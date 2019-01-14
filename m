Received: from eggs.gnu.org ([209.51.188.92]:40687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gitzt-0007YU-MM
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gitzq-0002WI-FL
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:15389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1gitzo-0002TQ-16
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:37:09 -0500
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 14 Jan 2019 20:24:56 +0800
Message-Id: <1547468699-17633-3-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel]  [PATCH v1 2/5] vl.c: add -smp,
 dies=* command line support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: like.xu@intel.com, imammedo@redhat.com, drjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This patch updates the check rules on legeacy -smp parse from user command
and it's designed to obey the same restrictions as socket/core/thread model.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hmp.c             |  3 +++
 hw/core/machine.c | 12 ++++++++++++
 vl.c              | 33 ++++++++++++++++++++-------------
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/hmp.c b/hmp.c
index 80aa5ab..05ac133 100644
--- a/hmp.c
+++ b/hmp.c
@@ -3013,6 +3013,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
         if (c->has_socket_id) {
             monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
         }
+        if (c->has_die_id) {
+            monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
+        }
         if (c->has_core_id) {
             monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
         }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 95dc7c3..05bc545 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -601,6 +601,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
             return;
         }
 
+        if (props->has_die_id && !slot->props.has_die_id) {
+            error_setg(errp, "die-id is not supported");
+            return;
+        }
+
         if (props->has_socket_id && !slot->props.has_socket_id) {
             error_setg(errp, "socket-id is not supported");
             return;
@@ -615,6 +620,10 @@ void machine_set_cpu_numa_node(MachineState *machine,
                 continue;
         }
 
+        if (props->has_die_id && props->die_id != slot->props.die_id) {
+                continue;
+        }
+
         if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
                 continue;
         }
@@ -849,6 +858,9 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     if (cpu->props.has_socket_id) {
         g_string_append_printf(s, "socket-id: %"PRId64, cpu->props.socket_id);
     }
+    if (cpu->props.has_die_id) {
+        g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id);
+    }
     if (cpu->props.has_core_id) {
         if (s->len) {
             g_string_append_printf(s, ", ");
diff --git a/vl.c b/vl.c
index 9b8ea3f..72be689 100644
--- a/vl.c
+++ b/vl.c
@@ -169,6 +169,7 @@ int win2k_install_hack = 0;
 int singlestep = 0;
 int smp_cpus;
 unsigned int max_cpus;
+int smp_dies = 1;
 int smp_cores = 1;
 int smp_threads = 1;
 int acpi_enabled = 1;
@@ -1208,6 +1209,9 @@ static QemuOptsList qemu_smp_opts = {
             .name = "sockets",
             .type = QEMU_OPT_NUMBER,
         }, {
+             .name = "dies",
+            .type = QEMU_OPT_NUMBER,
+        }, {
             .name = "cores",
             .type = QEMU_OPT_NUMBER,
         }, {
@@ -1226,32 +1230,34 @@ static void smp_parse(QemuOpts *opts)
     if (opts) {
         unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
         unsigned sockets = qemu_opt_get_number(opts, "sockets", 0);
+        unsigned dies = qemu_opt_get_number(opts, "dies", 0);
         unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
         unsigned threads = qemu_opt_get_number(opts, "threads", 0);
 
         /* compute missing values, prefer sockets over cores over threads */
+        dies = dies > 0 ? dies : 1;
         if (cpus == 0 || sockets == 0) {
             cores = cores > 0 ? cores : 1;
             threads = threads > 0 ? threads : 1;
             if (cpus == 0) {
                 sockets = sockets > 0 ? sockets : 1;
-                cpus = cores * threads * sockets;
+                cpus = cores * threads * dies * sockets;
             } else {
                 max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
-                sockets = max_cpus / (cores * threads);
+                sockets = max_cpus / (cores * threads * dies);
             }
         } else if (cores == 0) {
             threads = threads > 0 ? threads : 1;
-            cores = cpus / (sockets * threads);
+            cores = cpus / (sockets * dies * threads);
             cores = cores > 0 ? cores : 1;
         } else if (threads == 0) {
-            threads = cpus / (cores * sockets);
+            threads = cpus / (cores * dies * sockets);
             threads = threads > 0 ? threads : 1;
-        } else if (sockets * cores * threads < cpus) {
+        } else if (sockets * dies * cores * threads < cpus) {
             error_report("cpu topology: "
-                         "sockets (%u) * cores (%u) * threads (%u) < "
+                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) < "
                          "smp_cpus (%u)",
-                         sockets, cores, threads, cpus);
+                         sockets, dies, cores, threads, cpus);
             exit(1);
         }
 
@@ -1262,22 +1268,23 @@ static void smp_parse(QemuOpts *opts)
             exit(1);
         }
 
-        if (sockets * cores * threads > max_cpus) {
+        if (sockets * dies * cores * threads > max_cpus) {
             error_report("cpu topology: "
-                         "sockets (%u) * cores (%u) * threads (%u) > "
+                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) > "
                          "maxcpus (%u)",
-                         sockets, cores, threads, max_cpus);
+                         sockets, dies, cores, threads, max_cpus);
             exit(1);
         }
 
-        if (sockets * cores * threads != max_cpus) {
+        if (sockets * dies * cores * threads != max_cpus) {
             warn_report("Invalid CPU topology deprecated: "
-                        "sockets (%u) * cores (%u) * threads (%u) "
+                        "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
                         "!= maxcpus (%u)",
-                        sockets, cores, threads, max_cpus);
+                        sockets, dies, cores, threads, max_cpus);
         }
 
         smp_cpus = cpus;
+        smp_dies = dies;
         smp_cores = cores;
         smp_threads = threads;
     }
-- 
1.8.3.1
