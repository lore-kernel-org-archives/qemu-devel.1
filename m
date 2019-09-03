Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE3C22CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2QMifnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE3C22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C3d-0001jU-Rt
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNK-0001pf-TC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNJ-00049T-Fd
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:46 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BNJ-000490-8p
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:45 -0400
Received: by mail-pf1-x441.google.com with SMTP id w16so11073524pfn.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=N5NztJfh5BzMOtf9h7VP/IFXxLeIqYtsDkIeRVHhk+A=;
 b=C2QMifnvGVofYTbNdgkO7I1yucfD5L8BtHvzazYLRiKoaR+qZ9ux8gBcOf4IL3KydI
 QNd2jWTAWl/+oSXdjLh2uhChmDLIBZuXgdITOzIvM3rj0DTVwKNCuZi6FG9dPM20Z8ua
 w5Lm4FdxESz2OnFM70R8mu8P+DUjpX6XsU3eXRGxknXD4KrBnfZ7K34eUHDWXZ5+SZIK
 x4Tc2UWjvSSyGyp0CUtiDLEoOVZUa60S76MrV1JotogPiyrJHjzwd53KxpEcuPnlD6v9
 tNbknqYCV641yOBeFAcAyZKQFZeI4PtpwLFC0hnG2OM3sQ1meJu7QK58y+xbm8JhRLpR
 souw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=N5NztJfh5BzMOtf9h7VP/IFXxLeIqYtsDkIeRVHhk+A=;
 b=Y6g7WyIqNEEuujN/r7NepwTd+B9PDPS0YNqYZaIWszdkcJ7ejleBDkwjcCxIE91fFd
 qRgsKMfSBjDhCOxnpe2xq4P1EYH2ii2CLKscAnkfN8GwBuOE+cCDy5GMILSRsAgI07sv
 YotQ9yZvAbdyyOWfY7US9X/grCsBzs1soL8b2CxlFRC/hGcOADpv5h2ffWPkFJ8TIfOC
 MEYbt1RjYyU8OhM6hTTnjgVZdoGBrtCwNUx9l9jPHRZdwRxwkhv+ktiVZthAtzLTt87C
 8INOBWEaoAEVGppJB05icVExm3MHX5wqGX7BM7zdYVTWE73dLw1VZ0cZ0yP2UXoe/sFe
 5ogQ==
X-Gm-Message-State: APjAAAUr/rUgAHLyMBXaA9WiT0ngauAOogxXf7+5IcO1nZNrM4gTaj+L
 HSXWZ+CmN4u4fMyn5hK3o9ll5RXZgF4=
X-Google-Smtp-Source: APXvYqxRcnbh20fX6NrtvimoWg5A5oABqsa5FuK7QL/Fxt2TI0r4mK0/MU1L+fKB9JgnpVXUE1aBPQ==
X-Received: by 2002:a62:7911:: with SMTP id u17mr25834847pfc.162.1567526984070; 
 Tue, 03 Sep 2019 09:09:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:58 -0700
Message-Id: <20190903160858.5296-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 36/36] tcg: Factor out probe_write() logic into
 probe_access()
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

Let's also allow to probe other access types.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190830100959.26615-3-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 10 ++++++++--
 accel/tcg/cputlb.c      | 43 ++++++++++++++++++++++++++++++-----------
 accel/tcg/user-exec.c   | 26 +++++++++++++++++++------
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a7893ed16b..81b02eb2fe 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -310,8 +310,14 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 #endif
-void *probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
-                  uintptr_t retaddr);
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
+
+static inline void *probe_write(CPUArchState *env, target_ulong addr, int size,
+                                int mmu_idx, uintptr_t retaddr)
+{
+    return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
+}
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cb969d8372..abae79650c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1075,30 +1075,51 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     return qemu_ram_addr_from_host_nofail(p);
 }
 
-/* Probe for whether the specified guest write access is permitted.
- * If it is not permitted then an exception will be taken in the same
- * way as if this were a real write access (and we will not return).
+/*
+ * Probe for whether the specified guest access is permitted. If it is not
+ * permitted then an exception will be taken in the same way as if this
+ * were a real access (and we will not return).
  * If the size is 0 or the page requires I/O access, returns NULL; otherwise,
  * returns the address of the host page similar to tlb_vaddr_to_host().
  */
-void *probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
-                  uintptr_t retaddr)
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_addr_write(entry);
+    target_ulong tlb_addr;
+    size_t elt_ofs;
+    int wp_access;
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
+    switch (access_type) {
+    case MMU_DATA_LOAD:
+        elt_ofs = offsetof(CPUTLBEntry, addr_read);
+        wp_access = BP_MEM_READ;
+        break;
+    case MMU_DATA_STORE:
+        elt_ofs = offsetof(CPUTLBEntry, addr_write);
+        wp_access = BP_MEM_WRITE;
+        break;
+    case MMU_INST_FETCH:
+        elt_ofs = offsetof(CPUTLBEntry, addr_code);
+        wp_access = BP_MEM_READ;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tlb_addr = tlb_read_ofs(entry, elt_ofs);
+
     if (unlikely(!tlb_hit(tlb_addr, addr))) {
-        if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
+        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs,
+                            addr & TARGET_PAGE_MASK)) {
+            tlb_fill(env_cpu(env), addr, size, access_type, mmu_idx, retaddr);
             /* TLB resize via tlb_fill may have moved the entry. */
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
         }
-        tlb_addr = tlb_addr_write(entry);
+        tlb_addr = tlb_read_ofs(entry, elt_ofs);
     }
 
     if (!size) {
@@ -1109,7 +1130,7 @@ void *probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
     if (tlb_addr & TLB_WATCHPOINT) {
         cpu_check_watchpoint(env_cpu(env), addr, size,
                              env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
-                             BP_MEM_WRITE, retaddr);
+                             wp_access, retaddr);
     }
 
     if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO)) {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 5720bf8056..71c4bf6477 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -188,17 +188,31 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     g_assert_not_reached();
 }
 
-void *probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
-                  uintptr_t retaddr)
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
+    int flags;
+
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
 
-    if (!guest_addr_valid(addr) ||
-        page_check_range(addr, size, PAGE_WRITE) < 0) {
+    switch (access_type) {
+    case MMU_DATA_STORE:
+        flags = PAGE_WRITE;
+        break;
+    case MMU_DATA_LOAD:
+        flags = PAGE_READ;
+        break;
+    case MMU_INST_FETCH:
+        flags = PAGE_EXEC;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (!guest_addr_valid(addr) || page_check_range(addr, size, flags) < 0) {
         CPUState *cpu = env_cpu(env);
         CPUClass *cc = CPU_GET_CLASS(cpu);
-
-        cc->tlb_fill(cpu, addr, size, MMU_DATA_STORE, MMU_USER_IDX, false,
+        cc->tlb_fill(cpu, addr, size, access_type, MMU_USER_IDX, false,
                      retaddr);
         g_assert_not_reached();
     }
-- 
2.17.1


