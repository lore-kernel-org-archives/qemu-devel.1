Received: from eggs.gnu.org ([2001:4830:134:3::10]:43430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g03kK-000436-3L
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 07:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g03hU-00018K-9i
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 07:52:52 -0400
Date: Wed, 12 Sep 2018 19:52:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180912115241.GI2526@lemon.usersys.redhat.com>
References: <20180828031751.29507-1-yuchenlin@synology.com>
	<20180912093408.GG2526@lemon.usersys.redhat.com>
	<f17ae2da-068a-4b3a-8a4b-685c4c47b107@Mail>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f17ae2da-068a-4b3a-8a4b-685c4c47b107@Mail>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vmdk: align end of file to a sector
 boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <yuchenlin@synology.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, 09/12 17:52, yuchenlin wrote:
>=20
> Fam Zheng <famz@redhat.com> =E6=96=BC 2018-09-12 17:34 =E5=AF=AB=E9=81=93=
=EF=BC=9A
> > On Tue, 08/28 11:17, yuchenlin@synology.com wrote: > From: yuchenlin =
<yuchenlin@synology.com> > > There is a rare case which the size of last =
compressed cluster > is larger than the cluster size, which will cause th=
e file is > not aligned at the sector boundary. I don't understand. Doesn=
't it mean that if you force the alignment by truncating out the extra by=
tes, some data is lost?  =20
>=20
> You can take qcow2_co_pwritev_compressed in block/qcow2.c as an example=
.
> The bdrv_getlength will return the length in bytes which is always a mu=
ltiple of BDRV_SECTOR_SIZE.
> After truncates this size, the vmdk is extended to align sector size.
> > > > Signed-off-by: yuchenlin <yuchenlin@synology.com> > --- > block/v=
mdk.c | 18 ++++++++++++++++++ > 1 file changed, 18 insertions(+) > > diff=
 --git a/block/vmdk.c b/block/vmdk.c > index a9d0084e36..a8ae7c65d2 10064=
4 > --- a/block/vmdk.c > +++ b/block/vmdk.c > @@ -1698,6 +1698,24 @@ stat=
ic int coroutine_fn > vmdk_co_pwritev_compressed(BlockDriverState *bs, ui=
nt64_t offset, > uint64_t bytes, QEMUIOVector *qiov) > { > + if (bytes =3D=
=3D 0) { Where is this bytes =3D=3D 0 condition from?
>=20
> From the end of convert_do_copy in qemu-img.c.
>=20
> if (s->compressed && !s->ret) {
> /* signal EOF to align */
> ret =3D blk_pwrite_compressed(s->target, 0, NULL, 0);
> if (ret < 0) {
> return ret;
> }
> }

I see. Please mention this in the comment of the if check.

Fam

>=20
> It signals the EOF to the block driver.
> > > + /* align end of file to a sector boundary. */ > + BDRVVmdkState *=
s =3D bs->opaque; > + int i, ret; > + int64_t length; > + > + for (i =3D =
0; i < s->num_extents; i++) { > + length =3D bdrv_getlength(s->extents[i]=
.file->bs); > + if (length < 0) { > + return length; > + } > + ret =3D bd=
rv_truncate(s->extents[i].file, length, PREALLOC_MODE_OFF, NULL); > + if =
(ret < 0) { > + return ret; > + } > + } > + return 0; > + } > return vmdk=
_co_pwritev(bs, offset, bytes, qiov, 0); > } > > -- > 2.17.0 > Fam
>=20
>=20
> yuchenlin
>=20
