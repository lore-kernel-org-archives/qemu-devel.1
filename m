Received: from eggs.gnu.org ([2001:4830:134:3::10]:44738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV4-0001vm-40
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV3-00007L-2S
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJV2-000078-Sd
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D712E7F3EC
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:43:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:41 -0300
Message-Id: <20170329194148.19015-3-ehabkost@redhat.com>
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
References: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 2/9] Simplify code using *MACHINE_GET_CLASS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There's no need to use MACHINE_GET_CLASS/object_get_class()
followed by a *MACHINE_CLASS cast. Use *MACHINE_GET_CLASS()
directly.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c     | 3 +--
 hw/pci/pci.c          | 3 +--
 hw/xen/xen_backend.c  | 3 +--
 target/i386/machine.c | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index ada9eea483..6aa452a792 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -342,8 +342,7 @@ static void error_on_sysbus_device(SysBusDevice *sbdev, void *opaque)
 static void machine_init_notify(Notifier *notifier, void *data)
 {
     Object *machine = qdev_get_machine();
-    ObjectClass *oc = object_get_class(machine);
-    MachineClass *mc = MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (mc->has_dynamic_sysbus) {
         /* Our machine can handle dynamic sysbus devices, we're all good */
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e6b08e1988..9151057bf5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1195,8 +1195,7 @@ static pcibus_t pci_bar_address(PCIDevice *d,
     int bar = pci_bar(d, reg);
     uint16_t cmd = pci_get_word(d->config + PCI_COMMAND);
     Object *machine = qdev_get_machine();
-    ObjectClass *oc = object_get_class(machine);
-    MachineClass *mc = MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     bool allow_0_address = mc->pci_allow_0_address;
 
     if (type & PCI_BASE_ADDRESS_SPACE_IO) {
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 6c21c37d68..6e530681f4 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -553,8 +553,7 @@ err:
 static void xen_set_dynamic_sysbus(void)
 {
     Object *machine = qdev_get_machine();
-    ObjectClass *oc = object_get_class(machine);
-    MachineClass *mc = MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     mc->has_dynamic_sysbus = true;
 }
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 78ae2f986b..5b9eb3a2f6 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -893,8 +893,7 @@ static bool tsc_khz_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(qdev_get_machine());
     return env->tsc_khz && pcmc->save_tsc_khz;
 }
 
-- 
2.11.0.259.g40922b1
