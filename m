Received: from eggs.gnu.org ([2001:4830:134:3::10]:43459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFM-0005Hh-Gy
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFF-0003il-V5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:29 +1100
Message-Id: <20181108121646.26173-6-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/22] hw/ppc/spapr_rng: Introduce
 CONFIG_SPAPR_RNG switch for spapr_rng.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The spapr-rng device is suboptimal when compared to virtio-rng, so
users might want to disable it in their builds. Thus let's introduce
a proper CONFIG switch to allow us to compile QEMU without this device.
The function spapr_rng_populate_dt is required for linking, so move it
to a different location.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc64-softmmu.mak |  1 +
 hw/ppc/Makefile.objs              |  3 ++-
 hw/ppc/spapr.c                    | 23 +++++++++++++++++++++++
 hw/ppc/spapr_rng.c                | 23 -----------------------
 include/hw/ppc/spapr.h            |  2 --
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index f550573782..aec2855750 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -18,3 +18,4 @@ CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
 CONFIG_MEM_DEVICE=3Dy
 CONFIG_DIMM=3Dy
+CONFIG_SPAPR_RNG=3Dy
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 4ab5564672..4e0c1c0941 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -3,8 +3,9 @@ obj-y +=3D ppc.o ppc_booke.o fdt.o
 # IBM pSeries (sPAPR)
 obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
.o
 obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
-obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
.o
+obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
+obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c08130facb..e47b004b61 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -610,6 +610,29 @@ static void spapr_populate_cpus_dt_node(void *fdt, s=
PAPRMachineState *spapr)
     g_free(rev);
 }
=20
+static int spapr_rng_populate_dt(void *fdt)
+{
+    int node;
+    int ret;
+
+    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
+    if (node <=3D 0) {
+        return -1;
+    }
+    ret =3D fdt_setprop_string(fdt, node, "device_type",
+                             "ibm,platform-facilities");
+    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
+    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
+
+    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
+    if (node <=3D 0) {
+        return -1;
+    }
+    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,random");
+
+    return ret ? -1 : 0;
+}
+
 static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_=
t addr)
 {
     MemoryDeviceInfoList *info;
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index d2acd61a15..644bac96f8 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -132,29 +132,6 @@ static void spapr_rng_realize(DeviceState *dev, Erro=
r **errp)
     }
 }
=20
-int spapr_rng_populate_dt(void *fdt)
-{
-    int node;
-    int ret;
-
-    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
-    if (node <=3D 0) {
-        return -1;
-    }
-    ret =3D fdt_setprop_string(fdt, node, "device_type",
-                             "ibm,platform-facilities");
-    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
-    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
-
-    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
-    if (node <=3D 0) {
-        return -1;
-    }
-    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,random");
-
-    return ret ? -1 : 0;
-}
-
 static Property spapr_rng_properties[] =3D {
     DEFINE_PROP_BOOL("use-kvm", sPAPRRngState, use_kvm, false),
     DEFINE_PROP_LINK("rng", sPAPRRngState, backend, TYPE_RNG_BACKEND,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ad4d7cfd97..0805ad85a1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -745,8 +745,6 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64=
_t legacy_offset);
=20
 #define TYPE_SPAPR_RNG "spapr-rng"
=20
-int spapr_rng_populate_dt(void *fdt);
-
 #define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
=20
 /*
--=20
2.19.1
