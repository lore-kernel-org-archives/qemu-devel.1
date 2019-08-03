Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92AC433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0B92073D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6m4R1Ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0B92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htz63-00008K-Og
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4Z-0005td-0m
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4X-00074d-Lo
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:06 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4X-00073T-GR
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:05 -0400
Received: by mail-pl1-x643.google.com with SMTP id c2so34860457plz.13
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Vv1PJfuLW2Q3y6jhZwS+VA5WdsiwenJEhdiHqcPU8E=;
 b=Y6m4R1UgmbocM8caPBMrteJtERSrOeJiLGnM3FPGwmGvHF1A8Jb61r+XJbxj43PlWF
 B5y6PhvJZrCKursx25LMzydByDVTzhvucAfy446c2Q4hxyNzGTI8d8WiqCWUdberr7Kj
 XkF89KpMLlQBNygZxWlYdoksgbNQP0iXwFpIz+R4zrGbvRErBodIME22Cm1l62poJiTx
 qc6O0x1PhiJGWaM6/owU9OxUYbJU6znzRCJNW9CYcJz2fWPj0HeIH0BnErk4XUS4pGCl
 pH7HGPzyFuuQ/6bX9YtBHNn4C6+JGOb6+kj8V1s07E3xuoVEJ7tmN814k5Qex7Knr9cr
 6kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Vv1PJfuLW2Q3y6jhZwS+VA5WdsiwenJEhdiHqcPU8E=;
 b=jtRLRRyCxOzXSGzDunW5m7B3FauPoC9I5pl+566EmjEDJ/fjUP4CAOqtqCPBv9yE8h
 0qneSCocOLE6loq+SmRbiOGai8B8kdEoYEDOMqqZEI8hSl66dj/aGjs3I35QB+LQ2cm4
 psAzNjcYyRQOJGr0SpQwJxZMSy+wMhtmGGThC5AK/qtiXzxfrgHawpxoVmqE6bbsgViO
 CjyEQ6EzRzCEywM+1XvfJG022vFjMHABYQpgVbTWFtxoKLhWg0iBECzeLqWWlcbDuGdQ
 VS0d4LM2/7k34swRDuBYDQ7inhh+N/NDCgeSvsYfZYu2ZI0rfF3CtSAYHvTjwVzbum/S
 Yn7g==
X-Gm-Message-State: APjAAAWYbgU6BspKQtHH2TdLLQw0zZUBuWfge2423v0ZDc+tbuZpfui0
 NPtqzFoJ0Ym13hitq2pi8OwC5jUeTV4=
X-Google-Smtp-Source: APXvYqwElKJuSKp+zFrcUjqRod6t4pk2yXi5P8txvmjGa8EcrsWx5h0RSCHbx4q4R95sSU+q8ZKxgQ==
X-Received: by 2002:a17:902:f082:: with SMTP id
 go2mr143791348plb.25.1564858084208; 
 Sat, 03 Aug 2019 11:48:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:27 -0700
Message-Id: <20190803184800.8221-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v3 01/34] cputlb: Add tlb_set_asid_for_mmuidx
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

Although we can't do much with ASIDs except remember them, this
will allow cleanups within target/ that should make things clearer.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Assert cpu_is_self; only flush idx w/ asid mismatch.
v3: Improve asid comment.
---
 include/exec/cpu-all.h  | 11 +++++++++++
 include/exec/cpu-defs.h |  2 ++
 include/exec/exec-all.h | 19 +++++++++++++++++++
 accel/tcg/cputlb.c      | 26 ++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 536ea58f81..40b140cbba 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -439,4 +439,15 @@ static inline CPUTLB *env_tlb(CPUArchState *env)
     return &env_neg(env)->tlb;
 }
 
+/**
+ * cpu_tlb(env)
+ * @cpu: The generic CPUState
+ *
+ * Return the CPUTLB state associated with the cpu.
+ */
+static inline CPUTLB *cpu_tlb(CPUState *cpu)
+{
+    return &cpu_neg(cpu)->tlb;
+}
+
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9bc713a70b..b42986d822 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -169,6 +169,8 @@ typedef struct CPUTLBDesc {
     size_t n_used_entries;
     /* The next index to use in the tlb victim table.  */
     size_t vindex;
+    /* The current ASID for this tlb, if used; otherwise ignored.  */
+    uint32_t asid;
     /* The tlb victim table, in two parts.  */
     CPUTLBEntry vtable[CPU_VTLB_SIZE];
     CPUIOTLBEntry viotlb[CPU_VTLB_SIZE];
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..9c77aa5bf9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -225,6 +225,21 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
  * depend on when the guests translation ends the TB.
  */
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
+/**
+ * tlb_set_asid_for_mmuidx:
+ * @cpu: Originating cpu
+ * @asid: Address Space Identifier
+ * @idxmap: bitmap of MMU indexes to set to @asid
+ * @depmap: bitmap of dependent MMU indexes
+ *
+ * Set an ASID for all of @idxmap.  If any previous ASID was different,
+ * then we will flush the mmu idx.  If a flush is required, then also flush
+ * all dependent mmu indicies in @depmap.  This latter is typically used
+ * for secondary page resolution, for implementing virtualization within
+ * the guest.
+ */
+void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
+                             uint16_t idxmap, uint16_t dep_idxmap);
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
@@ -310,6 +325,10 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
 }
+static inline void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
+                                           uint16_t idxmap, uint16_t depmap)
+{
+}
 #endif
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bb9897b25a..c68f57755b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -540,6 +540,32 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
+void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxmap,
+                             uint16_t depmap)
+{
+    CPUTLB *tlb = cpu_tlb(cpu);
+    uint16_t work, to_flush = 0;
+
+    /* It doesn't make sense to set context across cpus.  */
+    assert_cpu_is_self(cpu);
+
+    /*
+     * We don't support ASIDs except for trivially.
+     * If there is any change, then we must flush the TLB.
+     */
+    for (work = idxmap; work != 0; work &= work - 1) {
+        int mmu_idx = ctz32(work);
+        if (tlb->d[mmu_idx].asid != asid) {
+            tlb->d[mmu_idx].asid = asid;
+            to_flush |= 1 << mmu_idx;
+        }
+    }
+    if (to_flush) {
+        to_flush |= depmap;
+        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(to_flush));
+    }
+}
+
 /* update the TLBs so that writes to code in the virtual page 'addr'
    can be detected */
 void tlb_protect_code(ram_addr_t ram_addr)
-- 
2.17.1


