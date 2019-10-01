Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72058ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C77F215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfohzBHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C77F215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLyD-0005yy-03
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlH-0001cm-RX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlG-0005YI-Mt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:31 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlG-0005Xw-Hg
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:30 -0400
Received: by mail-pg1-x542.google.com with SMTP id y35so10119373pgl.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qV5DRSUK9uxLr8VUlGB8IPLCjYhHZMF32okiY81/uHY=;
 b=sfohzBHOfz0OtcjcoVM3eEN2UWS/MQfxBDhy+XwtpM/X1TS4xXyM1fv8yfRp883mxA
 O57Xr9tC6hGZcqCm5uIK1ra4vG5VWcHRhNJjBb9S3vwGiJgwnhcQfBF/bAU0gMOpxyqy
 lhCaOgya7pBK+ew6ruys5zeuwSnhOQJKrLPtJaUQmrcn4UZTznUY3PqYUrdp2HLskmw2
 q7rngMc41RR1BN8orbuVr67Hy0HuQ/NJn/eBRB61Mfc8mn1JYEgyRKImkLa1uz8scdkw
 wSHDqpQmlDOBtaS07Wl0mWH6HgjAHXZSH0mFttQL2CzAqWEQhY9/NTiR8y67qr2FPCVz
 gjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qV5DRSUK9uxLr8VUlGB8IPLCjYhHZMF32okiY81/uHY=;
 b=Hh/IyGfKXoYJuWL31ohZwV3q3Rhe8d4Hy4IhqUG9JrYDOQ2hiFk6LQLWdC/rOhCGfQ
 THTL7MEHZX5NLbg6s79U8kNpX77L7xDd1Yzr0wVbXqXGKgTkr058bxHzOxnhoHYBu3sy
 PXYxQGZhSPeok8223XjEUbZbKyqIytTVHPSf8KbZJ73EOOz1pkQze3hJLkhWzRc/A5tc
 Q15DuP0tjG8fyhgtmnXjDQEnOEARqHRHQ488I9W9Uikie9MhPfgpyWXg8lgdN6lX7B99
 +VkQ4CTZ4BKQc5XZkf/d/lMjwmxWdZjcG/8I7ucLx/6dwZGiIkgrWoMhmjCsV+HQtQsR
 k1lw==
X-Gm-Message-State: APjAAAXATKYJ9jLUjkqjZfAku2VLoiO6+ehL9GtqfiUVGmhi7/bMjm1G
 ncc5K+aV5WqG6103HRvLDZpvB0GnTXI=
X-Google-Smtp-Source: APXvYqzb+fvvSKvBh0eMaLRqZm4jDgGkcgqpIdBLKXK//RY2rscoxI3ouw9J/gqrGiaLiEuUFWcnRQ==
X-Received: by 2002:a17:90a:1b46:: with SMTP id
 q64mr6780639pjq.97.1569950188996; 
 Tue, 01 Oct 2019 10:16:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/18] target/s390x: Return exception from translate_pages
Date: Tue,  1 Oct 2019 10:16:06 -0700
Message-Id: <20191001171614.8405-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not raise the exception directly within translate_pages,
but pass it back so that caller may do so.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 001d0a9c8a..869debd30a 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -451,25 +451,22 @@ nodat:
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
@@ -497,6 +494,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 {
     int currlen, nr_pages, i;
     target_ulong *pages;
+    uint64_t tec;
     int ret;
 
     if (kvm_enabled()) {
@@ -510,8 +508,10 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
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


