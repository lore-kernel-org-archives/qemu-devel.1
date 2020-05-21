Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B33C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB03C20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="VOKESkOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB03C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbdR4-00066S-Vd
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdKC-0003Uh-Un
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:56 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:51874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdKB-0001Hu-N3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=2FTh0G5Bni5O1HipBUNVtDSutJB43/93GVvOtHvkaoY=;
 b=VOKESkOoCaVhiV8z8J0Lk7p0xHZGPBskbZpshq4/zosNmk0IdHScyH+uZ5Qi8HRTU6UE
 cZgpGO0KGA7NmTkZvS8wrJoDiS9MsubKHVOBQz0PkhwiA8oNzkzH0uQ+w72tmy1jHBgf1u
 buOXfJdS4b9xAua4EWC4m0zX8uvtHgBMU=
Received: by filterdrecv-p3iad2-8ddf98858-xxtk7 with SMTP id
 filterdrecv-p3iad2-8ddf98858-xxtk7-19-5EC60B04-2
 2020-05-21 05:00:52.08102741 +0000 UTC m=+4852401.953129604
Received: from localhost.localdomain.com (unknown)
 by ismtpd0026p1las1.sendgrid.net (SG) with ESMTP
 id MD98p3FRTe-PP1loND7zOg Thu, 21 May 2020 05:00:51.865 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v4 08/10] Support adding individual regions in libvhost-user
Date: Thu, 21 May 2020 05:00:52 +0000 (UTC)
Message-Id: <1588533678-23450-9-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zf8uMeSsKbghQKEVM?=
 =?us-ascii?Q?6R2KgxARKEbTESzuukyHUwbR4wkJ6FoW++TXFTe?=
 =?us-ascii?Q?Fe2sz+f4lUcx3eEzTaRr7Ppoo352Iag4d3fdRar?=
 =?us-ascii?Q?URxyEiN6Vyz1bK=2FcOjunotCx0btOiTbBfLiRlLM?=
 =?us-ascii?Q?PyBgIFVFVIhHXHTqfRTvc+tMXfuh8xOCqPbbQ5x?=
 =?us-ascii?Q?Ms89IlE091tJv6X9lNnqw=3D=3D?=
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
Cc: raphael.s.norwitz@gmail.com, marcandre.lureau@gmail.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 contrib/libvhost-user/libvhost-user.c | 103 ++++++++++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |   7 +++
 2 files changed, 110 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 9f039b7..d8ee7a2 100644
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
@@ -663,6 +664,106 @@ generate_faults(VuDev *dev) {
 }
 
 static bool
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
+static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
@@ -1668,6 +1769,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_handle_vring_kick(dev, vmsg);
     case VHOST_USER_GET_MAX_MEM_SLOTS:
         return vu_handle_get_max_memslots(dev, vmsg);
+    case VHOST_USER_ADD_MEM_REG:
+        return vu_add_mem_reg(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 88ef40d..60ef7fd 100644
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
-- 
1.8.3.1


