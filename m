Received: from eggs.gnu.org ([209.51.188.92]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkN4-0004sk-9L
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkIu-0007fr-IZ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:42:29 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri,  1 Mar 2019 16:42:16 +0100
Message-Id: <1551454936-205218-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] numa: deprecate implict memory
 distribution between nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, libvir-list@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

Implict RAM distribution between nodes has exactly the same issues as:
  "numa: deprecate 'mem' parameter of '-numa node' option"
only with QEMU being the user that's 'adding' 'mem' parameter.

Depricate it, to get it out of the way so that we could switch to
consistent guest RAM allocation using memory backends and possibly
memory devices later on top of that.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c               | 3 +++
 qemu-deprecated.texi | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/numa.c b/numa.c
index 2205773..6d45a1f 100644
--- a/numa.c
+++ b/numa.c
@@ -409,6 +409,9 @@ void numa_complete_configuration(MachineState *ms)
         if (i == nb_numa_nodes) {
             assert(mc->numa_auto_assign_ram);
             mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
+            warn_report("Default splitting of RAM between nodes is deprecated,"
+                        " Use '-numa node,memdev' to explictly define RAM"
+                        " allocation per node");
         }
 
         numa_total = 0;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 73f99d4..09bec7d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -74,6 +74,13 @@ parameter @option{mem} to achieve the same fake NUMA effect or a properly
 configured @var{memory-backend-file} backend to actually benefit from NUMA
 configuration.
 
+@subsection -numa node (without memory specified) (since 4.0)
+
+Splitting RAM by default between NUMA nodes has the same issues as @option{mem}
+parameter described above with a difference that role of the user plays QEMU
+using generic splitting rule or a board specific one. Use @option{memdev} with
+@var{memory-backend-ram} backend to define mapping explictly instead.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
-- 
2.7.4
