Received: from eggs.gnu.org ([2001:4830:134:3::10]:48389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd7-0004wp-BP
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd5-0000nD-Qu
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpd5-0000mP-Hg
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd4-0003U8-Gt
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:01 +0100
Message-Id: <20180510174519.11264-4-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/21] pc: simplify
 MachineClass::get_hotplug_handler handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

By default MachineClass::get_hotplug_handler is NULL and concrete board
should set it to it's own handler.
Considering there isn't any default handler, drop saving empty
MachineClass::get_hotplug_handler in child class and make PC code
consistent with spapr/s390x boards.

We can bring this back when actual usecase surfaces and do it
consistently across boards that use get_hotplug_handler().

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-id: 1525691524-32265-2-git-send-email-imammedo@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i386/pc.h | 8 --------
 hw/i386/pc.c         | 6 +-----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2e834e6ded..2a98e3ad68 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -83,10 +83,6 @@ struct PCMachineState {
 /**
  * PCMachineClass:
  *
- * Methods:
- *
- * @get_hotplug_handler: pointer to parent class callback @get_hotplug_handler
- *
  * Compat fields:
  *
  * @enforce_aligned_dimm: check that DIMM's address/size is aligned by
@@ -106,10 +102,6 @@ struct PCMachineClass {
 
     /*< public >*/
 
-    /* Methods: */
-    HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
-                                           DeviceState *dev);
-
     /* Device configuration: */
     bool pci_enabled;
     bool kvmclock_enabled;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 868893d0a1..b2374febbb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2051,15 +2051,12 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
 static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
-
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         return HOTPLUG_HANDLER(machine);
     }
 
-    return pcmc->get_hotplug_handler ?
-        pcmc->get_hotplug_handler(machine, dev) : NULL;
+    return NULL;
 }
 
 static void
@@ -2339,7 +2336,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
-    pcmc->get_hotplug_handler = mc->get_hotplug_handler;
     pcmc->pci_enabled = true;
     pcmc->has_acpi_build = true;
     pcmc->rsdp_in_ram = true;
-- 
2.17.0
