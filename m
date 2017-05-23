Received: from eggs.gnu.org ([2001:4830:134:3::10]:48607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDAxn-0008Pq-3Q
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDAxj-0002gE-3M
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:39:07 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 May 2017 16:38:49 +0200
Message-Id: <1495550330-34087-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1495550330-34087-1-git-send-email-imammedo@redhat.com>
References: <1495550330-34087-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] numa: fallback to default NUMA node
 instead of node 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

Do the same as we did in commit
  (57924bcd8 numa: introduce machine callback for VCPU to node mapping)
but only for incomplete mapping usecase, falling back to board
provided default cpu to node mapping if user hasn't provided
mapping for CPU explicitly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/machine.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 964b75d..b8df15f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -730,9 +730,6 @@ static void machine_numa_finish_init(MachineState *machine)
                 g_string_append_printf(s, "%sCPU %d [%s]",
                                        s->len ? ", " : "", i, cpu_str);
                 g_free(cpu_str);
-
-                /* non mapped cpus used to fallback to node 0 */
-                props.node_id = 0;
             }
 
             props.has_node_id = true;
-- 
2.7.4
