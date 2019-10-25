Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19B9CA9EBF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA28921872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fF/B/hj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA28921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO98E-0005J2-AC
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90q-00051t-1i
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90n-0004Ch-5f
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90m-0004C1-UF; Fri, 25 Oct 2019 19:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046132; x=1603582132;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yMWZbTyS09Qj9dioNQRewgxpX8PPPn2TTEBKlAiR5HI=;
 b=fF/B/hj7SnPxNb61bJzASYuGEi2mhy0wJTJvE483YJo1fhUT16rUkA5A
 o7DNV8DTsLkMVZADZEDLtv+UMVMROq8HSim9rgOu+WT8mtwsmHIjKqD2J
 hnje6cxd1V/pCOHsuONsX6f4AZyM1EPeakYgzrtoLE5s5g2tQmENxDk9d
 Bug6K5kM13DIIhvHFt+xaHFKUlB8YwR0LPUhnSOjBZjMHkrn9Zp1bJ4YU
 /G2/xMSGFE9E7exRWp5uEVUz1qAsnDV6x7g1iXV6Fd3ek9lZEdn7rmLz6
 A8tEHK5T36ZB77PZsFxB95BVL+kQc34UMpk1W5isDG5o5CpV8E6U9DG7F A==;
IronPort-SDR: 8FWcOQDcoCPbNRTL4bbp9C9RHBZZEZc5npsBQ8ADftSRJuOjnCirJ8eC6R9fyqEAQi8vk2Ewog
 KnK/4x4T8AFpDmTk0rjQxIoSTMhbnM6AgciwU+RoKH+LSRda9G4dkqyAluSE6QNtQMJiDbLBuF
 +JQfyzknOMzlmONG7P1jUxR5ppB09rDeqoQv0cBAKsYXuAvz+uWpVrD4wLU4NFeXMsx6Yy8h7Q
 gvsGsTat0wRHn7mHCuiwPlEb+N016lCOE5uU5zsLi59JCF0pVZ69QENyq3vmNF3fHoOpdU9O3Q
 dJg=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520387"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:13 +0800
IronPort-SDR: XzBPCxNWHEQsu+jCuPNsHIh6+ZDNeCYBxaoesD+jOEw77Op8vC5nogp2yx68rIWMaen4t6ZJrE
 c/19H+ud7VKDckZE9jODn+4on/3ZskczznRxULC5TsHnWrHkKgVc0d97ZPo5NSoaA5DxneTEl5
 JQz2HTUIXpQNItJjt4ZBeurkIq9A5P9Ub/X6Tp1YGxFnbaoX+IcZkgPArPiZes10Ib2JdmzETN
 K07BZhddUSQwW65b6b7v3Z9j05uxLi+PejgX46ftC9hBTa4ebRDf73Y7+vR84E2+6VCebruqRp
 3Gbw7VrxH0CYTUdDQM8ofwXL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:23:39 -0700
IronPort-SDR: tlC+dNYdKDHL+jfN0iplGcHaTSZq50UZtIokMMO5W5NxvV77ITayQSdsREaUEM9YdpvwZPZX6l
 1HikYpTPGJnodHk3gw0gX51IK/VOCTXnaPZ4Xu03/xmFu4MhmE+mb+wmxPA8zV/o715QUfUNBW
 /hKpkXLI5F5qGDYYLzuRTHmq8/f+6IUmAwp08Obyh2vw/1CuFs0T+3ih7UBIimgIMv5y5KR7L0
 4tEj+SZX5frsm+vOobwfQEU4C1Dy5qBNAFmxGWziLuNFMQdQvMo2Fk7IfkfTO0vATCwCIRLaaP
 6Vs=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:28:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 03/27] target/riscv: Add the virtulisation mode
Date: Fri, 25 Oct 2019 16:23:18 -0700
Message-Id: <ff8c971109f1159e2fff7a64ea0b58533c329302.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  4 ++++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 91e1c56fc4..469dcbd1c0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -117,6 +117,8 @@ struct CPURISCVState {
 
 #ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* This contains QEMU specific information about the virt state. */
+    target_ulong virt;
     target_ulong resetvec;
 
     target_ulong mhartid;
@@ -248,6 +250,8 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
+bool riscv_cpu_virt_enabled(CPURISCVState *env);
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e99834856c..b4119cc002 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -422,6 +422,9 @@
 #define PRV_H 2 /* Reserved */
 #define PRV_M 3
 
+/* Virtulisation Register Fields */
+#define VIRT_ONOFF          1
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 31f553efb9..0306f3181d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -82,6 +82,24 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
     return false;
 }
 
+bool riscv_cpu_virt_enabled(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, VIRT_ONOFF);
+}
+
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, VIRT_ONOFF, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.23.0


