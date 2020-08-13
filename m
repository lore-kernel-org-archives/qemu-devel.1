Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08140C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46ED2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPRhz+Uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46ED2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Lx1-0008I8-1R
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6Lgh-0005im-Vr
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6Lgg-0002vH-5f
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dC75jBbWnZuGuRiE4XLHoj/ZZKtouKfKpeAWG3nMFAE=;
 b=FPRhz+Uf6QfvJUGIpFp8ePLL+KRNdLENyb9SfUwPXc9NHLdZnreuZNIZdWHqxEJDtYbLEz
 zEJHtEJ92I+dr1SZG6/ykboYJYpxFLkD0lth7AQA69G2O4lzr0r7eaj+Wkl9yET1jhE0Nk
 4vq2MZzgczgVnzc52teYyGX4SWIoRQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-n1ll3z8ONHO7v08QUVL37Q-1; Thu, 13 Aug 2020 18:27:03 -0400
X-MC-Unique: n1ll3z8ONHO7v08QUVL37Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF916100CA89
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:27:02 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6754E747A2;
 Thu, 13 Aug 2020 22:27:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/41] qom: DECLARE_*_CHECKERS macros
Date: Thu, 13 Aug 2020 18:26:13 -0400
Message-Id: <20200813222625.243136-30-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:26:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes the typedefs are buried inside another header, but
we want to benefit from the automatic definition of type cast
functions.  Introduce macros that will let type checkers be
defined when typedefs are already available.

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


