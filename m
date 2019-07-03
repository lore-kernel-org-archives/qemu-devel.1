Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D07AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538F221882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538F221882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1highU-0003Es-Fo
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <georg.kotheimer@kernkonzept.com>) id 1higDj-0002j6-KK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <georg.kotheimer@kernkonzept.com>) id 1higDh-0004AC-MH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:26:51 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]:59405
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <georg.kotheimer@kernkonzept.com>)
 id 1higDf-00043R-MS; Wed, 03 Jul 2019 10:26:49 -0400
Received: from [95.90.166.246] (helo=tweek.dd1.int.kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) id 1higDU-0003do-OA; Wed, 03 Jul 2019 16:26:36 +0200
From: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 16:26:17 +0200
Message-Id: <20190703142617.21073-1-georg.kotheimer@kernkonzept.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c1c:b490::2
X-Mailman-Approved-At: Wed, 03 Jul 2019 10:56:11 -0400
Subject: [Qemu-devel] [PATCH] RISC-V: Select FPU gdb xml file based on the
 supported extensions
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

Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
---
 configure                                        |  4 ++--
 gdb-xml/{riscv-64bit-fpu.xml => riscv-fpu-d.xml} |  0
 gdb-xml/{riscv-32bit-fpu.xml => riscv-fpu-f.xml} |  0
 target/riscv/gdbstub.c                           | 15 +++++++--------
 4 files changed, 9 insertions(+), 10 deletions(-)
 rename gdb-xml/{riscv-64bit-fpu.xml => riscv-fpu-d.xml} (100%)
 rename gdb-xml/{riscv-32bit-fpu.xml => riscv-fpu-f.xml} (100%)

diff --git a/configure b/configure
index f2cb9f3c66..462c5a4f1a 100755
--- a/configure
+++ b/configure
@@ -7581,14 +7581,14 @@ case "$target_name" in
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
+    gdb_xml_files="riscv-32bit-cpu.xml riscv-fpu-f.xml riscv-fpu-d.xml riscv-32bit-csr.xml"
     target_compiler=$cross_cc_riscv32
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
+    gdb_xml_files="riscv-64bit-cpu.xml riscv-fpu-f.xml riscv-fpu-d.xml riscv-64bit-csr.xml"
     target_compiler=$cross_cc_riscv64
   ;;
   sh4|sh4eb)
diff --git a/gdb-xml/riscv-64bit-fpu.xml b/gdb-xml/riscv-fpu-d.xml
similarity index 100%
rename from gdb-xml/riscv-64bit-fpu.xml
rename to gdb-xml/riscv-fpu-d.xml
diff --git a/gdb-xml/riscv-32bit-fpu.xml b/gdb-xml/riscv-fpu-f.xml
similarity index 100%
rename from gdb-xml/riscv-32bit-fpu.xml
rename to gdb-xml/riscv-fpu-f.xml
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 27be93279b..29fa468b28 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -375,20 +375,19 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-#if defined(TARGET_RISCV32)
-    if (env->misa & RVF) {
+
+    if (env->misa & RVD) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
-                                 36, "riscv-32bit-fpu.xml", 0);
+                                 36, "riscv-fpu-d.xml", 0);
+    } else if (env->misa & RVF) {
+        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
+                                 36, "riscv-fpu-f.xml", 0);
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
2.19.1


