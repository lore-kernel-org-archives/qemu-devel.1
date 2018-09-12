Received: from eggs.gnu.org ([2001:4830:134:3::10]:43621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g01pt-0004cG-5z
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 05:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g01pX-00089m-Ni
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 05:53:04 -0400
Date: Wed, 12 Sep 2018 17:52:40 +0800
From: yuchenlin <yuchenlin@synology.com>
Message-ID: <f17ae2da-068a-4b3a-8a4b-685c4c47b107@Mail>
In-Reply-To: <20180912093408.GG2526@lemon.usersys.redhat.com>
References: <20180828031751.29507-1-yuchenlin@synology.com>
	<20180912093408.GG2526@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


=46am Zheng <famz=40redhat.com> =E6=96=BC 2018-09-12 17:34 =E5=AF=AB=E9=81=
=93=EF=BC=9A
> On Tue, 08/28 11:17, yuchenlin=40synology.com wrote: > =46rom: yuchenli=
n <yuchenlin=40synology.com> > > There is a rare case which the size of l=
ast compressed cluster > is larger than the cluster size, which will caus=
e the file is > not aligned at the sector boundary. I don't understand. D=
oesn't it mean that if you force the alignment by truncating out the extr=
a bytes, some data is lost=3F  =20

You can take qcow2=5Fco=5Fpwritev=5Fcompressed in block/qcow2.c as an exa=
mple.
The bdrv=5Fgetlength will return the length in bytes which is always a mu=
ltiple of BDRV=5FSECTOR=5FSIZE.
After truncates this size, the vmdk is extended to align sector size.
> > > Signed-off-by: yuchenlin <yuchenlin=40synology.com> > --- > block/v=
mdk.c =7C 18 ++++++++++++++++++ > 1 file changed, 18 insertions(+) > > di=
ff --git a/block/vmdk.c b/block/vmdk.c > index a9d0084e36..a8ae7c65d2 100=
644 > --- a/block/vmdk.c > +++ b/block/vmdk.c > =40=40 -1698,6 +1698,24 =40=
=40 static int coroutine=5Ffn > vmdk=5Fco=5Fpwritev=5Fcompressed(BlockDri=
verState *bs, uint64=5Ft offset, > uint64=5Ft bytes, QEMUIOVector *qiov) =
> =7B > + if (bytes =3D=3D 0) =7B Where is this bytes =3D=3D 0 condition =
from=3F

=46rom the end of convert=5Fdo=5Fcopy in qemu-img.c.

if (s->compressed && =21s->ret) =7B
/* signal EO=46 to align */
ret =3D blk=5Fpwrite=5Fcompressed(s->target, 0, NULL, 0);
if (ret < 0) =7B
return ret;
=7D
=7D

It signals the EO=46 to the block driver.
> > + /* align end of file to a sector boundary. */ > + BDRVVmdkState *s =
=3D bs->opaque; > + int i, ret; > + int64=5Ft length; > + > + for (i =3D =
0; i < s->num=5Fextents; i++) =7B > + length =3D bdrv=5Fgetlength(s->exte=
nts=5Bi=5D.file->bs); > + if (length < 0) =7B > + return length; > + =7D =
> + ret =3D bdrv=5Ftruncate(s->extents=5Bi=5D.file, length, PREALLOC=5FMO=
DE=5FO=46=46, NULL); > + if (ret < 0) =7B > + return ret; > + =7D > + =7D=
 > + return 0; > + =7D > return vmdk=5Fco=5Fpwritev(bs, offset, bytes, qi=
ov, 0); > =7D > > -- > 2.17.0 > =46am


yuchenlin
