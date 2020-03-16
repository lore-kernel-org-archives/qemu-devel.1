Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22514C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80F0205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVcd7hNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80F0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxZm-0004fu-U9
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHQ-0003JR-33
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHN-0003Ry-1T
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33591)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHM-0003OK-OO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/R61sTatVz2Lj4MOOjZW3heYwaeufU4381IZAwdn8s=;
 b=IVcd7hNXlNXvajk9HPPufuYP0JnLObB5Y6cGZlej1186FPAo7xOBOmsja581NUaSGjQgCv
 HMnhCf+Thu5URYQgFm2ztYJj24L414xwsPrKTLmjZhJWMDtNckscmzf6SgLerizGzgNGyo
 GB+TFhhSJ4sZwJl0wLSpUlvb9ETDh8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-ewirAOkqNOSRrh1goYheIA-1; Mon, 16 Mar 2020 17:28:04 -0400
X-MC-Unique: ewirAOkqNOSRrh1goYheIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23E261005513;
 Mon, 16 Mar 2020 21:28:03 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D0C919C4F;
 Mon, 16 Mar 2020 21:28:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/61] qom/object: enable setter for uint types
Date: Mon, 16 Mar 2020 22:26:44 +0100
Message-Id: <1584394048-44994-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Felipe Franciosi <felipe@nutanix.com>

Traditionally, the uint-specific property helpers only offer getters.
When adding object (or class) uint types, one must therefore use the
generic property helper if a setter is needed (and probably duplicate
some code writing their own getters/setters).

This enhances the uint-specific property helper APIs by adding a
bitwise-or'd 'flags' field and modifying all clients of that API to set
this paramater to OBJ_PROP_FLAG_READ. This maintains the current
behaviour whilst allowing others to also set OBJ_PROP_FLAG_WRITE (or use
the more convenient OBJ_PROP_FLAG_READWRITE) in the future (which will
automatically install a setter). Other flags may be added later.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/ich9.c       |   4 +-
 hw/acpi/pcihp.c      |   7 +-
 hw/acpi/piix4.c      |  12 +--
 hw/isa/lpc_ich9.c    |   4 +-
 hw/ppc/spapr_drc.c   |   3 +-
 include/qom/object.h |  48 ++++++++++--
 qom/object.c         | 212 +++++++++++++++++++++++++++++++++++++++++++++--=
----
 ui/console.c         |   4 +-
 8 files changed, 246 insertions(+), 48 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 4e74284..67fe05a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -454,12 +454,12 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMReg=
s *pm, Error **errp)
     pm->s4_val =3D 2;
=20
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, errp);
+                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ, er=
rp);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, pm, NULL);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, errp);
+                                   &gpe0_len, OBJ_PROP_FLAG_READ, errp);
     object_property_add_bool(obj, "memory-hotplug-support",
                              ich9_pm_get_memory_hotplug_support,
                              ich9_pm_set_memory_hotplug_support,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 8413348..4dcef37 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -80,7 +80,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
=20
         *bus_bsel =3D (*bsel_alloc)++;
         object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                       bus_bsel, &error_abort);
+                                       bus_bsel, OBJ_PROP_FLAG_READ,
+                                       &error_abort);
     }
=20
     return bsel_alloc;
@@ -373,9 +374,9 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, =
PCIBus *root_bus,
     memory_region_add_subregion(address_space_io, s->io_base, &s->io);
=20
     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_=
base,
-                                   &error_abort);
+                                   OBJ_PROP_FLAG_READ, &error_abort);
     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_l=
en,
-                                   &error_abort);
+                                   OBJ_PROP_FLAG_READ, &error_abort);
 }
=20
 const VMStateDescription vmstate_acpi_pcihp_pci_status =3D {
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index b84dbba..964d6f5 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -444,17 +444,17 @@ static void piix4_pm_add_propeties(PIIX4PMState *s)
     static const uint16_t sci_int =3D 9;
=20
     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, NULL);
+                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NU=
LL);
     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD=
,
-                                  &acpi_disable_cmd, NULL);
+                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ, N=
ULL);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, NULL);
+                                  &gpe0_blk, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, NULL);
+                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ, NULL)=
;
     object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, NULL);
+                                  &sci_int, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, NULL);
+                                  &s->io_base, OBJ_PROP_FLAG_READ, NULL);
 }
=20
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index cb79616..d8186f5 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -643,9 +643,9 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc)
                         ich9_lpc_get_sci_int,
                         NULL, NULL, NULL, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CM=
D,
-                                  &acpi_enable_cmd, NULL);
+                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NU=
LL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_C=
MD,
-                                  &acpi_disable_cmd, NULL);
+                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ, N=
ULL);
=20
     ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
 }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index e373d34..47e6bb1 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -583,7 +583,8 @@ static void spapr_dr_connector_instance_init(Object *ob=
j)
     SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(obj);
     SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
-    object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
+    object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ=
,
+                                   NULL);
     object_property_add(obj, "index", "uint32", prop_get_index,
                         NULL, NULL, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
diff --git a/include/qom/object.h b/include/qom/object.h
index 2954649..784c97c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1664,69 +1664,101 @@ ObjectProperty *object_class_property_add_tm(Objec=
tClass *klass,
                                   void (*get)(Object *, struct tm *, Error=
 **),
                                   Error **errp);
=20
+typedef enum {
+    /* Automatically add a getter to the property */
+    OBJ_PROP_FLAG_READ =3D 1 << 0,
+    /* Automatically add a setter to the property */
+    OBJ_PROP_FLAG_WRITE =3D 1 << 1,
+    /* Automatically add a getter and a setter to the property */
+    OBJ_PROP_FLAG_READWRITE =3D (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE)=
,
+} ObjectPropertyFlags;
+
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint8'.
  */
 void object_property_add_uint8_ptr(Object *obj, const char *name,
-                                   const uint8_t *v, Error **errp);
+                                   const uint8_t *v, ObjectPropertyFlags f=
lags,
+                                   Error **errp);
+
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
-                                         const uint8_t *v, Error **errp);
+                                         const uint8_t *v,
+                                         ObjectPropertyFlags flags,
+                                         Error **errp);
=20
 /**
  * object_property_add_uint16_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint16'.
  */
 void object_property_add_uint16_ptr(Object *obj, const char *name,
-                                    const uint16_t *v, Error **errp);
+                                    const uint16_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp);
+
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
-                                          const uint16_t *v, Error **errp)=
;
+                                          const uint16_t *v,
+                                          ObjectPropertyFlags flags,
+                                          Error **errp);
=20
 /**
  * object_property_add_uint32_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint32'.
  */
 void object_property_add_uint32_ptr(Object *obj, const char *name,
-                                    const uint32_t *v, Error **errp);
+                                    const uint32_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp);
+
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
-                                          const uint32_t *v, Error **errp)=
;
+                                          const uint32_t *v,
+                                          ObjectPropertyFlags flags,
+                                          Error **errp);
=20
 /**
  * object_property_add_uint64_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint64'.
  */
 void object_property_add_uint64_ptr(Object *obj, const char *name,
-                                    const uint64_t *v, Error **errp);
+                                    const uint64_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **Errp);
+
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
-                                          const uint64_t *v, Error **errp)=
;
+                                          const uint64_t *v,
+                                          ObjectPropertyFlags flags,
+                                          Error **Errp);
=20
 /**
  * object_property_add_alias:
diff --git a/qom/object.c b/qom/object.c
index 555c8b9..1812f79 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2498,6 +2498,22 @@ static void property_get_uint8_ptr(Object *obj, Visi=
tor *v, const char *name,
     visit_type_uint8(v, name, &value, errp);
 }
=20
+static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *na=
me,
+                                   void *opaque, Error **errp)
+{
+    uint8_t *field =3D opaque;
+    uint8_t value;
+    Error *local_err =3D NULL;
+
+    visit_type_uint8(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    *field =3D value;
+}
+
 static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *n=
ame,
                                     void *opaque, Error **errp)
 {
@@ -2505,6 +2521,22 @@ static void property_get_uint16_ptr(Object *obj, Vis=
itor *v, const char *name,
     visit_type_uint16(v, name, &value, errp);
 }
=20
+static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *n=
ame,
+                                    void *opaque, Error **errp)
+{
+    uint16_t *field =3D opaque;
+    uint16_t value;
+    Error *local_err =3D NULL;
+
+    visit_type_uint16(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    *field =3D value;
+}
+
 static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *n=
ame,
                                     void *opaque, Error **errp)
 {
@@ -2512,6 +2544,22 @@ static void property_get_uint32_ptr(Object *obj, Vis=
itor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
=20
+static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *n=
ame,
+                                    void *opaque, Error **errp)
+{
+    uint32_t *field =3D opaque;
+    uint32_t value;
+    Error *local_err =3D NULL;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    *field =3D value;
+}
+
 static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *n=
ame,
                                     void *opaque, Error **errp)
 {
@@ -2519,68 +2567,184 @@ static void property_get_uint64_ptr(Object *obj, V=
isitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
=20
+static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *n=
ame,
+                                    void *opaque, Error **errp)
+{
+    uint64_t *field =3D opaque;
+    uint64_t value;
+    Error *local_err =3D NULL;
+
+    visit_type_uint64(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    *field =3D value;
+}
+
 void object_property_add_uint8_ptr(Object *obj, const char *name,
-                                   const uint8_t *v, Error **errp)
+                                   const uint8_t *v,
+                                   ObjectPropertyFlags flags,
+                                   Error **errp)
 {
-    object_property_add(obj, name, "uint8", property_get_uint8_ptr,
-                        NULL, NULL, (void *)v, errp);
+    ObjectPropertyAccessor *getter =3D NULL;
+    ObjectPropertyAccessor *setter =3D NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
+        getter =3D property_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
+        setter =3D property_set_uint8_ptr;
+    }
+
+    object_property_add(obj, name, "uint8",
+                        getter, setter, NULL, (void *)v, errp);
 }
=20
 ObjectProperty *
 object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
-                                         const uint8_t *v, Error **errp)
+                                    const uint8_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp)
 {
+    ObjectPropertyAccessor *getter =3D NULL;
+    ObjectPropertyAccessor *setter =3D NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
+        getter =3D property_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
+        setter =3D property_set_uint8_ptr;
+    }
+
     return object_class_property_add(klass, name, "uint8",
-                                     property_get_uint8_ptr,
-                                     NULL, NULL, (void *)v, errp);
+                                     getter, setter, NULL, (void *)v, errp=
);
 }
=20
 void object_property_add_uint16_ptr(Object *obj, const char *name,
-                                    const uint16_t *v, Error **errp)
+                                    const uint16_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp)
 {
-    object_property_add(obj, name, "uint16", property_get_uint16_ptr,
-                        NULL, NULL, (void *)v, errp);
+    ObjectPropertyAccessor *getter =3D NULL;
+    ObjectPropertyAccessor *setter =3D NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
+        getter =3D property_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
+        setter =3D property_set_uint16_ptr;
+    }
+
+    object_property_add(obj, name, "uint16",
+                        getter, setter, NULL, (void *)v, errp);
 }
=20
 ObjectProperty *
 object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
-                                          const uint16_t *v, Error **errp)
+                                     const uint16_t *v,
+                                     ObjectPropertyFlags flags,
+                                     Error **errp)
 {
+    ObjectPropertyAccessor *getter =3D NULL;
+    ObjectPropertyAccessor *setter =3D NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
+        getter =3D property_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
+        setter =3D property_set_uint16_ptr;
+    }
+
     return object_class_property_add(klass, name, "uint16",
-                                     property_get_uint16_ptr,
-                                     NULL, NULL, (void *)v, errp);
+                                     getter, setter, NULL, (void *)v, errp=
);
 }
=20
 void object_property_add_uint32_ptr(Object *obj, const char *name,
-                                    const uint32_t *v, Error **errp)
+                                    const uint32_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp)
 {
-    object_property_add(obj, name, "uint32", property_get_uint32_ptr,
-                        NULL, NULL, (void *)v, errp);
+    ObjectPropertyAccessor *getter =3D NULL;
+    ObjectPropertyAccessor *setter =3D NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
+        getter =3D property_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
+        setter =3D property_set_uint32_ptr;
+    }
+
+    object_property_add(obj, name, "uint32",
+                        getter, setter, NULL, (void *)v, errp);
 }
=20
 ObjectProperty *
 object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
-                                          const uint32_t *v, Error **errp)
+                                     const uint32_t *v,
+                                     ObjectPropertyFlags flags,
+                                     Error **errp)
 {
+    ObjectPropertyAccessor *getter =3D NULL;
+    ObjectPropertyAccessor *setter =3D NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
+        getter =3D property_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
+        setter =3D property_set_uint32_ptr;
+    }
+
     return object_class_property_add(klass, name, "uint32",
-                                     property_get_uint32_ptr,
-                                     NULL, NULL, (void *)v, errp);
+                                     getter, setter, NULL, (void *)v, errp=
);
 }
=20
 void object_property_add_uint64_ptr(Object *obj, const char *name,
-                                    const uint64_t *v, Error **errp)
+                                    const uint64_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp)
 {
-    object_property_add(obj, name, "uint64", property_get_uint64_ptr,
-                        NULL, NULL, (void *)v, errp);
+    ObjectPropertyAccessor *getter =3D NULL;
+    ObjectPropertyAccessor *setter =3D NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
+        getter =3D property_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
+        setter =3D property_set_uint64_ptr;
+    }
+
+    object_property_add(obj, name, "uint64",
+                        getter, setter, NULL, (void *)v, errp);
 }
=20
 ObjectProperty *
 object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
-                                          const uint64_t *v, Error **errp)
+                                     const uint64_t *v,
+                                     ObjectPropertyFlags flags,
+                                     Error **errp)
 {
+    ObjectPropertyAccessor *getter =3D NULL;
+    ObjectPropertyAccessor *setter =3D NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) =3D=3D OBJ_PROP_FLAG_READ) {
+        getter =3D property_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) =3D=3D OBJ_PROP_FLAG_WRITE) {
+        setter =3D property_set_uint64_ptr;
+    }
+
     return object_class_property_add(klass, name, "uint64",
-                                     property_get_uint64_ptr,
-                                     NULL, NULL, (void *)v, errp);
+                                     getter, setter, NULL, (void *)v, errp=
);
 }
=20
 typedef struct {
diff --git a/ui/console.c b/ui/console.c
index 179901c..184e173 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1299,8 +1299,8 @@ static QemuConsole *new_console(DisplayState *ds, con=
sole_type_t console_type,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
                              &error_abort);
-    object_property_add_uint32_ptr(obj, "head",
-                                   &s->head, &error_abort);
+    object_property_add_uint32_ptr(obj, "head", &s->head,
+                                   OBJ_PROP_FLAG_READ, &error_abort);
=20
     if (!active_console || ((active_console->console_type !=3D GRAPHIC_CON=
SOLE) &&
         (console_type =3D=3D GRAPHIC_CONSOLE))) {
--=20
1.8.3.1



