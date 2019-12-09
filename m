Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE952C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 01:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C452082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 01:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C452082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih26k-0003Lb-CH
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 20:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25g-0002E7-Kq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25e-0001RU-PK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:55:59 -0500
Received: from [192.146.154.1] (port=8940 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ih25e-0001QA-K9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 20:55:58 -0500
Received: from localhost.corp.nutanix.com (unknown [10.40.33.233])
 by mcp01.nutanix.com (Postfix) with ESMTP id 4450E1008B75;
 Tue, 17 Dec 2019 01:55:57 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] Fixed Error Handling in
 vhost_user_set_mem_table_postcopy
Date: Mon,  9 Dec 2019 02:00:45 -0500
Message-Id: <1575874847-5792-2-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.154.1
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
Cc: raphael.s.norwitz@gmail.com, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current vhost_user_set_mem_table_postcopy() implementation
populates each region of the VHOST_USER_SET_MEM_TABLE
message without first checking if there are more than
VHOST_MEMORY_MAX_NREGIONS already populated. This can
cause memory corruption and potentially a crash if too many
regions are added to the message during the postcopy step.

Additionally, after populating each region, the current
implementation asserts that the current region index is less than
VHOST_MEMORY_MAX_NREGIONS. Thus, even if the aforementioned
bug is fixed by moving the existing assert up, too many hot-adds
during the postcopy step will bring down qemu instead of
gracefully propogating up the error as in
vhost_user_set_mem_table().

This change cleans up error handling in
vhost_user_set_mem_table_postcopy() such that it handles
an unsupported number of memory hot-adds like
vhost_user_set_mem_table(), gracefully propogating an error
up instead of corrupting memory and crashing qemu.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost-user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 02a9b25..f74ff3b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -441,6 +441,10 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                      &offset);
         fd = memory_region_get_fd(mr);
         if (fd > 0) {
+            if (fd_num == VHOST_MEMORY_MAX_NREGIONS) {
+                error_report("Failed preparing vhost-user memory table msg");
+                return -1;
+            }
             trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
                                                   reg->memory_size,
                                                   reg->guest_phys_addr,
@@ -453,7 +457,6 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
             msg.payload.memory.regions[fd_num].guest_phys_addr =
                 reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].mmap_offset = offset;
-            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
             fds[fd_num++] = fd;
         } else {
             u->region_rb_offset[i] = 0;
-- 
1.8.3.1


