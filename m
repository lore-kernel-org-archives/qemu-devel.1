Received: from eggs.gnu.org ([2001:4830:134:3::10]:41137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7dL-0007c9-QN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7dH-0002bm-H9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 16:21:41 +1000
Message-Id: <20180503062145.17899-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180503062145.17899-1-david@gibson.dropbear.id.au>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/8] spapr: Make a helper to set up cpu entry
 point state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

Under PAPR, only the boot CPU is active when the system starts.  Other cp=
us
must be explicitly activated using an RTAS call.  The entry state for the
boot and secondary cpus isn't identical, but it has some things in common=
.
We're going to add a bit more common setup later, too, so to simplify
make a helper which sets up the common entry state for both boot and
secondary cpu threads.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c                  | 4 +---
 hw/ppc/spapr_cpu_core.c         | 9 +++++++++
 hw/ppc/spapr_rtas.c             | 6 ++----
 include/hw/ppc/spapr_cpu_core.h | 3 +++
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b35aff5d81..944bee7a71 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1668,10 +1668,8 @@ static void spapr_machine_reset(void)
     g_free(fdt);
=20
     /* Set up the entry state */
-    first_ppc_cpu->env.gpr[3] =3D fdt_addr;
+    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr=
);
     first_ppc_cpu->env.gpr[5] =3D 0;
-    first_cpu->halted =3D 0;
-    first_ppc_cpu->env.nip =3D SPAPR_ENTRY_POINT;
=20
     spapr->cas_reboot =3D false;
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 01dbc69424..a98c7b04c6 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -52,6 +52,15 @@ static void spapr_cpu_reset(void *opaque)
=20
 }
=20
+void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    env->nip =3D nip;
+    env->gpr[3] =3D r3;
+    CPU(cpu)->halted =3D 0;
+}
+
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
 {
     qemu_unregister_reset(spapr_cpu_reset, cpu);
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index df073447c5..840d198a8d 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -37,6 +37,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/ppc/spapr_rtas.h"
+#include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/ppc.h"
 #include "hw/boards.h"
=20
@@ -173,10 +174,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAP=
RMachineState *spapr,
      */
     newcpu->env.tb_env->tb_offset =3D callcpu->env.tb_env->tb_offset;
=20
-    env->nip =3D start;
-    env->gpr[3] =3D r3;
-
-    CPU(newcpu)->halted =3D 0;
+    spapr_cpu_set_entry_state(newcpu, start, r3);
=20
     qemu_cpu_kick(CPU(newcpu));
=20
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 1129f344aa..47dcfda12b 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -12,6 +12,7 @@
 #include "hw/qdev.h"
 #include "hw/cpu/core.h"
 #include "target/ppc/cpu-qom.h"
+#include "target/ppc/cpu.h"
=20
 #define TYPE_SPAPR_CPU_CORE "spapr-cpu-core"
 #define SPAPR_CPU_CORE(obj) \
@@ -38,4 +39,6 @@ typedef struct sPAPRCPUCoreClass {
 } sPAPRCPUCoreClass;
=20
 const char *spapr_get_cpu_core_type(const char *cpu_type);
+void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3);
+
 #endif
--=20
2.17.0
