Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165D5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D801021929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCYQsGIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D801021929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56495 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtom-00021Y-C0
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWd-0003XW-GR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWb-0007mp-TD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:51376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWa-0007jX-KE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id q70so814906wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vsT1sDdN9tyjeDx32IurIboRHv52kBAte0kwCWRATNA=;
 b=YCYQsGIZhwITd+2i+kCfjmzRhP79sQ0PedGrgO5limZdzE7857DcvxUok1znyUrvUW
 YhlpvUeN7jDoaON5s2bu7P8Q0QBeJPgE0VY4/p11tq7J+SiKpN6SyfwPddl97qPhox3p
 DW5wJoHpqFWo7ribgFbKx06fgaaA8Hx/jtcOqhhdEdq4MgHuAPTYc0BxOlZqHE068uW2
 FMi1i0qlwNeUgmpxfmRmLFZmrVEQaJJLBubNMu7xnvMwNpjrE5vCSSvaotIOGXoN4NmS
 oDUvbkEl1ps8X7nJdNJkzDr/PM2UtVhGPAGLLfk76gzLvMGwPLC04/3l06F90YVCYmI0
 3z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vsT1sDdN9tyjeDx32IurIboRHv52kBAte0kwCWRATNA=;
 b=LrHB3dqKRhtkPe1byi8BxN1o/Rv6V16lMV+W1pYE975Y6fK786XcdizpD7cqxCbmN/
 0dchMO9ptnVteexMWiY5tKup2UMlmaEH95xph1E6EoV6UX7oz3iLQkVp/764kJXULYDk
 QXzL1ubfF2j73wODBgwdku2XBt/dTJuD4+df3JwloOx7nOL9/kb4HDnREzDjfJFpocxS
 ZVVKyc3Eg4CEXMru7K5ecpzf7vrA4GmW6jjLZB/OdgLF7kJhcSmyJECsfDi9HxmPn3Am
 GRQk7TLCzGauLtC7tIg9mrFqZLbLCQcOKYOH0jo8FNmHHQ8kobVORUrb33hu2ByqTF1/
 twHQ==
X-Gm-Message-State: APjAAAX6EVGIEiFtJRq3KirBD3lEyts9RUvyql50ixtbHhBbQJsgHPWB
 KHPNswuXe2VDTdT1Xki4q5VXFA==
X-Google-Smtp-Source: APXvYqx5y7urZwD0YLcHcAD+VVCQgahtTMayrJ+ocl8DFZyWebf6wmMMIIjA/kOIZC7bX7vbG94a9w==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr1857820wma.62.1571986599375;
 Thu, 24 Oct 2019 23:56:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d199sm1300928wmd.35.2019.10.24.23.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D09DE1FFB8;
 Fri, 25 Oct 2019 07:37:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 32/73] plugins: implement helpers for resolving hwaddr
Date: Fri, 25 Oct 2019 07:36:32 +0100
Message-Id: <20191025063713.23374-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to keep a local per-cpu copy of the data as other threads may
be running. Currently we can provide insight as to if the access was
IO or not and give the offset into a given device (usually the main
RAMBlock). We store enough information to get details such as the
MemoryRegion which might be useful in later expansions to the API.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 82282d30d93..2c06b57272e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,6 +34,9 @@
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "translate-all.h"
+#ifdef CONFIG_PLUGIN
+#include "qemu/plugin-memory.h"
+#endif
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
@@ -1247,6 +1250,45 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
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
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    target_ulong tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+
+    if (likely(tlb_hit(tlb_addr, addr))) {
+        /* We must have an iotlb entry for MMIO */
+        if (tlb_addr & TLB_MMIO) {
+            CPUIOTLBEntry *iotlbentry;
+            iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+            data->is_io = true;
+            data->v.io.section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
+            data->v.io.offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
+        } else {
+            data->is_io = false;
+            data->v.ram.hostaddr = addr + tlbe->addend;
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
diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
new file mode 100644
index 00000000000..fbbe99474bd
--- /dev/null
+++ b/include/qemu/plugin-memory.h
@@ -0,0 +1,40 @@
+/*
+ * Plugin Memory API
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _PLUGIN_MEMORY_H_
+#define _PLUGIN_MEMORY_H_
+
+struct qemu_plugin_hwaddr {
+    bool is_io;
+    bool is_store;
+    union {
+        struct {
+            MemoryRegionSection *section;
+            hwaddr    offset;
+        } io;
+        struct {
+            uint64_t hostaddr;
+        } ram;
+    } v;
+};
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
+
+#endif /* _PLUGIN_MEMORY_H_ */
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index b9a4a4b6841..c213d1dd19f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -285,6 +285,14 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr);
 
+/*
+ * The following additional queries can be run on the hwaddr structure
+ * to return information about it. For non-IO accesses the device
+ * offset will be into the appropriate block of RAM.
+ */
+bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr);
+uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
+
 typedef void
 (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
                              qemu_plugin_meminfo_t info, uint64_t vaddr,
diff --git a/plugins/api.c b/plugins/api.c
index facf2a132de..33dac8e790d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -42,6 +42,7 @@
 #include "trace/mem-internal.h" /* mem_info macros */
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
+#include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #endif
 
@@ -240,11 +241,59 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
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
+    hwaddr_info.is_store = info & TRACE_MEM_ST;
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
+
+bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr)
+{
+#ifdef CONFIG_SOFTMMU
+    return hwaddr->is_io;
+#else
+    return false;
+#endif
+}
+
+uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr)
+{
+#ifdef CONFIG_SOFTMMU
+    if (haddr) {
+        if (!haddr->is_io) {
+            ram_addr_t ram_addr = qemu_ram_addr_from_host((void *) haddr->v.ram.hostaddr);
+            if (ram_addr == RAM_ADDR_INVALID) {
+                error_report("Bad ram pointer %"PRIx64"", haddr->v.ram.hostaddr);
+                abort();
+            }
+            return ram_addr;
+        } else {
+            return haddr->v.io.offset;
+        }
+    }
+#endif
+    return 0;
+}
 
 /*
  * Queries to the number and potential maximum number of vCPUs there
-- 
2.20.1


