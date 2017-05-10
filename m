Received: from eggs.gnu.org ([2001:4830:134:3::10]:45002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8WyM-0005aH-GA
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8WyI-0004k6-DZ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d8WyI-0004k0-4D
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:26 -0400
Date: Wed, 10 May 2017 22:08:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1494443192-17177-5-git-send-email-mst@redhat.com>
References: <1494443192-17177-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1494443192-17177-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/9] libvhost-user: fix crash when rings aren't
 ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Felipe Franciosi <felipe@nutanix.com>, Eric Blake <eblake@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Calling libvhost-user functions like vu_queue_get_avail_bytes() when the
queue doesn't yet have addresses will result in the crashes like the
following:

Program received signal SIGSEGV, Segmentation fault.
0x000055c414112ce4 in vring_avail_idx (vq=3D0x55c41582fd68, vq=3D0x55c415=
82fd68)
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
940            vq->shadow_avail_idx =3D vq->vring.avail->idx;
(gdb) p vq
$1 =3D (VuVirtq *) 0x55c41582fd68
(gdb) p vq->vring
$2 =3D {num =3D 0, desc =3D 0x0, avail =3D 0x0, used =3D 0x0, log_guest_a=
ddr =3D 0, flags =3D 0}

    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
No locals.
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:960
        num_heads =3D <optimized out>
    out_bytes=3Dout_bytes@entry=3D0x7fffd035d7c4, max_in_bytes=3Dmax_in_b=
ytes@entry=3D0,
    max_out_bytes=3Dmax_out_bytes@entry=3D0) at /home/dgilbert/git/qemu/c=
ontrib/libvhost-user/libvhost-user.c:1034

Add a pre-condition checks on vring.avail before accessing it.

Fix documentation and return type of vu_queue_empty() while at it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  6 +++---
 contrib/libvhost-user/libvhost-user.c | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 156b50e..af02a31 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -327,13 +327,13 @@ void vu_queue_set_notification(VuDev *dev, VuVirtq =
*vq, int enable);
 bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
=20
 /**
- * vu_queue_enabled:
+ * vu_queue_empty:
  * @dev: a VuDev context
  * @vq: a VuVirtq queue
  *
- * Returns: whether the queue is empty.
+ * Returns: true if the queue is empty or not ready.
  */
-int vu_queue_empty(VuDev *dev, VuVirtq *vq);
+bool vu_queue_empty(VuDev *dev, VuVirtq *vq);
=20
 /**
  * vu_queue_notify:
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 61e1657..9efb9da 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1031,6 +1031,11 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, =
unsigned int *in_bytes,
     idx =3D vq->last_avail_idx;
=20
     total_bufs =3D in_total =3D out_total =3D 0;
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        goto done;
+    }
+
     while ((rc =3D virtqueue_num_heads(dev, vq, idx)) > 0) {
         unsigned int max, num_bufs, indirect =3D 0;
         struct vring_desc *desc;
@@ -1121,11 +1126,16 @@ vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, uns=
igned int in_bytes,
=20
 /* Fetch avail_idx from VQ memory only when we really need to know if
  * guest has added some buffers. */
-int
+bool
 vu_queue_empty(VuDev *dev, VuVirtq *vq)
 {
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        return true;
+    }
+
     if (vq->shadow_avail_idx !=3D vq->last_avail_idx) {
-        return 0;
+        return false;
     }
=20
     return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
@@ -1174,7 +1184,8 @@ vring_notify(VuDev *dev, VuVirtq *vq)
 void
 vu_queue_notify(VuDev *dev, VuVirtq *vq)
 {
-    if (unlikely(dev->broken)) {
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
         return;
     }
=20
@@ -1291,7 +1302,8 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
     struct vring_desc *desc;
     int rc;
=20
-    if (unlikely(dev->broken)) {
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
         return NULL;
     }
=20
@@ -1445,7 +1457,8 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
 {
     struct vring_used_elem uelem;
=20
-    if (unlikely(dev->broken)) {
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
         return;
     }
=20
@@ -1474,7 +1487,8 @@ vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned in=
t count)
 {
     uint16_t old, new;
=20
-    if (unlikely(dev->broken)) {
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
         return;
     }
=20
--=20
MST
