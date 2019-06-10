Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1658CC28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 00:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB90C20820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 00:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB90C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39310 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha8Q0-0004nV-EC
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 20:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1ha8OR-0003jD-ER
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 20:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1ha8OQ-0002mF-DI
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 20:42:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:55869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1ha8OQ-0002ji-4b
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 20:42:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jun 2019 17:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,573,1557212400"; d="scan'208";a="183246801"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2019 17:42:26 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 08:41:59 +0800
Message-Id: <20190610004159.20966-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [PATCH v2] migration/xbzrle: update cache and
 current_data in one place
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we are not in the last_stage, we need to update the cache if page
is not the same.

Currently this procedure is scattered in two places and mixed with
encoding status check.

This patch extract this general step out to make the code a little bit
easy to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2: give more comment on the behavior
---
 migration/ram.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e9b40d636d..17cc9b2b44 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1594,25 +1594,30 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     encoded_len = xbzrle_encode_buffer(prev_cached_page, XBZRLE.current_buf,
                                        TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
                                        TARGET_PAGE_SIZE);
+
+    /*
+     * Update the cache contents, so that it corresponds to the data
+     * sent, in all cases except where we skip the page.
+     */
+    if (!last_stage && encoded_len != 0) {
+        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
+        /*
+         * In the case where we couldn't compress, ensure that the caller
+         * sends the data from the cache, since the guest might have
+         * changed the RAM since we copied it.
+         */
+        *current_data = prev_cached_page;
+    }
+
     if (encoded_len == 0) {
         trace_save_xbzrle_page_skipping();
         return 0;
     } else if (encoded_len == -1) {
         trace_save_xbzrle_page_overflow();
         xbzrle_counters.overflow++;
-        /* update data in the cache */
-        if (!last_stage) {
-            memcpy(prev_cached_page, *current_data, TARGET_PAGE_SIZE);
-            *current_data = prev_cached_page;
-        }
         return -1;
     }
 
-    /* we need to update the data in the cache, in order to get the same data */
-    if (!last_stage) {
-        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
-    }
-
     /* Send XBZRLE based compressed page */
     bytes_xbzrle = save_page_header(rs, rs->f, block,
                                     offset | RAM_SAVE_FLAG_XBZRLE);
-- 
2.19.1


