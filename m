Received: from eggs.gnu.org ([209.51.188.92]:60236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMh-0002qx-Pt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMg-0005nb-GX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMf-0005mc-4A
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:49 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:36 -0800
Message-Id: <20190307072236.9548-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 29/37] multi-process: remote:
 add create_done condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Do not allow BAR,MMIO handlers and irq setup to run before
the configuration of the devices completes.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 remote/remote-main.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index fa32f2a..3fa6cbd 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -67,6 +67,7 @@
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
+bool create_done;
 
 static void process_config_write(ProcMsg *msg)
 {
@@ -355,21 +356,31 @@ static void process_msg(GIOCondition cond)
     case INIT:
         break;
     case CONF_WRITE:
-        process_config_write(msg);
+        if (create_done) {
+            process_config_write(msg);
+        }
+
         break;
     case CONF_READ:
-        process_config_read(msg);
+        if (create_done) {
+            process_config_read(msg);
+        }
+
         break;
     case BAR_WRITE:
-        process_bar_write(msg, &err);
-        if (err) {
-            goto finalize_loop;
+        if (create_done) {
+            process_bar_write(msg, &err);
+            if (err) {
+                error_report_err(err);
+            }
         }
         break;
     case BAR_READ:
-        process_bar_read(msg, &err);
-        if (err) {
-            goto finalize_loop;
+        if (create_done) {
+            process_bar_read(msg, &err);
+            if (err) {
+                error_report_err(err);
+            }
         }
         break;
     case SYNC_SYSMEM:
@@ -389,7 +400,7 @@ static void process_msg(GIOCondition cond)
         qemu_mutex_lock_iothread();
         qemu_run_machine_init_done_notifiers();
         qemu_mutex_unlock_iothread();
-
+        create_done = true;
         break;
     case DRIVE_OPTS:
         if (setup_drive(msg, &err)) {
-- 
1.8.3.1
