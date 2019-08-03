Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B4C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D8C2073D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POoyQ7p+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D8C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htz6P-0001Mr-PG
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60495)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4a-0005vH-3K
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4Y-00075V-OO
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4Y-00074y-J2
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:06 -0400
Received: by mail-pf1-x443.google.com with SMTP id p184so37618535pfp.7
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OzH9oAANiLbbz3MZqOd0740wSKDkRIpOzsZLTONmMZs=;
 b=POoyQ7p+raLFWdXdMAzpyzaP2JaDBIv6nyVaZb9BfgIy2h7Mrrv6IJN3cSSEJntlw5
 fyjBeZs76EWn/Or6CbrU6PLJ1BCKSmRURYCh4ha3iDIM+5H4TlNZPQdCdwiX5W9Fp0Ee
 aswnR4wlqWtWQXx2paH4aGQY1c09aAtCPGHlqIQFNTe5xZgzADjy6HMgjLbaiCAlDmRs
 hhe/82vasY2whCT2XBPfo/RsXzWAh3RH9J/ywRIinWZ58/xgy3dkpNzVgCKgV8FvkYcC
 4iXcMs8vs3kMvuW0wVWCymak7Ouftt5En+eVh42Dr1EM1IHppVJKxWULZeme/RoHJKWT
 a2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OzH9oAANiLbbz3MZqOd0740wSKDkRIpOzsZLTONmMZs=;
 b=G8Vwueu4DCcV72hxMCKddVYazxtV8S5YDmepDfcefUUOu+X6syHDkLlHzckFCKlL/a
 K61eU/cIVD+EQSSkNQjM1VUjj5MiuQoGo2PuiLPvE7S6UM3UAMpeLX0H10osPkVTmzCF
 lWrTJlth9pqod6gU4rcnLvmyDd0OyZEFkSdmBDAZlcu6fU0U2dAcR4pHRgGREWqaLHkW
 JlQj06HQDigybmgcE3pkGdau5ZGvoc6ccYwrF2cW/DVeVFcqS35kT2ye1WIMywirn++4
 lLrbmKrXDBfnz9nRErHyTOMIZzGM8VDWgOcKfX3Sx91qjyuRpA4cgAb20FQz41L8PRCL
 QuSg==
X-Gm-Message-State: APjAAAWG7EZI1rfZsQBlinFBFpdz6SNc1gEdUoKgwLO4+CiOknTCPjmx
 mLSqjI5CKeNw44tc6PG56DcKCpjo4g8=
X-Google-Smtp-Source: APXvYqwTLu7ABi2FWZUOwwgpSILNwSA+C/RSS5DD/SvL/tVWU2hv+DPvqD1M9Ws27BnCjY9yntlgyw==
X-Received: by 2002:a63:8a49:: with SMTP id y70mr35691142pgd.271.1564858085297; 
 Sat, 03 Aug 2019 11:48:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:28 -0700
Message-Id: <20190803184800.8221-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 02/34] cputlb: Add tlb_flush_asid_by_mmuidx
 and friends
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we have remembered ASIDs, we can further minimize flushing
by comparing against the one we want to flush.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 16 ++++++++++++
 include/qom/cpu.h       |  2 ++
 accel/tcg/cputlb.c      | 55 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 9c77aa5bf9..0d890e1e60 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -240,6 +240,22 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
  */
 void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
                              uint16_t idxmap, uint16_t dep_idxmap);
+/**
+ * tlb_flush_asid_by_mmuidx:
+ * @cpu: Originating CPU of the flush
+ * @asid: Address Space Identifier
+ * @idxmap: bitmap of MMU indexes to flush if asid matches
+ *
+ * For each mmu index, if @asid matches the value previously saved via
+ * tlb_set_asid_for_mmuidx, flush the index.
+ */
+void tlb_flush_asid_by_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxmap);
+/* Similarly, broadcasting to all cpus. */
+void tlb_flush_asid_by_mmuidx_all_cpus(CPUState *cpu, uint32_t asid,
+                                       uint16_t idxmap);
+/* Similarly, waiting for the broadcast to complete.  */
+void tlb_flush_asid_by_mmuidx_all_cpus_synced(CPUState *cpu, uint32_t asid,
+                                              uint16_t idxmap);
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046b62..c072dd4c47 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -285,12 +285,14 @@ typedef union {
     unsigned long host_ulong;
     void         *host_ptr;
     vaddr         target_ptr;
+    uint64_t      uint64;
 } run_on_cpu_data;
 
 #define RUN_ON_CPU_HOST_PTR(p)    ((run_on_cpu_data){.host_ptr = (p)})
 #define RUN_ON_CPU_HOST_INT(i)    ((run_on_cpu_data){.host_int = (i)})
 #define RUN_ON_CPU_HOST_ULONG(ul) ((run_on_cpu_data){.host_ulong = (ul)})
 #define RUN_ON_CPU_TARGET_PTR(v)  ((run_on_cpu_data){.target_ptr = (v)})
+#define RUN_ON_CPU_UINT64(i)      ((run_on_cpu_data){.uint64 = (i)})
 #define RUN_ON_CPU_NULL           RUN_ON_CPU_HOST_PTR(NULL)
 
 typedef void (*run_on_cpu_func)(CPUState *cpu, run_on_cpu_data data);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c68f57755b..62baaa9ca6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -540,6 +540,61 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
+static void tlb_flush_asid_by_mmuidx_async_work(CPUState *cpu,
+                                                run_on_cpu_data data)
+{
+    CPUTLB *tlb = cpu_tlb(cpu);
+    uint32_t asid = data.uint64;
+    uint16_t idxmap = data.uint64 >> 32;
+    uint16_t to_flush = 0, work;
+
+    assert_cpu_is_self(cpu);
+
+    for (work = idxmap; work != 0; work &= work - 1) {
+        int mmu_idx = ctz32(work);
+        if (tlb->d[mmu_idx].asid == asid) {
+            to_flush |= 1 << mmu_idx;
+        }
+    }
+
+    if (to_flush) {
+        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(to_flush));
+    }
+}
+
+void tlb_flush_asid_by_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxmap)
+{
+    uint64_t asid_idx = deposit64(asid, 32, 32, idxmap);
+
+    if (cpu->created && !qemu_cpu_is_self(cpu)) {
+        async_run_on_cpu(cpu, tlb_flush_asid_by_mmuidx_async_work,
+                         RUN_ON_CPU_UINT64(asid_idx));
+    } else {
+        tlb_flush_asid_by_mmuidx_async_work(cpu, RUN_ON_CPU_UINT64(asid_idx));
+    }
+}
+
+void tlb_flush_asid_by_mmuidx_all_cpus(CPUState *src_cpu,
+                                       uint32_t asid, uint16_t idxmap)
+{
+    uint64_t asid_idx = deposit64(asid, 32, 32, idxmap);
+
+    flush_all_helper(src_cpu, tlb_flush_asid_by_mmuidx_async_work,
+                     RUN_ON_CPU_UINT64(asid_idx));
+    tlb_flush_asid_by_mmuidx_async_work(src_cpu, RUN_ON_CPU_UINT64(asid_idx));
+}
+
+void tlb_flush_asid_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
+                                              uint32_t asid, uint16_t idxmap)
+{
+    uint64_t asid_idx = deposit64(asid, 32, 32, idxmap);
+
+    flush_all_helper(src_cpu, tlb_flush_asid_by_mmuidx_async_work,
+                     RUN_ON_CPU_UINT64(asid_idx));
+    async_safe_run_on_cpu(src_cpu, tlb_flush_asid_by_mmuidx_async_work,
+                          RUN_ON_CPU_UINT64(asid_idx));
+}
+
 void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxmap,
                              uint16_t depmap)
 {
-- 
2.17.1


