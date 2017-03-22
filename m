Received: from eggs.gnu.org ([2001:4830:134:3::10]:45295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPV-0008W2-Sa
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPV-0002CF-1K
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:45 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:42 +0100
Message-Id: <1490189568-167621-18-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 17/23] numa: remove no longer used
 numa_get_node_for_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

it's been replaced by fetching mapping info from possible_cpus

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/sysemu/numa.h |  4 ----
 numa.c                | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 46ea6c7..c67763a 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -31,8 +31,4 @@ extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
 void numa_unset_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
 uint32_t numa_get_node(ram_addr_t addr, Error **errp);
-
-/* on success returns node index in numa_info,
- * on failure returns nb_numa_nodes */
-int numa_get_node_for_cpu(int idx);
 #endif
diff --git a/numa.c b/numa.c
index ab41776..187c93f 100644
--- a/numa.c
+++ b/numa.c
@@ -583,20 +583,6 @@ MemdevList *qmp_query_memdev(Error **errp)
     return list;
 }
 
-int numa_get_node_for_cpu(int idx)
-{
-    int i;
-
-    assert(idx < max_cpus);
-
-    for (i = 0; i < nb_numa_nodes; i++) {
-        if (test_bit(idx, numa_info[i].node_cpu)) {
-            break;
-        }
-    }
-    return i;
-}
-
 void ram_block_notifier_add(RAMBlockNotifier *n)
 {
     QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
-- 
2.7.4
