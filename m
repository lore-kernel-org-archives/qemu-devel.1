Received: from eggs.gnu.org ([2001:4830:134:3::10]:46657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcaAr-0005Ri-Ek
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcaAq-0006sF-NG
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fcaAq-0006s6-Gr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:42:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Jul 2018 14:41:54 -0300
Message-Id: <20180709174154.9470-3-ehabkost@redhat.com>
In-Reply-To: <20180709174154.9470-1-ehabkost@redhat.com>
References: <20180709174154.9470-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] hw/machine: Remove the Zero check of
 nb_numa_nodes for numa_complete_configuration()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

Commit 7a3099fc9c5c("numa: postpone options post-processing till machine_run_board_init()")
broke the commit 7b8be49d36fc("NUMA: Enable adding NUMA node implicitly").

The machine_run_board_init() doesn't do NUMA setup if nb_numa_nodes=0,
but the numa_complete_configuration need add a new node if memory hotplug
is enabled (slots > 0) even nb_numa_nodes=0.

So, Remove the check for numa_complete_configuration() to fix this.

Fixes 7a3099fc9c5c("numa: postpone options post-processing till machine_run_board_init()")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-Id: <20180704132239.6506-1-douly.fnst@cn.fujitsu.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3fad6f8801..a9aeb22f03 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -792,10 +792,9 @@ void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
-    if (nb_numa_nodes) {
-        numa_complete_configuration(machine);
+    numa_complete_configuration(machine);
+    if (nb_numa_nodes)
         machine_numa_finish_cpu_init(machine);
-    }
 
     /* If the machine supports the valid_cpu_types check and the user
      * specified a CPU with -cpu check here that the user CPU is supported.
-- 
2.18.0.rc1.1.g3f1ff2140
