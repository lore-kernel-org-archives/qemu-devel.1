Received: from eggs.gnu.org ([2001:4830:134:3::10]:34365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fagLN-0007ki-TO
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fagLK-0005MO-1t
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:53:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52660
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fagLJ-0005EN-JH
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:53:05 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 4 Jul 2018 19:52:47 +0800
Message-ID: <20180704115247.31117-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] hw/machine: Remove the Zero check of
 nb_numa_nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

Commit 7a3099fc9c5c("numa: postpone options post-processing till machine_run_board_init()")
broke the commit 7b8be49d36fc("NUMA: Enable adding NUMA node implicitly").

The machine_run_board_init() doesn't do NUMA setup if nb_numa_nodes=0.

Due to the NUMA setup will also check the value of nb_numa_nodes, remove the
check from machine_run_board_init() to fix ths bug.

Fixes 7a3099fc9c5c("numa: postpone options post-processing till machine_run_board_init()")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 hw/core/machine.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2077328bcc..962346f90d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -791,10 +791,8 @@ void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
-    if (nb_numa_nodes) {
-        numa_complete_configuration(machine);
-        machine_numa_finish_cpu_init(machine);
-    }
+    numa_complete_configuration(machine);
+    machine_numa_finish_cpu_init(machine);
 
     /* If the machine supports the valid_cpu_types check and the user
      * specified a CPU with -cpu check here that the user CPU is supported.
-- 
2.14.3
