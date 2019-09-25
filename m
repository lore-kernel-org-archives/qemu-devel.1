Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C20C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A07E2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F69/UaKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A07E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCcH-0005kI-1t
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIs-00020u-6y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIq-0004WW-Qv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:18 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIo-0004T7-Sb
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:16 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so4173653pfl.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MGym46ItcVgrFEop1vv6vOBmHP52BveKepQrEUSeRf8=;
 b=F69/UaKN4W2rsE5fVmNSn9hPI1nAh1iHfCIvkiuPnoI6UPuG01lZsNOGl6Ss7X/nEX
 yul8FhTqwAiztkTzCfmc5J72iK/1kLahPqUnS97vFFFalgfzdAAzxGrRra5gdGR6i5t9
 9VyZr+mcKb8bLFfuO85oYXazdC4r1TA0/DMqx9JfaV9NLdl2TiZRJ3FAmyEcQqfesC6O
 QAOcK63SNaQwWMfKDx4tzgaPt1wX5qgb1yKa20N2KNLcCDynYJOD8V++CozRNSa6erxN
 XWHqRBXgF/yitzcMq+2urThLkeqdZ3ICM4cEKPzNzLtLDJQ0II4RtD8qB0lCXAe5i0vK
 y5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MGym46ItcVgrFEop1vv6vOBmHP52BveKepQrEUSeRf8=;
 b=iKhEiJIj1HxGDBSYywvuLgRsmI/PCk6Q8yOUM0azHhsXyZk6slqCODoisUMT81poj9
 2J0zW8hB3ldY+MZJm13OkRKzPBf4rl1sCpNUFRXU+ptLwaBuOj9F2lPVONi7RYnTROeQ
 ahuYwfgKn15+dQd3ygQx7hBGlsH8kb4xltLBTj7RLneMwkl0h4jy8SwEermp7uzu8bxH
 AEN9WWTDUZRLBQKy05r6C5l1f20P8CIl+IRxlMBJP3TFvFuCcAcr+X4UrgriFWh/5xWn
 QPZdtvatlEpZkyRu/KCzmw/V49Hv4vx5aXFIDW6vGxnYXX0qXnfVuxlqFpWoQH1kWqHR
 6dCQ==
X-Gm-Message-State: APjAAAWglx0n0sfes5c/JKkWl8vGsNDREFRq5SaYXUMava9MHGSqMazq
 m3K23HpPm/kmV/HohJGmFiqODtzb8aI=
X-Google-Smtp-Source: APXvYqzCTJsBwhAhcAp2IUcXNQtCHogCjNbiGPKqpL7CBE1uFL7aT3nqfGzrSg1ElCOtKM5Ntv03eQ==
X-Received: by 2002:a17:90a:264a:: with SMTP id
 l68mr8280471pje.74.1569437172186; 
 Wed, 25 Sep 2019 11:46:12 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:46:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] cputlb: Pass retaddr to tb_invalidate_phys_page_fast
Date: Wed, 25 Sep 2019 11:45:47 -0700
Message-Id: <20190925184548.30673-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than rely on cpu->mem_io_pc, pass retaddr down directly.

Within tb_invalidate_phys_page_range__locked, the is_cpu_write_access
parameter is non-zero exactly when retaddr would be non-zero, so that
is a simple replacement.

Recognize that current_tb_not_found is true only when mem_io_pc
(and now retaddr) are also non-zero, so remove a redundant test.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
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
index 4b24811ce7..defc8d5929 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1094,11 +1094,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
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


