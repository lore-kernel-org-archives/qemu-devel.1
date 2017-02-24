Received: from eggs.gnu.org ([2001:4830:134:3::10]:57482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chNqm-0006Fc-G8
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chNqj-00049J-Dw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chNqj-00048t-4q
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:56:25 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1122D83F38
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 21:56:25 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eeb7954d-95f9-3db2-edd3-3d953903bcfb@redhat.com>
Date: Fri, 24 Feb 2017 15:56:22 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lid0ICxdiRL7P5SDxenJhj6mV9ed17h9H"
Subject: Re: [Qemu-devel] [PATCH 05/21] qmp: Clean up how we enforce
 capability negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lid0ICxdiRL7P5SDxenJhj6mV9ed17h9H
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <eeb7954d-95f9-3db2-edd3-3d953903bcfb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/21] qmp: Clean up how we enforce
 capability negotiation
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> To enforce capability negotiation before normal operation,
> handle_qmp_command() inspects every command before it's handed off to
> qmp_dispatch().  This is a bit of a layering violation, and results in
> duplicated code.
>=20
> Before capability negotiation (!cur_mon->in_command_mode), we fail
> commands other than "qmp_capabilities".  This is what enforces
> capability negotiation.
>=20
> Afterwards, we fail command "qmp_capabilities".
>=20
> Clean this up as follows.
>=20
> The obvious place to fail a command is the command itself, so move the
> "afterwards" check to qmp_qmp_capabilities().
>=20
> We do the "before" check in every other command, but that would be
> bothersome.  Instead, start without all the other commands, by
> registering only qmp_qmp_capabilities().  Register the others in
> qmp_qmp_capabilities().
>=20
> Additionally, replace the generic human-readable error message for
> CommandNotFound by one that reminds the user to run qmp_capabilities.
> Without that, we'd regress commit 2d5a834.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor.c | 70 ++++++++++++++++++++++++++++++++++++-------------------=
--------
>  1 file changed, 40 insertions(+), 30 deletions(-)
>=20

> @@ -3781,12 +3782,21 @@ static void handle_qmp_command(JSONMessageParse=
r *parser, GQueue *tokens)
>      cmd_name =3D qdict_get_str(qdict, "execute");
>      trace_handle_qmp_command(mon, cmd_name);
> =20
> -    if (invalid_qmp_mode(mon, cmd_name, &err)) {
> -        goto err_out;
> -    }
> -
>      rsp =3D qmp_dispatch(req);
> =20
> +    qdict =3D qdict_get_qdict(qobject_to_qdict(rsp), "error");
> +    if (qdict) {
> +        if (!mon->qmp.in_command_mode
> +            && !strcmp(qdict_get_try_str(qdict, "class"),

Ouch - this can call strcmp(NULL, ...) if the error is ill-formed.  Is
that a problem?  Can we assert that "class" will always exist as a string=
?

> +                       QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_F=
OUND])) {
> +            /* Provide a more useful error message */
> +            qdict_del(qdict, "desc");
> +            qdict_put(qdict, "desc",
> +                      qstring_from_str("Expecting capabilities negotia=
tion"
> +                                       " with 'qmp_capabilities'"));
> +        }
> +    }
> +

Otherwise, I like it.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Lid0ICxdiRL7P5SDxenJhj6mV9ed17h9H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsKwGAAoJEKeha0olJ0NqwOYH/3/Hqt/VUMo3S8PKstwSzeH9
5S+TQEadlK2s7IBLFy8y3jIoNGVJdYssfIc1/3oYrpVVpzon7gFiFUIzjPYMDdDW
evhZiTO3v3ivV0F7WW/Ts1qe1K2FKyRHuvNlOhgrTKaSL3UJVrxOtFXtUjgltW06
/+I4r5OAO/V1IKA/hqwO6/SFNR7wanLQc+suNSHOFO+4z3rv4OA2IEU9IxmhIMAX
YhNACp46BRqGVaKTjW2K/xpv23Tt2Q/rINhCHXGWnQjbtCcjAMFntDV/75vnYrVe
DjX2FnUs868NGte8McMhKb2XlQY+/mwIXffRoskF1rD2WtoFta3/Z4lmZ+oSHuU=
=wWRv
-----END PGP SIGNATURE-----

--Lid0ICxdiRL7P5SDxenJhj6mV9ed17h9H--
