Received: from eggs.gnu.org ([2001:4830:134:3::10]:37865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYNj-0008Mh-OL
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYNa-00068I-5w
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:03:35 -0500
References: <20180130150435.2553-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b93f21cf-5cd4-a6d0-7005-e19a3de211c8@redhat.com>
Date: Tue, 30 Jan 2018 10:03:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180130150435.2553-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YOUkxlJD3WwbYglkSRlZ1Qhlw9LPYpHSu"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Replace align_offset() with
 ROUND_UP()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YOUkxlJD3WwbYglkSRlZ1Qhlw9LPYpHSu
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <b93f21cf-5cd4-a6d0-7005-e19a3de211c8@redhat.com>
Subject: Re: [PATCH] qcow2: Replace align_offset() with ROUND_UP()
References: <20180130150435.2553-1-berto@igalia.com>
In-Reply-To: <20180130150435.2553-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 09:04 AM, Alberto Garcia wrote:
> The align_offset() function is equivalent to the ROUND_UP() macro so
> there's no need to use the former. The ROUND_UP() name is also a bit
> more explicit.
>=20
> This patch uses ROUND_UP() instead of the slower QEMU_ALIGN_UP()
> because align_offset() already requires that the second parameter is a
> power of two.

(Presumably, for the cases where the second argument is a compile-time
constant, the compiler emits the same code for either macro - but I
agree that QEMU_ALIGN_UP can be slower where the compiler can't see it
is a power of 2)

>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> +++ b/block/qcow2-bitmap.c
> @@ -413,7 +413,7 @@ static inline void bitmap_dir_entry_to_be(Qcow2Bitm=
apDirEntry *entry)
> =20
>  static inline int calc_dir_entry_size(size_t name_size, size_t extra_d=
ata_size)
>  {
> -    return align_offset(sizeof(Qcow2BitmapDirEntry) +
> +    return ROUND_UP(sizeof(Qcow2BitmapDirEntry) +
>                          name_size + extra_data_size, 8);

Indentation alignment is now off.


> +++ b/block/qcow2.c

> @@ -3681,7 +3681,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *=
opts, BlockDriverState *in_bs,
>      has_backing_file =3D !!optstr;
>      g_free(optstr);
> =20
> -    virtual_size =3D align_offset(qemu_opt_get_size_del(opts, BLOCK_OP=
T_SIZE, 0),
> +    virtual_size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SI=
ZE, 0),
>                                  cluster_size);

and again.

With the whitespace fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--YOUkxlJD3WwbYglkSRlZ1Qhlw9LPYpHSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwl0QACgkQp6FrSiUn
Q2rRngf/fecozonmtENGCSUbqMD3HQcy+le/i0datshZbtx7m815xRiVq21QgRRI
9/o7nIyqa/TQZo5VeKLqgRepenWiUqdilLq0nTxmq4IW5KQM/lnJlVa49N/0+XjJ
9qzzsqrVwnNo2e2Kz7C9h8HPvKsbvMrTTQuhOtGOHeZlEQp0k2m0HXDG/9EhfdUJ
/5ovZrz742WggrPA241jw29yqiZQIOve3k5SMghfEeon7ZpYCWZipRfsMilTh03e
YL9P0GkIk/LqdsngTsCqKLw6kOR3A6uCOFHPkp0xB2DSLoHEG7lVD4AMWNxiyelM
GtkduHQDdfLsykvyukAs1bebrrQDXA==
=OAcO
-----END PGP SIGNATURE-----

--YOUkxlJD3WwbYglkSRlZ1Qhlw9LPYpHSu--
