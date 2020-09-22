Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590D9C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFF7208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huD3kL2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFF7208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqm9-0002fc-Uy
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjW-000887-TZ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjR-0006F7-Pz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600813548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bQerftuqLCTQanJ6CDpzCHEgRIQUKAVRHQRaWDW4zA=;
 b=huD3kL2hsijvnRiM4doLQKCSBUORXbJ0gmwELVJjz0q9Cn03WFRtLeNkvBD3Z6fK3OIP4P
 xB8vq8VOwSXCQDmPTMoJhxfu0ItjExSvx2CLTjHqR3UcqPfkKymarINUrbRh8UTsB6tIA1
 Dq0DSTMPhoqxC7m8MwLNPg7/Ir5IOj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-85xp8tZSOxeh8pniQJrNPA-1; Tue, 22 Sep 2020 18:25:45 -0400
X-MC-Unique: 85xp8tZSOxeh8pniQJrNPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3E4E1005E64;
 Tue, 22 Sep 2020 22:25:44 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88B1E2C31E;
 Tue, 22 Sep 2020 22:25:44 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/11] qom: simplify object_find_property /
 object_class_find_property
Date: Tue, 22 Sep 2020 18:25:32 -0400
Message-Id: <20200922222542.2354748-2-ehabkost@redhat.com>
In-Reply-To: <20200922222542.2354748-1-ehabkost@redhat.com>
References: <20200922222542.2354748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

When debugging QEMU it is often useful to put a breakpoint on the
error_setg_internal method impl.

Unfortunately the object_property_add / object_class_property_add
methods call object_property_find / object_class_property_find methods
to check if a property exists already before adding the new property.

As a result there are a huge number of calls to error_setg_internal
on startup of most QEMU commands, making it very painful to set a
breakpoint on this method.

Most callers of object_find_property and object_class_find_property,
however, pass in a NULL for the Error parameter. This simplifies the
methods to remove the Error parameter entirely, and then adds some
new wrapper methods that are able to raise an Error when needed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200914135617.1493072-1-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h             | 48 ++++++++++++++++++++++---
 hw/arm/armv7m.c                  | 10 +++---
 hw/arm/exynos4210.c              |  2 +-
 hw/arm/highbank.c                |  2 +-
 hw/arm/integratorcp.c            |  2 +-
 hw/arm/realview.c                |  2 +-
 hw/arm/sbsa-ref.c                |  2 +-
 hw/arm/versatilepb.c             |  2 +-
 hw/arm/vexpress.c                |  4 +--
 hw/arm/virt.c                    | 10 +++---
 hw/arm/xilinx_zynq.c             |  2 +-
 hw/core/qdev-properties-system.c |  2 +-
 hw/core/sysbus.c                 |  2 +-
 hw/cpu/a15mpcore.c               |  4 +--
 hw/cpu/a9mpcore.c                |  2 +-
 hw/misc/iotkit-sysctl.c          |  2 +-
 hw/pci/pci.c                     |  2 +-
 hw/scsi/scsi-bus.c               |  4 +--
 qom/object.c                     | 60 +++++++++++++++++++-------------
 target/arm/monitor.c             |  2 +-
 target/i386/cpu.c                |  2 +-
 target/ppc/translate_init.c.inc  |  2 +-
 22 files changed, 109 insertions(+), 61 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 19cccd3f5f7..9b018887266 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1463,14 +1463,52 @@ void object_property_set_default_uint(ObjectProperty *prop, uint64_t value);
  * object_property_find:
  * @obj: the object
  * @name: the name of the property
+ *
+ * Look up a property for an object.
+ *
+ * Return its #ObjectProperty if found, or NULL.
+ */
+ObjectProperty *object_property_find(Object *obj, const char *name);
+
+/**
+ * object_property_find_err:
+ * @obj: the object
+ * @name: the name of the property
  * @errp: returns an error if this function fails
  *
- * Look up a property for an object and return its #ObjectProperty if found.
+ * Look up a property for an object.
+ *
+ * Return its #ObjectProperty if found, or NULL.
  */
-ObjectProperty *object_property_find(Object *obj, const char *name,
-                                     Error **errp);
-ObjectProperty *object_class_property_find(ObjectClass *klass, const char *name,
-                                           Error **errp);
+ObjectProperty *object_property_find_err(Object *obj,
+                                         const char *name,
+                                         Error **errp);
+
+/**
+ * object_class_property_find:
+ * @klass: the object class
+ * @name: the name of the property
+ *
+ * Look up a property for an object class.
+ *
+ * Return its #ObjectProperty if found, or NULL.
+ */
+ObjectProperty *object_class_property_find(ObjectClass *klass,
+                                           const char *name);
+
+/**
+ * object_class_property_find_err:
+ * @klass: the object class
+ * @name: the name of the property
+ * @errp: returns an error if this function fails
+ *
+ * Look up a property for an object class.
+ *
+ * Return its #ObjectProperty if found, or NULL.
+ */
+ObjectProperty *object_class_property_find_err(ObjectClass *klass,
+                                               const char *name,
+                                               Error **errp);
 
 typedef struct ObjectPropertyIterator {
     ObjectClass *nextclass;
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index aa831d6653c..0e5997d333a 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -169,28 +169,28 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
-    if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
+    if (object_property_find(OBJECT(s->cpu), "idau")) {
         object_property_set_link(OBJECT(s->cpu), "idau", s->idau,
                                  &error_abort);
     }
-    if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
+    if (object_property_find(OBJECT(s->cpu), "init-svtor")) {
         if (!object_property_set_uint(OBJECT(s->cpu), "init-svtor",
                                       s->init_svtor, errp)) {
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "start-powered-off", NULL)) {
+    if (object_property_find(OBJECT(s->cpu), "start-powered-off")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
                                       s->start_powered_off, errp)) {
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "vfp", NULL)) {
+    if (object_property_find(OBJECT(s->cpu), "vfp")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, errp)) {
             return;
         }
     }
-    if (object_property_find(OBJECT(s->cpu), "dsp", NULL)) {
+    if (object_property_find(OBJECT(s->cpu), "dsp")) {
         if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, errp)) {
             return;
         }
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 081bbff3170..ced2769b102 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -214,7 +214,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
         /* By default A9 CPUs have EL3 enabled.  This board does not currently
          * support EL3 so the CPU EL3 property is disabled before realization.
          */
-        if (object_property_find(cpuobj, "has_el3", NULL)) {
+        if (object_property_find(cpuobj, "has_el3")) {
             object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
         }
 
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 7da984171bb..da0510d7cef 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -276,7 +276,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
                                      &error_abort);
         }
 
-        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+        if (object_property_find(cpuobj, "reset-cbar")) {
             object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
                                     &error_abort);
         }
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index de670b08a90..16e89859539 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -603,7 +603,7 @@ static void integratorcp_init(MachineState *machine)
      * currently support EL3 so the CPU EL3 property is disabled before
      * realization.
      */
-    if (object_property_find(cpuobj, "has_el3", NULL)) {
+    if (object_property_find(cpuobj, "has_el3")) {
         object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
     }
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 5f1f36b15cd..0831159d158 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -108,7 +108,7 @@ static void realview_init(MachineState *machine,
          * does not currently support EL3 so the CPU EL3 property is disabled
          * before realization.
          */
-        if (object_property_find(cpuobj, "has_el3", NULL)) {
+        if (object_property_find(cpuobj, "has_el3")) {
             object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
         }
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index bcb2cb47619..257ada94255 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -703,7 +703,7 @@ static void sbsa_ref_init(MachineState *machine)
         numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
                           &error_fatal);
 
-        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+        if (object_property_find(cpuobj, "reset-cbar")) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     sbsa_ref_memmap[SBSA_CPUPERIPHS].base,
                                     &error_abort);
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 84d4677abb7..1ea55346264 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -213,7 +213,7 @@ static void versatile_init(MachineState *machine, int board_id)
      * currently support EL3 so the CPU EL3 property is disabled before
      * realization.
      */
-    if (object_property_find(cpuobj, "has_el3", NULL)) {
+    if (object_property_find(cpuobj, "has_el3")) {
         object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
     }
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 94ff094ab3e..531f3a122ad 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -218,12 +218,12 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
         }
         if (!virt) {
-            if (object_property_find(cpuobj, "has_el2", NULL)) {
+            if (object_property_find(cpuobj, "has_el2")) {
                 object_property_set_bool(cpuobj, "has_el2", false, NULL);
             }
         }
 
-        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+        if (object_property_find(cpuobj, "reset-cbar")) {
             object_property_set_int(cpuobj, "reset-cbar", periphbase,
                                     &error_abort);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index acf9bfbecea..1231a197c85 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1806,7 +1806,7 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
         }
 
-        if (!vms->virt && object_property_find(cpuobj, "has_el2", NULL)) {
+        if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
@@ -1822,15 +1822,15 @@ static void machvirt_init(MachineState *machine)
         }
 
         if (vmc->kvm_no_adjvtime &&
-            object_property_find(cpuobj, "kvm-no-adjvtime", NULL)) {
+            object_property_find(cpuobj, "kvm-no-adjvtime")) {
             object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
         }
 
-        if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
+        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
             object_property_set_bool(cpuobj, "pmu", false, NULL);
         }
 
-        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+        if (object_property_find(cpuobj, "reset-cbar")) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
                                     &error_abort);
@@ -1850,7 +1850,7 @@ static void machvirt_init(MachineState *machine)
                  * The property exists only if MemTag is supported.
                  * If it is, we must allocate the ram to back that up.
                  */
-                if (!object_property_find(cpuobj, "tag-memory", NULL)) {
+                if (!object_property_find(cpuobj, "tag-memory")) {
                     error_report("MTE requested, but not supported "
                                  "by the guest CPU");
                     exit(1);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 2c0bff4fa6c..b72772bc824 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -196,7 +196,7 @@ static void zynq_init(MachineState *machine)
      * currently support EL3 so the CPU EL3 property is disabled before
      * realization.
      */
-    if (object_property_find(OBJECT(cpu), "has_el3", NULL)) {
+    if (object_property_find(OBJECT(cpu), "has_el3")) {
         object_property_set_bool(OBJECT(cpu), "has_el3", false, &error_fatal);
     }
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 3e4f16fc218..b29daf4fb51 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -460,7 +460,7 @@ void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd)
         qdev_prop_set_netdev(dev, "netdev", nd->netdev);
     }
     if (nd->nvectors != DEV_NVECTORS_UNSPECIFIED &&
-        object_property_find(OBJECT(dev), "vectors", NULL)) {
+        object_property_find(OBJECT(dev), "vectors")) {
         qdev_prop_set_uint32(dev, "vectors", nd->nvectors);
     }
     nd->instantiated = 1;
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 294f90b7dee..68e8dc88c5c 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -93,7 +93,7 @@ bool sysbus_has_irq(SysBusDevice *dev, int n)
     char *prop = g_strdup_printf("%s[%d]", SYSBUS_DEVICE_GPIO_IRQ, n);
     ObjectProperty *r;
 
-    r = object_property_find(OBJECT(dev), prop, NULL);
+    r = object_property_find(OBJECT(dev), prop);
     g_free(prop);
 
     return (r != NULL);
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index c377be398d1..774ca9987a1 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -66,11 +66,11 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
          * either all the CPUs have TZ, or none do.
          */
         cpuobj = OBJECT(qemu_get_cpu(0));
-        has_el3 = object_property_find(cpuobj, "has_el3", NULL) &&
+        has_el3 = object_property_find(cpuobj, "has_el3") &&
             object_property_get_bool(cpuobj, "has_el3", &error_abort);
         qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
         /* Similarly for virtualization support */
-        has_el2 = object_property_find(cpuobj, "has_el2", NULL) &&
+        has_el2 = object_property_find(cpuobj, "has_el2") &&
             object_property_get_bool(cpuobj, "has_el2", &error_abort);
         qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
     }
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index ec186d49abd..d03f57e579b 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -81,7 +81,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
      */
-    has_el3 = object_property_find(cpuobj, "has_el3", NULL) &&
+    has_el3 = object_property_find(cpuobj, "has_el3") &&
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
 
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 269783366d1..964b48c74d9 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -83,7 +83,7 @@ static void set_init_vtor(uint64_t cpuid, uint32_t vtor)
     Object *cpuobj = OBJECT(arm_get_cpu_by_id(cpuid));
 
     if (cpuobj) {
-        if (object_property_find(cpuobj, "init-svtor", NULL)) {
+        if (object_property_find(cpuobj, "init-svtor")) {
             object_property_set_uint(cpuobj, "init-svtor", vtor, &error_abort);
         }
     }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index de0fae10ab9..fce725474b9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1900,7 +1900,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
              * a temporary instance here to be able to check it.
              */
             Object *obj = object_new_with_class(OBJECT_CLASS(dc));
-            if (object_property_find(obj, "netdev", NULL)) {
+            if (object_property_find(obj, "netdev")) {
                 g_ptr_array_add(pci_nic_models, (gpointer)name);
             }
             object_unref(obj);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index df65cc22239..3284a5d1fb6 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -270,10 +270,10 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
         object_property_set_int(OBJECT(dev), "bootindex", bootindex,
                                 &error_abort);
     }
-    if (object_property_find(OBJECT(dev), "removable", NULL)) {
+    if (object_property_find(OBJECT(dev), "removable")) {
         qdev_prop_set_bit(dev, "removable", removable);
     }
-    if (serial && object_property_find(OBJECT(dev), "serial", NULL)) {
+    if (serial && object_property_find(OBJECT(dev), "serial")) {
         qdev_prop_set_string(dev, "serial", serial);
     }
     if (!qdev_prop_set_drive_err(dev, "drive", blk, errp)) {
diff --git a/qom/object.c b/qom/object.c
index a91a6a515af..a1ab9a78011 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -403,7 +403,7 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
         if (object_dynamic_cast(obj, p->driver) == NULL) {
             continue;
         }
-        if (p->optional && !object_property_find(obj, p->property, NULL)) {
+        if (p->optional && !object_property_find(obj, p->property)) {
             continue;
         }
         p->used = true;
@@ -1214,7 +1214,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
         return ret;
     }
 
-    if (object_property_find(obj, name, NULL) != NULL) {
+    if (object_property_find(obj, name) != NULL) {
         error_setg(errp, "attempt to add duplicate property '%s' to object (type '%s')",
                    name, object_get_typename(obj));
         return NULL;
@@ -1256,7 +1256,7 @@ object_class_property_add(ObjectClass *klass,
 {
     ObjectProperty *prop;
 
-    assert(!object_class_property_find(klass, name, NULL));
+    assert(!object_class_property_find(klass, name));
 
     prop = g_malloc0(sizeof(*prop));
 
@@ -1273,24 +1273,27 @@ object_class_property_add(ObjectClass *klass,
     return prop;
 }
 
-ObjectProperty *object_property_find(Object *obj, const char *name,
-                                     Error **errp)
+ObjectProperty *object_property_find(Object *obj, const char *name)
 {
     ObjectProperty *prop;
     ObjectClass *klass = object_get_class(obj);
 
-    prop = object_class_property_find(klass, name, NULL);
+    prop = object_class_property_find(klass, name);
     if (prop) {
         return prop;
     }
 
-    prop = g_hash_table_lookup(obj->properties, name);
-    if (prop) {
-        return prop;
-    }
+    return g_hash_table_lookup(obj->properties, name);
+}
 
-    error_setg(errp, "Property '.%s' not found", name);
-    return NULL;
+ObjectProperty *object_property_find_err(Object *obj, const char *name,
+                                         Error **errp)
+{
+    ObjectProperty *prop = object_property_find(obj, name);
+    if (!prop) {
+        error_setg(errp, "Property '.%s' not found", name);
+    }
+    return prop;
 }
 
 void object_property_iter_init(ObjectPropertyIterator *iter,
@@ -1320,27 +1323,34 @@ void object_class_property_iter_init(ObjectPropertyIterator *iter,
     iter->nextclass = object_class_get_parent(klass);
 }
 
-ObjectProperty *object_class_property_find(ObjectClass *klass, const char *name,
-                                           Error **errp)
+ObjectProperty *object_class_property_find(ObjectClass *klass, const char *name)
 {
-    ObjectProperty *prop;
     ObjectClass *parent_klass;
 
     parent_klass = object_class_get_parent(klass);
     if (parent_klass) {
-        prop = object_class_property_find(parent_klass, name, NULL);
+        ObjectProperty *prop =
+            object_class_property_find(parent_klass, name);
         if (prop) {
             return prop;
         }
     }
 
-    prop = g_hash_table_lookup(klass->properties, name);
+    return g_hash_table_lookup(klass->properties, name);
+}
+
+ObjectProperty *object_class_property_find_err(ObjectClass *klass,
+                                               const char *name,
+                                               Error **errp)
+{
+    ObjectProperty *prop = object_class_property_find(klass, name);
     if (!prop) {
         error_setg(errp, "Property '.%s' not found", name);
     }
     return prop;
 }
 
+
 void object_property_del(Object *obj, const char *name)
 {
     ObjectProperty *prop = g_hash_table_lookup(obj->properties, name);
@@ -1355,7 +1365,7 @@ bool object_property_get(Object *obj, const char *name, Visitor *v,
                          Error **errp)
 {
     Error *err = NULL;
-    ObjectProperty *prop = object_property_find(obj, name, errp);
+    ObjectProperty *prop = object_property_find_err(obj, name, errp);
 
     if (prop == NULL) {
         return false;
@@ -1374,7 +1384,7 @@ bool object_property_set(Object *obj, const char *name, Visitor *v,
                          Error **errp)
 {
     Error *err = NULL;
-    ObjectProperty *prop = object_property_find(obj, name, errp);
+    ObjectProperty *prop = object_property_find_err(obj, name, errp);
 
     if (prop == NULL) {
         return false;
@@ -1590,7 +1600,7 @@ int object_property_get_enum(Object *obj, const char *name,
 {
     char *str;
     int ret;
-    ObjectProperty *prop = object_property_find(obj, name, errp);
+    ObjectProperty *prop = object_property_find_err(obj, name, errp);
     EnumProperty *enumprop;
 
     if (prop == NULL) {
@@ -1647,7 +1657,7 @@ out:
 
 const char *object_property_get_type(Object *obj, const char *name, Error **errp)
 {
-    ObjectProperty *prop = object_property_find(obj, name, errp);
+    ObjectProperty *prop = object_property_find_err(obj, name, errp);
     if (prop == NULL) {
         return NULL;
     }
@@ -2025,7 +2035,7 @@ char *object_get_canonical_path(const Object *obj)
 
 Object *object_resolve_path_component(Object *parent, const char *part)
 {
-    ObjectProperty *prop = object_property_find(parent, part, NULL);
+    ObjectProperty *prop = object_property_find(parent, part);
     if (prop == NULL) {
         return NULL;
     }
@@ -2724,8 +2734,8 @@ object_property_add_alias(Object *obj, const char *name,
     ObjectProperty *target_prop;
     g_autofree char *prop_type = NULL;
 
-    target_prop = object_property_find(target_obj, target_name,
-                                       &error_abort);
+    target_prop = object_property_find_err(target_obj, target_name,
+                                           &error_abort);
 
     if (object_property_is_child(target_prop)) {
         prop_type = g_strdup_printf("link%s",
@@ -2758,7 +2768,7 @@ void object_property_set_description(Object *obj, const char *name,
 {
     ObjectProperty *op;
 
-    op = object_property_find(obj, name, &error_abort);
+    op = object_property_find_err(obj, name, &error_abort);
     g_free(op->description);
     op->description = g_strdup(description);
 }
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index ba6e01abd03..375f34bfaa7 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -214,7 +214,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     i = 0;
     while ((name = cpu_model_advertised_features[i++]) != NULL) {
-        ObjectProperty *prop = object_property_find(obj, name, NULL);
+        ObjectProperty *prop = object_property_find(obj, name);
         if (prop) {
             QObject *value;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1c58f764dcb..3ffd877dd51 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6828,7 +6828,7 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
     ObjectProperty *op;
     uint64_t mask = (1ULL << bitnr);
 
-    op = object_property_find(OBJECT(cpu), prop_name, NULL);
+    op = object_property_find(OBJECT(cpu), prop_name);
     if (op) {
         fp = op->opaque;
         assert(fp->w == w);
diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
index accb4f2faea..bb66526280e 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -10478,7 +10478,7 @@ static void ppc_cpu_parse_featurestr(const char *type, char *features,
         return;
     }
 
-    if (object_property_find(machine, "max-cpu-compat", NULL)) {
+    if (object_property_find(machine, "max-cpu-compat")) {
         int i;
         char **inpieces;
         char *s = features;
-- 
2.26.2


