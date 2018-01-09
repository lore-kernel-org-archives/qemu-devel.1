Received: from eggs.gnu.org ([2001:4830:134:3::10]:37420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYuaH-00039S-3H
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYuaB-0006IG-4M
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:08:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYuaA-0006HM-RD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:08:51 -0500
Date: Tue, 9 Jan 2018 14:08:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109140810.GF31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-22-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-22-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 21/27] qmp: support out-of-band (oob)
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:51PM +0800, Peter Xu wrote:
> diff --git a/monitor.c b/monitor.c
> index b571866659..505db439d8 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1090,6 +1090,44 @@ static void qmp_caps_apply(Monitor *mon, QMPCapabi=
lityList *list)
>      }
>  }
> =20
> +/*
> + * Return true if check successful, or false otherwise.  When false is
> + * returned, detailed error will be in errp if provided.
> + */
> +static bool qmp_cmd_oob_check(Monitor *mon, QDict *req, Error **errp)
> +{
> +    const char *command;
> +    QmpCommand *cmd;
> +
> +    command =3D qdict_get_try_str(req, "execute");
> +    if (!command) {
> +        error_setg(errp, "Command field 'execute' missing");
> +        return false;
> +    }
> +
> +    cmd =3D qmp_find_command(mon->qmp.commands, command);
> +    if (!cmd) {
> +        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> +                  "The command %s has not been found", command);
> +        return false;
> +    }
> +
> +    if (qmp_is_oob(req)) {
> +        if (!qmp_oob_enabled(mon)) {
> +            error_setg(errp, "Please enable Out-Of-Band first "
> +                       "for the session during handshake");

The qmp-spec.txt document calls it "capabilities negotiation".  I don't
see "handshake" mentioned.  Please use the terminology from the QMP spec
so it's clear what this error message means.

> +            return false;
> +        }
> +        if (!(cmd->options & QCO_ALLOW_OOB)) {
> +            error_setg(errp, "The command %s does not support OOB",
> +                       command);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
>                            Error **errp)
>  {
> @@ -4032,6 +4070,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      QMPRequest *req_obj =3D monitor_qmp_requests_pop_one();
> =20
>      if (req_obj) {
> +        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id));

Not all tracers on all platforms support NULL string pointers.  Please
use qobject_get_try_str(req_obj->id) ?: "".

>          monitor_qmp_dispatch_one(req_obj);
>          /* Reschedule instead of looping so the main loop stays responsi=
ve */
>          qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> @@ -4055,17 +4094,31 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
>          error_setg(&err, QERR_JSON_PARSING);
>      }
>      if (err) {
> -        monitor_qmp_respond(mon, NULL, err, NULL);
> -        qobject_decref(req);
> -        return;
> +        goto err;
> +    }
> +
> +    /* Check against the request in general layout */
> +    qdict =3D qmp_dispatch_check_obj(req, &err);
> +    if (!qdict) {
> +        goto err;
>      }
> =20
> -    qdict =3D qobject_to_qdict(req);
> -    if (qdict) {
> -        id =3D qdict_get(qdict, "id");
> -        qobject_incref(id);
> -        qdict_del(qdict, "id");
> -    } /* else will fail qmp_dispatch() */
> +    /* Check against OOB specific */
> +    if (!qmp_cmd_oob_check(mon, qdict, &err)) {
> +        goto err;
> +    }
> +
> +    id =3D qdict_get(qdict, "id");
> +
> +    /* When OOB is enabled, the "id" field is mandatory. */
> +    if (qmp_oob_enabled(mon) && !id) {
> +        error_setg(&err, "Out-Of-Band capability requires that "
> +                   "every command contains an 'id' field.");

error_setg() messages shouldn't end with a period ('.').

> +        goto err;
> +    }
> +
> +    qobject_incref(id);
> +    qdict_del(qdict, "id");
> =20
>      req_obj =3D g_new0(QMPRequest, 1);
>      req_obj->mon =3D mon;
> @@ -4073,6 +4126,13 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>      req_obj->req =3D req;
>      req_obj->need_resume =3D false;
> =20
> +    if (qmp_is_oob(qdict)) {
> +        /* Out-Of-Band (OOB) requests are executed directly in parser. */
> +        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->i=
d));

Same NULL "%s" issue here.

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVMzKAAoJEJykq7OBq3PIWVkH/jyZHH0MMBrhEU61lIoDuU3i
LUxNNPXd6oCnFeru6OjI8cIAPnqhnwno3f9IWRj5SG3VwtEWBm4mMcfJDyK5C1Ol
++2g03h8YEuxSB0FcHkFawHWthMEFTRZtDT9SjI5JRPljjLFkTR5AORVdL+hrtRa
AMuYJWmD6CgWghZqtfx+j63iE9GzfowBvpaEhe3PvEybsNPNT2NOyDoqvoOGx+Hi
9xkNbWpfE1G8hGw3STmf+UDp3y1H6Dk/JgasmE8dSEWa5v5gh0MXBgSk8ZVPJw6x
pbTzSuD2EEdi9xcb6n74e51/t2ZnwyEciQzt4W7JfXcZ6nAZrWeOEptZk41Dgo0=
=kdsY
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
