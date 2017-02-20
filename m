Received: from eggs.gnu.org ([2001:4830:134:3::10]:47320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfn58-0001pW-I5
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfn57-0004rn-NM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:28:42 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-21-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6f790f11-1427-7f23-83d1-d3212fb74ddc@redhat.com>
Date: Mon, 20 Feb 2017 13:28:31 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-21-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I5BUSO7JhPBlBbXBghEogfkJ5u1sPbLT4"
Subject: Re: [Qemu-devel] [RFC PATCH 20/41] hw/block: Introduce share-rw
 qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I5BUSO7JhPBlBbXBghEogfkJ5u1sPbLT4
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <6f790f11-1427-7f23-83d1-d3212fb74ddc@redhat.com>
Subject: Re: [RFC PATCH 20/41] hw/block: Introduce share-rw qdev property
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-21-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> By default, don't allow another writer for block devices that are
> attached to a guest device. For the cases where this setup is intended
> (e.g. using a cluster filesystem on the disk), the new option can be
> used to allow it.
>=20
> This change affects only devices using DEFINE_BLOCK_PROPERTIES().
> Devices directly using DEFINE_PROP_DRIVE() still accept writers
> unconditionally.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/block/block.c           | 14 ++++++------
>  include/hw/block/block.h   |  4 +++-
>  tests/qemu-iotests/172.out | 53 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 64 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/block/block.c b/hw/block/block.c
> index c3d3901..3c218eb 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -56,7 +56,7 @@ void blkconf_apply_backend_options(BlockConf *conf, b=
ool readonly,
>  {
>      BlockBackend *blk =3D conf->blk;
>      BlockdevOnError rerror, werror;
> -    uint64_t perm;
> +    uint64_t perm, shared_perm;
>      bool wce;
>      int ret;
> =20
> @@ -65,11 +65,13 @@ void blkconf_apply_backend_options(BlockConf *conf,=
 bool readonly,
>          perm |=3D BLK_PERM_WRITE;
>      }
> =20
> -    /* TODO Remove BLK_PERM_WRITE unless explicitly configured so */
> -    ret =3D blk_set_perm(blk, perm,
> -                       BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHA=
NGED |
> -                       BLK_PERM_GRAPH_MOD | BLK_PERM_RESIZE | BLK_PERM=
_WRITE,
> -                       errp);
> +    shared_perm =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGE=
D |
> +                  BLK_PERM_GRAPH_MOD | BLK_PERM_RESIZE;

I'm not so sure BLK_PERM_RESIZE belongs here.

Max

> +    if (conf->share_rw) {
> +        shared_perm |=3D BLK_PERM_WRITE;
> +    }
> +
> +    ret =3D blk_set_perm(blk, perm, shared_perm, errp);
>      if (ret < 0) {
>          return;
>      }

[...]



--I5BUSO7JhPBlBbXBghEogfkJ5u1sPbLT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq4O8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANcwH/0L6vAoODMsSOmbnDglRoIQKLb/2DliG
kWzyq+Z0GfEJy2MdV/3TvJOlfXg95KuY5aBVQEO5fJuDwZUe2ulF9xUSpQEMDp2v
i9uJfm2Cqx8sCWt86iAL8XbsT+FqdTKjqeKd2uc7UhmRQvRsc1Soe5ujWPOG4MHA
dss19x2zWnhnVcMROOTXWw4+t8iAi9+TnU0YbiVzd+jiJ2F6mTUSdkIYtoDNRDll
qbJRFo77H7S07f9GRoGHT+287MObHDXXxpYj0RkNm0y0Itd2Mt1qf8K20eCSzm19
uLiKGpgG1CifzHrBBuOyrRVywLmMW1hZdLgCapDR1c4E1zU5EzjJ+pg=
=vmi5
-----END PGP SIGNATURE-----

--I5BUSO7JhPBlBbXBghEogfkJ5u1sPbLT4--
