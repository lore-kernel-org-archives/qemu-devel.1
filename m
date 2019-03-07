Received: from eggs.gnu.org ([209.51.188.92]:59765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLm-00026R-AM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLl-000514-8q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLk-000501-V6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:53 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:37 -0800
Message-Id: <20190307072137.8735-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 14/37] multi-process: PCI BAR
 write handling for proxy & remote endpoints
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

From: Jagannathan Raman <jag.raman@oracle.com>

Proxy device object implements handler for PCI BAR writes. The handler
sends BAR_WRITE message to the remote process with the BAR address and
value to be written
The remote process implements handler for BAR_WRITE message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 28 ++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  3 +++
 include/io/proxy-link.h       | 10 ++++++++++
 remote/remote-main.c          | 24 ++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 91cc82b..49ed683 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -201,3 +201,31 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
         }
     }
 }
+
+static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
+                                bool write, hwaddr addr, uint64_t *val,
+                                unsigned size, bool memory)
+{
+    ProcMsg msg;
+
+    memset(&msg, 0, sizeof(ProcMsg));
+
+    msg.bytestream = 0;
+    msg.size = sizeof(msg.data1);
+    msg.data1.bar_access.addr = mr->addr + addr;
+    msg.data1.bar_access.size = size;
+    msg.data1.bar_access.memory = memory;
+
+    if (write) {
+        msg.cmd = BAR_WRITE;
+        msg.data1.bar_access.val = *val;
+    }
+
+    proxy_proc_send(proxy_link, &msg);
+}
+
+void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                             uint64_t val, unsigned size, bool memory)
+{
+    send_bar_access_msg(dev->proxy_link, mr, true, addr, &val, size, memory);
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 0b0d94a..567a7c6 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -65,4 +65,7 @@ typedef struct PCIProxyDevClass {
     char *command;
 } PCIProxyDevClass;
 
+void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                             uint64_t val, unsigned size, bool memory);
+
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 521df4f..2884852 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -56,6 +56,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * CONF_READ        PCI config. space read
  * CONF_WRITE       PCI config. space write
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
+ * BAR_WRITE        Writes to PCI BAR region
  *
  */
 typedef enum {
@@ -63,6 +64,7 @@ typedef enum {
     CONF_READ,
     CONF_WRITE,
     SYNC_SYSMEM,
+    BAR_WRITE,
     MAX,
 } proc_cmd_t;
 
@@ -85,6 +87,13 @@ typedef struct {
 } sync_sysmem_msg_t;
 
 typedef struct {
+    hwaddr addr;
+    uint64_t val;
+    unsigned size;
+    bool memory;
+} bar_access_msg_t;
+
+typedef struct {
     proc_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -92,6 +101,7 @@ typedef struct {
     union {
         uint64_t u64;
         sync_sysmem_msg_t sync_sysmem;
+        bar_access_msg_t bar_access;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/remote/remote-main.c b/remote/remote-main.c
index f708be2..cf7949c 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -45,6 +45,7 @@
 #include "qemu/config-file.h"
 #include "sysemu/sysemu.h"
 #include "block/block.h"
+#include "exec/memattrs.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -75,6 +76,23 @@ static void process_config_read(ProcMsg *msg)
     PUT_REMOTE_WAIT(wait);
 }
 
+/* TODO: confirm memtx attrs. */
+static void process_bar_write(ProcMsg *msg, Error **errp)
+{
+    bar_access_msg_t *bar_access = &msg->data1.bar_access;
+    AddressSpace *as =
+        bar_access->memory ? &address_space_memory : &address_space_io;
+    MemTxResult res;
+
+    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
+                           (uint8_t *)&bar_access->val, bar_access->size, true);
+
+    if (res != MEMTX_OK) {
+        error_setg(errp, "Could not perform address space write operation,"
+                   " inaccessible address: %lx.", bar_access->addr);
+    }
+}
+
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -101,6 +119,12 @@ static void process_msg(GIOCondition cond)
     case CONF_READ:
         process_config_read(msg);
         break;
+    case BAR_WRITE:
+        process_bar_write(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1
