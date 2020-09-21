Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F57C4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1243E23A62
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSM0Y/xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1243E23A62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKUC6-00049k-6B
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1l-0000Bo-DN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1j-0001bJ-Ff
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ow/Goc64TH+sEuIKExQSCYDG7D9ex4nmrSV1na4tT+4=;
 b=BSM0Y/xm/HWHe5tVe3w0A5j0i2AAT87aRUcEpDJglQLK+e2EK2G3yDgvfmnGcxArNxgf/4
 Ov+tD5flvAMJoT1z8PCeZ1pqEr0Zq/1rZrC67dnF/lkKCmwvnW7XOPtFcXkuc5PlHjveyo
 ikZxQ9M9ZEoFF9VWwEBHd9g/ys7jA+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-XJ313jX4OBWy2vr9XZL3cg-1; Mon, 21 Sep 2020 18:11:12 -0400
X-MC-Unique: XJ313jX4OBWy2vr9XZL3cg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4908B1007465
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 22:11:11 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AA7B75261;
 Mon, 21 Sep 2020 22:11:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/24] tmp421: Register properties as class properties
Date: Mon, 21 Sep 2020 18:10:32 -0400
Message-Id: <20200921221045.699690-12-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 18:11:01
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
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: qemu-devel@nongnu.org
---
 hw/misc/tmp421.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 212d6e0e831..1c19a3a9713 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -340,22 +340,6 @@ static void tmp421_realize(DeviceState *dev, Error **errp)
     tmp421_reset(&s->i2c);
 }
 
-static void tmp421_initfn(Object *obj)
-{
-    object_property_add(obj, "temperature0", "int",
-                        tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature1", "int",
-                        tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature2", "int",
-                        tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature3", "int",
-                        tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL);
-}
-
 static void tmp421_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -368,6 +352,19 @@ static void tmp421_class_init(ObjectClass *klass, void *data)
     k->send = tmp421_tx;
     dc->vmsd = &vmstate_tmp421;
     sc->dev = (DeviceInfo *) data;
+
+    object_class_property_add(klass, "temperature0", "int",
+                              tmp421_get_temperature,
+                              tmp421_set_temperature, NULL, NULL);
+    object_class_property_add(klass, "temperature1", "int",
+                              tmp421_get_temperature,
+                              tmp421_set_temperature, NULL, NULL);
+    object_class_property_add(klass, "temperature2", "int",
+                              tmp421_get_temperature,
+                              tmp421_set_temperature, NULL, NULL);
+    object_class_property_add(klass, "temperature3", "int",
+                              tmp421_get_temperature,
+                              tmp421_set_temperature, NULL, NULL);
 }
 
 static const TypeInfo tmp421_info = {
@@ -375,7 +372,6 @@ static const TypeInfo tmp421_info = {
     .parent        = TYPE_I2C_SLAVE,
     .instance_size = sizeof(TMP421State),
     .class_size    = sizeof(TMP421Class),
-    .instance_init = tmp421_initfn,
     .abstract      = true,
 };
 
-- 
2.26.2


