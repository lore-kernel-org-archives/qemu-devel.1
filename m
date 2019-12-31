Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC597C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB1C206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhzcWGsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB1C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHsC-0002KG-5E
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCg-00068F-2t
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCe-0004w2-7P
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCd-0004rf-Ty
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jACZtpMkHhr4dAm9PZDneEJIxP5KZuqB9HWqqcnlLmc=;
 b=HhzcWGsFVRjwiIOZ0wQhpFof1fhrsrtrgsKHlUqbNV5s01areF8qOeOL0Z1AmAqiP1lhVY
 AzCFGDZYM1Y0Op82KsKfHCxXd1mSpdLB2sns0oBwTjdeiXh89thDkSPIryw5S3wYSgU0BO
 KvBS4GW8Amc1CfmfypDfVymC6hRtylw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-OanbalCYMSWK25kOr_QcDw-1; Tue, 31 Dec 2019 08:04:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74830477
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:48 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F034378E96
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:47 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 73/86] sparc:sun4m: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:57 +0100
Message-Id: <1577797450-88458-74-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: OanbalCYMSWK25kOr_QcDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Patch moves ram size check into sun4m_hw_init() and drops
ram_init() moving remainder to sun4m_hw_init() as well,
as it was the only place that called it.

Also it rewrites impl. of RamDevice a little bit, which
could serve as an example of frontend device for RAM backend.
(Caveats are:
  1. it doesn't check for memdev backend being mapped
     since it's been  usurped by generic machine to handle
     majority of machines which don't have RAM frontend device
  2. it still lacks 'addr' property and still has hardcoded
     sysbus_mmio_map() in board init. If done right, board should
     set 'addr' property and bus/machine plug handler should map
     it during device realize time.
)
Further improvements were left as exercise for the future,
since frontends are out scope of RAM conversion to memdev.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/sparc/sun4m.c | 73 ++++++++++++++++++++++++++++------------------------=
----
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 2aaa5bf..834ad2a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -777,63 +777,42 @@ static const TypeInfo prom_info =3D {
=20
 typedef struct RamDevice {
     SysBusDevice parent_obj;
-
-    MemoryRegion ram;
-    uint64_t size;
+    HostMemoryBackend *memdev;
 } RamDevice;
=20
 /* System RAM */
 static void ram_realize(DeviceState *dev, Error **errp)
 {
     RamDevice *d =3D SUN4M_RAM(dev);
-    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    MemoryRegion *ram =3D host_memory_backend_get_memory(d->memdev);
=20
-    memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ram",
-                                         d->size);
-    sysbus_init_mmio(sbd, &d->ram);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), ram);
 }
=20
-static void ram_init(hwaddr addr, ram_addr_t RAM_size,
-                     uint64_t max_mem)
+static void ram_initfn(Object *obj)
 {
-    DeviceState *dev;
-    SysBusDevice *s;
-    RamDevice *d;
-
-    /* allocate RAM */
-    if ((uint64_t)RAM_size > max_mem) {
-        error_report("Too much memory for this machine: %" PRId64 ","
-                     " maximum %" PRId64,
-                     RAM_size / MiB, max_mem / MiB);
-        exit(1);
-    }
-    dev =3D qdev_create(NULL, "memory");
-    s =3D SYS_BUS_DEVICE(dev);
-
-    d =3D SUN4M_RAM(dev);
-    d->size =3D RAM_size;
-    qdev_init_nofail(dev);
-
-    sysbus_mmio_map(s, 0, addr);
+    RamDevice *d =3D SUN4M_RAM(obj);
+    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
+                             (Object **)&d->memdev,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
+    object_property_set_description(obj, "memdev", "Set RAM backend"
+                                    "Valid value is ID of a hostmem backen=
d",
+                                     &error_abort);
 }
=20
-static Property ram_properties[] =3D {
-    DEFINE_PROP_UINT64("size", RamDevice, size, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void ram_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D ram_realize;
-    dc->props =3D ram_properties;
 }
=20
 static const TypeInfo ram_info =3D {
     .name          =3D TYPE_SUN4M_MEMORY,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(RamDevice),
+    .instance_init =3D ram_initfn,
     .class_init    =3D ram_class_init,
 };
=20
@@ -880,6 +859,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hw=
def,
     unsigned int smp_cpus =3D machine->smp.cpus;
     unsigned int max_cpus =3D machine->smp.max_cpus;
=20
+    if (machine->ram_size > hwdef->max_mem) {
+        error_report("Too much memory for this machine: %" PRId64 ","
+                     " maximum %" PRId64,
+                     machine->ram_size / MiB, hwdef->max_mem / MiB);
+        exit(1);
+    }
+
     /* init CPUs */
     for(i =3D 0; i < smp_cpus; i++) {
         cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]=
);
@@ -888,9 +874,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hw=
def,
     for (i =3D smp_cpus; i < MAX_CPUS; i++)
         cpu_irqs[i] =3D qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PI=
LS);
=20
+    /* Create and map RAM frontend */
+    dev =3D qdev_create(NULL, "memory");
+    object_property_set_link(OBJECT(dev), OBJECT(machine->ram_memdev),
+                             "memdev", &error_fatal);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
=20
-    /* set up devices */
-    ram_init(0, machine->ram_size, hwdef->max_mem);
     /* models without ECC don't trap when missing ram is accessed */
     if (!hwdef->ecc_base) {
         empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_s=
ize);
@@ -1078,7 +1068,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
=20
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
-    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, hwdef->machine_id);
     fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_DEPTH, graphic_depth);
     fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_WIDTH, graphic_width);
@@ -1415,6 +1405,7 @@ static void ss5_class_init(ObjectClass *oc, void *dat=
a)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo ss5_type =3D {
@@ -1434,6 +1425,7 @@ static void ss10_class_init(ObjectClass *oc, void *da=
ta)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo ss10_type =3D {
@@ -1453,6 +1445,7 @@ static void ss600mp_class_init(ObjectClass *oc, void =
*data)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo ss600mp_type =3D {
@@ -1472,6 +1465,7 @@ static void ss20_class_init(ObjectClass *oc, void *da=
ta)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo ss20_type =3D {
@@ -1490,6 +1484,7 @@ static void voyager_class_init(ObjectClass *oc, void =
*data)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo voyager_type =3D {
@@ -1508,6 +1503,7 @@ static void ss_lx_class_init(ObjectClass *oc, void *d=
ata)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo ss_lx_type =3D {
@@ -1526,6 +1522,7 @@ static void ss4_class_init(ObjectClass *oc, void *dat=
a)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo ss4_type =3D {
@@ -1544,6 +1541,7 @@ static void scls_class_init(ObjectClass *oc, void *da=
ta)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo scls_type =3D {
@@ -1562,6 +1560,7 @@ static void sbook_class_init(ObjectClass *oc, void *d=
ata)
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
     mc->default_display =3D "tcx";
+    mc->default_ram_id =3D "sun4m.ram";
 }
=20
 static const TypeInfo sbook_type =3D {
--=20
2.7.4


