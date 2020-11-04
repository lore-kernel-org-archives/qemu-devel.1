Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF79C388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4306720719
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDEI4/0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4306720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLO3-0006eP-Uy
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLEu-0001Z5-3h
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLEr-0005Zq-Ue
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdMyOjPEyHa8ld0hjAoBSsicMflgaQnNdGClhjzau5k=;
 b=eDEI4/0pfAClI+IZFP2hYzOYCLG9g+mY9pLtzg+hb9TWW4n+qBY5Tv1ePr/OUpFgmJYoxM
 baf9HjVq+/QLoVJnmnZLZy36/xahm0k3crXxUuqr8dgIhWPFLKnPcExS5+rWhksIL+yf7w
 1Lb2TjOR3Yun7zSOAwmwAB7v0EF3FhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-EeJL43U9MnS7BG3e5qDCOw-1; Wed, 04 Nov 2020 11:02:16 -0500
X-MC-Unique: EeJL43U9MnS7BG3e5qDCOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 189DF12CC67;
 Wed,  4 Nov 2020 16:01:21 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 811988357C;
 Wed,  4 Nov 2020 16:01:20 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/44] qdev: Make bit_prop_set() get Object* argument
Date: Wed,  4 Nov 2020 10:59:45 -0500
Message-Id: <20201104160021.2342108-9-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the code more generic and not specific to TYPE_DEVICE.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-properties.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index b6cf53e929..3a4638f4de 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -92,8 +92,9 @@ static uint32_t qdev_get_prop_mask(Property *prop)
     return 0x1 << prop->bitnr;
 }
 
-static void bit_prop_set(DeviceState *dev, Property *props, bool val)
+static void bit_prop_set(Object *obj, Property *props, bool val)
 {
+    DeviceState *dev = DEVICE(obj);
     uint32_t *p = qdev_get_prop_ptr(dev, props);
     uint32_t mask = qdev_get_prop_mask(props);
     if (val) {
@@ -129,7 +130,7 @@ static void prop_set_bit(Object *obj, Visitor *v, const char *name,
     if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
-    bit_prop_set(dev, prop, value);
+    bit_prop_set(obj, prop, value);
 }
 
 static void set_default_value_bool(ObjectProperty *op, const Property *prop)
@@ -153,8 +154,9 @@ static uint64_t qdev_get_prop_mask64(Property *prop)
     return 0x1ull << prop->bitnr;
 }
 
-static void bit64_prop_set(DeviceState *dev, Property *props, bool val)
+static void bit64_prop_set(Object *obj, Property *props, bool val)
 {
+    DeviceState *dev = DEVICE(obj);
     uint64_t *p = qdev_get_prop_ptr(dev, props);
     uint64_t mask = qdev_get_prop_mask64(props);
     if (val) {
@@ -190,7 +192,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
     if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
-    bit64_prop_set(dev, prop, value);
+    bit64_prop_set(obj, prop, value);
 }
 
 const PropertyInfo qdev_prop_bit64 = {
-- 
2.28.0


