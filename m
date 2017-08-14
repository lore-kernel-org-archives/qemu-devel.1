Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhCLP-0008LB-BN
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhCLL-0002aV-6P
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:11:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11471
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhCLK-0002WB-Qk
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:11:31 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Mon, 14 Aug 2017 18:11:11 +0800
Message-ID: <1502705471-28407-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] numa: Add a check whether the node0 has memory
 or not
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, dgilbert@redhat.com, armbru@redhat.com, david@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

Currently, Using the fisrt node without memory on the machine makes
QEMU unhappy. With this example command line:
  ... \
  -m 1024M,slots=4,maxmem=32G \
  -numa node,nodeid=0 \
  -numa node,mem=1024M,nodeid=1 \
  -numa node,nodeid=2 \
  -numa node,nodeid=3 \
Guest reports "No NUMA configuration found" and the NUMA topology is
wrong.

This is because when QEMU builds ACPI SRAT, it regards node0 as the
default node to deal with the memory hole(640K-1M). this means the
node0 must have some memory(>1M) firstly.

Add a check in parse_numa_opts to avoid this situation.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 numa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/numa.c b/numa.c
index e32af04..1d6f73f 100644
--- a/numa.c
+++ b/numa.c
@@ -464,6 +464,10 @@ void parse_numa_opts(MachineState *ms)
         if (i == nb_numa_nodes) {
             assert(mc->numa_auto_assign_ram);
             mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
+        } else if (i != 0) {
+            error_report("The first NUMA node must have some memory"
+                          " for building ACPI SART");
+            exit(1);
         }
 
         numa_total = 0;
-- 
2.5.5
