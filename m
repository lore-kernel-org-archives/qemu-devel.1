Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51460C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D68F20663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D68F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLXe-0006w6-F7
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiKp8-0007PA-15
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiKp5-0005dl-Lt
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiKp5-0005bW-Bc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 311C13086205;
 Tue,  2 Jul 2019 15:35:56 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B73033737;
 Tue,  2 Jul 2019 15:35:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Tue,  2 Jul 2019 12:35:02 -0300
Message-Id: <20190702153535.9851-10-ehabkost@redhat.com>
In-Reply-To: <20190702153535.9851-1-ehabkost@redhat.com>
References: <20190702153535.9851-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 02 Jul 2019 15:35:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 09/42] hw: Replace global smp variables with
 MachineState for all remaining archs
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
Cc: Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

The global smp variables in alpha/hppa/mips/openrisc/sparc*/xtensa codes
are replaced with smp properties from MachineState.

A local variable of the same name would be introduced in the declaration
phase if it's used widely in the context OR replace it on the spot if it's
only used once. No semantic changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20190518205428.90532-10-like.xu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/alpha/dp264.c           | 1 +
 hw/hppa/machine.c          | 2 ++
 hw/mips/boston.c           | 2 +-
 hw/mips/mips_malta.c       | 2 ++
 hw/openrisc/openrisc_sim.c | 1 +
 hw/sparc/sun4m.c           | 2 ++
 hw/sparc64/sun4u.c         | 4 ++--
 hw/xtensa/sim.c            | 2 +-
 hw/xtensa/xtfpga.c         | 1 +
 9 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 0347eb897c..9dfb835013 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -63,6 +63,7 @@ static void clipper_init(MachineState *machine)
     char *palcode_filename;
     uint64_t palcode_entry, palcode_low, palcode_high;
     uint64_t kernel_entry, kernel_low, kernel_high;
+    unsigned int smp_cpus = machine->smp.cpus;
 
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 416e67bab1..662838d83b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -72,6 +72,7 @@ static void machine_hppa_init(MachineState *machine)
     MemoryRegion *ram_region;
     MemoryRegion *cpu_region;
     long i;
+    unsigned int smp_cpus = machine->smp.cpus;
 
     ram_size = machine->ram_size;
 
@@ -242,6 +243,7 @@ static void machine_hppa_init(MachineState *machine)
 
 static void hppa_machine_reset(MachineState *ms)
 {
+    unsigned int smp_cpus = ms->smp.cpus;
     int i;
 
     qemu_devices_reset();
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 749582e5aa..9eeccbea9a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -458,7 +458,7 @@ static void boston_mach_init(MachineState *machine)
                           sizeof(s->cps), TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-type",
                             &err);
-    object_property_set_int(OBJECT(&s->cps), smp_cpus, "num-vp", &err);
+    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp", &err);
     object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
 
     if (err != NULL) {
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 132127882d..20e019bf66 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1095,6 +1095,8 @@ static int64_t load_kernel (void)
 
 static void malta_mips_config(MIPSCPU *cpu)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int smp_cpus = ms->smp.cpus;
     CPUMIPSState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 87b9feaa96..b85f0df323 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -130,6 +130,7 @@ static void openrisc_sim_init(MachineState *machine)
     qemu_irq *cpu_irqs[2];
     qemu_irq serial_irq;
     int n;
+    unsigned int smp_cpus = machine->smp.cpus;
 
     for (n = 0; n < smp_cpus; n++) {
         cpu = OPENRISC_CPU(cpu_create(machine->cpu_type));
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 7e4f61fc3e..a8004a5fe3 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -871,6 +871,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     FWCfgState *fw_cfg;
     DeviceState *dev;
     SysBusDevice *s;
+    unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int max_cpus = machine->smp.max_cpus;
 
     /* init CPUs */
     for(i = 0; i < smp_cpus; i++) {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 4230b17b87..5d87be811d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -697,8 +697,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                                 &FW_CFG_IO(dev)->comb_iomem);
 
     fw_cfg = FW_CFG(dev);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)machine->smp.cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, hwdef->machine_id);
     fw_cfg_add_i64(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_entry);
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index b6922c39d5..09165b6f4d 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -59,7 +59,7 @@ static void xtensa_sim_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     int n;
 
-    for (n = 0; n < smp_cpus; n++) {
+    for (n = 0; n < machine->smp.cpus; n++) {
         cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
         env = &cpu->env;
 
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index e05ef75a75..f7f3e11e93 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -238,6 +238,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     const unsigned system_io_size = 224 * MiB;
     uint32_t freq = 10000000;
     int n;
+    unsigned int smp_cpus = machine->smp.cpus;
 
     if (smp_cpus > 1) {
         mx_pic = xtensa_mx_pic_init(31);
-- 
2.18.0.rc1.1.g3f1ff2140


