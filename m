Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C772C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 06:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244BB2051A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 06:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244BB2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGztC-0005ik-8Z
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 02:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1jGzsD-0004pI-D8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 02:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1jGzsC-000423-Bl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 02:50:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:16676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1jGzsC-0003t9-2N
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 02:50:44 -0400
IronPort-SDR: ORm91fHsfWFy6YJtaMVwlVpEtlQ8AB2+ApfEBTeZnpL+WrthEfq1PtaCWxlzhsl4T/+7jKAxme
 PFS/ZinR4lJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 23:50:38 -0700
IronPort-SDR: yel406oUMlWhQztIFBraFpRZeAEeKSbpRJgSJI6ESH2cLGAuzZWeXQLG52FfIdF6KmH5HbZpuQ
 7Jn51BvpXN7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; d="scan'208";a="326149630"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga001.jf.intel.com with ESMTP; 24 Mar 2020 23:50:37 -0700
From: Robert Hoo <robert.hu@linux.intel.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org
Subject: [PATCH 2/2] util/bufferiszero: improve avx2 accelerator
Date: Wed, 25 Mar 2020 14:50:21 +0800
Message-Id: <1585119021-46593-2-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585119021-46593-1-git-send-email-robert.hu@linux.intel.com>
References: <1585119021-46593-1-git-send-email-robert.hu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.120
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
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By increasing avx2 length_to_accel to 128, we can simplify its logic and reduce a
branch.

The authorship of this patch actually belongs to Richard Henderson <richard.henderson@linaro.org>,
I just fix a boudary case on his original patch.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 util/bufferiszero.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index b801253..695bb4c 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -158,27 +158,19 @@ buffer_zero_avx2(const void *buf, size_t len)
     __m256i *p = (__m256i *)(((uintptr_t)buf + 5 * 32) & -32);
     __m256i *e = (__m256i *)(((uintptr_t)buf + len) & -32);
 
-    if (likely(p <= e)) {
-        /* Loop over 32-byte aligned blocks of 128.  */
-        do {
-            __builtin_prefetch(p);
-            if (unlikely(!_mm256_testz_si256(t, t))) {
-                return false;
-            }
-            t = p[-4] | p[-3] | p[-2] | p[-1];
-            p += 4;
-        } while (p <= e);
-    } else {
-        t |= _mm256_loadu_si256(buf + 32);
-        if (len <= 128) {
-            goto last2;
+    /* Loop over 32-byte aligned blocks of 128.  */
+    while (p <= e) {
+        __builtin_prefetch(p);
+        if (unlikely(!_mm256_testz_si256(t, t))) {
+            return false;
         }
-    }
+        t = p[-4] | p[-3] | p[-2] | p[-1];
+        p += 4;
+    } ;
 
     /* Finish the last block of 128 unaligned.  */
     t |= _mm256_loadu_si256(buf + len - 4 * 32);
     t |= _mm256_loadu_si256(buf + len - 3 * 32);
- last2:
     t |= _mm256_loadu_si256(buf + len - 2 * 32);
     t |= _mm256_loadu_si256(buf + len - 1 * 32);
 
@@ -263,7 +255,7 @@ static void init_accel(unsigned cache)
     }
     if (cache & CACHE_AVX2) {
         fn = buffer_zero_avx2;
-        length_to_accel = 64;
+        length_to_accel = 128;
     }
 #endif
 #ifdef CONFIG_AVX512F_OPT
-- 
1.8.3.1


