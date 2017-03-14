Received: from eggs.gnu.org ([2001:4830:134:3::10]:45310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnoV1-0000ZO-MS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnoUz-0001SQ-Mk
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cnoUz-0001S2-HG
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:33 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A41BBC04B945
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 15:36:33 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 23:36:25 +0800
Message-Id: <20170314153626.16989-2-famz@redhat.com>
In-Reply-To: <20170314153626.16989-1-famz@redhat.com>
References: <20170314153626.16989-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] virtio-scsi: Make
 virtio_scsi_acquire/release public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

They will be used in virtio-scsi-dataplane.c as well, so move them to
header.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/virtio-scsi.c           | 14 --------------
 include/hw/virtio/virtio-scsi.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 1dbc4bc..e7466d3 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -422,20 +422,6 @@ static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
     }
 }
 
-static inline void virtio_scsi_acquire(VirtIOSCSI *s)
-{
-    if (s->ctx) {
-        aio_context_acquire(s->ctx);
-    }
-}
-
-static inline void virtio_scsi_release(VirtIOSCSI *s)
-{
-    if (s->ctx) {
-        aio_context_release(s->ctx);
-    }
-}
-
 bool virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req;
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index f536f77..8ae0aca 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -121,6 +121,20 @@ typedef struct VirtIOSCSIReq {
     } req;
 } VirtIOSCSIReq;
 
+static inline void virtio_scsi_acquire(VirtIOSCSI *s)
+{
+    if (s->ctx) {
+        aio_context_acquire(s->ctx);
+    }
+}
+
+static inline void virtio_scsi_release(VirtIOSCSI *s)
+{
+    if (s->ctx) {
+        aio_context_release(s->ctx);
+    }
+}
+
 void virtio_scsi_common_realize(DeviceState *dev, Error **errp,
                                 VirtIOHandleOutput ctrl, VirtIOHandleOutput evt,
                                 VirtIOHandleOutput cmd);
-- 
2.9.3
