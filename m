Received: from eggs.gnu.org ([209.51.188.92]:53052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1aQ1-0001PU-QE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1aQ1-0006z3-1M
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:33:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1h1aQ0-0006yi-R5
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:33:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14B4D81DFF
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 17:33:24 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  6 Mar 2019 18:33:25 +0100
Message-Id: <1551893605-236413-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2] numa: warn if numa 'mem' option or default
 RAM splitting between nodes is used.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, libvir-list@redhat.com, berrange@redhat.com, eblake@redhat.com

Amend -numa option docs and print warnings if 'mem' option or default RAM
splitting between nodes is used. It's intended to discourage users from using
configuration that allows only to fake NUMA on guest side while leading
to reduced performance of the guest due to inability to properly configure
VM's RAM on the host.

In NUMA case, it's recommended to always explicitly configure guest RAM
using -numa node,memdev={backend-id} option.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c          |  5 +++++
 qemu-options.hx | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/numa.c b/numa.c
index 3875e1e..42838f9 100644
--- a/numa.c
+++ b/numa.c
@@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
 
     if (node->has_mem) {
         numa_info[nodenr].node_mem = node->mem;
+        warn_report("Parameter -numa node,mem is obsolete,"
+                    " use -numa node,memdev instead");
     }
     if (node->has_memdev) {
         Object *o;
@@ -407,6 +409,9 @@ void numa_complete_configuration(MachineState *ms)
         if (i == nb_numa_nodes) {
             assert(mc->numa_auto_assign_ram);
             mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
+            warn_report("Default splitting of RAM between nodes is obsolete,"
+                        " Use '-numa node,memdev' to explicitly define RAM"
+                        " allocation per node");
         }
 
         numa_total = 0;
diff --git a/qemu-options.hx b/qemu-options.hx
index 1cf9aac..61035cb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -206,10 +206,14 @@ For example:
 -numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
 @end example
 
-@samp{mem} assigns a given RAM amount to a node. @samp{memdev}
-assigns RAM from a given memory backend device to a node. If
-@samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
-split equally between them.
+@samp{memdev} assigns RAM from a given memory backend device to a node.
+
+Legacy options/behaviour: @samp{mem} assigns a given RAM amount to a node.
+If @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is split equally
+between them. Option @samp{mem} and default RAM splitting are obsolete as they
+do not provide means to manage RAM on the host side and only allow QEMU to fake
+NUMA support which in practice could degrade VM performance.
+It's advised to always explicitly configure NUMA RAM by using the @samp{memdev} option.
 
 @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
 if one node uses @samp{memdev}, all of them have to use it.
-- 
2.7.4
