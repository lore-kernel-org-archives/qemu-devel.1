Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7039BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAA02072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGa2VyYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAA02072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisiu-0000zn-7R
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLT-0001Ef-3l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60059
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLR-0008Lk-NG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZXfVkfvMOxkFr7etzq2Jsb5bpq8XS+6Xn0EsohfSxk=;
 b=IGa2VyYVI+FMTT4fdXvspmNe22bw2LdwoazCrcdXRfLhJjS/v4tGRI1mRXSkMFq+9m+CMZ
 ijS3FqvqzioNFL5Kz6Y/Mc+3ECEOHlos+/3XhH3E/BUayr2IIbH7FGeD8N9ooX9Vb8DzAG
 vImV6LOqoPSNxLnXKOhZQDlJvy/5quM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-5ov9gF8HP2ymMUI-Tb2msA-1; Wed, 10 Jun 2020 00:28:06 -0400
X-MC-Unique: 5ov9gF8HP2ymMUI-Tb2msA-1
Received: by mail-wm1-f70.google.com with SMTP id x6so86946wmj.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PZXfVkfvMOxkFr7etzq2Jsb5bpq8XS+6Xn0EsohfSxk=;
 b=H1CEjRUs1tDAmSUF8ugbAroHQk/gt5qea0KzTcHKsZ0GhTIiAx72jwUcEkaxK/XLb+
 s4AjAgO3sPkKZaoaRzIUzq4P2FiXC1U8hszEEsGR22G4DvZgLi4lOlzRLljJZQdg1j4+
 KciFee94UEA89gkIbOQVngqbuur23XzSQwb11tIu669G/UibQI8VRsFHrurdgZIiKdje
 Wqxz/SAblakcuTxzdT52iwiSjDMsYqlNDQpjiR8Dg/vKyd8+UPLx+BndAh9xc5Vrzuz6
 dWj72Ww3BENh7rlj+GFjV+xJ+YmXg8PniTHTo8vl3X7zCSPgbiJ2hF3y4qbNQvxd3P37
 wrfQ==
X-Gm-Message-State: AOAM530i6LCIIS4lmof3XdelAgGuwRLR74LWXu0JAJsGVRHDDzY/5Eqg
 3KofNjWjad6K3YxZhpoBf0Hx0Kq9edgfJqGZcD6ggOVvK+kZZpNkkL+SliVrnfSjrfTRWAYA3Kd
 4QJuA3iXqH5Z2pR4=
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr1346215wrs.313.1591763284952; 
 Tue, 09 Jun 2020 21:28:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhA0B/KkCm7/PcbLK9Pd/P0S0Uy2VLxFOuQTi5kfdyUeLopLlXf3uvip2MJcnYTfMIAGA2Zw==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr1346127wrs.313.1591763283741; 
 Tue, 09 Jun 2020 21:28:03 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id d11sm6186064wrm.64.2020.06.09.21.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:03 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/56] Lift max memory slots limit imposed by vhost-user
Message-ID: <20200610042613.1459309-41-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Mike Cui <cui@nutanix.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

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
Message-Id: <1588533678-23450-6-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-user.c      | 56 ++++++++++++++++++++++++-------------
 docs/interop/vhost-user.rst |  7 ++---
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 93584069cd..48b80818fd 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -35,10 +35,28 @@
 #include <linux/userfaultfd.h>
 #endif
 
-#define VHOST_MEMORY_MAX_NREGIONS    8
+#define VHOST_MEMORY_BASELINE_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_SLAVE_MAX_FDS     8
 
+/*
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
 /*
  * Maximum size of virtio device config space
  */
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
 
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 037eefab0e..688b7c6900 100644
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
-- 
MST


