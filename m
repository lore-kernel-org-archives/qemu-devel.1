Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E052C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2DC21531
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHi6PUU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2DC21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGMi-000086-Rj
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1h-0003wj-VP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1d-0006fo-Jv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lLBh8AHI5w5zORkGrS1PT6VyJYohW+X+eV7Twa8JhNg=;
 b=OHi6PUU4bPzggN6FqaggN1PQjmzAOqql5kqZdk6YnyWM3B3Gq39Qzycuo5L1tQWPB1QUca
 4usRdORn0XZa7Ua05MQlHXXWOxhJtXTInflTLiRPqDduNqqr1CvMnVeW14iHINQGUj9jiY
 5gtnJ8kxKwtUcn+eLvGoOAS/sdrwbnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-e9vWb2IFMAaFYFaHdzI1Jg-1; Thu, 29 Oct 2020 18:04:01 -0400
X-MC-Unique: e9vWb2IFMAaFYFaHdzI1Jg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCAED10E2184
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:04:00 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CFC355780;
 Thu, 29 Oct 2020 22:04:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/36] machine: Use DEFINE_PROP_STRING for string properties
Date: Thu, 29 Oct 2020 18:02:44 -0400
Message-Id: <20201029220246.472693-35-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 166 ++++++----------------------------------------
 1 file changed, 19 insertions(+), 147 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c5e0e79e6d..97e102911a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
+#include "qom/static-property.h"
 
 GlobalProperty hw_compat_5_1[] = {
     { "vhost-scsi", "num_queues", "1"},
@@ -211,81 +212,6 @@ GlobalProperty hw_compat_2_1[] = {
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
@@ -310,21 +236,6 @@ static void machine_set_phandle_start(Object *obj, Visitor *v,
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
 static bool machine_get_dump_guest_core(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -353,6 +264,18 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
     ms->mem_merge = value;
 }
 
+static Property machine_props[] = {
+    DEFINE_PROP_STRING("kernel", MachineState, kernel_filename),
+    DEFINE_PROP_STRING("initrd", MachineState, initrd_filename),
+    DEFINE_PROP_STRING("append", MachineState, kernel_cmdline),
+    DEFINE_PROP_STRING("dtb", MachineState, dtb),
+    DEFINE_PROP_STRING("dumpdtb", MachineState, dumpdtb),
+    DEFINE_PROP_STRING("dt-compatible", MachineState, dt_compatible),
+    DEFINE_PROP_STRING("firmware", MachineState, firmware),
+    DEFINE_PROP_STRING("memory-backend", MachineState, ram_memdev_id),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static bool machine_get_usb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -382,21 +305,6 @@ static void machine_set_graphics(Object *obj, bool value, Error **errp)
     ms->enable_graphics = value;
 }
 
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
 static void machine_set_suppress_vmdesc(Object *obj, bool value, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -519,21 +427,6 @@ static void validate_sysbus_device(SysBusDevice *sbdev, void *opaque)
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
@@ -773,28 +666,20 @@ static void machine_class_init(ObjectClass *oc, void *data)
      */
     mc->numa_mem_align_shift = 23;
 
-    object_class_property_add_str(oc, "kernel",
-        machine_get_kernel, machine_set_kernel);
+    /*
+     * TODO: provide a allow_set callback and prevent properties
+     * from being set after machine was already initialized
+     */
+    object_class_add_static_props(oc, machine_props, NULL);
+
     object_class_property_set_description(oc, "kernel",
         "Linux kernel image file");
-
-    object_class_property_add_str(oc, "initrd",
-        machine_get_initrd, machine_set_initrd);
     object_class_property_set_description(oc, "initrd",
         "Linux initial ramdisk file");
-
-    object_class_property_add_str(oc, "append",
-        machine_get_append, machine_set_append);
     object_class_property_set_description(oc, "append",
         "Linux kernel command line");
-
-    object_class_property_add_str(oc, "dtb",
-        machine_get_dtb, machine_set_dtb);
     object_class_property_set_description(oc, "dtb",
         "Linux kernel device tree file");
-
-    object_class_property_add_str(oc, "dumpdtb",
-        machine_get_dumpdtb, machine_set_dumpdtb);
     object_class_property_set_description(oc, "dumpdtb",
         "Dump current dtb to a file and quit");
 
@@ -804,8 +689,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "phandle-start",
         "The first phandle ID we may generate dynamically");
 
-    object_class_property_add_str(oc, "dt-compatible",
-        machine_get_dt_compatible, machine_set_dt_compatible);
     object_class_property_set_description(oc, "dt-compatible",
         "Overrides the \"compatible\" property of the dt root node");
 
@@ -829,8 +712,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "graphics",
         "Set on/off to enable/disable graphics emulation");
 
-    object_class_property_add_str(oc, "firmware",
-        machine_get_firmware, machine_set_firmware);
     object_class_property_set_description(oc, "firmware",
         "Firmware image");
 
@@ -844,8 +725,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "memory-encryption",
         "Set memory encryption object to use");
 
-    object_class_property_add_str(oc, "memory-backend",
-                                  machine_get_memdev, machine_set_memdev);
     object_class_property_set_description(oc, "memory-backend",
                                           "Set RAM backend"
                                           "Valid value is ID of hostmem based backend");
@@ -920,13 +799,6 @@ static void machine_finalize(Object *obj)
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


