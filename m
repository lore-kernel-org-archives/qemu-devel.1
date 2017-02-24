Received: from eggs.gnu.org ([2001:4830:134:3::10]:54126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ch7vP-0006aP-P6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 23:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ch7vM-0007wE-ON
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 23:56:11 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 24 Feb 2017 15:55:31 +1100
Message-Id: <20170224045531.7026-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] sysemu: support up to 1024 vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <gkurz@linux.vnet.ibm.com>

Some systems can already provide more than 255 hardware threads.

Bumping the QEMU limit to 1024 seems reasonable:
- it has no visible overhead in top;
- the limit itself has no effect on hot paths.

Cc: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

With ulimit -u/-n bumped (nproc and nofile), I was able to boot a guest
with 1024 CPUs, both with threads=1 and threads=8.

It takes time though - 3:15 to get to the guest shell but it is probably
expected on 160-threads machine.

---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e465d7ac98..46b81a625d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2712,7 +2712,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->init = ppc_spapr_init;
     mc->reset = ppc_spapr_reset;
     mc->block_default_type = IF_SCSI;
-    mc->max_cpus = 255;
+    mc->max_cpus = 1024;
     mc->no_parallel = 1;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * M_BYTE;
-- 
2.11.0
