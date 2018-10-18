Received: from eggs.gnu.org ([2001:4830:134:3::10]:38519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEXZ-0007dt-17
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEXY-0007NI-2E
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:05:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:03:41 -0300
Message-Id: <20181018200422.4358-5-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/45] numa: Fix QMP command set-numa-node error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

From: Markus Armbruster <armbru@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  parse_numa_node() does that, and then exit()s.  It
also passes &error_fatal to machine_set_cpu_numa_node().  Both wrong.
Attempting to configure numa when the machine doesn't support it kills
the VM:

    $ qemu-system-x86_64 -nodefaults -S -display none -M none -preconfig -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 3}, "package": "v3.0.0-837-gc5e4e49258"}, "capabilities": []}}
    {"execute": "qmp_capabilities"}
    {"return": {}}
    {"execute": "set-numa-node", "arguments": {"type": "node"}}
    NUMA is not supported by this machine-type
    $ echo $?
    1

Messed up when commit 64c2a8f6d3f and 7c88e65d9e9 (v2.10.0) added
incorrect error handling right next to correct examples.  Latent bug
until commit f3be67812c2 (v3.0.0) made it accessible via QMP.  Fairly
harmless in practice, because it's limited to RUN_STATE_PRECONFIG.
The fix is obvious: replace error_report(); exit() by error_setg();
return.

This affects parse_numa_node()'s other caller
numa_complete_configuration(): since it ignores errors, the "NUMA is
not supported by this machine-type" is now ignored, too.  But that
error is as unexpected there as any other.  Change it to abort on
error instead.

Fixes: f3be67812c226162f86ce92634bd913714445420
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181008173125.19678-15-armbru@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/numa.c b/numa.c
index 81542d4ebb..1d7c49ad43 100644
--- a/numa.c
+++ b/numa.c
@@ -60,6 +60,7 @@ NodeInfo numa_info[MAX_NODES];
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)
 {
+    Error *err = NULL;
     uint16_t nodenr;
     uint16List *cpus = NULL;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -82,8 +83,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     }
 
     if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
-        error_report("NUMA is not supported by this machine-type");
-        exit(1);
+        error_setg(errp, "NUMA is not supported by this machine-type");
+        return;
     }
     for (cpus = node->cpus; cpus; cpus = cpus->next) {
         CpuInstanceProperties props;
@@ -97,7 +98,11 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         props = mc->cpu_index_to_instance_props(ms, cpus->value);
         props.node_id = nodenr;
         props.has_node_id = true;
-        machine_set_cpu_numa_node(ms, &props, &error_fatal);
+        machine_set_cpu_numa_node(ms, &props, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
     }
 
     if (node->has_mem && node->has_memdev) {
@@ -367,7 +372,7 @@ void numa_complete_configuration(MachineState *ms)
     if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
         mc->auto_enable_numa_with_memhp) {
             NumaNodeOptions node = { };
-            parse_numa_node(ms, &node, NULL);
+            parse_numa_node(ms, &node, &error_abort);
     }
 
     assert(max_numa_nodeid <= MAX_NODES);
-- 
2.18.0.rc1.1.g3f1ff2140
