Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A4CC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE462084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE462084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHNeo-0000vj-VB
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 03:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.abakumov@ispras.ru>) id 1iHNdu-0008U4-Q7
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.abakumov@ispras.ru>) id 1iHNdt-00089H-5Q
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:41:18 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49226)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <mikhail.abakumov@ispras.ru>) id 1iHNds-00084y-PP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:41:17 -0400
Received: from mail.ispras.ru (localhost [127.0.0.1])
 by mail.ispras.ru (Postfix) with ESMTPSA id 1C71F540082;
 Mon,  7 Oct 2019 10:41:13 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Oct 2019 10:41:13 +0300
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
To: Qemu Devel <qemu-devel@nongnu.org>
Subject: [PATCH] target/mips: add gdb xml files
Message-ID: <caedac8d3f9f15f3245011b7d6b3f7bf@ispras.ru>
X-Sender: mikhail.abakumov@ispras.ru
User-Agent: Roundcube Webmail/1.1.2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, alex.bennee@linaro.org,
 amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 From: Mikhail Abakumov <mikhail.abakumov@ispras>

This patch add xml files with gdb registers for mips.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras>
---
  configure               |  3 ++
  gdb-xml/mips-core.xml   | 84 +++++++++++++++++++++++++++++++++++++++++
  gdb-xml/mips64-core.xml | 84 +++++++++++++++++++++++++++++++++++++++++
  target/mips/cpu.c       | 11 ++++++
  4 files changed, 182 insertions(+)
  create mode 100644 gdb-xml/mips-core.xml
  create mode 100644 gdb-xml/mips64-core.xml

diff --git a/configure b/configure
index 8f8446f52b..5bb2c62194 100755
--- a/configure
+++ b/configure
@@ -7466,12 +7466,14 @@ case "$target_name" in
    mips|mipsel)
      mttcg="yes"
      TARGET_ARCH=mips
+    gdb_xml_files="mips-core.xml"
      echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
    ;;
    mipsn32|mipsn32el)
      mttcg="yes"
      TARGET_ARCH=mips64
      TARGET_BASE_ARCH=mips
+    gdb_xml_files="mips64-core.xml"
      echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
      echo "TARGET_ABI32=y" >> $config_target_mak
    ;;
@@ -7479,6 +7481,7 @@ case "$target_name" in
      mttcg="yes"
      TARGET_ARCH=mips64
      TARGET_BASE_ARCH=mips
+    gdb_xml_files="mips64-core.xml"
      echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
    ;;
    moxie)
diff --git a/gdb-xml/mips-core.xml b/gdb-xml/mips-core.xml
new file mode 100644
index 0000000000..a46b2993eb
--- /dev/null
+++ b/gdb-xml/mips-core.xml
@@ -0,0 +1,84 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without 
modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.mips">
+  <reg name="zero" bitsize="32"/>
+  <reg name="at" bitsize="32"/>
+  <reg name="v0" bitsize="32"/>
+  <reg name="v1" bitsize="32"/>
+  <reg name="a0" bitsize="32"/>
+  <reg name="a1" bitsize="32"/>
+  <reg name="a2" bitsize="32"/>
+  <reg name="a3" bitsize="32"/>
+  <reg name="t0" bitsize="32"/>
+  <reg name="t1" bitsize="32"/>
+  <reg name="t2" bitsize="32"/>
+  <reg name="t3" bitsize="32"/>
+  <reg name="t4" bitsize="32"/>
+  <reg name="t5" bitsize="32"/>
+  <reg name="t6" bitsize="32"/>
+  <reg name="t7" bitsize="32"/>
+  <reg name="s0" bitsize="32"/>
+  <reg name="s1" bitsize="32"/>
+  <reg name="s2" bitsize="32"/>
+  <reg name="s3" bitsize="32"/>
+  <reg name="s4" bitsize="32"/>
+  <reg name="s5" bitsize="32"/>
+  <reg name="s6" bitsize="32"/>
+  <reg name="s7" bitsize="32"/>
+  <reg name="t8" bitsize="32"/>
+  <reg name="t9" bitsize="32"/>
+  <reg name="k0" bitsize="32"/>
+  <reg name="k1" bitsize="32"/>
+  <reg name="gp" bitsize="32"/>
+  <reg name="sp" bitsize="32"/>
+  <reg name="s8" bitsize="32"/>
+  <reg name="ra" bitsize="32"/>
+  <reg name="sr" bitsize="32"/>
+  <reg name="lo" bitsize="32"/>
+  <reg name="hi" bitsize="32"/>
+  <reg name="bad" bitsize="32"/>
+  <reg name="cause" bitsize="32"/>
+  <reg name="pc" bitsize="32"/>
+
+  <reg name="f0" bitsize="32" regnum="38"/>
+  <reg name="f1" bitsize="32"/>
+  <reg name="f2" bitsize="32"/>
+  <reg name="f3" bitsize="32"/>
+  <reg name="f4" bitsize="32"/>
+  <reg name="f5" bitsize="32"/>
+  <reg name="f6" bitsize="32"/>
+  <reg name="f7" bitsize="32"/>
+  <reg name="f8" bitsize="32"/>
+  <reg name="f9" bitsize="32"/>
+  <reg name="f10" bitsize="32"/>
+  <reg name="f11" bitsize="32"/>
+  <reg name="f12" bitsize="32"/>
+  <reg name="f13" bitsize="32"/>
+  <reg name="f14" bitsize="32"/>
+  <reg name="f15" bitsize="32"/>
+  <reg name="f16" bitsize="32"/>
+  <reg name="f17" bitsize="32"/>
+  <reg name="f18" bitsize="32"/>
+  <reg name="f19" bitsize="32"/>
+  <reg name="f20" bitsize="32"/>
+  <reg name="f21" bitsize="32"/>
+  <reg name="f22" bitsize="32"/>
+  <reg name="f23" bitsize="32"/>
+  <reg name="f24" bitsize="32"/>
+  <reg name="f25" bitsize="32"/>
+  <reg name="f26" bitsize="32"/>
+  <reg name="f27" bitsize="32"/>
+  <reg name="f28" bitsize="32"/>
+  <reg name="f29" bitsize="32"/>
+  <reg name="f30" bitsize="32"/>
+  <reg name="f31" bitsize="32"/>
+  <reg name="fsr" bitsize="32" group="float"/>
+  <reg name="fir" bitsize="32" group="float"/>
+  <reg name="fp" bitsize="32" group="float"/>
+</feature>
diff --git a/gdb-xml/mips64-core.xml b/gdb-xml/mips64-core.xml
new file mode 100644
index 0000000000..cc1a15ad56
--- /dev/null
+++ b/gdb-xml/mips64-core.xml
@@ -0,0 +1,84 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without 
modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.mips64">
+  <reg name="zero" bitsize="64"/>
+  <reg name="at" bitsize="64"/>
+  <reg name="v0" bitsize="64"/>
+  <reg name="v1" bitsize="64"/>
+  <reg name="a0" bitsize="64"/>
+  <reg name="a1" bitsize="64"/>
+  <reg name="a2" bitsize="64"/>
+  <reg name="a3" bitsize="64"/>
+  <reg name="t0" bitsize="64"/>
+  <reg name="t1" bitsize="64"/>
+  <reg name="t2" bitsize="64"/>
+  <reg name="t3" bitsize="64"/>
+  <reg name="t4" bitsize="64"/>
+  <reg name="t5" bitsize="64"/>
+  <reg name="t6" bitsize="64"/>
+  <reg name="t7" bitsize="64"/>
+  <reg name="s0" bitsize="64"/>
+  <reg name="s1" bitsize="64"/>
+  <reg name="s2" bitsize="64"/>
+  <reg name="s3" bitsize="64"/>
+  <reg name="s4" bitsize="64"/>
+  <reg name="s5" bitsize="64"/>
+  <reg name="s6" bitsize="64"/>
+  <reg name="s7" bitsize="64"/>
+  <reg name="t8" bitsize="64"/>
+  <reg name="t9" bitsize="64"/>
+  <reg name="k0" bitsize="64"/>
+  <reg name="k1" bitsize="64"/>
+  <reg name="gp" bitsize="64"/>
+  <reg name="sp" bitsize="64"/>
+  <reg name="s8" bitsize="64"/>
+  <reg name="ra" bitsize="64"/>
+  <reg name="sr" bitsize="64"/>
+  <reg name="lo" bitsize="64"/>
+  <reg name="hi" bitsize="64"/>
+  <reg name="bad" bitsize="64"/>
+  <reg name="cause" bitsize="64"/>
+  <reg name="pc" bitsize="64"/>
+
+  <reg name="f0" bitsize="64" regnum="38"/>
+  <reg name="f1" bitsize="64"/>
+  <reg name="f2" bitsize="64"/>
+  <reg name="f3" bitsize="64"/>
+  <reg name="f4" bitsize="64"/>
+  <reg name="f5" bitsize="64"/>
+  <reg name="f6" bitsize="64"/>
+  <reg name="f7" bitsize="64"/>
+  <reg name="f8" bitsize="64"/>
+  <reg name="f9" bitsize="64"/>
+  <reg name="f10" bitsize="64"/>
+  <reg name="f11" bitsize="64"/>
+  <reg name="f12" bitsize="64"/>
+  <reg name="f13" bitsize="64"/>
+  <reg name="f14" bitsize="64"/>
+  <reg name="f15" bitsize="64"/>
+  <reg name="f16" bitsize="64"/>
+  <reg name="f17" bitsize="64"/>
+  <reg name="f18" bitsize="64"/>
+  <reg name="f19" bitsize="64"/>
+  <reg name="f20" bitsize="64"/>
+  <reg name="f21" bitsize="64"/>
+  <reg name="f22" bitsize="64"/>
+  <reg name="f23" bitsize="64"/>
+  <reg name="f24" bitsize="64"/>
+  <reg name="f25" bitsize="64"/>
+  <reg name="f26" bitsize="64"/>
+  <reg name="f27" bitsize="64"/>
+  <reg name="f28" bitsize="64"/>
+  <reg name="f29" bitsize="64"/>
+  <reg name="f30" bitsize="64"/>
+  <reg name="f31" bitsize="64"/>
+  <reg name="fsr" bitsize="64" group="float"/>
+  <reg name="fir" bitsize="64" group="float"/>
+  <reg name="fp" bitsize="64" group="float"/>
+</feature>
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index bbcf7ca463..014f1db59e 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -181,6 +181,11 @@ static ObjectClass *mips_cpu_class_by_name(const 
char *cpu_model)
      return oc;
  }

+static gchar *mips_gdb_arch_name(CPUState *cs)
+{
+    return g_strdup("mips");
+}
+
  static void mips_cpu_class_init(ObjectClass *c, void *data)
  {
      MIPSCPUClass *mcc = MIPS_CPU_CLASS(c);
@@ -213,6 +218,12 @@ static void mips_cpu_class_init(ObjectClass *c, 
void *data)
      cc->tlb_fill = mips_cpu_tlb_fill;
  #endif

+    cc->gdb_arch_name = mips_gdb_arch_name;
+#ifdef TARGET_MIPS64
+    cc->gdb_core_xml_file = "mips64-core.xml";
+#else
+    cc->gdb_core_xml_file = "mips-core.xml";
+#endif
      cc->gdb_num_core_regs = 73;
      cc->gdb_stop_before_watchpoint = true;
  }
-- 
2.17.1

