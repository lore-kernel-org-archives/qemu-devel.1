Received: from eggs.gnu.org ([2001:4830:134:3::10]:33489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIdza-0000G2-Jh
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIdzX-0008Gv-EV
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:39:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIdzX-0008G2-5t
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:39:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 309676267F
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:39:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 20:36:13 +0400
Message-Id: <20170607163635.17635-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 21/43] pc-dimm: use get_uint() for dimm
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

TYPE_PC_DIMM's property PC_DIMM_ADDR_PROP is defined with
DEFINE_PROP_UINT64().

TYPE_PC_DIMM's property PC_DIMM_NODE_PROP is defined with
DEFINE_PROP_UINT32().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/memory_hotplug.c |  7 ++++---
 hw/acpi/nvdimm.c         | 10 +++++-----
 hw/mem/pc-dimm.c         |  5 +++--
 hw/ppc/spapr.c           |  7 ++++---
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 210073d283..d2a96569ba 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -83,11 +83,12 @@ static uint64_t acpi_memory_hotplug_read(void *opaque=
, hwaddr addr,
     o =3D OBJECT(mdev->dimm);
     switch (addr) {
     case 0x0: /* Lo part of phys address where DIMM is mapped */
-        val =3D o ? object_property_get_int(o, PC_DIMM_ADDR_PROP, NULL) =
: 0;
+        val =3D o ? object_property_get_uint(o, PC_DIMM_ADDR_PROP, NULL)=
 : 0;
         trace_mhp_acpi_read_addr_lo(mem_st->selector, val);
         break;
     case 0x4: /* Hi part of phys address where DIMM is mapped */
-        val =3D o ? object_property_get_int(o, PC_DIMM_ADDR_PROP, NULL) =
>> 32 : 0;
+        val =3D
+            o ? object_property_get_uint(o, PC_DIMM_ADDR_PROP, NULL) >> =
32 : 0;
         trace_mhp_acpi_read_addr_hi(mem_st->selector, val);
         break;
     case 0x8: /* Lo part of DIMM size */
@@ -99,7 +100,7 @@ static uint64_t acpi_memory_hotplug_read(void *opaque,=
 hwaddr addr,
         trace_mhp_acpi_read_size_hi(mem_st->selector, val);
         break;
     case 0x10: /* node proximity for _PXM method */
-        val =3D o ? object_property_get_int(o, PC_DIMM_NODE_PROP, NULL) =
: 0;
+        val =3D o ? object_property_get_uint(o, PC_DIMM_NODE_PROP, NULL)=
 : 0;
         trace_mhp_acpi_read_pxm(mem_st->selector, val);
         break;
     case 0x14: /* pack and return is_* fields */
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec034..e57027149d 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -236,14 +236,14 @@ static void
 nvdimm_build_structure_spa(GArray *structures, DeviceState *dev)
 {
     NvdimmNfitSpa *nfit_spa;
-    uint64_t addr =3D object_property_get_int(OBJECT(dev), PC_DIMM_ADDR_=
PROP,
-                                            NULL);
+    uint64_t addr =3D object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR=
_PROP,
+                                             NULL);
     uint64_t size =3D object_property_get_int(OBJECT(dev), PC_DIMM_SIZE_=
PROP,
                                             NULL);
-    uint32_t node =3D object_property_get_int(OBJECT(dev), PC_DIMM_NODE_=
PROP,
-                                            NULL);
+    uint32_t node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE=
_PROP,
+                                             NULL);
     int slot =3D object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
-                                            NULL);
+                                       NULL);
=20
     nfit_spa =3D acpi_data_push(structures, sizeof(*nfit_spa));
=20
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9e8dab0e89..f6def8c239 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -46,7 +46,8 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplu=
gState *hpms,
     uint64_t existing_dimms_capacity =3D 0;
     uint64_t addr;
=20
-    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
+    addr =3D object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
         goto out;
     }
@@ -73,7 +74,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplu=
gState *hpms,
         goto out;
     }
=20
-    object_property_set_int(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &local=
_err);
+    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &loca=
l_err);
     if (local_err) {
         goto out;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91b4057933..bae26e2a56 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2582,7 +2582,8 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
         goto out;
     }
=20
-    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
+    addr =3D object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
         pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
         goto out;
@@ -2741,7 +2742,7 @@ static void spapr_memory_unplug_request(HotplugHand=
ler *hotplug_dev,
     sPAPRDRConnectorClass *drck;
     sPAPRDIMMState *ds;
=20
-    addr_start =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PR=
OP,
+    addr_start =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_P=
ROP,
                                          &local_err);
     if (local_err) {
         goto out;
@@ -2980,7 +2981,7 @@ static void spapr_machine_device_plug(HotplugHandle=
r *hotplug_dev,
             error_setg(errp, "Memory hotplug not supported for this mach=
ine");
             return;
         }
-        node =3D object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,=
 errp);
+        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP=
, errp);
         if (*errp) {
             return;
         }
--=20
2.13.0.91.g00982b8dd
