Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F64C4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D195207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvFdKQwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D195207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKU5u-00057H-6O
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1f-0008P0-S9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1d-0001Zt-Bz
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZrRv5WK1DRp4gqR2jMWM6MQtae2evShrenuAPevph0=;
 b=hvFdKQwY2Zbf/ayDKPWVSggzEUeKL155C/vwIr7/U//2Ke8NM7ZUChe9jX8x9zZr2A7WOh
 luf//uOGQgdq1+iRq7SAfPLZuxDwbTW0Lr4I/xgeGMaP1O6aEKl2tkN20o6M20PWYkIGBf
 VpW3vyy+3kI1lwgQWiq6J48TJXFIHV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-rVLKgCDlPdiRS4cvBVhcGQ-1; Mon, 21 Sep 2020 18:11:06 -0400
X-MC-Unique: rVLKgCDlPdiRS4cvBVhcGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E018185C708
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 22:11:05 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0620873670;
 Mon, 21 Sep 2020 22:11:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/24] input-linux: Register properties as class properties
Date: Mon, 21 Sep 2020 18:10:30 -0400
Message-Id: <20200921221045.699690-10-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 18:11:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/input-linux.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index 5d501c8360c..cb86774a51e 100644
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
2.26.2


