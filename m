Received: from eggs.gnu.org ([209.51.188.92]:43573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg40-0002OC-EY
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg3y-0007KN-S9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:58:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gtg3y-00074i-Jq
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:57:58 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 12 Feb 2019 22:48:27 +0100
Message-Id: <20190212214827.30543-5-lvivier@redhat.com>
In-Reply-To: <20190212214827.30543-1-lvivier@redhat.com>
References: <20190212214827.30543-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 4/4] numa: check threads of the same core are on
 the same node
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

A core cannot be split between two nodes.
To check if a thread of the same core has already been assigned to a node=
,
this patch reverses the numa topology checking order and exits if the
topology is not valid.

Update test/numa-test accordingly.

Fixes: 722387e78daf ("spapr: get numa node mapping from possible_cpus ins=
tead of numa_get_node_for_cpu()")
Cc: imammedo@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/core/machine.c | 27 ++++++++++++++++++++++++---
 tests/numa-test.c |  4 ++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a2c29692b55e..c0a556b0dce7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -602,6 +602,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     bool match =3D false;
     int i;
+    const CpuInstanceProperties *previous_props =3D NULL;
=20
     if (!mc->possible_cpu_arch_ids) {
         error_setg(errp, "mapping of CPUs to NUMA node is not supported"=
);
@@ -634,18 +635,38 @@ void machine_set_cpu_numa_node(MachineState *machin=
e,
         }
=20
         /* skip slots with explicit mismatch */
-        if (props->has_thread_id && props->thread_id !=3D slot->props.th=
read_id) {
+        if (props->has_socket_id && props->socket_id !=3D slot->props.so=
cket_id) {
                 continue;
         }
=20
-        if (props->has_core_id && props->core_id !=3D slot->props.core_i=
d) {
+        if (props->has_core_id) {
+            if (props->core_id !=3D slot->props.core_id) {
                 continue;
+            }
+            if (slot->props.has_node_id) {
+                /* we have a node where our core is already assigned */
+                previous_props =3D &slot->props;
+            }
         }
=20
-        if (props->has_socket_id && props->socket_id !=3D slot->props.so=
cket_id) {
+        if (props->has_thread_id && props->thread_id !=3D slot->props.th=
read_id) {
                 continue;
         }
=20
+        /* check current thread matches node of the thread of the same c=
ore */
+        if (previous_props && previous_props->has_node_id &&
+            previous_props->node_id !=3D props->node_id) {
+            char *cpu_str =3D cpu_props_to_string(props);
+            char *node_str =3D cpu_props_to_string(previous_props);
+            error_setg(errp,  "Invalid node-id=3D%"PRIu64" of [%s]: core=
-id "
+                              "[%s] is already assigned to node-id %"PRI=
u64,
+                              props->node_id, cpu_str,
+                              node_str, previous_props->node_id);
+            g_free(cpu_str);
+            g_free(node_str);
+            return;
+        }
+
         /* reject assignment if slot is already assigned, for compatibil=
ity
          * of legacy cpu_index mapping with SPAPR core based mapping do =
not
          * error out if cpu thread and matched core have the same node-i=
d */
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 5280573fc992..a7c3c5b4dee8 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -112,7 +112,7 @@ static void pc_numa_cpu(const void *data)
         "-numa cpu,node-id=3D1,socket-id=3D0 "
         "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D0 "
         "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D1,thread-id=3D0 "
-        "-numa cpu,node-id=3D1,socket-id=3D1,core-id=3D1,thread-id=3D1")=
;
+        "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D1,thread-id=3D1")=
;
     qtest_start(cli);
     cpus =3D get_cpus(&resp);
     g_assert(cpus);
@@ -141,7 +141,7 @@ static void pc_numa_cpu(const void *data)
         } else if (socket =3D=3D 1 && core =3D=3D 1 && thread =3D=3D 0) =
{
             g_assert_cmpint(node, =3D=3D, 0);
         } else if (socket =3D=3D 1 && core =3D=3D 1 && thread =3D=3D 1) =
{
-            g_assert_cmpint(node, =3D=3D, 1);
+            g_assert_cmpint(node, =3D=3D, 0);
         } else {
             g_assert(false);
         }
--=20
2.20.1
