Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05277206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj063WTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05277206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIqd-0001xI-4h
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeImG-00038V-FM
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:40:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49504
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeImF-00082z-8f
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590673254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pk2lELEqRcqGJ8tSaQx/EeMVdWqa2OKvGnmPrynuxN4=;
 b=Qj063WTf3Kx3DFbMunVkNaTPVIXkOnUofbkmq45MF6bVJOVTXNg7DxIm/139Qk+BjGtvt8
 splzAxv5KCnvEMTXTfD+w+4/2axffpj0ytSJhF2U2ptVhZAtIFiZcfaLpda6gYfITvzhL9
 QMe9rKsBwP3qHGU8y78lDXxGZ4XZ3X4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-sVXA4jvsOPOaqJRVk6Ga-g-1; Thu, 28 May 2020 09:40:52 -0400
X-MC-Unique: sVXA4jvsOPOaqJRVk6Ga-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A82A0872FE1;
 Thu, 28 May 2020 13:40:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B5467A8B4;
 Thu, 28 May 2020 13:40:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A0BC39DAF; Thu, 28 May 2020 15:40:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] x86: move max-ram-below-4g to pc
Date: Thu, 28 May 2020 15:40:34 +0200
Message-Id: <20200528134035.32025-4-kraxel@redhat.com>
In-Reply-To: <20200528134035.32025-1-kraxel@redhat.com>
References: <20200528134035.32025-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move from X86MachineClass to PCMachineClass so it disappears
from microvm machine type property list.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h  |  2 ++
 include/hw/i386/x86.h |  4 ----
 hw/i386/pc.c          | 46 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c     | 10 +++++-----
 hw/i386/pc_q35.c      | 10 +++++-----
 hw/i386/x86.c         | 46 -------------------------------------------
 6 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8d764f965cd3..e6135c34d656 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -35,6 +35,7 @@ struct PCMachineState {
     PFlashCFI01 *flash[2];
 
     /* Configuration options: */
+    uint64_t max_ram_below_4g;
     OnOffAuto vmport;
 
     bool acpi_build_enabled;
@@ -51,6 +52,7 @@ struct PCMachineState {
 };
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
+#define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
 #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMBUS            "smbus"
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index b52285481687..b79f24e28545 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -51,9 +51,6 @@ typedef struct {
     qemu_irq *gsi;
     GMappedFile *initrd_mapped_file;
 
-    /* Configuration options: */
-    uint64_t max_ram_below_4g;
-
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
 
@@ -82,7 +79,6 @@ typedef struct {
     AddressSpace *ioapic_as;
 } X86MachineState;
 
-#define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
 #define X86_MACHINE_SMM              "smm"
 #define X86_MACHINE_ACPI             "acpi"
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2128f3d6fe8b..80a6cac3b56f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1856,6 +1856,45 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
     pcms->pit_enabled = value;
 }
 
+static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+    uint64_t value = pcms->max_ram_below_4g;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+    Error *error = NULL;
+    uint64_t value;
+
+    visit_type_size(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+    if (value > 4 * GiB) {
+        error_setg(&error,
+                   "Machine option 'max-ram-below-4g=%"PRIu64
+                   "' expects size less than or equal to 4G", value);
+        error_propagate(errp, error);
+        return;
+    }
+
+    if (value < 1 * MiB) {
+        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boundary,"
+                    "BIOS may not work with less than 1MiB", value);
+    }
+
+    pcms->max_ram_below_4g = value;
+}
+
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -1865,6 +1904,7 @@ static void pc_machine_initfn(Object *obj)
 #else
     pcms->vmport = ON_OFF_AUTO_OFF;
 #endif /* CONFIG_VMPORT */
+    pcms->max_ram_below_4g = 0; /* use default */
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
     pcms->smbus_enabled = true;
@@ -1963,6 +2003,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_supported = true;
     mc->default_ram_id = "pc.ram";
 
+    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
+        pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
+        NULL, NULL);
+    object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
+        "Maximum ram below the 4G boundary (32bit boundary)");
+
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
         NULL, NULL);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f66e1d73ce0b..503c35f7bf4c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -127,11 +127,11 @@ static void pc_init1(MachineState *machine,
     if (xen_enabled()) {
         xen_hvm_init(pcms, &ram_memory);
     } else {
-        if (!x86ms->max_ram_below_4g) {
-            x86ms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        if (!pcms->max_ram_below_4g) {
+            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
         }
-        lowmem = x86ms->max_ram_below_4g;
-        if (machine->ram_size >= x86ms->max_ram_below_4g) {
+        lowmem = pcms->max_ram_below_4g;
+        if (machine->ram_size >= pcms->max_ram_below_4g) {
             if (pcmc->gigabyte_align) {
                 if (lowmem > 0xc0000000) {
                     lowmem = 0xc0000000;
@@ -140,7 +140,7 @@ static void pc_init1(MachineState *machine,
                     warn_report("Large machine and max_ram_below_4g "
                                 "(%" PRIu64 ") not a multiple of 1G; "
                                 "possible bad performance.",
-                                x86ms->max_ram_below_4g);
+                                pcms->max_ram_below_4g);
                 }
             }
         }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4ba8ac8774e4..90e8fb2cb737 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -154,18 +154,18 @@ static void pc_q35_init(MachineState *machine)
     /* Handle the machine opt max-ram-below-4g.  It is basically doing
      * min(qemu limit, user limit).
      */
-    if (!x86ms->max_ram_below_4g) {
-        x86ms->max_ram_below_4g = 4 * GiB;
+    if (!pcms->max_ram_below_4g) {
+        pcms->max_ram_below_4g = 4 * GiB;
     }
-    if (lowmem > x86ms->max_ram_below_4g) {
-        lowmem = x86ms->max_ram_below_4g;
+    if (lowmem > pcms->max_ram_below_4g) {
+        lowmem = pcms->max_ram_below_4g;
         if (machine->ram_size - lowmem > lowmem &&
             lowmem & (1 * GiB - 1)) {
             warn_report("There is possibly poor performance as the ram size "
                         " (0x%" PRIx64 ") is more then twice the size of"
                         " max-ram-below-4g (%"PRIu64") and"
                         " max-ram-below-4g is not a multiple of 1G.",
-                        (uint64_t)machine->ram_size, x86ms->max_ram_below_4g);
+                        (uint64_t)machine->ram_size, pcms->max_ram_below_4g);
         }
     }
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 7a3bc7ab6639..49884e5c1597 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -846,45 +846,6 @@ void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
                                 bios);
 }
 
-static void x86_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
-                                             const char *name, void *opaque,
-                                             Error **errp)
-{
-    X86MachineState *x86ms = X86_MACHINE(obj);
-    uint64_t value = x86ms->max_ram_below_4g;
-
-    visit_type_size(v, name, &value, errp);
-}
-
-static void x86_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
-                                             const char *name, void *opaque,
-                                             Error **errp)
-{
-    X86MachineState *x86ms = X86_MACHINE(obj);
-    Error *error = NULL;
-    uint64_t value;
-
-    visit_type_size(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    if (value > 4 * GiB) {
-        error_setg(&error,
-                   "Machine option 'max-ram-below-4g=%"PRIu64
-                   "' expects size less than or equal to 4G", value);
-        error_propagate(errp, error);
-        return;
-    }
-
-    if (value < 1 * MiB) {
-        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boundary,"
-                    "BIOS may not work with less than 1MiB", value);
-    }
-
-    x86ms->max_ram_below_4g = value;
-}
-
 bool x86_machine_is_smm_enabled(X86MachineState *x86ms)
 {
     bool smm_available = false;
@@ -958,7 +919,6 @@ static void x86_machine_initfn(Object *obj)
 
     x86ms->smm = ON_OFF_AUTO_AUTO;
     x86ms->acpi = ON_OFF_AUTO_AUTO;
-    x86ms->max_ram_below_4g = 0; /* use default */
     x86ms->smp_dies = 1;
 
     x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
@@ -980,12 +940,6 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     x86mc->save_tsc_khz = true;
     nc->nmi_monitor_handler = x86_nmi;
 
-    object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
-        x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below_4g,
-        NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_MAX_RAM_BELOW_4G,
-        "Maximum ram below the 4G boundary (32bit boundary)");
-
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
         x86_machine_get_smm, x86_machine_set_smm,
         NULL, NULL);
-- 
2.18.4


