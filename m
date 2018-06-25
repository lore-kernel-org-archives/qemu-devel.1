Received: from eggs.gnu.org ([2001:4830:134:3::10]:54364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvh-0001u8-SQ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvf-0003IM-Om
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvf-0003Hi-Fp
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:22 -0300
Message-Id: <20180625222524.382-11-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] i386: Fix up the Node id for
 CPUID_8000_001E
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Babu Moger <babu.moger@amd.com>

From: Babu Moger <babu.moger@amd.com>

This is part of topoext support. To keep the compatibility, it is better
we support all the combination of nr_cores and nr_threads currently
supported. By allowing more nr_cores and nr_threads, we might end up with
more nodes than we can actually support with the real hardware. We need to
fix up the node id to make this work. We can achieve this by shifting the
socket_id bits left to address more nodes.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Message-Id: <1529443919-67509-2-git-send-email-babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a4484bb06..130391c840 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/bitops.h"
 
 #include "cpu.h"
 #include "exec/exec-all.h"
@@ -472,6 +473,8 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
                                        uint32_t *ecx, uint32_t *edx)
 {
     struct core_topology topo = {0};
+    unsigned long nodes;
+    int shift;
 
     build_core_topology(cs->nr_cores, cpu->core_id, &topo);
     *eax = cpu->apic_id;
@@ -504,7 +507,28 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
      *         2  Socket id
      *       1:0  Node id
      */
-    *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) | topo.node_id;
+    if (topo.num_nodes <= 4) {
+        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
+                topo.node_id;
+    } else {
+        /*
+         * Node id fix up. Actual hardware supports up to 4 nodes. But with
+         * more than 32 cores, we may end up with more than 4 nodes.
+         * Node id is a combination of socket id and node id. Only requirement
+         * here is that this number should be unique accross the system.
+         * Shift the socket id to accommodate more nodes. We dont expect both
+         * socket id and node id to be big number at the same time. This is not
+         * an ideal config but we need to to support it. Max nodes we can have
+         * is 32 (255/8) with 8 cores per node and 255 max cores. We only need
+         * 5 bits for nodes. Find the left most set bit to represent the total
+         * number of nodes. find_last_bit returns last set bit(0 based). Left
+         * shift(+1) the socket id to represent all the nodes.
+         */
+        nodes = topo.num_nodes - 1;
+        shift = find_last_bit(&nodes, 8);
+        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (shift + 1)) |
+                topo.node_id;
+    }
     *edx = 0;
 }
 
-- 
2.18.0.rc1.1.g3f1ff2140
