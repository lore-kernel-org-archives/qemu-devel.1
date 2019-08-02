Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27880C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016A22086A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016A22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htU2M-0008FB-BF
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1htU1j-0006zI-BL
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1htU1h-0000x3-Kk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:39:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1htU1h-0000wc-DW; Fri, 02 Aug 2019 05:39:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AED8CC0586AE;
 Fri,  2 Aug 2019 09:39:04 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4181519C6A;
 Fri,  2 Aug 2019 09:39:03 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:38:51 -0400
Message-Id: <20190802093854.5343-2-imammedo@redhat.com>
In-Reply-To: <20190802093854.5343-1-imammedo@redhat.com>
References: <20190802093854.5343-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 02 Aug 2019 09:39:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC v2 1/4] hw: add compat machines for 4.2
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

Add 4.2 machine types for arm/i440fx/q35/s390x/spapr.

For i440fx and q35, unversioned cpu models are still translated
to -v1, as 0788a56bd1ae ("i386: Make unversioned CPU models be
aliases") states this should only transition to the latest cpu
model version in 4.3 (or later).

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 9 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a71d1a53a5..d9ec37d807 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -317,6 +317,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_4_1[];
+extern const size_t hw_compat_4_1_len;
+
 extern GlobalProperty hw_compat_4_0[];
 extern const size_t hw_compat_4_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 859b64c51d..c840e39251 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -302,6 +302,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+extern GlobalProperty pc_compat_4_1[];
+extern const size_t pc_compat_4_1_len;
+
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d9496c9363..64e3fc3440 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2046,10 +2046,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_4_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
+
 static void virt_machine_4_1_options(MachineClass *mc)
 {
+    virt_machine_4_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(4, 1)
+DEFINE_VIRT_MACHINE(4, 1)
 
 static void virt_machine_4_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 28a475ad97..fd76dad859 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
+GlobalProperty hw_compat_4_1[] = {};
+const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
+
 GlobalProperty hw_compat_4_0[] = {
     { "VGA",            "edid", "false" },
     { "secondary-vga",  "edid", "false" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..2aa1c49701 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -116,6 +116,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
+GlobalProperty pc_compat_4_1[] = {};
+const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
+
 GlobalProperty pc_compat_4_0[] = {};
 const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c2280c72ef..24e71be1d2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -433,7 +433,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
 
-static void pc_i440fx_4_1_machine_options(MachineClass *m)
+static void pc_i440fx_4_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
@@ -442,6 +442,18 @@ static void pc_i440fx_4_1_machine_options(MachineClass *m)
     pcmc->default_cpu_version = 1;
 }
 
+DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
+                      pc_i440fx_4_2_machine_options);
+
+static void pc_i440fx_4_1_machine_options(MachineClass *m)
+{
+    pc_i440fx_4_2_machine_options(m);
+    m->alias = NULL;
+    m->is_default = 0;
+    compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
+    compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
+}
+
 DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
                       pc_i440fx_4_1_machine_options);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 397e1fdd2f..e61260762c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -365,7 +365,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_4_1_machine_options(MachineClass *m)
+static void pc_q35_4_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
@@ -373,6 +373,17 @@ static void pc_q35_4_1_machine_options(MachineClass *m)
     pcmc->default_cpu_version = 1;
 }
 
+DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
+                   pc_q35_4_2_machine_options);
+
+static void pc_q35_4_1_machine_options(MachineClass *m)
+{
+    pc_q35_4_2_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
+    compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
+}
+
 DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
                    pc_q35_4_1_machine_options);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49..6c8aa60545 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4426,15 +4426,26 @@ static const TypeInfo spapr_machine_info = {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-4.2
+ */
+static void spapr_machine_4_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
+
 /*
  * pseries-4.1
  */
 static void spapr_machine_4_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_4_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
 }
 
-DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
+DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
 
 /*
  * pseries-4.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5b6a9a4e55..593b34e0e2 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -660,14 +660,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_4_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_4_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(4_2, "4.2", true);
+
 static void ccw_machine_4_1_instance_options(MachineState *machine)
 {
+    ccw_machine_4_2_instance_options(machine);
 }
 
 static void ccw_machine_4_1_class_options(MachineClass *mc)
 {
+    ccw_machine_4_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
 }
-DEFINE_CCW_MACHINE(4_1, "4.1", true);
+DEFINE_CCW_MACHINE(4_1, "4.1", false);
 
 static void ccw_machine_4_0_instance_options(MachineState *machine)
 {
-- 
2.18.1


