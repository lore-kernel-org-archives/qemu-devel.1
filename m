Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA385C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5402214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5402214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izt1O-0006u7-Ps
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvY-0005q5-7r
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvW-00018F-Jk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:28 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53079 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvW-00017k-7Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8F6101A20FD;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4993F1A2055;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 06/32] target/avr: CPU class: Add GDB support
Date: Fri,  7 Feb 2020 02:57:34 +0100
Message-Id: <1581040680-308-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes GDB hooks for reading from wnd wrtiting to AVR
registers, and xml register definition file as well.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/avr/cpu.h     |  2 ++
 target/avr/cpu.c     |  4 +++
 target/avr/gdbstub.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS          |  2 ++
 gdb-xml/avr-cpu.xml  | 49 ++++++++++++++++++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 gdb-xml/avr-cpu.xml

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index d3003f8..a5213bd 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -123,6 +123,8 @@ extern const struct VMStateDescription vms_avr_cpu;
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 #define cpu_list avr_cpu_list
 #define cpu_signal_handler cpu_avr_signal_handler
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 19e729a..f2632a3 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -210,4 +210,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void =
*data)
     cc->disas_set_info =3D avr_cpu_disas_set_info;
     cc->tcg_initialize =3D avr_cpu_tcg_init;
     cc->synchronize_from_tb =3D avr_cpu_synchronize_from_tb;
+    cc->gdb_read_register =3D avr_cpu_gdb_read_register;
+    cc->gdb_write_register =3D avr_cpu_gdb_write_register;
+    cc->gdb_num_core_regs =3D 35;
+    cc->gdb_core_xml_file =3D "avr-cpu.xml";
 }
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
new file mode 100644
index 0000000..733184c
--- /dev/null
+++ b/target/avr/gdbstub.c
@@ -0,0 +1,84 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "exec/gdbstub.h"
+
+int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        return gdb_get_reg8(mem_buf, env->r[n]);
+    }
+
+    /*  SREG */
+    if (n =3D=3D 32) {
+        uint8_t sreg =3D cpu_get_sreg(env);
+
+        return gdb_get_reg8(mem_buf, sreg);
+    }
+
+    /*  SP */
+    if (n =3D=3D 33) {
+        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
+    }
+
+    /*  PC */
+    if (n =3D=3D 34) {
+        return gdb_get_reg32(mem_buf, env->pc_w * 2);
+    }
+
+    return 0;
+}
+
+int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        env->r[n] =3D *mem_buf;
+        return 1;
+    }
+
+    /*  SREG */
+    if (n =3D=3D 32) {
+        cpu_set_sreg(env, *mem_buf);
+        return 1;
+    }
+
+    /*  SP */
+    if (n =3D=3D 33) {
+        env->sp =3D lduw_p(mem_buf);
+        return 2;
+    }
+
+    /*  PC */
+    if (n =3D=3D 34) {
+        env->pc_w =3D ldl_p(mem_buf) / 2;
+        return 4;
+    }
+
+    return 0;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index e94c4c5..ef7b51f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -167,11 +167,13 @@ AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+F: gdb-xml/avr-cpu.xml
 F: target/avr/cpu-param.h
 F: target/avr/cpu-qom.h
 F: target/avr/cpu.h
 F: target/avr/cpu.c
 F: target/avr/helper.c
+F: target/avr/gdbstub.c
 F: target/avr/machine.c
=20
 CRIS TCG CPUs
diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
new file mode 100644
index 0000000..c4747f5
--- /dev/null
+++ b/gdb-xml/avr-cpu.xml
@@ -0,0 +1,49 @@
+<?xml version=3D"1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification=
,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!-- Register numbers are hard-coded in order to maintain backward
+     compatibility with older versions of tools that didn't use xml
+     register descriptions.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name=3D"org.gnu.gdb.riscv.cpu">
+  <reg name=3D"r0" bitsize=3D"8" type=3D"int" regnum=3D"0"/>
+  <reg name=3D"r1" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r2" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r3" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r4" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r5" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r6" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r7" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r8" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r9" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r10" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r11" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r12" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r13" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r14" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r15" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r16" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r17" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r18" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r19" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r20" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r21" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r22" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r23" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r24" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r25" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r26" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r27" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r28" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r29" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r30" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r31" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"sreg" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"sp" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"pc" bitsize=3D"8" type=3D"int"/>
+</feature>
--=20
2.7.4


