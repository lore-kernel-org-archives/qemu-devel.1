Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F71C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF9820825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="q/QuKzfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF9820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1L5-0001pL-2B
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1JI-0008Kb-5P
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:28 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:2515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1JH-00035A-4j
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=M6xTVVbhl/MNPl1YAIqUl150kIlTpOqbu4j5fCTP0pQ=;
 b=q/QuKzfwm4GrziEWq8ojn5G3LHizdJdLQW6piE4YTtRwQksDLLY9TPGg9q4lktrlou5a
 BO+6W3h44zcq33AIcnomirwHiDROydR6hsgHmAdNM0OO6lywrQH/7Fj9GXWqhOyfCUD1qc
 Haw8bbPG7t7QA8rdptDad5BysqwG+n/mY=
Received: by filterdrecv-p3iad2-8ddf98858-xxtk7 with SMTP id
 filterdrecv-p3iad2-8ddf98858-xxtk7-19-5EC3D034-6C
 2020-05-19 12:25:24.920715111 +0000 UTC m=+4706274.792817300
Received: from localhost.localdomain.com (unknown)
 by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP
 id JrnbnvuhSbGAl57yO8u6Zw Tue, 19 May 2020 12:25:24.640 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v3 01/10] Add helper to populate vhost-user message regions
Date: Tue, 19 May 2020 12:25:24 +0000 (UTC)
Message-Id: <1588473683-27067-2-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zS1BYfxWzbSS+pQZx?=
 =?us-ascii?Q?4eS3Ew6yLV9Xqja3b7JcYrwD1gaK+Utnj4D+eYE?=
 =?us-ascii?Q?7Wogs9isKFPnZwmmhtkM0z5j14C7LgkpuUFG624?=
 =?us-ascii?Q?mrDnbuTzkDbmH2KNicWAichC71+Ogh5VJZufAxM?=
 =?us-ascii?Q?o6bAwivIeBkHJ3mXk2jOV6=2F9jc+zDbc+Grtlzp3?=
 =?us-ascii?Q?1ufuyBOs8ZWKHiwv4X+Eg=3D=3D?=
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
 hw/virtio/vhost-user.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ec21e8f..ee6d1ed 100644
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
@@ -441,12 +450,8 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                 error_report("Failed preparing vhost-user memory table msg");
                 return -1;
             }
-            msg->payload.memory.regions[*fd_num].userspace_addr =
-                reg->userspace_addr;
-            msg->payload.memory.regions[*fd_num].memory_size =
-                reg->memory_size;
-            msg->payload.memory.regions[*fd_num].guest_phys_addr =
-                reg->guest_phys_addr;
+            vhost_user_fill_msg_region(&msg->payload.memory.regions[*fd_num],
+                                       reg);
             msg->payload.memory.regions[*fd_num].mmap_offset = offset;
             fds[(*fd_num)++] = fd;
         } else if (track_ramblocks) {
-- 
1.8.3.1


