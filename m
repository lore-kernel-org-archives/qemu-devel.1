Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613D0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECFF2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="bdfIe5vX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECFF2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnROy-0001K3-F8
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jnRO4-0000L9-Go
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:41:44 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:62792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jnRO2-000164-ED
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:to:cc:content-type:content-transfer-encoding;
 s=smtpapi; bh=W7UT2L/3cDgUS4c6yIl6C4600Td51ns/jp0qTrD5H9U=;
 b=bdfIe5vXrRaKAeyoy0aMYw98MR1xhjDXvOQt56p6qtq8ASR+zazh8Q2DcDX4ykZdqSsf
 iKlKX3dkZm1uYSI2LEwJYllWsskVf4aI4wiPVpA1W2Dqma0lthtWqTit/fcIcTgctpYJtw
 JYf5P/YTCEYRzvEta0SYclJIia0OJGDWo=
Received: by filterdrecv-p3mdw1-6dd9dd6d45-kzfl7 with SMTP id
 filterdrecv-p3mdw1-6dd9dd6d45-kzfl7-19-5EF0FB63-C
 2020-06-22 18:41:39.201949304 +0000 UTC m=+347944.536090791
Received: from localhost.localdomain.com (unknown)
 by ismtpd0012p1las1.sendgrid.net (SG) with ESMTP
 id wU5mNpNlQcO9EeplrsLRVg Mon, 22 Jun 2020 18:41:39.015 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH] Stop vhost-user sending uninitialized mmap_offsets
Date: Mon, 22 Jun 2020 18:41:39 +0000 (UTC)
Message-Id: <1592637581-25255-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zciUKG=2Fx94H5nEBLg?=
 =?us-ascii?Q?g=2FS3Dm5OJAEQAuqwtzZ7VB1p4dFrRcjv4X3anhe?=
 =?us-ascii?Q?K4kpktsuJ8o24iKzgC5xBHKSuydHVDZT0T8kdiF?=
 =?us-ascii?Q?m4UiVx+919f++BmlLw5NBIiI0vgvpkRcXYUgl8g?=
 =?us-ascii?Q?=2FLjbzOHDgfdFNNfaoCYPZfWhyUSi758=2Fr=2FFvJmp?=
 =?us-ascii?Q?YtJ76x2EQJroWVzkqhVCQ=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 14:41:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prior to this change, the vhost_user_fill_msg_region function filled out
all elements of the VhostUserMemoryRegion struct except the mmap_offset.

This function is often called on uninitialized structs, which are then
copied into VHOST_USER_SET_MEM_TABLE and VHOST_USER_ADD/REM_MEM_REG
messages. In some cases, where the mmap_offset was not needed, it was
left uninitialized, causing QEMU to send the backend uninitialized data,
which Coverity flagged as a series of issues.

This change augments the vhost_user_fill_msg_region API, adding a
mmap_offset paramenter, forcing the caller to initialize mmap_offset.

Fixes: CID-1429802, CID-1429803, CID-1429804

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost-user.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 4d6cd4e..3123121 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -460,12 +460,14 @@ static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
 }
 
 static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
-                                       struct vhost_memory_region *src)
+                                       struct vhost_memory_region *src,
+                                       uint64_t mmap_offset)
 {
     assert(src != NULL && dst != NULL);
     dst->userspace_addr = src->userspace_addr;
     dst->memory_size = src->memory_size;
     dst->guest_phys_addr = src->guest_phys_addr;
+    dst->mmap_offset = mmap_offset;
 }
 
 static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
@@ -500,9 +502,8 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                 error_report("Failed preparing vhost-user memory table msg");
                 return -1;
             }
-            vhost_user_fill_msg_region(&region_buffer, reg);
+            vhost_user_fill_msg_region(&region_buffer, reg, offset);
             msg->payload.memory.regions[*fd_num] = region_buffer;
-            msg->payload.memory.regions[*fd_num].mmap_offset = offset;
             fds[(*fd_num)++] = fd;
         } else if (track_ramblocks) {
             u->region_rb_offset[i] = 0;
@@ -649,7 +650,7 @@ static int send_remove_regions(struct vhost_dev *dev,
 
         if (fd > 0) {
             msg->hdr.request = VHOST_USER_REM_MEM_REG;
-            vhost_user_fill_msg_region(&region_buffer, shadow_reg);
+            vhost_user_fill_msg_region(&region_buffer, shadow_reg, 0);
             msg->payload.mem_reg.region = region_buffer;
 
             if (vhost_user_write(dev, msg, &fd, 1) < 0) {
@@ -709,9 +710,8 @@ static int send_add_regions(struct vhost_dev *dev,
                 u->region_rb[reg_idx] = mr->ram_block;
             }
             msg->hdr.request = VHOST_USER_ADD_MEM_REG;
-            vhost_user_fill_msg_region(&region_buffer, reg);
+            vhost_user_fill_msg_region(&region_buffer, reg, offset);
             msg->payload.mem_reg.region = region_buffer;
-            msg->payload.mem_reg.region.mmap_offset = offset;
 
             if (vhost_user_write(dev, msg, &fd, 1) < 0) {
                 return -1;
-- 
1.8.3.1


