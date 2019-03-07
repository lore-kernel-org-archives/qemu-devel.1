Received: from eggs.gnu.org ([209.51.188.92]:60217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMg-0002pc-G8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMf-0005n3-A4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMe-0005lx-0W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:48 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:41 -0800
Message-Id: <20190307072241.9639-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 31/37] multi-process: add
 heartbeat timer and signal handler
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

Add isignal handler for launched remote processes and set up
the heartbit timer for remote processes.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c   | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h |   1 +
 2 files changed, 102 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 9d075ec..e055abe 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -61,14 +61,96 @@
  */
 int kvm_vm_ioctl(KVMState *s, int type, ...);
 
+QEMUTimer *hb_timer;
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 static void setup_irqfd(PCIProxyDev *dev);
+static void pci_dev_exit(PCIDevice *dev);
+static void start_heartbeat_timer(void);
+static void stop_heartbeat_timer(void);
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx);
+static void broadcast_msg(ProcMsg *msg, bool need_reply);
+
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
+{
+    /* TODO: Add proper handler. */
+    printf("Child (pid %d) is dead? Signal is %d, Exit code is %d.\n",
+           siginfo->si_pid, siginfo->si_signo, siginfo->si_code);
+}
+
+static void broadcast_msg(ProcMsg *msg, bool need_reply)
+{
+    PCIProxyDev *entry;
+    unsigned int pid;
+    int wait;
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (need_reply) {
+            wait = GET_REMOTE_WAIT;
+            msg->num_fds = 1;
+            msg->fds[0] = wait;
+        }
+
+        proxy_proc_send(entry->proxy_link, msg);
+        if (need_reply) {
+            pid = (uint32_t)wait_for_remote(wait);
+            PUT_REMOTE_WAIT(wait);
+            /* TODO: Add proper handling. */
+            if (pid) {
+                need_reply = 0;
+            }
+        }
+    }
+}
+
+#define NOP_INTERVAL 1000000
+
+static void remote_ping(void *opaque)
+{
+    ProcMsg msg;
+
+    memset(&msg, 0, sizeof(ProcMsg));
+
+    msg.num_fds = 0;
+    msg.cmd = PROXY_PING;
+    msg.bytestream = 0;
+    msg.size = 0;
+
+    broadcast_msg(&msg, true);
+    timer_mod(hb_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+
+}
+
+void start_heartbeat_timer(void)
+{
+    hb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            remote_ping,
+                                            &proxy_dev_list);
+    timer_mod(hb_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+
+}
+
+static void stop_heartbeat_timer(void)
+{
+    timer_del(hb_timer);
+    timer_free(hb_timer);
+}
+
+static void set_sigchld_handler(void)
+{
+    struct sigaction sa_sigterm;
+    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
+    sa_sigterm.sa_sigaction = childsig_handler;
+    sa_sigterm.sa_flags = SA_SIGINFO | SA_NOCLDWAIT | SA_NOCLDSTOP;
+    sigaction(SIGCHLD, &sa_sigterm, NULL);
+}
 
 static void proxy_ready(PCIDevice *dev)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
 
     setup_irqfd(pdev);
+    set_sigchld_handler();
+    start_heartbeat_timer();
 }
 
 static void set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
@@ -165,6 +247,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
+    k->exit = pci_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 }
@@ -309,6 +392,24 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 
 }
 
+static void pci_dev_exit(PCIDevice *pdev)
+{
+    PCIProxyDev *entry, *sentry;
+    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
+
+    stop_heartbeat_timer();
+
+    QLIST_FOREACH_SAFE(entry, &proxy_dev_list.devices, next, sentry) {
+        if (entry->remote_pid == dev->remote_pid) {
+            QLIST_REMOVE(entry, next);
+        }
+    }
+
+    if (!QLIST_EMPTY(&proxy_dev_list.devices)) {
+        start_heartbeat_timer();
+    }
+}
+
 static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
                                 bool write, hwaddr addr, uint64_t *val,
                                 unsigned size, bool memory)
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 21d63cc..af451e8 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -76,6 +76,7 @@ typedef enum {
     DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
+    PROXY_PING,
     MAX,
 } proc_cmd_t;
 
-- 
1.8.3.1
