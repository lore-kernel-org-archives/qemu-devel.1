Received: from eggs.gnu.org ([2001:4830:134:3::10]:35601)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cdjwu-0004hk-Rp
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cdjwq-0004Ye-WB
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:43:44 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47170 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cdjwq-0004Wg-Ge
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:43:40 -0500
Date: Tue, 14 Feb 2017 21:43:02 +0100
Message-ID: <1045307195-43255@kerio.kamp.de>
In-Reply-To: <20170214162012.GC6189@noname.redhat.com>
MIME-Version: 1.0
From: Peter Lieven <pl@kamp.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH V3] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, ct@flyingcircus.io





 Von:   Kevin Wolf <kwolf@redhat.com>=20
 An:   Peter Lieven <pl@kamp.de>=20
 Kopie:   <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, <mreitz@redhat.=
com>, <ct@flyingcircus.io>=20
 Gesendet:   14.02.2017 17:20=20
 Betreff:   Re: [RFC PATCH V3] qemu-img: make convert async=20

Am 14.02.2017 um 14:39 hat Peter Lieven geschrieben:=20
> this is something I have been thinking about for almost 2 years now.=20
> we heavily have the following two use cases when using qemu-img convert.=20
> =20
> a) reading from NFS and writing to iSCSI for deploying templates=20
> b) reading from iSCSI and writing to NFS for backups=20
> =20
> In both processes we use libiscsi and libnfs so we have no kernel pagecac=
he.=20
> As qemu-img convert is implemented with sync operations that means we=20
> read one buffer and then write it. No parallelism and each sync request=20
> takes as long as it takes until it is completed.=20
> =20
> This is version 3 of the approach using coroutine worker "threads".=20
> =20
> So far I have the following runtimes when reading an uncompressed QCOW2 f=
rom=20
> NFS and writing it to iSCSI (raw):=20
> =20
> qemu-img (master)=20
> =C2=A0nfs -> iscsi 22.8 secs=20
> =C2=A0nfs -> ram =C2=A0 11.7 secs=20
> =C2=A0ram -> iscsi 12.3 secs=20
> =20
> qemu-img-async=20
> =C2=A0nfs -> iscsi 12.3 secs=20
> =C2=A0nfs -> ram =C2=A0 10.5 secs=20
> =C2=A0ram -> iscsi 11.7 secs=20
> =20
> Comments appreciated.=20
> =20
> Thank you,=20
> Peter=20
> =20
> Signed-off-by: Peter Lieven <pl@kamp.de>=20
> ---=20
> v2->v3: - updated stats in the commit msg from a host with a better netwo=
rk card=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - only wake up the coroutine that is acutally=
 waiting for a write to complete.=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 this was not only overhead, but also b=
reaking at least linux AIO.=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - fix coding style complaints=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - rename some variables and structs=20
> =20
> v1->v2: - using coroutine as worker "threads". [Max]=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - keeping the request queue as otherwise it h=
appens=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that we wait on BLK_ZERO chunks while =
keeping the write order.=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 it also avoids redundant calls to get_=
block_status and helps=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to skip some conditions for fully allo=
cated imaged (!s->min_sparse)=20
> =20
> =C2=A0qemu-img.c | 213 +++++++++++++++++++++++++++++++++++++++++---------=
-----------=20
> =C2=A01 file changed, 145 insertions(+), 68 deletions(-)=20
> =20
> diff --git a/qemu-img.c b/qemu-img.c=20
> index cff22e3..970863f 100644=20
> --- a/qemu-img.c=20
> +++ b/qemu-img.c=20
> @@ -1448,6 +1448,16 @@ enum ImgConvertBlockStatus {=20
> =C2=A0 =C2=A0 =C2=A0BLK_BACKING_FILE,=20
> =C2=A0};=20
> =C2=A0=20
> +typedef struct ImgConvertRequest {=20
> + =C2=A0 =C2=A0int64_t sector_num;=20
> + =C2=A0 =C2=A0enum ImgConvertBlockStatus status;=20
> + =C2=A0 =C2=A0int nb_sectors;=20
> + =C2=A0 =C2=A0QSIMPLEQ_ENTRY(ImgConvertRequest) next;=20
> +} ImgConvertRequest;=20
=20
If I understand your code correctly, you first go through the image and=20
create an ImgConvertRequest for every chunk with the same allocation=20
status (well, actually not every chunk, but that may be a bug, see=20
below).=20
=20
So let's assume a 1 TB image with every other cluster allocated:=20
=20
 =C2=A0 =C2=A01T / (64k * 2) =3D 8M=20
=20
A list with 8 million entries (requiring 8 million mallocs) feels=20
relatively large. Not counting malloc overhead (which might be=20
considerable here), I think we're at 192 MB memory usage for this case.=20
Not as bad as I was afraid, but not really nice either. And 1 TB isn't=20
even close to the maximum image size.=20
=20
Is it really necessary to create this list at the beginning? Why can't=20
we just get the next chunk as the old code used to?=20


In my initial version with AIO invoking convert_iterate_sectors caused
recursive entries into my queue_fill functions. If I have fixed worker thre=
ads
or only a few coroutines for read/write whatsever this might work without.
I will have a look. In my test cases I don't have such heavily fragmented
images. I was at a few hundred entries at most.
The other issue I feared was that the "cache" in convert_iterate_sectors
does not work correctly. But if the calls to this function are still in inc=
reasing
sector order, it should work.




=20
> +/* XXX: this should be a cmdline parameter */=20
> +#define NUM_COROUTINES 8=20
> +=20
> =C2=A0typedef struct ImgConvertState {=20
> =C2=A0 =C2=A0 =C2=A0BlockBackend **src;=20
> =C2=A0 =C2=A0 =C2=A0int64_t *src_sectors;=20
> @@ -1455,6 +1465,8 @@ typedef struct ImgConvertState {=20
> =C2=A0 =C2=A0 =C2=A0int64_t src_cur_offset;=20
> =C2=A0 =C2=A0 =C2=A0int64_t total_sectors;=20
> =C2=A0 =C2=A0 =C2=A0int64_t allocated_sectors;=20
> + =C2=A0 =C2=A0int64_t allocated_done;=20
> + =C2=A0 =C2=A0int64_t wr_offs;=20
> =C2=A0 =C2=A0 =C2=A0enum ImgConvertBlockStatus status;=20
> =C2=A0 =C2=A0 =C2=A0int64_t sector_next_status;=20
> =C2=A0 =C2=A0 =C2=A0BlockBackend *target;=20
> @@ -1464,11 +1476,16 @@ typedef struct ImgConvertState {=20
> =C2=A0 =C2=A0 =C2=A0int min_sparse;=20
> =C2=A0 =C2=A0 =C2=A0size_t cluster_sectors;=20
> =C2=A0 =C2=A0 =C2=A0size_t buf_sectors;=20
> + =C2=A0 =C2=A0Coroutine *co[NUM_COROUTINES];=20
> + =C2=A0 =C2=A0int64_t wait_sector_num[NUM_COROUTINES];=20
> + =C2=A0 =C2=A0QSIMPLEQ_HEAD(, ImgConvertRequest) queue;=20
> + =C2=A0 =C2=A0int ret;=20
> =C2=A0} ImgConvertState;=20
> =C2=A0=20
> =C2=A0static void convert_select_part(ImgConvertState *s, int64_t sector_=
num)=20
> =C2=A0{=20
> - =C2=A0 =C2=A0assert(sector_num >=3D s->src_cur_offset);=20
> + =C2=A0 =C2=A0s->src_cur_offset =3D 0;=20
> + =C2=A0 =C2=A0s->src_cur =3D 0;=20
> =C2=A0 =C2=A0 =C2=A0while (sector_num - s->src_cur_offset >=3D s->src_sec=
tors[s->src_cur]) {=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->src_cur_offset +=3D s->src_sectors[s=
->src_cur];=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->src_cur++;=20
=20
Is this necessary because we can effectively go backwards now when one=20
coroutine works already on the next part, but another one is still=20
processing the previous one? Worth a comment?=20


Exactly that is the problem. I will add a comment.


=20
> @@ -1544,11 +1561,13 @@ static int convert_iteration_sectors(ImgConvertSt=
ate *s, int64_t sector_num)=20
> =C2=A0 =C2=A0 =C2=A0return n;=20
> =C2=A0}=20
> =C2=A0=20
> -static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_s=
ectors,=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint8_t *buf)=20
> +static int convert_co_read(ImgConvertState *s, ImgConvertRequest *req,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 uint8_t *buf, QEMUIOVector *qiov)=20
=20
This is a weird interface: You want to get a created, but empty qiov=20
from the caller. There's no real point in that. The traditional approch=20
is having a struct iovec on the stack here locally and then using=20
qemu_iovec_init_external().=20


The idea was to avoid the qemu_iovec every time because this involves a mal=
loc,
but I admit its not nice. Maybe I find a better approach.


=20
> =C2=A0{=20
> =C2=A0 =C2=A0 =C2=A0int n;=20
> =C2=A0 =C2=A0 =C2=A0int ret;=20
> + =C2=A0 =C2=A0int64_t sector_num =3D req->sector_num;=20
> + =C2=A0 =C2=A0int nb_sectors =3D req->nb_sectors;=20
> =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0assert(nb_sectors <=3D s->buf_sectors);=20
> =C2=A0 =C2=A0 =C2=A0while (nb_sectors > 0) {=20
> @@ -1562,10 +1581,13 @@ static int convert_read(ImgConvertState *s, int64=
_t sector_num, int nb_sectors,=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk =3D s->src[s->src_cur];=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bs_sectors =3D s->src_sectors[s->src_cu=
r];=20
> =C2=A0=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_iovec_reset(qiov);=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D MIN(nb_sectors, bs_sectors - (sec=
tor_num - s->src_cur_offset));=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_pread(blk,=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(sector_num - s->src_cur_offset) << BDRV_SECTOR_BITS,=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0buf, n << BDRV_SECTOR_BITS);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_iovec_add(qiov, buf, n << BDRV_SECTOR_B=
ITS);=20
> +=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_co_preadv(=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk, (sector_num=
 - s->src_cur_offset) << BDRV_SECTOR_BITS,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n << BDRV_SECTOR=
_BITS, qiov, 0);=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0) {=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> @@ -1578,15 +1600,18 @@ static int convert_read(ImgConvertState *s, int64=
_t sector_num, int nb_sectors,=20
> =C2=A0 =C2=A0 =C2=A0return 0;=20
> =C2=A0}=20
> =C2=A0=20
> -static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_=
sectors,=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 const uint8_t *buf)=20
> +=20
> +static int convert_co_write(ImgConvertState *s, ImgConvertRequest *req,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *buf, QEMUIOVector *qiov)=20
=20
Same thing here.=20
=20
Note that convert_write() used to be called unconditionally. This is not=20
the case any more because you don't create ImgConvertRequests=20
unconditionally. In particular, BLK_ZERO is skipped without -S 0 instead=20
of doing a blk_co_pwrite_zeroes(). This is a bug. The assertion in the=20
BLK_BACKING_FILE branch of the switch is also dead code now.


You are right. This needs to be fixed.

=20
=20
> =C2=A0{=20
> =C2=A0 =C2=A0 =C2=A0int ret;=20
> + =C2=A0 =C2=A0int64_t sector_num =3D req->sector_num;=20
> + =C2=A0 =C2=A0int nb_sectors =3D req->nb_sectors;=20
> =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0while (nb_sectors > 0) {=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int n =3D nb_sectors;=20
> -=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (s->status) {=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_iovec_reset(qiov);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (req->status) {=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case BLK_BACKING_FILE:=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If we have a backing f=
ile, leave clusters unallocated that are=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * unallocated in the sou=
rce image, so that the backing file is=20
> @@ -1607,9 +1632,10 @@ static int convert_write(ImgConvertState *s, int64=
_t sector_num, int nb_sectors,=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> =C2=A0=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_pwri=
te_compressed(s->target,=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sector_num << BDRV_SECTOR_BITS,=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0buf, n << BDRV_SECTOR_BITS);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_iovec_add(q=
iov, buf, n << BDRV_SECTOR_BITS);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_co_p=
writev(s->target, sector_num << BDRV_SECTOR_BITS,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n << BDRV_SECTOR_BI=
TS, qiov,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BDRV_REQ_WRITE_COMP=
RESSED);=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0=
) {=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return ret;=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> @@ -1622,8 +1648,9 @@ static int convert_write(ImgConvertState *s, int64_=
t sector_num, int nb_sectors,=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s->min_sparse ||=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is_allocate=
d_sectors_min(buf, n, &n, s->min_sparse))=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_pwri=
te(s->target, sector_num << BDRV_SECTOR_BITS,=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf, n << BDRV_SECTOR_BITS, 0);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_iovec_add(q=
iov, buf, n << BDRV_SECTOR_BITS);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_co_p=
writev(s->target, sector_num << BDRV_SECTOR_BITS,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n << BDRV_SECTOR_BI=
TS, qiov, 0);=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0=
) {=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return ret;=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> @@ -1635,8 +1662,9 @@ static int convert_write(ImgConvertState *s, int64_=
t sector_num, int nb_sectors,=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s->has_zero_init) {=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_pwrite_zeroes(s->t=
arget, sector_num << BDRV_SECTOR_BITS,=20
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n << BDRV_SECTOR_BIT=
S, 0);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_co_pwrite_zeroes(s=
->target,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sector_num <=
< BDRV_SECTOR_BITS,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n << BDRV_SE=
CTOR_BITS, 0);=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0) {=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;=
=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> @@ -1651,12 +1679,92 @@ static int convert_write(ImgConvertState *s, int6=
4_t sector_num, int nb_sectors,=20
> =C2=A0 =C2=A0 =C2=A0return 0;=20
> =C2=A0}=20
> =C2=A0=20
> -static int convert_do_copy(ImgConvertState *s)=20
> +static void convert_co_do_copy(void *opaque)=20
> =C2=A0{=20
> + =C2=A0 =C2=A0ImgConvertState *s =3D opaque;=20
> =C2=A0 =C2=A0 =C2=A0uint8_t *buf =3D NULL;=20
> - =C2=A0 =C2=A0int64_t sector_num, allocated_done;=20
> + =C2=A0 =C2=A0int ret, i;=20
> + =C2=A0 =C2=A0ImgConvertRequest *req, *next_req;=20
> + =C2=A0 =C2=A0QEMUIOVector qiov;=20
> + =C2=A0 =C2=A0int index =3D -1;=20
> +=20
> + =C2=A0 =C2=A0for (i =3D 0; i < NUM_COROUTINES; i++) {=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s->co[i] =3D=3D qemu_coroutine_self()) {=
=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D i;=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> + =C2=A0 =C2=A0}=20
> + =C2=A0 =C2=A0assert(index >=3D 0);=20
> +=20
> + =C2=A0 =C2=A0qemu_iovec_init(&qiov, 1);=20
> + =C2=A0 =C2=A0buf =3D blk_blockalign(s->target, s->buf_sectors * BDRV_SE=
CTOR_SIZE);=20
> +=20
> + =C2=A0 =C2=A0while (s->ret =3D=3D -EINPROGRESS && (req =3D QSIMPLEQ_FIR=
ST(&s->queue))) {=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0QSIMPLEQ_REMOVE_HEAD(&s->queue, next);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0next_req =3D QSIMPLEQ_FIRST(&s->queue);=20
> +=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0s->allocated_done +=3D req->nb_sectors;=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_progress_print(100.0 * s->allocated_don=
e / s->allocated_sectors,=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00);=20
> +=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (req->status =3D=3D BLK_DATA) {=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D convert_co_read(s, req=
, buf, &qiov);=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0) {=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report("er=
ror while reading sector %" PRId64=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ": %s", req->sector_num, strerror(-ret));=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->ret =3D ret;=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> +=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* keep writes in order */=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0while (s->wr_offs !=3D req->sector_num) {=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s->ret !=3D -EINPROGRESS) =
{=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->wait_sector_num[index] =3D =
req->sector_num;=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_coroutine_yield();=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}=20
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0s->wait_sector_num[index] =3D -1;=20
=20
Okay, so may this is the most important part of the patch.=20
=20
If we need to keep writes in order, we can only have a single coroutine=20
that is currently writing. Then how likely is it that more than one=20
other coroutine could actually be reading at the same time rather than=20
just waiting for the current writer to be finished?=20
=20
My assumption is that it effectively degenerates to exactly one reader=20
and one writer, which means that we don't actually need a command line=20
option to configure the number of coroutines, and that our default of 8=20
is already higher than useful.=20


I will check the result for 4 and 2 coroutines. My observation or fear was
that a read and write that are effectively no-ops (BLK_ZERO with s->has_zer=
o_init)
could block the queue and avoid to read ahead.




=20
The big question is then if the code could become simpler if we can=20
assume exactly two coroutines. Possibly even not two coroutines that do=20
the same thing, but one that reads and another one that writes,=20
coordinated with the usual coroutine locking mechanisms. (I haven't=20
thought enough about it to be sure that it would be an improvement, but=20
it doesn't feel too unlikely.)=20
=20
On the other hand, if keeping writes in order is only actually needed in=20
specific cases, other cases could benefit from actual parallelism, even=20
though this is not implemented in this patch.=20


I tried to disable it. It has had no influence for my test scenario. But wi=
th
the current approach such a switch as well as a switch to define the number
of workers could easily be implemented. Having multiple readers (and maybe =
writers)
should increase performance if there is latency involved.


Before I rewrite everything I would propose to try to change the code
to avoid to build the request queue upfront and analyze what a change in nu=
mber
of coroutines has in the current and the version without request queue?


If we would have a read and a write coroutine and maybe a third (to calcula=
te the request
size with convert_iterate_sectors) my idea would be to have a limited reque=
st queue.
That is passed from coroutine to coroutine.


sth like:
=C2=A0queue 1: free request object
=C2=A0fifo queue 2: request objects ready for reading
=C2=A0fifo queue 3: request objects ready for writing.


The first coroutine would fetch the a free request object and calculate nb_=
sectors and status and
put it into queue 2.
Then the reader coroutine would fetch the next read object in order and per=
form the read. Once
finisched it puts the object into the queue 3.
Then the writer coroutine handles the write and when the write is finished =
it puts it back into
into the freelist (queue 1).


Thanks for your comments,
Peter



=
