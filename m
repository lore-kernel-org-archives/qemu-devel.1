Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E405C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDE92082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxNaxz5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDE92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIbB-000071-Ti
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1izIVV-0008Vo-4S
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1izIVS-0006Ne-Kp
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:06:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1izIVS-0006LZ-Gf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N9+b7e4x5yznvSmGThVN1j4c9ZkLyTEFvHz5YPIdIE8=;
 b=VxNaxz5C4nsMu4EOZozt47ErbxlwJsjBJ9tvSA9ezg/aoZAUT31wAttnHmRosxdtrRYjKo
 A92dTvPTJMTHoPOCd6g+m4xwW22KohZ5ar4imbfvsA2SwIxEnZ0yIEcc8bXvCzps5Ing1V
 YFWQ6kBjCYfClZim9u+LFqEPJAM3S2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-zsCF2bmbM7qXBewNLrRftw-1; Wed, 05 Feb 2020 06:06:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90E9A1835A04;
 Wed,  5 Feb 2020 11:06:02 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-31.bne.redhat.com
 [10.64.54.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11075790C0;
 Wed,  5 Feb 2020 11:05:58 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RESEND RFC PATCH v2 2/2] target/arm: Support NMI injection
Date: Wed,  5 Feb 2020 22:05:41 +1100
Message-Id: <20200205110541.37811-3-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: zsCF2bmbM7qXBewNLrRftw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 aik@ozlabs.ru, maz@kernel.org, eric.auger@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This supports QMP/HMP "nmi" command by injecting SError interrupt to
guest, which is expected to crash with that. Currently, It's supported
on two CPU models: "host" and "max".

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/virt.c          | 18 ++++++++++++++++
 target/arm/cpu-qom.h   |  1 +
 target/arm/cpu.c       | 48 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c     | 25 ++++++++++++++++++----
 target/arm/internals.h |  8 +++++++
 5 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe27d6..883861a28a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,6 +71,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/nmi.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -2026,10 +2027,25 @@ static int virt_kvm_type(MachineState *ms, const ch=
ar *type_str)
     return requested_pa_size > 40 ? requested_pa_size : 0;
 }
=20
+static void virt_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    ARMCPUClass *acc;
+    CPUState *cpu =3D first_cpu;
+
+    acc =3D ARM_CPU_GET_CLASS(OBJECT(cpu));
+    if (!acc->inject_nmi) {
+        error_setg(errp, "NMI injection not supported");
+        return;
+    }
+
+    acc->inject_nmi(cpu, errp);
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
@@ -2058,6 +2074,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
     hc->unplug_request =3D virt_machine_device_unplug_request_cb;
     mc->numa_mem_supported =3D true;
     mc->auto_enable_numa_with_memhp =3D true;
+    nc->nmi_monitor_handler =3D virt_nmi;
 }
=20
 static void virt_instance_init(Object *obj)
@@ -2141,6 +2158,7 @@ static const TypeInfo virt_machine_info =3D {
     .instance_init =3D virt_instance_init,
     .interfaces =3D (InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
+         { TYPE_NMI },
          { }
     },
 };
diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 7f5b244bde..853f0f3ca5 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -52,6 +52,7 @@ typedef struct ARMCPUClass {
     const ARMCPUInfo *info;
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
+    void (*inject_nmi)(CPUState *cpu, Error **errp);
 } ARMCPUClass;
=20
 typedef struct ARMCPU ARMCPU;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 24fd77437b..f0ef315f3b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -475,6 +475,44 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrup=
t_request)
     return ret;
 }
=20
+#ifdef CONFIG_KVM
+static void do_inject_nmi_kvm(CPUState *cpu, run_on_cpu_data data)
+{
+    struct kvm_vcpu_events events;
+    Error **errp =3D data.host_ptr;
+    int ret;
+
+    if (!kvm_has_vcpu_events()) {
+        error_setg(errp, "vCPU events not supported");
+        return;
+    }
+
+    memset(&events, 0, sizeof(events));
+    events.exception.serror_pending =3D 1;
+    ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
+    if (ret) {
+        error_setg(errp, "Error to inject vCPU events");
+    }
+}
+#endif
+
+/* The guest is expected to crash once receiving the SError interrupt */
+static void do_inject_nmi(CPUState *cpu, run_on_cpu_data data)
+{
+    cpu_synchronize_state(cpu);
+
+#ifdef CONFIG_KVM
+    return do_inject_nmi_kvm(cpu, data);
+#endif
+
+    cpu_interrupt(cpu, CPU_INTERRUPT_SERROR);
+}
+
+void arm_cpu_inject_nmi(CPUState *cpu, Error **errp)
+{
+    async_run_on_cpu(cpu, do_inject_nmi, RUN_ON_CPU_HOST_PTR(errp));
+}
+
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
 static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request=
)
 {
@@ -2759,10 +2797,20 @@ static void arm_host_initfn(Object *obj)
     arm_cpu_post_init(obj);
 }
=20
+#ifdef TARGET_AARCH64
+static void arm_host_class_init(ObjectClass *oc, void *data)
+{
+    ARMCPUClass *acc =3D ARM_CPU_CLASS(oc);
+
+    acc->inject_nmi =3D arm_cpu_inject_nmi;
+}
+#endif /* TARGET_AARCH64 */
+
 static const TypeInfo host_arm_cpu_type_info =3D {
     .name =3D TYPE_ARM_HOST_CPU,
 #ifdef TARGET_AARCH64
     .parent =3D TYPE_AARCH64_CPU,
+    .class_init =3D arm_host_class_init,
 #else
     .parent =3D TYPE_ARM_CPU,
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2d97bf45e1..66e746f66b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "internals.h"
 #include "qemu/module.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
@@ -713,6 +714,14 @@ static void aarch64_max_initfn(Object *obj)
                         cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
 }
=20
+static void aarch64_max_class_init(ObjectClass *oc, void *data)
+{
+    ARMCPUClass *acc =3D ARM_CPU_CLASS(oc);
+
+    acc->inject_nmi =3D arm_cpu_inject_nmi;
+    acc->info =3D data;
+}
+
 struct ARMCPUInfo {
     const char *name;
     void (*initfn)(Object *obj);
@@ -720,10 +729,18 @@ struct ARMCPUInfo {
 };
=20
 static const ARMCPUInfo aarch64_cpus[] =3D {
-    { .name =3D "cortex-a57",         .initfn =3D aarch64_a57_initfn },
-    { .name =3D "cortex-a53",         .initfn =3D aarch64_a53_initfn },
-    { .name =3D "cortex-a72",         .initfn =3D aarch64_a72_initfn },
-    { .name =3D "max",                .initfn =3D aarch64_max_initfn },
+    { .name =3D "cortex-a57",
+      .class_init =3D NULL,
+      .initfn =3D aarch64_a57_initfn },
+    { .name =3D "cortex-a53",
+      .class_init =3D NULL,
+      .initfn =3D aarch64_a53_initfn },
+    { .name =3D "cortex-a72",
+      .class_init =3D NULL,
+      .initfn =3D aarch64_a72_initfn },
+    { .name =3D "max",
+      .class_init =3D aarch64_max_class_init,
+      .initfn =3D aarch64_max_initfn },
     { .name =3D NULL }
 };
=20
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5313dd3d4..6a922fbc98 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -949,6 +949,14 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
=20
+/**
+ * arm_cpu_inject_nmi: Inject SError exception
+ *
+ * Inject SError exception to trigger kernel panic inside the guest. That'=
s
+ * the simulated behavior as to other architectures like x86.
+ */
+void arm_cpu_inject_nmi(CPUState *cpu, Error **errp);
+
 /**
  * arm_mmu_idx_el:
  * @env: The cpu environment
--=20
2.23.0


