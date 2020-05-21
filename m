Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FF7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC74C20721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="Pp6N4gFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC74C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbdOb-0002nu-TE
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdJz-0003KF-Me
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:44 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:28555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdJy-0001Gj-Gx
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=1gT8UANEjY26OpRqhyqDy/W0PyLouFTI8A05goPKUko=;
 b=Pp6N4gFSKNFrYaBRfKLXcuY1y+EaC5eJE7DRb5GRy9ka62d1rKQ91F/mvpqwYpRBVXao
 6bl/BS1m5CaV3w5Yzn+9ElwsCaMyllHF20JRxMqYLUHcCadUG+ywJf0notCf/5Gcnar48l
 PJkc8Vqe6VpTPfH+jg8GTOpdtV34UTaOs=
Received: by filterdrecv-p3iad2-8ddf98858-w5zgs with SMTP id
 filterdrecv-p3iad2-8ddf98858-w5zgs-17-5EC60AF8-92
 2020-05-21 05:00:40.516925812 +0000 UTC m=+4852394.811253408
Received: from localhost.localdomain.com (unknown)
 by ismtpd0026p1las1.sendgrid.net (SG) with ESMTP
 id p5IHhxkhQSG-k2Y6vHr4Rg Thu, 21 May 2020 05:00:40.319 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v4 05/10] Lift max memory slots limit imposed by vhost-user
Date: Thu, 21 May 2020 05:00:40 +0000 (UTC)
Message-Id: <1588533678-23450-6-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zcHs6ANfyz+yj7wQh?=
 =?us-ascii?Q?8uN2B2Wv9Rj8vSG31+Kau6EBCR0zg27Ee0wWyHx?=
 =?us-ascii?Q?XxKtnyh=2FxRuUXSytKpyNJKwm00jGRjRJKNfntTm?=
 =?us-ascii?Q?AB=2FoJLcq3TJlfI1EbQobKe3r0HgH9aeExKIGIj0?=
 =?us-ascii?Q?kguJ4ufyrvYyXuAclt=2FNt6fLKt9DAb+ULzvrDxT?=
 =?us-ascii?Q?KBU6aIgBmEBDOgxdS9xDw=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:00:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 marcandre.lureau@gmail.com, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Historically, sending all memory regions to vhost-user backends in a
single message imposed a limitation on the number of times memory
could be hot-added to a VM with a vhost-user device. Now that backends
which support the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS send memory
regions individually, we no longer need to impose this limitation on
devices which support this feature.

With this change, VMs with a vhost-user device which supports the
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS can support a configurable
number of memory slots, up to the maximum allowed by the target
platform.

Existing backends which do not support
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are unaffected.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
Suggested-by: Mike Cui <cui@nutanix.com>
---
 docs/interop/vhost-user.rst |  7 +++---
 hw/virtio/vhost-user.c      | 56 ++++++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 037eefa..688b7c6 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1273,10 +1273,9 @@ Master message types
   feature has been successfully negotiated, this message is submitted
   by master to the slave. The slave should return the message with a
   u64 payload containing the maximum number of memory slots for
-  QEMU to expose to the guest. At this point, the value returned
-  by the backend will be capped at the maximum number of ram slots
-  which can be supported by vhost-user. Currently that limit is set
-  at VHOST_USER_MAX_RAM_SLOTS = 8.
+  QEMU to expose to the guest. The value returned by the backend
+  will be capped at the maximum number of ram slots which can be
+  supported by the target platform.
 
 ``VHOST_USER_ADD_MEM_REG``
   :id: 37
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9358406..48b8081 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -35,11 +35,29 @@
 #include <linux/userfaultfd.h>
 #endif
 
-#define VHOST_MEMORY_MAX_NREGIONS    8
+#define VHOST_MEMORY_BASELINE_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_SLAVE_MAX_FDS     8
 
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
@@ -127,7 +145,7 @@ typedef struct VhostUserMemoryRegion {
 typedef struct VhostUserMemory {
     uint32_t nregions;
     uint32_t padding;
-    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+    VhostUserMemoryRegion regions[VHOST_MEMORY_BASELINE_NREGIONS];
 } VhostUserMemory;
 
 typedef struct VhostUserMemRegMsg {
@@ -222,7 +240,7 @@ struct vhost_user {
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
-    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
+    uint64_t           postcopy_client_bases[VHOST_USER_MAX_RAM_SLOTS];
     /* Length of the region_rb and region_rb_offset arrays */
     size_t             region_rb_len;
     /* RAMBlock associated with a given region */
@@ -237,7 +255,7 @@ struct vhost_user {
 
     /* Our current regions */
     int num_shadow_regions;
-    struct vhost_memory_region shadow_regions[VHOST_MEMORY_MAX_NREGIONS];
+    struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
 };
 
 struct scrub_regions {
@@ -392,7 +410,7 @@ int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd)
 static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
                                    struct vhost_log *log)
 {
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
     bool shmfd = virtio_has_feature(dev->protocol_features,
                                     VHOST_USER_PROTOCOL_F_LOG_SHMFD);
@@ -470,7 +488,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
         mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
         if (fd > 0) {
             if (track_ramblocks) {
-                assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
+                assert(*fd_num < VHOST_MEMORY_BASELINE_NREGIONS);
                 trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
                                                       reg->memory_size,
                                                       reg->guest_phys_addr,
@@ -478,7 +496,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                                                       offset);
                 u->region_rb_offset[i] = offset;
                 u->region_rb[i] = mr->ram_block;
-            } else if (*fd_num == VHOST_MEMORY_MAX_NREGIONS) {
+            } else if (*fd_num == VHOST_MEMORY_BASELINE_NREGIONS) {
                 error_report("Failed preparing vhost-user memory table msg");
                 return -1;
             }
@@ -523,7 +541,7 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
                                  bool track_ramblocks)
 {
     struct vhost_user *u = dev->opaque;
-    bool found[VHOST_MEMORY_MAX_NREGIONS] = {};
+    bool found[VHOST_USER_MAX_RAM_SLOTS] = {};
     struct vhost_memory_region *reg, *shadow_reg;
     int i, j, fd, add_idx = 0, rm_idx = 0, fd_num = 0;
     ram_addr_t offset;
@@ -777,9 +795,9 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
                                          bool track_ramblocks)
 {
     struct vhost_user *u = dev->opaque;
-    struct scrub_regions add_reg[VHOST_MEMORY_MAX_NREGIONS];
-    struct scrub_regions rem_reg[VHOST_MEMORY_MAX_NREGIONS];
-    uint64_t shadow_pcb[VHOST_MEMORY_MAX_NREGIONS] = {};
+    struct scrub_regions add_reg[VHOST_USER_MAX_RAM_SLOTS];
+    struct scrub_regions rem_reg[VHOST_USER_MAX_RAM_SLOTS];
+    uint64_t shadow_pcb[VHOST_USER_MAX_RAM_SLOTS] = {};
     int nr_add_reg, nr_rem_reg;
 
     msg->hdr.size = sizeof(msg->payload.mem_reg.padding) +
@@ -803,7 +821,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
 
     if (track_ramblocks) {
         memcpy(u->postcopy_client_bases, shadow_pcb,
-               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
         /*
          * Now we've registered this with the postcopy code, we ack to the
          * client, because now we're in the position to be able to deal with
@@ -823,7 +841,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
 err:
     if (track_ramblocks) {
         memcpy(u->postcopy_client_bases, shadow_pcb,
-               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
     }
 
     return -1;
@@ -835,7 +853,7 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                              bool config_mem_slots)
 {
     struct vhost_user *u = dev->opaque;
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     VhostUserMsg msg_reply;
     int region_i, msg_i;
@@ -893,7 +911,7 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
         }
 
         memset(u->postcopy_client_bases, 0,
-               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
 
         /*
          * They're in the same order as the regions that were sent
@@ -942,7 +960,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
     struct vhost_user *u = dev->opaque;
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
@@ -1149,7 +1167,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
                                 VhostUserRequest request,
                                 struct vhost_vring_file *file)
 {
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
     VhostUserMsg msg = {
         .hdr.request = request,
@@ -1845,7 +1863,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
         /* get max memory regions if backend supports configurable RAM slots */
         if (!virtio_has_feature(dev->protocol_features,
                                 VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
-            u->user->memory_slots = VHOST_MEMORY_MAX_NREGIONS;
+            u->user->memory_slots = VHOST_MEMORY_BASELINE_NREGIONS;
         } else {
             err = vhost_user_get_max_memslots(dev, &ram_slots);
             if (err < 0) {
@@ -1860,7 +1878,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
                 return -1;
             }
 
-            u->user->memory_slots = MIN(ram_slots, VHOST_MEMORY_MAX_NREGIONS);
+            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
         }
     }
 
-- 
1.8.3.1


