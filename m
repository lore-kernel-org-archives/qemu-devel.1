Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA2D206D4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmxLrlne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA2D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLej-0007m7-MX
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFa-0003HI-3P
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFP-0005fR-Ng
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaZtid/+gsxr1KnVgg0LqfYYoT5G3HSDJ0Ji8I0AsHI=;
 b=XmxLrlnexnc6luKyIlI3d9//CY1IsvvDD9KL+wJZcid9PM9o2jgDbJftHGy0vcQL5XzbF/
 HH6LYiwdtEf9sY6TRsodJHL8VF1ofA/NXmULcT2FY6SoDTc2rQcgk6IiuSq+np7zZsVuEr
 16Dq+oYo8pIN/cNaLNcb8sZGRnR2Eb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434---tCFuaePsGQsvCcId0f2w-1; Wed, 04 Nov 2020 11:02:53 -0500
X-MC-Unique: --tCFuaePsGQsvCcId0f2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B37BB1A2E95E;
 Wed,  4 Nov 2020 16:02:11 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62A425C5DE;
 Wed,  4 Nov 2020 16:02:08 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 34/44] qdev: Make qdev_propinfo_get_uint16() static
Date: Wed,  4 Nov 2020 11:00:11 -0500
Message-Id: <20201104160021.2342108-35-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

There are no users of the function outside qdev-properties.c.
Make function static and rename it to get_uint16().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-prop-internal.h | 2 --
 hw/core/qdev-properties.c    | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index 9fac681e38..3a1e2bbc27 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -20,8 +20,6 @@ void qdev_propinfo_set_default_value_int(ObjectProperty *op,
 void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
                                           const Property *prop);
 
-void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp);
 void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp);
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ec9e456d95..2a9f62a922 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -295,8 +295,8 @@ const PropertyInfo qdev_prop_uint8 = {
 
 /* --- 16bit integer --- */
 
-void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
+static void get_uint16(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
 {
     Property *prop = opaque;
     uint16_t *ptr = qdev_get_prop_ptr(obj, prop);
@@ -315,7 +315,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_uint16 = {
     .name  = "uint16",
-    .get   = qdev_propinfo_get_uint16,
+    .get   = get_uint16,
     .set   = set_uint16,
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
-- 
2.28.0


