Received: from eggs.gnu.org ([209.51.188.92]:59834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLv-0002CS-PE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLu-0005Az-EX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLu-0005AZ-3W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:02 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:44 -0800
Message-Id: <20190307072144.8781-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 15/37] multi-process: PCI BAR
 read handling for proxy & remote endpoints
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

Proxy device object implements the read handler for PCI BAR accesses.
The handler sends BAR_READ message to the remote process.
The remote process implements handler for BAR_READ message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 22 +++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  3 +++
 include/io/proxy-link.h       |  2 ++
 remote/remote-main.c          | 49 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 49ed683..08e549e 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -207,6 +207,7 @@ static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
                                 unsigned size, bool memory)
 {
     ProcMsg msg;
+    int wait;
 
     memset(&msg, 0, sizeof(ProcMsg));
 
@@ -219,9 +220,20 @@ static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
     if (write) {
         msg.cmd = BAR_WRITE;
         msg.data1.bar_access.val = *val;
+    } else {
+        wait = GET_REMOTE_WAIT;
+
+        msg.cmd = BAR_READ;
+        msg.num_fds = 1;
+        msg.fds[0] = wait;
     }
 
     proxy_proc_send(proxy_link, &msg);
+
+    if (!write) {
+        *val = wait_for_remote(wait);
+        PUT_REMOTE_WAIT(wait);
+    }
 }
 
 void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
@@ -229,3 +241,13 @@ void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
 {
     send_bar_access_msg(dev->proxy_link, mr, true, addr, &val, size, memory);
 }
+
+uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                                unsigned size, bool memory)
+{
+    uint64_t val;
+
+    send_bar_access_msg(dev->proxy_link, mr, false, addr, &val, size, memory);
+
+    return val;
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 567a7c6..e8d3a9c 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -68,4 +68,7 @@ typedef struct PCIProxyDevClass {
 void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
                              uint64_t val, unsigned size, bool memory);
 
+uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
+                                unsigned size, bool memory);
+
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 2884852..dc3c074 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -57,6 +57,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * CONF_WRITE       PCI config. space write
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  * BAR_WRITE        Writes to PCI BAR region
+ * BAR_READ         Reads from PCI BAR region
  *
  */
 typedef enum {
@@ -65,6 +66,7 @@ typedef enum {
     CONF_WRITE,
     SYNC_SYSMEM,
     BAR_WRITE,
+    BAR_READ,
     MAX,
 } proc_cmd_t;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index cf7949c..f0390cc 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -93,6 +93,49 @@ static void process_bar_write(ProcMsg *msg, Error **errp)
     }
 }
 
+static void process_bar_read(ProcMsg *msg, Error **errp)
+{
+    bar_access_msg_t *bar_access = &msg->data1.bar_access;
+    AddressSpace *as;
+    int wait = msg->fds[0];
+    MemTxResult res;
+    uint64_t val = 0;
+
+    as = bar_access->memory ? &address_space_memory : &address_space_io;
+
+    assert(bar_access->size <= sizeof(uint64_t));
+
+    res = address_space_rw(as, bar_access->addr, MEMTXATTRS_UNSPECIFIED,
+                           (uint8_t *)&val, bar_access->size, false);
+
+    if (res != MEMTX_OK) {
+        error_setg(errp, "Could not perform address space read operation,"
+                   " inaccessible address: %lx.", bar_access->addr);
+        val = (uint64_t)-1;
+        goto fail;
+    }
+
+    switch (bar_access->size) {
+    case 4:
+        val = *((uint32_t *)&val);
+        break;
+    case 2:
+        val = *((uint16_t *)&val);
+        break;
+    case 1:
+        val = *((uint8_t *)&val);
+        break;
+    default:
+        error_setg(errp, "Invalid PCI BAR read size");
+        return;
+    }
+
+fail:
+    notify_proxy(wait, val);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -125,6 +168,12 @@ static void process_msg(GIOCondition cond)
             goto finalize_loop;
         }
         break;
+    case BAR_READ:
+        process_bar_read(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1
