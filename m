Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D4320825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="xSeisfZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D4320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1Ly-0003Gn-CN
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1JW-0008VD-RW
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:44 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:46099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1JT-00035k-Fr
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=i0Twq+cLmun0AL87TLF4mDFKdDwGhNZq/HRRt7ALzsI=;
 b=xSeisfZHsaoj5Hx4HvnAUbmQN4cQCXfZ+rmvu+OD9Xrk0zyOSRiNI4wCF6Q17jIh5uM1
 CHWxBK9uWhUN5BKmIFGRAEicQPHfv6TRyG/l6XX4m7OkuBgccFC+IyWJy2uHJO+4D/Z5T2
 9vJDVKju0cO57jyDyptUbvysLQhpgqeIQ=
Received: by filterdrecv-p3iad2-8ddf98858-szfkb with SMTP id
 filterdrecv-p3iad2-8ddf98858-szfkb-20-5EC3D040-77
 2020-05-19 12:25:37.007463432 +0000 UTC m=+4706285.824587008
Received: from localhost.localdomain.com (unknown)
 by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP
 id nqOupbdiSEyD2eX35KzFyw Tue, 19 May 2020 12:25:36.751 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v3 05/10] Lift max memory slots limit imposed by vhost-user
Date: Tue, 19 May 2020 12:25:37 +0000 (UTC)
Message-Id: <1588473683-27067-6-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zfb9oaW8Dn6ChLkDu?=
 =?us-ascii?Q?Ff6vD766A4JqCMd+JugyKPxO7KypFYsp1RqPXzW?=
 =?us-ascii?Q?a7lBu0P1bVtWg9NQfoxmt4YaetEOiebleSNKL8V?=
 =?us-ascii?Q?u9Eat9C+IvLpCXxYiH+3GAZ6DJrfPc+SOgXmsBP?=
 =?us-ascii?Q?hSzeYp+1lglInhr40nNusXJ=2FhWs8ZurvVTK2rNs?=
 =?us-ascii?Q?PMBWa3mSCYlWPh3wYPYNw=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 08:25:15
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
index 4af8476..270a96d 100644
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
@@ -469,7 +487,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
         mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
         if (fd > 0) {
             if (track_ramblocks) {
-                assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
+                assert(*fd_num < VHOST_MEMORY_BASELINE_NREGIONS);
                 trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
                                                       reg->memory_size,
                                                       reg->guest_phys_addr,
@@ -477,7 +495,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                                                       offset);
                 u->region_rb_offset[i] = offset;
                 u->region_rb[i] = mr->ram_block;
-            } else if (*fd_num == VHOST_MEMORY_MAX_NREGIONS) {
+            } else if (*fd_num == VHOST_MEMORY_BASELINE_NREGIONS) {
                 error_report("Failed preparing vhost-user memory table msg");
                 return -1;
             }
@@ -522,7 +540,7 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
                                  bool track_ramblocks)
 {
     struct vhost_user *u = dev->opaque;
-    bool found[VHOST_MEMORY_MAX_NREGIONS] = {};
+    bool found[VHOST_USER_MAX_RAM_SLOTS] = {};
     struct vhost_memory_region *reg, *shadow_reg;
     int i, j, fd, add_idx = 0, rm_idx = 0, fd_num = 0;
     ram_addr_t offset;
@@ -773,9 +791,9 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
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
@@ -799,7 +817,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
 
     if (track_ramblocks) {
         memcpy(u->postcopy_client_bases, shadow_pcb,
-               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
         /*
          * Now we've registered this with the postcopy code, we ack to the
          * client, because now we're in the position to be able to deal with
@@ -819,7 +837,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
 err:
     if (track_ramblocks) {
         memcpy(u->postcopy_client_bases, shadow_pcb,
-               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
     }
 
     return -1;
@@ -831,7 +849,7 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                              bool config_mem_slots)
 {
     struct vhost_user *u = dev->opaque;
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     VhostUserMsg msg_reply;
     int region_i, msg_i;
@@ -889,7 +907,7 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
         }
 
         memset(u->postcopy_client_bases, 0,
-               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
 
         /*
          * They're in the same order as the regions that were sent
@@ -938,7 +956,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
     struct vhost_user *u = dev->opaque;
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
@@ -1145,7 +1163,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
                                 VhostUserRequest request,
                                 struct vhost_vring_file *file)
 {
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
     VhostUserMsg msg = {
         .hdr.request = request,
@@ -1841,7 +1859,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
         /* get max memory regions if backend supports configurable RAM slots */
         if (!virtio_has_feature(dev->protocol_features,
                                 VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
-            u->user->memory_slots = VHOST_MEMORY_MAX_NREGIONS;
+            u->user->memory_slots = VHOST_MEMORY_BASELINE_NREGIONS;
         } else {
             err = vhost_user_get_max_memslots(dev, &ram_slots);
             if (err < 0) {
@@ -1856,7 +1874,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
                 return -1;
             }
 
-            u->user->memory_slots = MIN(ram_slots, VHOST_MEMORY_MAX_NREGIONS);
+            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
         }
     }
 
-- 
1.8.3.1


