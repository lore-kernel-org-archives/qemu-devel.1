Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2639AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841042064C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXxEyBtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841042064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLV0-0002c3-Jc
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFP-0002nf-0m
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFL-0005e4-Td
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H98XLpUksdIgX7C5G11L5PaMJaT7m6T8YKA2VVNxxBo=;
 b=MXxEyBtYJBx4BXx2yNw2omjDqwha+rT5QwswRuQi3UkmNEawl0/kKgVTGJNFUqyCn4y4aS
 sh6/IZIU5VLVDbPPGo3Y0ybEJjsyh329MmjFImTDxKe5B0JezyEo3JlXMrAm8Wc9oTKH5J
 QRNPZAShv4PJHqIt8GCTRzV6tBQefDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-6_tuzgmNNPuF0fzxxnmWkA-1; Wed, 04 Nov 2020 11:02:49 -0500
X-MC-Unique: 6_tuzgmNNPuF0fzxxnmWkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A57851097F36;
 Wed,  4 Nov 2020 16:02:12 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE3A55798;
 Wed,  4 Nov 2020 16:02:12 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 32/44] qom: Add allow_set callback to ObjectProperty
Date: Wed,  4 Nov 2020 11:00:09 -0500
Message-Id: <20201104160021.2342108-33-ehabkost@redhat.com>
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

Add a ObjectProperty.allow_set callback, that can be set by QOM
property registration functions.

Note that this doesn't replace the check callback at
object*_property_add_link() (yet), because currently the link
property check callback needs to get the property value as
argument (despite this not being necessary in most cases).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Redone patch on top of changes in previous patches in the
  series
* Provide prop_allow_set_always() and prop_allow_set_never()
  helpers
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/qom/object.h | 38 ++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 16 ++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index d378f13a11..2ab124b8f0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -86,6 +86,43 @@ typedef void (ObjectPropertyRelease)(Object *obj,
  */
 typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
 
+/**
+ * typedef ObjectPropertyAllowSet:
+ * @obj: the object that owns the property
+ * @prop: the property being set
+ * @errp: pointer to error information
+ *
+ * Called when a property is being set.
+ *
+ * If return value is false, it will prevent the property from
+ * being changed.  Error information should be filled in @errp
+ * if return vlaue is false.
+ */
+typedef bool (ObjectPropertyAllowSet)(Object *obj, ObjectProperty *prop,
+                                      Error **errp);
+
+/**
+ * prop_allow_set_always:
+ * @obj: the object that owns the property
+ * @prop: the property being set
+ * @errp: pointer to error information
+ *
+ * ObjectPropertyAllowSet implementation that always allow the
+ * property to be set.
+ */
+bool prop_allow_set_always(Object *obj, ObjectProperty *prop, Error **errp);
+
+/**
+ * prop_allow_set_never:
+ * @obj: the object that owns the property
+ * @prop: the property being set
+ * @errp: pointer to error information
+ *
+ * ObjectPropertyAllowSet implementation that never allows the
+ * property to be set.
+ */
+bool prop_allow_set_never(Object *obj, ObjectProperty *prop, Error **errp);
+
 struct ObjectProperty
 {
     char *name;
@@ -96,6 +133,7 @@ struct ObjectProperty
     ObjectPropertyResolve *resolve;
     ObjectPropertyRelease *release;
     ObjectPropertyInit *init;
+    ObjectPropertyAllowSet *allow_set;
     void *opaque;
     QObject *defval;
 };
diff --git a/qom/object.c b/qom/object.c
index 1065355233..7c11bcd3b1 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1381,6 +1381,18 @@ bool object_property_get(Object *obj, const char *name, Visitor *v,
     return !err;
 }
 
+bool prop_allow_set_always(Object *obj, ObjectProperty *prop, Error **errp)
+{
+    return true;
+}
+
+bool prop_allow_set_never(Object *obj, ObjectProperty *prop, Error **errp)
+{
+    error_setg(errp, "Property '%s.%s' can't be set",
+               object_get_typename(obj), prop->name);
+    return false;
+}
+
 bool object_property_set(Object *obj, const char *name, Visitor *v,
                          Error **errp)
 {
@@ -1395,6 +1407,10 @@ bool object_property_set(Object *obj, const char *name, Visitor *v,
         error_setg(errp, QERR_PERMISSION_DENIED);
         return false;
     }
+    if (prop->allow_set && !prop->allow_set(obj, prop, errp)) {
+        return false;
+    }
+
     prop->set(obj, v, name, prop->opaque, &err);
     error_propagate(errp, err);
     return !err;
-- 
2.28.0


