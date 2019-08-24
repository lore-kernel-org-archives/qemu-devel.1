Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4601C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66FB2133F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6nbMQmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66FB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1dmU-0005sm-UZ
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 17:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dgc-0001Lg-Q9
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dga-00031Q-Mf
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:45380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1dgY-0002yr-O2
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id w26so9018583pfq.12
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4hy82QgJUYjjhSQJRivLUVd+yZYge9fg7c759/kiQtk=;
 b=r6nbMQmcsQngIJjNGcIIA3MBEIbWepuenJmElHgdCfEI77FMfVJXrGuwbAyXSO0FsX
 JEQwxU9awFnukcky7YvXV+T94J/5w09OtobnOqhHLAcKg41NouPeMO5HLR968sv88xOc
 dXG13rnadC69C7pKcF7nZsatTAtyViq6wnCM9FMxaChUL1sOvvnaGgrnFowQlk8s+UgQ
 h+BlgE3xdoOFax7SnjR7wjVvPZG/7rymlIDCBtKkWxlhqerVJZTDPMCeBa9EQc3ZKkvP
 U/1z5lztBG6m45HMd00KD6xADGMUc8yV77seml4VAMu8hADsIblcOGDj3J/l4lQ0N8eQ
 JMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4hy82QgJUYjjhSQJRivLUVd+yZYge9fg7c759/kiQtk=;
 b=rg1KiDz4kl4GnZzs+wJya6gFmVsDt9lHJncq4bd1BN9CuAMIrGyzIuZY055gJkoz6h
 X+XV4Nu8Y+oK7vLqAjw1OdlUqyzLwU4a6qnye8Lzh2upu5W7vsIHgkxqwhlOeUTC81sg
 pD2+E/t1vLUrdj7TYjNdpaZrrWfMjiXM+2diwK8V61af1IPpZ/8K52xvt9be0a3qC+T8
 yizPeQ513y+2LG5xPDtLrriw9cvEa8/rrSPwHhYs/aG2H/7mQMZHnk8fAfCO1wff+1HO
 Hvybc4cz00bB/4T1s2KXDgjxaqJuKtb81g4b1axNDPclO4dSFhSA33F05aWoJG1QOH8z
 r03w==
X-Gm-Message-State: APjAAAV+R4Lws9o7MBVh/LElY5UGagRtC4VlrfOXF/ZWDOBEh3tRfGUQ
 CLClTyaByqhCBO2rsfiiYyEADesfR/k=
X-Google-Smtp-Source: APXvYqyOTSvn+cgIXvJjzDIsV/kDwQrGmeu5o7kmsRiFIFQyXrVbDFKPBr4aRzzT8UFagobkJKA4zg==
X-Received: by 2002:a62:e515:: with SMTP id n21mr12541230pff.186.1566682497057; 
 Sat, 24 Aug 2019 14:34:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 81sm6325753pfx.111.2019.08.24.14.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2019 14:34:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 14:34:47 -0700
Message-Id: <20190824213451.31118-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190824213451.31118-1-richard.henderson@linaro.org>
References: <20190824213451.31118-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
Subject: [Qemu-devel] [PATCH 2/6] exec: Factor out core logic of
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
Cc: peter.maydell@linaro.org, david@redhat.com
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


