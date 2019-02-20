Received: from eggs.gnu.org ([209.51.188.92]:36948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwVD5-0005wb-R9
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwVD4-0006yo-Pe
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:59:03 -0500
Date: Wed, 20 Feb 2019 16:58:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220165839.GJ30403@stefanha-x1.localdomain>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P6YfpwaDcfcOCJkJ"
Content-Disposition: inline
In-Reply-To: <VI1PR0602MB3245424120D151F29884A7E2A4630@VI1PR0602MB3245.eurprd06.prod.outlook.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@outlook.com>


--P6YfpwaDcfcOCJkJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 07:21:25AM +0000, Fernando Casas Sch=F6ssow wrote:
> It took a few days but last night the problem was reproduced.
> This is the information from the log:
>=20
> vdev 0x55f261d940f0 ("virtio-blk")
> vq 0x55f261d9ee40 (idx 0)
> inuse 128 vring.num 128
> old_shadow_avail_idx 58874 last_avail_idx 58625 avail_idx 58874
> avail 0x3d87a800 avail_idx (cache bypassed) 58625

Hi Paolo,
Are you aware of any recent MemoryRegionCache issues?  The avail_idx
value 58874 was read via the cache while a non-cached read produces
58625!

I suspect that 58625 is correct since the vring is already full and the
driver wouldn't bump avail_idx any further until requests complete.

Fernando also hits this issue with virtio-scsi so it's not a
virtio_blk.ko driver bug or a virtio-blk device emulation issue.

A QEMU core dump is available for debugging.

Here is the patch that produced this debug output:
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a1ff647a66..28d89fcbcb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -866,6 +866,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
         return NULL;
     }
     rcu_read_lock();
+    uint16_t old_shadow_avail_idx =3D vq->shadow_avail_idx;
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
     }
@@ -879,6 +880,12 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     max =3D vq->vring.num;

     if (vq->inuse >=3D vq->vring.num) {
+        fprintf(stderr, "vdev %p (\"%s\")\n", vdev, vdev->name);
+        fprintf(stderr, "vq %p (idx %u)\n", vq, (unsigned int)(vq - vdev->=
vq));
+        fprintf(stderr, "inuse %u vring.num %u\n", vq->inuse, vq->vring.nu=
m);
+        fprintf(stderr, "old_shadow_avail_idx %u last_avail_idx %u avail_i=
dx %u\n", old_shadow_avail_idx, vq->last_avail_idx, vq->shadow_avail_idx);
+        fprintf(stderr, "avail %#" HWADDR_PRIx " avail_idx (cache bypassed=
) %u\n", vq->vring.avail, virtio_lduw_phys(vdev, vq->vring.avail + offsetof=
(VRingAvail, idx)));
+        fprintf(stderr, "used_idx %u\n", vq->used_idx);
+        abort(); /* <--- core dump! */
         virtio_error(vdev, "Virtqueue size exceeded");
         goto done;
     }

Stefan

> used_idx 58497
> 2019-02-18 03:20:08.605+0000: shutting down, reason=3Dcrashed
>=20
> The dump file, including guest memory, was generated successfully (after =
gzip the file is around 492MB).
> I switched the guest now to virtio-scsi to get the information and dump w=
ith this setup as well.
>=20
> How should we proceed?
>=20
> Thanks.
>=20
> On lun, feb 11, 2019 at 4:17 AM, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> Thanks for collecting the data! The fact that both virtio-blk and virtio-=
scsi failed suggests it's not a virtqueue element leak in the virtio-blk or=
 virtio-scsi device emulation code. The hung task error messages from insid=
e the guest are a consequence of QEMU hitting the "Virtqueue size exceeded"=
 error. QEMU refuses to process further requests after the error, causing t=
asks inside the guest to get stuck on I/O. I don't have a good theory regar=
ding the root cause. Two ideas: 1. The guest is corrupting the vring or sub=
mitting more requests than will fit into the ring. Somewhat unlikely becaus=
e it happens with both Windows and Linux guests. 2. QEMU's virtqueue code i=
s buggy, maybe the memory region cache which is used for fast guest RAM acc=
esses. Here is an expanded version of the debug patch which might help iden=
tify which of these scenarios is likely. Sorry, it requires running the gue=
st again! This time let's make QEMU dump core so both QEMU state and guest =
RAM are captured for further debugging. That way it will be possible to ext=
ract more information using gdb without rerunning. Stefan --- diff --git a/=
hw/virtio/virtio.c b/hw/virtio/virtio.c index a1ff647a66..28d89fcbcb 100644=
 --- a/hw/virtio/virtio.c +++ b/hw/virtio/virtio.c @@ -866,6 +866,7 @@ void=
 *virtqueue_pop(VirtQueue *vq, size_t sz) return NULL; } rcu_read_lock(); +=
 uint16_t old_shadow_avail_idx =3D vq->shadow_avail_idx; if (virtio_queue_e=
mpty_rcu(vq)) { goto done; } @@ -879,6 +880,12 @@ void *virtqueue_pop(VirtQ=
ueue *vq, size_t sz) max =3D vq->vring.num; if (vq->inuse >=3D vq->vring.nu=
m) { + fprintf(stderr, "vdev %p (\"%s\")\n", vdev, vdev->name); + fprintf(s=
tderr, "vq %p (idx %u)\n", vq, (unsigned int)(vq - vdev->vq)); + fprintf(st=
derr, "inuse %u vring.num %u\n", vq->inuse, vq->vring.num); + fprintf(stder=
r, "old_shadow_avail_idx %u last_avail_idx %u avail_idx %u\n", old_shadow_a=
vail_idx, vq->last_avail_idx, vq->shadow_avail_idx); + fprintf(stderr, "ava=
il %#" HWADDR_PRIx " avail_idx (cache bypassed) %u\n", vq->vring.avail, vir=
tio_lduw_phys(vdev, vq->vring.avail + offsetof(VRingAvail, idx))); + fprint=
f(stderr, "used_idx %u\n", vq->used_idx); + abort(); /* <--- core dump! */ =
virtio_error(vdev, "Virtqueue size exceeded"); goto done; }
>=20
>=20

--P6YfpwaDcfcOCJkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbYc/AAoJEJykq7OBq3PIeB0H/05VXDkkLxwq0fS4WlUKRHZp
W0yccG5QIEgAraYCXFn/Z6uml7EqHFVzaPcRWqEo+a82q7M9B2p6mP57SYNXENX5
Zh3pCdPnck0ZzBa8tMNjPSENB+XY/KccKLshdT355lL6sBe1vyDz7JEPI9Yjmp+1
QZWlXJ/eukg6NrDEZdGtER2Wsc4edmh1cjdF7BeyKKy/p7P6VFEXTgUVSOWCeEur
XAcxpVZcNiGyFjTb+7p6f6t3776MRjTk6xv/kBGFEZv+TEJLyc3Utl1DeMLj684t
OIlXQPQN/UToNuSpf9knDe37t7GbGGde6DItd6xnLJyFvZtAcZXQHWpTar2YEOg=
=Knjk
-----END PGP SIGNATURE-----

--P6YfpwaDcfcOCJkJ--
