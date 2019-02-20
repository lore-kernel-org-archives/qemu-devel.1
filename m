Received: from eggs.gnu.org ([209.51.188.92]:41889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gwX2P-0007KL-A8
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gwX2N-0006up-SB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:56:09 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Wed, 20 Feb 2019 18:56:04 +0000
Message-ID: <VI1PR0602MB32456F471A198636E7C7C0B1A47D0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190201054849.GH23131@stefanha-x1.localdomain>
	<VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190204060636.GF29758@stefanha-x1.localdomain>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo>
	<VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190211031725.GB18083@stefanha-x1.localdomain>
	<VI1PR0602MB3245424120D151F29884A7E2A4630@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190220165839.GJ30403@stefanha-x1.localdomain>
	<f168e72e-89fe-cf9b-89ff-3eb820f8a5cf@redhat.com>
In-Reply-To: <f168e72e-89fe-cf9b-89ff-3eb820f8a5cf@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Hi Paolo,

This is Fernando, the one  that reported the issue.
Regarding the dumps I have three of them including guest memory, 2 for virt=
io-scsi, 1 for virtio-blk, in case a comparison may help to confirm which i=
s the proble.) I can upload them to a server you indicate me or I can also =
put them on a server so you can download them as you see fit. Each dump, co=
mpressed, is around 500MB.

If it's more convenient for you I can try to get the requested information =
from gdb. But I will need some guidance since I'm not skilled enough with t=
he debugger.

Another option, if you provide me with the right patch, is for me to patch,=
 rebuild QEMU and repro the problem again. With virtio-scsi I'm able to rep=
ro this in a matter of hours most of the times, with virtio-blk it will tak=
e a couple of days.

Just let me know how do you prefer to move forward.

Thanks a lot for helping with this!

Kind regards,

Fernando

On mi=E9, feb 20, 2019 at 6:53 PM, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
On 20/02/19 17:58, Stefan Hajnoczi wrote:
On Mon, Feb 18, 2019 at 07:21:25AM +0000, Fernando Casas Sch=F6ssow wrote:
It took a few days but last night the problem was reproduced. This is the i=
nformation from the log: vdev 0x55f261d940f0 ("virtio-blk") vq 0x55f261d9ee=
40 (idx 0) inuse 128 vring.num 128 old_shadow_avail_idx 58874 last_avail_id=
x 58625 avail_idx 58874 avail 0x3d87a800 avail_idx (cache bypassed) 58625
Hi Paolo, Are you aware of any recent MemoryRegionCache issues? The avail_i=
dx value 58874 was read via the cache while a non-cached read produces 5862=
5! I suspect that 58625 is correct since the vring is already full and the =
driver wouldn't bump avail_idx any further until requests complete. Fernand=
o also hits this issue with virtio-scsi so it's not a virtio_blk.ko driver =
bug or a virtio-blk device emulation issue.
No, I am not aware of any issues. How can I get the core dump (and the corr=
esponding executable to get the symbols)? Alternatively, it should be enoug=
h to print the vq->vring.caches->avail.mrs from the debugger. Also, one pos=
sibility is to add in vring_avail_idx an assertion like assert(vq->shadow_a=
vaila_idx =3D=3D virtio_lduw_phys(vdev, vq->vring.avail + offsetof(VRingAva=
il, idx))); and try to catch the error earlier. Paolo
A QEMU core dump is available for debugging. Here is the patch that produce=
d this debug output: diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c i=
ndex a1ff647a66..28d89fcbcb 100644 --- a/hw/virtio/virtio.c +++ b/hw/virtio=
/virtio.c @@ -866,6 +866,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)=
 return NULL; } rcu_read_lock(); + uint16_t old_shadow_avail_idx =3D vq->sh=
adow_avail_idx; if (virtio_queue_empty_rcu(vq)) { goto done; } @@ -879,6 +8=
80,12 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz) max =3D vq->vring.nu=
m; if (vq->inuse >=3D vq->vring.num) { + fprintf(stderr, "vdev %p (\"%s\")\=
n", vdev, vdev->name); + fprintf(stderr, "vq %p (idx %u)\n", vq, (unsigned =
int)(vq - vdev->vq)); + fprintf(stderr, "inuse %u vring.num %u\n", vq->inus=
e, vq->vring.num); + fprintf(stderr, "old_shadow_avail_idx %u last_avail_id=
x %u avail_idx %u\n", old_shadow_avail_idx, vq->last_avail_idx, vq->shadow_=
avail_idx); + fprintf(stderr, "avail %#" HWADDR_PRIx " avail_idx (cache byp=
assed) %u\n", vq->vring.avail, virtio_lduw_phys(vdev, vq->vring.avail + off=
setof(VRingAvail, idx))); + fprintf(stderr, "used_idx %u\n", vq->used_idx);=
 + abort(); /* <--- core dump! */ virtio_error(vdev, "Virtqueue size exceed=
ed"); goto done; } Stefan
used_idx 58497 2019-02-18 03:20:08.605+0000: shutting down, reason=3Dcrashe=
d The dump file, including guest memory, was generated successfully (after =
gzip the file is around 492MB). I switched the guest now to virtio-scsi to =
get the information and dump with this setup as well. How should we proceed=
? Thanks.
