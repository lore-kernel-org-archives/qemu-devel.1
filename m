Received: from eggs.gnu.org ([2001:4830:134:3::10]:53413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixS-0003iB-0M
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixQ-0004n7-2U
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:33 +1100
Message-Id: <20171215055435.24204-23-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/24] spapr: Rename machine init functions for
 clarity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Machine objects have two init functions - the generic QOM level
instance_init which should only do static object initialization, and
the Machine specific MachineClass::init which does the actual
construction of the machine.

In spapr the functions implementing these two have names -
ppc_machine_initfn() and ppc_spapr_init() - which don't correspond closel=
y
to either of those.  To prevent people (read, me) from confusing which is
which, rename them spapr_instance_init() and spapr_machine_init() to
make it clearer which is which.

While we're there rename ppc_spapr_reset() to spapr_machine_reset() to
match.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 306875e123..42d6a2302a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1454,7 +1454,7 @@ static int spapr_reset_drcs(Object *child, void *op=
aque)
     return 0;
 }
=20
-static void ppc_spapr_reset(void)
+static void spapr_machine_reset(void)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
@@ -2292,7 +2292,7 @@ out:
 }
=20
 /* pSeries LPAR / sPAPR hardware init */
-static void ppc_spapr_init(MachineState *machine)
+static void spapr_machine_init(MachineState *machine)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
@@ -2820,7 +2820,7 @@ static void spapr_set_vsmt(Object *obj, Visitor *v,=
 const char *name,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
=20
-static void spapr_machine_initfn(Object *obj)
+static void spapr_instance_init(Object *obj)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
@@ -3777,8 +3777,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
      * functions for the specific versioned machine types can override
      * these details for backwards compatibility
      */
-    mc->init =3D ppc_spapr_init;
-    mc->reset =3D ppc_spapr_reset;
+    mc->init =3D spapr_machine_init;
+    mc->reset =3D spapr_machine_reset;
     mc->block_default_type =3D IF_SCSI;
     mc->max_cpus =3D 1024;
     mc->no_parallel =3D 1;
@@ -3825,7 +3825,7 @@ static const TypeInfo spapr_machine_info =3D {
     .parent        =3D TYPE_MACHINE,
     .abstract      =3D true,
     .instance_size =3D sizeof(sPAPRMachineState),
-    .instance_init =3D spapr_machine_initfn,
+    .instance_init =3D spapr_instance_init,
     .instance_finalize =3D spapr_machine_finalizefn,
     .class_size    =3D sizeof(sPAPRMachineClass),
     .class_init    =3D spapr_machine_class_init,
--=20
2.14.3
