Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C0C4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C4620665
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+NCgNTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLX7-0005gx-Sn
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFb-0003Jr-4r
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFR-0005fw-L5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k0gY4Sk0O+5XMXEg546Jxy3y7v8c67w4awiRa0gddxo=;
 b=I+NCgNTBleMD0o7FuD/DarToPIxiuy68SLFNsoJciFZUH4CW+1pleMOColqxy3l04G71th
 gDalyLXqN0hr/zY/ps0v8x8Sl2XozPrGw/hUE80oR3CeZFGIP/NKxCl3a6IEOCKpnNo/ZN
 NJm/3tWAwESgXvceIOsNvGeAT2X74A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-n6_xYl6HN5uVNRd7PdPiMw-1; Wed, 04 Nov 2020 11:02:55 -0500
X-MC-Unique: n6_xYl6HN5uVNRd7PdPiMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E64D1006C94;
 Wed,  4 Nov 2020 16:02:54 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10B125B4D8;
 Wed,  4 Nov 2020 16:02:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 44/44] machine: Register most properties as field properties
Date: Wed,  4 Nov 2020 11:00:21 -0500
Message-Id: <20201104160021.2342108-45-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Redone using object_class_add_property_field() + PROP_* macros
  instead of DEFINE_PROP_* array, as suggested by Paolo
---
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/machine.c | 256 +++++++---------------------------------------
 1 file changed, 39 insertions(+), 217 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 98b87f76cb..2d39b56191 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,8 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
+#include "qom/field-property.h"
+#include "qom/property-types.h"
 
 GlobalProperty hw_compat_5_1[] = {
     { "vhost-scsi", "num_queues", "1"},
@@ -212,81 +214,6 @@ GlobalProperty hw_compat_2_1[] = {
 };
 const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
 
-static char *machine_get_kernel(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->kernel_filename);
-}
-
-static void machine_set_kernel(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->kernel_filename);
-    ms->kernel_filename = g_strdup(value);
-}
-
-static char *machine_get_initrd(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->initrd_filename);
-}
-
-static void machine_set_initrd(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->initrd_filename);
-    ms->initrd_filename = g_strdup(value);
-}
-
-static char *machine_get_append(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->kernel_cmdline);
-}
-
-static void machine_set_append(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->kernel_cmdline);
-    ms->kernel_cmdline = g_strdup(value);
-}
-
-static char *machine_get_dtb(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->dtb);
-}
-
-static void machine_set_dtb(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->dtb);
-    ms->dtb = g_strdup(value);
-}
-
-static char *machine_get_dumpdtb(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->dumpdtb);
-}
-
-static void machine_set_dumpdtb(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->dumpdtb);
-    ms->dumpdtb = g_strdup(value);
-}
-
 static void machine_get_phandle_start(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
@@ -311,48 +238,6 @@ static void machine_set_phandle_start(Object *obj, Visitor *v,
     ms->phandle_start = value;
 }
 
-static char *machine_get_dt_compatible(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->dt_compatible);
-}
-
-static void machine_set_dt_compatible(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->dt_compatible);
-    ms->dt_compatible = g_strdup(value);
-}
-
-static bool machine_get_dump_guest_core(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return ms->dump_guest_core;
-}
-
-static void machine_set_dump_guest_core(Object *obj, bool value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    ms->dump_guest_core = value;
-}
-
-static bool machine_get_mem_merge(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return ms->mem_merge;
-}
-
-static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    ms->mem_merge = value;
-}
 
 static bool machine_get_usb(Object *obj, Error **errp)
 {
@@ -369,49 +254,6 @@ static void machine_set_usb(Object *obj, bool value, Error **errp)
     ms->usb_disabled = !value;
 }
 
-static bool machine_get_graphics(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return ms->enable_graphics;
-}
-
-static void machine_set_graphics(Object *obj, bool value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    ms->enable_graphics = value;
-}
-
-static char *machine_get_firmware(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->firmware);
-}
-
-static void machine_set_firmware(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->firmware);
-    ms->firmware = g_strdup(value);
-}
-
-static void machine_set_suppress_vmdesc(Object *obj, bool value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    ms->suppress_vmdesc = value;
-}
-
-static bool machine_get_suppress_vmdesc(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return ms->suppress_vmdesc;
-}
-
 static char *machine_get_memory_encryption(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -432,7 +274,7 @@ static void machine_set_memory_encryption(Object *obj, const char *value,
      * so there's no point in it trying to merge areas.
      */
     if (value) {
-        machine_set_mem_merge(obj, false, errp);
+        ms->mem_merge = false;
     }
 }
 
@@ -520,21 +362,6 @@ static void validate_sysbus_device(SysBusDevice *sbdev, void *opaque)
     }
 }
 
-static char *machine_get_memdev(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->ram_memdev_id);
-}
-
-static void machine_set_memdev(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->ram_memdev_id);
-    ms->ram_memdev_id = g_strdup(value);
-}
-
 
 static void machine_init_notify(Notifier *notifier, void *data)
 {
@@ -774,28 +601,29 @@ static void machine_class_init(ObjectClass *oc, void *data)
      */
     mc->numa_mem_align_shift = 23;
 
-    object_class_property_add_str(oc, "kernel",
-        machine_get_kernel, machine_set_kernel);
+    object_class_property_add_field(oc, "kernel",
+                                    PROP_STRING(MachineState, kernel_filename),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "kernel",
         "Linux kernel image file");
-
-    object_class_property_add_str(oc, "initrd",
-        machine_get_initrd, machine_set_initrd);
+    object_class_property_add_field(oc, "initrd",
+                                    PROP_STRING(MachineState, initrd_filename),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "initrd",
         "Linux initial ramdisk file");
-
-    object_class_property_add_str(oc, "append",
-        machine_get_append, machine_set_append);
+    object_class_property_add_field(oc, "append",
+                                    PROP_STRING(MachineState, kernel_cmdline),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "append",
         "Linux kernel command line");
-
-    object_class_property_add_str(oc, "dtb",
-        machine_get_dtb, machine_set_dtb);
+    object_class_property_add_field(oc, "dtb",
+                                    PROP_STRING(MachineState, dtb),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "dtb",
         "Linux kernel device tree file");
-
-    object_class_property_add_str(oc, "dumpdtb",
-        machine_get_dumpdtb, machine_set_dumpdtb);
+    object_class_property_add_field(oc, "dumpdtb",
+                                    PROP_STRING(MachineState, dumpdtb),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "dumpdtb",
         "Dump current dtb to a file and quit");
 
@@ -805,18 +633,20 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "phandle-start",
         "The first phandle ID we may generate dynamically");
 
-    object_class_property_add_str(oc, "dt-compatible",
-        machine_get_dt_compatible, machine_set_dt_compatible);
+    object_class_property_add_field(oc, "dt-compatible",
+                                    PROP_STRING(MachineState, dt_compatible),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "dt-compatible",
         "Overrides the \"compatible\" property of the dt root node");
 
-    object_class_property_add_bool(oc, "dump-guest-core",
-        machine_get_dump_guest_core, machine_set_dump_guest_core);
+    object_class_property_add_field(oc, "dump-guest-core",
+                                    PROP_BOOL(MachineState, dump_guest_core, true),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "dump-guest-core",
         "Include guest memory in a core dump");
-
-    object_class_property_add_bool(oc, "mem-merge",
-        machine_get_mem_merge, machine_set_mem_merge);
+    object_class_property_add_field(oc, "mem-merge",
+                                    PROP_BOOL(MachineState, mem_merge, true),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "mem-merge",
         "Enable/disable memory merge support");
 
@@ -825,18 +655,20 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "usb",
         "Set on/off to enable/disable usb");
 
-    object_class_property_add_bool(oc, "graphics",
-        machine_get_graphics, machine_set_graphics);
+    object_class_property_add_field(oc, "graphics",
+                                    PROP_BOOL(MachineState, enable_graphics, true),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "graphics",
         "Set on/off to enable/disable graphics emulation");
 
-    object_class_property_add_str(oc, "firmware",
-        machine_get_firmware, machine_set_firmware);
+    object_class_property_add_field(oc, "firmware",
+                                    PROP_STRING(MachineState, firmware),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "firmware",
         "Firmware image");
-
-    object_class_property_add_bool(oc, "suppress-vmdesc",
-        machine_get_suppress_vmdesc, machine_set_suppress_vmdesc);
+    object_class_property_add_field(oc, "suppress-vmdesc",
+                                    PROP_BOOL(MachineState, suppress_vmdesc, false),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "suppress-vmdesc",
         "Set on to disable self-describing migration");
 
@@ -845,8 +677,9 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "memory-encryption",
         "Set memory encryption object to use");
 
-    object_class_property_add_str(oc, "memory-backend",
-                                  machine_get_memdev, machine_set_memdev);
+    object_class_property_add_field(oc, "memory-backend",
+                                    PROP_STRING(MachineState, ram_memdev_id),
+                                    prop_allow_set_always);
     object_class_property_set_description(oc, "memory-backend",
                                           "Set RAM backend"
                                           "Valid value is ID of hostmem based backend");
@@ -873,10 +706,6 @@ static void machine_initfn(Object *obj)
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
 
-    ms->dump_guest_core = true;
-    ms->mem_merge = true;
-    ms->enable_graphics = true;
-
     if (mc->nvdimm_supported) {
         Object *obj = OBJECT(ms);
 
@@ -921,13 +750,6 @@ static void machine_finalize(Object *obj)
 {
     MachineState *ms = MACHINE(obj);
 
-    g_free(ms->kernel_filename);
-    g_free(ms->initrd_filename);
-    g_free(ms->kernel_cmdline);
-    g_free(ms->dtb);
-    g_free(ms->dumpdtb);
-    g_free(ms->dt_compatible);
-    g_free(ms->firmware);
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
-- 
2.28.0


