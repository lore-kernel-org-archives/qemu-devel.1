Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C8CC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2FF20659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkHD3+iY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2FF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvNt-00069V-6D
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60623)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMa-0003wA-O5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMZ-0003Hf-Jf
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:20 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMZ-0003HH-B2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:19 -0400
Received: by mail-pg1-x543.google.com with SMTP id t132so32632236pgb.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OzH9oAANiLbbz3MZqOd0740wSKDkRIpOzsZLTONmMZs=;
 b=mkHD3+iYsbWab5cdVZchcSsYztaDNDugjO/BYtRQhaR9lWwuMtKJO1MOfTOMi+41tK
 vt6UkLW3JTiyThN3STPBnqE59TUW11RxDLiQ/biaUh2aO84jV77b/5fX8jYTq7pxU97z
 Ozu8J/5z66NiObuOQTlQzV6OEwh+egQSop9TErhKiE6aCHisL/bVRc4pTuIcb3++LkLT
 QlYOucEUVqXBkN7zQQoQMB62P06LSBvG8N2aZ8KN1Ipc6icCZMvXpNGcjCOT1DYMm8Xo
 hltZZ27joq3NsBo6CUCTa2HdLvkgt5I96hCt3h50ndDp11BSX9caNWf0FVB1+EsgxVd5
 Pb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OzH9oAANiLbbz3MZqOd0740wSKDkRIpOzsZLTONmMZs=;
 b=QlF/6Udy5HWs+7HJMRar5Ha1IWUZgECeJYE7eQsAkvkca1KBhbfFoo9QlAsH3Uy4Kk
 bOcSRUPhCdWAblNZWT0CQXBvm0zzUVvaWmPAj168oz60bNCGHsQH3Wflw59kmO3WLPNA
 QFFgTCmA1xQwmfHRJ00klzIZVszPGoDy9hSEDKZPucwvLEaAOYt/GXMSq4UcHlXZJoc6
 XchzVx5QeOIh2Fi+/BFJmiiGafZ+HTuuwsmyvC9NrZGKLXyFVkCFF6VdY82yGAjahukq
 YmXACYk3LkNux59y9eHR8eOq6kN8EVHstFYlk6oam4r54vFLF7PCQV/GDqAzhgmFqHHL
 v4dw==
X-Gm-Message-State: APjAAAUtGvJTL+mfL+IkR1Iy9jKT+EmfzMhoXJFbjAtYOdOGOBljRvDa
 dmBQE6kVfhtD4/pnSVnnqPup5bezxxg=
X-Google-Smtp-Source: APXvYqyCh4czqu5MPOguqi5mN0IkCbCArQrhKl2imbG1TB/cUQHFz0tm3E1i7kVM2Hu07hZ8yC7ShQ==
X-Received: by 2002:aa7:9407:: with SMTP id x7mr51015581pfo.163.1564605497999; 
 Wed, 31 Jul 2019 13:38:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:43 -0700
Message-Id: <20190731203813.30765-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 02/32] cputlb: Add tlb_flush_asid_by_mmuidx
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


