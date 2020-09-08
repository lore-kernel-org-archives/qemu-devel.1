Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EB0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6773D20658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzepuK9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6773D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjqV-0005nX-BT
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjo7-0000hV-0j
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjo4-0004JA-Ro
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599595292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9wpfpFY9cCriCCJs74ijsD+iryOC4RfWojjLq6lqRU=;
 b=MzepuK9Jn4Dl0BCQD3vwS+V+duqPEnRHUNdFoi6Wo9L3FoPmeO1k8JlExRNPG/80sU7v4O
 annIYXJhhlPVWYltCYhdX+0mQubv8fAf6Z0riyn78UzY4hpL8oY7yLGsc9aDGbCvrzFtRw
 9CG2JGQGrEHCWm8XAM0ZqhHzouNpkz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-sAfsqWLpMhSKMBkXLCUfkw-1; Tue, 08 Sep 2020 16:01:30 -0400
X-MC-Unique: sAfsqWLpMhSKMBkXLCUfkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4329F1005E5C;
 Tue,  8 Sep 2020 20:01:29 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F109702E7;
 Tue,  8 Sep 2020 20:01:28 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 04/34] qom: Allow class type name to be specified in
 OBJECT_DECLARE*
Date: Tue,  8 Sep 2020 16:00:53 -0400
Message-Id: <20200908200123.3402311-5-ehabkost@redhat.com>
In-Reply-To: <20200908200123.3402311-1-ehabkost@redhat.com>
References: <20200908200123.3402311-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
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

Many QOM types don't follow the Type/TypeClass pattern
on the instance/struct names.  Let the class struct name
be specified in the OBJECT_DECLARE* macros.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200831210740.126168-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f515230f61..500e7dfa99 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -555,7 +555,8 @@ struct Object
 
 /**
  * OBJECT_DECLARE_TYPE:
- * @ModuleObjName: the object name with initial capitalization
+ * @InstanceType: instance struct name
+ * @ClassType: class struct name
  * @module_obj_name: the object name in lowercase with underscore separators
  * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
  *
@@ -567,33 +568,33 @@ struct Object
  *
  * The object struct and class struct need to be declared manually.
  */
-#define OBJECT_DECLARE_TYPE(ModuleObjName, module_obj_name, MODULE_OBJ_NAME) \
-    typedef struct ModuleObjName ModuleObjName; \
-    typedef struct ModuleObjName##Class ModuleObjName##Class; \
+#define OBJECT_DECLARE_TYPE(InstanceType, ClassType, module_obj_name, MODULE_OBJ_NAME) \
+    typedef struct InstanceType InstanceType; \
+    typedef struct ClassType ClassType; \
     \
-    G_DEFINE_AUTOPTR_CLEANUP_FUNC(ModuleObjName, object_unref) \
+    G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
     \
-    static inline G_GNUC_UNUSED ModuleObjName##Class * \
+    static inline G_GNUC_UNUSED ClassType * \
     MODULE_OBJ_NAME##_GET_CLASS(void *obj) \
-    { return OBJECT_GET_CLASS(ModuleObjName##Class, obj, \
+    { return OBJECT_GET_CLASS(ClassType, obj, \
                               TYPE_##MODULE_OBJ_NAME); } \
     \
-    static inline G_GNUC_UNUSED ModuleObjName##Class * \
+    static inline G_GNUC_UNUSED ClassType * \
     MODULE_OBJ_NAME##_CLASS(void *klass) \
-    { return OBJECT_CLASS_CHECK(ModuleObjName##Class, klass, \
+    { return OBJECT_CLASS_CHECK(ClassType, klass, \
                                 TYPE_##MODULE_OBJ_NAME); } \
     \
-    static inline G_GNUC_UNUSED ModuleObjName * \
+    static inline G_GNUC_UNUSED InstanceType * \
     MODULE_OBJ_NAME(void *obj) \
-    { return OBJECT_CHECK(ModuleObjName, obj, \
+    { return OBJECT_CHECK(InstanceType, obj, \
                           TYPE_##MODULE_OBJ_NAME); }
 
 /**
  * OBJECT_DECLARE_SIMPLE_TYPE:
- * @ModuleObjName: the object name with initial caps
+ * @InstanceType: instance struct name
  * @module_obj_name: the object name in lowercase with underscore separators
  * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
- * @ParentModuleObjName: the parent object name with initial caps
+ * @ParentClassType: class struct name of parent type
  *
  * This does the same as OBJECT_DECLARE_TYPE(), but also declares
  * the class struct, thus only the object struct needs to be declare
@@ -602,10 +603,10 @@ struct Object
  * This macro should be used unless the class struct needs to have
  * virtual methods declared.
  */
-#define OBJECT_DECLARE_SIMPLE_TYPE(ModuleObjName, module_obj_name, \
-                                   MODULE_OBJ_NAME, ParentModuleObjName) \
-    OBJECT_DECLARE_TYPE(ModuleObjName, module_obj_name, MODULE_OBJ_NAME) \
-    struct ModuleObjName##Class { ParentModuleObjName##Class parent_class; };
+#define OBJECT_DECLARE_SIMPLE_TYPE(InstanceType, module_obj_name, \
+                                   MODULE_OBJ_NAME, ParentClassType) \
+    OBJECT_DECLARE_TYPE(InstanceType, InstanceType##Class, module_obj_name, MODULE_OBJ_NAME) \
+    struct InstanceType##Class { ParentClassType parent_class; };
 
 
 /**
-- 
2.26.2


