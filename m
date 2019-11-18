Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49011C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149472073A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mAsMFMsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149472073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWf3s-00053g-4x
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1iWeys-0003KB-Ti
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1iWeyr-0005Lj-1b
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:14:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1iWeyq-0005LS-PQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:14:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIB4Rql036052;
 Mon, 18 Nov 2019 11:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=paYTcUShLjy8qkX+FnQ1+x7C2Qj+3DLeBvn7VIoqEJM=;
 b=mAsMFMsn4cg8/alTBkX4oH9LQOKCwW+3z0sEljr1B+DrDi3JQLLOwFb1R+ILDAprDRg8
 E9bo2vzSB6DW9VgcFv4MUAiT7op0vK9vDVT7JCezJHfoXQyk5pDdOi9qNZicDlioIwi5
 FGyIVFfou26jyFfHdUBoAPHf7pD2VS2plwO8xhgkwLmHJbpiii/kgb64RLnUh4erDSKa
 05L1QT/0m7QtdITJhJpK9eCllj6G+AI7yLWK/oTgvff3Zdt3SfcdhijA5kReBJO2VzDL
 wpVg2qiBqeMDQa1fwFDQcrv3H6BistzTtnuQkaPpLS7lTWzLU0Ko+S1q0H18CHfdWhA5 qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2wa8htfhgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 11:14:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIBDpGQ157861;
 Mon, 18 Nov 2019 11:14:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2wau94dw33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 11:14:00 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAIBDT8F017547;
 Mon, 18 Nov 2019 11:13:29 GMT
Received: from ol7.nl.oracle.com (/10.175.20.22)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 18 Nov 2019 03:13:29 -0800
From: Liam Merwick <liam.merwick@oracle.com>
To: slp@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, 
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: [PATCH v2] hw/i386: Move save_tsc_khz from PCMachineClass to
 X86MachineClass
Date: Mon, 18 Nov 2019 11:13:25 +0000
Message-Id: <1574075605-25215-1-git-send-email-liam.merwick@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180101
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: qemu-devel@nongnu.org, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attempting to migrate a VM using the microvm machine class results in the source
QEMU aborting with the following message/backtrace:

target/i386/machine.c:955:tsc_khz_needed: Object 0x555556608fa0 is not an
instance of type generic-pc-machine

abort()
object_class_dynamic_cast_assert()
vmstate_save_state_v()
vmstate_save_state()
vmstate_save()
qemu_savevm_state_complete_precopy()
migration_thread()
migration_thread()
migration_thread()
qemu_thread_start()
start_thread()
clone()

The access to the machine class returned by MACHINE_GET_CLASS() in
tsc_khz_needed() is crashing as it is trying to dereference a different
type of machine class object (TYPE_PC_MACHINE) to that of this microVM.

This can be resolved by extending the changes in the following commit
f0bb276bf8d5 ("hw/i386: split PCMachineState deriving X86MachineState from it")
and moving the save_tsc_khz field in PCMachineClass to X86MachineClass.

Fixes: f0bb276bf8d5 ("hw/i386: split PCMachineState deriving X86MachineState from it")
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---

v1 -> v2 - fix SHA1 of patch being referenced.

 hw/i386/pc.c          | 1 -
 hw/i386/pc_piix.c     | 4 ++--
 hw/i386/pc_q35.c      | 4 ++--
 hw/i386/x86.c         | 1 +
 include/hw/i386/pc.h  | 2 --
 include/hw/i386/x86.h | 2 ++
 target/i386/machine.c | 4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 96715f8a3f99..ac08e6360437 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2195,7 +2195,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
      * to be used at the moment, 32K should be enough for a while.  */
     pcmc->acpi_data_size = 0x20000 + 0x8000;
-    pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
     pcmc->pvh_enabled = true;
     assert(!mc->get_hotplug_handler);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2aefa3b8dfe3..0548c259dc74 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -567,10 +567,10 @@ DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
 
 static void pc_i440fx_2_5_machine_options(MachineClass *m)
 {
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
 
     pc_i440fx_2_6_machine_options(m);
-    pcmc->save_tsc_khz = false;
+    x86mc->save_tsc_khz = false;
     m->legacy_fw_cfg_order = 1;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d51f5247276d..385e5cffb167 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -508,10 +508,10 @@ DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
 
 static void pc_q35_2_5_machine_options(MachineClass *m)
 {
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
 
     pc_q35_2_6_machine_options(m);
-    pcmc->save_tsc_khz = false;
+    x86mc->save_tsc_khz = false;
     m->legacy_fw_cfg_order = 1;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index fd84b23124e6..394edc2f7209 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -763,6 +763,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     x86mc->compat_apic_id_mode = false;
+    x86mc->save_tsc_khz = true;
     nc->nmi_monitor_handler = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e6fa8418ca61..1f86eba3f998 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -116,8 +116,6 @@ typedef struct PCMachineClass {
     bool enforce_aligned_dimm;
     bool broken_reserved_end;
 
-    /* TSC rate migration: */
-    bool save_tsc_khz;
     /* generate legacy CPU hotplug AML */
     bool legacy_cpu_hotplug;
 
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 82d09fd7d099..4b8491788526 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -30,6 +30,8 @@ typedef struct {
 
     /*< public >*/
 
+    /* TSC rate migration: */
+    bool save_tsc_khz;
     /* Enables contiguous-apic-ID mode */
     bool compat_apic_id_mode;
 } X86MachineClass;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 6481f846f6e9..7bdeb7815755 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -988,8 +988,8 @@ static bool tsc_khz_needed(void *opaque)
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
-    return env->tsc_khz && pcmc->save_tsc_khz;
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(mc);
+    return env->tsc_khz && x86mc->save_tsc_khz;
 }
 
 static const VMStateDescription vmstate_tsc_khz = {
-- 
1.8.3.1


