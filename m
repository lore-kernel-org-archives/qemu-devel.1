Received: from eggs.gnu.org ([2001:4830:134:3::10]:40618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9W-0004P4-3z
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9L-0005aO-Ai
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9L-0005ZX-2n
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:45:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0havp144807
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:58 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3cbn4ybg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:57 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 18:45:57 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:20 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170920004521.9417-12-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/12] libvhost-user: support resuming
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
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This is the same workaround as commit 523b018dde3b765, which was lost
with libvhost-user transition in commit e10e798c85c2331.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 35480cbfcb73143af66c8de4b444d686a46c2e88)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
 contrib/libvhost-user/libvhost-user.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 35fa0c5e56..d27d6303db 100644
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
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 53ef222c0b..4021f1124e 100644
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
--=20
2.11.0
