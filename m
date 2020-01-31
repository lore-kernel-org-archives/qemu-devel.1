Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD2BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D03217BA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D03217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJt5-0002Yf-B6
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ixJng-0007XW-Bw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ixJnd-0002x2-0f
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:04:44 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46251 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ixJnc-0001wU-Kh
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:04:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 1ACF31A1E89;
 Fri, 31 Jan 2020 01:03:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id EF52C1A1E0C;
 Fri, 31 Jan 2020 01:03:36 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc4 03/29] target/avr: Add migration support
Date: Fri, 31 Jan 2020 01:02:47 +0100
Message-Id: <1580428993-4767-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

Add migration functions for AVR cores.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>

Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 target/avr/cpu.c     |   1 +
 target/avr/cpu.h     |   2 +
 target/avr/machine.c | 121 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 124 insertions(+)
 create mode 100644 target/avr/machine.c

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index beda91e..49e32af 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -205,6 +205,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void =
*data)
     cc->set_pc =3D avr_cpu_set_pc;
     cc->memory_rw_debug =3D avr_cpu_memory_rw_debug;
     cc->get_phys_page_debug =3D avr_cpu_get_phys_page_debug;
+    cc->vmsd =3D &vms_avr_cpu;
     cc->disas_set_info =3D avr_cpu_disas_set_info;
     cc->tlb_fill =3D avr_cpu_tlb_fill;
     cc->tcg_initialize =3D avr_cpu_tcg_init;
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 08f4415..2907a37 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -119,6 +119,8 @@ typedef struct AVRCPU {
     CPUAVRState env;
 } AVRCPU;
=20
+extern const struct VMStateDescription vms_avr_cpu;
+
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
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
--=20
2.7.4


