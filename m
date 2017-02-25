Received: from eggs.gnu.org ([2001:4830:134:3::10]:50842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chdkE-0000Hw-BK
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 09:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chdkD-0006eY-DL
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 09:54:46 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-48-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ea0b10ea-2e90-a80f-4ca8-235fcd834173@redhat.com>
Date: Sat, 25 Feb 2017 15:54:35 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-48-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BoWwsNi9QT6TT74i9SMRvTHcLxCMQ9JU9"
Subject: Re: [Qemu-devel] [PATCH 47/54] migration/block: Use real permissions
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
--BoWwsNi9QT6TT74i9SMRvTHcLxCMQ9JU9
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <ea0b10ea-2e90-a80f-4ca8-235fcd834173@redhat.com>
Subject: Re: [PATCH 47/54] migration/block: Use real permissions
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-48-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-48-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Request BLK_PERM_CONSISTENT_READ for the source of block migration, and=

> handle potential permission errors as good as we can in this place
> (which is not very good, but it matches the other failure cases).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  migration/block.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/block.c b/migration/block.c
> index d259936..958d0fc 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -379,7 +379,7 @@ static void unset_dirty_tracking(void)
>      }
>  }
> =20
> -static void init_blk_migration(QEMUFile *f)
> +static int init_blk_migration(QEMUFile *f)
>  {
>      BlockDriverState *bs;
>      BlkMigDevState *bmds;
> @@ -390,6 +390,8 @@ static void init_blk_migration(QEMUFile *f)
>          BlkMigDevState *bmds;
>          BlockDriverState *bs;
>      } *bmds_bs;
> +    Error *local_err =3D NULL;
> +    int ret;
> =20
>      block_mig_state.submitted =3D 0;
>      block_mig_state.read_done =3D 0;
> @@ -411,12 +413,12 @@ static void init_blk_migration(QEMUFile *f)
> =20
>          sectors =3D bdrv_nb_sectors(bs);
>          if (sectors <=3D 0) {
> +            ret =3D sectors;
>              goto out;
>          }
> =20
>          bmds =3D g_new0(BlkMigDevState, 1);
> -        /* FIXME Use real permissions */
> -        bmds->blk =3D blk_new(0, BLK_PERM_ALL);
> +        bmds->blk =3D blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);=

>          bmds->blk_name =3D g_strdup(bdrv_get_device_name(bs));
>          bmds->bulk_completed =3D 0;
>          bmds->total_sectors =3D sectors;
> @@ -446,7 +448,11 @@ static void init_blk_migration(QEMUFile *f)
>          BlockDriverState *bs =3D bmds_bs[i].bs;
> =20
>          if (bmds) {
> -            blk_insert_bs(bmds->blk, bs, &error_abort);
> +            ret =3D blk_insert_bs(bmds->blk, bs, &local_err);
> +            if (ret < 0) {
> +                error_report_err(local_err);
> +                goto out;
> +            }
> =20
>              alloc_aio_bitmap(bmds);
>              error_setg(&bmds->blocker, "block device is in use by migr=
ation");
> @@ -454,8 +460,10 @@ static void init_blk_migration(QEMUFile *f)
>          }
>      }
> =20
> +    ret =3D 0;
>  out:
>      g_free(bmds_bs);
> +    return ret;
>  }
> =20
>  /* Called with no lock taken.  */
> @@ -706,7 +714,10 @@ static int block_save_setup(QEMUFile *f, void *opa=
que)
>              block_mig_state.submitted, block_mig_state.transferred);
> =20
>      qemu_mutex_lock_iothread();
> -    init_blk_migration(f);
> +    ret =3D init_blk_migration(f);
> +    if (ret < 0) {

What about qemu_mutex_unlock_iothread()?

Max

> +        return ret;
> +    }
> =20
>      /* start track dirty blocks */
>      ret =3D set_dirty_tracking();
>=20



--BoWwsNi9QT6TT74i9SMRvTHcLxCMQ9JU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixmqsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbdgH/jLMoLZrePWHPpSsVGarZ3a8EdkegFLA
YkSR7vMBM+HHh0wDLikKIu8JItcsngIdCZE6yE+1uDG0zhRoH87XY/EFQGOnYPkc
GU9A10gIndMJGNMaHz/xc/NxAg5SISakKj+aKCaN+YSdN1XXPuhlHNJbZXLtczve
39FdTy7++kRKNyw4aOgCijIBQmE4/LvyLN3+fAfa45GNLddfIq2FdXE7OMp9xiEv
+TOrf5uWvCLeHcrPVXsZiMckFsvnqjs1CrrJ3rG5kmdVayyVUeN50m5MjrzXKZXK
L4MouNQq8gIcWPgRj+43FDKUGnO8/gQLOCCBP2YsRGlzRfHx0GXmHHE=
=FoJg
-----END PGP SIGNATURE-----

--BoWwsNi9QT6TT74i9SMRvTHcLxCMQ9JU9--
