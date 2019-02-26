Received: from eggs.gnu.org ([209.51.188.92]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkr-000528-Rp
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkp-0002V2-Eb
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:45 +1100
Message-Id: <20190226045304.25618-32-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/50] spapr: Generate FDT fragment for CPUs at
 configure connector time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059666839.1466090.3833376527523126752.stgit@bahia.lab.tou=
louse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 52 +++++++++++++++++++-----------------------
 hw/ppc/spapr_drc.c     |  1 +
 include/hw/ppc/spapr.h |  2 ++
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b92deee771..6cf7a9f5c1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3636,27 +3636,6 @@ out:
     error_propagate(errp, local_err);
 }
=20
-static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset=
,
-                                           sPAPRMachineState *spapr)
-{
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
-    int id =3D spapr_get_vcpu_id(cpu);
-    void *fdt;
-    int offset, fdt_size;
-    char *nodename;
-
-    fdt =3D create_device_tree(&fdt_size);
-    nodename =3D g_strdup_printf("%s@%x", dc->fw_name, id);
-    offset =3D fdt_add_subnode(fdt, 0, nodename);
-
-    spapr_populate_cpu_dt(cs, fdt, offset, spapr);
-    g_free(nodename);
-
-    *fdt_offset =3D offset;
-    return fdt;
-}
-
 /* Callback to be called during DRC release. */
 void spapr_core_release(DeviceState *dev)
 {
@@ -3717,6 +3696,27 @@ void spapr_core_unplug_request(HotplugHandler *hot=
plug_dev, DeviceState *dev,
     spapr_hotplug_req_remove_by_index(drc);
 }
=20
+int spapr_core_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spa=
pr,
+                           void *fdt, int *fdt_start_offset, Error **err=
p)
+{
+    sPAPRCPUCore *core =3D SPAPR_CPU_CORE(drc->dev);
+    CPUState *cs =3D CPU(core->threads[0]);
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
+    int id =3D spapr_get_vcpu_id(cpu);
+    char *nodename;
+    int offset;
+
+    nodename =3D g_strdup_printf("%s@%x", dc->fw_name, id);
+    offset =3D fdt_add_subnode(fdt, 0, nodename);
+    g_free(nodename);
+
+    spapr_populate_cpu_dt(cs, fdt, offset, spapr);
+
+    *fdt_start_offset =3D offset;
+    return 0;
+}
+
 static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *de=
v,
                             Error **errp)
 {
@@ -3725,7 +3725,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     sPAPRCPUCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(dev);
-    CPUState *cs =3D CPU(core->threads[0]);
+    CPUState *cs;
     sPAPRDRConnector *drc;
     Error *local_err =3D NULL;
     CPUArchId *core_slot;
@@ -3744,14 +3744,8 @@ static void spapr_core_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
     g_assert(drc || !mc->has_hotpluggable_cpus);
=20
     if (drc) {
-        void *fdt;
-        int fdt_offset;
-
-        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
-
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
+        spapr_drc_attach(drc, dev, NULL, 0, &local_err);
         if (local_err) {
-            g_free(fdt);
             error_propagate(errp, local_err);
             return;
         }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 634c28695a..aa26aa40be 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -680,6 +680,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, =
void *data)
     drck->typename =3D "CPU";
     drck->drc_name_prefix =3D "CPU ";
     drck->release =3D spapr_core_release;
+    drck->dt_populate =3D spapr_core_dt_populate;
 }
=20
 static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0ec309da49..5e3c760725 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -766,6 +766,8 @@ int spapr_max_server_number(sPAPRMachineState *spapr)=
;
=20
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
+int spapr_core_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spa=
pr,
+                           void *fdt, int *fdt_start_offset, Error **err=
p);
 void spapr_lmb_release(DeviceState *dev);
 int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
                           void *fdt, int *fdt_start_offset, Error **errp=
);
--=20
2.20.1
