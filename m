Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D3C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9898217F9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9898217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgJtF-0005os-1L
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 22:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51514)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hgJqQ-0002Py-MW
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hgJqO-0004Eg-R8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:09:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:6491)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hgJqN-0004Bu-SQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:09:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2019 19:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; d="scan'208";a="188879918"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2019 19:08:51 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 10:08:21 +0800
Message-Id: <20190627020822.15485-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627020822.15485-1-richardw.yang@linux.intel.com>
References: <20190627020822.15485-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH 2/3] migration/postcopy: break the loop when
 there is no more page to discard
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

When one is equal or bigger then end, it means there is no page to
discard. Just break the loop in this case instead of processing it.

No functional change, just refactor it a little.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b78169e811..b41b58ee54 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2776,23 +2776,23 @@ static int postcopy_send_discard_bm_ram(MigrationState *ms,
 
     for (current = 0; current < end; ) {
         unsigned long one = find_next_bit(unsentmap, end, current);
+        unsigned long zero, discard_length;
 
-        if (one < end) {
-            unsigned long zero = find_next_zero_bit(unsentmap, end, one + 1);
-            unsigned long discard_length;
+        if (one >= end) {
+            break;
+        }
 
-            if (zero >= end) {
-                discard_length = end - one;
-            } else {
-                discard_length = zero - one;
-            }
-            if (discard_length) {
-                postcopy_discard_send_range(ms, pds, one, discard_length);
-            }
-            current = one + discard_length;
+        zero = find_next_zero_bit(unsentmap, end, one + 1);
+
+        if (zero >= end) {
+            discard_length = end - one;
         } else {
-            current = one;
+            discard_length = zero - one;
+        }
+        if (discard_length) {
+            postcopy_discard_send_range(ms, pds, one, discard_length);
         }
+        current = one + discard_length;
     }
 
     return 0;
-- 
2.19.1


