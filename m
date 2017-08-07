Received: from eggs.gnu.org ([2001:4830:134:3::10]:34801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1deg9M-0002bh-3X
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1deg9K-0004OP-K2
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:24:44 -0400
References: <cover.1502075213.git.jcody@redhat.com>
	<403586fbd705655c9e861b9e57648b598b651896.1502075213.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06087502-7d53-bc88-59a4-3a5f49426367@redhat.com>
Date: Mon, 7 Aug 2017 06:24:30 -0500
MIME-Version: 1.0
In-Reply-To: <403586fbd705655c9e861b9e57648b598b651896.1502075213.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Obx1oGRksVfPf0K2c33B8JNonJDDMXrk"
Subject: Re: [Qemu-devel] [PATCH 2/2] block/vhdx: check for offset overflow
 to bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Obx1oGRksVfPf0K2c33B8JNonJDDMXrk
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-block@nongnu.org
Message-ID: <06087502-7d53-bc88-59a4-3a5f49426367@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/vhdx: check for offset overflow to
 bdrv_truncate()
References: <cover.1502075213.git.jcody@redhat.com>
 <403586fbd705655c9e861b9e57648b598b651896.1502075213.git.jcody@redhat.com>
In-Reply-To: <403586fbd705655c9e861b9e57648b598b651896.1502075213.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/06/2017 10:08 PM, Jeff Cody wrote:
> VHDX uses uint64_t types for most offsets, following the VHDX spec.
> However, bdrv_truncate() takes an int64_t value for the truncating
> offset.  Check for overflow before calling bdrv_truncate().
>=20
> N.B.: For a compliant image this is not an issue, as the maximum VHDX
> image size is defined per the spec to be 64TB.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/vhdx-log.c | 4 ++++
>  block/vhdx.c     | 3 +++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/block/vhdx-log.c b/block/vhdx-log.c
> index fd4e7af..3b74e5d 100644
> --- a/block/vhdx-log.c
> +++ b/block/vhdx-log.c
> @@ -554,6 +554,10 @@ static int vhdx_log_flush(BlockDriverState *bs, BD=
RVVHDXState *s,
>              if (new_file_size % (1024*1024)) {
>                  /* round up to nearest 1MB boundary */
>                  new_file_size =3D ((new_file_size >> 20) + 1) << 20;

Since you're touching here, can you fix this to use QEMU_ALIGN_UP instead=
?

> +                if (new_file_size > INT64_MAX) {
> +                    ret =3D -EINVAL;
> +                    goto exit;
> +                }
>                  bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_O=
FF, NULL);

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2Obx1oGRksVfPf0K2c33B8JNonJDDMXrk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmITe4ACgkQp6FrSiUn
Q2oPNAf/RojkyLfu0pAcYp5vu/2cTnS1djidVhAOymZ31GPW0mQVH4o8AkgZHh/l
KjOIzmHiSYVrTRefXmJreRCKRxBc7QuoiiQ4X/RnSDzRd2Vz4e//hZNM4y/LisGV
cveSqSMu1QQNH96Ox65ZF0j4FA7BHSfRM1BsUPUwwwoNQD5s3kSVLOXy2vmWI8l1
Rh+klc2r+YYwCk4yBpiIiQNgrAN9mkwu+PnyYd55joRebS/OiUw48RqoslEeh4bH
NzqbKDcpok0EW7EdNhYnmu8+sCa1f+Fw80vrD0p63pF02kfY3cyMXLiO2N/mKZHp
iMJDEJAppMgouBufEGwI+Ho0cWOu9w==
=V42S
-----END PGP SIGNATURE-----

--2Obx1oGRksVfPf0K2c33B8JNonJDDMXrk--
