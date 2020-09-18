Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E58C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AF22158C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifm5ce0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AF22158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOKK-0005nx-63
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNIG-0002e8-5k
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNI2-0006Hf-5d
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLrIDApUcgOCvc/oGCOA8twHr0W5cXxAQ0f1YfYRYiQ=;
 b=ifm5ce0AWw8KMkhct/35h5ZKvl8+lcOo3LdTDjMjc5LwJMnIRa86rprSYwuTr16e8BJlXU
 jHjQFl3Gsi/d5ZAkd7gTfx2jFv7fG1RyHYqQds/KA3QxTImiwHD/hY+hlAszCJ0OGYmHlU
 ttR8iHETImkpGmKs6o7OlppQ8FcsMjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Z9VTgYuUOom0GmmcSmLdGQ-1; Fri, 18 Sep 2020 16:47:25 -0400
X-MC-Unique: Z9VTgYuUOom0GmmcSmLdGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106A184639B;
 Fri, 18 Sep 2020 20:47:24 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCC0468D64;
 Fri, 18 Sep 2020 20:47:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 08/17] qom: Allow objects to be allocated with increased
 alignment
Date: Fri, 18 Sep 2020 16:47:05 -0400
Message-Id: <20200918204714.27276-9-ehabkost@redhat.com>
In-Reply-To: <20200918204714.27276-1-ehabkost@redhat.com>
References: <20200918204714.27276-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

It turns out that some hosts have a default malloc alignment less
than that required for vectors.

We assume that, with compiler annotation on CPUArchState, that we
can properly align the vector portion of the guest state.  Fix the
alignment of the allocation by using qemu_memalloc when required.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200916004638.2444147-3-richard.henderson@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h |  5 +++++
 qom/object.c         | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 32524d72cc..405a2c67b0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -691,6 +691,7 @@ struct Object
         .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
         .name = TYPE_##MODULE_OBJ_NAME, \
         .instance_size = sizeof(ModuleObjName), \
+        .instance_align = __alignof__(ModuleObjName), \
         .instance_init = module_obj_name##_init, \
         .instance_finalize = module_obj_name##_finalize, \
         .class_size = sizeof(ModuleObjName##Class), \
@@ -770,6 +771,9 @@ struct Object
  * @instance_size: The size of the object (derivative of #Object).  If
  *   @instance_size is 0, then the size of the object will be the size of the
  *   parent object.
+ * @instance_align: The required alignment of the object.  If @instance_align
+ *   is 0, then normal malloc alignment is sufficient; if non-zero, then we
+ *   must use qemu_memalign for allocation.
  * @instance_init: This function is called to initialize an object.  The parent
  *   class will have already been initialized so the type is only responsible
  *   for initializing its own members.
@@ -807,6 +811,7 @@ struct TypeInfo
     const char *parent;
 
     size_t instance_size;
+    size_t instance_align;
     void (*instance_init)(Object *obj);
     void (*instance_post_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
diff --git a/qom/object.c b/qom/object.c
index cecad35b99..a91a6a515a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -50,6 +50,7 @@ struct TypeImpl
     size_t class_size;
 
     size_t instance_size;
+    size_t instance_align;
 
     void (*class_init)(ObjectClass *klass, void *data);
     void (*class_base_init)(ObjectClass *klass, void *data);
@@ -114,6 +115,7 @@ static TypeImpl *type_new(const TypeInfo *info)
 
     ti->class_size = info->class_size;
     ti->instance_size = info->instance_size;
+    ti->instance_align = info->instance_align;
 
     ti->class_init = info->class_init;
     ti->class_base_init = info->class_base_init;
@@ -688,16 +690,44 @@ static void object_finalize(void *data)
     }
 }
 
+/* Find the minimum alignment guaranteed by the system malloc. */
+#if __STDC_VERSION__ >= 201112L
+typddef max_align_t qemu_max_align_t;
+#else
+typedef union {
+    long l;
+    void *p;
+    double d;
+    long double ld;
+} qemu_max_align_t;
+#endif
+
 static Object *object_new_with_type(Type type)
 {
     Object *obj;
+    size_t size, align;
+    void (*obj_free)(void *);
 
     g_assert(type != NULL);
     type_initialize(type);
 
-    obj = g_malloc(type->instance_size);
-    object_initialize_with_type(obj, type->instance_size, type);
-    obj->free = g_free;
+    size = type->instance_size;
+    align = type->instance_align;
+
+    /*
+     * Do not use qemu_memalign unless required.  Depending on the
+     * implementation, extra alignment implies extra overhead.
+     */
+    if (likely(align <= __alignof__(qemu_max_align_t))) {
+        obj = g_malloc(size);
+        obj_free = g_free;
+    } else {
+        obj = qemu_memalign(align, size);
+        obj_free = qemu_vfree;
+    }
+
+    object_initialize_with_type(obj, size, type);
+    obj->free = obj_free;
 
     return obj;
 }
-- 
2.26.2


