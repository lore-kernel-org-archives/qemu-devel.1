Received: from eggs.gnu.org ([2001:4830:134:3::10]:50163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f45zF-0007RK-IW
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f45zB-0001Ql-Ko
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:35:37 -0400
From: Serhii Popovych <spopovyc@redhat.com>
Date: Thu,  5 Apr 2018 10:35:22 -0400
Message-Id: <1522938923-96058-2-git-send-email-spopovyc@redhat.com>
In-Reply-To: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.13 1/2] Revert "spapr: Don't allow memory
 hotplug to memory less nodes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

This reverts commit b556854bd8524c26b8be98ab1bfdf0826831e793.

Leave change @node type from uint32_t to to int from reverted commit
because node < 0 is always false.

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
---
 hw/ppc/spapr.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2c0be8c..3ad4545 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3477,28 +3477,6 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
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
1.8.3.1
