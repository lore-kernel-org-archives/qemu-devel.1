Received: from eggs.gnu.org ([2001:4830:134:3::10]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fxNLd-0007ig-2s
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 22:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fxNLc-00064n-2c
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 22:15:12 -0400
Date: Wed, 5 Sep 2018 10:14:53 +0800
From: yuchenlin <yuchenlin@synology.com>
Message-ID: <d83ea4f7-3d79-49b1-a067-4146e7cbc745@Mail>
In-Reply-To: <20180828031751.29507-1-yuchenlin@synology.com>
References: <20180828031751.29507-1-yuchenlin@synology.com>
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
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

Ping=21

yuchenlin=40synology.com =E6=96=BC 2018-08-28 11:18 =E5=AF=AB=E9=81=93=EF=
=BC=9A
> =46rom: yuchenlin <yuchenlin=40synology.com> There is a rare case which=
 the size of last compressed cluster is larger than the cluster size, whi=
ch will cause the file is not aligned at the sector boundary. Signed-off-=
by: yuchenlin <yuchenlin=40synology.com> --- block/vmdk.c =7C 18 ++++++++=
++++++++++ 1 file changed, 18 insertions(+) diff --git a/block/vmdk.c b/b=
lock/vmdk.c index a9d0084e36..a8ae7c65d2 100644 --- a/block/vmdk.c +++ b/=
block/vmdk.c =40=40 -1698,6 +1698,24 =40=40 static int coroutine=5Ffn vmd=
k=5Fco=5Fpwritev=5Fcompressed(BlockDriverState *bs, uint64=5Ft offset, ui=
nt64=5Ft bytes, QEMUIOVector *qiov) =7B + if (bytes =3D=3D 0) =7B + /* al=
ign end of file to a sector boundary. */ + BDRVVmdkState *s =3D bs->opaqu=
e; + int i, ret; + int64=5Ft length; + + for (i =3D 0; i < s->num=5Fexten=
ts; i++) =7B + length =3D bdrv=5Fgetlength(s->extents=5Bi=5D.file->bs); +=
 if (length < 0) =7B + return length; + =7D + ret =3D bdrv=5Ftruncate(s->=
extents=5Bi=5D.file, length, PREALLOC=5FMODE=5FO=46=46, NULL); + if (ret =
< 0) =7B + return ret; + =7D + =7D + return 0; + =7D return vmdk=5Fco=5Fp=
writev(bs, offset, bytes, qiov, 0); =7D -- 2.17.0  =20
