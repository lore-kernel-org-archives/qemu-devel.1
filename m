Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9F5207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="nLSfw7Sz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="nLSfw7Sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9F5207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwaMn-0002Zj-F9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 18:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.org>) id 1iwaLE-0001tJ-Tx
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.org>) id 1iwaLD-0006I2-Rz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:32:20 -0500
Received: from home.keithp.com ([63.227.221.253]:44598 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.org>)
 id 1iwaLD-0006FJ-Lm; Tue, 28 Jan 2020 18:32:19 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id BAC5C3F2A89B;
 Tue, 28 Jan 2020 15:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1580254338; bh=wh4Wst2qJAcsdTxmbufjJzuxkXZslL6kirqAxDIsWJk=;
 h=From:To:Cc:Subject:Date:From;
 b=nLSfw7SzEimqF03zxuDpUM5EQ9A+pzPWACHF7QrQJsRrNJm2KvoWINBQy91sqi3Oz
 e0UHovFx5DP8HUiT7nc95Zfq+7AmPw9GR5AXK7l0W5lF8fVzxODWKTobSv2eM6pB+3
 jgFu9bH6+Yf2gcsX1IBrXkPXGhilF3D3IgZLyYbUtPvW0S5FREOElilbLj9xpmrEWR
 JBArULQJhWTOMZBeOisGOLeIB4OQ2E6ak7av3sbLX/uu1iPVrc/AvPZRuP6xjsyXGT
 MnYA3rXFUpDQxr/50ztLg9fIeXObDdCJknv8L5MDhKk6CnBWU/J0oF1HAr4Zs2DkZh
 Oi8K1jrYDJvlA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 2GCMjx2hAEOq; Tue, 28 Jan 2020 15:32:18 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 616843F2A895;
 Tue, 28 Jan 2020 15:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1580254338; bh=wh4Wst2qJAcsdTxmbufjJzuxkXZslL6kirqAxDIsWJk=;
 h=From:To:Cc:Subject:Date:From;
 b=nLSfw7SzEimqF03zxuDpUM5EQ9A+pzPWACHF7QrQJsRrNJm2KvoWINBQy91sqi3Oz
 e0UHovFx5DP8HUiT7nc95Zfq+7AmPw9GR5AXK7l0W5lF8fVzxODWKTobSv2eM6pB+3
 jgFu9bH6+Yf2gcsX1IBrXkPXGhilF3D3IgZLyYbUtPvW0S5FREOElilbLj9xpmrEWR
 JBArULQJhWTOMZBeOisGOLeIB4OQ2E6ak7av3sbLX/uu1iPVrc/AvPZRuP6xjsyXGT
 MnYA3rXFUpDQxr/50ztLg9fIeXObDdCJknv8L5MDhKk6CnBWU/J0oF1HAr4Zs2DkZh
 Oi8K1jrYDJvlA==
Received: by keithp.com (Postfix, from userid 1000)
 id 419691582162; Tue, 28 Jan 2020 15:32:18 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org,
 Keith Packard <keithp@keithp.com>
Subject: [PATCH] riscv: Separate FPU register size from core register size in
 gdbstub [v2]
Date: Tue, 28 Jan 2020 15:32:16 -0800
Message-Id: <20200128233216.515171-1-keithp@keithp.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.227.221.253
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Keith Packard <keithp@keithp.com>
From: Keith Packard via <qemu-devel@nongnu.org>

The size of the FPU registers is dictated by the 'f' and 'd' features,
not the core processor register size. Processors with the 'd' feature
have 64-bit FPU registers. Processors without the 'd' feature but with
the 'f' feature have 32-bit FPU registers.

Signed-off-by: Keith Packard <keithp@keithp.com>

---

v2:
    Fix checkpatch formatting complaints.
---
 configure              |  4 ++--
 target/riscv/gdbstub.c | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index a72a5def57..c21bff8d10 100755
--- a/configure
+++ b/configure
@@ -7709,13 +7709,13 @@ case "$target_name" in
     TARGET_BASE_ARCH=3Driscv
     TARGET_ABI_DIR=3Driscv
     mttcg=3Dyes
-    gdb_xml_files=3D"riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit=
-csr.xml riscv-32bit-virtual.xml"
+    gdb_xml_files=3D"riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit=
-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
   ;;
   riscv64)
     TARGET_BASE_ARCH=3Driscv
     TARGET_ABI_DIR=3Driscv
     mttcg=3Dyes
-    gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit=
-csr.xml riscv-64bit-virtual.xml"
+    gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit=
-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
   ;;
   sh4|sh4eb)
     TARGET_ARCH=3Dsh4
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1a7947e019..1a72f7be9c 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -303,7 +303,12 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8=
_t *mem_buf, int n)
 static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n=
)
 {
     if (n < 32) {
-        return gdb_get_reg64(mem_buf, env->fpr[n]);
+        if (env->misa & RVD) {
+            return gdb_get_reg64(mem_buf, env->fpr[n]);
+        }
+        if (env->misa & RVF) {
+            return gdb_get_reg32(mem_buf, env->fpr[n]);
+        }
     /* there is hole between ft11 and fflags in fpu.xml */
     } else if (n < 36 && n > 32) {
         target_ulong val =3D 0;
@@ -403,23 +408,20 @@ void riscv_cpu_register_gdb_regs_for_features(CPUSt=
ate *cs)
 {
     RISCVCPU *cpu =3D RISCV_CPU(cs);
     CPURISCVState *env =3D &cpu->env;
-#if defined(TARGET_RISCV32)
-    if (env->misa & RVF) {
+    if (env->misa & RVD) {
+        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fp=
u,
+                                 36, "riscv-64bit-fpu.xml", 0);
+    } else if (env->misa & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fp=
u,
                                  36, "riscv-32bit-fpu.xml", 0);
     }
-
+#if defined(TARGET_RISCV32)
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              240, "riscv-32bit-csr.xml", 0);
=20
     gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_vi=
rtual,
                              1, "riscv-32bit-virtual.xml", 0);
 #elif defined(TARGET_RISCV64)
-    if (env->misa & RVF) {
-        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fp=
u,
-                                 36, "riscv-64bit-fpu.xml", 0);
-    }
-
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              240, "riscv-64bit-csr.xml", 0);
=20
--=20
2.25.0


