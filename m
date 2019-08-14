Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED4C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 00:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FFF20665
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 00:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FFF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxh9Z-0004J6-Ho
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 20:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hxh9C-0003uZ-HB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 20:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hxh9B-0005Sc-Il
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 20:28:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:60891)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hxh9B-0005RA-96
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 20:28:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Aug 2019 17:28:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; d="scan'208";a="177960620"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2019 17:28:04 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 08:27:23 +0800
Message-Id: <20190814002723.5140-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: [Qemu-devel] [PATCH] test-bitmap: test set 1 bit case for bitmap_set
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
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de, peterx@redhat.com,
 kraxel@redhat.com, pbonzini@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All current bitmap_set test cases set range across word, while the
handle of a range within one word is different from that.

Add case to set 1 bit as a represent for set range within one word.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
Thanks for Paolo's finding.

---
 tests/test-bitmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index 18aa584591..087e02a26c 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -67,6 +67,18 @@ static void bitmap_set_case(bmap_set_func set_func)
 
     bmap = bitmap_new(BMAP_SIZE);
 
+    /* Set one bit at offset in second word */
+    for (offset = 0; offset <= BITS_PER_LONG; offset++) {
+        bitmap_clear(bmap, 0, BMAP_SIZE);
+        set_func(bmap, BITS_PER_LONG + offset, 1);
+        g_assert_cmpint(find_first_bit(bmap, 2 * BITS_PER_LONG),
+                        ==, BITS_PER_LONG + offset);
+        g_assert_cmpint(find_next_zero_bit(bmap,
+                                           3 * BITS_PER_LONG,
+                                           BITS_PER_LONG + offset),
+                        ==, BITS_PER_LONG + offset + 1);
+    }
+
     /* Both Aligned, set bits [BITS_PER_LONG, 3*BITS_PER_LONG] */
     set_func(bmap, BITS_PER_LONG, 2 * BITS_PER_LONG);
     g_assert_cmpuint(bmap[1], ==, -1ul);
-- 
2.17.1


