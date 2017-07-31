Received: from eggs.gnu.org ([2001:4830:134:3::10]:50909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pe-00046w-0J
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pa-00068a-Q8
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:25 +0300
Message-Id: <b190f477e29c7cd03a8fee49c96d27f160e3f5b0.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 06/25] qemu-system-tricore: segfault when
 entering "x 0" on the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eduardo Otubo <otubo@redhat.com>

Starting Qemu with "qemu-system-tricore -nographic -M tricore_testboard -S"
and entering "x 0" at the monitor prompt leads to Segmentation fault.
This happens because tricore_cpu_get_phys_page_debug() is not implemented
yet, this is a temporary workaround to avoid the crash.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/tricore/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 08f50e2ba7..5ab5b56454 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -22,6 +22,15 @@
 #include "cpu.h"
 #include "qemu-common.h"
 #include "exec/exec-all.h"
+#include "qemu/error-report.h"
+
+static hwaddr tricore_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+                                         MemTxAttrs *attrs)
+{
+    error_report("function cpu_get_phys_page_attrs_debug not "
+                    "implemented, aborting");
+    return -1;
+}
 
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
@@ -176,6 +185,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     cc->dump_state = tricore_cpu_dump_state;
     cc->set_pc = tricore_cpu_set_pc;
     cc->synchronize_from_tb = tricore_cpu_synchronize_from_tb;
+    cc->get_phys_page_attrs_debug = tricore_cpu_get_phys_page_attrs_debug;
 }
 
 static void cpu_register(const TriCoreCPUInfo *info)
-- 
2.11.0
