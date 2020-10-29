Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA116C4741F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C36120FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWrE54+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C36120FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGKn-0005lQ-5p
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1n-0003xR-FL
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1d-0006g0-VP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WaGICVKFJXVkLncju1zY88FyPaqJBQvQuxC4WR7cjZU=;
 b=AWrE54+s1PNjAn3i6g1fSQDRBu5JEv/RBsoYliPZLX5wRiCTic8z85qoqP52rXMuDG7M07
 OhnDJ789EaaqjE362b6eReUNdE08ojzivgixHIiI4DotgDUTGTsJpcHbs1KfkWVFIBlXFp
 b1aHVduvY1ViaLu24YEp2uLLnx0CM0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-iSgGScHrNdaOptsD6ZFhyA-1; Thu, 29 Oct 2020 18:04:03 -0400
X-MC-Unique: iSgGScHrNdaOptsD6ZFhyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C8D49CC01
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:04:02 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF53260C17;
 Thu, 29 Oct 2020 22:04:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/36] machine: Use DEFINE_PROP_BOOL for boolean properties
Date: Thu, 29 Oct 2020 18:02:45 -0400
Message-Id: <20201029220246.472693-36-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
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
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately, the "usb" property is not trivial because it
actually represents a pair of booleans.  It probably should be
replaced by a OnOffAuto property instead.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 77 +++--------------------------------------------
 1 file changed, 5 insertions(+), 72 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 97e102911a..e62097526a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -236,34 +236,6 @@ static void machine_set_phandle_start(Object *obj, Visitor *v,
     ms->phandle_start = value;
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
 static Property machine_props[] = {
     DEFINE_PROP_STRING("kernel", MachineState, kernel_filename),
     DEFINE_PROP_STRING("initrd", MachineState, initrd_filename),
@@ -273,6 +245,10 @@ static Property machine_props[] = {
     DEFINE_PROP_STRING("dt-compatible", MachineState, dt_compatible),
     DEFINE_PROP_STRING("firmware", MachineState, firmware),
     DEFINE_PROP_STRING("memory-backend", MachineState, ram_memdev_id),
+    DEFINE_PROP_BOOL("dump-guest-core", MachineState, dump_guest_core, true),
+    DEFINE_PROP_BOOL("mem-merge", MachineState, mem_merge, true),
+    DEFINE_PROP_BOOL("graphics", MachineState, enable_graphics, true),
+    DEFINE_PROP_BOOL("suppress-vmdesc", MachineState, suppress_vmdesc, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -291,34 +267,6 @@ static void machine_set_usb(Object *obj, bool value, Error **errp)
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
@@ -339,7 +287,7 @@ static void machine_set_memory_encryption(Object *obj, const char *value,
      * so there's no point in it trying to merge areas.
      */
     if (value) {
-        machine_set_mem_merge(obj, false, errp);
+        ms->mem_merge = false;
     }
 }
 
@@ -692,13 +640,8 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "dt-compatible",
         "Overrides the \"compatible\" property of the dt root node");
 
-    object_class_property_add_bool(oc, "dump-guest-core",
-        machine_get_dump_guest_core, machine_set_dump_guest_core);
     object_class_property_set_description(oc, "dump-guest-core",
         "Include guest memory in a core dump");
-
-    object_class_property_add_bool(oc, "mem-merge",
-        machine_get_mem_merge, machine_set_mem_merge);
     object_class_property_set_description(oc, "mem-merge",
         "Enable/disable memory merge support");
 
@@ -707,16 +650,10 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "usb",
         "Set on/off to enable/disable usb");
 
-    object_class_property_add_bool(oc, "graphics",
-        machine_get_graphics, machine_set_graphics);
     object_class_property_set_description(oc, "graphics",
         "Set on/off to enable/disable graphics emulation");
-
     object_class_property_set_description(oc, "firmware",
         "Firmware image");
-
-    object_class_property_add_bool(oc, "suppress-vmdesc",
-        machine_get_suppress_vmdesc, machine_set_suppress_vmdesc);
     object_class_property_set_description(oc, "suppress-vmdesc",
         "Set on to disable self-describing migration");
 
@@ -751,10 +688,6 @@ static void machine_initfn(Object *obj)
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
 
-    ms->dump_guest_core = true;
-    ms->mem_merge = true;
-    ms->enable_graphics = true;
-
     if (mc->nvdimm_supported) {
         Object *obj = OBJECT(ms);
 
-- 
2.28.0


