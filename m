Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12ABC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EED1206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wp5aV4KR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EED1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwK5-00028Y-7o
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwE8-0000Lc-4U
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwE5-0006XU-Ml
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599166376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzJ0fBUbaOGpIRJlrVvOmS3lXKZBwJYdPPskPKJO3e8=;
 b=Wp5aV4KR7EMDpjSfefSueRXaISV0Fvyh5UseA84cEHPqES1YHrkblP9IeAeCi/ZveLdOcx
 Bj8Ia+kqVVsMo0NCMV0X+NQyHw+j+6tZ95+4diFcLtO/yR8k8GVzgQn2znIyCshSkG7W4a
 XNuhpEWDGuBQIcDL+4DRaZCOph8rhEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-FEOqU7_sN32EiIYmuV-b-Q-1; Thu, 03 Sep 2020 16:52:54 -0400
X-MC-Unique: FEOqU7_sN32EiIYmuV-b-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F171801AEC;
 Thu,  3 Sep 2020 20:52:53 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 288405D9CC;
 Thu,  3 Sep 2020 20:52:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/27] qom: DECLARE_*_CHECKERS macros
Date: Thu,  3 Sep 2020 16:52:24 -0400
Message-Id: <20200903205247.1667472-5-ehabkost@redhat.com>
In-Reply-To: <20200903205247.1667472-1-ehabkost@redhat.com>
References: <20200903205247.1667472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes the typedefs are buried inside another header, but
we want to benefit from the automatic definition of type cast
functions.  Introduce macros that will let type checkers be
defined when typedefs are already available.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200831210740.126168-5-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 72 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 500e7dfa99..4cd84998c2 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -553,6 +553,62 @@ struct Object
     Object *parent;
 };
 
+/**
+ * DECLARE_INSTANCE_CHECKER:
+ * @InstanceType: instance struct name
+ * @OBJ_NAME: the object name in uppercase with underscore separators
+ * @TYPENAME: type name
+ *
+ * Direct usage of this macro should be avoided, and the complete
+ * OBJECT_DECLARE_TYPE macro is recommended instead.
+ *
+ * This macro will provide the three standard type cast functions for a
+ * QOM type.
+ */
+#define DECLARE_INSTANCE_CHECKER(InstanceType, OBJ_NAME, TYPENAME) \
+    static inline G_GNUC_UNUSED InstanceType * \
+    OBJ_NAME(void *obj) \
+    { return OBJECT_CHECK(InstanceType, obj, TYPENAME); }
+
+/**
+ * DECLARE_CLASS_CHECKERS:
+ * @ClassType: class struct name
+ * @OBJ_NAME: the object name in uppercase with underscore separators
+ * @TYPENAME: type name
+ *
+ * Direct usage of this macro should be avoided, and the complete
+ * OBJECT_DECLARE_TYPE macro is recommended instead.
+ *
+ * This macro will provide the three standard type cast functions for a
+ * QOM type.
+ */
+#define DECLARE_CLASS_CHECKERS(ClassType, OBJ_NAME, TYPENAME) \
+    static inline G_GNUC_UNUSED ClassType * \
+    OBJ_NAME##_GET_CLASS(void *obj) \
+    { return OBJECT_GET_CLASS(ClassType, obj, TYPENAME); } \
+    \
+    static inline G_GNUC_UNUSED ClassType * \
+    OBJ_NAME##_CLASS(void *klass) \
+    { return OBJECT_CLASS_CHECK(ClassType, klass, TYPENAME); }
+
+/**
+ * DECLARE_OBJ_CHECKERS:
+ * @InstanceType: instance struct name
+ * @ClassType: class struct name
+ * @OBJ_NAME: the object name in uppercase with underscore separators
+ * @TYPENAME: type name
+ *
+ * Direct usage of this macro should be avoided, and the complete
+ * OBJECT_DECLARE_TYPE macro is recommended instead.
+ *
+ * This macro will provide the three standard type cast functions for a
+ * QOM type.
+ */
+#define DECLARE_OBJ_CHECKERS(InstanceType, ClassType, OBJ_NAME, TYPENAME) \
+    DECLARE_INSTANCE_CHECKER(InstanceType, OBJ_NAME, TYPENAME) \
+    \
+    DECLARE_CLASS_CHECKERS(ClassType, OBJ_NAME, TYPENAME)
+
 /**
  * OBJECT_DECLARE_TYPE:
  * @InstanceType: instance struct name
@@ -574,20 +630,8 @@ struct Object
     \
     G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
     \
-    static inline G_GNUC_UNUSED ClassType * \
-    MODULE_OBJ_NAME##_GET_CLASS(void *obj) \
-    { return OBJECT_GET_CLASS(ClassType, obj, \
-                              TYPE_##MODULE_OBJ_NAME); } \
-    \
-    static inline G_GNUC_UNUSED ClassType * \
-    MODULE_OBJ_NAME##_CLASS(void *klass) \
-    { return OBJECT_CLASS_CHECK(ClassType, klass, \
-                                TYPE_##MODULE_OBJ_NAME); } \
-    \
-    static inline G_GNUC_UNUSED InstanceType * \
-    MODULE_OBJ_NAME(void *obj) \
-    { return OBJECT_CHECK(InstanceType, obj, \
-                          TYPE_##MODULE_OBJ_NAME); }
+    DECLARE_OBJ_CHECKERS(InstanceType, ClassType, \
+                         MODULE_OBJ_NAME, TYPE_##MODULE_OBJ_NAME)
 
 /**
  * OBJECT_DECLARE_SIMPLE_TYPE:
-- 
2.26.2


