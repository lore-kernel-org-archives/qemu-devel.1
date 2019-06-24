Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021EFC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C451D20663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ME6ezsvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C451D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55562 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfYjT-0006L0-3n
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 19:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52034)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe8-0001Ky-2O
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe6-0001Nv-EU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22363)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe5-0001FV-EN; Mon, 24 Jun 2019 19:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561420075; x=1592956075;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b+EHrskRbgiYN4wK+XpeJIoohi/4XorSgGeJtVGGG7g=;
 b=ME6ezsvKIqizIX3Z+ON5il/vREhxfS3HVd3rVvNAIR/P0dxkXjAn7qq6
 kB5Lu02o7ylPjoJBaitek1nqhJ7k3fBaP8FRfFi/pS4plSbktYhAbFBCG
 mRVP2MhI8LTNBrIzSnxrrQIn/1KczJLJDc9PYUFcbf6ZNkGFczl7ushTS
 ojqoxu1Qyiv5SzP3qWKoTezTNjJEbYs63AXjBUykTdmc78WX/+dTl/Ew8
 j16kfPExKHuoZBV0/m/N8TOhG1G27j9hLARDjLGNJY6RpLxfaVdS7sjoK
 Beo2umzZS5tU00NV/tCxRv34IeCB7KnvIRH9YyTGgWh54wKOQGTVbPwTF g==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="211216781"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 07:47:51 +0800
IronPort-SDR: 5UOn+JMLSqZtamn3rY2jCrKOrGJkQLVztlbVcQSu8b1z/cVuAOlVHMypk+AKO6dEFvacdNehCD
 s+OeDr6Mjwh+toG6TmgtEzJ425qQtkhKyQ3pzG/4tR1zm+84dlovtXY0ERzG/5uWWeMdAFh3ko
 bS8pmUWwIZ99Lxt3raiKFw28aZXDZnG4xBEXxLJib4YTkjlbMp50qZwxpAUK7Aqy9QoF/UbFzm
 na0zyRBKaGE91j08+EBdkn9nXBw6zI3nXDJP33lyinGI11PmUtvo3IiQPKzYKGfxmjTW7aig/B
 2aV3hKN/xqKyjkKIXuVcJCp7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 16:44:24 -0700
IronPort-SDR: i5q57TWw4ofEtAL0b8zvgBb4DuY7EP8djwGUNWo7yUCRTWCdW86t1aDgb7v7olL/Xhu1bnFSFt
 rVMHjcSfn4WsBvwjUrvG7Rwmus/5E5lpQPCN0zyOgF6X5q3IvCCLcNOh0XiumW6Ojdc2ebusTR
 Wf6UYzOOrmurdhbmwucvrC+eqgzIrn5MfBb64DQ1NtEMuSLFdSws2itJsdlJnPn86SUhet1Bsg
 aIRVDZRUkIQMO8SpzWItKBtIqnr3xmLNkmV24kUQnA3qwVtfUf0+dNrUv1A+uFButwQaqqASoY
 Ulc=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Jun 2019 16:45:06 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 16:42:38 -0700
Message-Id: <e762ccdb1ca778aff7a0d987a722b3246faf1cce.1561419713.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561419713.git.alistair.francis@wdc.com>
References: <cover.1561419713.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v2 4/4] target/riscv: Implement
 riscv_cpu_unassigned_access
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Clark <mjc@sifive.com>

This patch adds support for the riscv_cpu_unassigned_access call
and will raise a load or store access fault.

Signed-off-by: Michael Clark <mjc@sifive.com>
[Changes by AF:
 - Squash two patches and rewrite commit message
 - Set baddr to the access address
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  1 +
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6f2b644220..f656714d59 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -416,6 +416,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
 #ifndef CONFIG_USER_ONLY
+    cc->do_unassigned_access = riscv_cpu_unassigned_access;
     cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6c5de37b25..dc31b16dcb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -248,6 +248,8 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
+void riscv_cpu_unassigned_access(CPUState *cpu, hwaddr addr, bool is_write,
+                                 bool is_exec, int unused, unsigned size);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8b6754b917..0bbfb7f48b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -375,6 +375,22 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
+void riscv_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
+                                 bool is_exec, int unused, unsigned size)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (is_write) {
+        cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+    } else {
+        cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+    }
+
+    env->badaddr = addr;
+    riscv_raise_exception(&cpu->env, cs->exception_index, GETPC());
+}
+
 void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type, int mmu_idx,
                                    uintptr_t retaddr)
-- 
2.22.0


