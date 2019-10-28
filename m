Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67874CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E1D20717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SvAdebdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E1D20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP847-00050Y-Sq
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7PU-00056t-Ki
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7PS-0003l1-RV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:24 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7PS-0003kO-ML
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:22 -0400
Received: by mail-pf1-x444.google.com with SMTP id b128so7174063pfa.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=NTDCXoct0r20MWf46zhs8NOznjZVo4mAIr2TQFqNsno=;
 b=SvAdebdVMX9kWzSmRv9+gk3fa1bjFCWyJonqHKFtYJKtvo5yqILznp+4Xxlfhz4ysl
 dMgv3sQI9MAqmqOFlY7Q6YmOVFKw0vZIaUyqBTK0pnG6CQxgydEyrbX44QlKhgYpk6vv
 /w00HCY2rrArTEDDVKhPRH0U40Qis8SEwubx05AylAKlM4kuxA3Z31M2Ag68Gjz0RkHE
 yET90GyQzQsq1RErMl/RgFZ171WZcei61CI5iJPHywZr6qBY/53J64xAaYjKrQ+RBtAF
 qaNGPQiLcAxTB3UClIW4od2EDffmcYLfbUSADe6PhNG1uQ35WtQ9heu93SRt28PuUvEz
 5zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=NTDCXoct0r20MWf46zhs8NOznjZVo4mAIr2TQFqNsno=;
 b=FBA88hokbch/XQGMI0NCGhDT3Hb0wgTdAwxXRlE4RjiVYyUJtugpVGHShMI9aPJVMe
 l4YsM3xSUrlUX14WwtXbljhXcMrPP4pdo9N5l8xA818v4Vygmdya3LS/O7+Hx8tSk4zy
 4wL2F5bHPV2bRbVEKbwnH49l8FIXQSu4o8G8GORdKwkv1uKA4+0obHLx7ijihS2oEYUs
 C7/ZxOsr7Qx+QqCkuibdGsIitLoDkmPDt4PHspO4+yLl4CuFboZdKhnaEd9oZk0eMn6J
 Ml2VEuyZ/PopxFUqFndWmKf7II/HEWmd6CzAfqNuISjI44TaLitosadFVfyj0Gn8VDpj
 J8jw==
X-Gm-Message-State: APjAAAW3Fhe6zy6VUa8gr5xYIWi7KMjBrQLdPjkb3JXwXcaIOmdbfx2i
 hm8rZAw4jNgtA8FdipoPMrjTZqEkJjkxPw==
X-Google-Smtp-Source: APXvYqyjqVlr7mXVtsL/tk24DaXugRUC/POwfZuSUxF7FbtAbaW9gr82rekRs2Lx71vvSexEDMy/7g==
X-Received: by 2002:aa7:8e16:: with SMTP id c22mr21089336pfr.116.1572278301380; 
 Mon, 28 Oct 2019 08:58:21 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f25sm15812305pfk.10.2019.10.28.08.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:20 -0700 (PDT)
Subject: [PULL 03/18] RISC-V: Implement cpu_do_transaction_failed
Date: Mon, 28 Oct 2019 08:48:47 -0700
Message-Id: <20191028154902.32491-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This converts our port over from cpu_do_unassigned_access to
cpu_do_transaction_failed, as cpu_do_unassigned_access has been
deprecated.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu.h        |  7 +++++--
 target/riscv/cpu_helper.c | 11 +++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f13e298a36..3939963b71 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -484,7 +484,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
 #ifndef CONFIG_USER_ONLY
-    cc->do_unassigned_access = riscv_cpu_unassigned_access;
+    cc->do_transaction_failed = riscv_cpu_do_transaction_failed;
     cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 124ed33ee4..8c64c68538 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -264,8 +264,11 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
-void riscv_cpu_unassigned_access(CPUState *cpu, hwaddr addr, bool is_write,
-                                 bool is_exec, int unused, unsigned size);
+void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c82e7ed52b..917252f71b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -408,20 +408,23 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
-void riscv_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
-                                 bool is_exec, int unused, unsigned size)
+void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
-    if (is_write) {
+    if (access_type == MMU_DATA_STORE) {
         cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
     } else {
         cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
     }
 
     env->badaddr = addr;
-    riscv_raise_exception(&cpu->env, cs->exception_index, GETPC());
+    riscv_raise_exception(&cpu->env, cs->exception_index, retaddr);
 }
 
 void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
-- 
2.21.0


