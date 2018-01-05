Received: from eggs.gnu.org ([2001:4830:134:3::10]:52597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXUTO-00083G-Nt
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXUTN-0005eC-N0
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:03:58 -0500
References: <20180105065538.13375-1-famz@redhat.com>
	<20180105065538.13375-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <969321e2-e1f6-513f-4caf-ff62ce6d1f26@redhat.com>
Date: Fri, 5 Jan 2018 10:03:44 -0600
MIME-Version: 1.0
In-Reply-To: <20180105065538.13375-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2F5E9UrHBYkTDv2u8pKa5ZMZa10f3BYZ9"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: Move img_open error
 reporting to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2F5E9UrHBYkTDv2u8pKa5ZMZa10f3BYZ9
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <969321e2-e1f6-513f-4caf-ff62ce6d1f26@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: Move img_open error reporting
 to callers
References: <20180105065538.13375-1-famz@redhat.com>
 <20180105065538.13375-2-famz@redhat.com>
In-Reply-To: <20180105065538.13375-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 12:55 AM, Fam Zheng wrote:
> In the next patch one caller will have a special error handling logic
> than reporting it, add "Error **" parameters to functions and give

s/than/rather than/
s/it, add/it.  Add/

> control back to callers, to make that possible.
>=20
> Update iotests output accordingly.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c                 | 115 +++++++++++++++++++++++++++----------=
--------
>  tests/qemu-iotests/043.out |   6 +--
>  2 files changed, 73 insertions(+), 48 deletions(-)
>=20

> @@ -2455,23 +2464,24 @@ static ImageInfoList *collect_image_info_list(b=
ool image_opts,
>          ImageInfoList *elem;
> =20
>          if (g_hash_table_lookup_extended(filenames, filename, NULL, NU=
LL)) {
> -            error_report("Backing file '%s' creates an infinite loop."=
,
> -                         filename);
> +            error_setg(errp,
> +                       "Backing file '%s' creates an infinite loop.",

error_setg() should not end in '.'; you can fix that while touching this.=
=2E.

> +++ b/tests/qemu-iotests/043.out
> @@ -2,19 +2,19 @@ QA output created by 043
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
> =20
>  =3D=3D backing file references self =3D=3D
> -qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
> +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Backing file 'TEST_DIR/t=
=2EIMGFMT' creates an infinite loop.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_=
file=3DTEST_DIR/t.IMGFMT.base
> =20
>  =3D=3D parent references self =3D=3D
> -qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
> +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Backing file 'TEST_DIR/t=
=2EIMGFMT' creates an infinite loop.

=2E..which is another tweak here.

Those tweaks are minor, so
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2F5E9UrHBYkTDv2u8pKa5ZMZa10f3BYZ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPoeAACgkQp6FrSiUn
Q2pMdgf6Azm9nNWozivRDBbNYoW9SYZS7x7UKV6xuNec9w80DhMOu6pQGWt/SiW2
gOc8OYDUwYqpzWNtLepYfUT3TLGpQuYBBrV23HrAc3Jc9oiaJh+PiUbedYSCl+/5
hmc78T6J4DeKLHV3+fey8hWmSrb9SsGE9Ki9yvtTmmSE3aduVKXHsC3J6oSQFbHg
fhVzRyLKdFp8vo44oqHN+Lt5THSwEpAg5PraDFcITeaJntFn1x/dj31RggM8FDOP
os9od8s94Tdz5uc94QezZ8HpElOfgdDNHy38IWjV6IS21mHgjTEtrzE7cPooIV3e
KR+WQgCrbE9lKx6lsocdZZepJQtcMg==
=gQwp
-----END PGP SIGNATURE-----

--2F5E9UrHBYkTDv2u8pKa5ZMZa10f3BYZ9--
