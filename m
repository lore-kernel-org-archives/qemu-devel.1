Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF2C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AF42072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AF42072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIlQ-0007fm-A4
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIjx-0005HI-BU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIjw-0001On-1v
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:21:05 -0500
Received: from relay.sw.ru ([185.231.240.75]:41396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIjs-00015W-KZ; Wed, 05 Feb 2020 06:21:00 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIjk-0006Jd-DJ; Wed, 05 Feb 2020 14:20:52 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 02/10] hbitmap: move hbitmap_iter_next_word to hbitmap.c
Date: Wed,  5 Feb 2020 14:20:33 +0300
Message-Id: <20200205112041.6003-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205112041.6003-1-vsementsov@virtuozzo.com>
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function is definitely internal (it's not used by third party and
it has complicated interface). Move it to .c file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/hbitmap.h | 30 ------------------------------
 util/hbitmap.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 1bf944ca3d..ab227b117f 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -362,34 +362,4 @@ void hbitmap_free_meta(HBitmap *hb);
  */
 int64_t hbitmap_iter_next(HBitmapIter *hbi);
 
-/**
- * hbitmap_iter_next_word:
- * @hbi: HBitmapIter to operate on.
- * @p_cur: Location where to store the next non-zero word.
- *
- * Return the index of the next nonzero word that is set in @hbi's
- * associated HBitmap, and set *p_cur to the content of that word
- * (bits before the index that was passed to hbitmap_iter_init are
- * trimmed on the first call).  Return -1, and set *p_cur to zero,
- * if all remaining words are zero.
- */
-static inline size_t hbitmap_iter_next_word(HBitmapIter *hbi, unsigned long *p_cur)
-{
-    unsigned long cur = hbi->cur[HBITMAP_LEVELS - 1];
-
-    if (cur == 0) {
-        cur = hbitmap_iter_skip_words(hbi);
-        if (cur == 0) {
-            *p_cur = 0;
-            return -1;
-        }
-    }
-
-    /* The next call will resume work from the next word.  */
-    hbi->cur[HBITMAP_LEVELS - 1] = 0;
-    *p_cur = cur;
-    return hbi->pos;
-}
-
-
 #endif
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 7f9b3e0cd7..a368dc5ef7 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -298,6 +298,35 @@ uint64_t hbitmap_count(const HBitmap *hb)
     return hb->count << hb->granularity;
 }
 
+/**
+ * hbitmap_iter_next_word:
+ * @hbi: HBitmapIter to operate on.
+ * @p_cur: Location where to store the next non-zero word.
+ *
+ * Return the index of the next nonzero word that is set in @hbi's
+ * associated HBitmap, and set *p_cur to the content of that word
+ * (bits before the index that was passed to hbitmap_iter_init are
+ * trimmed on the first call).  Return -1, and set *p_cur to zero,
+ * if all remaining words are zero.
+ */
+static size_t hbitmap_iter_next_word(HBitmapIter *hbi, unsigned long *p_cur)
+{
+    unsigned long cur = hbi->cur[HBITMAP_LEVELS - 1];
+
+    if (cur == 0) {
+        cur = hbitmap_iter_skip_words(hbi);
+        if (cur == 0) {
+            *p_cur = 0;
+            return -1;
+        }
+    }
+
+    /* The next call will resume work from the next word.  */
+    hbi->cur[HBITMAP_LEVELS - 1] = 0;
+    *p_cur = cur;
+    return hbi->pos;
+}
+
 /* Count the number of set bits between start and end, not accounting for
  * the granularity.  Also an example of how to use hbitmap_iter_next_word.
  */
-- 
2.21.0


