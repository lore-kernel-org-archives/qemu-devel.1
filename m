Received: from eggs.gnu.org ([2001:4830:134:3::10]:39848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5trC-00008Y-0m
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5trB-00016Y-Ba
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:58:14 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  3 May 2017 14:57:06 +0200
Message-Id: <1493816238-33120-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/24] numa: add numa_[has_]node_id()
 wrappers
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

wrappers should make access to [has]node_id fields more readable

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 follow up patches will use this wrappers
 v2:
    - add wrappers (Drew)
---
 include/sysemu/numa.h | 10 ++++++++++
 numa.c                |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 46ea6c7..98d01e6 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -35,4 +35,14 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp);
 /* on success returns node index in numa_info,
  * on failure returns nb_numa_nodes */
 int numa_get_node_for_cpu(int idx);
+
+static inline bool numa_has_node_id(const CPUArchIdList *possible_cpus, int idx)
+{
+    return possible_cpus->cpus[idx].props.has_node_id;
+}
+
+static inline int numa_node_id(const CPUArchIdList *possible_cpus, int idx)
+{
+    return possible_cpus->cpus[idx].props.node_id;
+}
 #endif
diff --git a/numa.c b/numa.c
index c7e3e0a..872ee0d 100644
--- a/numa.c
+++ b/numa.c
@@ -394,7 +394,7 @@ void parse_numa_opts(MachineState *ms)
 
         possible_cpus = mc->possible_cpu_arch_ids(ms);
         for (i = 0; i < possible_cpus->len; i++) {
-            if (possible_cpus->cpus[i].props.has_node_id) {
+            if (numa_has_node_id(possible_cpus, i)) {
                 break;
             }
         }
-- 
2.7.4
