Received: from eggs.gnu.org ([2001:4830:134:3::10]:35839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX7Gs-0003LL-6r
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX7Go-0008Cs-1a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:45:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX7Gn-0008Bs-Nl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8333C058EB6
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 14:45:08 +0000 (UTC)
References: <20170714203313.31041-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68543d33-8f49-5948-dc4c-fc678ac6aee7@redhat.com>
Date: Mon, 17 Jul 2017 09:45:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170714203313.31041-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="35kcXOOADna1UxNVgq4DqTigkI8BlCA3b"
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix error handling code on alternate
 conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--35kcXOOADna1UxNVgq4DqTigkI8BlCA3b
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <68543d33-8f49-5948-dc4c-fc678ac6aee7@redhat.com>
Subject: Re: [PATCH] qapi: Fix error handling code on alternate conflict
References: <20170714203313.31041-1-ehabkost@redhat.com>
In-Reply-To: <20170714203313.31041-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 03:33 PM, Eduardo Habkost wrote:
> The conflict check added by commit c0644771 ("qapi: Reject
> alternates that can't work with keyval_parse()") doesn't work
> with the following declaration:
>=20
>   { 'alternate': 'Alt',
>     'data': { 'one': 'bool',
>               'two': 'str' } }
>=20
> It crashes with:
>=20
>   Traceback (most recent call last):
>     File "./scripts/qapi-types.py", line 295, in <module>
>       schema =3D QAPISchema(input_file)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 1468,=
 in __init__
>       self.exprs =3D check_exprs(parser.exprs)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 958, =
in check_exprs
>       check_alternate(expr, info)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 830, =
in check_alternate
>       % (name, key, types_seen[qtype]))
>   KeyError: 'QTYPE_QSTRING'
>=20
> This happens because the previously-seen conflicting member
> ('one') can't be found at types_seen[qtype], but at
> types_seen['QTYPE_BOOL'].
>=20
> Fix the bug by moving the error check to the same loop that adds
> new items to types_seen, raising an exception if types_seen[qt]
> is already set.
>=20
> Add two additional test cases that can detect the bug.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

> +++ b/tests/qapi-schema/alternate-conflict-bool-string.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/alternate-conflict-bool-string.json:3: Alternate 'Al=
t' member 'two' can't be distinguished from member 'one'

Claims the error is at line 3,

> +++ b/tests/qapi-schema/alternate-conflict-bool-string.json
> @@ -0,0 +1,4 @@
> +# alternate branches of 'str' type conflict with all scalar types
> +{ 'alternate': 'Alt',

but the declaration starts at line 2.  That's probably why patchew
complained that your patch doesn't build.  The idea looks sane, though;
looking forward to v2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--35kcXOOADna1UxNVgq4DqTigkI8BlCA3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllszW0ACgkQp6FrSiUn
Q2oZgQf/W+vtec5PFoNwniyDIxiKkXfxQa8jHQVFYt19g0iTnhxWufl1SwDdDHJf
i/6v1n7bnM7l48ceICN5EqPiKEJY1np0qsCCXBIdRBuaMYxPuY+jVpX0IBz3eeTs
KUZmHvLnAYDar+G4rkKhF6n7FLWRx4+4qcPqCt3TIFcIGpIOt1GeeTJl+jCpr1D+
adUwVv6yJZdsJxeizbTDdPwk7AhApDf+Jbz+5YCU4vj7GaTHlzGQoKkkG+20ji7E
VloBfloM/yhiT4UBeeFq71iFrCy6ukX6X6mzzI98zbwMISknIyDJQT6ltWz38fy1
puCt1TyC1m8gtSi4feLsKvwtQuC+bg==
=zJPu
-----END PGP SIGNATURE-----

--35kcXOOADna1UxNVgq4DqTigkI8BlCA3b--
