Received: from eggs.gnu.org ([2001:4830:134:3::10]:52286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyEzF-0007q7-Hy
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyEzE-0005aQ-IA
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:54:53 -0400
Date: Wed, 12 Apr 2017 10:54:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170412095431.GA26164@stefanha-x1.localdomain>
References: <1491912312-23393-1-git-send-email-lidongchen@tencent.com>
	<20170411155958.GE5940@stefanha-x1.localdomain>
	<CAOGPPbepj9RiVXt8XnNBfkofre1t3oqAU3d3d9CsBDwLNR91_w@mail.gmail.com>
	<CAOGPPbcwg99ZSDKmqv3K2X6C0SLkQJ3WjRzSBWRtT-+V0besmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <CAOGPPbcwg99ZSDKmqv3K2X6C0SLkQJ3WjRzSBWRtT-+V0besmQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 09:51:23AM +0800, 858585 jemmy wrote:
> On Wed, Apr 12, 2017 at 9:27 AM, 858585 jemmy <jemmy858585@gmail.com> wro=
te:
> > On Tue, Apr 11, 2017 at 11:59 PM, Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> >> On Tue, Apr 11, 2017 at 08:05:12PM +0800, jemmy858585@gmail.com wrote:
> >>> From: Lidong Chen <lidongchen@tencent.com>
> >>>
> >>> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
> >>> this maybe cause the qcow2 file size is bigger after migration.
> >>> This patch check each cluster, use blk_pwrite_zeroes for each
> >>> zero cluster.
> >>>
> >>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> >>> ---
> >>>  migration/block.c | 33 +++++++++++++++++++++++++++++++--
> >>>  1 file changed, 31 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/migration/block.c b/migration/block.c
> >>> index 7734ff7..5d0635a 100644
> >>> --- a/migration/block.c
> >>> +++ b/migration/block.c
> >>> @@ -885,6 +885,8 @@ static int block_load(QEMUFile *f, void *opaque, =
int version_id)
> >>>      int64_t total_sectors =3D 0;
> >>>      int nr_sectors;
> >>>      int ret;
> >>> +    BlockDriverInfo bdi;
> >>> +    int cluster_size;
> >>>
> >>>      do {
> >>>          addr =3D qemu_get_be64(f);
> >>> @@ -919,6 +921,15 @@ static int block_load(QEMUFile *f, void *opaque,=
 int version_id)
> >>>                      error_report_err(local_err);
> >>>                      return -EINVAL;
> >>>                  }
> >>> +
> >>> +                ret =3D bdrv_get_info(blk_bs(blk), &bdi);
> >>> +                if (ret =3D=3D 0 && bdi.cluster_size > 0 &&
> >>> +                    bdi.cluster_size <=3D BLOCK_SIZE &&
> >>> +                    BLOCK_SIZE % bdi.cluster_size =3D=3D 0) {
> >>> +                    cluster_size =3D bdi.cluster_size;
> >>> +                } else {
> >>> +                    cluster_size =3D BLOCK_SIZE;
> >>
> >> This is a nice trick to unify code paths.  It has a disadvantage thoug=
h:
> >>
> >> If the "zero blocks" migration capability is enabled and the drive has
> >> no cluster_size (e.g. raw files), then the source QEMU process has
> >> already scanned for zeroes.  CPU is wasted scanning for zeroes in the
> >> destination QEMU process.
> >>
> >> Given that disk images can be large we should probably avoid unnecessa=
ry
> >> scanning.  This is especially true because there's no other reason
> >> (besides zero detection) to pollute the CPU cache with data from the
> >> disk image.
> >>
> >> In other words, we should only scan for zeroes when
> >> !block_mig_state.zero_blocks || cluster_size < BLOCK_SIZE.
> >
> > This case, the source qemu process will add BLK_MIG_FLAG_ZERO_BLOCK fla=
g.
> > It will call blk_pwrite_zeroes already before apply this patch.
> > so destination QEMU process will not scanning for zero cluster.
> >
> > There are two reason cause the destination QEMU process receive the
> > block which don't have
> > BLK_MIG_FLAG_ZERO_BLOCK flag.
> > 1.the source QEMU process is old version, or !block_mig_state.zero_bloc=
ks.
> > 2.the content of BLOCK_SIZE is not zero.
> >
> > So if the destination QEMU process receive the block which don't have
> > BLK_MIG_FLAG_ZERO_BLOCK flag, it already mee the condition
> > !block_mig_state.zero_blocks || cluster_size < BLOCK_SIZE.
> >
> > so i think it's unnecessary to check this condition again.
> >
> > Thanks.
>=20
> Sorry,  you are right.
> it will cause the destination QEMU process scanning for zeroes again.
>=20
> How about this?
>=20
>                 for (i =3D 0; i < BLOCK_SIZE / cluster_size; i++) {
>                     cur_addr =3D addr * BDRV_SECTOR_SIZE + i * cluster_si=
ze;
>                     cur_buf =3D buf + i * cluster_size;
>=20
>                     if ((!block_mig_state.zero_blocks || cluster_size
> < BLOCK_SIZE)
>                         && buffer_is_zero(cur_buf, cluster_size)) {
>                         ret =3D blk_pwrite_zeroes(blk, cur_addr,
>                                                 cluster_size,
>                                                 BDRV_REQ_MAY_UNMAP);
>                     } else {
>                         ret =3D blk_pwrite(blk, cur_addr, cur_buf,
>                                          cluster_size, 0);
>                     }
>                     if (ret < 0) {
>                         break;
>                     }
>                 }

Thanks, looks good to me.  Please send a new revision of the patch.

You can already add my:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7flXAAoJEJykq7OBq3PIZzQH/jDuPmTgPxWTS5rG7jgiwNbw
1IBN1p5tLWBVZOjXr6GIOrQ1ozQ+P5s7OL+nhAsnxRhdGPVndd3C6Ed49cT3dqce
euzqm4fLXFcOJGREosQsN3c4ZJpqYNVzgMU8pHYku3AJ5EJe/TYYA8GjcgA1gRSV
HFC1evNcljYmdmugsvgA32obbJG6KJHb9u0M3wO0ujdRwYYcrl/cX7N++DqxF9kf
hNbfBrZLC4cyc/SVNJmmRTIiPN04gw/TM29VrhEi+wSgKdABT3po4eox8OfUZzdh
iOklGEmSMBknFPKEcjj+DgPsbVbzbz/68TdXerllCgMd51BSGHHx4vV5NHpsfL0=
=B8KY
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
