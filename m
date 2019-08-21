Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D9EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58EC22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58EC22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TcC-0002u1-Pt
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <georg.kotheimer@kernkonzept.com>) id 1i0TZh-0006Y3-Ub
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <georg.kotheimer@kernkonzept.com>) id 1i0TTU-0002FI-4K
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:28:41 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]:44095
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <georg.kotheimer@kernkonzept.com>)
 id 1i0TTT-0002F0-HS; Wed, 21 Aug 2019 12:28:39 -0400
Received: from [95.90.100.178] (helo=tweek.dd1.int.kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) id 1i0TTS-00084n-Cz; Wed, 21 Aug 2019 18:28:38 +0200
From: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:28:31 +0200
Message-Id: <20190821162831.27811-1-georg.kotheimer@kernkonzept.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c1c:b490::2
Subject: [Qemu-devel] [PATCH v3] RISC-V: Select FPU gdb xml file based on
 the supported extensions
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 Georg Kotheimer <georg.kotheimer@kernkonzept.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The size of the FPU registers depends solely on the floating point
extensions supported by the target architecture.
However, in the previous implementation the floating point register
size was derived from whether the target architecture is 32-bit or
64-bit.

To allow RVF without RVD, changes to riscv_gdb_get_fpu() and
riscv_gdb_set_fpu() were necessary.

Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
---
 configure              |  4 ++--
 target/riscv/gdbstub.c | 45 ++++++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/configure b/configure
index 714e7fb6a1..44ee953022 100755
--- a/configure
+++ b/configure
@@ -7596,14 +7596,14 @@ case "$target_name" in
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
+    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-csr.xml"
     target_compiler=$cross_cc_riscv32
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
+    gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
     target_compiler=$cross_cc_riscv64
   ;;
   sh4|sh4eb)
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 27be93279b..89b2543c9d 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -303,19 +303,22 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
 {
     if (n < 32) {
-        return gdb_get_reg64(mem_buf, env->fpr[n]);
+        if (env->misa & RVD) {
+            return gdb_get_reg64(mem_buf, env->fpr[n]);
+        }
+        return gdb_get_reg32(mem_buf, env->fpr[n]);
     /* there is hole between ft11 and fflags in fpu.xml */
     } else if (n < 36 && n > 32) {
         target_ulong val = 0;
         int result;
         /*
-         * CSR_FFLAGS is at index 8 in csr_register, and gdb says it is FP
-         * register 33, so we recalculate the map index.
+         * CSR_FFLAGS is at index 1 in the csr space, and gdb says it is FP
+         * register 33, so we recalculate the csr index.
          * This also works for CSR_FRM and CSR_FCSR.
          */
-        result = riscv_csrrw_debug(env, n - 33 +  8, &val, 0, 0);
+        result = riscv_csrrw_debug(env, n - 33 + CSR_FFLAGS, &val, 0, 0);
         if (result == 0) {
-            return gdb_get_regl(mem_buf, val);
+            return gdb_get_reg32(mem_buf, val);
         }
     }
     return 0;
@@ -324,20 +327,25 @@ static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
 static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
 {
     if (n < 32) {
-        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
-        return sizeof(uint64_t);
+        if (env->misa & RVD) {
+            env->fpr[n] = ldq_p(mem_buf);
+            return sizeof(uint64_t);
+        } else {
+            env->fpr[n] = ldl_p(mem_buf);
+            return sizeof(uint32_t);
+        }
     /* there is hole between ft11 and fflags in fpu.xml */
     } else if (n < 36 && n > 32) {
-        target_ulong val = ldtul_p(mem_buf);
+        target_ulong val = ldl_p(mem_buf);
         int result;
         /*
-         * CSR_FFLAGS is at index 8 in csr_register, and gdb says it is FP
-         * register 33, so we recalculate the map index.
+         * CSR_FFLAGS is at index 1 in the csr space, and gdb says it is FP
+         * register 33, so we recalculate the csr index.
          * This also works for CSR_FRM and CSR_FCSR.
          */
-        result = riscv_csrrw_debug(env, n - 33 + 8, NULL, val, -1);
+        result = riscv_csrrw_debug(env, n - 33 + CSR_FFLAGS, NULL, val, -1);
         if (result == 0) {
-            return sizeof(target_ulong);
+            return sizeof(uint32_t);
         }
     }
     return 0;
@@ -375,20 +383,19 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-#if defined(TARGET_RISCV32)
-    if (env->misa & RVF) {
+
+    if (env->misa & RVD) {
+        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
+                                 36, "riscv-64bit-fpu.xml", 0);
+    } else if (env->misa & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
                                  36, "riscv-32bit-fpu.xml", 0);
     }
 
+#if defined(TARGET_RISCV32)
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              4096, "riscv-32bit-csr.xml", 0);
 #elif defined(TARGET_RISCV64)
-    if (env->misa & RVF) {
-        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
-                                 36, "riscv-64bit-fpu.xml", 0);
-    }
-
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              4096, "riscv-64bit-csr.xml", 0);
 #endif
-- 
2.20.1


