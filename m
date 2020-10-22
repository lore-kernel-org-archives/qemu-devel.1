Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A37C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFB524655
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PktZUmsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFB524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVjCu-0001ZK-61
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 18:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVj7v-0006ME-4d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVj7r-0007rG-0S
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603405921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHHfJL2HKHTfdvkd7qqVNYxdcwNdTDTUok1ETVSGZcA=;
 b=PktZUmshL8ORRgZpZM/EjCQuYy6JqNfrUWSYr5Y56TV1v4brnjSMhURl6kWRQnH0eOYwf6
 xnLvwSLDl83SQp3ypzMPrs1f0KwpBU+Li4/MoYfTw0S0Nv+NqjsymPBynYN4F9kkqEDTNP
 vgrT3WIPwOlJtRZdyr59xcjZ+BsC1zQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-7VFkkiE9OQ2sXcoZzRwYyg-1; Thu, 22 Oct 2020 18:31:59 -0400
X-MC-Unique: 7VFkkiE9OQ2sXcoZzRwYyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 430998CAA24;
 Thu, 22 Oct 2020 22:31:58 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C29FE5D9CC;
 Thu, 22 Oct 2020 22:31:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] machine: Use object_class_property_add_bool_ptr() when
 possible
Date: Thu, 22 Oct 2020 18:31:39 -0400
Message-Id: <20201022223140.2083123-4-ehabkost@redhat.com>
In-Reply-To: <20201022223140.2083123-1-ehabkost@redhat.com>
References: <20201022223140.2083123-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Get rid if some manually written properties getters/setters.

Not all properties could be converted because they have extra
logic in the property setter.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/machine.c | 78 ++++++++---------------------------------------
 1 file changed, 13 insertions(+), 65 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d740a7e963..21cad22b9e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -325,34 +325,6 @@ static void machine_set_dt_compatible(Object *obj, const char *value, Error **er
     ms->dt_compatible = g_strdup(value);
 }
 
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
-
 static bool machine_get_usb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -368,20 +340,6 @@ static void machine_set_usb(Object *obj, bool value, Error **errp)
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
 static char *machine_get_firmware(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -397,20 +355,6 @@ static void machine_set_firmware(Object *obj, const char *value, Error **errp)
     ms->firmware = g_strdup(value);
 }
 
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
 static void machine_set_enforce_config_section(Object *obj, bool value,
                                              Error **errp)
 {
@@ -449,7 +393,7 @@ static void machine_set_memory_encryption(Object *obj, const char *value,
      * so there's no point in it trying to merge areas.
      */
     if (value) {
-        machine_set_mem_merge(obj, false, errp);
+        ms->mem_merge = false;
     }
 }
 
@@ -827,13 +771,15 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "dt-compatible",
         "Overrides the \"compatible\" property of the dt root node");
 
-    object_class_property_add_bool(oc, "dump-guest-core",
-        machine_get_dump_guest_core, machine_set_dump_guest_core);
+    object_class_property_add_bool_ptr(oc, "dump-guest-core",
+                                       offsetof(MachineState, dump_guest_core),
+                                       OBJ_PROP_FLAG_READWRITE);
     object_class_property_set_description(oc, "dump-guest-core",
         "Include guest memory in a core dump");
 
-    object_class_property_add_bool(oc, "mem-merge",
-        machine_get_mem_merge, machine_set_mem_merge);
+    object_class_property_add_bool_ptr(oc, "mem-merge",
+                                       offsetof(MachineState, mem_merge),
+                                       OBJ_PROP_FLAG_READWRITE);
     object_class_property_set_description(oc, "mem-merge",
         "Enable/disable memory merge support");
 
@@ -842,8 +788,9 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "usb",
         "Set on/off to enable/disable usb");
 
-    object_class_property_add_bool(oc, "graphics",
-        machine_get_graphics, machine_set_graphics);
+    object_class_property_add_bool_ptr(oc, "graphics",
+                                       offsetof(MachineState, enable_graphics),
+                                       OBJ_PROP_FLAG_READWRITE);
     object_class_property_set_description(oc, "graphics",
         "Set on/off to enable/disable graphics emulation");
 
@@ -852,8 +799,9 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "firmware",
         "Firmware image");
 
-    object_class_property_add_bool(oc, "suppress-vmdesc",
-        machine_get_suppress_vmdesc, machine_set_suppress_vmdesc);
+    object_class_property_add_bool_ptr(oc, "suppress-vmdesc",
+                                       offsetof(MachineState, suppress_vmdesc),
+                                       OBJ_PROP_FLAG_READWRITE);
     object_class_property_set_description(oc, "suppress-vmdesc",
         "Set on to disable self-describing migration");
 
-- 
2.28.0


