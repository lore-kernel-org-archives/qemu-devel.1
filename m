Received: from eggs.gnu.org ([2001:4830:134:3::10]:37945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnODE-0000WF-SQ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnODA-0004ib-Hu
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:04:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27977
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnODA-0004iA-6X
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:04:40 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Thu, 31 Aug 2017 20:04:28 +0800
Message-ID: <1504181068-17822-4-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1504181068-17822-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1504181068-17822-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 3/3] NUMA: Replace MAX_NODES with
 nb_numa_nodes in for loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, mst@redhat.com, rth@twiddle.net, Dou Liyang <douly.fnst@cn.fujitsu.com>

In QEMU, the number of the NUMA nodes is determined by parse_numa_opts().
Then, QEMU uses it for iteration, for example:
  for (i = 0; i < nb_numa_nodes; i++)

However, in memory_region_allocate_system_memory(), it uses MAX_NODES
not nb_numa_nodes.

So, replace MAX_NODES with nb_numa_nodes to keep code consistency and
reduce the loop times.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/numa.c b/numa.c
index e32af04..5f2916d 100644
--- a/numa.c
+++ b/numa.c
@@ -567,7 +567,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
     }
 
     memory_region_init(mr, owner, name, ram_size);
-    for (i = 0; i < MAX_NODES; i++) {
+    for (i = 0; i < nb_numa_nodes; i++) {
         uint64_t size = numa_info[i].node_mem;
         HostMemoryBackend *backend = numa_info[i].node_memdev;
         if (!backend) {
-- 
2.5.5
