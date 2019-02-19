Received: from eggs.gnu.org ([209.51.188.92]:35418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gvzo1-0006JW-DS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gvzny-0006A1-Sf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:27:05 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Tue, 19 Feb 2019 07:26:51 +0000
Message-ID: <VI1PR0602MB32452B6E3203D73EB52C648CA47C0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <CABdb7377U9SpZno1kU6+TuARUmqfMMcC2uuwXTHqSZpLsqB7Gw@mail.gmail.com>
	<1498199343.2815.0@smtp-mail.outlook.com>
	<VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190201054849.GH23131@stefanha-x1.localdomain>
	<VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190204060636.GF29758@stefanha-x1.localdomain>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo>
	<VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190211031725.GB18083@stefanha-x1.localdomain>
	<VI1PR0602MB3245424120D151F29884A7E2A4630@VI1PR0602MB3245.eurprd06.prod.outlook.com>
In-Reply-To: <VI1PR0602MB3245424120D151F29884A7E2A4630@VI1PR0602MB3245.eurprd06.prod.outlo
	ok.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Problem reproduced with virtio-scsi as well on the same guest, this time it=
 took less than a day.
Information from the log file:

vdev 0x55823f119f90 ("virtio-scsi")
vq 0x55823f122e80 (idx 2)
inuse 128 vring.num 128
old_shadow_avail_idx 58367 last_avail_idx 58113 avail_idx 58367
avail 0x3de8a800 avail_idx (cache bypassed) 58113
used_idx 57985
2019-02-19 04:20:43.291+0000: shutting down, reason=3Dcrashed

Got the dump file as well, including guest memory. Size is around 486MB aft=
er compression.
Is there any other information I should collect to progress the investigati=
on?

Thanks.

On lun, feb 18, 2019 at 8:21 AM, Fernando Casas Sch=F6ssow <casasfernando@o=
utlook.com> wrote:
It took a few days but last night the problem was reproduced.
This is the information from the log:

vdev 0x55f261d940f0 ("virtio-blk")
vq 0x55f261d9ee40 (idx 0)
inuse 128 vring.num 128
old_shadow_avail_idx 58874 last_avail_idx 58625 avail_idx 58874
avail 0x3d87a800 avail_idx (cache bypassed) 58625
used_idx 58497
2019-02-18 03:20:08.605+0000: shutting down, reason=3Dcrashed

The dump file, including guest memory, was generated successfully (after gz=
ip the file is around 492MB).
I switched the guest now to virtio-scsi to get the information and dump wit=
h this setup as well.

How should we proceed?

Thanks.

On lun, feb 11, 2019 at 4:17 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
Thanks for collecting the data! The fact that both virtio-blk and virtio-sc=
si failed suggests it's not a virtqueue element leak in the virtio-blk or v=
irtio-scsi device emulation code. The hung task error messages from inside =
the guest are a consequence of QEMU hitting the "Virtqueue size exceeded" e=
rror. QEMU refuses to process further requests after the error, causing tas=
ks inside the guest to get stuck on I/O. I don't have a good theory regardi=
ng the root cause. Two ideas: 1. The guest is corrupting the vring or submi=
tting more requests than will fit into the ring. Somewhat unlikely because =
it happens with both Windows and Linux guests. 2. QEMU's virtqueue code is =
buggy, maybe the memory region cache which is used for fast guest RAM acces=
ses. Here is an expanded version of the debug patch which might help identi=
fy which of these scenarios is likely. Sorry, it requires running the guest=
 again! This time let's make QEMU dump core so both QEMU state and guest RA=
M are captured for further debugging. That way it will be possible to extra=
ct more information using gdb without rerunning. Stefan --- diff --git a/hw=
/virtio/virtio.c b/hw/virtio/virtio.c index a1ff647a66..28d89fcbcb 100644 -=
-- a/hw/virtio/virtio.c +++ b/hw/virtio/virtio.c @@ -866,6 +866,7 @@ void *=
virtqueue_pop(VirtQueue *vq, size_t sz) return NULL; } rcu_read_lock(); + u=
int16_t old_shadow_avail_idx =3D vq->shadow_avail_idx; if (virtio_queue_emp=
ty_rcu(vq)) { goto done; } @@ -879,6 +880,12 @@ void *virtqueue_pop(VirtQue=
ue *vq, size_t sz) max =3D vq->vring.num; if (vq->inuse >=3D vq->vring.num)=
 { + fprintf(stderr, "vdev %p (\"%s\")\n", vdev, vdev->name); + fprintf(std=
err, "vq %p (idx %u)\n", vq, (unsigned int)(vq - vdev->vq)); + fprintf(stde=
rr, "inuse %u vring.num %u\n", vq->inuse, vq->vring.num); + fprintf(stderr,=
 "old_shadow_avail_idx %u last_avail_idx %u avail_idx %u\n", old_shadow_ava=
il_idx, vq->last_avail_idx, vq->shadow_avail_idx); + fprintf(stderr, "avail=
 %#" HWADDR_PRIx " avail_idx (cache bypassed) %u\n", vq->vring.avail, virti=
o_lduw_phys(vdev, vq->vring.avail + offsetof(VRingAvail, idx))); + fprintf(=
stderr, "used_idx %u\n", vq->used_idx); + abort(); /* <--- core dump! */ vi=
rtio_error(vdev, "Virtqueue size exceeded"); goto done; }
