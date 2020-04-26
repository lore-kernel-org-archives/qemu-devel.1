Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B5C55199
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C1E20700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KwgK+91W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C1E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkBn-00037b-DQ
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk82-0004g3-RZ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk82-0004WW-8X
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk81-0004Lu-MJ; Sun, 26 Apr 2020 12:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918458; x=1619454458;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SNPqdx+w5gimlKtZRUjlEdolMCX+BsbkFGAwV2LHuFU=;
 b=KwgK+91WdTZbnQcblzsW+oPbAONtD9OleuPyCiMOntLQ921nEjHFTmjy
 k8n3m2St56d/0DLNUUMymGMAqHHNALpbeuejHFlqEpWMj9LDlVouHiq9d
 pUGN4wBicqeuLC57+VfWQ3oVLc/OIEtxOHIVLLWBUrUr2tEIRG1/L9T0X
 +lma3Ctb4OUI03HNvUQ1VqUt/AfX2Oypg1BuJklKuzeoRYPDakqF1gAxi
 dTARkEm3PtEjWVrywJvuz5X4pVA9e99NIhFFr0o5YigPtgQCxJMZaWyNs
 3qB2pDOjb9QTS7GVHhCjEPabxXZR4UOXKldgmcTh/1HZ1fmW/ZZn27gvj w==;
IronPort-SDR: +FOOvhuv3rJ2gEnE0iFrolOY1mW7jkXjeMqD+49Y/xrQeGoc+ghIWD7u1xNWiWHgQXjEjwfGF2
 4H0UoBEDYzh97mrrs8CsMm5WUdfXpi2hXqE3qLObkxWlbbF4BuIrTvi/jARGGugviSAswnRXHw
 pNCQY1sP3LhsMQWW9LicU9VPCuapAjhjczA/EeaykF9fHA9SSMZxwpV7pA1OdNoEuMvHBFelPH
 2Ni3PaXqGbROei8DOtjlNudZ6OYAlafoECFxmise4NJOdy9mZbWQKrfclf3wJQ/DUSHaioMZVM
 HAM=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="137626674"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:37 +0800
IronPort-SDR: D6GXHfKLaAGKe68MTHqU8wGILDqrRCuuiCr8rI1e98LAR1xoOWEGAiThQDXivKaRE3aj3JRJtb
 vJZ9gGgRUTTCa/YDbkfDipmt8/DmYyRj8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:19 -0700
IronPort-SDR: OS9xMFmjjTKnWZ2rO50f8f+DXqMsu88rHKweqKfW/xjy5uC9tkXzx2tPTKvA45iXHHaU1rPM53
 vQoPawoCLe8w==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:36 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 05/15] target/riscv: Allow setting a two-stage lookup in
 the virt status
Date: Sun, 26 Apr 2020 09:19:26 -0700
Message-Id: <ad426660833205907c521eaa5cf1680c0fb69ebe.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0e7f5b9c5..e44a7a91e4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -302,6 +302,8 @@ bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
+bool riscv_cpu_two_stage_lookup(CPURISCVState *env);
+void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7f64ee1174..f52711ac32 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -452,6 +452,7 @@
  * page table fault.
  */
 #define FORCE_HS_EXCEP      2
+#define HS_TWO_STAGE        4
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0d4a7b752d..075675c59c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -220,6 +220,24 @@ void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, FORCE_HS_EXCEP, enable);
 }
 
+bool riscv_cpu_two_stage_lookup(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, HS_TWO_STAGE);
+}
+
+void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, HS_TWO_STAGE, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.26.2


