Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD3DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCBD20885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayxWbD0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCBD20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1f5-0002TX-0a
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1Tq-0000BI-8F
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:50:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1Td-0004t9-Er
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593705012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYSAMF0Yn2u4bbrj0q+Hl9G8PJi/A4StZknd6FourGA=;
 b=ayxWbD0Z7NP+f8cxJnaYTfpkOPnvFsMXKtiyb7JvP59UJLgqfGAMIjRhVdEOM2EMhhTZuG
 Y03LAqy4bJ213zaJc6tbfL16rWrj4Jp1Lw0u7YmXIf7r+AjvuMDdRKhW66xtSXA+qdqfk+
 JZ3fH25Rb78Jp/vOnoPC1Gial7tb+7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-pWhySCnlMBWSAeGWW976hg-1; Thu, 02 Jul 2020 11:50:08 -0400
X-MC-Unique: pWhySCnlMBWSAeGWW976hg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF393D8EA4;
 Thu,  2 Jul 2020 15:50:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7957017D8F;
 Thu,  2 Jul 2020 15:50:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 132271135236; Thu,  2 Jul 2020 17:50:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/44] qom: Make functions taking Error ** return bool,
 not 0/-1
Date: Thu,  2 Jul 2020 17:49:46 +0200
Message-Id: <20200702155000.3455325-31-armbru@redhat.com>
In-Reply-To: <20200702155000.3455325-1-armbru@redhat.com>
References: <20200702155000.3455325-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just for consistency.  Also fix the example in object_set_props()'s
documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qom/object.h | 28 +++++++++++-----------------
 qom/object.c         | 14 +++++++-------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index b2d2558245..d74ede4eac 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -729,15 +729,13 @@ void object_apply_compat_props(Object *obj);
  *   Error *err = NULL;
  *   Object *obj = ...get / create object...;
  *
- *   obj = object_set_props(obj,
- *                          &err,
- *                          "share", "yes",
- *                          "mem-path", "/dev/shm/somefile",
- *                          "prealloc", "yes",
- *                          "size", "1048576",
- *                          NULL);
- *
- *   if (!obj) {
+ *   if (!object_set_props(obj,
+ *                         &err,
+ *                         "share", "yes",
+ *                         "mem-path", "/dev/shm/somefile",
+ *                         "prealloc", "yes",
+ *                         "size", "1048576",
+ *                         NULL)) {
  *     error_reportf_err(err, "Cannot set properties: ");
  *   }
  *   </programlisting>
@@ -746,11 +744,9 @@ void object_apply_compat_props(Object *obj);
  * The returned object will have one stable reference maintained
  * for as long as it is present in the object hierarchy.
  *
- * Returns: -1 on error, 0 on success
+ * Returns: %true on success, %false on error.
  */
-int object_set_props(Object *obj,
-                     Error **errp,
-                     ...) QEMU_SENTINEL;
+bool object_set_props(Object *obj, Error **errp, ...) QEMU_SENTINEL;
 
 /**
  * object_set_propv:
@@ -760,11 +756,9 @@ int object_set_props(Object *obj,
  *
  * See object_set_props() for documentation.
  *
- * Returns: -1 on error, 0 on success
+ * Returns: %true on success, %false on error.
  */
-int object_set_propv(Object *obj,
-                     Error **errp,
-                     va_list vargs);
+bool object_set_propv(Object *obj, Error **errp, va_list vargs);
 
 /**
  * object_initialize:
diff --git a/qom/object.c b/qom/object.c
index ebfe6e6c51..bd8c86ec6f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -557,7 +557,7 @@ bool object_initialize_child_with_propsv(Object *parentobj,
     object_initialize(childobj, size, type);
     obj = OBJECT(childobj);
 
-    if (object_set_propv(obj, errp, vargs) < 0) {
+    if (!object_set_propv(obj, errp, vargs)) {
         goto out;
     }
 
@@ -752,7 +752,7 @@ Object *object_new_with_propv(const char *typename,
     }
     obj = object_new_with_type(klass->type);
 
-    if (object_set_propv(obj, errp, vargs) < 0) {
+    if (!object_set_propv(obj, errp, vargs)) {
         goto error;
     }
 
@@ -780,12 +780,12 @@ Object *object_new_with_propv(const char *typename,
 }
 
 
-int object_set_props(Object *obj,
+bool object_set_props(Object *obj,
                      Error **errp,
                      ...)
 {
     va_list vargs;
-    int ret;
+    bool ret;
 
     va_start(vargs, errp);
     ret = object_set_propv(obj, errp, vargs);
@@ -795,7 +795,7 @@ int object_set_props(Object *obj,
 }
 
 
-int object_set_propv(Object *obj,
+bool object_set_propv(Object *obj,
                      Error **errp,
                      va_list vargs)
 {
@@ -809,12 +809,12 @@ int object_set_propv(Object *obj,
         g_assert(value != NULL);
         if (!object_property_parse(obj, propname, value, &local_err)) {
             error_propagate(errp, local_err);
-            return -1;
+            return false;
         }
         propname = va_arg(vargs, char *);
     }
 
-    return 0;
+    return true;
 }
 
 
-- 
2.26.2


