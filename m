Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A70EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2342621D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2xcwfPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2342621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXDs-0001Lm-60
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcH-0002k9-EF
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcE-0004p0-As
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcE-0004lO-1l
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so1539549pll.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r2Kkjv0LcYhAT4t2h/Z2Rtb/YRP8Pw5ksCfAIsS74Ko=;
 b=B2xcwfPxOi1uavUy8QNEQvUavc03RxaCR7JwEVGDVqh6tGMY3l5kqJqWF5EYwaIA+5
 PXlswRAZfRuWNOsYuOjUL78n2WbEo23hYDEtcsqURgY6TZDrbcPMOZ2s526SGJgJgaqh
 sGgXcdPZu8oo5hCI9mSDcJVbNGQT/E70CrgFka4Yj2wS3XMpuJKMsLba2Ufxway6rnpW
 Vj2XhR5/oZpK4adFJ0Sr5uJDRX1seYpUJ9d+rmY9JUwQI4HMmHDVTy4Q/PXc/yQaADfJ
 FbSH0Ca2hrgKY5dgl3sodACxGDrLAtz8fJ2XR7bWeUc9tu6p3e7tmTO8BK4kyoANbk4/
 Vk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=r2Kkjv0LcYhAT4t2h/Z2Rtb/YRP8Pw5ksCfAIsS74Ko=;
 b=H49RO/r2EbvEa0A34RYxHSeWIV+0oc2crc/RwIXiRAuIZ+DeH25T8yKmR+2o+K6RGi
 xPMDDPiO9+rZ4zA6sTNLoCVaVv6zhjTyNBkQkvvfvLJbNGBEgvv5MCALfS+mXhx+tCvQ
 pWHJGZBh+TresG2IFuWEzwcqMk8sZquncioAmk3xbsewzmf+iAlwQU+9fN2ldXqPzXnW
 Shn5D0codxg6YgmM4004L6UMZcsshLjZ0mEtX0N3vJlXJaLjE+TaE+N4/kkpL134vrcP
 3DgiqTsaVOkhJBin2Qbxj8T66jYJMGrXLuQYzMTirKWBAm13P8jc76NpvqPWQEZQMjj+
 PIOw==
X-Gm-Message-State: APjAAAVBkrcUYTEVYzh7Fvb1KpqkmHOSWlVwTnO/dfiPQM/fNtMxJ006
 LeNXyE+LIUJSxuTwnImFKNHZKjkf/q0=
X-Google-Smtp-Source: APXvYqwYn3KJb/atLwQb+8GodFbrL187ZUtIpvw139BdSrGRO/jx/0ZvAJ9m0iTj6pc2zHc6rKDt/w==
X-Received: by 2002:a17:902:7d92:: with SMTP id
 a18mr4747728plm.243.1569515193401; 
 Thu, 26 Sep 2019 09:26:33 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/18] target/s390: Return exception from translate_pages
Date: Thu, 26 Sep 2019 09:26:08 -0700
Message-Id: <20190926162615.31168-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not raise the exception directly within translate_pages,
but pass it back so that caller may do so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index a9219942b1..5ecd9ee87e 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -423,25 +423,22 @@ nodat:
  * the MEMOP interface.
  */
 static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
-                           target_ulong *pages, bool is_write)
+                           target_ulong *pages, bool is_write, uint64_t *tec)
 {
     uint64_t asc = cpu->env.psw.mask & PSW_MASK_ASC;
     CPUS390XState *env = &cpu->env;
     int ret, i, pflags;
 
     for (i = 0; i < nr_pages; i++) {
-        uint64_t tec;
-
-        ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, &tec);
+        ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, tec);
         if (ret) {
-            trigger_access_exception(env, ret, ILEN_AUTO, tec);
-            return -EFAULT;
+            return ret;
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write,
                                         MEMTXATTRS_UNSPECIFIED)) {
-            trigger_access_exception(env, PGM_ADDRESSING, ILEN_AUTO, 0);
-            return -EFAULT;
+            *tec = 0; /* unused */
+            return PGM_ADDRESSING;
         }
         addr += TARGET_PAGE_SIZE;
     }
@@ -469,6 +466,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 {
     int currlen, nr_pages, i;
     target_ulong *pages;
+    uint64_t tec;
     int ret;
 
     if (kvm_enabled()) {
@@ -482,8 +480,10 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
                + 1;
     pages = g_malloc(nr_pages * sizeof(*pages));
 
-    ret = translate_pages(cpu, laddr, nr_pages, pages, is_write);
-    if (ret == 0 && hostbuf != NULL) {
+    ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
+    if (ret) {
+        trigger_access_exception(&cpu->env, ret, ILEN_AUTO, tec);
+    } else if (hostbuf != NULL) {
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-- 
2.17.1


