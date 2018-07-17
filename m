Received: from eggs.gnu.org ([2001:4830:134:3::10]:43304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffIvo-0005FV-SR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 01:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffIvk-0005TJ-0G
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 01:53:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffIvj-0005T5-QW
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 01:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E18B400225D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 05:53:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-7-marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 07:53:45 +0200
In-Reply-To: <20180706121354.2021-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:48 +0200")
Message-ID: <87pnzmh0gm.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> json_parser_parse_err() may return something else than a QDict, in
> which case we loose the object. Let's keep track of the original
> object to avoid leaks.

Should this leak fix go into 3.0?

> When an error occurs, "qdict" contains the response, but we still
> check the "execute" key there.

Harmless.

>                                Untangle a bit this code, by having a
> clear error path.

Untangling might make sense anyway.  Let's see.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/main.c | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 537cc0e162..0784761605 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -600,6 +600,7 @@ static void process_command(GAState *s, QDict *req)
>  static void process_event(JSONMessageParser *parser, GQueue *tokens)
>  {
>      GAState *s =3D container_of(parser, GAState, parser);
> +    QObject *obj;
>      QDict *qdict;
>      Error *err =3D NULL;
>      int ret;
> @@ -607,35 +608,34 @@ static void process_event(JSONMessageParser *parser=
, GQueue *tokens)
>      g_assert(s && parser);
>=20=20
>      g_debug("process_event: called");
> -    qdict =3D qobject_to(QDict, json_parser_parse_err(tokens, NULL, &err=
));
> -    if (err || !qdict) {
> -        qobject_unref(qdict);
> -        if (!err) {
> -            g_warning("failed to parse event: unknown error");
> -            error_setg(&err, QERR_JSON_PARSING);
> -        } else {
> -            g_warning("failed to parse event: %s", error_get_pretty(err)=
);
> -        }
> -        qdict =3D qmp_error_response(err);
> +    obj =3D json_parser_parse_err(tokens, NULL, &err);
> +    if (err) {
> +        goto err;
>      }
> -
> -    /* handle host->guest commands */
> -    if (qdict_haskey(qdict, "execute")) {
> -        process_command(s, qdict);
> -    } else {
> -        if (!qdict_haskey(qdict, "error")) {
> -            qobject_unref(qdict);
> -            g_warning("unrecognized payload format");
> -            error_setg(&err, QERR_UNSUPPORTED);
> -            qdict =3D qmp_error_response(err);
> -        }
> -        ret =3D send_response(s, qdict);
> -        if (ret < 0) {
> -            g_warning("error sending error response: %s", strerror(-ret)=
);
> -        }
> +    qdict =3D qobject_to(QDict, obj);
> +    if (!qdict) {
> +        error_setg(&err, QERR_JSON_PARSING);
> +        goto err;
> +    }
> +    if (!qdict_haskey(qdict, "execute")) {
> +        g_warning("unrecognized payload format");
> +        error_setg(&err, QERR_UNSUPPORTED);
> +        goto err;
>      }
>=20=20
> +    process_command(s, qdict);
> +    qobject_unref(obj);
> +    return;
> +
> +err:
> +    g_warning("failed to parse event: %s", error_get_pretty(err));
> +    qdict =3D qmp_error_response(err);
> +    ret =3D send_response(s, qdict);
> +    if (ret < 0) {
> +        g_warning("error sending error response: %s", strerror(-ret));
> +    }
>      qobject_unref(qdict);
> +    qobject_unref(obj);
>  }
>=20=20
>  /* false return signals GAChannel to close the current client connection=
 */

Control flow is much improved.  Took me a minute to convince myself the
reference counting is okay: qdict is a weak reference before qdict =3D
qmp_error_response(), and becomes strong there.  Suggest to use a new
variable @err_rsp for the latter purpose.

Regardless:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
