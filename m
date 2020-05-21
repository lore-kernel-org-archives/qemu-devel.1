Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DE6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9612070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="FmGh/JYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9612070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbdLE-0004qC-3q
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdJo-00032T-KV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:32 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:61607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdJn-0001Em-Fi
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=Va0Wof9z55xrrI91p6vOei7zjKTVO0gLIlQPs/0NLmE=;
 b=FmGh/JYnQSvIZ4wRUmE8bI8AYrD7+lLDbFzg6gXXR+1NlJ/knB3WjzG2aYQ39XQykp1X
 FwKySoYH/LR/f+Cu1TYLwYywWjuuyjFLdrTxiP01abbMWYNyavH1cuHYTSNfdgB7jJG3S8
 FFU7clvFVXfWiwMNAFyyxFJcWGoz0posQ=
Received: by filterdrecv-p3iad2-8ddf98858-lwgxm with SMTP id
 filterdrecv-p3iad2-8ddf98858-lwgxm-19-5EC60AED-C7
 2020-05-21 05:00:29.450879106 +0000 UTC m=+4852378.688574636
Received: from localhost.localdomain.com (unknown)
 by ismtpd0026p1las1.sendgrid.net (SG) with ESMTP
 id wgexu8MbRYaJaOvAFOQoKA Thu, 21 May 2020 05:00:29.256 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v4 02/10] Add vhost-user helper to get MemoryRegion data
Date: Thu, 21 May 2020 05:00:29 +0000 (UTC)
Message-Id: <1588533678-23450-3-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zciUKG=2Fx94H5nEBLg?=
 =?us-ascii?Q?g=2FS3DlyXmSKv4CA51oOqz3CA8a=2FreLwKwMAf9Wy?=
 =?us-ascii?Q?o9Wg=2Fa7=2Fvapv9BZvycGWTZq6T4WMC2q5bzTtgiz?=
 =?us-ascii?Q?myzRGq3XaWYU5JV50IE7cYN6sWzNxqe5OLE9s9B?=
 =?us-ascii?Q?h1d=2FW7L4ADsvciINJL9ingAfeU8s95v36Qi++SV?=
 =?us-ascii?Q?GKIzVGUH2BJtWpl7ato5g=3D=3D?=
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

When setting the memory tables, qemu uses a memory region's userspace
address to look up the region's MemoryRegion struct. Among other things,
the MemoryRegion contains the region's offset and associated file
descriptor, all of which need to be sent to the backend.

With VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, this logic will be
needed in multiple places, so before feature support is added it
should be moved to a helper function.

This helper is also used to simplify the vhost_user_can_merge()
function.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost-user.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2e0552d..442b0d6 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -407,6 +407,18 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     return 0;
 }
 
+static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
+                                            int *fd)
+{
+    MemoryRegion *mr;
+
+    assert((uintptr_t)addr == addr);
+    mr = memory_region_from_host((void *)(uintptr_t)addr, offset);
+    *fd = memory_region_get_fd(mr);
+
+    return mr;
+}
+
 static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
                                        struct vhost_memory_region *src)
 {
@@ -433,10 +445,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
     for (i = 0; i < dev->mem->nregions; ++i) {
         reg = dev->mem->regions + i;
 
-        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
-        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
-                                     &offset);
-        fd = memory_region_get_fd(mr);
+        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
         if (fd > 0) {
             if (track_ramblocks) {
                 assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
@@ -1551,13 +1560,9 @@ static bool vhost_user_can_merge(struct vhost_dev *dev,
 {
     ram_addr_t offset;
     int mfd, rfd;
-    MemoryRegion *mr;
-
-    mr = memory_region_from_host((void *)(uintptr_t)start1, &offset);
-    mfd = memory_region_get_fd(mr);
 
-    mr = memory_region_from_host((void *)(uintptr_t)start2, &offset);
-    rfd = memory_region_get_fd(mr);
+    (void)vhost_user_get_mr_data(start1, &offset, &mfd);
+    (void)vhost_user_get_mr_data(start2, &offset, &rfd);
 
     return mfd == rfd;
 }
-- 
1.8.3.1


