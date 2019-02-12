Received: from eggs.gnu.org ([209.51.188.92]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg41-0002P8-OP
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg3z-0007L5-Ac
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:58:01 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 12 Feb 2019 22:48:26 +0100
Message-Id: <20190212214827.30543-4-lvivier@redhat.com>
In-Reply-To: <20190212214827.30543-1-lvivier@redhat.com>
References: <20190212214827.30543-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 3/4] numa: move cpu_slot_to_string() upper in the
 function
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

This will allow to use it in more functions in the future.

As we change the prototype to take directly CpuInstanceProperties
instead of CPUArchId, rename the function to cpu_props_to_string().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/core/machine.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7c74b318f635..a2c29692b55e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -550,6 +550,27 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus=
(MachineState *machine)
     return head;
 }
=20
+static char *cpu_props_to_string(const CpuInstanceProperties *props)
+{
+    GString *s =3D g_string_new(NULL);
+    if (props->has_socket_id) {
+        g_string_append_printf(s, "socket-id: %"PRId64, props->socket_id=
);
+    }
+    if (props->has_core_id) {
+        if (s->len) {
+            g_string_append_printf(s, ", ");
+        }
+        g_string_append_printf(s, "core-id: %"PRId64, props->core_id);
+    }
+    if (props->has_thread_id) {
+        if (s->len) {
+            g_string_append_printf(s, ", ");
+        }
+        g_string_append_printf(s, "thread-id: %"PRId64, props->thread_id=
);
+    }
+    return g_string_free(s, false);
+}
+
 /**
  * machine_set_cpu_numa_node:
  * @machine: machine object to modify
@@ -849,27 +870,6 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
=20
-static char *cpu_slot_to_string(const CPUArchId *cpu)
-{
-    GString *s =3D g_string_new(NULL);
-    if (cpu->props.has_socket_id) {
-        g_string_append_printf(s, "socket-id: %"PRId64, cpu->props.socke=
t_id);
-    }
-    if (cpu->props.has_core_id) {
-        if (s->len) {
-            g_string_append_printf(s, ", ");
-        }
-        g_string_append_printf(s, "core-id: %"PRId64, cpu->props.core_id=
);
-    }
-    if (cpu->props.has_thread_id) {
-        if (s->len) {
-            g_string_append_printf(s, ", ");
-        }
-        g_string_append_printf(s, "thread-id: %"PRId64, cpu->props.threa=
d_id);
-    }
-    return g_string_free(s, false);
-}
-
 static void machine_numa_finish_cpu_init(MachineState *machine)
 {
     int i;
@@ -887,7 +887,7 @@ static void machine_numa_finish_cpu_init(MachineState=
 *machine)
             default_mapping =3D false;
         } else {
             /* record slots with not set mapping, */
-            char *cpu_str =3D cpu_slot_to_string(cpu_slot);
+            char *cpu_str =3D cpu_props_to_string(&cpu_slot->props);
             g_string_append_printf(s, "%sCPU %d [%s]",
                                    s->len ? ", " : "", i, cpu_str);
             g_free(cpu_str);
--=20
2.20.1
