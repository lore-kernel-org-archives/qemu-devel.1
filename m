Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB28C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC40120675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1Vq1rzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC40120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqMb-000624-1M
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7F-0002AL-31
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq75-0006pM-M5
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JE/AoBk+Nw3Lc3/qVN9lvjJTtWoe7QKSHsEbelLEVVA=;
 b=b1Vq1rzUeN0yGVuIqhvKsUfuTfCaJGHtmXd+CUuXWv7HRnLP+pCEE5vQkdyB41e1SdiXw1
 YVi76vlG/QYfUUyPTLuKFuh5EvJjfJ9M3hxpFvzIZqfbMaw8qxqPUwsvxbA8BJSWThQ6LS
 r5aKUslcUMVUJy4MSE/4rOrgsb13eCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-k_xERq96O6O5J_vwGle0Ew-1; Tue, 07 Jul 2020 12:06:27 -0400
X-MC-Unique: k_xERq96O6O5J_vwGle0Ew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5181CBFC3;
 Tue,  7 Jul 2020 16:06:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A45B19D7B;
 Tue,  7 Jul 2020 16:06:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECBAC11275F8; Tue,  7 Jul 2020 18:06:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 30/45] qom: Make functions taking Error ** return bool,
 not 0/-1
Date: Tue,  7 Jul 2020 18:05:58 +0200
Message-Id: <20200707160613.848843-31-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just for consistency.  Also fix the example in object_set_props()'s
documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qom/object.h | 28 +++++++++++-----------------
 qom/object.c         | 14 +++++++-------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 189f8ecbf6..04271ea5de 100644
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
index 25c5ddb78f..97c4e0af07 100644
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


