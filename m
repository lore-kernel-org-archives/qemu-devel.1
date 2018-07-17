Received: from eggs.gnu.org ([2001:4830:134:3::10]:48764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ffMGr-0007xB-8o
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ffMGq-0000k5-6t
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:27:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ffMGp-0000id-Vx
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:27:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id b15-v6so504810wrv.10
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 02:27:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87pnzmh0gm.fsf@dusky.pond.sub.org>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-7-marcandre.lureau@redhat.com>
	<87pnzmh0gm.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Jul 2018 11:27:45 +0200
Message-ID: <CAJ+F1CJa+41o+2r2mb+9zGKx5QFVHMFry0Es=KHVeAL=-itqUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] qga: process_event() simplification
 and leak fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Hi

On Tue, Jul 17, 2018 at 7:53 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> json_parser_parse_err() may return something else than a QDict, in
>> which case we loose the object. Let's keep track of the original
>> object to avoid leaks.
>
> Should this leak fix go into 3.0?

It has been there for a while, but it could be fixed for 3.0 indeed.

>
>> When an error occurs, "qdict" contains the response, but we still
>> check the "execute" key there.
>
> Harmless.
>
>>                                Untangle a bit this code, by having a
>> clear error path.
>
> Untangling might make sense anyway.  Let's see.
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qga/main.c | 50 +++++++++++++++++++++++++-------------------------
>>  1 file changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/qga/main.c b/qga/main.c
>> index 537cc0e162..0784761605 100644
>> --- a/qga/main.c
>> +++ b/qga/main.c
>> @@ -600,6 +600,7 @@ static void process_command(GAState *s, QDict *req)
>>  static void process_event(JSONMessageParser *parser, GQueue *tokens)
>>  {
>>      GAState *s =3D container_of(parser, GAState, parser);
>> +    QObject *obj;
>>      QDict *qdict;
>>      Error *err =3D NULL;
>>      int ret;
>> @@ -607,35 +608,34 @@ static void process_event(JSONMessageParser *parse=
r, GQueue *tokens)
>>      g_assert(s && parser);
>>
>>      g_debug("process_event: called");
>> -    qdict =3D qobject_to(QDict, json_parser_parse_err(tokens, NULL, &er=
r));
>> -    if (err || !qdict) {
>> -        qobject_unref(qdict);
>> -        if (!err) {
>> -            g_warning("failed to parse event: unknown error");
>> -            error_setg(&err, QERR_JSON_PARSING);
>> -        } else {
>> -            g_warning("failed to parse event: %s", error_get_pretty(err=
));
>> -        }
>> -        qdict =3D qmp_error_response(err);
>> +    obj =3D json_parser_parse_err(tokens, NULL, &err);
>> +    if (err) {
>> +        goto err;
>>      }
>> -
>> -    /* handle host->guest commands */
>> -    if (qdict_haskey(qdict, "execute")) {
>> -        process_command(s, qdict);
>> -    } else {
>> -        if (!qdict_haskey(qdict, "error")) {
>> -            qobject_unref(qdict);
>> -            g_warning("unrecognized payload format");
>> -            error_setg(&err, QERR_UNSUPPORTED);
>> -            qdict =3D qmp_error_response(err);
>> -        }
>> -        ret =3D send_response(s, qdict);
>> -        if (ret < 0) {
>> -            g_warning("error sending error response: %s", strerror(-ret=
));
>> -        }
>> +    qdict =3D qobject_to(QDict, obj);
>> +    if (!qdict) {
>> +        error_setg(&err, QERR_JSON_PARSING);
>> +        goto err;
>> +    }
>> +    if (!qdict_haskey(qdict, "execute")) {
>> +        g_warning("unrecognized payload format");
>> +        error_setg(&err, QERR_UNSUPPORTED);
>> +        goto err;
>>      }
>>
>> +    process_command(s, qdict);
>> +    qobject_unref(obj);
>> +    return;
>> +
>> +err:
>> +    g_warning("failed to parse event: %s", error_get_pretty(err));
>> +    qdict =3D qmp_error_response(err);
>> +    ret =3D send_response(s, qdict);
>> +    if (ret < 0) {
>> +        g_warning("error sending error response: %s", strerror(-ret));
>> +    }
>>      qobject_unref(qdict);
>> +    qobject_unref(obj);
>>  }
>>
>>  /* false return signals GAChannel to close the current client connectio=
n */
>
> Control flow is much improved.  Took me a minute to convince myself the
> reference counting is okay: qdict is a weak reference before qdict =3D
> qmp_error_response(), and becomes strong there.  Suggest to use a new
> variable @err_rsp for the latter purpose.

Yes, the code is further improved in patch 11.

>
> Regardless:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

thanks


--=20
Marc-Andr=C3=A9 Lureau
