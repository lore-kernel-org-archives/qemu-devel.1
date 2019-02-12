Received: from eggs.gnu.org ([209.51.188.92]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg24-0001Bn-J0
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg1z-00052G-H1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:55:59 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 12 Feb 2019 22:48:25 +0100
Message-Id: <20190212214827.30543-3-lvivier@redhat.com>
In-Reply-To: <20190212214827.30543-1-lvivier@redhat.com>
References: <20190212214827.30543-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 2/4] numa: exit on incomplete CPU mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>

Change the existing message to an error and exit.

This message was a warning and comes with the information
it will be removed in the future since May 10 2017
(ec78f8114bc4 "numa: use possible_cpus for not mapped CPUs check").

Update tests/numa-test to remove the incomplete CPU mapping test.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/core/machine.c | 46 +++++++++++++++++++++-------------------------
 tests/numa-test.c | 20 --------------------
 2 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 077fbd182adf..7c74b318f635 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -873,51 +873,47 @@ static char *cpu_slot_to_string(const CPUArchId *cp=
u)
 static void machine_numa_finish_cpu_init(MachineState *machine)
 {
     int i;
-    bool default_mapping;
+    bool default_mapping =3D true;
     GString *s =3D g_string_new(NULL);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(mac=
hine);
+    const CPUArchId *cpu_slot;
=20
     assert(nb_numa_nodes);
     for (i =3D 0; i < possible_cpus->len; i++) {
-        if (possible_cpus->cpus[i].props.has_node_id) {
-            break;
+        cpu_slot =3D &possible_cpus->cpus[i];
+
+        if (cpu_slot->props.has_node_id) {
+            default_mapping =3D false;
+        } else {
+            /* record slots with not set mapping, */
+            char *cpu_str =3D cpu_slot_to_string(cpu_slot);
+            g_string_append_printf(s, "%sCPU %d [%s]",
+                                   s->len ? ", " : "", i, cpu_str);
+            g_free(cpu_str);
         }
     }
-    default_mapping =3D (i =3D=3D possible_cpus->len);
+    if (!default_mapping && s->len && !qtest_enabled()) {
+        error_report("CPU(s) not present in any NUMA nodes: %s", s->str)=
;
+        error_report("All CPU(s) up to maxcpus must be described "
+                    "in NUMA config");
+        g_string_free(s, true);
+        exit(1);
+    }
+    g_string_free(s, true);
=20
     for (i =3D 0; i < possible_cpus->len; i++) {
-        const CPUArchId *cpu_slot =3D &possible_cpus->cpus[i];
+        cpu_slot =3D &possible_cpus->cpus[i];
=20
         if (!cpu_slot->props.has_node_id) {
             /* fetch default mapping from board and enable it */
             CpuInstanceProperties props =3D cpu_slot->props;
=20
             props.node_id =3D mc->get_default_cpu_node_id(machine, i);
-            if (!default_mapping) {
-                /* record slots with not set mapping,
-                 * TODO: make it hard error in future */
-                char *cpu_str =3D cpu_slot_to_string(cpu_slot);
-                g_string_append_printf(s, "%sCPU %d [%s]",
-                                       s->len ? ", " : "", i, cpu_str);
-                g_free(cpu_str);
-
-                /* non mapped cpus used to fallback to node 0 */
-                props.node_id =3D 0;
-            }
-
             props.has_node_id =3D true;
             machine_set_cpu_numa_node(machine, &props, &error_fatal);
         }
     }
-    if (s->len && !qtest_enabled()) {
-        warn_report("CPU(s) not present in any NUMA nodes: %s",
-                    s->str);
-        warn_report("All CPU(s) up to maxcpus should be described "
-                    "in NUMA config, ability to start up with partial NU=
MA "
-                    "mappings is obsoleted and will be removed in future=
");
-    }
-    g_string_free(s, true);
 }
=20
 void machine_run_board_init(MachineState *machine)
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 9824fdd5875e..5280573fc992 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -55,25 +55,6 @@ static void test_mon_default(const void *data)
     g_free(cli);
 }
=20
-static void test_mon_partial(const void *data)
-{
-    char *s;
-    char *cli;
-
-    cli =3D make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=3D0,cpus=3D0-1 "
-                   "-numa node,nodeid=3D1,cpus=3D4-5 ");
-    qtest_start(cli);
-
-    s =3D hmp("info numa");
-    g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
-    g_assert(strstr(s, "node 1 cpus: 4 5"));
-    g_free(s);
-
-    qtest_end();
-    g_free(cli);
-}
-
 static QList *get_cpus(QDict **resp)
 {
     *resp =3D qmp("{ 'execute': 'query-cpus' }");
@@ -333,7 +314,6 @@ int main(int argc, char **argv)
=20
     qtest_add_data_func("/numa/mon/default", args, test_mon_default);
     qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explic=
it);
-    qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial=
);
     qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cp=
us);
=20
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
--=20
2.20.1
