Received: from eggs.gnu.org ([2001:4830:134:3::10]:55102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elF6D-0008CA-FV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elF6C-0007ps-Gi
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:28:53 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-15-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d24da529-61c3-64f7-84d4-87e38a3280c1@redhat.com>
Date: Mon, 12 Feb 2018 15:28:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-15-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bZoApFPD8CLAdpyP4N17R2VWL49QxGp5H"
Subject: Re: [Qemu-devel] [PATCH 14/27] gluster: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bZoApFPD8CLAdpyP4N17R2VWL49QxGp5H
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <d24da529-61c3-64f7-84d4-87e38a3280c1@redhat.com>
Subject: Re: [PATCH 14/27] gluster: Support .bdrv_co_create
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-15-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to gluster, which enables=

> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  18 ++++++-
>  block/gluster.c      | 149 +++++++++++++++++++++++++++++++++----------=
--------
>  2 files changed, 115 insertions(+), 52 deletions(-)

[...]

> diff --git a/block/gluster.c b/block/gluster.c
> index 0f4265a3a4..b7e2b7fa2b 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c

[...]

> @@ -962,64 +976,33 @@ static coroutine_fn int qemu_gluster_co_pwrite_ze=
roes(BlockDriverState *bs,
>  }
>  #endif
> =20
> -static int qemu_gluster_create(const char *filename,
> -                               QemuOpts *opts, Error **errp)
> +static int qemu_gluster_co_create(BlockdevCreateOptions *options,
> +                                  Error **errp)
>  {
> -    BlockdevOptionsGluster *gconf;
> +    BlockdevCreateOptionsGluster *opts =3D &options->u.gluster;

In the other drivers so far you have asserted first that options->driver
is as expected and then retrieved the appropriate part of the union.  I
liked that a bit better, although of course it doesn't matter functionall=
y.

Anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      struct glfs *glfs;
>      struct glfs_fd *fd;
>      int ret =3D 0;
> -    PreallocMode prealloc;
> -    int64_t total_size =3D 0;
> -    char *tmp =3D NULL;
> -    Error *local_err =3D NULL;
> -
> -    gconf =3D g_new0(BlockdevOptionsGluster, 1);
> -    gconf->debug =3D qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
> -                                           GLUSTER_DEBUG_DEFAULT);
> -    if (gconf->debug < 0) {
> -        gconf->debug =3D 0;
> -    } else if (gconf->debug > GLUSTER_DEBUG_MAX) {
> -        gconf->debug =3D GLUSTER_DEBUG_MAX;
> -    }
> -    gconf->has_debug =3D true;
> =20
> -    gconf->logfile =3D qemu_opt_get_del(opts, GLUSTER_OPT_LOGFILE);
> -    if (!gconf->logfile) {
> -        gconf->logfile =3D g_strdup(GLUSTER_LOGFILE_DEFAULT);
> -    }
> -    gconf->has_logfile =3D true;
> +    assert(options->driver =3D=3D BLOCKDEV_DRIVER_GLUSTER);
> =20


--bZoApFPD8CLAdpyP4N17R2VWL49QxGp5H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBpJsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhhwH/3vWTBXM88PVsRV/NTNvmwe0WtA+PlIk
B0khd6Im/rVMnNXi7nOD4nbNqzfbHKyhuwk+wqHvIaqaRcaJ/iazq6ni8dzPvUs5
iFnGyZeor7vvHybv39OwTb1OzDnSomQXA6Ymjle72ysQ2iuWYaPL/0AH+XjvI1tQ
PrAhW1r6NBottK2e6s3vxdEkoH915Ks5yalhLuOA76lPggUHprHNf5P5fPBB3Ai9
6a+h7/FF49JTvRptPv5hU98TnMm0Wlp8M2AAR+FK7FdWS2E2tlZg0HXsYtnztpD4
iQlovhr5CvX8/tVe907mXDyYwkczQAbATPteJIDbAU1yVo4skBTqa30=
=4X0G
-----END PGP SIGNATURE-----

--bZoApFPD8CLAdpyP4N17R2VWL49QxGp5H--
