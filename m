Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A0C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED25F2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJN1bFrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED25F2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa3M-00072G-1w
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa2T-0003MF-34
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa2O-000560-IG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:35 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa2O-00055a-80
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:32 -0400
Received: by mail-pg1-x542.google.com with SMTP id i70so4229448pgd.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qSAk/ikU/Yd5/thTZP7TzeGfcBAUft8dVvQCioYm2gw=;
 b=uJN1bFrSINBPl/sff9/uuCWdSGOdrG4D0Xwy+7pcEI535MjV2m5NRtoHx148aQnRTl
 eG4Hdphz3jfZtmpre8EVNrop//i2bAe+7SoUY7F3YS9QpMKUl24V4NUb2HJ71SSZaJUj
 dSFHmWCn+0YiPQLH9Rlzdd/COaWFXQtjafdUCJ3MHhichKwkDGcnWPJCW4KZ7LR34/0T
 ymXFwV6iRF9ynVZ3Db42fzMulXN7zO4+9j5ypr0M4ycwB9SyRw7Xbk/6XoAIbW53yc8H
 oXWOmhvLeJ+beJCA6qGurTCj7gAJoMRw6RsHfn4niLt4GBZ4Y0rKkYQKxecgoT45u0Qb
 bFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qSAk/ikU/Yd5/thTZP7TzeGfcBAUft8dVvQCioYm2gw=;
 b=Qx0R7f5cvJCLMdBDf/IQ2MxKQRQo4XV4viUZz1SW0RIcptKVDkKK60rk9fMO9sDZaD
 eJ5J4TV6JKRmwV7jvAr0v+PtgINzm0Kcxz1yL385barpoB1nmMdZYRaEpJFVC0l4y9nB
 MvRVmodH/E/c7mNGYOxwV1IfKB9zCZ+y+2bSJaa6Ud1ew0dhkL/ibMu0npsYrND6GuBR
 CnYcivH8tofg15+bGIyY+U5qTP9jwvnEMXIBk+mQR4OiYKVZSOjOIr0Mac1BeR4AJ3Ui
 UILEdfeK69z4ErBv65e59g/K1fhsN0UKmmfXGazHji+2R0wr5Z27wOureBDywWnUUhUr
 m4dw==
X-Gm-Message-State: APjAAAXMwHwyMjwoKLuu4+X8GFzNalLJB2Jqn+dQvnQ/BaQpw7iEyg6T
 L9i3Stm1D2MdWQ3P9ZbJyDzllo2tdYE=
X-Google-Smtp-Source: APXvYqxK+yzyLZY7jxU7RMZyqSd3epPzljzDYILzVXrmI9OEpVzd2qyKN1FlQLZriJt5HlIVOj/low==
X-Received: by 2002:a63:460c:: with SMTP id t12mr55854546pga.69.1563570211022; 
 Fri, 19 Jul 2019 14:03:31 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:04 -0700
Message-Id: <20190719210326.15466-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH for-4.2 02/24] cputlb: Add
 tlb_flush_asid_by_mmuidx and friends
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we have remembered ASIDs, we can further minimize flushing
by comparing against the one we want to flush.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 16 +++++++++++++
 include/qom/cpu.h       |  1 +
 accel/tcg/cputlb.c      | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

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
index 5ee0046b62..4ae6ea3e1d 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -283,6 +283,7 @@ struct hax_vcpu_state;
 typedef union {
     int           host_int;
     unsigned long host_ulong;
+    uint64_t      host_uint64;
     void         *host_ptr;
     vaddr         target_ptr;
 } run_on_cpu_data;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c68f57755b..3ef68a11bf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -540,6 +540,57 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
+static void tlb_flush_asid_by_mmuidx_async_work(CPUState *cpu,
+                                                run_on_cpu_data data)
+{
+    CPUTLB *tlb = cpu_tlb(cpu);
+    uint32_t asid = data.host_uint64;
+    uint16_t idxmap = data.host_uint64 >> 32;
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
+    run_on_cpu_data data = { .host_uint64 = deposit64(asid, 32, 32, idxmap) };
+
+    if (cpu->created && !qemu_cpu_is_self(cpu)) {
+        async_run_on_cpu(cpu, tlb_flush_asid_by_mmuidx_async_work, data);
+    } else {
+        tlb_flush_asid_by_mmuidx_async_work(cpu, data);
+    }
+}
+
+void tlb_flush_asid_by_mmuidx_all_cpus(CPUState *src_cpu,
+                                       uint32_t asid, uint16_t idxmap)
+{
+    run_on_cpu_data data = { .host_uint64 = deposit64(asid, 32, 32, idxmap) };
+
+    flush_all_helper(src_cpu, tlb_flush_asid_by_mmuidx_async_work, data);
+    tlb_flush_asid_by_mmuidx_async_work(src_cpu, data);
+}
+
+void tlb_flush_asid_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
+                                              uint32_t asid, uint16_t idxmap)
+{
+    run_on_cpu_data data = { .host_uint64 = deposit64(asid, 32, 32, idxmap) };
+
+    flush_all_helper(src_cpu, tlb_flush_asid_by_mmuidx_async_work, data);
+    async_safe_run_on_cpu(src_cpu, tlb_flush_asid_by_mmuidx_async_work, data);
+}
+
 void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxmap,
                              uint16_t depmap)
 {
-- 
2.17.1


