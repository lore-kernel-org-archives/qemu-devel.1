Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7360C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E501521D43
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 22:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcsFCaZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E501521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVjEr-0002yO-W0
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 18:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVj7v-0006NB-Or
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kVj7s-0007rN-SY
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 18:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603405924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoFXLo8lO3rUNqTKjHIZBDthubuFa4/zr4nO6XUKvwo=;
 b=UcsFCaZcihgST6pJ+AErqCkRPw4aWa/EDuaOKcZcmq+Dvt/f4KxcP2BAdGKMdLHXArI6Li
 Z2G5twv5fMCywGs3wCneVITWoV0Dpg2JEaTZtICwWB+S5eVua3vfQcWzd5UDiI1HNMfliF
 12H5bLsOGSwdRWZTYJGdf4r9+bRYI5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-JZ2sQbkFPXShYO7ERswvXg-1; Thu, 22 Oct 2020 18:32:01 -0400
X-MC-Unique: JZ2sQbkFPXShYO7ERswvXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79CD2186DD29;
 Thu, 22 Oct 2020 22:31:59 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F28B5B4A9;
 Thu, 22 Oct 2020 22:31:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] pc: Use object_class_property_add_bool_ptr()
Date: Thu, 22 Oct 2020 18:31:40 -0400
Message-Id: <20201022223140.2083123-5-ehabkost@redhat.com>
In-Reply-To: <20201022223140.2083123-1-ehabkost@redhat.com>
References: <20201022223140.2083123-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Get rid of manually written property getters/setters.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org
---
 hw/i386/pc.c | 57 +++++++++-------------------------------------------
 1 file changed, 9 insertions(+), 48 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4e323755d0..d5a5b1b2ae 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1493,48 +1493,6 @@ static void pc_machine_set_vmport(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &pcms->vmport, errp);
 }
 
-static bool pc_machine_get_smbus(Object *obj, Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-
-    return pcms->smbus_enabled;
-}
-
-static void pc_machine_set_smbus(Object *obj, bool value, Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-
-    pcms->smbus_enabled = value;
-}
-
-static bool pc_machine_get_sata(Object *obj, Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-
-    return pcms->sata_enabled;
-}
-
-static void pc_machine_set_sata(Object *obj, bool value, Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-
-    pcms->sata_enabled = value;
-}
-
-static bool pc_machine_get_pit(Object *obj, Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-
-    return pcms->pit_enabled;
-}
-
-static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-
-    pcms->pit_enabled = value;
-}
-
 static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
                                             const char *name, void *opaque,
                                             Error **errp)
@@ -1697,14 +1655,17 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, PC_MACHINE_VMPORT,
         "Enable vmport (pc & q35)");
 
-    object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
-        pc_machine_get_smbus, pc_machine_set_smbus);
+    object_class_property_add_bool_ptr(oc, PC_MACHINE_SMBUS,
+                                       offsetof(PCMachineState, smbus_enabled),
+                                       OBJ_PROP_FLAG_READWRITE);
 
-    object_class_property_add_bool(oc, PC_MACHINE_SATA,
-        pc_machine_get_sata, pc_machine_set_sata);
+    object_class_property_add_bool_ptr(oc, PC_MACHINE_SATA,
+                                       offsetof(PCMachineState, sata_enabled),
+                                       OBJ_PROP_FLAG_READWRITE);
 
-    object_class_property_add_bool(oc, PC_MACHINE_PIT,
-        pc_machine_get_pit, pc_machine_set_pit);
+    object_class_property_add_bool_ptr(oc, PC_MACHINE_PIT,
+                                       offsetof(PCMachineState, pit_enabled),
+                                       OBJ_PROP_FLAG_READWRITE);
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.28.0


