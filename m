Received: from eggs.gnu.org ([2001:4830:134:3::10]:59816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fVOEe-00075A-BJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 17:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fVOEb-000349-DO
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 17:32:20 -0400
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com
	([104.47.36.82]:38970
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fVOEb-00032O-7J
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 17:32:17 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Tue, 19 Jun 2018 17:31:57 -0400
Message-Id: <1529443919-67509-2-git-send-email-babu.moger@amd.com>
In-Reply-To: <1529443919-67509-1-git-send-email-babu.moger@amd.com>
References: <1529443919-67509-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v16 1/3] i386: Fix up the Node id for
 CPUID_8000_001E
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com, babu.moger@amd.com

This is part of topoext support. To keep the compatibility, it is better
we support all the combination of nr_cores and nr_threads currently
supported. By allowing more nr_cores and nr_threads, we might end up with
more nodes than we can actually support with the real hardware. We need to
fix up the node id to make this work. We can achieve this by shifting the
socket_id bits left to address more nodes.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a4484b..130391c 100644
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
1.8.3.1
