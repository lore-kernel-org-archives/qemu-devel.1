Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702E4C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 01:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C542173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 01:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C542173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnusK-0006Cb-Fi
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 21:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hnuro-00040b-4n
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hnurn-0003m4-45
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:05:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:12087)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hnurm-0003j4-ST
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:05:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 18:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,276,1559545200"; d="scan'208";a="319489334"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga004.jf.intel.com with ESMTP; 17 Jul 2019 18:05:47 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 09:04:56 +0800
Message-Id: <20190718010456.4234-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718010456.4234-1-richardw.yang@linux.intel.com>
References: <20190718010456.4234-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] [PATCH v3 2/2] test-bitmap: add test for bitmap_set
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
v3:
  * free bmap
  * all 1's set correctly
  * expand range to 2 long
  * check each possible of offset
  * add a skeleton to test both bitmap_set and bitmap_set_atomic
---
 tests/test-bitmap.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index cb7c5e462d..18aa584591 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -59,12 +59,67 @@ static void check_bitmap_copy_with_offset(void)
     g_free(bmap3);
 }
 
+typedef void (*bmap_set_func)(unsigned long *map, long i, long len);
+static void bitmap_set_case(bmap_set_func set_func)
+{
+    unsigned long *bmap;
+    int offset;
+
+    bmap = bitmap_new(BMAP_SIZE);
+
+    /* Both Aligned, set bits [BITS_PER_LONG, 3*BITS_PER_LONG] */
+    set_func(bmap, BITS_PER_LONG, 2 * BITS_PER_LONG);
+    g_assert_cmpuint(bmap[1], ==, -1ul);
+    g_assert_cmpuint(bmap[2], ==, -1ul);
+    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG), ==, BITS_PER_LONG);
+    g_assert_cmpint(find_next_zero_bit(bmap, 3 * BITS_PER_LONG, BITS_PER_LONG),
+                    ==, 3 * BITS_PER_LONG);
+
+    for (offset = 0; offset <= BITS_PER_LONG; offset++) {
+        bitmap_clear(bmap, 0, BMAP_SIZE);
+        /* End Aligned, set bits [BITS_PER_LONG - offset, 3*BITS_PER_LONG] */
+        set_func(bmap, BITS_PER_LONG - offset, 2 * BITS_PER_LONG + offset);
+        g_assert_cmpuint(bmap[1], ==, -1ul);
+        g_assert_cmpuint(bmap[2], ==, -1ul);
+        g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
+                        ==, BITS_PER_LONG - offset);
+        g_assert_cmpint(find_next_zero_bit(bmap,
+                                           3 * BITS_PER_LONG,
+                                           BITS_PER_LONG - offset),
+                        ==, 3 * BITS_PER_LONG);
+    }
+
+    for (offset = 0; offset <= BITS_PER_LONG; offset++) {
+        bitmap_clear(bmap, 0, BMAP_SIZE);
+        /* Start Aligned, set bits [BITS_PER_LONG, 3*BITS_PER_LONG + offset] */
+        set_func(bmap, BITS_PER_LONG, 2 * BITS_PER_LONG + offset);
+        g_assert_cmpuint(bmap[1], ==, -1ul);
+        g_assert_cmpuint(bmap[2], ==, -1ul);
+        g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
+                        ==, BITS_PER_LONG);
+        g_assert_cmpint(find_next_zero_bit(bmap,
+                                           3 * BITS_PER_LONG + offset,
+                                           BITS_PER_LONG),
+                        ==, 3 * BITS_PER_LONG + offset);
+    }
+
+    g_free(bmap);
+}
+
+static void check_bitmap_set(void)
+{
+    bitmap_set_case(bitmap_set);
+    bitmap_set_case(bitmap_set_atomic);
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


