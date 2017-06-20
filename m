Received: from eggs.gnu.org ([2001:4830:134:3::10]:45239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITF-0004KQ-8c
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT9-0002EI-Gg
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT9-0002Cg-4G
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D7BF624DA
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:49 +0200
Message-Id: <1497962468-22936-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 22/41] pc-dimm: make "size" property uint64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This carries the memory_region_size() value without implicit cast.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-23-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/acpi/memory_hotplug.c |  5 +++--
 hw/acpi/nvdimm.c         |  8 ++++----
 hw/mem/pc-dimm.c         | 18 +++++++++---------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index d2a9656..cda2c9d 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -92,11 +92,12 @@ static uint64_t acpi_memory_hotplug_read(void *opaque=
, hwaddr addr,
         trace_mhp_acpi_read_addr_hi(mem_st->selector, val);
         break;
     case 0x8: /* Lo part of DIMM size */
-        val =3D o ? object_property_get_int(o, PC_DIMM_SIZE_PROP, NULL) =
: 0;
+        val =3D o ? object_property_get_uint(o, PC_DIMM_SIZE_PROP, NULL)=
 : 0;
         trace_mhp_acpi_read_size_lo(mem_st->selector, val);
         break;
     case 0xc: /* Hi part of DIMM size */
-        val =3D o ? object_property_get_int(o, PC_DIMM_SIZE_PROP, NULL) =
>> 32 : 0;
+        val =3D
+            o ? object_property_get_uint(o, PC_DIMM_SIZE_PROP, NULL) >> =
32 : 0;
         trace_mhp_acpi_read_size_hi(mem_st->selector, val);
         break;
     case 0x10: /* node proximity for _PXM method */
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index f507b49..6ceea19 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -238,8 +238,8 @@ nvdimm_build_structure_spa(GArray *structures, Device=
State *dev)
     NvdimmNfitSpa *nfit_spa;
     uint64_t addr =3D object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR=
_PROP,
                                              NULL);
-    uint64_t size =3D object_property_get_int(OBJECT(dev), PC_DIMM_SIZE_=
PROP,
-                                            NULL);
+    uint64_t size =3D object_property_get_uint(OBJECT(dev), PC_DIMM_SIZE=
_PROP,
+                                             NULL);
     uint32_t node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE=
_PROP,
                                              NULL);
     int slot =3D object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
@@ -284,8 +284,8 @@ static void
 nvdimm_build_structure_memdev(GArray *structures, DeviceState *dev)
 {
     NvdimmNfitMemDev *nfit_memdev;
-    uint64_t size =3D object_property_get_int(OBJECT(dev), PC_DIMM_SIZE_=
PROP,
-                                            NULL);
+    uint64_t size =3D object_property_get_uint(OBJECT(dev), PC_DIMM_SIZE=
_PROP,
+                                             NULL);
     int slot =3D object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
                                             NULL);
     uint32_t handle =3D nvdimm_slot_to_handle(slot);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index f6def8c..b72258e 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -136,7 +136,7 @@ static int pc_existing_dimms_capacity_internal(Object=
 *obj, void *opaque)
         DeviceState *dev =3D DEVICE(obj);
=20
         if (dev->realized) {
-            (*size) +=3D object_property_get_int(obj, PC_DIMM_SIZE_PROP,
+            (*size) +=3D object_property_get_uint(obj, PC_DIMM_SIZE_PROP=
,
                 cap->errp);
         }
=20
@@ -182,8 +182,8 @@ int qmp_pc_dimm_device_list(Object *obj, void *opaque=
)
             di->addr =3D dimm->addr;
             di->slot =3D dimm->slot;
             di->node =3D dimm->node;
-            di->size =3D object_property_get_int(OBJECT(dimm), PC_DIMM_S=
IZE_PROP,
-                                               NULL);
+            di->size =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_=
SIZE_PROP,
+                                                NULL);
             di->memdev =3D object_get_canonical_path(OBJECT(dimm->hostme=
m));
=20
             info->u.dimm.data =3D di;
@@ -314,9 +314,9 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space=
_start,
     /* find address range that will fit new DIMM */
     for (item =3D list; item; item =3D g_slist_next(item)) {
         PCDIMMDevice *dimm =3D item->data;
-        uint64_t dimm_size =3D object_property_get_int(OBJECT(dimm),
-                                                     PC_DIMM_SIZE_PROP,
-                                                     errp);
+        uint64_t dimm_size =3D object_property_get_uint(OBJECT(dimm),
+                                                      PC_DIMM_SIZE_PROP,
+                                                      errp);
         if (errp && *errp) {
             goto out;
         }
@@ -356,7 +356,7 @@ static Property pc_dimm_properties[] =3D {
 static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    int64_t value;
+    uint64_t value;
     MemoryRegion *mr;
     PCDIMMDevice *dimm =3D PC_DIMM(obj);
     PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(obj);
@@ -364,7 +364,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v,=
 const char *name,
     mr =3D ddc->get_memory_region(dimm);
     value =3D memory_region_size(mr);
=20
-    visit_type_int(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
=20
 static void pc_dimm_check_memdev_is_busy(Object *obj, const char *name,
@@ -387,7 +387,7 @@ static void pc_dimm_init(Object *obj)
 {
     PCDIMMDevice *dimm =3D PC_DIMM(obj);
=20
-    object_property_add(obj, PC_DIMM_SIZE_PROP, "int", pc_dimm_get_size,
+    object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", pc_dimm_get_si=
ze,
                         NULL, NULL, NULL, &error_abort);
     object_property_add_link(obj, PC_DIMM_MEMDEV_PROP, TYPE_MEMORY_BACKE=
ND,
                              (Object **)&dimm->hostmem,
--=20
2.7.5
