Received: from eggs.gnu.org ([2001:4830:134:3::10]:52991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kN-00085R-NY
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kF-0004QC-W6
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:45 +1100
Message-Id: <20170202051445.5735-108-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 107/107] hw/ppc/pnv: Use error_report instead of
 hw_error if a ROM file can't be found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

hw_error() is for CPU related errors only (it dumps the CPU registers
and  calls abort()!), so using error_report() is the better choice
of reporting an error in case we simply did not find a file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 83597fe..4fab5c0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -381,7 +381,7 @@ static void ppc_powernv_init(MachineState *machine)
 
     fw_size = load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SIZE);
     if (fw_size < 0) {
-        hw_error("qemu: could not load OPAL '%s'\n", fw_filename);
+        error_report("qemu: could not load OPAL '%s'", fw_filename);
         exit(1);
     }
     g_free(fw_filename);
@@ -393,8 +393,8 @@ static void ppc_powernv_init(MachineState *machine)
         kernel_size = load_image_targphys(machine->kernel_filename,
                                           KERNEL_LOAD_ADDR, 0x2000000);
         if (kernel_size < 0) {
-            hw_error("qemu: could not load kernel'%s'\n",
-                     machine->kernel_filename);
+            error_report("qemu: could not load kernel'%s'",
+                         machine->kernel_filename);
             exit(1);
         }
     }
-- 
2.9.3
