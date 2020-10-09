Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9EAC43467
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799272227E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjbjTYWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799272227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuzC-00060x-8M
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuqP-0003wM-AB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuqM-0001Cx-Bk
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/0WU02UGw93rIL/U7xfUdD3VvJQmzc6XB5lCRxb7ac=;
 b=OjbjTYWYVrO6uhi9N9LVHpB9XGlgtyyvHD2j110uW/zMi+uZNXluaerlrX8uEAGMKN+Ns6
 XAvl3uY/sHNKV9q0jsoWJlD1x9vBWsvreIfsuTEMZmqFjdwfcvegSFL3j8CsBE996CGdzP
 /XzFEZWHnGEVL1NRB+hWI6+Ic7fnyKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-OPSQWlvbPbKlaXr9hbZ92w-1; Fri, 09 Oct 2020 12:02:03 -0400
X-MC-Unique: OPSQWlvbPbKlaXr9hbZ92w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E2E2835B50
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 16:02:02 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D6815C1C7;
 Fri,  9 Oct 2020 16:01:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/12] input: Use class properties
Date: Fri,  9 Oct 2020 12:01:20 -0400
Message-Id: <20201009160122.1662082-11-ehabkost@redhat.com>
In-Reply-To: <20201009160122.1662082-1-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instance properties make introspection hard and are not shown by
"-object ...,help".  Convert them to class properties.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/input-barrier.c | 44 ++++++++++++++++++++++----------------------
 ui/input-linux.c   | 27 ++++++++++++++-------------
 2 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index a047919fde..8e886a6495 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -689,34 +689,34 @@ static void input_barrier_instance_init(Object *obj)
     ib->y_origin = 0;
     ib->width = 1920;
     ib->height = 1080;
-
-    object_property_add_str(obj, "name",
-                            input_barrier_get_name,
-                            input_barrier_set_name);
-    object_property_add_str(obj, "server",
-                            input_barrier_get_server,
-                            input_barrier_set_server);
-    object_property_add_str(obj, "port",
-                            input_barrier_get_port,
-                            input_barrier_set_port);
-    object_property_add_str(obj, "x-origin",
-                            input_barrier_get_x_origin,
-                            input_barrier_set_x_origin);
-    object_property_add_str(obj, "y-origin",
-                            input_barrier_get_y_origin,
-                            input_barrier_set_y_origin);
-    object_property_add_str(obj, "width",
-                            input_barrier_get_width,
-                            input_barrier_set_width);
-    object_property_add_str(obj, "height",
-                            input_barrier_get_height,
-                            input_barrier_set_height);
 }
 
 static void input_barrier_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
+    object_class_property_add_str(oc, "name",
+                                  input_barrier_get_name,
+                                  input_barrier_set_name);
+    object_class_property_add_str(oc, "server",
+                                  input_barrier_get_server,
+                                  input_barrier_set_server);
+    object_class_property_add_str(oc, "port",
+                                  input_barrier_get_port,
+                                  input_barrier_set_port);
+    object_class_property_add_str(oc, "x-origin",
+                                  input_barrier_get_x_origin,
+                                  input_barrier_set_x_origin);
+    object_class_property_add_str(oc, "y-origin",
+                                  input_barrier_get_y_origin,
+                                  input_barrier_set_y_origin);
+    object_class_property_add_str(oc, "width",
+                                  input_barrier_get_width,
+                                  input_barrier_set_width);
+    object_class_property_add_str(oc, "height",
+                                  input_barrier_get_height,
+                                  input_barrier_set_height);
+
     ucc->complete = input_barrier_complete;
 }
 
diff --git a/ui/input-linux.c b/ui/input-linux.c
index ab351a4187..df3dff8898 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -489,25 +489,26 @@ static void input_linux_set_grab_toggle(Object *obj, int value,
 
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
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
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
+
     ucc->complete = input_linux_complete;
 }
 
-- 
2.26.2


