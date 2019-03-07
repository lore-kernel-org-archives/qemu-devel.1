Received: from eggs.gnu.org ([209.51.188.92]:59934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMH-0002Up-3A
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMF-0005ZP-H2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMD-0005YX-UC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:22 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:05 -0800
Message-Id: <20190307072205.8990-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 19/37] multi-process: store
 info about the remote process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Store info about the remote process in a hash table, so that
it could be used later for QMP/HMP commands.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/i386/pc.c          | 1 +
 hw/proxy/qemu-proxy.c | 7 +++++++
 include/hw/i386/pc.h  | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4212818..9f569cf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2643,6 +2643,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->pit_enabled = true;
+    pcms->remote_devs = g_hash_table_new(g_str_hash, g_str_equal);
 }
 
 static void pc_machine_reset(void)
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index d525344..d1560d9 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -50,6 +50,8 @@
 #include "qemu/event_notifier.h"
 #include "sysemu/kvm.h"
 #include "util/event_notifier-posix.c"
+#include "hw/i386/pc.h"
+#include "hw/boards.h"
 
 /*
  * TODO: kvm_vm_ioctl is only available for per-target objects (NEED_CPU_H).
@@ -234,6 +236,7 @@ static void init_emulation_process(PCIProxyDev *pdev, char *command, Error **err
     }
 
     pdev->proxy_link = proxy_link_create();
+    pdev->remote_pid = rpid;
 
     if (!pdev->proxy_link) {
         error_setg(errp, "Failed to create proxy link");
@@ -252,9 +255,13 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
     PCIProxyDevClass *k = PCI_PROXY_DEV_GET_CLASS(dev);
     Error *local_err = NULL;
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+    DeviceState *d = DEVICE(dev);
 
     init_emulation_process(dev, k->command, errp);
 
+    (void)g_hash_table_insert(pcms->remote_devs, (gpointer)d->id, (gpointer)dev);
+
     if (k->realize) {
         k->realize(dev, &local_err);
         if (local_err) {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 54222a2..ded7cf0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -1,6 +1,8 @@
 #ifndef HW_PC_H
 #define HW_PC_H
 
+#include <gmodule.h>
+
 #include "qemu-common.h"
 #include "exec/memory.h"
 #include "hw/boards.h"
@@ -39,6 +41,7 @@ struct PCMachineState {
     PCIBus *bus;
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
+    GHashTable *remote_devs;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
-- 
1.8.3.1
