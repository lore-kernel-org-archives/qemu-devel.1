Received: from eggs.gnu.org ([2001:4830:134:3::10]:58430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffOrv-0005KJ-Kt
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffOru-0005tc-CO
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:14:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffOru-0005tG-6r
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:14:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-7-marcandre.lureau@redhat.com>
	<87pnzmh0gm.fsf@dusky.pond.sub.org>
	<CAJ+F1CJa+41o+2r2mb+9zGKx5QFVHMFry0Es=KHVeAL=-itqUA@mail.gmail.com>
Date: Tue, 17 Jul 2018 14:14:10 +0200
In-Reply-To: <CAJ+F1CJa+41o+2r2mb+9zGKx5QFVHMFry0Es=KHVeAL=-itqUA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 17 Jul 2018
	11:27:45 +0200")
Message-ID: <87k1pudppp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>

Mike, I got a bug fix for you to consider for 3.0.

Marc-Andr=C3=A9, there's one remark for you inline.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jul 17, 2018 at 7:53 AM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> json_parser_parse_err() may return something else than a QDict, in
>>> which case we loose the object. Let's keep track of the original
>>> object to avoid leaks.
>>
>> Should this leak fix go into 3.0?
>
> It has been there for a while, but it could be fixed for 3.0 indeed.
>
>>
>>> When an error occurs, "qdict" contains the response, but we still
>>> check the "execute" key there.
>>
>> Harmless.
>>
>>>                                Untangle a bit this code, by having a
>>> clear error path.
>>
>> Untangling might make sense anyway.  Let's see.
>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  qga/main.c | 50 +++++++++++++++++++++++++-------------------------
>>>  1 file changed, 25 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/qga/main.c b/qga/main.c
>>> index 537cc0e162..0784761605 100644
>>> --- a/qga/main.c
>>> +++ b/qga/main.c
>>> @@ -600,6 +600,7 @@ static void process_command(GAState *s, QDict *req)
>>>  static void process_event(JSONMessageParser *parser, GQueue *tokens)
>>>  {
>>>      GAState *s =3D container_of(parser, GAState, parser);
>>> +    QObject *obj;
>>>      QDict *qdict;
>>>      Error *err =3D NULL;
>>>      int ret;
>>> @@ -607,35 +608,34 @@ static void process_event(JSONMessageParser *pars=
er, GQueue *tokens)
>>>      g_assert(s && parser);
>>>
>>>      g_debug("process_event: called");
>>> -    qdict =3D qobject_to(QDict, json_parser_parse_err(tokens, NULL, &e=
rr));
>>> -    if (err || !qdict) {
>>> -        qobject_unref(qdict);
>>> -        if (!err) {
>>> -            g_warning("failed to parse event: unknown error");
>>> -            error_setg(&err, QERR_JSON_PARSING);
>>> -        } else {
>>> -            g_warning("failed to parse event: %s", error_get_pretty(er=
r));
>>> -        }
>>> -        qdict =3D qmp_error_response(err);
>>> +    obj =3D json_parser_parse_err(tokens, NULL, &err);
>>> +    if (err) {
>>> +        goto err;
>>>      }
>>> -
>>> -    /* handle host->guest commands */
>>> -    if (qdict_haskey(qdict, "execute")) {
>>> -        process_command(s, qdict);
>>> -    } else {
>>> -        if (!qdict_haskey(qdict, "error")) {
>>> -            qobject_unref(qdict);
>>> -            g_warning("unrecognized payload format");
>>> -            error_setg(&err, QERR_UNSUPPORTED);
>>> -            qdict =3D qmp_error_response(err);
>>> -        }
>>> -        ret =3D send_response(s, qdict);
>>> -        if (ret < 0) {
>>> -            g_warning("error sending error response: %s", strerror(-re=
t));
>>> -        }
>>> +    qdict =3D qobject_to(QDict, obj);
>>> +    if (!qdict) {
>>> +        error_setg(&err, QERR_JSON_PARSING);
>>> +        goto err;
>>> +    }
>>> +    if (!qdict_haskey(qdict, "execute")) {
>>> +        g_warning("unrecognized payload format");
>>> +        error_setg(&err, QERR_UNSUPPORTED);
>>> +        goto err;
>>>      }
>>>
>>> +    process_command(s, qdict);
>>> +    qobject_unref(obj);
>>> +    return;
>>> +
>>> +err:
>>> +    g_warning("failed to parse event: %s", error_get_pretty(err));
>>> +    qdict =3D qmp_error_response(err);
>>> +    ret =3D send_response(s, qdict);
>>> +    if (ret < 0) {
>>> +        g_warning("error sending error response: %s", strerror(-ret));
>>> +    }
>>>      qobject_unref(qdict);
>>> +    qobject_unref(obj);
>>>  }
>>>
>>>  /* false return signals GAChannel to close the current client connecti=
on */
>>
>> Control flow is much improved.  Took me a minute to convince myself the
>> reference counting is okay: qdict is a weak reference before qdict =3D
>> qmp_error_response(), and becomes strong there.  Suggest to use a new
>> variable @err_rsp for the latter purpose.
>
> Yes, the code is further improved in patch 11.

Looking... yes, it looks quite nice after PATCH 11.  Whether to make the
intermediate state after this patch a bit nicer just because we can is
Mike's call to make.

>> Regardless:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>
> thanks
