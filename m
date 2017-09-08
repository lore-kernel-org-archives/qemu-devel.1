Received: from eggs.gnu.org ([2001:4830:134:3::10]:49167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK85-0006pB-B4
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK83-0005AE-7O
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK83-00059Z-07
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:31 -0400
Date: Fri, 8 Sep 2017 17:19:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-13-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/17] libvhost-user: support resuming
 vq->last_avail_idx based on used_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Jens Freimann <jfreiman@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This is the same workaround as commit 523b018dde3b765, which was lost
with libvhost-user transition in commit e10e798c85c2331.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  7 +++++++
 contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 53ef222..4021f11 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -132,6 +132,7 @@ typedef void (*vu_set_features_cb) (VuDev *dev, uint6=
4_t features);
 typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool star=
ted);
+typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx)=
;
=20
 typedef struct VuDevIface {
     /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
@@ -148,6 +149,12 @@ typedef struct VuDevIface {
     vu_process_msg_cb process_msg;
     /* tells when queues can be processed */
     vu_queue_set_started_cb queue_set_started;
+    /*
+     * If the queue is processed in order, in which case it will be
+     * resumed to vring.used->idx. This can help to support resuming
+     * on unmanaged exit/crash.
+     */
+    vu_queue_is_processed_in_order_cb queue_is_processed_in_order;
 } VuDevIface;
=20
 typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 35fa0c5..d27d630 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -521,6 +521,19 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vms=
g)
=20
     vq->used_idx =3D vq->vring.used->idx;
=20
+    if (vq->last_avail_idx !=3D vq->used_idx) {
+        bool resume =3D dev->iface->queue_is_processed_in_order &&
+            dev->iface->queue_is_processed_in_order(dev, index);
+
+        DPRINT("Last avail index !=3D used index: %u !=3D %u%s\n",
+               vq->last_avail_idx, vq->used_idx,
+               resume ? ", resuming" : "");
+
+        if (resume) {
+            vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->used_idx=
;
+        }
+    }
+
     return false;
 }
=20
--=20
MST
