Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AACECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D6220673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELAYYCE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D6220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyTN-0003qa-3E
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy29-0006a8-Jt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy28-000589-2I
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy27-00056k-R6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:00 -0400
Received: by mail-wr1-x444.google.com with SMTP id r3so19173443wrj.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oN1mnKuiyoRPUYVWg4mbq/TduDJ+Zln9LyiIfU1AE/I=;
 b=ELAYYCE9wO2Pxa6cvtOlk3xEi0wTbV74U2+gI+mwaGGMljj9wetrsCZZao01FFSmT6
 xLo+uN0Cws4Ovfg/BVpyPb2YJJQr2ebNwsIdVkIvTVdcYp6CzfdVzI3ChPvujpbW/l5F
 cvq32IlEUQLvHXG7m4+yGwf6JnOpEt/Jc/0E6DD/R0D6Liwq8SIVoL/eOW+90mjO+Y6D
 idbxudWbersoHeKtARMxJxkxBof3HdHK9y6oL3t7xIm2gcLDjVpm0ZojU9OCnO7rscCU
 kc07qk4qPH+Y7zB4Kr0+ZNO3Sd8I6HzORQzbwD0so8wrC6clk1aWEnXd5nLVOb8PM4/M
 pMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oN1mnKuiyoRPUYVWg4mbq/TduDJ+Zln9LyiIfU1AE/I=;
 b=a2ksKiyfVrnTPYiAJWYTpC234waBps62Ht2fjYzwS7LUoTd4l0BlcYUlHuIt3HVfoL
 iVZbr/xzCuuMo18zZVgPQqInzengotMiMzxDAVjeAUjZgvvTSbCB5NLSrIE7kCh6eym3
 LaleJAkYIguf3ooqJzecP/SkQpLkJs6ssMiE7A8kH03D+LDAVcPNTxvdLEznr8vJraGY
 gxJ/+1xpXKnx9w+f5Fv1WFn8/s7iSczstkpzh/2DSyWyuebgUxgprmOE3CD/zFtqWfdF
 DVAhWQz+ZaDQgDdxDtF6xeGQwXKII6MvC5hm3ITeXsSlffO+4oW7nGwGyfX8qOjScGLB
 PRmQ==
X-Gm-Message-State: APjAAAXpRE+xRNmYYWCxn8kSohFVKQTIn3pujAAu6H+/+Vs82nUdRhzy
 ALXuYUUslbF5EONRv/4tLWIAUFR5U7s=
X-Google-Smtp-Source: APXvYqwHn+g2KaI2RQJqYxikWKO26cSrAJULui+XGjIAJUoT774ktOyFtNoNri8DOsfmxPzcLZMqRg==
X-Received: by 2002:a5d:51d1:: with SMTP id n17mr25291390wrv.125.1571050618706; 
 Mon, 14 Oct 2019 03:56:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n7sm19363697wrt.59.2019.10.14.03.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E4451FF93;
 Mon, 14 Oct 2019 11:49:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 17/55] plugins: implement helpers for resolving hwaddr
Date: Mon, 14 Oct 2019 11:49:10 +0100
Message-Id: <20191014104948.4291-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: robert.foley@futurewei.com, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to keep a local per-cpu copy of the data as other threads may
be running. We use a automatically growing array and re-use the space
for subsequent queries.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - use TLS instead of racy GArray
  - add more commentary regarding success
  - error_report if we fail
---
 accel/tcg/cputlb.c      | 35 +++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h | 20 ++++++++++++++++++++
 include/qemu/plugin.h   |  6 ++++++
 plugins/api.c           | 34 +++++++++++++++++++++++++++++++++-
 4 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b587d910f8..2937dac7a5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1247,6 +1247,41 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     return (void *)((uintptr_t)addr + entry->addend);
 }
 
+
+#ifdef CONFIG_PLUGIN
+/*
+ * Perform a TLB lookup and populate the qemu_plugin_hwaddr structure.
+ * This should be a hot path as we will have just looked this path up
+ * in the softmmu lookup code (or helper). We don't handle re-fills or
+ * checking the victim table. This is purely informational.
+ *
+ * This should never fail as the memory access being instrumented
+ * should have just filled the TLB.
+ */
+
+bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
+                       bool is_store, struct qemu_plugin_hwaddr *data)
+{
+    CPUArchState *env = cpu->env_ptr;
+    CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
+    target_ulong tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+
+    if (likely(tlb_hit(tlb_addr, addr))) {
+        if (tlb_addr & TLB_MMIO) {
+            data->hostaddr = 0;
+            data->is_io = true;
+            /* XXX: lookup device */
+        } else {
+            data->hostaddr = addr + tlbe->addend;
+            data->is_io = false;
+        }
+        return true;
+    }
+    return false;
+}
+
+#endif
+
 /* Probe for a read-modify-write atomic operation.  Do not allow unaligned
  * operations, or io operations to proceed.  Return the host address.  */
 static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ba2f501f0f..47a071fee0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -261,6 +261,20 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 void tlb_set_page(CPUState *cpu, target_ulong vaddr,
                   hwaddr paddr, int prot,
                   int mmu_idx, target_ulong size);
+
+/**
+ * tlb_plugin_lookup: query last TLB lookup
+ * @cpu: cpu environment
+ *
+ * This function can be used directly after a memory operation to
+ * query information about the access. It is used by the plugin
+ * infrastructure to expose more information about the address.
+ *
+ * It would only fail if not called from an instrumented memory access
+ * which would be an abuse of the API.
+ */
+bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
+                       bool is_store, struct qemu_plugin_hwaddr *data);
 #else
 static inline void tlb_init(CPUState *cpu)
 {
@@ -310,6 +324,12 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
 }
+static inline bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr,
+                                     int mmu_idx, bool is_store,
+                                     struct qemu_plugin_hwaddr *data)
+{
+    return false;
+}
 #endif
 void *probe_access(CPUArchState *env, target_ulong addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 3c46a24166..657345df60 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -182,6 +182,12 @@ struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb)
     return insn;
 }
 
+struct qemu_plugin_hwaddr {
+    uint64_t hostaddr;
+    bool is_io;
+};
+
+
 #ifdef CONFIG_PLUGIN
 
 void qemu_plugin_vcpu_init_hook(CPUState *cpu);
diff --git a/plugins/api.c b/plugins/api.c
index 3de05719a8..fbacd78df6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,7 +39,7 @@
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "tcg/tcg.h"
-#include "trace/mem-internal.h" /* mem_info macros */
+#include "exec/exec-all.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
@@ -240,11 +240,30 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
  * Virtual Memory queries
  */
 
+#ifdef CONFIG_SOFTMMU
+static __thread struct qemu_plugin_hwaddr hwaddr_info;
+
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr)
+{
+    CPUState *cpu = current_cpu;
+    unsigned int mmu_idx = info >> TRACE_MEM_MMU_SHIFT;
+
+    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
+                           info & TRACE_MEM_ST, &hwaddr_info)) {
+        error_report("invalid use of qemu_plugin_get_hwaddr");
+        return NULL;
+    }
+
+    return &hwaddr_info;
+}
+#else
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr)
 {
     return NULL;
 }
+#endif
 
 bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr)
 {
@@ -253,7 +272,20 @@ bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr)
 
 uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *haddr)
 {
+#ifdef CONFIG_SOFTMMU
+    ram_addr_t ram_addr = 0;
+
+    if (haddr && !haddr->is_io) {
+        ram_addr = qemu_ram_addr_from_host((void *) haddr->hostaddr);
+        if (ram_addr == RAM_ADDR_INVALID) {
+            error_report("Bad ram pointer %"PRIx64"", haddr->hostaddr);
+            abort();
+        }
+    }
+    return ram_addr;
+#else
     return 0;
+#endif
 }
 
 /*
-- 
2.20.1


