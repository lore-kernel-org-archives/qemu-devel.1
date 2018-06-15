Received: from eggs.gnu.org ([2001:4830:134:3::10]:53294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTsKV-0006Hi-2f
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTsKP-0007SU-2J
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:07 -0400
Received: from mail-eopbgr730053.outbound.protection.outlook.com
	([40.107.73.53]:16992
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTsKO-0007R7-SU
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:00 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 15 Jun 2018 13:15:45 -0400
Message-Id: <1529082947-60001-2-git-send-email-babu.moger@amd.com>
In-Reply-To: <1529082947-60001-1-git-send-email-babu.moger@amd.com>
References: <1529082947-60001-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v15 1/3] i386: Fix up the Node id for
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

This is part of topoext support. To keep the compatibility, we need
to support all the combination of nr_cores and nr_threads currently
supported. With this combination, we might end up with more nodes than
we can support with real hardware. We need to fix up the node id to
accommodate more nodes here. We can achieve this by shifting the bits.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a4484b..5246be4 100644
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
@@ -504,7 +507,25 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
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
+         * an ideal config but we need to to support it. Max bit we can have
+         * here is 8.
+         */
+        nodes = topo.num_nodes - 1;
+        shift = find_last_bit(&nodes, 8);
+        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << shift) |
+                topo.node_id;
+    }
     *edx = 0;
 }
 
-- 
1.8.3.1
