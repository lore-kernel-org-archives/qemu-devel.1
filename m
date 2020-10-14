Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCE6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A29212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yjfy/DE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A29212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSi2C-0005g1-BF
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrG-0001GB-N0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrE-000632-QN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602686063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihfrtb283BNC8cQMvWcOPMEH2drLy84+qfZqHqg5KTM=;
 b=Yjfy/DE+sVxHbZI2s3XgEPdi7BhCaDLXGjXY1g2Zd5tFfI7w8XjNvGDylrVIoKmuDrsjr9
 WkxaHC6Yh+MnBkf+T1z/vfxHde9WbljXjy0WAKjzYPf9JX5crWIr8fdOqiLVNp7x4v1lIL
 nRcdUMe0JogC1JhO4An3NLsuCVwxDh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-AtgCjlXiMXqhwPCeqWqTCQ-1; Wed, 14 Oct 2020 10:34:20 -0400
X-MC-Unique: AtgCjlXiMXqhwPCeqWqTCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9891A1021200;
 Wed, 14 Oct 2020 14:34:19 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62A5D75135;
 Wed, 14 Oct 2020 14:34:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/10] input-linux: Register properties as class properties
Date: Wed, 14 Oct 2020 10:34:09 -0400
Message-Id: <20201014143415.240472-5-ehabkost@redhat.com>
In-Reply-To: <20201014143415.240472-1-ehabkost@redhat.com>
References: <20201014143415.240472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200921221045.699690-10-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 ui/input-linux.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index ab351a4187..a339c52cb8 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -489,19 +489,6 @@ static void input_linux_set_grab_toggle(Object *obj, int value,
 
 static void input_linux_instance_init(Object *obj)
 {
-    object_property_add_str(obj, "evdev",
-                            input_linux_get_evdev,
-                            input_linux_set_evdev);
-    object_property_add_bool(obj, "grab_all",
-                             input_linux_get_grab_all,
-                             input_linux_set_grab_all);
-    object_property_add_bool(obj, "repeat",
-                             input_linux_get_repeat,
-                             input_linux_set_repeat);
-    object_property_add_enum(obj, "grab-toggle", "GrabToggleKeys",
-                             &GrabToggleKeys_lookup,
-                             input_linux_get_grab_toggle,
-                             input_linux_set_grab_toggle);
 }
 
 static void input_linux_class_init(ObjectClass *oc, void *data)
@@ -509,6 +496,20 @@ static void input_linux_class_init(ObjectClass *oc, void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = input_linux_complete;
+
+    object_class_property_add_str(oc, "evdev",
+                                  input_linux_get_evdev,
+                                  input_linux_set_evdev);
+    object_class_property_add_bool(oc, "grab_all",
+                                   input_linux_get_grab_all,
+                                   input_linux_set_grab_all);
+    object_class_property_add_bool(oc, "repeat",
+                                   input_linux_get_repeat,
+                                   input_linux_set_repeat);
+    object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys",
+                                   &GrabToggleKeys_lookup,
+                                   input_linux_get_grab_toggle,
+                                   input_linux_set_grab_toggle);
 }
 
 static const TypeInfo input_linux_info = {
-- 
2.28.0


