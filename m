Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55772C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC0D206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC0D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjzo-0002VB-IB
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjf4-0007Qs-K1
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjet-0004Cy-Gj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:26 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:54391)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjes-00049x-UM
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:15 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id 0B1A686E87;
 Fri, 27 Sep 2019 15:23:14 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 8A018240085;
 Fri, 27 Sep 2019 15:23:13 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH v25 15/22] hw/timer: RX62N internal timer modules
Date: Fri, 27 Sep 2019 15:22:55 +0900
Message-Id: <20190927062302.110144-16-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927062302.110144-1-ysato@users.sourceforge.jp>
References: <20190927062302.110144-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.13
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
Cc: peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 philmd@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

renesas_tmr: 8bit timer modules.
renesas_cmt: 16bit compare match timer modules.
This part use many renesas's CPU.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033=
ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190607091116.49044-7-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/timer/renesas_cmt.h |  38 +++
 include/hw/timer/renesas_tmr.h |  53 ++++
 hw/timer/renesas_cmt.c         | 278 ++++++++++++++++++++
 hw/timer/renesas_tmr.c         | 458 +++++++++++++++++++++++++++++++++
 hw/timer/Kconfig               |   6 +
 hw/timer/Makefile.objs         |   3 +
 6 files changed, 836 insertions(+)
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c

diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cm=
t.h
new file mode 100644
index 0000000000..acd25c6e0b
--- /dev/null
+++ b/include/hw/timer/renesas_cmt.h
@@ -0,0 +1,38 @@
+/*
+ * Renesas Compare-match timer Object
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#ifndef HW_RENESAS_CMT_H
+#define HW_RENESAS_CMT_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_CMT "renesas-cmt"
+#define RCMT(obj) OBJECT_CHECK(RCMTState, (obj), TYPE_RENESAS_CMT)
+
+enum {
+    CMT_CH =3D 2,
+    CMT_NR_IRQ =3D 1 * CMT_CH,
+};
+
+typedef struct RCMTState {
+    SysBusDevice parent_obj;
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    uint16_t cmstr;
+    uint16_t cmcr[CMT_CH];
+    uint16_t cmcnt[CMT_CH];
+    uint16_t cmcor[CMT_CH];
+    int64_t tick[CMT_CH];
+    qemu_irq cmi[CMT_CH];
+    QEMUTimer *timer[CMT_CH];
+} RCMTState;
+
+#endif
diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tm=
r.h
new file mode 100644
index 0000000000..5787004c74
--- /dev/null
+++ b/include/hw/timer/renesas_tmr.h
@@ -0,0 +1,53 @@
+/*
+ * Renesas 8bit timer Object
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#ifndef HW_RENESAS_TMR_H
+#define HW_RENESAS_TMR_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_TMR "renesas-tmr"
+#define RTMR(obj) OBJECT_CHECK(RTMRState, (obj), TYPE_RENESAS_TMR)
+
+enum timer_event {
+    cmia =3D 0,
+    cmib =3D 1,
+    ovi =3D 2,
+    none =3D 3,
+    TMR_NR_EVENTS =3D 4
+};
+
+enum {
+    TMR_CH =3D 2,
+    TMR_NR_IRQ =3D 3 * TMR_CH,
+};
+
+typedef struct RTMRState {
+    SysBusDevice parent_obj;
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    uint8_t tcnt[TMR_CH];
+    uint8_t tcora[TMR_CH];
+    uint8_t tcorb[TMR_CH];
+    uint8_t tcr[TMR_CH];
+    uint8_t tccr[TMR_CH];
+    uint8_t tcor[TMR_CH];
+    uint8_t tcsr[TMR_CH];
+    int64_t tick;
+    int64_t div_round[TMR_CH];
+    enum timer_event next[TMR_CH];
+    qemu_irq cmia[TMR_CH];
+    qemu_irq cmib[TMR_CH];
+    qemu_irq ovi[TMR_CH];
+    QEMUTimer *timer[TMR_CH];
+} RTMRState;
+
+#endif
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
new file mode 100644
index 0000000000..5d57c447b8
--- /dev/null
+++ b/hw/timer/renesas_cmt.c
@@ -0,0 +1,278 @@
+/*
+ * Renesas 16bit Compare-match timer
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ * (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu/timer.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
+#include "hw/timer/renesas_cmt.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+/*
+ *  +0 CMSTR - common control
+ *  +2 CMCR  - ch0
+ *  +4 CMCNT - ch0
+ *  +6 CMCOR - ch0
+ *  +8 CMCR  - ch1
+ * +10 CMCNT - ch1
+ * +12 CMCOR - ch1
+ * If we think that the address of CH 0 has an offset of +2,
+ * we can treat it with the same address as CH 1, so define it like that=
.
+ */
+REG16(CMSTR, 0)
+  FIELD(CMSTR, STR0, 0, 1)
+  FIELD(CMSTR, STR1, 1, 1)
+  FIELD(CMSTR, STR,  0, 2)
+/* This addeess is channel offset */
+REG16(CMCR, 0)
+  FIELD(CMCR, CKS, 0, 2)
+  FIELD(CMCR, CMIE, 6, 1)
+REG16(CMCNT, 2)
+REG16(CMCOR, 4)
+
+static void update_events(RCMTState *cmt, int ch)
+{
+    int64_t next_time;
+
+    if ((cmt->cmstr & (1 << ch)) =3D=3D 0) {
+        /* count disable, so not happened next event. */
+        return ;
+    }
+    next_time =3D cmt->cmcor[ch] - cmt->cmcnt[ch];
+    next_time *=3D NANOSECONDS_PER_SECOND;
+    next_time /=3D cmt->input_freq;
+    /*
+     * CKS -> div rate
+     *  0 -> 8 (1 << 3)
+     *  1 -> 32 (1 << 5)
+     *  2 -> 128 (1 << 7)
+     *  3 -> 512 (1 << 9)
+     */
+    next_time *=3D 1 << (3 + FIELD_EX16(cmt->cmcr[ch], CMCR, CKS) * 2);
+    next_time +=3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    timer_mod(cmt->timer[ch], next_time);
+}
+
+static int64_t read_cmcnt(RCMTState *cmt, int ch)
+{
+    int64_t delta, now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (cmt->cmstr & (1 << ch)) {
+        delta =3D (now - cmt->tick[ch]);
+        delta /=3D NANOSECONDS_PER_SECOND;
+        delta /=3D cmt->input_freq;
+        delta /=3D 1 << (3 + FIELD_EX16(cmt->cmcr[ch], CMCR, CKS) * 2);
+        cmt->tick[ch] =3D now;
+        return cmt->cmcnt[ch] + delta;
+    } else {
+        return cmt->cmcnt[ch];
+    }
+}
+
+static uint64_t cmt_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset =3D addr & 0x0f;
+    RCMTState *cmt =3D opaque;
+    int ch =3D offset / 0x08;
+    uint64_t ret;
+
+    if (offset =3D=3D A_CMSTR) {
+        ret =3D 0;
+        ret =3D FIELD_DP16(ret, CMSTR, STR,
+                         FIELD_EX16(cmt->cmstr, CMSTR, STR));
+        return ret;
+    } else {
+        offset &=3D 0x07;
+        if (ch =3D=3D 0) {
+            offset -=3D 0x02;
+        }
+        switch (offset) {
+        case A_CMCR:
+            ret =3D 0;
+            ret =3D FIELD_DP16(ret, CMCR, CKS,
+                             FIELD_EX16(cmt->cmstr, CMCR, CKS));
+            ret =3D FIELD_DP16(ret, CMCR, CMIE,
+                             FIELD_EX16(cmt->cmstr, CMCR, CMIE));
+            return ret;
+        case A_CMCNT:
+            return read_cmcnt(cmt, ch);
+        case A_CMCOR:
+            return cmt->cmcor[ch];
+        }
+    }
+    qemu_log_mask(LOG_UNIMP, "renesas_cmt: Register 0x%"
+                  HWADDR_PRIX " not implemented\n", offset);
+    return UINT64_MAX;
+}
+
+static void start_stop(RCMTState *cmt, int ch, int st)
+{
+    if (st) {
+        update_events(cmt, ch);
+    } else {
+        timer_del(cmt->timer[ch]);
+    }
+}
+
+static void cmt_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
+{
+    hwaddr offset =3D addr & 0x0f;
+    RCMTState *cmt =3D opaque;
+    int ch =3D offset / 0x08;
+
+    if (offset =3D=3D A_CMSTR) {
+        cmt->cmstr =3D FIELD_EX16(val, CMSTR, STR);
+        start_stop(cmt, 0, FIELD_EX16(cmt->cmstr, CMSTR, STR0));
+        start_stop(cmt, 1, FIELD_EX16(cmt->cmstr, CMSTR, STR1));
+    } else {
+        offset &=3D 0x07;
+        if (ch =3D=3D 0) {
+            offset -=3D 0x02;
+        }
+        switch (offset) {
+        case A_CMCR:
+            cmt->cmcr[ch] =3D FIELD_DP16(cmt->cmcr[ch], CMCR, CKS,
+                                       FIELD_EX16(val, CMCR, CKS));
+            cmt->cmcr[ch] =3D FIELD_DP16(cmt->cmcr[ch], CMCR, CMIE,
+                                       FIELD_EX16(val, CMCR, CMIE));
+            break;
+        case 2:
+            cmt->cmcnt[ch] =3D val;
+            break;
+        case 4:
+            cmt->cmcor[ch] =3D val;
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP, "renesas_cmt: Register -0x%" HWADDR=
_PRIX
+                          " not implemented\n", offset);
+            return;
+        }
+        if (FIELD_EX16(cmt->cmstr, CMSTR, STR) & (1 << ch)) {
+            update_events(cmt, ch);
+        }
+    }
+}
+
+static const MemoryRegionOps cmt_ops =3D {
+    .write =3D cmt_write,
+    .read  =3D cmt_read,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 2,
+        .max_access_size =3D 2,
+    },
+};
+
+static void timer_events(RCMTState *cmt, int ch)
+{
+    cmt->cmcnt[ch] =3D 0;
+    cmt->tick[ch] =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    update_events(cmt, ch);
+    if (FIELD_EX16(cmt->cmcr[ch], CMCR, CMIE)) {
+        qemu_irq_pulse(cmt->cmi[ch]);
+    }
+}
+
+static void timer_event0(void *opaque)
+{
+    RCMTState *cmt =3D opaque;
+
+    timer_events(cmt, 0);
+}
+
+static void timer_event1(void *opaque)
+{
+    RCMTState *cmt =3D opaque;
+
+    timer_events(cmt, 1);
+}
+
+static void rcmt_reset(DeviceState *dev)
+{
+    RCMTState *cmt =3D RCMT(dev);
+    cmt->cmstr =3D 0;
+    cmt->cmcr[0] =3D cmt->cmcr[1] =3D 0;
+    cmt->cmcnt[0] =3D cmt->cmcnt[1] =3D 0;
+    cmt->cmcor[0] =3D cmt->cmcor[1] =3D 0xffff;
+}
+
+static void rcmt_init(Object *obj)
+{
+    SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
+    RCMTState *cmt =3D RCMT(obj);
+    int i;
+
+    memory_region_init_io(&cmt->memory, OBJECT(cmt), &cmt_ops,
+                          cmt, "renesas-cmt", 0x10);
+    sysbus_init_mmio(d, &cmt->memory);
+
+    for (i =3D 0; i < ARRAY_SIZE(cmt->cmi); i++) {
+        sysbus_init_irq(d, &cmt->cmi[i]);
+    }
+    cmt->timer[0] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event0, cmt=
);
+    cmt->timer[1] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event1, cmt=
);
+}
+
+static const VMStateDescription vmstate_rcmt =3D {
+    .name =3D "rx-cmt",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rcmt_properties[] =3D {
+    DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rcmt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props =3D rcmt_properties;
+    dc->vmsd =3D &vmstate_rcmt;
+    dc->reset =3D rcmt_reset;
+}
+
+static const TypeInfo rcmt_info =3D {
+    .name       =3D TYPE_RENESAS_CMT,
+    .parent     =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RCMTState),
+    .instance_init =3D rcmt_init,
+    .class_init =3D rcmt_class_init,
+};
+
+static void rcmt_register_types(void)
+{
+    type_register_static(&rcmt_info);
+}
+
+type_init(rcmt_register_types)
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
new file mode 100644
index 0000000000..eebdd0cb1f
--- /dev/null
+++ b/hw/timer/renesas_tmr.c
@@ -0,0 +1,458 @@
+/*
+ * Renesas 8bit timer
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ * (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
+#include "hw/timer/renesas_tmr.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+REG8(TCR, 0)
+  FIELD(TCR, CCLR, 3, 2)
+  FIELD(TCR, OVIE, 5, 1)
+  FIELD(TCR, CMIEA, 6, 1)
+  FIELD(TCR, CMIEB, 7, 1)
+REG8(TCSR, 2)
+  FIELD(TCSR, OSA, 0, 2)
+  FIELD(TCSR, OSB, 2, 2)
+  FIELD(TCSR, ADTE, 4, 2)
+REG8(TCORA, 4)
+REG8(TCORB, 6)
+REG8(TCNT, 8)
+REG8(TCCR, 10)
+  FIELD(TCCR, CKS, 0, 3)
+  FIELD(TCCR, CSS, 3, 2)
+  FIELD(TCCR, TMRIS, 7, 1)
+
+#define INTERNAL  0x01
+#define CASCADING 0x03
+#define CCLR_A    0x01
+#define CCLR_B    0x02
+
+static const int clkdiv[] =3D {0, 1, 2, 8, 32, 64, 1024, 8192};
+
+#define concat_reg(reg) ((reg[0] << 8) | reg[1])
+static void update_events(RTMRState *tmr, int ch)
+{
+    uint16_t diff[TMR_NR_EVENTS], min;
+    int64_t next_time;
+    int i, event;
+
+    if (tmr->tccr[ch] =3D=3D 0) {
+        return ;
+    }
+    if (FIELD_EX8(tmr->tccr[ch], TCCR, CSS) =3D=3D 0) {
+        /* external clock mode */
+        /* event not happened */
+        return ;
+    }
+    if (FIELD_EX8(tmr->tccr[0], TCCR, CSS) =3D=3D CASCADING) {
+        /* cascading mode */
+        if (ch =3D=3D 1) {
+            tmr->next[ch] =3D none;
+            return ;
+        }
+        diff[cmia] =3D concat_reg(tmr->tcora) - concat_reg(tmr->tcnt);
+        diff[cmib] =3D concat_reg(tmr->tcorb) - concat_reg(tmr->tcnt);
+        diff[ovi] =3D 0x10000 - concat_reg(tmr->tcnt);
+    } else {
+        /* separate mode */
+        diff[cmia] =3D tmr->tcora[ch] - tmr->tcnt[ch];
+        diff[cmib] =3D tmr->tcorb[ch] - tmr->tcnt[ch];
+        diff[ovi] =3D 0x100 - tmr->tcnt[ch];
+    }
+    /* Search for the most recently occurring event. */
+    for (event =3D 0, min =3D diff[0], i =3D 1; i < none; i++) {
+        if (min > diff[i]) {
+            event =3D i;
+            min =3D diff[i];
+        }
+    }
+    tmr->next[ch] =3D event;
+    next_time =3D diff[event];
+    next_time *=3D clkdiv[FIELD_EX8(tmr->tccr[ch], TCCR, CKS)];
+    next_time *=3D NANOSECONDS_PER_SECOND;
+    next_time /=3D tmr->input_freq;
+    next_time +=3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    timer_mod(tmr->timer[ch], next_time);
+}
+
+
+static inline int elapsed_time(RTMRState *tmr, int ch, int64_t delta)
+{
+    int divrate =3D clkdiv[FIELD_EX8(tmr->tccr[ch], TCCR, CKS)];
+    int et;
+
+    tmr->div_round[ch] +=3D delta;
+    if (divrate > 0) {
+        et =3D tmr->div_round[ch] / divrate;
+        tmr->div_round[ch] %=3D divrate;
+    } else {
+        /* disble clock. so no update */
+        et =3D 0;
+    }
+    return et;
+}
+static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
+{
+    int64_t delta, now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int elapsed, ovf =3D 0;
+    uint16_t tcnt[2];
+    uint32_t ret;
+
+    delta =3D (now - tmr->tick) * NANOSECONDS_PER_SECOND / tmr->input_fr=
eq;
+    if (delta > 0) {
+        tmr->tick =3D now;
+
+        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) =3D=3D INTERNAL) {
+            /* timer1 count update */
+            elapsed =3D elapsed_time(tmr, 1, delta);
+            if (elapsed >=3D 0x100) {
+                ovf =3D elapsed >> 8;
+            }
+            tcnt[1] =3D tmr->tcnt[1] + (elapsed & 0xff);
+        }
+        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
+        case INTERNAL:
+            elapsed =3D elapsed_time(tmr, 0, delta);
+            tcnt[0] =3D tmr->tcnt[0] + elapsed;
+            break;
+        case CASCADING:
+            if (ovf > 0) {
+                tcnt[0] =3D tmr->tcnt[0] + ovf;
+            }
+            break;
+        }
+    } else {
+        tcnt[0] =3D tmr->tcnt[0];
+        tcnt[1] =3D tmr->tcnt[1];
+    }
+    if (size =3D=3D 1) {
+        return tcnt[ch];
+    } else {
+        ret =3D 0;
+        ret =3D deposit32(ret, 0, 8, tcnt[1]);
+        ret =3D deposit32(ret, 8, 8, tcnt[0]);
+        return ret;
+    }
+}
+
+static inline uint8_t read_tccr(uint8_t r)
+{
+    uint8_t tccr =3D 0;
+    tccr =3D FIELD_DP8(tccr, TCCR, TMRIS,
+                     FIELD_EX8(r, TCCR, TMRIS));
+    tccr =3D FIELD_DP8(tccr, TCCR, CSS,
+                     FIELD_EX8(r, TCCR, CSS));
+    tccr =3D FIELD_DP8(tccr, TCCR, CKS,
+                     FIELD_EX8(r, TCCR, CKS));
+    return tccr;
+}
+
+static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RTMRState *tmr =3D opaque;
+    int ch =3D addr & 1;
+    uint64_t ret;
+
+    if (size =3D=3D 2 && (ch !=3D 0 || addr =3D=3D A_TCR || addr =3D=3D =
A_TCSR)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "renesas_tmr: Invalid read size 0=
x%"
+                      HWADDR_PRIX "\n", addr);
+        return UINT64_MAX;
+    }
+    switch (addr & 0x0e) {
+    case A_TCR:
+        ret =3D 0;
+        ret =3D FIELD_DP8(ret, TCR, CCLR,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CCLR));
+        ret =3D FIELD_DP8(ret, TCR, OVIE,
+                        FIELD_EX8(tmr->tcr[ch], TCR, OVIE));
+        ret =3D FIELD_DP8(ret, TCR, CMIEA,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEA));
+        ret =3D FIELD_DP8(ret, TCR, CMIEB,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEB));
+        return ret;
+    case A_TCSR:
+        ret =3D 0;
+        ret =3D FIELD_DP8(ret, TCSR, OSA,
+                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSA));
+        ret =3D FIELD_DP8(ret, TCSR, OSB,
+                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSB));
+        switch (ch) {
+        case 0:
+            ret =3D FIELD_DP8(ret, TCSR, ADTE,
+                            FIELD_EX8(tmr->tcsr[ch], TCSR, ADTE));
+            break;
+        case 1: /* CH1 ADTE unimplement always 1 */
+            ret =3D FIELD_DP8(ret, TCSR, ADTE, 1);
+            break;
+        }
+        return ret;
+    case A_TCORA:
+        if (size =3D=3D 1) {
+            return tmr->tcora[ch];
+        } else if (ch =3D=3D 0) {
+            return concat_reg(tmr->tcora);
+        }
+    case A_TCORB:
+        if (size =3D=3D 1) {
+            return tmr->tcorb[ch];
+        } else {
+            return concat_reg(tmr->tcorb);
+        }
+    case A_TCNT:
+        return read_tcnt(tmr, size, ch);
+    case A_TCCR:
+        if (size =3D=3D 1) {
+            return read_tccr(tmr->tccr[ch]);
+        } else {
+            return read_tccr(tmr->tccr[0]) << 8 | read_tccr(tmr->tccr[1]=
);
+        }
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", addr);
+        break;
+    }
+    return UINT64_MAX;
+}
+
+#define COUNT_WRITE(reg, val)                   \
+    do {                                        \
+        if (size =3D=3D 1) {                        \
+            tmr->reg[ch] =3D val;                 \
+            update_events(tmr, ch);             \
+        } else {                                \
+            tmr->reg[0] =3D extract32(val, 8, 8); \
+            tmr->reg[1] =3D extract32(val, 0, 8); \
+            update_events(tmr, 0);              \
+            update_events(tmr, 1);              \
+        }                                       \
+    } while (0)
+
+static void tmr_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
+{
+    RTMRState *tmr =3D opaque;
+    int ch =3D addr & 1;
+
+    if (size =3D=3D 2 && (ch !=3D 0 || addr =3D=3D A_TCR || addr =3D=3D =
A_TCSR)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas_tmr: Invalid write size 0x%" HWADDR_PRIX
+                      "\n", addr);
+        return;
+    }
+    switch (addr & 0x0e) {
+    case A_TCR:
+        tmr->tcr[ch] =3D val;
+        break;
+    case A_TCSR:
+        tmr->tcsr[ch] =3D val;
+        break;
+    case A_TCORA:
+        COUNT_WRITE(tcora, val);
+        break;
+    case A_TCORB:
+        COUNT_WRITE(tcorb, val);
+        break;
+    case A_TCNT:
+        COUNT_WRITE(tcnt, val);
+        break;
+    case A_TCCR:
+        COUNT_WRITE(tccr, val);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps tmr_ops =3D {
+    .write =3D tmr_write,
+    .read  =3D tmr_read,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 2,
+    },
+};
+
+static void timer_events(RTMRState *tmr, int ch);
+
+static uint16_t issue_event(RTMRState *tmr, int ch, int sz,
+                        uint16_t tcnt, uint16_t tcora, uint16_t tcorb)
+{
+    uint16_t ret =3D tcnt;
+
+    switch (tmr->next[ch]) {
+    case none:
+        break;
+    case cmia:
+        if (tcnt >=3D tcora) {
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CCLR) =3D=3D CCLR_A) {
+                ret =3D tcnt - tcora;
+            }
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CMIEA)) {
+                qemu_irq_pulse(tmr->cmia[ch]);
+            }
+            if (sz =3D=3D 8 && ch =3D=3D 0 &&
+                FIELD_EX8(tmr->tccr[1], TCCR, CSS) =3D=3D CASCADING) {
+                tmr->tcnt[1]++;
+                timer_events(tmr, 1);
+            }
+        }
+        break;
+    case cmib:
+        if (tcnt >=3D tcorb) {
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CCLR) =3D=3D CCLR_B) {
+                ret =3D tcnt - tcorb;
+            }
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CMIEB)) {
+                qemu_irq_pulse(tmr->cmib[ch]);
+            }
+        }
+        break;
+    case ovi:
+        if ((tcnt >=3D (1 << sz)) && FIELD_EX8(tmr->tcr[ch], TCR, OVIE))=
 {
+            qemu_irq_pulse(tmr->ovi[ch]);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
+static void timer_events(RTMRState *tmr, int ch)
+{
+    uint16_t tcnt;
+    tmr->tcnt[ch] =3D read_tcnt(tmr, 1, ch);
+    if (FIELD_EX8(tmr->tccr[0], TCCR, CSS) !=3D CASCADING) {
+        tmr->tcnt[ch] =3D issue_event(tmr, ch, 8,
+                                    tmr->tcnt[ch],
+                                    tmr->tcora[ch], tmr->tcorb[ch]) & 0x=
ff;
+    } else {
+        if (ch =3D=3D 1) {
+            return ;
+        }
+        tcnt =3D issue_event(tmr, ch, 16,
+                           concat_reg(tmr->tcnt),
+                           concat_reg(tmr->tcora),
+                           concat_reg(tmr->tcorb));
+        tmr->tcnt[0] =3D (tcnt >> 8) & 0xff;
+        tmr->tcnt[1] =3D tcnt & 0xff;
+    }
+    update_events(tmr, ch);
+}
+
+static void timer_event0(void *opaque)
+{
+    RTMRState *tmr =3D opaque;
+
+    timer_events(tmr, 0);
+}
+
+static void timer_event1(void *opaque)
+{
+    RTMRState *tmr =3D opaque;
+
+    timer_events(tmr, 1);
+}
+
+static void rtmr_reset(DeviceState *dev)
+{
+    RTMRState *tmr =3D RTMR(dev);
+    tmr->tcr[0]   =3D tmr->tcr[1]   =3D 0x00;
+    tmr->tcsr[0]  =3D 0x00;
+    tmr->tcsr[1]  =3D 0x10;
+    tmr->tcnt[0]  =3D tmr->tcnt[1]  =3D 0x00;
+    tmr->tcora[0] =3D tmr->tcora[1] =3D 0xff;
+    tmr->tcorb[0] =3D tmr->tcorb[1] =3D 0xff;
+    tmr->tccr[0]  =3D tmr->tccr[1]  =3D 0x00;
+    tmr->next[0]  =3D tmr->next[1]  =3D none;
+    tmr->tick =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static void rtmr_init(Object *obj)
+{
+    SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
+    RTMRState *tmr =3D RTMR(obj);
+    int i;
+
+    memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
+                          tmr, "renesas-tmr", 0x10);
+    sysbus_init_mmio(d, &tmr->memory);
+
+    for (i =3D 0; i < ARRAY_SIZE(tmr->ovi); i++) {
+        sysbus_init_irq(d, &tmr->cmia[i]);
+        sysbus_init_irq(d, &tmr->cmib[i]);
+        sysbus_init_irq(d, &tmr->ovi[i]);
+    }
+    tmr->timer[0] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event0, tmr=
);
+    tmr->timer[1] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event1, tmr=
);
+}
+
+static const VMStateDescription vmstate_rtmr =3D {
+    .name =3D "rx-tmr",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rtmr_properties[] =3D {
+    DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rtmr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props =3D rtmr_properties;
+    dc->vmsd =3D &vmstate_rtmr;
+    dc->reset =3D rtmr_reset;
+}
+
+static const TypeInfo rtmr_info =3D {
+    .name       =3D TYPE_RENESAS_TMR,
+    .parent     =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RTMRState),
+    .instance_init =3D rtmr_init,
+    .class_init =3D rtmr_class_init,
+};
+
+static void rtmr_register_types(void)
+{
+    type_register_static(&rtmr_info);
+}
+
+type_init(rtmr_register_types)
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index eefc95f35e..4c93874159 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -58,3 +58,9 @@ config CMSDK_APB_TIMER
 config CMSDK_APB_DUALTIMER
     bool
     select PTIMER
+
+config RENESAS_TMR8
+    bool
+
+config RENESAS_CMT
+    bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 123d92c969..706bd1510c 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -40,6 +40,9 @@ obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
=20
 obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
=20
+obj-$(CONFIG_RENESAS_TMR8) +=3D renesas_tmr.o
+obj-$(CONFIG_RENESAS_CMT) +=3D renesas_cmt.o
+
 common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
=20
--=20
2.20.1


