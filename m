Received: from eggs.gnu.org ([2001:4830:134:3::10]:59912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzac-0002F1-IW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzab-0002Lh-PQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:50 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:06 +1000
Message-Id: <20180427092126.24812-30-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 29/49] Revert "spapr: Don't allow memory hotplug
 to memory less nodes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Serhii Popovych <spopovyc@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Serhii Popovych <spopovyc@redhat.com>

This reverts commit b556854bd8524c26b8be98ab1bfdf0826831e793.

Leave change @node type from uint32_t to to int from reverted commit
because node < 0 is always false.

Note that implementing capability or some trick to detect if guest
kernel does not support hot-add to memory: this returns previous
behavour where memory added to first non-empty node.

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5a1c1e25e1..fc86ba6934 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3478,28 +3478,6 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
             return;
         }
 
-        /*
-         * Currently PowerPC kernel doesn't allow hot-adding memory to
-         * memory-less node, but instead will silently add the memory
-         * to the first node that has some memory. This causes two
-         * unexpected behaviours for the user.
-         *
-         * - Memory gets hotplugged to a different node than what the user
-         *   specified.
-         * - Since pc-dimm subsystem in QEMU still thinks that memory belongs
-         *   to memory-less node, a reboot will set things accordingly
-         *   and the previously hotplugged memory now ends in the right node.
-         *   This appears as if some memory moved from one node to another.
-         *
-         * So until kernel starts supporting memory hotplug to memory-less
-         * nodes, just prevent such attempts upfront in QEMU.
-         */
-        if (nb_numa_nodes && !numa_info[node].node_mem) {
-            error_setg(errp, "Can't hotplug memory to memory-less node %d",
-                       node);
-            return;
-        }
-
         spapr_memory_plug(hotplug_dev, dev, node, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_plug(hotplug_dev, dev, errp);
-- 
2.14.3
