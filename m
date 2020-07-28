Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC16C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EB320775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuZ4lKtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EB320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ME0-0006DI-Vg
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0MCR-0004eR-DZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:47:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0MCO-0003xj-7y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595929623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oGixnmN5ECx8+42m7De8D80tinyjrxrKYytchUbA1s4=;
 b=NuZ4lKtmEqHW2Zd1QYM1EhU1FMwUv0S4a+fu8Te1o69E2/y1xdM9kK3gqjig7MjnlH+W2w
 nvUKTErwfGle5WrHtY2iFnZniM2i/6zfbNdxIJg/zrcJW8RH3MT4QvOx1s+waz+LIyJ55h
 fJk0Ba5iVnRwoBZ5AP186nFwv2oQOQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-tGInl10CNQqZXrJwO6w7tw-1; Tue, 28 Jul 2020 05:46:59 -0400
X-MC-Unique: tGInl10CNQqZXrJwO6w7tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F26B71083E83;
 Tue, 28 Jul 2020 09:46:57 +0000 (UTC)
Received: from localhost (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B32590E69;
 Tue, 28 Jul 2020 09:46:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] hw: add compat machines for 5.2
Date: Tue, 28 Jul 2020 11:46:45 +0200
Message-Id: <20200728094645.272149-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add 5.2 machine types for arm/i440fx/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 9 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ecfee362a182..acf9bfbeceaf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2546,10 +2546,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_5_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(5, 2)
+
 static void virt_machine_5_1_options(MachineClass *mc)
 {
+    virt_machine_5_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
+DEFINE_VIRT_MACHINE(5, 1)
 
 static void virt_machine_5_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2f881d6d75b8..a24fe18ab6a6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,6 +28,9 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
 
+GlobalProperty hw_compat_5_1[] = {};
+const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
+
 GlobalProperty hw_compat_5_0[] = {
     { "virtio-balloon-device", "page-poison", "false" },
     { "vmport", "x-read-set-eax", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d419d599127..1733b5341a62 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -97,6 +97,9 @@
 #include "fw_cfg.h"
 #include "trace.h"
 
+GlobalProperty pc_compat_5_1[] = {};
+const size_t pc_compat_5_1_len = G_N_ELEMENTS(pc_compat_5_1);
+
 GlobalProperty pc_compat_5_0[] = {};
 const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b789e83f9acb..c5ba70ca17cb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,7 +426,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
 
-static void pc_i440fx_5_1_machine_options(MachineClass *m)
+static void pc_i440fx_5_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
@@ -435,6 +435,18 @@ static void pc_i440fx_5_1_machine_options(MachineClass *m)
     pcmc->default_cpu_version = 1;
 }
 
+DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
+                      pc_i440fx_5_2_machine_options);
+
+static void pc_i440fx_5_1_machine_options(MachineClass *m)
+{
+    pc_i440fx_5_2_machine_options(m);
+    m->alias = NULL;
+    m->is_default = false;
+    compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
+}
+
 DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
                       pc_i440fx_5_1_machine_options);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a3e607a544a5..0cb9c18cd44d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -353,7 +353,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_5_1_machine_options(MachineClass *m)
+static void pc_q35_5_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
@@ -361,6 +361,17 @@ static void pc_q35_5_1_machine_options(MachineClass *m)
     pcmc->default_cpu_version = 1;
 }
 
+DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
+                   pc_q35_5_2_machine_options);
+
+static void pc_q35_5_1_machine_options(MachineClass *m)
+{
+    pc_q35_5_2_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
+}
+
 DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
                    pc_q35_5_1_machine_options);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0ae293ec9431..1c8d0981b382 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4579,15 +4579,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-5.2
+ */
+static void spapr_machine_5_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
+
 /*
  * pseries-5.1
  */
 static void spapr_machine_5_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_5_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
 }
 
-DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
+DEFINE_SPAPR_MACHINE(5_1, "5.1", false);
 
 /*
  * pseries-5.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 403d30e13bca..3dc22737a389 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -804,14 +804,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_5_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_5_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(5_2, "5.2", true);
+
 static void ccw_machine_5_1_instance_options(MachineState *machine)
 {
+    ccw_machine_5_2_instance_options(machine);
 }
 
 static void ccw_machine_5_1_class_options(MachineClass *mc)
 {
+    ccw_machine_5_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
 }
-DEFINE_CCW_MACHINE(5_1, "5.1", true);
+DEFINE_CCW_MACHINE(5_1, "5.1", false);
 
 static void ccw_machine_5_0_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 426ce5f625a4..bc5b82ad209e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -319,6 +319,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_5_1[];
+extern const size_t hw_compat_5_1_len;
+
 extern GlobalProperty hw_compat_5_0[];
 extern const size_t hw_compat_5_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3d7ed3a55e30..fe52e165b27c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -193,6 +193,9 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
 
+extern GlobalProperty pc_compat_5_1[];
+extern const size_t pc_compat_5_1_len;
+
 extern GlobalProperty pc_compat_5_0[];
 extern const size_t pc_compat_5_0_len;
 
-- 
2.25.4


