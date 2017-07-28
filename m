Received: from eggs.gnu.org ([2001:4830:134:3::10]:39468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1db3ny-00063m-FG
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1db3nt-000510-5F
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:51:40 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 28 Jul 2017 13:51:31 +0200
Message-Id: <20170728115131.31725-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH] unicore32: abort when entering "x 0" on the
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, gxt@mprc.pku.edu.cn, thuth@redhat.com

Starting Qemu with "qemu-system-unicore32 -M puv3,accel=qtest -S -nographic"
and entering "x 0 " at the monitor prompt leads to abort():

  $ ./unicore32-softmmu/qemu-system-unicore32 -M puv3,accel=qtest -S -nographic
  QEMU 2.9.90 monitor - type 'help' for more information
  (qemu) x 0
  qemu: fatal: uc32_cpu_get_phys_page_debug not supported yet

  R00=00000000 R01=00000000 R02=00000000 R03=00000000
  R04=00000000 R05=00000000 R06=00000000 R07=00000000
  R08=00000000 R09=00000000 R10=00000000 R11=00000000
  R12=00000000 R13=00000000 R14=00000000 R15=00000000
  R16=00000000 R17=00000000 R18=00000000 R19=00000000
  R20=00000000 R21=00000000 R22=00000000 R23=00000000
  R24=00000000 R25=00000000 R26=00000000 R27=00000000
  R28=00000000 R29=00000000 R30=00000000 R31=03000000
  PSR=40000013 -Z-- PRIV
  Aborted (core dumped)

This happens because uc32_cpu_get_phys_page_debug() is not implemented
yet, this is a temporary workaround to avoid the crash.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 target/unicore32/softmmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index e7152e72e0..d8d76968f3 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "qemu/error-report.h"
 
 #undef DEBUG_UC32
 
@@ -271,8 +272,7 @@ int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
 
 hwaddr uc32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    UniCore32CPU *cpu = UNICORE32_CPU(cs);
-
-    cpu_abort(CPU(cpu), "%s not supported yet\n", __func__);
-    return addr;
+    error_report("function uc32_cpu_get_phys_page_debug not "
+                    "implemented, aborting");
+    return -1;
 }
-- 
2.13.3
