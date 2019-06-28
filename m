Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D1C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6032B2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6032B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgx6Y-0003WC-JL
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 16:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39033)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgx4x-0002xq-En
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgx4u-00049w-Pm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgx4u-00049Y-HV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:02:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6631031628FF;
 Fri, 28 Jun 2019 20:02:34 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 795BD5C88A;
 Fri, 28 Jun 2019 20:02:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 17:02:27 -0300
Message-Id: <20190628200227.1053-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 28 Jun 2019 20:02:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] pc: Move compat_apic_id_mode variable to
 PCMachineClass
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the static variable with a PCMachineClass field.  This
will help us eventually get rid of the pc_compat_*() init
functions.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  3 +++
 hw/i386/pc.c         | 22 +++++++++-------------
 hw/i386/pc_piix.c    |  3 ++-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c54cc54a47..853502f277 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -134,6 +134,9 @@ typedef struct PCMachineClass {
 
     /* use PVH to load kernels that support this feature */
     bool pvh_enabled;
+
+    /* Enables contiguous-apic-ID mode */
+    bool compat_apic_id_mode;
 } PCMachineClass;
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e96360b47a..3983621f1c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -913,14 +913,6 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
     return false;
 }
 
-/* Enables contiguous-apic-ID mode, for compatibility */
-static bool compat_apic_id_mode;
-
-void enable_compat_apic_id_mode(void)
-{
-    compat_apic_id_mode = true;
-}
-
 /* Calculates initial APIC ID for a specific CPU index
  *
  * Currently we need to be able to calculate the APIC ID from the CPU index
@@ -928,13 +920,15 @@ void enable_compat_apic_id_mode(void)
  * no concept of "CPU index", and the NUMA tables on fw_cfg need the APIC ID of
  * all CPUs up to max_cpus.
  */
-static uint32_t x86_cpu_apic_id_from_index(unsigned int cpu_index)
+static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+                                           unsigned int cpu_index)
 {
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     uint32_t correct_id;
     static bool warned;
 
     correct_id = x86_apicid_from_cpu_idx(smp_cores, smp_threads, cpu_index);
-    if (compat_apic_id_mode) {
+    if (pcmc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
                          "CPU topology won't match the configuration");
@@ -1533,7 +1527,8 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
 void pc_hot_add_cpu(const int64_t id, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    int64_t apic_id = x86_cpu_apic_id_from_index(id);
+    PCMachineState *pcms = PC_MACHINE(ms);
+    int64_t apic_id = x86_cpu_apic_id_from_index(pcms, id);
     Error *local_err = NULL;
 
     if (id < 0) {
@@ -1569,7 +1564,7 @@ void pc_cpus_init(PCMachineState *pcms)
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
      */
-    pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
+    pcms->apic_id_limit = x86_cpu_apic_id_from_index(pcms, max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < smp_cpus; i++) {
         pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
@@ -2660,6 +2655,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 {
+    PCMachineState *pcms = PC_MACHINE(ms);
     int i;
 
     if (ms->possible_cpus) {
@@ -2679,7 +2675,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
+        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  smp_cores, smp_threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c07c4a5b38..f29de58636 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -358,7 +358,6 @@ static void pc_compat_1_4_fn(MachineState *machine)
 static void pc_compat_1_3(MachineState *machine)
 {
     pc_compat_1_4_fn(machine);
-    enable_compat_apic_id_mode();
 }
 
 /* PC compat function for pc-0.14 to pc-1.2 */
@@ -708,6 +707,7 @@ DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4_fn,
 
 static void pc_i440fx_1_3_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("1.3.0")
         { "usb-tablet", "usb_version", "1" },
@@ -718,6 +718,7 @@ static void pc_i440fx_1_3_machine_options(MachineClass *m)
 
     pc_i440fx_1_4_machine_options(m);
     m->hw_version = "1.3.0";
+    pcmc->compat_apic_id_mode = true;
     compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
-- 
2.18.0.rc1.1.g3f1ff2140


