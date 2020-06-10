Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373D12072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbuDMb09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373D12072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jismC-0006t2-Cj
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLQ-00019g-Uu
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLO-0008Lb-Tv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jo4M6y52NHBwYNFBR907mvAIWzd7q/B/wHGfD+ayKdg=;
 b=YbuDMb097bfHFSpN0alqt3U+kEwfgiekt5FIpQjyglGDyNiarDYt/MUhqLkfPMOSbrv8s0
 z/ZI5Jyx4l0yBoqquiySiogUylvO1VI6vXsb78yC/64tSEmSUfKh1VMK9Mld5SgraqDj0e
 lt8G4joO1cPYg/03/3sXFhQpPg9sqEw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-bcqZQNcCNM2ezt6gJ9Oxcw-1; Wed, 10 Jun 2020 00:28:04 -0400
X-MC-Unique: bcqZQNcCNM2ezt6gJ9Oxcw-1
Received: by mail-wr1-f70.google.com with SMTP id w4so506718wrl.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jo4M6y52NHBwYNFBR907mvAIWzd7q/B/wHGfD+ayKdg=;
 b=UZoATHKrQAflvXBIZpE/dEhupRf3ufS8MizTsTngZRpVh3GBAigwgfJBkMBhfH7E9g
 UmJt1ww6jxTT/2/7bMb539kGvHvCBDidY5wOTpwX6BE9o7YKkEuQxeLQv3j6A23USqZy
 mnySg/ztXotDUv1xMC45Dk9lqwgUatPiBCR0kUrIf+HrnN+96maOxVwi32Yjc+10Ux91
 stYC57Qg4Vyl+bitGHypFmPtHjIzVWoLmKlamhhD52LwyC6F72GNgifh6aJH4NkEYmO4
 SB4GcjSq0o70mteqP5M6JC5xI51bHVFnd+PlfJ0+rnPzCnFO/9ov+JqWBjRuAr+OCqVt
 AvQg==
X-Gm-Message-State: AOAM531Edm/Dum4ANPpuz+uZYb3TzYtH579Z/Xgwvsouc1gsgd6Z1p0o
 7as7jJzijx+nRZkuZ9PV85fmDlbGM4odkPbCW/S1HMyz7lqjKDQ/vJ5JSHy90FQSZzmDaoYgedH
 AMeZ1Jva+SVPNHq0=
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr1421224wrq.153.1591763281894; 
 Tue, 09 Jun 2020 21:28:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw63XZpdMIrp9SSi28avBTRrYYI6FNYmcCj/XHqXrxfgVxF/xAoIFfT3gW5CbXtwA3eMR4YjA==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr1421182wrq.153.1591763281392; 
 Tue, 09 Jun 2020 21:28:01 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id l204sm5443383wmf.19.2020.06.09.21.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:00 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/56] Transmit vhost-user memory regions individually
Message-ID: <20200610042613.1459309-40-mst@redhat.com>
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
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

With this change, when the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
protocol feature has been negotiated, Qemu no longer sends the backend
all the memory regions in a single message. Rather, when the memory
tables are set or updated, a series of VHOST_USER_ADD_MEM_REG and
VHOST_USER_REM_MEM_REG messages are sent to transmit the regions to map
and/or unmap instead of sending send all the regions in one fixed size
VHOST_USER_SET_MEM_TABLE message.

The vhost_user struct maintains a shadow state of the VM’s memory
regions. When the memory tables are modified, the
vhost_user_set_mem_table() function compares the new device memory state
to the shadow state and only sends regions which need to be unmapped or
mapped in. The regions which must be unmapped are sent first, followed
by the new regions to be mapped in. After all the messages have been
sent, the shadow state is set to the current virtual device state.

Existing backends which do not support
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are unaffected.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Swapnil Ingle <swapnil.ingle@nutanix.com>
Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
Suggested-by: Mike Cui <cui@nutanix.com>
Message-Id: <1588533678-23450-5-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-user.c      | 516 ++++++++++++++++++++++++++++++------
 docs/interop/vhost-user.rst |  33 ++-
 2 files changed, 472 insertions(+), 77 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 0af593f9aa..93584069cd 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -104,6 +104,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_RESET_DEVICE = 34,
     /* Message number 35 reserved for VHOST_USER_VRING_KICK. */
     VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+    VHOST_USER_ADD_MEM_REG = 37,
+    VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -128,6 +130,11 @@ typedef struct VhostUserMemory {
     VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
 } VhostUserMemory;
 
+typedef struct VhostUserMemRegMsg {
+    uint32_t padding;
+    VhostUserMemoryRegion region;
+} VhostUserMemRegMsg;
+
 typedef struct VhostUserLog {
     uint64_t mmap_size;
     uint64_t mmap_offset;
@@ -186,6 +193,7 @@ typedef union {
         struct vhost_vring_state state;
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
+        VhostUserMemRegMsg mem_reg;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
@@ -226,6 +234,16 @@ struct vhost_user {
 
     /* True once we've entered postcopy_listen */
     bool               postcopy_listen;
+
+    /* Our current regions */
+    int num_shadow_regions;
+    struct vhost_memory_region shadow_regions[VHOST_MEMORY_MAX_NREGIONS];
+};
+
+struct scrub_regions {
+    struct vhost_memory_region *region;
+    int reg_idx;
+    int fd_idx;
 };
 
 static bool ioeventfd_enabled(void)
@@ -489,8 +507,332 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
     return 1;
 }
 
+static inline bool reg_equal(struct vhost_memory_region *shadow_reg,
+                             struct vhost_memory_region *vdev_reg)
+{
+    return shadow_reg->guest_phys_addr == vdev_reg->guest_phys_addr &&
+        shadow_reg->userspace_addr == vdev_reg->userspace_addr &&
+        shadow_reg->memory_size == vdev_reg->memory_size;
+}
+
+static void scrub_shadow_regions(struct vhost_dev *dev,
+                                 struct scrub_regions *add_reg,
+                                 int *nr_add_reg,
+                                 struct scrub_regions *rem_reg,
+                                 int *nr_rem_reg, uint64_t *shadow_pcb,
+                                 bool track_ramblocks)
+{
+    struct vhost_user *u = dev->opaque;
+    bool found[VHOST_MEMORY_MAX_NREGIONS] = {};
+    struct vhost_memory_region *reg, *shadow_reg;
+    int i, j, fd, add_idx = 0, rm_idx = 0, fd_num = 0;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+    bool matching;
+
+    /*
+     * Find memory regions present in our shadow state which are not in
+     * the device's current memory state.
+     *
+     * Mark regions in both the shadow and device state as "found".
+     */
+    for (i = 0; i < u->num_shadow_regions; i++) {
+        shadow_reg = &u->shadow_regions[i];
+        matching = false;
+
+        for (j = 0; j < dev->mem->nregions; j++) {
+            reg = &dev->mem->regions[j];
+
+            mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+
+            if (reg_equal(shadow_reg, reg)) {
+                matching = true;
+                found[j] = true;
+                if (track_ramblocks) {
+                    /*
+                     * Reset postcopy client bases, region_rb, and
+                     * region_rb_offset in case regions are removed.
+                     */
+                    if (fd > 0) {
+                        u->region_rb_offset[j] = offset;
+                        u->region_rb[j] = mr->ram_block;
+                        shadow_pcb[j] = u->postcopy_client_bases[i];
+                    } else {
+                        u->region_rb_offset[j] = 0;
+                        u->region_rb[j] = NULL;
+                    }
+                }
+                break;
+            }
+        }
+
+        /*
+         * If the region was not found in the current device memory state
+         * create an entry for it in the removed list.
+         */
+        if (!matching) {
+            rem_reg[rm_idx].region = shadow_reg;
+            rem_reg[rm_idx++].reg_idx = i;
+        }
+    }
+
+    /*
+     * For regions not marked "found", create entries in the added list.
+     *
+     * Note their indexes in the device memory state and the indexes of their
+     * file descriptors.
+     */
+    for (i = 0; i < dev->mem->nregions; i++) {
+        reg = &dev->mem->regions[i];
+        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+        if (fd > 0) {
+            ++fd_num;
+        }
+
+        /*
+         * If the region was in both the shadow and device state we don't
+         * need to send a VHOST_USER_ADD_MEM_REG message for it.
+         */
+        if (found[i]) {
+            continue;
+        }
+
+        add_reg[add_idx].region = reg;
+        add_reg[add_idx].reg_idx = i;
+        add_reg[add_idx++].fd_idx = fd_num;
+    }
+    *nr_rem_reg = rm_idx;
+    *nr_add_reg = add_idx;
+
+    return;
+}
+
+static int send_remove_regions(struct vhost_dev *dev,
+                               struct scrub_regions *remove_reg,
+                               int nr_rem_reg, VhostUserMsg *msg,
+                               bool reply_supported)
+{
+    struct vhost_user *u = dev->opaque;
+    struct vhost_memory_region *shadow_reg;
+    int i, fd, shadow_reg_idx, ret;
+    ram_addr_t offset;
+    VhostUserMemoryRegion region_buffer;
+
+    /*
+     * The regions in remove_reg appear in the same order they do in the
+     * shadow table. Therefore we can minimize memory copies by iterating
+     * through remove_reg backwards.
+     */
+    for (i = nr_rem_reg - 1; i >= 0; i--) {
+        shadow_reg = remove_reg[i].region;
+        shadow_reg_idx = remove_reg[i].reg_idx;
+
+        vhost_user_get_mr_data(shadow_reg->userspace_addr, &offset, &fd);
+
+        if (fd > 0) {
+            msg->hdr.request = VHOST_USER_REM_MEM_REG;
+            vhost_user_fill_msg_region(&region_buffer, shadow_reg);
+            msg->payload.mem_reg.region = region_buffer;
+
+            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
+                return -1;
+            }
+
+            if (reply_supported) {
+                ret = process_message_reply(dev, msg);
+                if (ret) {
+                    return ret;
+                }
+            }
+        }
+
+        /*
+         * At this point we know the backend has unmapped the region. It is now
+         * safe to remove it from the shadow table.
+         */
+        memmove(&u->shadow_regions[shadow_reg_idx],
+                &u->shadow_regions[shadow_reg_idx + 1],
+                sizeof(struct vhost_memory_region) *
+                (u->num_shadow_regions - shadow_reg_idx));
+        u->num_shadow_regions--;
+    }
+
+    return 0;
+}
+
+static int send_add_regions(struct vhost_dev *dev,
+                            struct scrub_regions *add_reg, int nr_add_reg,
+                            VhostUserMsg *msg, uint64_t *shadow_pcb,
+                            bool reply_supported, bool track_ramblocks)
+{
+    struct vhost_user *u = dev->opaque;
+    int i, fd, ret, reg_idx, reg_fd_idx;
+    struct vhost_memory_region *reg;
+    MemoryRegion *mr;
+    ram_addr_t offset;
+    VhostUserMsg msg_reply;
+    VhostUserMemoryRegion region_buffer;
+
+    for (i = 0; i < nr_add_reg; i++) {
+        reg = add_reg[i].region;
+        reg_idx = add_reg[i].reg_idx;
+        reg_fd_idx = add_reg[i].fd_idx;
+
+        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+
+        if (fd > 0) {
+            if (track_ramblocks) {
+                trace_vhost_user_set_mem_table_withfd(reg_fd_idx, mr->name,
+                                                      reg->memory_size,
+                                                      reg->guest_phys_addr,
+                                                      reg->userspace_addr,
+                                                      offset);
+                u->region_rb_offset[reg_idx] = offset;
+                u->region_rb[reg_idx] = mr->ram_block;
+            }
+            msg->hdr.request = VHOST_USER_ADD_MEM_REG;
+            vhost_user_fill_msg_region(&region_buffer, reg);
+            msg->payload.mem_reg.region = region_buffer;
+            msg->payload.mem_reg.region.mmap_offset = offset;
+
+            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
+                return -1;
+            }
+
+            if (track_ramblocks) {
+                uint64_t reply_gpa;
+
+                if (vhost_user_read(dev, &msg_reply) < 0) {
+                    return -1;
+                }
+
+                reply_gpa = msg_reply.payload.mem_reg.region.guest_phys_addr;
+
+                if (msg_reply.hdr.request != VHOST_USER_ADD_MEM_REG) {
+                    error_report("%s: Received unexpected msg type."
+                                 "Expected %d received %d", __func__,
+                                 VHOST_USER_ADD_MEM_REG,
+                                 msg_reply.hdr.request);
+                    return -1;
+                }
+
+                /*
+                 * We're using the same structure, just reusing one of the
+                 * fields, so it should be the same size.
+                 */
+                if (msg_reply.hdr.size != msg->hdr.size) {
+                    error_report("%s: Unexpected size for postcopy reply "
+                                 "%d vs %d", __func__, msg_reply.hdr.size,
+                                 msg->hdr.size);
+                    return -1;
+                }
+
+                /* Get the postcopy client base from the backend's reply. */
+                if (reply_gpa == dev->mem->regions[reg_idx].guest_phys_addr) {
+                    shadow_pcb[reg_idx] =
+                        msg_reply.payload.mem_reg.region.userspace_addr;
+                    trace_vhost_user_set_mem_table_postcopy(
+                        msg_reply.payload.mem_reg.region.userspace_addr,
+                        msg->payload.mem_reg.region.userspace_addr,
+                        reg_fd_idx, reg_idx);
+                } else {
+                    error_report("%s: invalid postcopy reply for region. "
+                                 "Got guest physical address %lX, expected "
+                                 "%lX", __func__, reply_gpa,
+                                 dev->mem->regions[reg_idx].guest_phys_addr);
+                    return -1;
+                }
+            } else if (reply_supported) {
+                ret = process_message_reply(dev, msg);
+                if (ret) {
+                    return ret;
+                }
+            }
+        } else if (track_ramblocks) {
+            u->region_rb_offset[reg_idx] = 0;
+            u->region_rb[reg_idx] = NULL;
+        }
+
+        /*
+         * At this point, we know the backend has mapped in the new
+         * region, if the region has a valid file descriptor.
+         *
+         * The region should now be added to the shadow table.
+         */
+        u->shadow_regions[u->num_shadow_regions].guest_phys_addr =
+            reg->guest_phys_addr;
+        u->shadow_regions[u->num_shadow_regions].userspace_addr =
+            reg->userspace_addr;
+        u->shadow_regions[u->num_shadow_regions].memory_size =
+            reg->memory_size;
+        u->num_shadow_regions++;
+    }
+
+    return 0;
+}
+
+static int vhost_user_add_remove_regions(struct vhost_dev *dev,
+                                         VhostUserMsg *msg,
+                                         bool reply_supported,
+                                         bool track_ramblocks)
+{
+    struct vhost_user *u = dev->opaque;
+    struct scrub_regions add_reg[VHOST_MEMORY_MAX_NREGIONS];
+    struct scrub_regions rem_reg[VHOST_MEMORY_MAX_NREGIONS];
+    uint64_t shadow_pcb[VHOST_MEMORY_MAX_NREGIONS] = {};
+    int nr_add_reg, nr_rem_reg;
+
+    msg->hdr.size = sizeof(msg->payload.mem_reg.padding) +
+        sizeof(VhostUserMemoryRegion);
+
+    /* Find the regions which need to be removed or added. */
+    scrub_shadow_regions(dev, add_reg, &nr_add_reg, rem_reg, &nr_rem_reg,
+                         shadow_pcb, track_ramblocks);
+
+    if (nr_rem_reg && send_remove_regions(dev, rem_reg, nr_rem_reg, msg,
+                reply_supported) < 0)
+    {
+        goto err;
+    }
+
+    if (nr_add_reg && send_add_regions(dev, add_reg, nr_add_reg, msg,
+                shadow_pcb, reply_supported, track_ramblocks) < 0)
+    {
+        goto err;
+    }
+
+    if (track_ramblocks) {
+        memcpy(u->postcopy_client_bases, shadow_pcb,
+               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+        /*
+         * Now we've registered this with the postcopy code, we ack to the
+         * client, because now we're in the position to be able to deal with
+         * any faults it generates.
+         */
+        /* TODO: Use this for failure cases as well with a bad value. */
+        msg->hdr.size = sizeof(msg->payload.u64);
+        msg->payload.u64 = 0; /* OK */
+
+        if (vhost_user_write(dev, msg, NULL, 0) < 0) {
+            return -1;
+        }
+    }
+
+    return 0;
+
+err:
+    if (track_ramblocks) {
+        memcpy(u->postcopy_client_bases, shadow_pcb,
+               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+    }
+
+    return -1;
+}
+
 static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
-                                             struct vhost_memory *mem)
+                                             struct vhost_memory *mem,
+                                             bool reply_supported,
+                                             bool config_mem_slots)
 {
     struct vhost_user *u = dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
@@ -513,71 +855,84 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
         u->region_rb_len = dev->mem->nregions;
     }
 
-    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
+    if (config_mem_slots) {
+        if (vhost_user_add_remove_regions(dev, &msg, reply_supported,
                                           true) < 0) {
-        return -1;
-    }
-
-    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
-        return -1;
-    }
-
-    if (vhost_user_read(dev, &msg_reply) < 0) {
-        return -1;
-    }
-
-    if (msg_reply.hdr.request != VHOST_USER_SET_MEM_TABLE) {
-        error_report("%s: Received unexpected msg type."
-                     "Expected %d received %d", __func__,
-                     VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request);
-        return -1;
-    }
-    /* We're using the same structure, just reusing one of the
-     * fields, so it should be the same size.
-     */
-    if (msg_reply.hdr.size != msg.hdr.size) {
-        error_report("%s: Unexpected size for postcopy reply "
-                     "%d vs %d", __func__, msg_reply.hdr.size, msg.hdr.size);
-        return -1;
-    }
-
-    memset(u->postcopy_client_bases, 0,
-           sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
-
-    /* They're in the same order as the regions that were sent
-     * but some of the regions were skipped (above) if they
-     * didn't have fd's
-    */
-    for (msg_i = 0, region_i = 0;
-         region_i < dev->mem->nregions;
-        region_i++) {
-        if (msg_i < fd_num &&
-            msg_reply.payload.memory.regions[msg_i].guest_phys_addr ==
-            dev->mem->regions[region_i].guest_phys_addr) {
-            u->postcopy_client_bases[region_i] =
-                msg_reply.payload.memory.regions[msg_i].userspace_addr;
-            trace_vhost_user_set_mem_table_postcopy(
-                msg_reply.payload.memory.regions[msg_i].userspace_addr,
-                msg.payload.memory.regions[msg_i].userspace_addr,
-                msg_i, region_i);
-            msg_i++;
+            return -1;
+        }
+    } else {
+        if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
+                                              true) < 0) {
+            return -1;
+        }
+
+        if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
+            return -1;
+        }
+
+        if (vhost_user_read(dev, &msg_reply) < 0) {
+            return -1;
+        }
+
+        if (msg_reply.hdr.request != VHOST_USER_SET_MEM_TABLE) {
+            error_report("%s: Received unexpected msg type."
+                         "Expected %d received %d", __func__,
+                         VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request);
+            return -1;
+        }
+
+        /*
+         * We're using the same structure, just reusing one of the
+         * fields, so it should be the same size.
+         */
+        if (msg_reply.hdr.size != msg.hdr.size) {
+            error_report("%s: Unexpected size for postcopy reply "
+                         "%d vs %d", __func__, msg_reply.hdr.size,
+                         msg.hdr.size);
+            return -1;
+        }
+
+        memset(u->postcopy_client_bases, 0,
+               sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
+
+        /*
+         * They're in the same order as the regions that were sent
+         * but some of the regions were skipped (above) if they
+         * didn't have fd's
+         */
+        for (msg_i = 0, region_i = 0;
+             region_i < dev->mem->nregions;
+             region_i++) {
+            if (msg_i < fd_num &&
+                msg_reply.payload.memory.regions[msg_i].guest_phys_addr ==
+                dev->mem->regions[region_i].guest_phys_addr) {
+                u->postcopy_client_bases[region_i] =
+                    msg_reply.payload.memory.regions[msg_i].userspace_addr;
+                trace_vhost_user_set_mem_table_postcopy(
+                    msg_reply.payload.memory.regions[msg_i].userspace_addr,
+                    msg.payload.memory.regions[msg_i].userspace_addr,
+                    msg_i, region_i);
+                msg_i++;
+            }
+        }
+        if (msg_i != fd_num) {
+            error_report("%s: postcopy reply not fully consumed "
+                         "%d vs %zd",
+                         __func__, msg_i, fd_num);
+            return -1;
+        }
+
+        /*
+         * Now we've registered this with the postcopy code, we ack to the
+         * client, because now we're in the position to be able to deal
+         * with any faults it generates.
+         */
+        /* TODO: Use this for failure cases as well with a bad value. */
+        msg.hdr.size = sizeof(msg.payload.u64);
+        msg.payload.u64 = 0; /* OK */
+        if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+            return -1;
         }
-    }
-    if (msg_i != fd_num) {
-        error_report("%s: postcopy reply not fully consumed "
-                     "%d vs %zd",
-                     __func__, msg_i, fd_num);
-        return -1;
-    }
-    /* Now we've registered this with the postcopy code, we ack to the client,
-     * because now we're in the position to be able to deal with any faults
-     * it generates.
-     */
-    /* TODO: Use this for failure cases as well with a bad value */
-    msg.hdr.size = sizeof(msg.payload.u64);
-    msg.payload.u64 = 0; /* OK */
-    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
-        return -1;
     }
 
     return 0;
@@ -592,12 +947,17 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool config_mem_slots =
+        virtio_has_feature(dev->protocol_features,
+                           VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
 
     if (do_postcopy) {
-        /* Postcopy has enough differences that it's best done in it's own
+        /*
+         * Postcopy has enough differences that it's best done in it's own
          * version
          */
-        return vhost_user_set_mem_table_postcopy(dev, mem);
+        return vhost_user_set_mem_table_postcopy(dev, mem, reply_supported,
+                                                 config_mem_slots);
     }
 
     VhostUserMsg msg = {
@@ -608,17 +968,23 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
-    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
+    if (config_mem_slots) {
+        if (vhost_user_add_remove_regions(dev, &msg, reply_supported,
                                           false) < 0) {
-        return -1;
-    }
+            return -1;
+        }
+    } else {
+        if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
+                                              false) < 0) {
+            return -1;
+        }
+        if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
+            return -1;
+        }
 
-    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
-        return -1;
-    }
-
-    if (reply_supported) {
-        return process_message_reply(dev, &msg);
+        if (reply_supported) {
+            return process_message_reply(dev, &msg);
+        }
     }
 
     return 0;
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index b3cf5c3cb5..037eefab0e 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1276,8 +1276,37 @@ Master message types
   QEMU to expose to the guest. At this point, the value returned
   by the backend will be capped at the maximum number of ram slots
   which can be supported by vhost-user. Currently that limit is set
-  at VHOST_USER_MAX_RAM_SLOTS = 8 because of underlying protocol
-  limitations.
+  at VHOST_USER_MAX_RAM_SLOTS = 8.
+
+``VHOST_USER_ADD_MEM_REG``
+  :id: 37
+  :equivalent ioctl: N/A
+  :slave payload: memory region
+
+  When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol
+  feature has been successfully negotiated, this message is submitted
+  by the master to the slave. The message payload contains a memory
+  region descriptor struct, describing a region of guest memory which
+  the slave device must map in. When the
+  ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol feature has
+  been successfully negotiated, along with the
+  ``VHOST_USER_REM_MEM_REG`` message, this message is used to set and
+  update the memory tables of the slave device.
+
+``VHOST_USER_REM_MEM_REG``
+  :id: 38
+  :equivalent ioctl: N/A
+  :slave payload: memory region
+
+  When the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol
+  feature has been successfully negotiated, this message is submitted
+  by the master to the slave. The message payload contains a memory
+  region descriptor struct, describing a region of guest memory which
+  the slave device must unmap. When the
+  ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol feature has
+  been successfully negotiated, along with the
+  ``VHOST_USER_ADD_MEM_REG`` message, this message is used to set and
+  update the memory tables of the slave device.
 
 Slave message types
 -------------------
-- 
MST


