Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBE8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7DF2080F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTJ4aK9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7DF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBtEW-0001cQ-Cq
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy8-0001yr-6H
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy6-0008Mb-Qd
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsy6-0008MK-Jy
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:26 -0400
Received: by mail-pg1-x543.google.com with SMTP id d4so2902118pgd.10
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sDuc8EGRNaTml8IZLkfOWC9uf/uHcOoeKSMXRUSHBtA=;
 b=DTJ4aK9HwfKrjitfJTj/ZwefS8YvEmDtxQuoM2xXoflI9QZegGjQVE4hXF5ZmdQ/Td
 J0dZuy0n4+h2h+Q6bN+OuzaQhAuuMpLKkdvA2Fu/IzUCmHuHH/XYqVJ5hlE1KYB2PVu9
 q9nhn81yGoTXK1MulaPB8q1LtdSmaPTyT0p5f782J4tQO+CpdUN4psvzUU7BxTvCYT7T
 WgbpTSCLFCzQVcmPyOybGQtZ3kXyEsUSpYqsbi8gWlW/1V/ZAJk/l8WZry4wl8AVxZBc
 9qSdbw3fg0kYomqTLghP3WZySkQWnE4QiFNByE4sU5jkeVuX4m7+1BuodMwOwt8oRGfV
 xFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sDuc8EGRNaTml8IZLkfOWC9uf/uHcOoeKSMXRUSHBtA=;
 b=KmFw1M6uhKdYG9nBvlmJTTKA1qe4ARz1Qbx6DBmRSwpFEF8gdrwHRZXa76dQ5NIbQ+
 8zRK63uK4h315V3/RaCXimWxyt3Q5Ce8snO7pNZN1bYXRIndWhXIu4DhMg1IFBMRsILR
 LMdQ8ZVlm0XnsL0OND6ZoCWoLJI/GtM4ps5u7rUyuGrQc2r6TufWBpsCFP27hCBoI5P8
 S2GCLD56BfhfmwUH8IZDWz7bY2WnvkL0Jn2CZ76GEHMQCeOihlIW2NchSajg0xBvabUP
 rSC12nAE0ssWIUhfD0UvhJ/ebJNR2J8jjiqxjticOv39e0x6Iyyb+cTASK9thU5RzVSa
 saZQ==
X-Gm-Message-State: APjAAAWnxwuJpmR2LeAty1YOS08AbP6tXUrlfct05dXGY4Ug9Pwa4dvr
 yDI3cQ8nZi8hgDgUG4xN5gjUaTLFsKQ=
X-Google-Smtp-Source: APXvYqyMDnR4Fp3xBSyoPWnYNQlMwvx/1WGjO0uazHQkqnht+NjjWkpGBcqAki+OX0nuYAnHWqE6AQ==
X-Received: by 2002:a17:90a:a4c6:: with SMTP id
 l6mr14235314pjw.15.1569124525054; 
 Sat, 21 Sep 2019 20:55:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/20] cputlb: Pass retaddr to tb_invalidate_phys_page_fast
Date: Sat, 21 Sep 2019 20:54:57 -0700
Message-Id: <20190922035458.14879-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than rely on cpu->mem_io_pc, pass retaddr down directly.

Within tb_invalidate_phys_page_range__locked, the is_cpu_write_access
parameter is non-zero exactly when retaddr would be non-zero, so that
is a simple replacement.

Recognize that current_tb_not_found is true only when mem_io_pc
(and now retaddr) are also non-zero, so remove a redundant test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.h |  3 ++-
 accel/tcg/cputlb.c        |  6 +-----
 accel/tcg/translate-all.c | 39 +++++++++++++++++++--------------------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 31f2117188..135c1ea96a 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -27,7 +27,8 @@ struct page_collection *page_collection_lock(tb_page_addr_t start,
                                              tb_page_addr_t end);
 void page_collection_unlock(struct page_collection *set);
 void tb_invalidate_phys_page_fast(struct page_collection *pages,
-                                  tb_page_addr_t start, int len);
+                                  tb_page_addr_t start, int len,
+                                  uintptr_t retaddr);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end);
 void tb_check_watchpoint(CPUState *cpu);
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 257c59c08c..eff129447d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1093,11 +1093,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
         struct page_collection *pages
             = page_collection_lock(ram_addr, ram_addr + size);
-
-        /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
-        cpu->mem_io_pc = retaddr;
-
-        tb_invalidate_phys_page_fast(pages, ram_addr, size);
+        tb_invalidate_phys_page_fast(pages, ram_addr, size, retaddr);
         page_collection_unlock(pages);
     }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index de4b697163..db77fb221b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1889,7 +1889,7 @@ static void
 tb_invalidate_phys_page_range__locked(struct page_collection *pages,
                                       PageDesc *p, tb_page_addr_t start,
                                       tb_page_addr_t end,
-                                      int is_cpu_write_access)
+                                      uintptr_t retaddr)
 {
     TranslationBlock *tb;
     tb_page_addr_t tb_start, tb_end;
@@ -1897,9 +1897,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
 #ifdef TARGET_HAS_PRECISE_SMC
     CPUState *cpu = current_cpu;
     CPUArchState *env = NULL;
-    int current_tb_not_found = is_cpu_write_access;
+    bool current_tb_not_found = retaddr != 0;
+    bool current_tb_modified = false;
     TranslationBlock *current_tb = NULL;
-    int current_tb_modified = 0;
     target_ulong current_pc = 0;
     target_ulong current_cs_base = 0;
     uint32_t current_flags = 0;
@@ -1931,24 +1931,21 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
         if (!(tb_end <= start || tb_start >= end)) {
 #ifdef TARGET_HAS_PRECISE_SMC
             if (current_tb_not_found) {
-                current_tb_not_found = 0;
-                current_tb = NULL;
-                if (cpu->mem_io_pc) {
-                    /* now we have a real cpu fault */
-                    current_tb = tcg_tb_lookup(cpu->mem_io_pc);
-                }
+                current_tb_not_found = false;
+                /* now we have a real cpu fault */
+                current_tb = tcg_tb_lookup(retaddr);
             }
             if (current_tb == tb &&
                 (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
-                /* If we are modifying the current TB, we must stop
-                its execution. We could be more precise by checking
-                that the modification is after the current PC, but it
-                would require a specialized function to partially
-                restore the CPU state */
-
-                current_tb_modified = 1;
-                cpu_restore_state_from_tb(cpu, current_tb,
-                                          cpu->mem_io_pc, true);
+                /*
+                 * If we are modifying the current TB, we must stop
+                 * its execution. We could be more precise by checking
+                 * that the modification is after the current PC, but it
+                 * would require a specialized function to partially
+                 * restore the CPU state.
+                 */
+                current_tb_modified = true;
+                cpu_restore_state_from_tb(cpu, current_tb, retaddr, true);
                 cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
                                      &current_flags);
             }
@@ -2042,7 +2039,8 @@ void tb_invalidate_phys_range(target_ulong start, target_ulong end)
  * Call with all @pages in the range [@start, @start + len[ locked.
  */
 void tb_invalidate_phys_page_fast(struct page_collection *pages,
-                                  tb_page_addr_t start, int len)
+                                  tb_page_addr_t start, int len,
+                                  uintptr_t retaddr)
 {
     PageDesc *p;
 
@@ -2069,7 +2067,8 @@ void tb_invalidate_phys_page_fast(struct page_collection *pages,
         }
     } else {
     do_invalidate:
-        tb_invalidate_phys_page_range__locked(pages, p, start, start + len, 1);
+        tb_invalidate_phys_page_range__locked(pages, p, start, start + len,
+                                              retaddr);
     }
 }
 #else
-- 
2.17.1


