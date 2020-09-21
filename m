Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960FAC4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1835323A60
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6NSG3Ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1835323A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKU9S-0000df-6K
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1j-000060-7H
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1h-0001b1-BI
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCTMr39FHuk0vjVaS7H5c3xouop2xzcz/9htq84mkLM=;
 b=d6NSG3Ug4XxfSfjbRoOgrBsr/ONjPmzGypitYnXWf75iKHo/PtAtLfREGCPoR1zdkG1n/c
 ip6pg/6E+di7YI8DBWJBmcyk7v59GhBhohItpOfgwJtmKgX2nOlKVcqdihD7LegS5w+Hh2
 xeAo273/nVZGvCMqpsVx8c87pwabcvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-Fbv_PM7IN9egNmuO9b0JSw-1; Mon, 21 Sep 2020 18:11:10 -0400
X-MC-Unique: Fbv_PM7IN9egNmuO9b0JSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87D91007461
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 22:11:09 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6A545D9CD;
 Mon, 21 Sep 2020 22:11:06 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/24] input-barrier: Register properties as class properties
Date: Mon, 21 Sep 2020 18:10:31 -0400
Message-Id: <20200921221045.699690-11-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
 ui/input-barrier.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 87543a33993..9a196d0a33d 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -689,28 +689,6 @@ static void input_barrier_instance_init(Object *obj)
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
@@ -718,6 +696,28 @@ static void input_barrier_class_init(ObjectClass *oc, void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = input_barrier_complete;
+
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
 }
 
 static const TypeInfo input_barrier_info = {
-- 
2.26.2


