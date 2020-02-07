Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3C3C352A3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C5020715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C5020715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izsxO-0007de-3Y
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvY-0005q4-7I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvW-00018K-K3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:28 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49884 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvW-0000GC-9H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 549CC1A1E43;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 2B8091A1FEE;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 03/32] target/avr: CPU class: Add interrupt handling
 support
Date: Fri,  7 Feb 2020 02:57:31 +0100
Message-Id: <1581040680-308-4-git-send-email-aleksandar.markovic@rt-rk.com>
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

This patch introduces functions avr_cpu_do_interrupt() and
avr_cpu_exec_interrupt() that are part of AVR CPU class object.

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
 target/avr/cpu.c    |  2 ++
 target/avr/helper.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS         |  1 +
 3 files changed, 92 insertions(+)
 create mode 100644 target/avr/helper.c

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 442391c..10cb83c 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -199,6 +199,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void =
*data)
     cc->class_by_name =3D avr_cpu_class_by_name;
=20
     cc->has_work =3D avr_cpu_has_work;
+    cc->do_interrupt =3D avr_cpu_do_interrupt;
+    cc->cpu_exec_interrupt =3D avr_cpu_exec_interrupt;
     cc->dump_state =3D avr_cpu_dump_state;
     cc->set_pc =3D avr_cpu_set_pc;
     cc->disas_set_info =3D avr_cpu_disas_set_info;
diff --git a/target/avr/helper.c b/target/avr/helper.c
new file mode 100644
index 0000000..731a9ee
--- /dev/null
+++ b/target/avr/helper.c
@@ -0,0 +1,89 @@
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
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+
+bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    bool ret =3D false;
+    CPUClass *cc =3D CPU_GET_CLASS(cs);
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+
+    if (interrupt_request & CPU_INTERRUPT_RESET) {
+        if (cpu_interrupts_enabled(env)) {
+            cs->exception_index =3D EXCP_RESET;
+            cc->do_interrupt(cs);
+
+            cs->interrupt_request &=3D ~CPU_INTERRUPT_RESET;
+
+            ret =3D true;
+        }
+    }
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_interrupts_enabled(env) && env->intsrc !=3D 0) {
+            int index =3D ctz32(env->intsrc);
+            cs->exception_index =3D EXCP_INT(index);
+            cc->do_interrupt(cs);
+
+            env->intsrc &=3D env->intsrc - 1; /* clear the interrupt */
+            cs->interrupt_request &=3D ~CPU_INTERRUPT_HARD;
+
+            ret =3D true;
+        }
+    }
+    return ret;
+}
+
+void avr_cpu_do_interrupt(CPUState *cs)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+
+    uint32_t ret =3D env->pc_w;
+    int vector =3D 0;
+    int size =3D avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
+    int base =3D 0;
+
+    if (cs->exception_index =3D=3D EXCP_RESET) {
+        vector =3D 0;
+    } else if (env->intsrc !=3D 0) {
+        vector =3D ctz32(env->intsrc) + 1;
+    }
+
+    if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
+        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
+    } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
+    } else {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+    }
+
+    env->pc_w =3D base + vector * size;
+    env->sregI =3D 0; /* clear Global Interrupt Flag */
+
+    cs->exception_index =3D -1;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 79b709d..3767a92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -171,6 +171,7 @@ F: target/avr/cpu-param.h
 F: target/avr/cpu-qom.h
 F: target/avr/cpu.h
 F: target/avr/cpu.c
+F: target/avr/helper.c
=20
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
--=20
2.7.4


