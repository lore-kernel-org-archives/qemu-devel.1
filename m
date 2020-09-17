Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25EBC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D29D206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKOOtMRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D29D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuYo-0007SM-8s
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuMU-0000Ml-LE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuMI-00087B-7N
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600350832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujv/CFbULyntOLoQmwRM5dWpP9RTJ3+bB2TQbKYEIx4=;
 b=GKOOtMRgy/jo+0SrIIetekofoIA0nKjIygjmArdRm/9qGxSPElXA+4uRafhmV6xvB36qD0
 xXA8RZo178XkSHyeZ7nMKAFIVOgOOSPpDZys0oIlijU6zY0uEd/f4PxqWWTkqkrMr4gqvo
 EwCBb9cqDh5OWPUGYYlZM5vuBizjDRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-zmGI77YkOP6JBDb6ZsMNvQ-1; Thu, 17 Sep 2020 09:53:48 -0400
X-MC-Unique: zmGI77YkOP6JBDb6ZsMNvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA2F81084C9B;
 Thu, 17 Sep 2020 13:53:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 667137881A;
 Thu, 17 Sep 2020 13:53:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3D9F831E7F; Thu, 17 Sep 2020 15:53:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/21] x86: move acpi_dev from pc/microvm
Date: Thu, 17 Sep 2020 15:53:16 +0200
Message-Id: <20200917135323.18022-15-kraxel@redhat.com>
In-Reply-To: <20200917135323.18022-1-kraxel@redhat.com>
References: <20200917135323.18022-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both pc and microvm machine types have a acpi_dev field.
Move it to the common base type.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200915120909.20838-15-kraxel@redhat.com
---
 include/hw/i386/microvm.h |  1 -
 include/hw/i386/pc.h      |  1 -
 include/hw/i386/x86.h     |  1 +
 hw/i386/acpi-build.c      |  2 +-
 hw/i386/acpi-microvm.c    |  5 +++--
 hw/i386/microvm.c         | 10 ++++++----
 hw/i386/pc.c              | 34 +++++++++++++++++++---------------
 hw/i386/pc_piix.c         |  2 +-
 hw/i386/pc_q35.c          |  2 +-
 9 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index d75dcf8203b7..be2d95af4d74 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -68,7 +68,6 @@ struct MicrovmMachineState {
     bool kernel_cmdline_fixed;
     Notifier machine_done;
     Notifier powerdown_req;
-    AcpiDeviceIf *acpi_dev;
 };
 typedef struct MicrovmMachineState MicrovmMachineState;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 421a77acc223..c14e14dfe0c7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -30,7 +30,6 @@ struct PCMachineState {
     Notifier machine_done;
 
     /* Pointers to devices and objects: */
-    HotplugHandler *acpi_dev;
     PCIBus *bus;
     I2CBus *smbus;
     PFlashCFI01 *flash[2];
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 25c904638c11..f540e801a837 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -52,6 +52,7 @@ struct X86MachineState {
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
     GMappedFile *initrd_mapped_file;
+    HotplugHandler *acpi_dev;
 
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7a5a8b3521b0..0e0535d2e30c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2431,7 +2431,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, x86ms,
-                    ACPI_DEVICE_IF(pcms->acpi_dev), true);
+                    ACPI_DEVICE_IF(x86ms->acpi_dev), true);
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index b9ce3768b263..df39c5d3bd90 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -108,7 +108,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("_SB");
     fw_cfg_add_acpi_dsdt(sb_scope, x86ms->fw_cfg);
     isa_build_aml(ISA_BUS(isabus), sb_scope);
-    build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
+    build_ged_aml(sb_scope, GED_DEVICE, x86ms->acpi_dev,
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
     acpi_dsdt_add_virtio(sb_scope, mms);
@@ -136,6 +136,7 @@ static void acpi_build_microvm(AcpiBuildTables *tables,
                                MicrovmMachineState *mms)
 {
     MachineState *machine = MACHINE(mms);
+    X86MachineState *x86ms = X86_MACHINE(mms);
     GArray *table_offsets;
     GArray *tables_blob = tables->table_data;
     unsigned dsdt, xsdt;
@@ -183,7 +184,7 @@ static void acpi_build_microvm(AcpiBuildTables *tables,
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, X86_MACHINE(machine),
-                    mms->acpi_dev, false);
+                    ACPI_DEVICE_IF(x86ms->acpi_dev), false);
 
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 04209eb38fbe..9df15354ce0f 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -143,7 +143,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                            x86ms->gsi[GED_MMIO_IRQ]);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
-        mms->acpi_dev = ACPI_DEVICE_IF(dev);
+        x86ms->acpi_dev = HOTPLUG_HANDLER(dev);
     }
 
     if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
@@ -469,11 +469,13 @@ static void microvm_powerdown_req(Notifier *notifier, void *data)
 {
     MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
                                             powerdown_req);
+    X86MachineState *x86ms = X86_MACHINE(mms);
 
-    if (mms->acpi_dev) {
-        Object *obj = OBJECT(mms->acpi_dev);
+    if (x86ms->acpi_dev) {
+        Object *obj = OBJECT(x86ms->acpi_dev);
         AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
-        adevc->send_event(mms->acpi_dev, ACPI_POWER_DOWN_STATUS);
+        adevc->send_event(ACPI_DEVICE_IF(x86ms->acpi_dev),
+                          ACPI_POWER_DOWN_STATUS);
     }
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d11daacc23cf..a18140421e92 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1274,6 +1274,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
     const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    const X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
     const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
@@ -1285,7 +1286,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      * but pcms->acpi_dev is still created. Check !acpi_enabled in
      * addition to cover this case.
      */
-    if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
+    if (!x86ms->acpi_dev || !x86_machine_is_acpi_enabled(x86ms)) {
         error_setg(errp,
                    "memory hotplug is not enabled: missing acpi device or acpi disabled");
         return;
@@ -1296,7 +1297,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
+    hotplug_handler_pre_plug(x86ms->acpi_dev, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1311,6 +1312,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
 {
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
@@ -1323,7 +1325,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
         nvdimm_plug(ms->nvdimms_state);
     }
 
-    hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
+    hotplug_handler_plug(x86ms->acpi_dev, dev, &error_abort);
 out:
     error_propagate(errp, local_err);
 }
@@ -1331,14 +1333,14 @@ out:
 static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
 
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
      * but pcms->acpi_dev is still created. Check !acpi_enabled in
      * addition to cover this case.
      */
-    if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
+    if (!x86ms->acpi_dev || !x86_machine_is_acpi_enabled(x86ms)) {
         error_setg(errp,
                    "memory hotplug is not enabled: missing acpi device or acpi disabled");
         return;
@@ -1349,7 +1351,7 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
         return;
     }
 
-    hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
+    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
                                    errp);
 }
 
@@ -1357,9 +1359,10 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
     Error *local_err = NULL;
 
-    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1403,10 +1406,10 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    X86MachineState *x86ms = X86_MACHINE(pcms);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
 
-    if (pcms->acpi_dev) {
-        hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+    if (x86ms->acpi_dev) {
+        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
         if (local_err) {
             goto out;
         }
@@ -1432,8 +1435,9 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     int idx = -1;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
 
-    if (!pcms->acpi_dev) {
+    if (!x86ms->acpi_dev) {
         error_setg(errp, "CPU hot unplug not supported without ACPI");
         return;
     }
@@ -1445,7 +1449,7 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
         return;
     }
 
-    hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
+    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
                                    errp);
 }
 
@@ -1456,9 +1460,9 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    X86MachineState *x86ms = X86_MACHINE(pcms);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
 
-    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1487,7 +1491,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    X86MachineState *x86ms = X86_MACHINE(pcms);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
     unsigned int smp_cores = ms->smp.cores;
     unsigned int smp_threads = ms->smp.threads;
     X86CPUTopoInfo topo_info;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 33fa035fb7fe..6f3e78bb6053 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -293,7 +293,7 @@ static void pc_init1(MachineState *machine,
 
         object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&pcms->acpi_dev,
+                                 (Object **)&x86ms->acpi_dev,
                                  object_property_allow_set_link,
                                  OBJ_PROP_LINK_STRONG);
         object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0cb9c18cd44d..622d0397172a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -240,7 +240,7 @@ static void pc_q35_init(MachineState *machine)
 
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
-                             (Object **)&pcms->acpi_dev,
+                             (Object **)&x86ms->acpi_dev,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-- 
2.27.0


