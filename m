Received: from eggs.gnu.org ([209.51.188.92]:60122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMa-0002m7-JP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMY-0005jh-JX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMW-0005gb-Lv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:41 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:26 -0800
Message-Id: <20190307072226.9362-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 25/37] multi-process:
 configure remote side devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, berrange@redhat.com

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Add functions to configure remote devices.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 41 +++++++++++++++++++++++++++++++++++++++--
 include/hw/proxy/qemu-proxy.h |  2 ++
 include/io/proxy-link.h       |  2 ++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index f519beb..9d075ec 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -52,6 +52,7 @@
 #include "util/event_notifier-posix.c"
 #include "hw/i386/pc.h"
 #include "hw/boards.h"
+#include "include/qemu/log.h"
 
 /*
  * TODO: kvm_vm_ioctl is only available for per-target objects (NEED_CPU_H).
@@ -61,6 +62,40 @@
 int kvm_vm_ioctl(KVMState *s, int type, ...);
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
+static void setup_irqfd(PCIProxyDev *dev);
+
+static void proxy_ready(PCIDevice *dev)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+
+    setup_irqfd(pdev);
+}
+
+static void set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
+{
+    QString *qstr;
+    ProcMsg msg;
+    const char *str;
+    PCIProxyDev *pdev;
+
+    pdev = PCI_PROXY_DEV(dev);
+
+    qstr = qobject_to_json(QOBJECT(qdict));
+    str = qstring_get_str(qstr);
+    qemu_log_mask(LOG_REMOTE_DEBUG, "remote qdict in proxy: %s.\n", str);
+
+    memset(&msg, 0, sizeof(ProcMsg));
+
+    msg.data2 = (uint8_t *)str;
+    msg.cmd = cmd;
+    msg.bytestream = 1;
+    msg.size = qstring_get_length(qstr) + 1;
+    msg.num_fds = 0;
+
+    proxy_proc_send(pdev->proxy_link, &msg);
+
+    return;
+}
 
 static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
                           unsigned int op)
@@ -76,7 +111,8 @@ static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
 
     msg.data2 = (uint8_t *)malloc(sizeof(conf_data));
     if (!msg.data2) {
-        printf("Failed to allocate memory for msg.data2.");
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Failed to allocate memory"
+                      " for msg.data2.\n");
         return -ENOMEM;
     }
 
@@ -268,8 +304,9 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->sync = REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
 
     configure_memory_sync(dev->sync, dev->proxy_link);
+    dev->set_remote_opts = set_remote_opts;
+    dev->proxy_ready = proxy_ready;
 
-    setup_irqfd(dev);
 }
 
 static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 55160b0..6b61bb7 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -28,6 +28,8 @@
 #include "io/proxy-link.h"
 #include "hw/proxy/memory-sync.h"
 #include "qemu/event_notifier.h"
+#include "hw/pci/pci.h"
+#include "block/qdict.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index ce2fcc3..21d63cc 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -72,6 +72,8 @@ typedef enum {
     BAR_WRITE,
     BAR_READ,
     SET_IRQFD,
+    DEV_OPTS,
+    DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
     MAX,
-- 
1.8.3.1
