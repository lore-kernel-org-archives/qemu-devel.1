Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB5C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B1420989
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B1420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTRt-0001Bz-PK
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46667)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hmka2@cl.cam.ac.uk>) id 1hgTMv-0002kA-Cv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hmka2@cl.cam.ac.uk>) id 1hgTMu-0000Hv-3h
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:19:13 -0400
Received: from mta2.cl.cam.ac.uk ([2001:630:212:200::25:2]:47818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hmka2@cl.cam.ac.uk>)
 id 1hgTMk-0008WA-L5; Thu, 27 Jun 2019 08:19:04 -0400
Received: from cassia.cl.cam.ac.uk ([2001:630:212:238:b26e:bfff:fe2f:c7d9])
 by mta2.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.86_2) (envelope-from <hmka2@cl.cam.ac.uk>)
 id 1hgTMY-000Sdt-ML; Thu, 27 Jun 2019 13:18:50 +0100
Received: from hmka2 by cassia.cl.cam.ac.uk with local (Exim 4.90_1)
 (envelope-from <hmka2@cl.cam.ac.uk>)
 id 1hgTMY-0002Lf-Kk; Thu, 27 Jun 2019 13:18:50 +0100
From: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
To: qemu-riscv@nongnu.org
Date: Thu, 27 Jun 2019 13:18:25 +0100
Message-Id: <20190627121828.8376-3-Hesham.Almatary@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627121828.8376-1-Hesham.Almatary@cl.cam.ac.uk>
References: <20190627121828.8376-1-Hesham.Almatary@cl.cam.ac.uk>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:630:212:200::25:2
Subject: [Qemu-devel] [PATCHv4 3/6] RISC-V: Check for the effective memory
 privilege mode during PMP checks
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current PMP check function checks for env->priv which is not the effective
memory privilege mode.

For example, mstatus.MPRV could be set while executing in M-Mode, and in that
case the privilege mode for the PMP check should be S-Mode rather than M-Mode
(in env->priv) if mstatus.MPP == PRV_S.

This patch passes the effective memory privilege mode to the PMP check.
Functions that call the PMP check should pass the correct memory privilege mode
after reading mstatus' MPRV/MPP or hstatus.SPRV (if Hypervisor mode exists).

Suggested-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
---
 target/riscv/cpu_helper.c | 10 +++++++++-
 target/riscv/pmp.c        |  6 +++---
 target/riscv/pmp.h        |  2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7c7282c680..5a1cd7cf96 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -392,19 +392,27 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int prot;
     bool pmp_violation = false;
     int ret = TRANSLATE_FAIL;
+    int mode = mmu_idx;

     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);

     ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);

+    if (mode == PRV_M && access_type != MMU_INST_FETCH) {
+        if (get_field(env->mstatus, MSTATUS_MPRV)) {
+            mode = get_field(env->mstatus, MSTATUS_MPP);
+        }
+    }
+
     qemu_log_mask(CPU_LOG_MMU,
                   "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
                   " prot %d\n", __func__, address, ret, pa, prot);

     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
-        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
+        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type,
+        mode)) {
         pmp_violation = true;
         ret = TRANSLATE_FAIL;
     }
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b11c4ae22f..89170bc11d 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -229,7 +229,7 @@ static int pmp_is_in_range(CPURISCVState *env, int pmp_index, target_ulong addr)
  * Check if the address has required RWX privs to complete desired operation
  */
 bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
-    target_ulong size, pmp_priv_t privs)
+    target_ulong size, pmp_priv_t privs, target_ulong mode)
 {
     int i = 0;
     int ret = -1;
@@ -265,7 +265,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
             }

             allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
-            if ((env->priv != PRV_M) || pmp_is_locked(env, i)) {
+            if ((mode != PRV_M) || pmp_is_locked(env, i)) {
                 allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
             }

@@ -281,7 +281,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,

     /* No rule matched */
     if (ret == -1) {
-        if (env->priv == PRV_M) {
+        if (mode == PRV_M) {
             ret = 1; /* Privileged spec v1.10 states if no PMP entry matches an
                       * M-Mode access, the access succeeds */
         } else {
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 66790950eb..8e19793132 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -59,6 +59,6 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
     target_ulong val);
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
-    target_ulong size, pmp_priv_t priv);
+    target_ulong size, pmp_priv_t priv, target_ulong mode);

 #endif
--
2.17.1


