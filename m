Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D1AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E6420679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vqfd1zB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E6420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxRy-0000N1-K9
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHS-0003P8-Ni
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHP-0003gI-9k
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHP-0003cV-01
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mL+UrM7rBopI4N44idY+Y3FyvYTN9D88OpzfXEmVZpE=;
 b=Vqfd1zB8te04AzFgNs+2gLLIUwA7j3hBK/T8iT3IyrQTaeWfEUL25Krk9wljjGoTEORgqt
 99unJOuuLhxC++sGiKvu70W2WNCcZjymNg8tg6nsBPBMloEuCxqDBvNU4qBWi23EQ3QIFe
 IoitEfO9a+7hu9UbUgXq8hXvh2EmgCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-N-PWMI-WMKGXneT-3PJnUQ-1; Mon, 16 Mar 2020 17:28:08 -0400
X-MC-Unique: N-PWMI-WMKGXneT-3PJnUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E52D1804544;
 Mon, 16 Mar 2020 21:28:07 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 497BC19C4F;
 Mon, 16 Mar 2020 21:28:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/61] qom/object: Use common get/set uint helpers
Date: Mon, 16 Mar 2020 22:26:47 +0100
Message-Id: <1584394048-44994-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

Several objects implemented their own uint property getters and setters,
despite them being straightforward (without any checks/validations on
the values themselves) and identical across objects. This makes use of
an enhanced API for object_property_add_uintXX_ptr() which offers
default setters.

Some of these setters used to update the value even if the type visit
failed (eg. because the value being set overflowed over the given type).
The new setter introduces a check for these errors, not updating the
value if an error occurred. The error is propagated.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/ich9.c    |  95 +++++-------------------------------------------
 hw/isa/lpc_ich9.c |  12 ++-----
 hw/misc/edu.c     |  13 ++-----
 hw/pci-host/q35.c |  14 ++------
 hw/ppc/spapr.c    |  36 ++++---------------
 memory.c          |  15 ++------
 target/arm/cpu.c  |  22 ++----------
 target/i386/sev.c | 106 +++++---------------------------------------------=
----
 8 files changed, 37 insertions(+), 276 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 67fe05a..336cace 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -357,81 +357,6 @@ static void ich9_pm_set_cpu_hotplug_legacy(Object *obj=
, bool value,
     s->pm.cpu_hotplug_legacy =3D value;
 }
=20
-static void ich9_pm_get_disable_s3(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm =3D opaque;
-    uint8_t value =3D pm->disable_s3;
-
-    visit_type_uint8(v, name, &value, errp);
-}
-
-static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm =3D opaque;
-    Error *local_err =3D NULL;
-    uint8_t value;
-
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    pm->disable_s3 =3D value;
-out:
-    error_propagate(errp, local_err);
-}
-
-static void ich9_pm_get_disable_s4(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm =3D opaque;
-    uint8_t value =3D pm->disable_s4;
-
-    visit_type_uint8(v, name, &value, errp);
-}
-
-static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm =3D opaque;
-    Error *local_err =3D NULL;
-    uint8_t value;
-
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    pm->disable_s4 =3D value;
-out:
-    error_propagate(errp, local_err);
-}
-
-static void ich9_pm_get_s4_val(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm =3D opaque;
-    uint8_t value =3D pm->s4_val;
-
-    visit_type_uint8(v, name, &value, errp);
-}
-
-static void ich9_pm_set_s4_val(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm =3D opaque;
-    Error *local_err =3D NULL;
-    uint8_t value;
-
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    pm->s4_val =3D value;
-out:
-    error_propagate(errp, local_err);
-}
-
 static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
 {
     ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
@@ -468,18 +393,14 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMReg=
s *pm, Error **errp)
                              ich9_pm_get_cpu_hotplug_legacy,
                              ich9_pm_set_cpu_hotplug_legacy,
                              NULL);
-    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
-                        ich9_pm_get_disable_s3,
-                        ich9_pm_set_disable_s3,
-                        NULL, pm, NULL);
-    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
-                        ich9_pm_get_disable_s4,
-                        ich9_pm_set_disable_s4,
-                        NULL, pm, NULL);
-    object_property_add(obj, ACPI_PM_PROP_S4_VAL, "uint8",
-                        ich9_pm_get_s4_val,
-                        ich9_pm_set_s4_val,
-                        NULL, pm, NULL);
+    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
+                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE=
,
+                                  NULL);
+    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
+                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE=
,
+                                  NULL);
+    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
+                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE, NU=
LL);
     object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
                              ich9_pm_get_enable_tco,
                              ich9_pm_set_enable_tco,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3d0f4db..fbc3165 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -625,13 +625,6 @@ static const MemoryRegionOps ich9_rst_cnt_ops =3D {
     .endianness =3D DEVICE_LITTLE_ENDIAN
 };
=20
-static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *name=
,
-                                 void *opaque, Error **errp)
-{
-    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
-    visit_type_uint8(v, name, &lpc->sci_gsi, errp);
-}
-
 static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
@@ -639,9 +632,8 @@ static void ich9_lpc_initfn(Object *obj)
     static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
=20
-    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
-                        ich9_lpc_get_sci_int,
-                        NULL, NULL, NULL, NULL);
+    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
+                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ, NULL)=
;
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CM=
D,
                                   &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NU=
LL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_C=
MD,
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index d5e2bdb..ff10f5b 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -396,21 +396,14 @@ static void pci_edu_uninit(PCIDevice *pdev)
     msi_uninit(pdev);
 }
=20
-static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    uint64_t *val =3D opaque;
-
-    visit_type_uint64(v, name, val, errp);
-}
-
 static void edu_instance_init(Object *obj)
 {
     EduState *edu =3D EDU(obj);
=20
     edu->dma_mask =3D (1UL << 28) - 1;
-    object_property_add(obj, "dma_mask", "uint64", edu_obj_uint64,
-                    edu_obj_uint64, NULL, &edu->dma_mask, NULL);
+    object_property_add_uint64_ptr(obj, "dma_mask",
+                                   &edu->dma_mask, OBJ_PROP_FLAG_READWRITE=
,
+                                   NULL);
 }
=20
 static void edu_class_init(ObjectClass *class, void *data)
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 993f467..2bbc90b 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -166,14 +166,6 @@ static void q35_host_get_pci_hole64_end(Object *obj, V=
isitor *v,
     visit_type_uint64(v, name, &value, errp);
 }
=20
-static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char *n=
ame,
-                                    void *opaque, Error **errp)
-{
-    PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
-
-    visit_type_uint64(v, name, &e->size, errp);
-}
-
 /*
  * NOTE: setting defaults for the mch.* fields in this table
  * doesn't work, because mch is a separate QOM object that is
@@ -214,6 +206,7 @@ static void q35_host_initfn(Object *obj)
 {
     Q35PCIHost *s =3D Q35_HOST_DEVICE(obj);
     PCIHostState *phb =3D PCI_HOST_BRIDGE(obj);
+    PCIExpressHost *pehb =3D PCIE_HOST_BRIDGE(obj);
=20
     memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
                           "pci-conf-idx", 4);
@@ -243,9 +236,8 @@ static void q35_host_initfn(Object *obj)
                         q35_host_get_pci_hole64_end,
                         NULL, NULL, NULL, NULL);
=20
-    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
-                        q35_host_get_mmcfg_size,
-                        NULL, NULL, NULL, NULL);
+    object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
+                                   &pehb->size, OBJ_PROP_FLAG_READ, NULL);
=20
     object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGIO=
N,
                              (Object **) &s->mch.ram_memory,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cc10798..41c0f24 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3223,30 +3223,6 @@ static void spapr_set_resize_hpt(Object *obj, const =
char *value, Error **errp)
     }
 }
=20
-static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
-}
-
-static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
-}
-
-static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *nam=
e,
-                                  void *opaque, Error **errp)
-{
-    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
-}
-
-static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *nam=
e,
-                                  void *opaque, Error **errp)
-{
-    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
-}
-
 static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
@@ -3344,17 +3320,19 @@ static void spapr_instance_init(Object *obj)
     object_property_set_description(obj, "resize-hpt",
                                     "Resizing of the Hash Page Table (enab=
led, disabled, required)",
                                     NULL);
-    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
-                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abort);
+    object_property_add_uint32_ptr(obj, "vsmt",
+                                   &spapr->vsmt, OBJ_PROP_FLAG_READWRITE,
+                                   &error_abort);
     object_property_set_description(obj, "vsmt",
                                     "Virtual SMT: KVM behaves as if this w=
ere"
                                     " the host's SMT mode", &error_abort);
+
     object_property_add_bool(obj, "vfio-no-msix-emulation",
                              spapr_get_msix_emulation, NULL, NULL);
=20
-    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_add=
r,
-                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
-                        &error_abort);
+    object_property_add_uint64_ptr(obj, "kernel-addr",
+                                   &spapr->kernel_addr, OBJ_PROP_FLAG_READ=
WRITE,
+                                   &error_abort);
     object_property_set_description(obj, "kernel-addr",
                                     stringify(KERNEL_LOAD_ADDR)
                                     " for -kernel is the default",
diff --git a/memory.c b/memory.c
index 09be40e..404ff4e 100644
--- a/memory.c
+++ b/memory.c
@@ -1170,15 +1170,6 @@ void memory_region_init(MemoryRegion *mr,
     memory_region_do_init(mr, owner, name, size);
 }
=20
-static void memory_region_get_addr(Object *obj, Visitor *v, const char *na=
me,
-                                   void *opaque, Error **errp)
-{
-    MemoryRegion *mr =3D MEMORY_REGION(obj);
-    uint64_t value =3D mr->addr;
-
-    visit_type_uint64(v, name, &value, errp);
-}
-
 static void memory_region_get_container(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
@@ -1242,10 +1233,8 @@ static void memory_region_initfn(Object *obj)
                              NULL, NULL, &error_abort);
     op->resolve =3D memory_region_resolve_container;
=20
-    object_property_add(OBJECT(mr), "addr", "uint64",
-                        memory_region_get_addr,
-                        NULL, /* memory_region_set_addr */
-                        NULL, NULL, &error_abort);
+    object_property_add_uint64_ptr(OBJECT(mr), "addr",
+                                   &mr->addr, OBJ_PROP_FLAG_READ, &error_a=
bort);
     object_property_add(OBJECT(mr), "priority", "uint32",
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3623ece..7fe3670 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1153,22 +1153,6 @@ static void arm_set_pmu(Object *obj, bool value, Err=
or **errp)
     cpu->has_pmu =3D value;
 }
=20
-static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    visit_type_uint32(v, name, &cpu->init_svtor, errp);
-}
-
-static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    visit_type_uint32(v, name, &cpu->init_svtor, errp);
-}
-
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
 {
     /*
@@ -1288,9 +1272,9 @@ void arm_cpu_post_init(Object *obj)
          * a simple DEFINE_PROP_UINT32 for this because we want to permit
          * the property to be set after realize.
          */
-        object_property_add(obj, "init-svtor", "uint32",
-                            arm_get_init_svtor, arm_set_init_svtor,
-                            NULL, NULL, &error_abort);
+        object_property_add_uint32_ptr(obj, "init-svtor",
+                                       &cpu->init_svtor,
+                                       OBJ_PROP_FLAG_READWRITE, &error_abo=
rt);
     }
=20
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 024bb24..846018a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -267,109 +267,21 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
 }
=20
 static void
-qsev_guest_set_handle(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
-    uint32_t value;
-
-    visit_type_uint32(v, name, &value, errp);
-    sev->handle =3D value;
-}
-
-static void
-qsev_guest_set_policy(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
-    uint32_t value;
-
-    visit_type_uint32(v, name, &value, errp);
-    sev->policy =3D value;
-}
-
-static void
-qsev_guest_set_cbitpos(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
-    uint32_t value;
-
-    visit_type_uint32(v, name, &value, errp);
-    sev->cbitpos =3D value;
-}
-
-static void
-qsev_guest_set_reduced_phys_bits(Object *obj, Visitor *v, const char *name=
,
-                                   void *opaque, Error **errp)
-{
-    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
-    uint32_t value;
-
-    visit_type_uint32(v, name, &value, errp);
-    sev->reduced_phys_bits =3D value;
-}
-
-static void
-qsev_guest_get_policy(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    uint32_t value;
-    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
-
-    value =3D sev->policy;
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void
-qsev_guest_get_handle(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    uint32_t value;
-    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
-
-    value =3D sev->handle;
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void
-qsev_guest_get_cbitpos(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    uint32_t value;
-    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
-
-    value =3D sev->cbitpos;
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void
-qsev_guest_get_reduced_phys_bits(Object *obj, Visitor *v, const char *name=
,
-                                   void *opaque, Error **errp)
-{
-    uint32_t value;
-    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
-
-    value =3D sev->reduced_phys_bits;
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void
 qsev_guest_init(Object *obj)
 {
     QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
=20
     sev->sev_device =3D g_strdup(DEFAULT_SEV_DEVICE);
     sev->policy =3D DEFAULT_GUEST_POLICY;
-    object_property_add(obj, "policy", "uint32", qsev_guest_get_policy,
-                        qsev_guest_set_policy, NULL, NULL, NULL);
-    object_property_add(obj, "handle", "uint32", qsev_guest_get_handle,
-                        qsev_guest_set_handle, NULL, NULL, NULL);
-    object_property_add(obj, "cbitpos", "uint32", qsev_guest_get_cbitpos,
-                        qsev_guest_set_cbitpos, NULL, NULL, NULL);
-    object_property_add(obj, "reduced-phys-bits", "uint32",
-                        qsev_guest_get_reduced_phys_bits,
-                        qsev_guest_set_reduced_phys_bits, NULL, NULL, NULL=
);
+    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
+                                   OBJ_PROP_FLAG_READWRITE, NULL);
+    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
+                                   OBJ_PROP_FLAG_READWRITE, NULL);
+    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
+                                   OBJ_PROP_FLAG_READWRITE, NULL);
+    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
+                                   &sev->reduced_phys_bits,
+                                   OBJ_PROP_FLAG_READWRITE, NULL);
 }
=20
 /* sev guest info */
--=20
1.8.3.1



