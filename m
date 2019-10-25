Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33322070B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33322070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOA2k-0006oG-UB
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iO8se-0008E7-Mv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iO8sc-0000AP-Lh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:20:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:32856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iO8sa-000086-Nh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:20:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="373689598"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga005.jf.intel.com with ESMTP; 25 Oct 2019 16:20:17 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 1/2] migration/multifd: clean pages after filling packet
Date: Sat, 26 Oct 2019 07:19:59 +0800
Message-Id: <20191025232000.25857-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025232000.25857-1-richardw.yang@linux.intel.com>
References: <20191025232000.25857-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a preparation for the next patch:

    not use multifd during postcopy.

Without enabling postcopy, everything looks good. While after enabling
postcopy, migration may fail even not use multifd during postcopy. The
reason is the pages is not properly cleared and *old* target page will
continue to be transferred.

After clean pages, migration succeeds.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 80dd2d55f9..7087bb73ed 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -929,10 +929,10 @@ static int multifd_send_pages(RAMState *rs)
         }
         qemu_mutex_unlock(&p->mutex);
     }
-    p->pages->used = 0;
+    assert(!p->pages->used);
+    assert(!p->pages->block);
 
     p->packet_num = multifd_send_state->packet_num++;
-    p->pages->block = NULL;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
     transferred = ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packet_len;
@@ -1114,6 +1114,8 @@ static void *multifd_send_thread(void *opaque)
             p->flags = 0;
             p->num_packets++;
             p->num_pages += used;
+            p->pages->used = 0;
+            p->pages->block = NULL;
             qemu_mutex_unlock(&p->mutex);
 
             trace_multifd_send(p->id, packet_num, used, flags,
-- 
2.17.1


