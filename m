Received: from eggs.gnu.org ([2001:4830:134:3::10]:35554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ecWO6-0000wM-VB
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ecWO4-0004z6-84
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:07:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ecWO3-0004yo-V0
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:07:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 19 Jan 2018 13:06:52 +0000
Message-Id: <20180119130653.24044-2-stefanha@redhat.com>
In-Reply-To: <20180119130653.24044-1-stefanha@redhat.com>
References: <20180119130653.24044-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC 1/2] vhost-user: share the vhost-user protocol
 related structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com, Wei Wang <wei.w.wang@intel.com>

From: Wei Wang <wei.w.wang@intel.com>

Put the vhost-user protocol related data structures to vhost-user.h,
so that they can be used in other implementations (e.g. a slave
implementation).

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 include/hw/virtio/vhost-user.h | 106 +++++++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c         | 100 +-------------------------------------
 2 files changed, 107 insertions(+), 99 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
new file mode 100644
index 0000000000..d76e9ada31
--- /dev/null
+++ b/include/hw/virtio/vhost-user.h
@@ -0,0 +1,106 @@
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
+    VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
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
+    VHOST_USER_SET_SLAVE_REQ_FD = 21,
+    VHOST_USER_IOTLB_MSG = 22,
+    VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_MAX
+} VhostUserRequest;
+
+typedef enum VhostUserSlaveRequest {
+    VHOST_USER_SLAVE_NONE = 0,
+    VHOST_USER_SLAVE_IOTLB_MSG = 1,
+    VHOST_USER_SLAVE_MAX
+}  VhostUserSlaveRequest;
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
+    /* The following payload size */
+    uint32_t size;
+    union {
+#define VHOST_USER_VRING_IDX_MASK   (0xff)
+#define VHOST_USER_VRING_NOFD_MASK  (0x1 << 8)
+        uint64_t u64;
+        struct vhost_vring_state state;
+        struct vhost_vring_addr addr;
+        VhostUserMemory memory;
+        VhostUserLog log;
+        struct vhost_iotlb_msg iotlb;
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
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675ed98..e512f5a463 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
 #include "chardev/char-fe.h"
 #include "sysemu/kvm.h"
@@ -23,105 +24,6 @@
 #include <sys/un.h>
 #include <linux/vhost.h>
 
-#define VHOST_MEMORY_MAX_NREGIONS    8
-#define VHOST_USER_F_PROTOCOL_FEATURES 30
-
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_MQ = 0,
-    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
-    VHOST_USER_PROTOCOL_F_RARP = 2,
-    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
-    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
-    VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
-    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
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
-    VHOST_USER_SET_SLAVE_REQ_FD = 21,
-    VHOST_USER_IOTLB_MSG = 22,
-    VHOST_USER_SET_VRING_ENDIAN = 23,
-    VHOST_USER_MAX
-} VhostUserRequest;
-
-typedef enum VhostUserSlaveRequest {
-    VHOST_USER_SLAVE_NONE = 0,
-    VHOST_USER_SLAVE_IOTLB_MSG = 1,
-    VHOST_USER_SLAVE_MAX
-}  VhostUserSlaveRequest;
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
-        struct vhost_iotlb_msg iotlb;
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
-
 struct vhost_user {
     CharBackend *chr;
     int slave_fd;
-- 
2.14.3
