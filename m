Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D27C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8A320873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="frIcUwHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8A320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2eG-0002P3-N0
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iK2Yf-0005Eg-7A
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iK2Yd-00083Z-7d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:53 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:50623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iK2YK-0007ql-5d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1571067991; h=Content-Transfer-Encoding: MIME-Version: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=4uh4XYKZoSn8NOfnf5km4QH3rcQLS4UNihTw7pl8V1k=;
 b=frIcUwHlBZM0BOQ9ZwujlGfhDuepoGKyXSnUHWO1guGwkAyinv8KKc12syUIOxHUU7DKyxZH
 b8DdxpzLRzkffdY0imZVEa2X3Jgherseya3qgCmknjQB9AAhYtu0tNXKno+3yns8rwzAktTG
 MOkYPkFbOPs5D9A7l2I2SCVI5GQg7UxgDYNh6B33i83cFQT2GV1UKwaLRf0mZ5qMx5ixLZOZ
 JxbrmeuKvPhZbIInXe85IkVO+MQWNpEzUxCKcPfMTOKLbSLjsLn8v/OCnNdaGuHyKWitFiKi
 K7AvPywyO1tcBD3eS7z/+C3rlqeSvB9rxKBdy3S+X+O+QMxb2MGdWA==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.pdos.lcs.mit.edu
 (26-5-211.dynamic.csail.mit.edu [18.26.5.211])
 by mxa.mailgun.org with ESMTP id 5da49853.7f705dace450-smtp-out-n01;
 Mon, 14 Oct 2019 15:46:27 -0000 (UTC)
From: Jonathan Behrens <jonathan@fintelia.io>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 2/3] target/riscv: Expose "priv" register for GDB for reads
Date: Mon, 14 Oct 2019 11:45:28 -0400
Message-Id: <20191014154529.287048-3-jonathan@fintelia.io>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014154529.287048-1-jonathan@fintelia.io>
References: <20191014154529.287048-1-jonathan@fintelia.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.61.151.224
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
 Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch enables a debugger to read the current privilege level via a virtual
"priv" register. When compiled with CONFIG_USER_ONLY the register is still
visible but always reports the value zero.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
---
 configure                       |  4 ++--
 gdb-xml/riscv-32bit-virtual.xml | 11 +++++++++++
 gdb-xml/riscv-64bit-virtual.xml | 11 +++++++++++
 target/riscv/gdbstub.c          | 23 +++++++++++++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 gdb-xml/riscv-32bit-virtual.xml
 create mode 100644 gdb-xml/riscv-64bit-virtual.xml

diff --git a/configure b/configure
index 30544f52e6..6118a6a045 100755
--- a/configure
+++ b/configure
@@ -7520,13 +7520,13 @@ case "$target_name" in
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
+    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
+    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
   ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-virtual.xml
new file mode 100644
index 0000000000..905f1c555d
--- /dev/null
+++ b/gdb-xml/riscv-32bit-virtual.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.virtual">
+  <reg name="priv" bitsize="32"/>
+</feature>
diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-virtual.xml
new file mode 100644
index 0000000000..62d86c237b
--- /dev/null
+++ b/gdb-xml/riscv-64bit-virtual.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.virtual">
+  <reg name="priv" bitsize="64"/>
+</feature>
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index cb5bfd3d50..1f71604b78 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -373,6 +373,23 @@ static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
+static int riscv_gdb_get_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
+{
+    if (n == 0) {
+#ifdef CONFIG_USER_ONLY
+        return gdb_get_regl(mem_buf, 0);
+#else
+        return gdb_get_regl(mem_buf, cs->priv);
+#endif
+    }
+    return 0;
+}
+
+static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
+{
+    return 0;
+}
+
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -385,6 +402,9 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              240, "riscv-32bit-csr.xml", 0);
+
+    gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
+                             1, "riscv-32bit-virtual.xml", 0);
 #elif defined(TARGET_RISCV64)
     if (env->misa & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
@@ -393,5 +413,8 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              240, "riscv-64bit-csr.xml", 0);
+
+    gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
+                             1, "riscv-64bit-virtual.xml", 0);
 #endif
 }
-- 
2.23.0

