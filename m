Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54CFC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FF1206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDO1fhpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FF1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrWY-0003ML-T7
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45205)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPn-00051s-GW
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPm-0000MS-0K
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPl-0000Ly-QB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id y4so70383126wrm.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nwwivd4l04F9lotguBi5Pm9ljTTEntqAZyI9oEyrjH8=;
 b=sDO1fhpFlvG0YQoaMXLyUECDLb92YEL+YNc8Ll9Tqnl1Yyu8fW78x/hEpRuRewSQpX
 hKc4+mvpSE8YHZej0UNrw8gFlTvIUhHpjoLPs5yX8EJfr+wg+mFt4NVUe74rhrcjHCnG
 s5FtNIHTCGfPI/bCv1nt7tLymIyDKlDHz2WkhROZBnFx7vGyUhIufL8S0/CayDobrSyr
 d2zkcuHbdnV50XuTtjAqnTdm3dmEnf2ABd9y2Zldyc85F3mh7eankudz99l1ZwRAOZ0d
 PEGAYA5oQg11E9M1xTv+0xy74GPIG3Y/hR5PGV41Pw3L7H9QeTS1gUG9ZDzNTe4J3Hhu
 /CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nwwivd4l04F9lotguBi5Pm9ljTTEntqAZyI9oEyrjH8=;
 b=boqW/XHOSZS0uXx2ibGaJ33ZBfiguKDm977hUsDZ4CHmRdhe8zqE2CCo3HtbBrQYaz
 WeNmT7oMG785at19xmMbPQe/uojJTwxTsVqf/CTqo3iraU8auRN2Ax02Jd0n6k0nzYDz
 PLUR/SNbbaGJ/rkdvScBuh/BF6+a/tT+qWFgB89EHchIAcHG5QczfHSoVUA55259F/j2
 ikspq/AXL8pg04BCd+Xcjsf3CodFRdddWfqcZBVkZ98aYNyh2mohhz1RGnMEBYkG1ro2
 4OqSpo7ob2uzwh8upxRIx9ycsiSMzNSmXXsGJC6LPDdF6SG1V/TIptoNfmDTg37bNqUT
 BqSg==
X-Gm-Message-State: APjAAAXLfeDYnzLjjPwkNMkehSRLFUfm0yNEL9HKgknCnA4qAD5k3Na+
 TCmsyP9zaA+rFUYIJYe3HcTL0IVuTpM=
X-Google-Smtp-Source: APXvYqxXd+H0GGKlOoRndl0xFfWeP2MV9/3GiCirZoIGXWxFw6fCzS5Q7hY+WMe5STFayodVYELVug==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr5708897wrt.84.1564590320731;
 Wed, 31 Jul 2019 09:25:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j17sm113934938wrb.35.2019.07.31.09.25.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:16 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C480D1FF8C;
 Wed, 31 Jul 2019 17:07:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:49 +0100
Message-Id: <20190731160719.11396-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 24/54] plugins: implement helpers for
 resolving hwaddr
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
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
 accel/tcg/cputlb.c      | 32 ++++++++++++++++++++++++++
 include/exec/exec-all.h | 17 ++++++++++++++
 include/qemu/plugin.h   |  6 +++++
 plugins/api.c           | 50 +++++++++++++++++++++++++++++++++--------
 4 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f7c0290639c..f37e89c806d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1130,6 +1130,38 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     return (void *)((uintptr_t)addr + entry->addend);
 }
 
+
+#ifdef CONFIG_PLUGIN
+/*
+ * Perform a TLB lookup and populate the qemu_plugin_hwaddr structure.
+ * This should be a hot path as we will have just looked this path up
+ * in the softmmu lookup code (or helper). We don't handle re-fills or
+ * checking the victim table. This is purely informational.
+ */
+
+bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
+                       bool is_store, struct qemu_plugin_hwaddr *data)
+{
+    CPUArchState *env = cpu->env_ptr;
+    CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
+    target_ulong tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+
+    if (tlb_hit(tlb_addr, addr)) {
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
index 90045e77c1f..c42626e35b1 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -262,6 +262,17 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
                   int mmu_idx, target_ulong size);
 void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr);
+
+/**
+ * tlb_plugin_lookup: query last TLB lookup
+ * @cpu: cpu environment
+ *
+ * This function can be used directly after a memory operation to
+ * query information about the access. It is used by the plugin
+ * infrastructure to expose more information about the address.
+ */
+bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
+                       bool is_store, struct qemu_plugin_hwaddr *data);
 #else
 static inline void tlb_init(CPUState *cpu)
 {
@@ -311,6 +322,12 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
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
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 3c46a241669..657345df60c 100644
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
index 586bb8789f1..4b3ac9e31fb 100644
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
@@ -240,11 +240,42 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
  * Virtual Memory queries
  */
 
+#ifdef CONFIG_SOFTMMU
+static GArray *hwaddr_refs;
+
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr)
+{
+    CPUState *cpu = current_cpu;
+    unsigned int mmu_idx = info >> TRACE_MEM_MMU_SHIFT;
+    struct qemu_plugin_hwaddr *hwaddr;
+
+    /* Ensure we have memory allocated for this work */
+    if (!hwaddr_refs) {
+        hwaddr_refs = g_array_sized_new(false, true,
+                                        sizeof(struct qemu_plugin_hwaddr),
+                                        cpu->cpu_index + 1);
+    } else if (cpu->cpu_index >= hwaddr_refs->len) {
+        hwaddr_refs = g_array_set_size(hwaddr_refs, cpu->cpu_index + 1);
+    }
+
+    hwaddr = &g_array_index(hwaddr_refs, struct qemu_plugin_hwaddr,
+                            cpu->cpu_index);
+
+    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
+                           info & TRACE_MEM_ST, hwaddr)) {
+        return NULL;
+    }
+
+    return hwaddr;
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
@@ -253,14 +284,15 @@ bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr)
 
 uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *haddr)
 {
-#if 0 /* XXX FIXME should be SOFTMMU */
-    ram_addr_t ram_addr;
-
-    g_assert(haddr);
-    ram_addr = qemu_ram_addr_from_host(haddr);
-    if (ram_addr == RAM_ADDR_INVALID) {
-        error_report("Bad ram pointer %p", haddr);
-        abort();
+#ifdef CONFIG_SOFTMMU
+    ram_addr_t ram_addr = 0;
+
+    if (haddr && !haddr->is_io) {
+        ram_addr = qemu_ram_addr_from_host((void *) haddr->hostaddr);
+        if (ram_addr == RAM_ADDR_INVALID) {
+            error_report("Bad ram pointer %"PRIx64"", haddr->hostaddr);
+            abort();
+        }
     }
     return ram_addr;
 #else
-- 
2.20.1


