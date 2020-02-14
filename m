Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B3C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3B1222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJVOo/z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3B1222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2U2f-0000su-3A
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j2U1U-0008GI-Ap
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j2U1S-0005Td-Ra
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:00:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j2U1S-0005Sl-M9
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581660018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tySIqj25vFkbJUOWFkZJcKmdOpzjeZeQsC3TdET8Seg=;
 b=TJVOo/z9+bQWzrVbFKuulIeXewoyFNd5wmUsVxraLZW3HSJG+W/ABzr2qOwed07dqq8q7Y
 rUhaVtdTZxQ8xOOTStZMpfdlX8vu1Y0rn+wBF+2gIiaEetX+b3IWL05wi1zstd3FeZsbRt
 O3b/nhhrzZWjLt34U6H3u7+RQb6mMBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-tBOdov_nNtuRPh-yqeYsWg-1; Fri, 14 Feb 2020 01:00:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDF48010EF;
 Fri, 14 Feb 2020 06:00:13 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-93.bne.redhat.com
 [10.64.54.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D8A41001B30;
 Fri, 14 Feb 2020 06:00:09 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v3 2/2] hw/arm/virt: Simulate NMI injection
Date: Fri, 14 Feb 2020 16:59:50 +1100
Message-Id: <20200214055950.62477-3-gshan@redhat.com>
In-Reply-To: <20200214055950.62477-1-gshan@redhat.com>
References: <20200214055950.62477-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: tBOdov_nNtuRPh-yqeYsWg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, richard.henderson@linaro.org,
 eric.auger@redhat.com, shan.gavin@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements the backend to support HMP/QMP "nmi" command, which is
used to inject NMI interrupt to crash guest for debugging purpose. As
ARM architecture doesn't have NMI supported, so we're simulating the
behaviour by injecting SError or data abort to guest for "virt" board.

An additonal IRQ line is introduced for SError on each CPU. The IRQ line
is connected to SError exception handler. The IRQ line on CPU#0 is raised
when HMP/QMP "nmi" is issued to inject SError or data abort to crash guest.
Note the IRQ line can be shared with other devices who want to have the
capability of reporting errors in future.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/virt.c                      | 34 +++++++++++++++++++++++++++++-
 hw/intc/arm_gic_common.c           |  3 +++
 hw/intc/arm_gicv3_common.c         |  3 +++
 include/hw/intc/arm_gic_common.h   |  1 +
 include/hw/intc/arm_gicv3_common.h |  1 +
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe27d6..78549faa75 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,6 +71,8 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
+#include "sysemu/hw_accel.h"
+#include "hw/nmi.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -690,7 +692,7 @@ static void create_gic(VirtMachineState *vms)
         } else if (vms->virt) {
             qemu_irq irq =3D qdev_get_gpio_in(vms->gic,
                                             ppibase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus, irq);
         }
=20
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
@@ -704,6 +706,8 @@ static void create_gic(VirtMachineState *vms)
                            qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
         sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_SERROR));
     }
=20
     fdt_add_gic_node(vms);
@@ -2026,10 +2030,36 @@ static int virt_kvm_type(MachineState *ms, const ch=
ar *type_str)
     return requested_pa_size > 40 ? requested_pa_size : 0;
 }
=20
+
+static void do_inject_serror(CPUState *cpu, run_on_cpu_data data)
+{
+    VirtMachineState *vms =3D data.host_ptr;
+    GICv3State *gicv3;
+    GICState *gicv2;
+
+    cpu_synchronize_state(cpu);
+
+    if (vms->gic_version =3D=3D 3) {
+        gicv3 =3D ARM_GICV3_COMMON(OBJECT(vms->gic));
+        qemu_irq_raise(gicv3->cpu[0].parent_serror);
+    } else {
+        gicv2 =3D ARM_GIC_COMMON(OBJECT(vms->gic));
+        qemu_irq_raise(gicv2->parent_serror[0]);
+    }
+}
+
+static void virt_inject_serror(NMIState *n, int cpu_index, Error **errp)
+{
+    VirtMachineState *vms =3D VIRT_MACHINE(n);
+
+    async_run_on_cpu(first_cpu, do_inject_serror, RUN_ON_CPU_HOST_PTR(vms)=
);
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
+    NMIClass *nc =3D NMI_CLASS(oc);
=20
     mc->init =3D machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by K=
VM.
@@ -2058,6 +2088,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
     hc->unplug_request =3D virt_machine_device_unplug_request_cb;
     mc->numa_mem_supported =3D true;
     mc->auto_enable_numa_with_memhp =3D true;
+    nc->nmi_monitor_handler =3D virt_inject_serror;
 }
=20
 static void virt_instance_init(Object *obj)
@@ -2141,6 +2172,7 @@ static const TypeInfo virt_machine_info =3D {
     .instance_init =3D virt_instance_init,
     .interfaces =3D (InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
+         { TYPE_NMI },
          { }
     },
 };
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index e6c4fe7a5a..f39cefdeea 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -155,6 +155,9 @@ void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handl=
er handler,
     for (i =3D 0; i < s->num_cpu; i++) {
         sysbus_init_irq(sbd, &s->parent_vfiq[i]);
     }
+    for (i =3D 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->parent_serror[i]);
+    }
     if (s->virt_extn) {
         for (i =3D 0; i < s->num_cpu; i++) {
             sysbus_init_irq(sbd, &s->maintenance_irq[i]);
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 58ef65f589..19a04449a0 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -288,6 +288,9 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_h=
andler handler,
     for (i =3D 0; i < s->num_cpu; i++) {
         sysbus_init_irq(sbd, &s->cpu[i].parent_vfiq);
     }
+    for (i =3D 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->cpu[i].parent_serror);
+    }
=20
     memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
                           "gicv3_dist", 0x10000);
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_com=
mon.h
index b5585fec45..4cdeed7725 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -70,6 +70,7 @@ typedef struct GICState {
     qemu_irq parent_fiq[GIC_NCPU];
     qemu_irq parent_virq[GIC_NCPU];
     qemu_irq parent_vfiq[GIC_NCPU];
+    qemu_irq parent_serror[GIC_NCPU];
     qemu_irq maintenance_irq[GIC_NCPU];
=20
     /* GICD_CTLR; for a GIC with the security extensions the NS banked ver=
sion
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3=
_common.h
index 31ec9a1ae4..a025a04727 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -152,6 +152,7 @@ struct GICv3CPUState {
     qemu_irq parent_fiq;
     qemu_irq parent_virq;
     qemu_irq parent_vfiq;
+    qemu_irq parent_serror;
     qemu_irq maintenance_irq;
=20
     /* Redistributor */
--=20
2.23.0


