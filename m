Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC198C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E9C20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpPH1Etn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E9C20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtw2h-00067e-UC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtvjK-00025v-VY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:18:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtvjI-0005aG-VQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594397908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YS3EUTQ0l8ceq/oSCvz304x4tc+rVeDBnloFqce7ihk=;
 b=TpPH1EtnYWVpbutUbzE0ZOPPxXC++aczdKZndPdUKK7q4vTv65S6q6FVHrkm9lMHJnL0Lx
 Vl7agmeEHA5K7fSo1nesag9u/RqbmE/aPefgzPE1Bbh4RLpejBoiM18XqCu5yrOTsaaMA4
 56a27B0MbRcSkL9PKn1lv0gR2TTdDC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-xweXzFGGMquANDjqg556uA-1; Fri, 10 Jul 2020 12:17:15 -0400
X-MC-Unique: xweXzFGGMquANDjqg556uA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 507A9107ACCA;
 Fri, 10 Jul 2020 16:17:14 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 523787EFA5;
 Fri, 10 Jul 2020 16:17:13 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 3/3] x68: acpi: trigger SMI before scanning for hotplugged CPUs
Date: Fri, 10 Jul 2020 12:17:04 -0400
Message-Id: <20200710161704.309824-4-imammedo@redhat.com>
In-Reply-To: <20200710161704.309824-1-imammedo@redhat.com>
References: <20200710161704.309824-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lersek@redhat.com, boris.ostrovsky@oracle.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case firmware has negotiated CPU hotplug SMI feature, generate
AML to describe SMI IO port region and send SMI to firmware
on each CPU hotplug SCI.

It might be not really usable, but should serve as a starting point to
discuss how better to deal with split hotplug sequence during hot-add
(
ex scenario where it will break is:
   hot-add
      -> (QEMU) add CPU in hotplug regs
      -> (QEMU) SCI
           -1-> (OS) scan
               -1-> (OS) SMI
               -1-> (FW) pull in CPU1 ***
               -1-> (OS) start iterating hotplug regs
   hot-add
      -> (QEMU) add CPU in hotplug regs
      -> (QEMU) SCI
            -2-> (OS) scan (blocked on mutex till previous scan is finished)
               -1-> (OS) 1st added CPU1 send device check event -> INIT/SIPI
               -1-> (OS) 1st added CPU2 send device check event -> INIT/SIPI
                       that's where it explodes, since FW didn't see CPU2
                       when SMI was called
)

hot remove will throw in yet another set of problems, so lets discuss
both here and see if we can  really share hotplug registers block between
FW and AML or we should do something else with it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v0:
 - s/aml_string/aml_eisaid/
   /fixes Windows BSOD, on nonsense value/ (Laszlo Ersek <lersek@redhat.com>)
 - put SMI device under PCI0 like the rest of hotplug IO port
 - do not generate SMI AML if CPU hotplug SMI feature hasn't been negotiated
---
 include/hw/acpi/cpu.h |  1 +
 hw/acpi/cpu.c         |  6 ++++++
 hw/i386/acpi-build.c  | 33 ++++++++++++++++++++++++++++++++-
 hw/isa/lpc_ich9.c     |  3 +++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 62f0278ba2..0eeedaa491 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -50,6 +50,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 typedef struct CPUHotplugFeatures {
     bool acpi_1_compatible;
     bool has_legacy_cphp;
+    const char *smi_path;
 } CPUHotplugFeatures;
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 3d6a500fb7..6539bc23f6 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -14,6 +14,8 @@
 #define ACPI_CPU_CMD_DATA_OFFSET_RW 8
 #define ACPI_CPU_CMD_DATA2_OFFSET_R 0
 
+#define OVMF_CPUHP_SMI_CMD 4
+
 enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
     CPHP_OST_EVENT_CMD = 1,
@@ -473,6 +475,10 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
+            if (opts.smi_path) {
+                aml_append(method, aml_store(aml_int(OVMF_CPUHP_SMI_CMD),
+                    aml_name("%s", opts.smi_path)));
+            }
             aml_append(method, aml_store(one, has_event));
             while_ctx = aml_while(aml_equal(has_event, one));
             {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b7bcbbbb2a..1e21386f0c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
     bool pcihp_bridge_en;
+    bool smi_on_cpuhp;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
@@ -194,6 +195,7 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->cpu_hp_io_base = 0;
     pm->pcihp_io_base = 0;
     pm->pcihp_io_len = 0;
+    pm->smi_on_cpuhp = false;
 
     assert(obj);
     init_common_fadt_data(machine, obj, &pm->fadt);
@@ -213,6 +215,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
         pm->fadt.reset_val = 0xf;
         pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
         pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
+        pm->smi_on_cpuhp =
+            !!(object_property_get_uint(lpc, "x-smi-negotiated-features", NULL)
+               & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT));
     }
 
     /* The above need not be conditional on machine type because the reset port
@@ -1515,6 +1520,31 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
         aml_append(dev, build_q35_osc_method());
         aml_append(sb_scope, dev);
+
+        if (pm->smi_on_cpuhp) {
+            /* reserve SMI block resources */
+            dev = aml_device("PCI0.SMI0");
+            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A06")));
+            aml_append(dev, aml_name_decl("_UID", aml_string("SMI resources")));
+            crs = aml_resource_template();
+            aml_append(crs,
+                aml_io(
+                       AML_DECODE16,
+                       ACPI_PORT_SMI_CMD,
+                       ACPI_PORT_SMI_CMD,
+                       1,
+                       1)
+            );
+            aml_append(dev, aml_name_decl("_CRS", crs));
+            aml_append(dev, aml_operation_region("SMIR", AML_SYSTEM_IO,
+                aml_int(0xB2), 1));
+            field = aml_field("SMIR", AML_BYTE_ACC, AML_NOLOCK,
+                              AML_WRITE_AS_ZEROS);
+            aml_append(field, aml_named_field("SMIC", 8));
+            aml_append(dev, field);
+            aml_append(sb_scope, dev);
+        }
+
         aml_append(dsdt, sb_scope);
 
         build_hpet_aml(dsdt);
@@ -1530,7 +1560,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
-            .acpi_1_compatible = true, .has_legacy_cphp = true
+            .acpi_1_compatible = true, .has_legacy_cphp = true,
+            .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
         };
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 83da7346ab..5ebea70a8d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -643,6 +643,9 @@ static void ich9_lpc_initfn(Object *obj)
                                   &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                   &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
+    object_property_add_uint64_ptr(obj, "x-smi-negotiated-features",
+                                   &lpc->smi_negotiated_features,
+                                   OBJ_PROP_FLAG_READ);
 
     ich9_pm_add_properties(obj, &lpc->pm);
 }
-- 
2.26.2


