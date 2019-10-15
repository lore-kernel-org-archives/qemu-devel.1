Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A9C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100CE20650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100CE20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPyA-0005PL-J8
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPjm-0004Wr-16
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPjk-0006si-OJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPjk-0006sK-G8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B7FE8AC6F5;
 Tue, 15 Oct 2019 16:31:51 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D974419C58;
 Tue, 15 Oct 2019 16:31:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/32] hw/i386/pc: Extract pc_i8259_create()
Date: Tue, 15 Oct 2019 18:26:56 +0200
Message-Id: <20191015162705.28087-24-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 15 Oct 2019 16:31:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i8259 creation code is common to all PC machines, extract the
common code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 19 +++++++++++++++++++
 hw/i386/pc_piix.c    | 13 +------------
 hw/i386/pc_q35.c     | 14 +-------------
 include/hw/i386/pc.h |  1 +
 4 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 59de0c8a1f..2b6a52f23b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1978,6 +1978,25 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa=
_bus, PCIBus *pci_bus)
     rom_reset_order_override();
 }
=20
+void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
+{
+    qemu_irq *i8259;
+
+    if (kvm_pic_in_kernel()) {
+        i8259 =3D kvm_i8259_init(isa_bus);
+    } else if (xen_enabled()) {
+        i8259 =3D xen_interrupt_controller_init();
+    } else {
+        i8259 =3D i8259_init(isa_bus, pc_allocate_cpu_irq());
+    }
+
+    for (size_t i =3D 0; i < ISA_NUM_IRQS; i++) {
+        i8259_irqs[i] =3D i8259[i];
+    }
+
+    g_free(i8259);
+}
+
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
 {
     DeviceState *dev;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 452b107e1b..0a7193a3cc 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -81,7 +81,6 @@ static void pc_init1(MachineState *machine,
     ISABus *isa_bus;
     PCII440FXState *i440fx_state;
     int piix3_devfn =3D -1;
-    qemu_irq *i8259;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
@@ -208,18 +207,8 @@ static void pc_init1(MachineState *machine,
     }
     isa_bus_irqs(isa_bus, pcms->gsi);
=20
-    if (kvm_pic_in_kernel()) {
-        i8259 =3D kvm_i8259_init(isa_bus);
-    } else if (xen_enabled()) {
-        i8259 =3D xen_interrupt_controller_init();
-    } else {
-        i8259 =3D i8259_init(isa_bus, pc_allocate_cpu_irq());
-    }
+    pc_i8259_create(isa_bus, gsi_state->i8259_irq);
=20
-    for (i =3D 0; i < ISA_NUM_IRQS; i++) {
-        gsi_state->i8259_irq[i] =3D i8259[i];
-    }
-    g_free(i8259);
     if (pcmc->pci_enabled) {
         ioapic_init_gsi(gsi_state, "i440fx");
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6d096eff28..f4fb9a02ba 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -128,7 +128,6 @@ static void pc_q35_init(MachineState *machine)
     MemoryRegion *ram_memory;
     GSIState *gsi_state;
     ISABus *isa_bus;
-    qemu_irq *i8259;
     int i;
     ICH9LPCState *ich9_lpc;
     PCIDevice *ahci;
@@ -255,18 +254,7 @@ static void pc_q35_init(MachineState *machine)
     pci_bus_set_route_irq_fn(host_bus, ich9_route_intx_pin_to_irq);
     isa_bus =3D ich9_lpc->isa_bus;
=20
-    if (kvm_pic_in_kernel()) {
-        i8259 =3D kvm_i8259_init(isa_bus);
-    } else if (xen_enabled()) {
-        i8259 =3D xen_interrupt_controller_init();
-    } else {
-        i8259 =3D i8259_init(isa_bus, pc_allocate_cpu_irq());
-    }
-
-    for (i =3D 0; i < ISA_NUM_IRQS; i++) {
-        gsi_state->i8259_irq[i] =3D i8259[i];
-    }
-    g_free(i8259);
+    pc_i8259_create(isa_bus, gsi_state->i8259_irq);
=20
     if (pcmc->pci_enabled) {
         ioapic_init_gsi(gsi_state, "q35");
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 75b44e156c..183326d9fe 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -235,6 +235,7 @@ void pc_pci_device_init(PCIBus *pci_bus);
=20
 typedef void (*cpu_set_smm_t)(int smm, void *arg);
=20
+void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
=20
 ISADevice *pc_find_fdc0(void);
--=20
2.21.0


