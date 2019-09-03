Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5E3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9378A21881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAc1hO9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9378A21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bu9-000693-Eq
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN4-0001PV-6x
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN2-0003tH-Te
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:39315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BN2-0003sv-Mr
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id bd8so1767124plb.6
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4hy82QgJUYjjhSQJRivLUVd+yZYge9fg7c759/kiQtk=;
 b=BAc1hO9froJH+HxamFXVaI4SCfXzyOVFPo6PFjPs0jp7nyiWDttIK2ubV+kb7P6vMe
 ltMzs6LUQi009lBuD2KVUyn8/WF4CQhJ3Tzs5FGy1whzev8sNm5J8V1tC77APM90PEgn
 Srsxff8WOTRwmnaK0XrdqJSFJD9ObRkKzCE17iUvC4fC67qiVOHwDi+xUi4oZg6ECSDU
 XXypujcyaLIyUNgPUeIhGUkbGirlj81KyfUKnIB8A6SwoCrlNUewWbE68zzqH5tA9f2y
 rn5HVyBwvLA0bfAjT2CdOZ9kklxQbSX8GLIdFmY6HMa+3Cl2wud6UWpMgEfPrPjHCwLl
 itzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4hy82QgJUYjjhSQJRivLUVd+yZYge9fg7c759/kiQtk=;
 b=UxMe1HDL/wjeTQ8y9oJzqRfaOUKXGPvPDVxDk1s+zkj98EbqnmiL9lSEZSZYkEPyf7
 cT5xdHlV3VjbNoQ+PrQV5+n7E/BUl6HikI8OX3mFyYyfuS+bol/25mKiQtVJ/7QpDJ5o
 9Hu2MSyyc9XAxS2A1pwrWPmwgd65klH84mjrzuj8ixeGS5p3fhZaa5qhuhYrg0IOGnr8
 12AeODLcxwT/Z3JvylrvNwEALmXCO5+LPJEivQOhKkH00DX6S/eT7jCvA/WD5lJic+rb
 u6HbF8yWZVOeSXW3BhKgkyC7ubMSVtXy1F7yCSTDl8bT6GUgehPNB2iimzdbscwDG4oZ
 5QMA==
X-Gm-Message-State: APjAAAWlzv4/NWI8pnHABJOht7N7PDd9Iu8QNFNxTvvI8B7mMvSqu8cT
 M9L9FnrQyNnKTA18aQEvyh7YoVXiskE=
X-Google-Smtp-Source: APXvYqzRcEvIv0Vxqpi4Gka84XhFj00jfTiNAp1lhh1icycoRlmDsN4hjMLT8uUng/C42dBlNSkzTw==
X-Received: by 2002:a17:902:aa02:: with SMTP id
 be2mr10797954plb.172.1567526966733; 
 Tue, 03 Sep 2019 09:09:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:43 -0700
Message-Id: <20190903160858.5296-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::632
Subject: [Qemu-devel] [PATCH 21/36] exec: Factor out core logic of
 check_watchpoint()
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We want to perform the same checks in probe_write() to trigger a cpu
exit before doing any modifications. We'll have to pass a PC.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190823100741.9621-9-david@redhat.com>
[rth: Use vaddr for len, like other watchpoint functions;
Move user-only stub to static inline.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  7 +++++++
 exec.c                | 26 ++++++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6de688059d..7bd8bed5b2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1091,6 +1091,11 @@ static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
 static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
 {
 }
+
+static inline void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
+                                        MemTxAttrs atr, int fl, uintptr_t ra)
+{
+}
 #else
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
@@ -1098,6 +1103,8 @@ int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
+                          MemTxAttrs attrs, int flags, uintptr_t ra);
 #endif
 
 /**
diff --git a/exec.c b/exec.c
index 31fb75901f..cb6f5763dc 100644
--- a/exec.c
+++ b/exec.c
@@ -2789,11 +2789,10 @@ static const MemoryRegionOps notdirty_mem_ops = {
 };
 
 /* Generate a debug exception if a watchpoint has been hit.  */
-static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
+void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
+                          MemTxAttrs attrs, int flags, uintptr_t ra)
 {
-    CPUState *cpu = current_cpu;
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    target_ulong vaddr;
     CPUWatchpoint *wp;
 
     assert(tcg_enabled());
@@ -2804,17 +2803,17 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
         cpu_interrupt(cpu, CPU_INTERRUPT_DEBUG);
         return;
     }
-    vaddr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
-    vaddr = cc->adjust_watchpoint_address(cpu, vaddr, len);
+
+    addr = cc->adjust_watchpoint_address(cpu, addr, len);
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (cpu_watchpoint_address_matches(wp, vaddr, len)
+        if (cpu_watchpoint_address_matches(wp, addr, len)
             && (wp->flags & flags)) {
             if (flags == BP_MEM_READ) {
                 wp->flags |= BP_WATCHPOINT_HIT_READ;
             } else {
                 wp->flags |= BP_WATCHPOINT_HIT_WRITE;
             }
-            wp->hitaddr = vaddr;
+            wp->hitaddr = MAX(addr, wp->vaddr);
             wp->hitattrs = attrs;
             if (!cpu->watchpoint_hit) {
                 if (wp->flags & BP_CPU &&
@@ -2829,11 +2828,14 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                 if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                     cpu->exception_index = EXCP_DEBUG;
                     mmap_unlock();
-                    cpu_loop_exit(cpu);
+                    cpu_loop_exit_restore(cpu, ra);
                 } else {
                     /* Force execution of one insn next time.  */
                     cpu->cflags_next_tb = 1 | curr_cflags();
                     mmap_unlock();
+                    if (ra) {
+                        cpu_restore_state(cpu, ra, true);
+                    }
                     cpu_loop_exit_noexc(cpu);
                 }
             }
@@ -2843,6 +2845,14 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
     }
 }
 
+static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
+{
+    CPUState *cpu = current_cpu;
+    vaddr addr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
+
+    cpu_check_watchpoint(cpu, addr, len, attrs, flags, 0);
+}
+
 /* Watchpoint access routines.  Watchpoints are inserted using TLB tricks,
    so these check for a hit then pass through to the normal out-of-line
    phys routines.  */
-- 
2.17.1


