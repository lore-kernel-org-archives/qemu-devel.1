Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69985C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 03:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352CE214AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 03:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352CE214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJV5p-0002hc-GM
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 23:30:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJV4N-0001u8-U5
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJV4K-0006c0-4h
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:29:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:62410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJV4J-0006ZL-Rd
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:29:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Apr 2019 20:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; d="scan'208";a="145518825"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 20:28:59 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 11:28:31 +0800
Message-Id: <20190425032831.22551-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.31
Subject: [Qemu-devel] [PATCH] bitmap: get last word mask from nr directly
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: corentincj@iksaif.net, pl@kamp.de, Wei Yang <richardw.yang@linux.intel.com>,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425032831.SCPmAnSAMDkL1F1PD4kcPjkke_iaMiBVJdkAzTELa14@z>

The value left in nr is the number of bits for the last word, which
could be calculate the last word mask directly.

Remove the unnecessary size.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 util/bitmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/bitmap.c b/util/bitmap.c
index cb618c65a5..5aa60b8717 100644
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
@@ -221,7 +220,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
 void bitmap_clear(unsigned long *map, long start, long nr)
 {
     unsigned long *p = map + BIT_WORD(start);
-    const long size = start + nr;
     int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
     unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
 
@@ -235,7 +233,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
         p++;
     }
     if (nr) {
-        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
         *p &= ~mask_to_clear;
     }
 }
-- 
2.19.1


