Received: from eggs.gnu.org ([2001:4830:134:3::10]:36882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMab9-00017c-00
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMab5-0006Wf-1a
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:22:54 -0500
References: <20171206115726.5237-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <171741b3-39b8-7c37-8e07-4a9dd590e4c9@redhat.com>
Date: Wed, 6 Dec 2017 08:22:35 -0600
MIME-Version: 1.0
In-Reply-To: <20171206115726.5237-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1lrSMphVM6BRH0WFwxTkQcX5fvKNaIaFS"
Subject: Re: [Qemu-devel] [PATCH] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1lrSMphVM6BRH0WFwxTkQcX5fvKNaIaFS
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <171741b3-39b8-7c37-8e07-4a9dd590e4c9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-io: fix EOF Ctrl-D handling in qemu-io
 readline code
References: <20171206115726.5237-1-berrange@redhat.com>
In-Reply-To: <20171206115726.5237-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 05:57 AM, Daniel P. Berrange wrote:
> qemu-io puts the TTY into non-canonical mode, which means no EOF proces=
sing is
> done and thus getchar() will never return the EOF constant. Instead we =
have to
> check for an explicit Ctrl-D, aka  0x4, to detect EOF and exit the qemu=
-io
> shell. This fixes the regression that prevented Ctrl-D from triggering =
an exit
> of qemu-io that has existed since readline was first added in
>=20
>   commit 0cf17e181798063c3824c8200ba46f25f54faa1a
>   Author: Stefan Hajnoczi <stefanha@redhat.com>
>   Date:   Thu Nov 14 11:54:17 2013 +0100
>=20
>     qemu-io: use readline.c
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-io.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

>      while (!line) {
>          int ch =3D getchar();
> -        if (ch =3D=3D EOF) {
> +        /* In non-canon tty mode we get 0x4 (Ctrl-D), not the stdio "E=
OF"
> +         * constant */
> +        if (ch =3D=3D 0x4) {

Should we instead be looking for a match against the current termios()
c_cc[VEOF] setting, in case the user prefers something other than ^D via
stty?  Does readline provide any functionality for automating this?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1lrSMphVM6BRH0WFwxTkQcX5fvKNaIaFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlon/SsACgkQp6FrSiUn
Q2ofHwgAgXeIQVCDtLwlourfGiOUJ+tZPugejrfZMafX5m5LHWERCmc8xX1EWpwm
YG753TgeEdSdbeNgXcgORpjRZNRXL6xXO+aIN/art0L1GDxQTnitOcnzhyrgG/NV
6SIp4/eP+paF6O5zRj4X+bWifxNm+iD9SmckR8asdFhmFJAXwT0K678w+ekVbOZN
mPBs35//tR8jdIO4hemc+8+iI7+oBQmDj2AS4k2Ole+sBjNIVCRwUxitL6zeYMwq
ddrt1luW14vD+R/sl6tttWkd7KJcOl4FsUapeimoD5pQKDCCcaEL1rGaoCWgP6Gg
jdn8EhuSuZ+qBDpafQL0e4FeKRskpQ==
=PlVv
-----END PGP SIGNATURE-----

--1lrSMphVM6BRH0WFwxTkQcX5fvKNaIaFS--
