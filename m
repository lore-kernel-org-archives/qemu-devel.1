Received: from eggs.gnu.org ([2001:4830:134:3::10]:44815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968f-0005Yl-Jt
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968d-0001iG-1M
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:10685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968c-0001gq-NW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:26 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:33 +0800
Message-Id: <1494578148-102868-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 01/16] vhost-user: share the vhost-user
 protocol related structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

Put the vhost-user protocol related data structures to vhost-user.h,
so that they can be used in other implementations (e.g. a slave
implementation).

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-user.c         | 89 +---------------------------------------
 include/hw/virtio/vhost-user.h | 93 ++++++++++++++++++++++++++++++++++++++++++
 include/net/vhost-user.h       |  4 +-
 3 files changed, 96 insertions(+), 90 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9334a8a..d161884 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
 #include "sysemu/char.h"
 #include "sysemu/kvm.h"
@@ -22,94 +23,6 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <linux/vhost.h>
-
-#define VHOST_MEMORY_MAX_NREGIONS    8
-#define VHOST_USER_F_PROTOCOL_FEATURES 30
-
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_MQ = 0,
-    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
-    VHOST_USER_PROTOCOL_F_RARP = 2,
-    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
-    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
-
-    VHOST_USER_PROTOCOL_F_MAX
-};
-
-#define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
-
-typedef enum VhostUserRequest {
-    VHOST_USER_NONE = 0,
-    VHOST_USER_GET_FEATURES = 1,
-    VHOST_USER_SET_FEATURES = 2,
-    VHOST_USER_SET_OWNER = 3,
-    VHOST_USER_RESET_OWNER = 4,
-    VHOST_USER_SET_MEM_TABLE = 5,
-    VHOST_USER_SET_LOG_BASE = 6,
-    VHOST_USER_SET_LOG_FD = 7,
-    VHOST_USER_SET_VRING_NUM = 8,
-    VHOST_USER_SET_VRING_ADDR = 9,
-    VHOST_USER_SET_VRING_BASE = 10,
-    VHOST_USER_GET_VRING_BASE = 11,
-    VHOST_USER_SET_VRING_KICK = 12,
-    VHOST_USER_SET_VRING_CALL = 13,
-    VHOST_USER_SET_VRING_ERR = 14,
-    VHOST_USER_GET_PROTOCOL_FEATURES = 15,
-    VHOST_USER_SET_PROTOCOL_FEATURES = 16,
-    VHOST_USER_GET_QUEUE_NUM = 17,
-    VHOST_USER_SET_VRING_ENABLE = 18,
-    VHOST_USER_SEND_RARP = 19,
-    VHOST_USER_NET_SET_MTU = 20,
-    VHOST_USER_MAX
-} VhostUserRequest;
-
-typedef struct VhostUserMemoryRegion {
-    uint64_t guest_phys_addr;
-    uint64_t memory_size;
-    uint64_t userspace_addr;
-    uint64_t mmap_offset;
-} VhostUserMemoryRegion;
-
-typedef struct VhostUserMemory {
-    uint32_t nregions;
-    uint32_t padding;
-    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
-} VhostUserMemory;
-
-typedef struct VhostUserLog {
-    uint64_t mmap_size;
-    uint64_t mmap_offset;
-} VhostUserLog;
-
-typedef struct VhostUserMsg {
-    VhostUserRequest request;
-
-#define VHOST_USER_VERSION_MASK     (0x3)
-#define VHOST_USER_REPLY_MASK       (0x1<<2)
-#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
-    uint32_t flags;
-    uint32_t size; /* the following payload size */
-    union {
-#define VHOST_USER_VRING_IDX_MASK   (0xff)
-#define VHOST_USER_VRING_NOFD_MASK  (0x1<<8)
-        uint64_t u64;
-        struct vhost_vring_state state;
-        struct vhost_vring_addr addr;
-        VhostUserMemory memory;
-        VhostUserLog log;
-    } payload;
-} QEMU_PACKED VhostUserMsg;
-
-static VhostUserMsg m __attribute__ ((unused));
-#define VHOST_USER_HDR_SIZE (sizeof(m.request) \
-                            + sizeof(m.flags) \
-                            + sizeof(m.size))
-
-#define VHOST_USER_PAYLOAD_SIZE (sizeof(m) - VHOST_USER_HDR_SIZE)
-
-/* The version of the protocol we support */
-#define VHOST_USER_VERSION    (0x1)
 
 static bool ioeventfd_enabled(void)
 {
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
new file mode 100644
index 0000000..766a950
--- /dev/null
+++ b/include/hw/virtio/vhost-user.h
@@ -0,0 +1,93 @@
+#ifndef VHOST_USER_H
+#define VHOST_USER_H
+
+#include <linux/vhost.h>
+
+#define VHOST_MEMORY_MAX_NREGIONS    8
+#define VHOST_USER_F_PROTOCOL_FEATURES 30
+
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_MQ = 0,
+    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
+    VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
+
+    VHOST_USER_PROTOCOL_F_MAX
+};
+
+#define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
+
+typedef enum VhostUserRequest {
+    VHOST_USER_NONE = 0,
+    VHOST_USER_GET_FEATURES = 1,
+    VHOST_USER_SET_FEATURES = 2,
+    VHOST_USER_SET_OWNER = 3,
+    VHOST_USER_RESET_OWNER = 4,
+    VHOST_USER_SET_MEM_TABLE = 5,
+    VHOST_USER_SET_LOG_BASE = 6,
+    VHOST_USER_SET_LOG_FD = 7,
+    VHOST_USER_SET_VRING_NUM = 8,
+    VHOST_USER_SET_VRING_ADDR = 9,
+    VHOST_USER_SET_VRING_BASE = 10,
+    VHOST_USER_GET_VRING_BASE = 11,
+    VHOST_USER_SET_VRING_KICK = 12,
+    VHOST_USER_SET_VRING_CALL = 13,
+    VHOST_USER_SET_VRING_ERR = 14,
+    VHOST_USER_GET_PROTOCOL_FEATURES = 15,
+    VHOST_USER_SET_PROTOCOL_FEATURES = 16,
+    VHOST_USER_GET_QUEUE_NUM = 17,
+    VHOST_USER_SET_VRING_ENABLE = 18,
+    VHOST_USER_SEND_RARP = 19,
+    VHOST_USER_NET_SET_MTU = 20,
+    VHOST_USER_MAX
+} VhostUserRequest;
+
+typedef struct VhostUserMemoryRegion {
+    uint64_t guest_phys_addr;
+    uint64_t memory_size;
+    uint64_t userspace_addr;
+    uint64_t mmap_offset;
+} VhostUserMemoryRegion;
+
+typedef struct VhostUserMemory {
+    uint32_t nregions;
+    uint32_t padding;
+    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+} VhostUserMemory;
+
+typedef struct VhostUserLog {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+} VhostUserLog;
+
+typedef struct VhostUserMsg {
+    VhostUserRequest request;
+
+#define VHOST_USER_VERSION_MASK     (0x3)
+#define VHOST_USER_REPLY_MASK       (0x1 << 2)
+#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
+    uint32_t flags;
+    uint32_t size; /* the following payload size */
+    union {
+#define VHOST_USER_VRING_IDX_MASK   (0xff)
+#define VHOST_USER_VRING_NOFD_MASK  (0x1 << 8)
+        uint64_t u64;
+        struct vhost_vring_state state;
+        struct vhost_vring_addr addr;
+        VhostUserMemory memory;
+        VhostUserLog log;
+    } payload;
+} QEMU_PACKED VhostUserMsg;
+
+static VhostUserMsg m __attribute__ ((unused));
+#define VHOST_USER_HDR_SIZE (sizeof(m.request) \
+                            + sizeof(m.flags) \
+                            + sizeof(m.size))
+
+#define VHOST_USER_PAYLOAD_SIZE (sizeof(m) - VHOST_USER_HDR_SIZE)
+
+/* The version of the protocol we support */
+#define VHOST_USER_VERSION    (0x1)
+
+#endif
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
index 5bcd8a6..d9e328d 100644
--- a/include/net/vhost-user.h
+++ b/include/net/vhost-user.h
@@ -8,8 +8,8 @@
  *
  */
 
-#ifndef VHOST_USER_H
-#define VHOST_USER_H
+#ifndef NET_VHOST_USER_H
+#define NET_VHOST_USER_H
 
 struct vhost_net;
 struct vhost_net *vhost_user_get_vhost_net(NetClientState *nc);
-- 
2.7.4
