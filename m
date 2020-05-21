Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67144C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2168120748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="qyKcbRAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2168120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbdLE-0004nX-8F
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdJn-00031q-MU
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:31 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:16893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdJl-0001D5-IS
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=m0NtnfVnp0PzfL8px4sfwdcZTA8azBlcXjhOtOvFdl8=;
 b=qyKcbRAElTLIoMwmJk3K5OyHEzV8NJAV/23kVGO0oi+X2YtoY4wNBZzejpXGOvTOeQKy
 /S61zLrqL8yWdgX/ioi9hglrA0dVVubY2dT8xTqBbDAdc3w7pTgrcBF9Wf/E/M88rvKtRI
 WsiIDnpXZWJzlv25+g+oRzwiSigxYjAA8=
Received: by filterdrecv-p3iad2-8ddf98858-4fqk8 with SMTP id
 filterdrecv-p3iad2-8ddf98858-4fqk8-19-5EC60AEA-4F
 2020-05-21 05:00:26.281457718 +0000 UTC m=+4852371.715890103
Received: from localhost.localdomain.com (unknown)
 by ismtpd0026p1las1.sendgrid.net (SG) with ESMTP
 id Z5pJocFvQ2aULHmAcDnqJg Thu, 21 May 2020 05:00:26.069 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v4 01/10] Add helper to populate vhost-user message regions
Date: Thu, 21 May 2020 05:00:26 +0000 (UTC)
Message-Id: <1588533678-23450-2-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zVv1yMmJe5tLurTe2?=
 =?us-ascii?Q?InvQ9mYtNZqTmxdk8Wla7zw5jovEWVmb0cMKqQC?=
 =?us-ascii?Q?nGqneqYtWnvMojJzCWfPEHHNp6tswzP=2FZicf521?=
 =?us-ascii?Q?quUeuIlPiWefyyNsx0qOplGYXsoaAgfiENr3TH1?=
 =?us-ascii?Q?w0b5MygRWewOer9Y7=2F6BLbR3G6xqmrVTXQ9ENFz?=
 =?us-ascii?Q?2L=2FQuGPrff1TgOahPTl3g=3D=3D?=
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

When setting vhost-user memory tables, memory region descriptors must be
copied from the vhost_dev struct to the vhost-user message. To avoid
duplicating code in setting the memory tables, we should use a helper to
populate this field. This change adds this helper.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost-user.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ec21e8f..2e0552d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -407,6 +407,15 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     return 0;
 }
 
+static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
+                                       struct vhost_memory_region *src)
+{
+    assert(src != NULL && dst != NULL);
+    dst->userspace_addr = src->userspace_addr;
+    dst->memory_size = src->memory_size;
+    dst->guest_phys_addr = src->guest_phys_addr;
+}
+
 static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                                              struct vhost_dev *dev,
                                              VhostUserMsg *msg,
@@ -417,6 +426,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
     ram_addr_t offset;
     MemoryRegion *mr;
     struct vhost_memory_region *reg;
+    VhostUserMemoryRegion region_buffer;
 
     msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
 
@@ -441,12 +451,8 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                 error_report("Failed preparing vhost-user memory table msg");
                 return -1;
             }
-            msg->payload.memory.regions[*fd_num].userspace_addr =
-                reg->userspace_addr;
-            msg->payload.memory.regions[*fd_num].memory_size =
-                reg->memory_size;
-            msg->payload.memory.regions[*fd_num].guest_phys_addr =
-                reg->guest_phys_addr;
+            vhost_user_fill_msg_region(&region_buffer, reg);
+            msg->payload.memory.regions[*fd_num] = region_buffer;
             msg->payload.memory.regions[*fd_num].mmap_offset = offset;
             fds[(*fd_num)++] = fd;
         } else if (track_ramblocks) {
-- 
1.8.3.1


