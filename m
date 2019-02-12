Received: from eggs.gnu.org ([209.51.188.92]:42604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg10-0000Xd-GR
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gtg0z-0003W5-1q
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:54:54 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 12 Feb 2019 22:48:24 +0100
Message-Id: <20190212214827.30543-2-lvivier@redhat.com>
In-Reply-To: <20190212214827.30543-1-lvivier@redhat.com>
References: <20190212214827.30543-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 1/4] numa,
 spapr: add thread-id in the possible_cpus list
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

spapr_possible_cpu_arch_ids() counts only cores, and so
the number of available CPUs is the number of vCPU divided
by smp_threads.

... -smp 4,maxcpus=3D8,cores=3D2,threads=3D2,sockets=3D2 -numa node,cpus=3D=
0,cpus=3D1 \
                                                 -numa node,cpus=3D3,cpus=
=3D4 \
                                                 -numa node -numa node

This generates (info hotpluggable-cpus)

  node-id: 0 core-id: 0 thread-id: 0 [thread-id: 1]
  node-id: 0 core-id: 6 thread-id: 0 [thread-id: 1]
  node-id: 1 core-id: 2 thread-id: 0 [thread-id: 1]
  node-id: 1 core-id: 4 thread-id: 0 [thread-id: 1]

And this command line generates the following error:

  CPU(s) not present in any NUMA nodes: CPU 3 [core-id: 6]

That is wrong because CPU 3 [core-id: 6] is assigned to node-id 0
Moreover "cpus=3D4" is not valid, because it means core-id 8 but
maxcpus is 8.

With this patch we have now:

  node-id: 0 core-id: 0 thread-id: 0
  node-id: 0 core-id: 0 thread-id: 1
  node-id: 0 core-id: 1 thread-id: 0
  node-id: 1 core-id: 1 thread-id: 1
  node-id: 0 core-id: 2 thread-id: 1
  node-id: 1 core-id: 2 thread-id: 0
  node-id: 0 core-id: 3 thread-id: 1
  node-id: 0 core-id: 3 thread-id: 0

CPUs 0 (core-id: 0 thread-id: 0) and 1 (core-id: 0 thread-id: 1) are
correctly assigned to node-id 0, CPUs 3 (core-id: 1 thread-id: 1) and
 4 (core-id: 2 thread-id: 0) are correctly assigned to node-id 1.
All other CPUs are assigned to node-id 0 by default.

And the error message is also correct:

  CPU(s) not present in any NUMA nodes: CPU 2 [core-id: 1, thread-id: 0],=
 \
                                        CPU 5 [core-id: 2, thread-id: 1],=
 \
                                        CPU 6 [core-id: 3, thread-id: 0],=
 \
                                        CPU 7 [core-id: 3, thread-id: 1]

Fixes: ec78f8114bc4 ("numa: use possible_cpus for not mapped CPUs check")
Cc: imammedo@redhat.com

Before commit ec78f8114bc4, output was correct:

  CPU(s) not present in any NUMA nodes: 2 5 6 7

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 332cba89d425..7196ba09da34 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2404,15 +2404,13 @@ static void spapr_validate_node_memory(MachineSta=
te *machine, Error **errp)
 /* find cpu slot in machine->possible_cpus by core_id */
 static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int=
 *idx)
 {
-    int index =3D id / smp_threads;
-
-    if (index >=3D ms->possible_cpus->len) {
+    if (id >=3D ms->possible_cpus->len) {
         return NULL;
     }
     if (idx) {
-        *idx =3D index;
+        *idx =3D id;
     }
-    return &ms->possible_cpus->cpus[index];
+    return &ms->possible_cpus->cpus[id];
 }
=20
 static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
@@ -2514,7 +2512,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
             error_report("This machine version does not support CPU hotp=
lug");
             exit(1);
         }
-        boot_cores_nr =3D possible_cpus->len;
+        boot_cores_nr =3D possible_cpus->len / smp_threads;
     }
=20
     if (smc->pre_2_10_has_unused_icps) {
@@ -2528,7 +2526,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
         }
     }
=20
-    for (i =3D 0; i < possible_cpus->len; i++) {
+    for (i =3D 0; i < possible_cpus->len / smp_threads; i++) {
         int core_id =3D i * smp_threads;
=20
         if (mc->has_hotpluggable_cpus) {
@@ -3795,21 +3793,16 @@ spapr_cpu_index_to_props(MachineState *machine, u=
nsigned cpu_index)
=20
 static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int=
 idx)
 {
-    return idx / smp_cores % nb_numa_nodes;
+    return idx / (smp_cores * smp_threads) % nb_numa_nodes;
 }
=20
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *ma=
chine)
 {
     int i;
     const char *core_type;
-    int spapr_max_cores =3D max_cpus / smp_threads;
-    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
=20
-    if (!mc->has_hotpluggable_cpus) {
-        spapr_max_cores =3D QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_t=
hreads;
-    }
     if (machine->possible_cpus) {
-        assert(machine->possible_cpus->len =3D=3D spapr_max_cores);
+        assert(machine->possible_cpus->len =3D=3D max_cpus);
         return machine->possible_cpus;
     }
=20
@@ -3820,16 +3813,16 @@ static const CPUArchIdList *spapr_possible_cpu_ar=
ch_ids(MachineState *machine)
     }
=20
     machine->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
-                             sizeof(CPUArchId) * spapr_max_cores);
-    machine->possible_cpus->len =3D spapr_max_cores;
+                             sizeof(CPUArchId) * max_cpus);
+    machine->possible_cpus->len =3D max_cpus;
     for (i =3D 0; i < machine->possible_cpus->len; i++) {
-        int core_id =3D i * smp_threads;
-
         machine->possible_cpus->cpus[i].type =3D core_type;
         machine->possible_cpus->cpus[i].vcpus_count =3D smp_threads;
-        machine->possible_cpus->cpus[i].arch_id =3D core_id;
+        machine->possible_cpus->cpus[i].arch_id =3D i;
         machine->possible_cpus->cpus[i].props.has_core_id =3D true;
-        machine->possible_cpus->cpus[i].props.core_id =3D core_id;
+        machine->possible_cpus->cpus[i].props.core_id =3D i / smp_thread=
s;
+        machine->possible_cpus->cpus[i].props.has_thread_id =3D true;
+        machine->possible_cpus->cpus[i].props.thread_id =3D i % smp_thre=
ads;
     }
     return machine->possible_cpus;
 }
--=20
2.20.1
