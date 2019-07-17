Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AC7C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6591220665
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6591220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hne6p-0005vp-9J
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 03:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hne6Y-00050f-1S
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hne6W-0003uX-UY
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:11:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:60321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hne6W-0003sM-L7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:11:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 00:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; d="scan'208";a="161670181"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga008.jf.intel.com with ESMTP; 17 Jul 2019 00:11:53 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 15:11:13 +0800
Message-Id: <20190717071114.14772-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717071114.14772-1-richardw.yang@linux.intel.com>
References: <20190717071114.14772-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v2 1/2] bitmap: get last word mask from nr
 directly
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

The value left in nr is the number of bits for the last word, which
could be calculate the last word mask directly.

Remove the unnecessary size.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2: refine bitmap_set_atomic too, suggested from Peter
---
 util/bitmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/util/bitmap.c b/util/bitmap.c
index 1753ff7f5b..5b15249796 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 void bitmap_set(unsigned long *map, long start, long nr)
 {
     unsigned long *p = map + BIT_WORD(start);
-    const long size = start + nr;
     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
 
@@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
         p++;
     }
     if (nr) {
-        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
         *p |= mask_to_set;
     }
 }
@@ -182,7 +181,6 @@ void bitmap_set(unsigned long *map, long start, long nr)
 void bitmap_set_atomic(unsigned long *map, long start, long nr)
 {
     unsigned long *p = map + BIT_WORD(start);
-    const long size = start + nr;
     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
 
@@ -208,7 +206,7 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
 
     /* Last word */
     if (nr) {
-        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
         atomic_or(p, mask_to_set);
     } else {
         /* If we avoided the full barrier in atomic_or(), issue a
@@ -221,7 +219,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
 void bitmap_clear(unsigned long *map, long start, long nr)
 {
     unsigned long *p = map + BIT_WORD(start);
-    const long size = start + nr;
     int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
     unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
 
@@ -235,7 +232,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
         p++;
     }
     if (nr) {
-        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
         *p &= ~mask_to_clear;
     }
 }
-- 
2.17.1


