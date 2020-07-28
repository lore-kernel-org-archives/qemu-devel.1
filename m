Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C731C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE1E2075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gHmUNT7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE1E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Kze-0000GZ-92
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k0KwU-0003vV-LK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:26:34 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k0KwS-0000q4-MP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:26:34 -0400
Received: by mail-pj1-x1042.google.com with SMTP id f9so4955279pju.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UC0InaM2Av4NdGRB30AcNgGF6NmB2i/F1RQN192G0E0=;
 b=gHmUNT7Z0hYepK/a/IHgsaHkPfHTaZxEsXHq32AMZzjwvJ2IOrH0ATFeylOFqHKfXf
 t9oZqyOR8XMUsKY7DlXMMQZdyZNBWChkncRgeqy+ND71AgYtthjW6vGtt7307l29xoRR
 4c/ih7hQW+DNqJzkIA31xpO1re6Ukrocb0Zp5o2Bu8MSiclpfuh3U2gTQyWI8i62Kobk
 HRqK6VP7uchy14bjAPiQZ/W75IJejkPZJEoIJ/fwi9R6T6Lv564N4qmePGihG/5qatVv
 Q9PLEustxY945RbmoIi5XShbPU6JMpJR48m0joisdfKJPbIRZhHIia27XiZFSFOQp4vD
 NmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UC0InaM2Av4NdGRB30AcNgGF6NmB2i/F1RQN192G0E0=;
 b=bYA5D+IF5rvkUiwZVr0sNEh6d1zle5xxhrhj9hCKsxblXC/KMQFYxOHA8+r9D0r6YC
 YMxGlm/g4iQPQWN+Wtb2gXqxLebeI+GygWF975hO5kEZSoCBIHVgijydYAGk0LmHVI25
 cXprxg/Sc1B1LqLXBh+RIvsp3/M/S6yRm/XRKbEghwCl96TeN2GcfKrEri4tyA4+v5Ph
 erzMxToNsKCyXBIyYr9b6Q+2QgdCZ4KDPWnykkX10kdq3ngSj8B2NdRPwnhQYOde4dj2
 a+Ro93fPIXBLu+yO5/WxI1RWYZpV4YBw6NOFwE58i5Ke6U5f/V9fdVDohMYoiZyn7PGy
 Jxwg==
X-Gm-Message-State: AOAM531VzgneNsN8MKXxQ5YA3dHR9xWvXfoSqmK5W1TKbChtxh+bZJ11
 IOIJWJxJr222Gm9RsMGcEUks1A==
X-Google-Smtp-Source: ABdhPJw7Wf/PUWOtDu/gHK+DK+I1oe0f4LPcvGnR5zBPgQ9DldM3nWupgVC7g+6FUAXx5nwd4LxPPw==
X-Received: by 2002:a17:90a:ea83:: with SMTP id
 h3mr3524636pjz.176.1595924791246; 
 Tue, 28 Jul 2020 01:26:31 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id h2sm17599747pfk.93.2020.07.28.01.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 01:26:30 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 4/4] target/riscv: Change the TLB page size depends on PMP
 entries.
Date: Tue, 28 Jul 2020 16:26:17 +0800
Message-Id: <6b0bf48662ef26ab4c15381a08e78a74ebd7ca79.1595924470.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595924470.git.zong.li@sifive.com>
References: <cover.1595924470.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=zong.li@sifive.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The minimum granularity of PMP is 4 bytes, it is small than 4KB page
size, therefore, the pmp checking would be ignored if its range doesn't
start from the alignment of one page. This patch detects the pmp entries
and sets the small page size to TLB if there is a PMP entry which cover
the page size.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 target/riscv/cpu_helper.c | 10 ++++++--
 target/riscv/pmp.c        | 52 +++++++++++++++++++++++++++++++++++++++
 target/riscv/pmp.h        |  2 ++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2f337e418c..fd1d373b6f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -693,6 +693,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
+    target_ulong tlb_size = 0;
 
     env->guest_phys_fault_addr = 0;
 
@@ -784,8 +785,13 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     if (ret == TRANSLATE_SUCCESS) {
-        tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
-                     prot, mmu_idx, TARGET_PAGE_SIZE);
+        if (pmp_is_range_in_tlb(env, pa & TARGET_PAGE_MASK, &tlb_size)) {
+            tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
+                         prot, mmu_idx, tlb_size);
+        } else {
+            tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
+                         prot, mmu_idx, TARGET_PAGE_SIZE);
+        }
         return true;
     } else if (probe) {
         return false;
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index aeba796484..adadf6e9ba 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -393,3 +393,55 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 
     return val;
 }
+
+/*
+ * Calculate the TLB size if the start address or the end address of
+ * PMP entry is presented in thie TLB page.
+ */
+static target_ulong pmp_get_tlb_size(CPURISCVState *env, int pmp_index,
+    target_ulong tlb_sa, target_ulong tlb_ea)
+{
+    target_ulong pmp_sa = env->pmp_state.addr[pmp_index].sa;
+    target_ulong pmp_ea = env->pmp_state.addr[pmp_index].ea;
+
+    if (pmp_sa >= tlb_sa && pmp_ea <= tlb_ea) {
+        return pmp_ea - pmp_sa + 1;
+    }
+
+    if (pmp_sa >= tlb_sa && pmp_sa <= tlb_ea && pmp_ea >= tlb_ea) {
+        return tlb_ea - pmp_sa + 1;
+    }
+
+    if (pmp_ea <= tlb_ea && pmp_ea >= tlb_sa && pmp_sa <= tlb_sa) {
+        return pmp_ea - tlb_sa + 1;
+    }
+
+    return 0;
+}
+
+/*
+ * Check is there a PMP entry whcih range covers this page. If so,
+ * try to find the minimum granularity for the TLB size.
+ */
+bool pmp_is_range_in_tlb(CPURISCVState *env, hwaddr tlb_sa,
+    target_ulong *tlb_size)
+{
+    int i;
+    target_ulong val;
+    target_ulong tlb_ea = (tlb_sa + TARGET_PAGE_SIZE - 1);
+
+    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+        val = pmp_get_tlb_size(env, i, tlb_sa, tlb_ea);
+        if (val) {
+            if (*tlb_size == 0 || *tlb_size > val) {
+                *tlb_size = val;
+            }
+        }
+    }
+
+    if (*tlb_size != 0) {
+        return true;
+    }
+
+    return false;
+}
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 8e19793132..c70f2ea4c4 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -60,5 +60,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
     target_ulong size, pmp_priv_t priv, target_ulong mode);
+bool pmp_is_range_in_tlb(CPURISCVState *env, hwaddr tlb_sa,
+    target_ulong *tlb_size);
 
 #endif
-- 
2.27.0


