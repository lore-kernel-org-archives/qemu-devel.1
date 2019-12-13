Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9CAC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB6B20706
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7+DBJ7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB6B20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnyg-0008MV-NX
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifng5-0001jO-6V
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifng3-0003Q5-R0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifng3-0003P9-MQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576254027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EftjF8HiFSpwXHv8YZWYjoqxeIDtjy2n7wAZHjtMGk=;
 b=A7+DBJ7RSW942P7zwXRg7R/4n94VRlMi/c+EYQ01Y06nQzqCZ/sThWMLJn63sTY5tB0oNo
 lvCGQte90GCw1wP93Gj518KogjhUpFe2GXxwSisgw4ZjsG6i6HiCM/DBO06m8HP2NOeyuW
 P5DKzHrfleAOjeUz2SFgVMT+ONgAO80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-fqun19fLNLSrG9Al94wyOA-1; Fri, 13 Dec 2019 11:20:26 -0500
X-MC-Unique: fqun19fLNLSrG9Al94wyOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89139800D4E;
 Fri, 13 Dec 2019 16:20:24 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E95AD19481;
 Fri, 13 Dec 2019 16:20:12 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/12] hw/i386/pc: Move x86_machine_allocate_cpu_irq() to
 'hw/i386/x86.c'
Date: Fri, 13 Dec 2019 17:17:52 +0100
Message-Id: <20191213161753.8051-12-philmd@redhat.com>
In-Reply-To: <20191213161753.8051-1-philmd@redhat.com>
References: <20191213161753.8051-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep 'pc.c' for PC-machine specific code, and use 'x86.c' for code
used by all the X86-based machines.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/pc.h  |  1 -
 include/hw/i386/x86.h |  2 ++
 hw/i386/pc.c          | 27 ---------------------------
 hw/i386/x86.c         | 30 ++++++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 244dbf2ec0..2ef6e2cfff 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -198,7 +198,6 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *rom_memory,
                     MemoryRegion **ram_memory);
 uint64_t pc_pci_hole64_start(void);
-qemu_irq x86_machine_allocate_cpu_irq(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 4b84917885..4c3dd6f33e 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -95,4 +95,6 @@ void x86_load_linux(X86MachineState *x86ms,
                     bool pvh_enabled,
                     bool linuxboot_dma_enabled);
=20
+qemu_irq x86_machine_allocate_cpu_irq(void);
+
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4defee274f..4c018735b0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -412,28 +412,6 @@ int cpu_get_pic_interrupt(CPUX86State *env)
     return intno;
 }
=20
-static void pic_irq_request(void *opaque, int irq, int level)
-{
-    CPUState *cs =3D first_cpu;
-    X86CPU *cpu =3D X86_CPU(cs);
-
-    trace_x86_pic_interrupt(irq, level);
-    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
-        CPU_FOREACH(cs) {
-            cpu =3D X86_CPU(cs);
-            if (apic_accept_pic_intr(cpu->apic_state)) {
-                apic_deliver_pic_intr(cpu->apic_state, level);
-            }
-        }
-    } else {
-        if (level) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
-    }
-}
-
 /* PC cmos mappings */
=20
 #define REG_EQUIPMENT_BYTE          0x14
@@ -1282,11 +1260,6 @@ uint64_t pc_pci_hole64_start(void)
     return ROUND_UP(hole64_start, 1 * GiB);
 }
=20
-qemu_irq x86_machine_allocate_cpu_irq(void)
-{
-    return qemu_allocate_irq(pic_irq_request, NULL, 0);
-}
-
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
 {
     DeviceState *dev =3D NULL;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 394edc2f72..a6a394ca36 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -34,6 +34,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/replay.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/kvm.h"
=20
 #include "hw/i386/x86.h"
 #include "target/i386/cpu.h"
@@ -41,11 +42,13 @@
 #include "hw/i386/fw_cfg.h"
=20
 #include "hw/acpi/cpu_hotplug.h"
+#include "hw/irq.h"
 #include "hw/nmi.h"
 #include "hw/loader.h"
 #include "multiboot.h"
 #include "elf.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "trace.h"
=20
 #define BIOS_FILENAME "bios.bin"
=20
@@ -206,6 +209,33 @@ static void x86_nmi(NMIState *n, int cpu_index, Erro=
r **errp)
     }
 }
=20
+static void pic_irq_request(void *opaque, int irq, int level)
+{
+    CPUState *cs =3D first_cpu;
+    X86CPU *cpu =3D X86_CPU(cs);
+
+    trace_x86_pic_interrupt(irq, level);
+    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
+        CPU_FOREACH(cs) {
+            cpu =3D X86_CPU(cs);
+            if (apic_accept_pic_intr(cpu->apic_state)) {
+                apic_deliver_pic_intr(cpu->apic_state, level);
+            }
+        }
+    } else {
+        if (level) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+qemu_irq x86_machine_allocate_cpu_irq(void)
+{
+    return qemu_allocate_irq(pic_irq_request, NULL, 0);
+}
+
 static long get_file_size(FILE *f)
 {
     long where, size;
--=20
2.21.0


