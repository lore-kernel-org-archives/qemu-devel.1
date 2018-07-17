Received: from eggs.gnu.org ([2001:4830:134:3::10]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffRr2-00030r-Tl
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffRqx-0003Jx-Uv
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:25:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffRqx-0003IW-MA
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:25:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-12-marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 17:25:21 +0200
In-Reply-To: <20180706121354.2021-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:53 +0200")
Message-ID: <87y3e9c2am.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/12] qga: process_event() simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Copying the maintainer Michael Roth.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Simplify the code around qmp_dispatch():
> - rely on qmp_dispatch/check_obj() for message checking
> - have a single send_response() point
> - constify send_response() argument
> - rsp/req variable renaming for clarity
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/main.c | 58 ++++++++++++++----------------------------------------
>  1 file changed, 15 insertions(+), 43 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 0784761605..b0a88ee5cf 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -545,15 +545,15 @@ fail:
>  #endif
>  }
>=20=20
> -static int send_response(GAState *s, QDict *payload)
> +static int send_response(GAState *s, const QDict *rsp)
>  {
>      const char *buf;
>      QString *payload_qstr, *response_qstr;
>      GIOStatus status;
>=20=20
> -    g_assert(payload && s->channel);
> +    g_assert(rsp && s->channel);
>=20=20
> -    payload_qstr =3D qobject_to_json(QOBJECT(payload));
> +    payload_qstr =3D qobject_to_json(QOBJECT(rsp));
>      if (!payload_qstr) {
>          return -EINVAL;
>      }
> @@ -579,63 +579,35 @@ static int send_response(GAState *s, QDict *payload)
>      return 0;
>  }
>=20=20
> -static void process_command(GAState *s, QDict *req)
> -{
> -    QDict *rsp;
> -    int ret;
> -
> -    g_assert(req);
> -    g_debug("processing command");
> -    rsp =3D qmp_dispatch(&ga_commands, QOBJECT(req), false);
> -    if (rsp) {
> -        ret =3D send_response(s, rsp);
> -        if (ret < 0) {
> -            g_warning("error sending response: %s", strerror(-ret));
> -        }
> -        qobject_unref(rsp);
> -    }
> -}
> -
>  /* handle requests/control events coming in over the channel */
>  static void process_event(JSONMessageParser *parser, GQueue *tokens)
>  {
>      GAState *s =3D container_of(parser, GAState, parser);
> -    QObject *obj;
> -    QDict *qdict;
> +    QObject *req;
> +    QDict *rsp =3D NULL;
>      Error *err =3D NULL;
>      int ret;
>=20=20
>      g_assert(s && parser);
>=20=20
>      g_debug("process_event: called");
> -    obj =3D json_parser_parse_err(tokens, NULL, &err);
> +
> +    req =3D json_parser_parse_err(tokens, NULL, &err);
>      if (err) {
> -        goto err;
> -    }
> -    qdict =3D qobject_to(QDict, obj);
> -    if (!qdict) {
> -        error_setg(&err, QERR_JSON_PARSING);
> -        goto err;
> -    }
> -    if (!qdict_haskey(qdict, "execute")) {
> -        g_warning("unrecognized payload format");
> -        error_setg(&err, QERR_UNSUPPORTED);
> -        goto err;
> +        rsp =3D qmp_error_response(err);
> +        goto end;
>      }
>=20=20
> -    process_command(s, qdict);
> -    qobject_unref(obj);
> -    return;
> +    g_debug("processing command");
> +    rsp =3D qmp_dispatch(&ga_commands, req, false);
>=20=20
> -err:
> -    g_warning("failed to parse event: %s", error_get_pretty(err));
> -    qdict =3D qmp_error_response(err);
> -    ret =3D send_response(s, qdict);
> +end:
> +    ret =3D send_response(s, rsp);
>      if (ret < 0) {
>          g_warning("error sending error response: %s", strerror(-ret));
>      }
> -    qobject_unref(qdict);
> -    qobject_unref(obj);
> +    qobject_unref(rsp);
> +    qobject_unref(req);
>  }
>=20=20
>  /* false return signals GAChannel to close the current client connection=
 */

Nice.  It changes a couple of error messages:

* When @req isn't a dictionary, from

    Invalid JSON syntax

  to

    QMP input must be a JSON object

* When @req lacks member "execute", from

    this feature or command is not currently supported

  to

    QMP input lacks member 'execute'

Improvement, except the QMP part is a bit odd.

Let's mention the error message improvments in the commit message.
