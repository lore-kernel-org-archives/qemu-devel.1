Received: from eggs.gnu.org ([2001:4830:134:3::10]:52231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdjQk-0001By-MR
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdjQh-0007tP-CC
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:10:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdjQh-0007t5-33
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:10:27 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82C38155E4
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 20:10:26 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99dd0998-5e15-888f-301c-141c931b10a8@redhat.com>
Date: Tue, 14 Feb 2017 14:10:17 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uSDMIWsi0Dr8V4hp9SttnTjqoMJhdT5Fr"
Subject: Re: [Qemu-devel] [PATCH 02/24] QemuOpts: Assert value string isn't
 null
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
--uSDMIWsi0Dr8V4hp9SttnTjqoMJhdT5Fr
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <99dd0998-5e15-888f-301c-141c931b10a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/24] QemuOpts: Assert value string isn't
 null
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Plenty of code relies on QemuOpt member @str not being null, including
> qemu_opts_print(), qemu_opts_to_qdict(), and callbacks passed to
> qemu_opt_foreach().
>=20

>=20
> Assert member @str isn't null, so that misuse is caught right away.
>=20
> Simplify parse_option_bool(), parse_option_number() and
> parse_option_size() accordingly.  Best viewed with whitespace changes
> ignored.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/qemu-option.c | 89 ++++++++++++++++++++++++----------------------=
--------
>  1 file changed, 39 insertions(+), 50 deletions(-)
>=20

> @@ -180,39 +172,35 @@ void parse_option_size(const char *name, const ch=
ar *value,
>      char *postfix;
>      double sizef;
> =20

> +    sizef =3D strtod(value, &postfix);
> +    if (sizef < 0 || sizef > UINT64_MAX) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
> +                   "a non-negative number below 2^64");
> +        return;
> +    }
> +    switch (*postfix) {
> +    case 'T':
=2E..
> +    default:
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a size")=
;
> +        error_append_hint(errp, "You may use k, M, G or T suffixes for=
 "
> +                          "kilobytes, megabytes, gigabytes and terabyt=
es.\n");
> +        return;
>      }

Unrelated to this patch, but noticing it now: it looks like we blindly
accept "qemu-system-x86_64 -nodefaults -m 1Mgarbage" as meaning the same
as "... -m 1M".  Looking back at 1/24, looks like you marked that as one
of the buggy cases.  Good - I guess I'll get to comment more on it in a
later patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--uSDMIWsi0Dr8V4hp9SttnTjqoMJhdT5Fr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo2QpAAoJEKeha0olJ0NqzuMIAJrZjHHc1J97qCA1Vl6P8r8o
7D2Xao5bflp+cLHahrtg1gRh/c9J95Vt+UQKJiYRMuznzgNh8b3qjt4EEORq3LR6
2HiuHWzTMNa85MiAao719VJiDS3F/dndZq5Uc3cepe9rqGs4zLMar7Q7s8qqzKYZ
M/3vt96DXKe7HVqKw3S39AJ1mvJdTreT87PV4xcetsVV38bgzC0ne7d51kRo9v7T
ttgYb1xXMj2U2FF+17DKZ8ulTymaIlI4A6awdYzxf8NdgmzaflXmN510AEeBcNgN
k2zWAIZDHm0aiKefS5Xge6yi8nFOnyN6/JHkjVVhq6eH+4Vo4SJIwoKfk84m+/U=
=H+Gb
-----END PGP SIGNATURE-----

--uSDMIWsi0Dr8V4hp9SttnTjqoMJhdT5Fr--
