Received: from eggs.gnu.org ([2001:4830:134:3::10]:37261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da14c-0004G0-UI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da14Z-0002Do-0j
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:44:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da14Y-0002DL-N5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:44:30 -0400
References: <20170725143923.11241-1-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1677208-c06d-168a-aeb9-f6fcedadfa0e@redhat.com>
Date: Tue, 25 Jul 2017 09:44:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170725143923.11241-1-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w1RNnd4oiFTIXp64qSbcUMJtDBjtfv3CC"
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
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w1RNnd4oiFTIXp64qSbcUMJtDBjtfv3CC
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <d1677208-c06d-168a-aeb9-f6fcedadfa0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] monitor: improve tracing in
 handle_qmp_command
References: <20170725143923.11241-1-den@openvz.org>
In-Reply-To: <20170725143923.11241-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 09:39 AM, Denis V. Lunev wrote:
> Calculate req_json only if trace_handle_qmp_command enabled.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> ---
> Changes from v1:
> - written in the explicit for, as discussed in the mailing list

I could live with this being considered a bug-fix for 2.10, as we
regressed in speed/memory usage during normal untraced QMP commands.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
>  monitor.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index d8ac20f6ca..2bfeb9bbcc 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3822,7 +3822,6 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
>      QDict *qdict =3D NULL;
>      Monitor *mon =3D cur_mon;
>      Error *err =3D NULL;
> -    QString *req_json;
> =20
>      req =3D json_parser_parse_err(tokens, NULL, &err);
>      if (!req && !err) {
> @@ -3840,9 +3839,11 @@ static void handle_qmp_command(JSONMessageParser=
 *parser, GQueue *tokens)
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
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--w1RNnd4oiFTIXp64qSbcUMJtDBjtfv3CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3WUkACgkQp6FrSiUn
Q2qucggAipYEkBX1NZyn51ZrtCes8QfIwDJAw5LWC2D+ptBDGL8tAZvDCz04TA6l
Gh3GCl0FAnOIS5x8WFrMRh76KJTBzcK7w2zq3KoTBc7Y9om3yEnBOMI4z7kVjPAd
fw507CeNYNDiQDQrjqlRC3EOzoNQcUhwoEh/nZgarMgdTULHEHaSO5YUX5noYGho
HAFkszZvhfdv+GA+s+ift9J3ZD6Z1dhdysu9l8sxVIuNcgIELjS5EtBQyL1+gBZJ
JLy1LIg1DLTLdN+0QHFdI+4F8mgySv9iWHi3HB1WxN+PSCOJ9nlaAIVT47sec955
ueZein2R6j6X6Z+QUfZ3t0uF5NJsDg==
=T8BQ
-----END PGP SIGNATURE-----

--w1RNnd4oiFTIXp64qSbcUMJtDBjtfv3CC--
