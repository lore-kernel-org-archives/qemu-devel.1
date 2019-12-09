Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 01:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BB42082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 01:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BB42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih26w-0003bv-SO
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 20:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25l-0002Hx-FD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25j-0001Xg-7U
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:56:05 -0500
Received: from [192.146.154.1] (port=43553 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25i-0001WW-VQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:56:03 -0500
Received: from localhost.corp.nutanix.com (unknown [10.40.33.233])
 by mcp01.nutanix.com (Postfix) with ESMTP id 6FBBA1008B6E;
 Tue, 17 Dec 2019 01:56:02 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] Introduce Configurable Number of Memory Slots Exposed
 by vhost-user:
Date: Mon,  9 Dec 2019 02:00:47 -0500
Message-Id: <1575874847-5792-4-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.154.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: raphael.s.norwitz@gmail.com, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current vhost-user implementation in Qemu imposes a limit on the
maximum number of memory slots exposed to a VM using a vhost-user
device. This change provides a new protocol feature
VHOST_USER_F_CONFIGURE_SLOTS which, when enabled, lifts this limit
and allows a VM with a vhost-user device to expose a configurable
number of memory slots, up to the maximum supported by the platform.
Existing backends are unaffected.

This feature works by using three new messages,
VHOST_USER_GET_MAX_MEM_SLOTS, VHOST_USER_ADD_MEM_REG and
VHOST_USER_REM_MEM_REG. VHOST_USER_GET_MAX_MEM_SLOTS gets the
number of memory slots the backend is willing to accept. Then,
when the memory tables are set or updated, a series of
VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG messages are sent
to transmit the regions to map and/or unmap instead of trying to
send all the regions in one fixed size VHOST_USER_SET_MEM_TABLE message.

The vhost_user struct maintains a shadow state of the VM=E2=80=99s memory
regions. When the memory tables are modified, the
vhost_user_set_mem_table() function compares the new device memory state
to the shadow state and only sends regions which need to be unmapped or
mapped in. The regions which must be unmapped are sent first, followed
by the new regions to be mapped in. After all the messages have been sent=
,
the shadow state is set to the current virtual device state.

The current feature implementation does not work with postcopy migration
and cannot be enabled if the VHOST_USER_PROTOCOL_F_REPLY_ACK feature has
also been negotiated.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 docs/interop/vhost-user.rst |  43 ++++++++
 hw/virtio/vhost-user.c      | 251 ++++++++++++++++++++++++++++++++++++++=
++----
 2 files changed, 273 insertions(+), 21 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 7827b71..855a072 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -785,6 +785,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
   #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
   #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
+  #define VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS   13
=20
 Master message types
 --------------------
@@ -1190,6 +1191,48 @@ Master message types
   ancillary data. The GPU protocol is used to inform the master of
   rendering state and updates. See vhost-user-gpu.rst for details.
=20
+``VHOST_USER_GET_MAX_MEM_SLOTS``
+  :id: 34
+  :equivalent ioctl: N/A
+  :slave payload: u64
+
+  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has be=
en
+  successfully negotiated, this message is submitted by master to the
+  slave. The slave should return the message with a u64 payload
+  containing the maximum number of memory slots for QEMU to expose to
+  the guest. This message is not supported with postcopy migration or if
+  the VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiated.
+
+``VHOST_USER_ADD_MEM_REG``
+  :id: 35
+  :equivalent ioctl: N/A
+  :slave payload: memory region
+
+  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has be=
en
+  successfully negotiated, this message is submitted by master to the sl=
ave.
+  The message payload contains a memory region descriptor struct, descri=
bing
+  a region of guest memory which the slave device must map in. When the
+  VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has been succes=
sfully
+  negotiated, along with the VHOST_USER_REM_MEM_REG message, this messag=
e is
+  used to set and update the memory tables of the slave device. This mes=
sage
+  is not supported with postcopy migration or if the
+  VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiated.
+
+``VHOST_USER_REM_MEM_REG``
+  :id: 36
+  :equivalent ioctl: N/A
+  :slave payload: memory region
+
+  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has be=
en
+  successfully negotiated, this message is submitted by master to the sl=
ave.
+  The message payload contains a memory region descriptor struct, descri=
bing
+  a region of guest memory which the slave device must unmap. When the
+  VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has been succes=
sfully
+  negotiated, along with the VHOST_USER_ADD_MEM_REG message, this messag=
e is
+  used to set and update the memory tables of the slave device. This mes=
sage
+  is not supported with postcopy migration or if the
+  VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiated.
+
 Slave message types
 -------------------
=20
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2134e81..3432462 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -35,11 +35,29 @@
 #include <linux/userfaultfd.h>
 #endif
=20
-#define VHOST_MEMORY_MAX_NREGIONS    8
+#define VHOST_MEMORY_LEGACY_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_SLAVE_MAX_FDS     8
=20
 /*
+ * Set maximum number of RAM slots supported to
+ * the maximum number supported by the target
+ * hardware plaform.
+ */
+#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
+    defined(TARGET_ARM) || defined(TARGET_ARM_64)
+#include "hw/acpi/acpi.h"
+#define VHOST_USER_MAX_RAM_SLOTS ACPI_MAX_RAM_SLOTS
+
+#elif defined(TARGET_PPC) || defined(TARGET_PPC_64)
+#include "hw/ppc/spapr.h"
+#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
+
+#else
+#define VHOST_USER_MAX_RAM_SLOTS 512
+#endif
+
+/*
  * Maximum size of virtio device config space
  */
 #define VHOST_USER_MAX_CONFIG_SIZE 256
@@ -58,6 +76,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD =3D 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
+    VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS =3D 13,
     VHOST_USER_PROTOCOL_F_MAX
 };
=20
@@ -98,6 +117,9 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_INFLIGHT_FD =3D 31,
     VHOST_USER_SET_INFLIGHT_FD =3D 32,
     VHOST_USER_GPU_SET_SOCKET =3D 33,
+    VHOST_USER_GET_MAX_MEM_SLOTS =3D 34,
+    VHOST_USER_ADD_MEM_REG =3D 35,
+    VHOST_USER_REM_MEM_REG =3D 36,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -119,9 +141,14 @@ typedef struct VhostUserMemoryRegion {
 typedef struct VhostUserMemory {
     uint32_t nregions;
     uint32_t padding;
-    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+    VhostUserMemoryRegion regions[VHOST_MEMORY_LEGACY_NREGIONS];
 } VhostUserMemory;
=20
+typedef struct VhostUserMemRegMsg {
+    uint32_t padding;
+    VhostUserMemoryRegion region;
+} VhostUserMemRegMsg;
+
 typedef struct VhostUserLog {
     uint64_t mmap_size;
     uint64_t mmap_offset;
@@ -180,6 +207,7 @@ typedef union {
         struct vhost_vring_state state;
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
+        VhostUserMemRegMsg mem_reg;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
@@ -208,7 +236,7 @@ struct vhost_user {
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
-    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
+    uint64_t           postcopy_client_bases[VHOST_USER_MAX_RAM_SLOTS];
     /* Length of the region_rb and region_rb_offset arrays */
     size_t             region_rb_len;
     /* RAMBlock associated with a given region */
@@ -220,6 +248,10 @@ struct vhost_user {
=20
     /* True once we've entered postcopy_listen */
     bool               postcopy_listen;
+
+    /* Our current regions */
+    int num_shadow_regions;
+    VhostUserMemoryRegion shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
 };
=20
 static bool ioeventfd_enabled(void)
@@ -368,7 +400,7 @@ int vhost_user_gpu_set_socket(struct vhost_dev *dev, =
int fd)
 static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
                                    struct vhost_log *log)
 {
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num =3D 0;
     bool shmfd =3D virtio_has_feature(dev->protocol_features,
                                     VHOST_USER_PROTOCOL_F_LOG_SHMFD);
@@ -426,7 +458,7 @@ static int vhost_user_fill_set_mem_table_msg(struct v=
host_user *u,
                                      &offset);
         fd =3D memory_region_get_fd(mr);
         if (fd > 0) {
-            if (*fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
+            if (*fd_num =3D=3D VHOST_MEMORY_LEGACY_NREGIONS) {
                 error_report("Failed preparing vhost-user memory table m=
sg");
                 return -1;
             }
@@ -472,7 +504,7 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
                                              struct vhost_memory *mem)
 {
     struct vhost_user *u =3D dev->opaque;
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_MEMORY_LEGACY_NREGIONS];
     size_t fd_num =3D 0;
     VhostUserMsg msg_reply;
     int region_i, msg_i;
@@ -521,7 +553,7 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
     }
=20
     memset(u->postcopy_client_bases, 0,
-           sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+           sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
=20
     /* They're in the same order as the regions that were sent
      * but some of the regions were skipped (above) if they
@@ -562,18 +594,151 @@ static int vhost_user_set_mem_table_postcopy(struc=
t vhost_dev *dev,
     return 0;
 }
=20
+static inline bool reg_equal(VhostUserMemoryRegion *shadow_reg,
+                             struct vhost_memory_region *vdev_reg)
+{
+    if (shadow_reg->guest_phys_addr =3D=3D vdev_reg->guest_phys_addr &&
+        shadow_reg->userspace_addr =3D=3D vdev_reg->userspace_addr &&
+        shadow_reg->memory_size =3D=3D vdev_reg->memory_size) {
+        return true;
+    } else {
+        return false;
+    }
+}
+
+static int vhost_user_send_add_remove_regions(struct vhost_dev *dev,
+                                              struct vhost_memory *mem,
+                                              VhostUserMsg *msg)
+{
+    struct vhost_user *u =3D dev->opaque;
+    int i, j, fd;
+    bool found[VHOST_USER_MAX_RAM_SLOTS] =3D {};
+    bool matching =3D false;
+    struct vhost_memory_region *reg;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+
+    /*
+     * Ensure the VHOST_USER_PROTOCOL_F_REPLY_ACK has not been
+     * negotiated and no postcopy migration is in progress.
+     */
+    assert(!virtio_has_feature(dev->protocol_features,
+                               VHOST_USER_PROTOCOL_F_REPLY_ACK));
+    if (u->postcopy_listen && u->postcopy_fd.handler) {
+        error_report("Postcopy migration is not supported when the "
+                     "VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS feature "
+                     "has been negotiated");
+        return -1;
+    }
+
+    msg->hdr.size =3D sizeof(msg->payload.mem_reg.padding);
+    msg->hdr.size +=3D sizeof(VhostUserMemoryRegion);
+
+    /*
+     * Send VHOST_USER_REM_MEM_REG for memory regions in our shadow stat=
e
+     * which are not found not in the device's memory state.
+     */
+    for (i =3D 0; i < u->num_shadow_regions; ++i) {
+        reg =3D dev->mem->regions;
+
+        for (j =3D 0; j < dev->mem->nregions; j++) {
+            reg =3D dev->mem->regions + j;
+
+            assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_=
addr);
+            mr =3D memory_region_from_host((void *)(uintptr_t)reg->users=
pace_addr,
+                                         &offset);
+            fd =3D memory_region_get_fd(mr);
+
+            if (reg_equal(&u->shadow_regions[i], reg)) {
+                matching =3D true;
+                found[j] =3D true;
+                break;
+            }
+        }
+
+        if (fd > 0 && !matching) {
+            msg->hdr.request =3D VHOST_USER_REM_MEM_REG;
+            msg->payload.mem_reg.region.userspace_addr =3D reg->userspac=
e_addr;
+            msg->payload.mem_reg.region.memory_size =3D reg->memory_size=
;
+            msg->payload.mem_reg.region.guest_phys_addr =3D
+                reg->guest_phys_addr;
+            msg->payload.mem_reg.region.mmap_offset =3D offset;
+
+            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
+                return -1;
+            }
+        }
+    }
+
+    /*
+     * Send messages to add regions present in the device which are not
+     * in our shadow state.
+     */
+    for (i =3D 0; i < dev->mem->nregions; ++i) {
+        reg =3D dev->mem->regions + i;
+
+        /*
+         * If the region was in both the shadow and vdev state we don't
+         * need to send a VHOST_USER_ADD_MEM_REG message for it.
+         */
+        if (found[i]) {
+            continue;
+        }
+
+        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
+        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace=
_addr,
+                                     &offset);
+        fd =3D memory_region_get_fd(mr);
+
+        if (fd > 0) {
+            msg->hdr.request =3D VHOST_USER_ADD_MEM_REG;
+            msg->payload.mem_reg.region.userspace_addr =3D reg->userspac=
e_addr;
+            msg->payload.mem_reg.region.memory_size =3D reg->memory_size=
;
+            msg->payload.mem_reg.region.guest_phys_addr =3D
+                reg->guest_phys_addr;
+            msg->payload.mem_reg.region.mmap_offset =3D offset;
+
+            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
+                return -1;
+            }
+        }
+    }
+
+    /* Make our shadow state match the updated device state. */
+    u->num_shadow_regions =3D dev->mem->nregions;
+    for (i =3D 0; i < dev->mem->nregions; ++i) {
+        reg =3D dev->mem->regions + i;
+        u->shadow_regions[i].guest_phys_addr =3D reg->guest_phys_addr;
+        u->shadow_regions[i].userspace_addr =3D reg->userspace_addr;
+        u->shadow_regions[i].memory_size =3D reg->memory_size;
+    }
+
+    return 0;
+}
+
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
     struct vhost_user *u =3D dev->opaque;
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_MEMORY_LEGACY_NREGIONS];
     size_t fd_num =3D 0;
     bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported =3D virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
+    bool config_slots =3D
+        virtio_has_feature(dev->protocol_features,
+                           VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS);
=20
     if (do_postcopy) {
-        /* Postcopy has enough differences that it's best done in it's o=
wn
+        if (config_slots) {
+            error_report("Postcopy migration not supported with "
+                          "VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS feature=
 "
+                          "enabled.");
+            return -1;
+        }
+
+        /*
+         * Postcopy has enough differences that it's best done in it's o=
wn
          * version
          */
         return vhost_user_set_mem_table_postcopy(dev, mem);
@@ -587,17 +752,22 @@ static int vhost_user_set_mem_table(struct vhost_de=
v *dev,
         msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
     }
=20
-    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
-                                          false) < 0) {
-        return -1;
-    }
-
-    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
-        return -1;
-    }
+    if (config_slots && !reply_supported) {
+        if (vhost_user_send_add_remove_regions(dev, mem, &msg) < 0) {
+            return -1;
+        }
+    } else {
+        if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num=
,
+                                              false) < 0) {
+            return -1;
+        }
+        if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
+            return -1;
+        }
=20
-    if (reply_supported) {
-        return process_message_reply(dev, &msg);
+        if (reply_supported) {
+            return process_message_reply(dev, &msg);
+        }
     }
=20
     return 0;
@@ -762,7 +932,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev=
,
                                 VhostUserRequest request,
                                 struct vhost_vring_file *file)
 {
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num =3D 0;
     VhostUserMsg msg =3D {
         .hdr.request =3D request,
@@ -1496,7 +1666,46 @@ static int vhost_user_get_vq_index(struct vhost_de=
v *dev, int idx)
=20
 static int vhost_user_memslots_limit(struct vhost_dev *dev)
 {
-    return VHOST_MEMORY_MAX_NREGIONS;
+    VhostUserMsg msg =3D {
+        .hdr.request =3D VHOST_USER_GET_MAX_MEM_SLOTS,
+        .hdr.flags =3D VHOST_USER_VERSION,
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS)) {
+        return VHOST_MEMORY_LEGACY_NREGIONS;
+    }
+
+    if (virtio_has_feature(dev->protocol_features,
+                           VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
+        error_report("The VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol=
 "
+                     "feature is not supported when the "
+                     "VHOST_USER_PROTOCOL_F_REPLY_ACK features has also =
"
+                     "been negotiated");
+        return -1;
+    }
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    if (vhost_user_read(dev, &msg) < 0) {
+        return -1;
+    }
+
+    if (msg.hdr.request !=3D VHOST_USER_GET_MAX_MEM_SLOTS) {
+        error_report("Received unexpected msg type. Expected %d received=
 %d",
+                     VHOST_USER_GET_MAX_MEM_SLOTS, msg.hdr.request);
+        return -1;
+    }
+
+    if (msg.hdr.size !=3D sizeof(msg.payload.u64)) {
+        error_report("Received bad msg size");
+        return -1;
+    }
+
+    return MIN(MAX(msg.payload.u64, VHOST_MEMORY_LEGACY_NREGIONS),
+               VHOST_USER_MAX_RAM_SLOTS);
 }
=20
 static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
--=20
1.8.3.1


