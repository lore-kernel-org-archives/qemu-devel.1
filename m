Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D42FC35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7065420715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7065420715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izszJ-0003FW-I0
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvY-0005q6-9m
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvW-000189-JN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:28 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53080 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvW-00017l-7W
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 966B11A209B;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 3EBB11A20AF;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 05/32] target/avr: CPU class: Add migration support
Date: Fri,  7 Feb 2020 02:57:33 +0100
Message-Id: <1581040680-308-6-git-send-email-aleksandar.markovic@rt-rk.com>
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

Add migration-related functions of AVR CPU class object.

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
 target/avr/cpu.h     |   2 +
 target/avr/cpu.c     |   1 +
 target/avr/machine.c | 121 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS          |   1 +
 4 files changed, 125 insertions(+)
 create mode 100644 target/avr/machine.c

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index ac14e64..d3003f8 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -118,6 +118,8 @@ typedef struct AVRCPU {
     CPUAVRState env;
 } AVRCPU;
=20
+extern const struct VMStateDescription vms_avr_cpu;
+
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 08a538c..19e729a 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -206,6 +206,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void =
*data)
     cc->memory_rw_debug =3D avr_cpu_memory_rw_debug;
     cc->get_phys_page_debug =3D avr_cpu_get_phys_page_debug;
     cc->tlb_fill =3D avr_cpu_tlb_fill;
+    cc->vmsd =3D &vms_avr_cpu;
     cc->disas_set_info =3D avr_cpu_disas_set_info;
     cc->tcg_initialize =3D avr_cpu_tcg_init;
     cc->synchronize_from_tb =3D avr_cpu_synchronize_from_tb;
diff --git a/target/avr/machine.c b/target/avr/machine.c
new file mode 100644
index 0000000..ba44bd0
--- /dev/null
+++ b/target/avr/machine.c
@@ -0,0 +1,121 @@
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
+#include "migration/cpu.h"
+
+static int get_sreg(QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field)
+{
+    CPUAVRState *env =3D opaque;
+    uint8_t sreg;
+
+    sreg =3D qemu_get_byte(f);
+    cpu_set_sreg(env, sreg);
+    return 0;
+}
+
+static int put_sreg(
+    QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field, QJSON *vmdesc)
+{
+    CPUAVRState *env =3D opaque;
+    uint8_t sreg =3D cpu_get_sreg(env);
+
+    qemu_put_byte(f, sreg);
+    return 0;
+}
+
+static const VMStateInfo vms_sreg =3D {
+    .name =3D "sreg",
+    .get =3D get_sreg,
+    .put =3D put_sreg,
+};
+
+static int get_segment(
+    QEMUFile *f, void *opaque, size_t size, const VMStateField *field)
+{
+    uint32_t *ramp =3D opaque;
+    uint8_t temp;
+
+    temp =3D qemu_get_byte(f);
+    *ramp =3D ((uint32_t)temp) << 16;
+    return 0;
+}
+
+static int put_segment(
+    QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field, QJSON *vmdesc)
+{
+    uint32_t *ramp =3D opaque;
+    uint8_t temp =3D *ramp >> 16;
+
+    qemu_put_byte(f, temp);
+    return 0;
+}
+
+static const VMStateInfo vms_rampD =3D {
+    .name =3D "rampD",
+    .get =3D get_segment,
+    .put =3D put_segment,
+};
+static const VMStateInfo vms_rampX =3D {
+    .name =3D "rampX",
+    .get =3D get_segment,
+    .put =3D put_segment,
+};
+static const VMStateInfo vms_rampY =3D {
+    .name =3D "rampY",
+    .get =3D get_segment,
+    .put =3D put_segment,
+};
+static const VMStateInfo vms_rampZ =3D {
+    .name =3D "rampZ",
+    .get =3D get_segment,
+    .put =3D put_segment,
+};
+static const VMStateInfo vms_eind =3D {
+    .name =3D "eind",
+    .get =3D get_segment,
+    .put =3D put_segment,
+};
+
+const VMStateDescription vms_avr_cpu =3D {
+    .name =3D "cpu",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(env.pc_w, AVRCPU),
+        VMSTATE_UINT32(env.sp, AVRCPU),
+        VMSTATE_UINT32(env.skip, AVRCPU),
+
+        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NUMBER_OF_CPU_REGISTERS),
+
+        VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAVRState),
+        VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD, uint32_t),
+        VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX, uint32_t),
+        VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY, uint32_t),
+        VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ, uint32_t),
+        VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, uint32_t),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3767a92..e94c4c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -172,6 +172,7 @@ F: target/avr/cpu-qom.h
 F: target/avr/cpu.h
 F: target/avr/cpu.c
 F: target/avr/helper.c
+F: target/avr/machine.c
=20
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
--=20
2.7.4


