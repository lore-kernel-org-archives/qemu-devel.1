Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4083C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7AF20665
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7AF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hne73-00075b-Mj
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 03:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hne6Z-000567-PP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hne6X-0003vN-Mr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:11:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:60321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hne6X-0003sM-Dk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:11:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 00:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; d="scan'208";a="161670201"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga008.jf.intel.com with ESMTP; 17 Jul 2019 00:11:55 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 15:11:14 +0800
Message-Id: <20190717071114.14772-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717071114.14772-1-richardw.yang@linux.intel.com>
References: <20190717071114.14772-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v2 2/2] test-bitmap: add test for bitmap_set
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

Add a test for bitmap_set. There are three cases:

  * Both start and end is BITS_PER_LONG aligned
  * Only start is BITS_PER_LONG aligned
  * Only end is BITS_PER_LONG aligned

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 tests/test-bitmap.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index cb7c5e462d..1f0123f604 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -59,12 +59,45 @@ static void check_bitmap_copy_with_offset(void)
     g_free(bmap3);
 }
 
+static void check_bitmap_set(void)
+{
+    unsigned long *bmap;
+
+    bmap = bitmap_new(BMAP_SIZE);
+
+    /* Both Aligned, set bits [BITS_PER_LONG, 2*BITS_PER_LONG] */
+    bitmap_set(bmap, BITS_PER_LONG, BITS_PER_LONG);
+    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG), ==, BITS_PER_LONG);
+    g_assert_cmpint(find_next_zero_bit(bmap, 2 * BITS_PER_LONG, BITS_PER_LONG),
+                    ==, 2 * BITS_PER_LONG);
+
+    bitmap_clear(bmap, 0, BMAP_SIZE);
+    /* End Aligned, set bits [BITS_PER_LONG - 5, 2*BITS_PER_LONG] */
+    bitmap_set(bmap, BITS_PER_LONG - 5, BITS_PER_LONG + 5);
+    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
+                    ==, BITS_PER_LONG - 5);
+    g_assert_cmpint(find_next_zero_bit(bmap,
+                                       2 * BITS_PER_LONG, BITS_PER_LONG - 5),
+                    ==, 2 * BITS_PER_LONG);
+
+    bitmap_clear(bmap, 0, BMAP_SIZE);
+    /* Start Aligned, set bits [BITS_PER_LONG, 2*BITS_PER_LONG + 5] */
+    bitmap_set(bmap, BITS_PER_LONG, BITS_PER_LONG + 5);
+    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
+                    ==, BITS_PER_LONG);
+    g_assert_cmpint(find_next_zero_bit(bmap,
+                                       2 * BITS_PER_LONG + 5, BITS_PER_LONG),
+                    ==, 2 * BITS_PER_LONG + 5);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     g_test_add_func("/bitmap/bitmap_copy_with_offset",
                     check_bitmap_copy_with_offset);
+    g_test_add_func("/bitmap/bitmap_set",
+                    check_bitmap_set);
 
     g_test_run();
 
-- 
2.17.1


