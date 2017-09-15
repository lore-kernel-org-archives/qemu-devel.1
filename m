Received: from eggs.gnu.org ([2001:4830:134:3::10]:38434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmBU-0007Jz-1p
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmBO-0002df-Dp
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:41:12 -0400
Received: from ozlabs.ru ([107.173.13.209]:44990)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmBO-0002dY-7S
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:41:06 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 15 Sep 2017 18:40:18 +1000
Message-Id: <20170915084030.40988-2-aik@ozlabs.ru>
In-Reply-To: <20170915084030.40988-1-aik@ozlabs.ru>
References: <20170915084030.40988-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 01/13] memory: Postpone flatview and
 dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

Most devices use at least one address space and every time a new address
space is added, flat views and dispatch trees are rebuild for all address
spaces. This is not a problem for a relatively small amount of devices but
even 50 virtio-pci devices use more than 8GB of RAM.

What happens that on every flatview/dispatch rebuild, new arrays are
allocated and old ones release but the release is done via RCU so until
an entire machine is build, they are not released.

This wraps devices creation into memory_region_transaction_begin/commit
to massively reduce amount of flat view/dispatch tree (re)allocations.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* wrapped qemu_run_machine_init_done_notifiers() as well
---
 vl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/vl.c b/vl.c
index fb1f05b937..ee3cc7db48 100644
--- a/vl.c
+++ b/vl.c
@@ -4661,12 +4661,16 @@ int main(int argc, char **argv, char **envp)
     igd_gfx_passthru();
 
     /* init generic devices */
+    memory_region_transaction_begin();
+
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     if (qemu_opts_foreach(qemu_find_opts("device"),
                           device_init_func, NULL, NULL)) {
         exit(1);
     }
 
+    memory_region_transaction_commit();
+
     cpu_synchronize_all_post_init();
 
     rom_reset_order_override();
@@ -4749,8 +4753,13 @@ int main(int argc, char **argv, char **envp)
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
     qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
+
+    memory_region_transaction_begin();
+
     qemu_run_machine_init_done_notifiers();
 
+    memory_region_transaction_commit();
+
     if (rom_check_and_register_reset() != 0) {
         error_report("rom check and register reset failed");
         exit(1);
-- 
2.11.0
