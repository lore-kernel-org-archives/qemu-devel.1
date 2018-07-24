Received: from eggs.gnu.org ([2001:4830:134:3::10]:60126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkrA-0002Ss-Dm
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkr9-0005Cp-Ab
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:12 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:36888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fhkr9-0005CX-5A
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:11 -0400
Received: by mail-oi0-x22e.google.com with SMTP id k81-v6so4391117oib.4
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 17:07:11 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180719184111.5129-7-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-7-marcandre.lureau@redhat.com>
Message-ID: <153239062938.10934.9895964660342498297@sif>
Date: Mon, 23 Jul 2018 19:03:49 -0500
Subject: Re: [Qemu-devel] [PATCH v2 06/18] qga: process_event()
 simplification and leak fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

Quoting Marc-Andr=C3=A9 Lureau (2018-07-19 13:40:59)
> json_parser_parse_err() may return something else than a QDict, in
> which case we loose the object. Let's keep track of the original
> object to avoid leaks.
> =

> When an error occurs, "qdict" contains the response, but we still
> check the "execute" key there. Untangle a bit this code, by having a
> clear error path.
> =

> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks, I've gone ahead and queued this one for 3.0/stable:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/main.c | 54 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> =

> diff --git a/qga/main.c b/qga/main.c
> index 537cc0e162..87372d40ef 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -600,42 +600,42 @@ static void process_command(GAState *s, QDict *req)
>  static void process_event(JSONMessageParser *parser, GQueue *tokens)
>  {
>      GAState *s =3D container_of(parser, GAState, parser);
> -    QDict *qdict;
> +    QObject *obj;
> +    QDict *req, *rsp;
>      Error *err =3D NULL;
>      int ret;
> =

>      g_assert(s && parser);
> =

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
> +    req =3D qobject_to(QDict, obj);
> +    if (!req) {
> +        error_setg(&err, QERR_JSON_PARSING);
> +        goto err;
> +    }
> +    if (!qdict_haskey(req, "execute")) {
> +        g_warning("unrecognized payload format");
> +        error_setg(&err, QERR_UNSUPPORTED);
> +        goto err;
>      }
> =

> -    qobject_unref(qdict);
> +    process_command(s, req);
> +    qobject_unref(obj);
> +    return;
> +
> +err:
> +    g_warning("failed to parse event: %s", error_get_pretty(err));
> +    rsp =3D qmp_error_response(err);
> +    ret =3D send_response(s, rsp);
> +    if (ret < 0) {
> +        g_warning("error sending error response: %s", strerror(-ret));
> +    }
> +    qobject_unref(rsp);
> +    qobject_unref(obj);
>  }
> =

>  /* false return signals GAChannel to close the current client connection=
 */
> -- =

> 2.18.0.129.ge3331758f1
>=20
