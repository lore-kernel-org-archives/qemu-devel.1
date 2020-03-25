Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC0C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C710206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C710206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHLFX-0002vg-34
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 01:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jHLEi-0002Wy-4O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jHLEf-0000SN-ME
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:39:23 -0400
Received: from [192.146.154.243] (port=39587 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jHLEf-0000Rf-Eq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 01:39:21 -0400
Received: from localhost.localdomain.com (unknown [10.40.48.82])
 by mcp01.nutanix.com (Postfix) with ESMTP id C25EF100941C;
 Thu, 26 Mar 2020 05:39:18 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Subject: [PATCH] Refactor vhost_user_set_mem_table functions
Date: Wed, 25 Mar 2020 06:35:06 -0400
Message-Id: <1585132506-13316-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.243
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>, raphael.s.norwitz@gmail.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhost_user_set_mem_table() and vhost_user_set_mem_table_postcopy() have
gotten convoluted, and have some identical code.

This change moves the logic populating the VhostUserMemory struct and
fds array from vhost_user_set_mem_table() and
vhost_user_set_mem_table_postcopy() to a new function,
vhost_user_fill_set_mem_table_msg().

No functionality is impacted.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
---
 hw/virtio/vhost-user.c | 143 +++++++++++++++++++++++--------------------------
 1 file changed, 67 insertions(+), 76 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 08e7e63..ec21e8f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -407,18 +407,79 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     return 0;
 }
 
+static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
+                                             struct vhost_dev *dev,
+                                             VhostUserMsg *msg,
+                                             int *fds, size_t *fd_num,
+                                             bool track_ramblocks)
+{
+    int i, fd;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+    struct vhost_memory_region *reg;
+
+    msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
+
+    for (i = 0; i < dev->mem->nregions; ++i) {
+        reg = dev->mem->regions + i;
+
+        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
+        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
+                                     &offset);
+        fd = memory_region_get_fd(mr);
+        if (fd > 0) {
+            if (track_ramblocks) {
+                assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
+                trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
+                                                      reg->memory_size,
+                                                      reg->guest_phys_addr,
+                                                      reg->userspace_addr,
+                                                      offset);
+                u->region_rb_offset[i] = offset;
+                u->region_rb[i] = mr->ram_block;
+            } else if (*fd_num == VHOST_MEMORY_MAX_NREGIONS) {
+                error_report("Failed preparing vhost-user memory table msg");
+                return -1;
+            }
+            msg->payload.memory.regions[*fd_num].userspace_addr =
+                reg->userspace_addr;
+            msg->payload.memory.regions[*fd_num].memory_size =
+                reg->memory_size;
+            msg->payload.memory.regions[*fd_num].guest_phys_addr =
+                reg->guest_phys_addr;
+            msg->payload.memory.regions[*fd_num].mmap_offset = offset;
+            fds[(*fd_num)++] = fd;
+        } else if (track_ramblocks) {
+            u->region_rb_offset[i] = 0;
+            u->region_rb[i] = NULL;
+        }
+    }
+
+    msg->payload.memory.nregions = *fd_num;
+
+    if (!*fd_num) {
+        error_report("Failed initializing vhost-user memory map, "
+                     "consider using -object memory-backend-file share=on");
+        return -1;
+    }
+
+    msg->hdr.size = sizeof(msg->payload.memory.nregions);
+    msg->hdr.size += sizeof(msg->payload.memory.padding);
+    msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
+
+    return 1;
+}
+
 static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                              struct vhost_memory *mem)
 {
     struct vhost_user *u = dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
-    int i, fd;
     size_t fd_num = 0;
     VhostUserMsg msg_reply;
     int region_i, msg_i;
 
     VhostUserMsg msg = {
-        .hdr.request = VHOST_USER_SET_MEM_TABLE,
         .hdr.flags = VHOST_USER_VERSION,
     };
 
@@ -433,48 +494,11 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
         u->region_rb_len = dev->mem->nregions;
     }
 
-    for (i = 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg = dev->mem->regions + i;
-        ram_addr_t offset;
-        MemoryRegion *mr;
-
-        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
-        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
-                                     &offset);
-        fd = memory_region_get_fd(mr);
-        if (fd > 0) {
-            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
-            trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
-                                                  reg->memory_size,
-                                                  reg->guest_phys_addr,
-                                                  reg->userspace_addr, offset);
-            u->region_rb_offset[i] = offset;
-            u->region_rb[i] = mr->ram_block;
-            msg.payload.memory.regions[fd_num].userspace_addr =
-                reg->userspace_addr;
-            msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
-            msg.payload.memory.regions[fd_num].guest_phys_addr =
-                reg->guest_phys_addr;
-            msg.payload.memory.regions[fd_num].mmap_offset = offset;
-            fds[fd_num++] = fd;
-        } else {
-            u->region_rb_offset[i] = 0;
-            u->region_rb[i] = NULL;
-        }
-    }
-
-    msg.payload.memory.nregions = fd_num;
-
-    if (!fd_num) {
-        error_report("Failed initializing vhost-user memory map, "
-                     "consider using -object memory-backend-file share=on");
+    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
+                                          true) < 0) {
         return -1;
     }
 
-    msg.hdr.size = sizeof(msg.payload.memory.nregions);
-    msg.hdr.size += sizeof(msg.payload.memory.padding);
-    msg.hdr.size += fd_num * sizeof(VhostUserMemoryRegion);
-
     if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
         return -1;
     }
@@ -545,7 +569,6 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
 {
     struct vhost_user *u = dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
-    int i, fd;
     size_t fd_num = 0;
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
@@ -559,7 +582,6 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     }
 
     VhostUserMsg msg = {
-        .hdr.request = VHOST_USER_SET_MEM_TABLE,
         .hdr.flags = VHOST_USER_VERSION,
     };
 
@@ -567,42 +589,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
-    for (i = 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg = dev->mem->regions + i;
-        ram_addr_t offset;
-        MemoryRegion *mr;
-
-        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
-        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
-                                     &offset);
-        fd = memory_region_get_fd(mr);
-        if (fd > 0) {
-            if (fd_num == VHOST_MEMORY_MAX_NREGIONS) {
-                error_report("Failed preparing vhost-user memory table msg");
-                return -1;
-            }
-            msg.payload.memory.regions[fd_num].userspace_addr =
-                reg->userspace_addr;
-            msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
-            msg.payload.memory.regions[fd_num].guest_phys_addr =
-                reg->guest_phys_addr;
-            msg.payload.memory.regions[fd_num].mmap_offset = offset;
-            fds[fd_num++] = fd;
-        }
-    }
-
-    msg.payload.memory.nregions = fd_num;
-
-    if (!fd_num) {
-        error_report("Failed initializing vhost-user memory map, "
-                     "consider using -object memory-backend-file share=on");
+    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
+                                          false) < 0) {
         return -1;
     }
 
-    msg.hdr.size = sizeof(msg.payload.memory.nregions);
-    msg.hdr.size += sizeof(msg.payload.memory.padding);
-    msg.hdr.size += fd_num * sizeof(VhostUserMemoryRegion);
-
     if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
         return -1;
     }
-- 
1.8.3.1


