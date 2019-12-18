Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2479FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E323A2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBzDOfj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E323A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYWU-0005cl-Ra
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3h-00076L-8K
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3f-0002dK-Ex
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:05 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3f-0002XT-5M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:03 -0500
Received: by mail-wm1-x344.google.com with SMTP id 20so1484074wmj.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rDif3jIy3NQWrPrWp+OG7Re6McoAeV4H/8rGZ5nE6Ss=;
 b=OBzDOfj9RfWITy9p4YQA6RTKYI6Fxw9CapJ2CCN5wsUyLKZcCVUxf12hjExF6q9E93
 2UtLbVruCIUs+AD03oog+vxuvuXUv0Xz/HlEy2QVS+zdFJyceaoh5A+ZRid4rM1+2Wea
 ZGp7BAMtLV/ibYnuWFcztwUB4gJB2FgAav27jEZYfa0tcb4SuCbW29ySIhF5Adh58xd5
 nYPFVXqrNyBWrtjbZlkLX1wP5u8p2cnhi1aIuQ9ZzTaz7oUd7SdSNOLKQJpeQMVEvKUn
 ASPiGSqAIxlCg1hl1XGg8kDSfVkpJjkj2AVryduF1DQdEuw9vn4WkZDWT1LSIYcBSy0X
 aDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rDif3jIy3NQWrPrWp+OG7Re6McoAeV4H/8rGZ5nE6Ss=;
 b=tMPZpAAOMoPd9UPG7hfbFmowwuytMGXSPZNHy2E+6JAkSTdGJauGJw86LRx4msu6Dv
 26T15Xmx7pqf8WSpZXk8DfizJt+mZuW0sp5tVd5NyWjTPDtcm3mbhts717rdQjoaYHE9
 wYqbT5/haB8uw2GMS+diuwqWvac8MehOmy1kG+lnxSaoMk1t6rWyZy6w4xT6ByphNymI
 1StXH7Y/R58+0WmljxGDruwmcQLgMlrIyj8Y4TMIT0GfRz/yQwdZxVunkzE/ONdzKJsg
 ltt6msfv3R4akdf1iPxEqfR+YAt5fZvsHWL1ot0yfdEChXJHVlTE9ZVqGqcdQARj79jj
 3pMA==
X-Gm-Message-State: APjAAAVPcIoqCniWTGzVy+DPOX7735RCS6qOd3FP9OskRHncyQFhMq9e
 4GIh71rM5+v//e5oJbMcWcc+T+Rb
X-Google-Smtp-Source: APXvYqw0UiYshy3Tu1qaEpr79/rkDbueK2ncAWYeC+eE1BiRIJ55nPdWWAw6bITv8tfJB1Y5a+ZUDQ==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr2799982wme.177.1576670641580; 
 Wed, 18 Dec 2019 04:04:01 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 58/87] hw/i386/pc: Extract the port92 device
Date: Wed, 18 Dec 2019 13:02:24 +0100
Message-Id: <1576670573-48048-59-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This device is only used by the PC machines. The pc.c file is
already big enough, with 2255 lines. By removing 113 lines of
it, we reduced it by 5%. It is now a bit easier to navigate
the file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Makefile.objs |   1 +
 hw/i386/pc.c          | 113 --------------------------------------------
 hw/i386/port92.c      | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/trace-events  |   2 +-
 include/hw/i386/pc.h  |   3 ++
 5 files changed, 131 insertions(+), 114 deletions(-)
 create mode 100644 hw/i386/port92.c

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 1236c3b..8ce1b26 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -13,6 +13,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
+obj-$(CONFIG_PC) += port92.o
 
 obj-y += kvmvapic.o
 obj-$(CONFIG_PC) += acpi-build.o
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e36053f..42014b0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -673,119 +673,6 @@ void pc_cmos_init(PCMachineState *pcms,
     qemu_register_reset(pc_cmos_init_late, &arg);
 }
 
-#define TYPE_PORT92 "port92"
-#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
-
-/* port 92 stuff: could be split off */
-typedef struct Port92State {
-    ISADevice parent_obj;
-
-    MemoryRegion io;
-    uint8_t outport;
-    qemu_irq a20_out;
-} Port92State;
-
-static void port92_write(void *opaque, hwaddr addr, uint64_t val,
-                         unsigned size)
-{
-    Port92State *s = opaque;
-    int oldval = s->outport;
-
-    trace_port92_write(val);
-    s->outport = val;
-    qemu_set_irq(s->a20_out, (val >> 1) & 1);
-    if ((val & 1) && !(oldval & 1)) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
-static uint64_t port92_read(void *opaque, hwaddr addr,
-                            unsigned size)
-{
-    Port92State *s = opaque;
-    uint32_t ret;
-
-    ret = s->outport;
-    trace_port92_read(ret);
-    return ret;
-}
-
-static const VMStateDescription vmstate_port92_isa = {
-    .name = "port92",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(outport, Port92State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void port92_reset(DeviceState *d)
-{
-    Port92State *s = PORT92(d);
-
-    s->outport &= ~1;
-}
-
-static const MemoryRegionOps port92_ops = {
-    .read = port92_read,
-    .write = port92_write,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void port92_initfn(Object *obj)
-{
-    Port92State *s = PORT92(obj);
-
-    memory_region_init_io(&s->io, OBJECT(s), &port92_ops, s, "port92", 1);
-
-    s->outport = 0;
-
-    qdev_init_gpio_out_named(DEVICE(obj), &s->a20_out, PORT92_A20_LINE, 1);
-}
-
-static void port92_realizefn(DeviceState *dev, Error **errp)
-{
-    ISADevice *isadev = ISA_DEVICE(dev);
-    Port92State *s = PORT92(dev);
-
-    isa_register_ioport(isadev, &s->io, 0x92);
-}
-
-static void port92_class_initfn(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = port92_realizefn;
-    dc->reset = port92_reset;
-    dc->vmsd = &vmstate_port92_isa;
-    /*
-     * Reason: unlike ordinary ISA devices, this one needs additional
-     * wiring: its A20 output line needs to be wired up with
-     * qdev_connect_gpio_out_named().
-     */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo port92_info = {
-    .name          = TYPE_PORT92,
-    .parent        = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(Port92State),
-    .instance_init = port92_initfn,
-    .class_init    = port92_class_initfn,
-};
-
-static void port92_register_types(void)
-{
-    type_register_static(&port92_info);
-}
-
-type_init(port92_register_types)
-
 static void handle_a20_line_change(void *opaque, int irq, int level)
 {
     X86CPU *cpu = opaque;
diff --git a/hw/i386/port92.c b/hw/i386/port92.c
new file mode 100644
index 0000000..19866c4
--- /dev/null
+++ b/hw/i386/port92.c
@@ -0,0 +1,126 @@
+/*
+ * QEMU I/O port 0x92 (System Control Port A, to handle Fast Gate A20)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/runstate.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/i386/pc.h"
+#include "trace.h"
+
+#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
+
+typedef struct Port92State {
+    ISADevice parent_obj;
+
+    MemoryRegion io;
+    uint8_t outport;
+    qemu_irq a20_out;
+} Port92State;
+
+static void port92_write(void *opaque, hwaddr addr, uint64_t val,
+                         unsigned size)
+{
+    Port92State *s = opaque;
+    int oldval = s->outport;
+
+    trace_port92_write(val);
+    s->outport = val;
+    qemu_set_irq(s->a20_out, (val >> 1) & 1);
+    if ((val & 1) && !(oldval & 1)) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+static uint64_t port92_read(void *opaque, hwaddr addr,
+                            unsigned size)
+{
+    Port92State *s = opaque;
+    uint32_t ret;
+
+    ret = s->outport;
+    trace_port92_read(ret);
+
+    return ret;
+}
+
+static const VMStateDescription vmstate_port92_isa = {
+    .name = "port92",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(outport, Port92State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void port92_reset(DeviceState *d)
+{
+    Port92State *s = PORT92(d);
+
+    s->outport &= ~1;
+}
+
+static const MemoryRegionOps port92_ops = {
+    .read = port92_read,
+    .write = port92_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void port92_initfn(Object *obj)
+{
+    Port92State *s = PORT92(obj);
+
+    memory_region_init_io(&s->io, OBJECT(s), &port92_ops, s, "port92", 1);
+
+    s->outport = 0;
+
+    qdev_init_gpio_out_named(DEVICE(obj), &s->a20_out, PORT92_A20_LINE, 1);
+}
+
+static void port92_realizefn(DeviceState *dev, Error **errp)
+{
+    ISADevice *isadev = ISA_DEVICE(dev);
+    Port92State *s = PORT92(dev);
+
+    isa_register_ioport(isadev, &s->io, 0x92);
+}
+
+static void port92_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = port92_realizefn;
+    dc->reset = port92_reset;
+    dc->vmsd = &vmstate_port92_isa;
+    /*
+     * Reason: unlike ordinary ISA devices, this one needs additional
+     * wiring: its A20 output line needs to be wired up with
+     * qdev_connect_gpio_out_named().
+     */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo port92_info = {
+    .name          = TYPE_PORT92,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(Port92State),
+    .instance_init = port92_initfn,
+    .class_init    = port92_class_initfn,
+};
+
+static void port92_register_types(void)
+{
+    type_register_static(&port92_info);
+}
+
+type_init(port92_register_types)
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index a9b6437..e48bef2 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -116,6 +116,6 @@ vmport_command(unsigned char command) "command: 0x%02x"
 x86_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
 x86_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
 
-# pc.c
+# port92.c
 port92_read(uint8_t val) "port92: read 0x%02x"
 port92_write(uint8_t val) "port92: write 0x%02x"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 58aaa23..d5ac76d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -196,8 +196,11 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 ISADevice *pc_find_fdc0(void);
 int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
+/* port92.c */
 #define PORT92_A20_LINE "a20"
 
+#define TYPE_PORT92 "port92"
+
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
-- 
1.8.3.1



