Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9DDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEF4207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZooXDSoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEF4207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisrr-0007GQ-It
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisOG-0004fg-Vk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:31:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisOE-0000gQ-TU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afqjR/PPKF3RnnjVexEnd3gC/JLrRCP0cPSdSL7aizY=;
 b=ZooXDSoOYIjJZteFJ2BpI/XurdS7IcbVmTuMu9lSEhmWrgNiZzmZd4DnmxCfntiUXUiqaA
 C2wnzmUEVDRSR7vgkruEkGpVVbnT01S3xtOlTevltqRZwanem1LBav9TU9exXSXZzqaMDe
 VQE0zqfZFG5qyf0AiaROvbSFbSgdKQo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-AEzjcuTkObOlBeRTKKOxmw-1; Wed, 10 Jun 2020 00:28:12 -0400
X-MC-Unique: AEzjcuTkObOlBeRTKKOxmw-1
Received: by mail-wr1-f71.google.com with SMTP id c14so504031wrm.15
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=afqjR/PPKF3RnnjVexEnd3gC/JLrRCP0cPSdSL7aizY=;
 b=D+vZp/IR6HlAw+sf33/mr0xQnzRHkSL46oFAHGveCMcVSYT2ax9/mj+zLIwwtQf8I9
 K6vkA5FY8QeIqHYRCFusL9vVmDYy2wuOVHu7jpQBzyznRnf2gMcIWsdNeiAUON/jCE7v
 A3mF75VxCj56yKgpvQSzLgL6X6Jzz3d+rJzp2jkZr83IchA5bnDUJ7ivKAgMkhoEZNz3
 A1urnTfor9vX4ghXogGzIFhBWOg1SBT4HKrmZnwTKyi4g8FyGcnHziGSCQI11B0BxvO+
 UF8OTNmuISKyhmionDJgwWD91FfgX5sOfQQBOqLFX/r2VN+jc0zqBRHG3kNo3nGU8qje
 guYg==
X-Gm-Message-State: AOAM530lXOp0Oro3R6QsT6plfe1I8ev8rIsV1VVh2OVASQcyJm+lJlH7
 DmRTTmrnWMMO2wjhc7Zd8SMyXHiWcQe4RPyNaP1DY0ZnRWVaDl3J+u29ALnTpwgnyo0s85JBiQk
 bdDhmp/sM1DeqMEQ=
X-Received: by 2002:a1c:740e:: with SMTP id p14mr1213644wmc.155.1591763291164; 
 Tue, 09 Jun 2020 21:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2b1ob3MWTUnE3xzOsTL37A8APxv75ijnGDpjwT0ROl8P1weELPpUiT69x03DTEaxIV4jJiw==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr1213630wmc.155.1591763290870; 
 Tue, 09 Jun 2020 21:28:10 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id k21sm6517090wrd.24.2020.06.09.21.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:10 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/56] Support adding individual regions in libvhost-user
Message-ID: <20200610042613.1459309-44-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Johannes Berg <johannes.berg@intel.com>, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

When the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS is enabled, qemu will
transmit memory regions to a backend individually using the new message
VHOST_USER_ADD_MEM_REG. With this change vhost-user backends built with
libvhost-user can now map in new memory regions when VHOST_USER_ADD_MEM_REG
messages are received.

Qemu only sends VHOST_USER_ADD_MEM_REG messages when the
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS feature is negotiated, and
since it is not yet supported in libvhost-user, this new functionality
is not yet used.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1588533678-23450-9-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |   7 ++
 contrib/libvhost-user/libvhost-user.c | 103 ++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 88ef40d26a..60ef7fd13e 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -98,6 +98,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GPU_SET_SOCKET = 33,
     VHOST_USER_VRING_KICK = 35,
     VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+    VHOST_USER_ADD_MEM_REG = 37,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -124,6 +125,11 @@ typedef struct VhostUserMemory {
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
@@ -176,6 +182,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_state state;
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
+        VhostUserMemRegMsg memreg;
         VhostUserLog log;
         VhostUserConfig config;
         VhostUserVringArea area;
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 9f039b707e..d8ee7a23a3 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -138,6 +138,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_GPU_SET_SOCKET),
         REQ(VHOST_USER_VRING_KICK),
         REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
+        REQ(VHOST_USER_ADD_MEM_REG),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -662,6 +663,106 @@ generate_faults(VuDev *dev) {
     return true;
 }
 
+static bool
+vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
+    int i;
+    bool track_ramblocks = dev->postcopy_listening;
+    VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
+    VuDevRegion *dev_region = &dev->regions[dev->nregions];
+    void *mmap_addr;
+
+    /*
+     * If we are in postcopy mode and we receive a u64 payload with a 0 value
+     * we know all the postcopy client bases have been recieved, and we
+     * should start generating faults.
+     */
+    if (track_ramblocks &&
+        vmsg->size == sizeof(vmsg->payload.u64) &&
+        vmsg->payload.u64 == 0) {
+        (void)generate_faults(dev);
+        return false;
+    }
+
+    DPRINT("Adding region: %d\n", dev->nregions);
+    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+           msg_region->guest_phys_addr);
+    DPRINT("    memory_size:     0x%016"PRIx64"\n",
+           msg_region->memory_size);
+    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+           msg_region->userspace_addr);
+    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+           msg_region->mmap_offset);
+
+    dev_region->gpa = msg_region->guest_phys_addr;
+    dev_region->size = msg_region->memory_size;
+    dev_region->qva = msg_region->userspace_addr;
+    dev_region->mmap_offset = msg_region->mmap_offset;
+
+    /*
+     * We don't use offset argument of mmap() since the
+     * mapped address has to be page aligned, and we use huge
+     * pages.
+     */
+    if (track_ramblocks) {
+        /*
+         * In postcopy we're using PROT_NONE here to catch anyone
+         * accessing it before we userfault.
+         */
+        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
+                         PROT_NONE, MAP_SHARED,
+                         vmsg->fds[0], 0);
+    } else {
+        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
+                         PROT_READ | PROT_WRITE, MAP_SHARED, vmsg->fds[0],
+                         0);
+    }
+
+    if (mmap_addr == MAP_FAILED) {
+        vu_panic(dev, "region mmap error: %s", strerror(errno));
+    } else {
+        dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
+        DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
+               dev_region->mmap_addr);
+    }
+
+    close(vmsg->fds[0]);
+
+    if (track_ramblocks) {
+        /*
+         * Return the address to QEMU so that it can translate the ufd
+         * fault addresses back.
+         */
+        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
+                                                 dev_region->mmap_offset);
+
+        /* Send the message back to qemu with the addresses filled in. */
+        vmsg->fd_num = 0;
+        if (!vu_send_reply(dev, dev->sock, vmsg)) {
+            vu_panic(dev, "failed to respond to add-mem-region for postcopy");
+            return false;
+        }
+
+        DPRINT("Successfully added new region in postcopy\n");
+        dev->nregions++;
+        return false;
+
+    } else {
+        for (i = 0; i < dev->max_queues; i++) {
+            if (dev->vq[i].vring.desc) {
+                if (map_ring(dev, &dev->vq[i])) {
+                    vu_panic(dev, "remapping queue %d for new memory region",
+                             i);
+                }
+            }
+        }
+
+        DPRINT("Successfully added new region\n");
+        dev->nregions++;
+        vmsg_set_reply_u64(vmsg, 0);
+        return true;
+    }
+}
+
 static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1668,6 +1769,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_handle_vring_kick(dev, vmsg);
     case VHOST_USER_GET_MAX_MEM_SLOTS:
         return vu_handle_get_max_memslots(dev, vmsg);
+    case VHOST_USER_ADD_MEM_REG:
+        return vu_add_mem_reg(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
-- 
MST


