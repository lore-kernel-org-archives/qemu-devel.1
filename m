Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE55C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1A721D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdE59Ww5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1A721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDX9p-0005xe-IA
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcF-0002i6-Gr
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcD-0004o7-As
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:39 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:43450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcD-0004km-1m
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:37 -0400
Received: by mail-pg1-f175.google.com with SMTP id v27so1820601pgk.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o++bPpRnFnFKhUL/Zv8ZfWMYMEUhC7pytRfRg2vZulI=;
 b=OdE59Ww55qQlwpP7iiIrBzGgfg8sml2mVIpCW9Bjyebl/v2r23SubzadLssPynvS9/
 MWTqkyxkOvqq0KwcZfM6bgEcEWnXSLNdK6rz0mUrjflpqQCjSXeBTTYwb4/gqLbHATiU
 d87IEDADaJjDKKt5SLuDjSpYp1aDyE6JSnv1IjgxDOnfV54fvmWVKwDlcXVjBuv6+GRd
 3YPW0LhXrooPWJg7MN8pHUYjs1U9XCby0yfXFnJxOCnePEnubhulbQqNZZBST0DQdBTJ
 jVK6UfU0r5o+JcSwFwbxPkcV0UVLpkQG+OR9dszPfN6W8O7d4hXy5FL8oYtwDK7asx2R
 Q5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o++bPpRnFnFKhUL/Zv8ZfWMYMEUhC7pytRfRg2vZulI=;
 b=pTgg1vecMy7nlDbap+7qz24+HgTBewqGH4NpHEKZB0jxwj+bB/WxLfsKYtcTf3Pl6o
 g8eNRMVebRoZfhCFniUb1EOgqdJh+LwfoKShaDJXn4jxiwScnOG3MzFWXr2yg1OueoYT
 uWw6/E97+NzvMBhhjfki+gi0IAidU1ogRA9yfdrqSSwNK1V447ktbCOzt7lOaKXD6mBT
 pXnpVTrhyqNrchpUkd5N8bywzaSkiLqSqI48vPW55Mm36+6Qjs875gQ88GlReNEAZDkn
 J3xfnvUjS5ib/QcsjZXERppGlvkOLvDwcBtFxJulvMQX0DOEB4CvbJ5K2Gbkv1ywdDd7
 YJ2A==
X-Gm-Message-State: APjAAAWPgz1PSDvrt00yDlUkhVfGHl64NZ5A1dtANDlNzIf+Xb7uq0to
 vwnVNoVhnT/q/EgwBp5HFRYpdTSuZH4=
X-Google-Smtp-Source: APXvYqz1xy18XumnE50oogX2VW0g54yuvfsMLiH9UB5ZCd7n7AyjecL1OfdDKjH5mCC1TZ54X0JEXg==
X-Received: by 2002:a17:90a:e38f:: with SMTP id
 b15mr4337462pjz.140.1569515192123; 
 Thu, 26 Sep 2019 09:26:32 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/18] target/s390: Return exception from mmu_translate
Date: Thu, 26 Sep 2019 09:26:07 -0700
Message-Id: <20190926162615.31168-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.175
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

Do not raise the exception directly within mmu_translate,
but pass it back so that caller may do so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |  2 +-
 target/s390x/excp_helper.c |  4 ++--
 target/s390x/mem_helper.c  | 13 ++++++++++---
 target/s390x/mmu_helper.c  | 36 ++++++++++++++----------------------
 4 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c4388aaf23..c993c3ef40 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -360,7 +360,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
 
 /* mmu_helper.c */
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, bool exc);
+                  target_ulong *raddr, int *flags, uint64_t *tec);
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags, uint64_t *tec);
 
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 906b87c071..6a0728b65f 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -140,8 +140,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
-        fail = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, true);
-        excp = 0; /* exception already raised */
+        excp = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, &tec);
+        fail = excp;
     } else if (mmu_idx == MMU_REAL_IDX) {
         /* 31-Bit mode */
         if (!(env->psw.mask & PSW_MASK_64)) {
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 7d2a652823..e15aa296dd 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2364,8 +2364,8 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     CPUState *cs = env_cpu(env);
     uint32_t cc = 0;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
-    uint64_t ret;
-    int old_exc, flags;
+    uint64_t ret, tec;
+    int old_exc, flags, exc;
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
@@ -2373,7 +2373,14 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     }
 
     old_exc = cs->exception_index;
-    if (mmu_translate(env, addr, 0, asc, &ret, &flags, true)) {
+    exc = mmu_translate(env, addr, 0, asc, &ret, &flags, &tec);
+    if (exc) {
+        /*
+         * We don't care about ILEN or TEC, as we're not going to
+         * deliver the exception -- thus resetting exception_index below.
+         * TODO: clean this up.
+         */
+        trigger_pgm_exception(env, exc, ILEN_UNWIND);
         cc = 3;
     }
     if (cs->exception_index == EXCP_PGM) {
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index ed6570db62..a9219942b1 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -349,17 +349,15 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
  * @return       0 if the translation was successful, -1 if a fault occurred
  */
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, bool exc)
+                  target_ulong *raddr, int *flags, uint64_t *tec)
 {
-    /* Code accesses have an undefined ilc, let's use 2 bytes. */
-    const int ilen = (rw == MMU_INST_FETCH) ? 2 : ILEN_AUTO;
-    uint64_t tec = (vaddr & TARGET_PAGE_MASK) | (asc >> 46) |
-                   (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ);
     uint64_t asce;
     int r;
 
-
+    *tec = (vaddr & TARGET_PAGE_MASK) | (asc >> 46) |
+            (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ);
     *flags = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+
     if (is_low_address(vaddr & TARGET_PAGE_MASK) && lowprot_enabled(env, asc)) {
         /*
          * If any part of this page is currently protected, make sure the
@@ -371,10 +369,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
          */
         *flags |= PAGE_WRITE_INV;
         if (is_low_address(vaddr) && rw == MMU_DATA_STORE) {
-            if (exc) {
-                trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
-            }
-            return -EACCES;
+            return PGM_PROTECTION;
         }
     }
 
@@ -404,20 +399,14 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
     /* perform the DAT translation */
     r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw);
     if (unlikely(r)) {
-        if (exc) {
-            trigger_access_exception(env, r, ilen, tec);
-        }
-        return -1;
+        return r;
     }
 
     /* check for DAT protection */
     if (unlikely(rw == MMU_DATA_STORE && !(*flags & PAGE_WRITE))) {
-        if (exc) {
-            /* DAT sets bit 61 only */
-            tec |= 0x4;
-            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
-        }
-        return -1;
+        /* DAT sets bit 61 only */
+        *tec |= 0x4;
+        return PGM_PROTECTION;
     }
 
 nodat:
@@ -441,9 +430,12 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
     int ret, i, pflags;
 
     for (i = 0; i < nr_pages; i++) {
-        ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, true);
+        uint64_t tec;
+
+        ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, &tec);
         if (ret) {
-            return ret;
+            trigger_access_exception(env, ret, ILEN_AUTO, tec);
+            return -EFAULT;
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write,
-- 
2.17.1


