Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46435C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B268920665
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvtV+B9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B268920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLVA-00033U-Nw
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFX-0003BU-Ot
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFP-0005fP-Nx
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7270hbDFJf10L+jBPZu0S0+3zjLu26lLc2uz5p62+8=;
 b=RvtV+B9loUt5eUk8d/SWv+9Lwvls/tB1YV67r0qClTr+4bDoCeU4KFkJQ+89S/U3WtbNzk
 h+Yaj5/C+2o/Q3llGWM65jecQoRw8BrcDedAxoSllv7nzulNLYfPrW3xAxouC69X6tBdZA
 tt/es1ioE/oo8aQtjyHtWqqM1CJE8hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-FqGvdunvOYiEEsJgk07nEA-1; Wed, 04 Nov 2020 11:02:49 -0500
X-MC-Unique: FqGvdunvOYiEEsJgk07nEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DA1CAD7E2;
 Wed,  4 Nov 2020 16:01:41 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3DA610F3;
 Wed,  4 Nov 2020 16:01:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/44] qdev: Add name parameter to qdev_class_add_property()
Date: Wed,  4 Nov 2020 10:59:56 -0500
Message-Id: <20201104160021.2342108-20-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make it easier to remove Property.name in the future.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
This is a new patch added in series v2
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-properties.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 69181ce31d..dff98646e6 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -887,7 +887,8 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
     }
 }
 
-static void qdev_class_add_property(DeviceClass *klass, Property *prop)
+static void qdev_class_add_property(DeviceClass *klass, const char *name,
+                                    Property *prop)
 {
     ObjectClass *oc = OBJECT_CLASS(klass);
 
@@ -897,7 +898,7 @@ static void qdev_class_add_property(DeviceClass *klass, Property *prop)
         ObjectProperty *op;
 
         op = object_class_property_add(oc,
-                                       prop->name, prop->info->name,
+                                       name, prop->info->name,
                                        prop->info->get, prop->info->set,
                                        prop->info->release,
                                        prop);
@@ -905,7 +906,7 @@ static void qdev_class_add_property(DeviceClass *klass, Property *prop)
             prop->info->set_default_value(op, prop);
         }
     }
-    object_class_property_set_description(oc, prop->name,
+    object_class_property_set_description(oc, name,
                                           prop->info->description);
 }
 
@@ -962,7 +963,7 @@ void device_class_set_props(DeviceClass *dc, Property *props)
     dc->props_ = props;
     for (prop = props; prop && prop->name; prop++) {
         qdev_class_add_legacy_property(dc, prop);
-        qdev_class_add_property(dc, prop);
+        qdev_class_add_property(dc, prop->name, prop);
     }
 }
 
-- 
2.28.0


