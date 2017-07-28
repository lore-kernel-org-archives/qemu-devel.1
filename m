Received: from eggs.gnu.org ([2001:4830:134:3::10]:58187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db1ND-0002os-U4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db1N9-0003PC-OB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:15:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1db1N9-0003OU-FB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:15:51 -0400
Date: Fri, 28 Jul 2017 10:15:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170728091541.GA9972@stefanha-x1.localdomain>
References: <20170725143923.11241-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20170725143923.11241-1-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] monitor: improve tracing in
 handle_qmp_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 05:39:23PM +0300, Denis V. Lunev wrote:
> Calculate req_json only if trace_handle_qmp_command enabled.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> ---
> Changes from v1:
> - written in the explicit for, as discussed in the mailing list
>=20
>  monitor.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index d8ac20f6ca..2bfeb9bbcc 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3822,7 +3822,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>      QDict *qdict =3D NULL;
>      Monitor *mon =3D cur_mon;
>      Error *err =3D NULL;
> -    QString *req_json;
> =20
>      req =3D json_parser_parse_err(tokens, NULL, &err);
>      if (!req && !err) {
> @@ -3840,9 +3839,11 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>          qdict_del(qdict, "id");
>      } /* else will fail qmp_dispatch() */
> =20
> -    req_json =3D qobject_to_json(req);
> -    trace_handle_qmp_command(mon, qstring_get_str(req_json));
> -    qobject_decref(QOBJECT(req_json));
> +    if (trace_event_get_state(TRACE_HANDLE_QMP_COMMAND)) {
> +        QString *req_json =3D qobject_to_json(req);
> +        trace_handle_qmp_command(mon, qstring_get_str(req_json));
> +        qobject_decref(QOBJECT(req_json));
> +    }
> =20
>      rsp =3D qmp_dispatch(cur_mon->qmp.commands, req);

Thanks for the patch.  Another fix is needed first so that SystemTap and
LTTng UST users can use this trace event.  Currently
trace_event_get_state(TRACE_HANDLE_QMP_COMMAND) will return false
because SystemTap and LTTng UST maintain their own state.  I have CCed
you on the fix.

Stefan

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZewC9AAoJEJykq7OBq3PIZpIH+wabPEIH/ZybsvyFUdu5/xGi
YTNXs6Q1TU2dwg1+pOy1uavAI60DNjtIZMd2AtA6gKKmhWNcpKJl+NIf4t5S1Gba
UZ78TYbl4TJElLdY0+5E6au/4NNeem7rS4guB/fx6MvNZHGcHSQO3I8KVdP07IRQ
HOprfIBo3gguJg2xd4SPWZHWPJ2lSCbfkErn6SfF/4MU9nWqIqwewLqPZQ8kf8h7
oo7za9WIIVhU+ubF066Iz9JxJjy6JA0gwkjKCTuafl66n8LfkC5msQ1Yfij8tRWl
9spqRxjM5kpqnqs7YKoJuwjfBgqP/52uYglDO6iQRdfg/fAH/lRG+DTg3oOjBAY=
=ouKz
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
