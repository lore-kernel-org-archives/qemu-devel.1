Received: from eggs.gnu.org ([2001:4830:134:3::10]:49982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEf-0005Su-9n
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEd-000476-3Y
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:15 +1000
Message-Id: <20180618035324.19907-20-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/28] pnv_core: Allocate cpu thread objects
 individually
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

Currently, we allocate space for all the cpu objects within a single core
in one big block.  This was copied from an older version of the spapr cod=
e
and requires some ugly pointer manipulation to extract the individual
objects.

This design was due to a misunderstanding of qemu lifetime conventions an=
d
has already been changed in spapr (in 94ad93bd "spapr_cpu_core: instantia=
te
CPUs separately".

Make an equivalent change in pnv_core to get rid of the nasty pointer
arithmetic.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c              |  4 ++--
 hw/ppc/pnv_core.c         | 11 +++++------
 include/hw/ppc/pnv_core.h |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0314881316..0b9508d94d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -121,9 +121,9 @@ static int get_cpus_node(void *fdt)
  */
 static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 {
-    CPUState *cs =3D CPU(DEVICE(pc->threads));
+    PowerPCCPU *cpu =3D pc->threads[0];
+    CPUState *cs =3D CPU(cpu);
     DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
     int smt_threads =3D CPU_CORE(pc)->nr_threads;
     CPUPPCState *env =3D &cpu->env;
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 01f47c8037..1e40f01e98 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -151,7 +151,6 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     PnvCore *pc =3D PNV_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(OBJECT(dev));
     const char *typename =3D pnv_core_cpu_typename(pc);
-    size_t size =3D object_type_get_instance_size(typename);
     Error *local_err =3D NULL;
     void *obj;
     int i, j;
@@ -165,11 +164,11 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
=20
-    pc->threads =3D g_malloc0(size * cc->nr_threads);
+    pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
-        obj =3D pc->threads + i * size;
+        obj =3D object_new(typename);
=20
-        object_initialize(obj, size, typename);
+        pc->threads[i] =3D POWERPC_CPU(obj);
=20
         snprintf(name, sizeof(name), "thread[%d]", i);
         object_property_add_child(OBJECT(pc), name, obj, &error_abort);
@@ -179,7 +178,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     }
=20
     for (j =3D 0; j < cc->nr_threads; j++) {
-        obj =3D pc->threads + j * size;
+        obj =3D OBJECT(pc->threads[j]);
=20
         pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
         if (local_err) {
@@ -194,7 +193,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
=20
 err:
     while (--i >=3D 0) {
-        obj =3D pc->threads + i * size;
+        obj =3D OBJECT(pc->threads[i]);
         object_unparent(obj);
     }
     g_free(pc->threads);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index e337af7a3a..447ae761f7 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -34,7 +34,7 @@ typedef struct PnvCore {
     CPUCore parent_obj;
=20
     /*< public >*/
-    void *threads;
+    PowerPCCPU **threads;
     uint32_t pir;
=20
     MemoryRegion xscom_regs;
--=20
2.17.1
