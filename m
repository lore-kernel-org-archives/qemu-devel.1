Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5631AC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 19:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AA62067D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 19:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AA62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htco2-00060D-Cv
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 15:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41080)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htcli-0005MB-8u
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htclU-0002fo-Ty
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:59:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:46130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htclA-0002UE-7t; Fri, 02 Aug 2019 14:58:37 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1htcl5-0003Cw-Hn; Fri, 02 Aug 2019 21:58:31 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri,  2 Aug 2019 21:58:30 +0300
Message-Id: <20190802185830.74648-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hbitmap_reset is broken: it rounds up the requested region. It leads to
the following bug, which is shown by fixed test:

assume granularity = 2
set(0, 3) # count becomes 4
reset(0, 1) # count becomes 2

But user of the interface assume that virtual bit 1 should be still
dirty, so hbitmap should report count to be 4!

In other words, because of granularity, when we set one "virtual" bit,
yes, we make all "virtual" bits in same chunk to be dirty. But this
should not be so for reset.

Fix this, aligning bound correctly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

Hmm, is it a bug or feature? :)
I don't have a test for mirror yet, but I think that sync mirror may be broken
because of this, as do_sync_target_write() seems to be using unaligned reset.

 tests/test-hbitmap.c |  2 +-
 util/hbitmap.c       | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 592d8219db..0008025a9f 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -424,7 +424,7 @@ static void test_hbitmap_granularity(TestHBitmapData *data,
     hbitmap_test_set(data, 0, 3);
     g_assert_cmpint(hbitmap_count(data->hb), ==, 4);
     hbitmap_test_reset(data, 0, 1);
-    g_assert_cmpint(hbitmap_count(data->hb), ==, 2);
+    g_assert_cmpint(hbitmap_count(data->hb), ==, 4);
 }
 
 static void test_hbitmap_iter_granularity(TestHBitmapData *data,
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 7905212a8b..61a813994a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -473,15 +473,29 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, uint64_t count)
 {
     /* Compute range in the last layer.  */
     uint64_t first;
-    uint64_t last = start + count - 1;
+    uint64_t last;
+    uint64_t end = start + count;
+    uint64_t gran = UINT64_C(1) << hb->granularity;
 
-    trace_hbitmap_reset(hb, start, count,
-                        start >> hb->granularity, last >> hb->granularity);
+    /*
+     * We should clear only bits, fully covered by requested region. Otherwise
+     * we may clear something that is actually still dirty.
+     */
+    first = DIV_ROUND_UP(start, gran);
 
-    first = start >> hb->granularity;
-    last >>= hb->granularity;
+    if (end == hb->orig_size) {
+        end = DIV_ROUND_UP(end, gran);
+    } else {
+        end = end >> hb->granularity;
+    }
+    if (end <= first) {
+        return;
+    }
+    last = end - 1;
     assert(last < hb->size);
 
+    trace_hbitmap_reset(hb, start, count, first, last);
+
     hb->count -= hb_count_between(hb, first, last);
     if (hb_reset_between(hb, HBITMAP_LEVELS - 1, first, last) &&
         hb->meta) {
-- 
2.18.0


