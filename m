Received: from eggs.gnu.org ([2001:4830:134:3::10]:44782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobbD-0001qj-1G
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobb9-0003BG-HS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:15 -0400
Received: from mail.kernel.org ([198.145.29.136]:45840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cobb9-00038s-Ar
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:11 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 16 Mar 2017 13:01:52 -0700
Message-Id: <1489694518-16978-3-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1489694518-16978-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v3 3/9] 9p: introduce a type for the 9p header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, jgross@suse.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Use the new type in virtio-9p-device.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.h               | 6 ++++++
 hw/9pfs/virtio-9p-device.c | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b7e8362..5312d8a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -119,6 +119,12 @@ static inline char *rpath(FsContext *ctx, const char *path)
 typedef struct V9fsPDU V9fsPDU;
 struct V9fsState;
 
+typedef struct {
+    uint32_t size_le;
+    uint8_t id;
+    uint16_t tag_le;
+} QEMU_PACKED P9MsgHeader;
+
 struct V9fsPDU
 {
     uint32_t size;
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 27a4a32..3782f43 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -46,11 +46,7 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
     VirtQueueElement *elem;
 
     while ((pdu = pdu_alloc(s))) {
-        struct {
-            uint32_t size_le;
-            uint8_t id;
-            uint16_t tag_le;
-        } QEMU_PACKED out;
+        P9MsgHeader out;
 
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
-- 
1.9.1
