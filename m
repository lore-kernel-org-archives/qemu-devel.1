Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C2DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E3520775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtjazHtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E3520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtI4h-0003mT-RD
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHgl-0006td-QB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:33:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60388
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHgh-0002mq-2y
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZKxpK8CLDy2POMPj/ev17VEMZHFCX2DrRtktbvLGfo=;
 b=OtjazHtF+oCxXy5iws0wstzYfHs1BLHmgIhmMTPVHjs7VHIzJSo22MyxMkE+1IfYF8ldw5
 9Cm/8inHs2oCNqKHgfGudpyliUi/djZ5z4uVPK1ti5w9MD+79Wa6m/AUldITV8XiRBEMai
 SGj+LPtu6CP0PwDRir8arR3QXk4AUkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-anP2njqSOWezMB1hp16R0Q-1; Tue, 07 Jul 2020 17:25:14 -0400
X-MC-Unique: anP2njqSOWezMB1hp16R0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD83CBFC1;
 Tue,  7 Jul 2020 21:25:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2268C0067;
 Tue,  7 Jul 2020 21:25:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F8261144249; Tue,  7 Jul 2020 23:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/53] qapi: Make visitor functions taking Error ** return bool,
 not void
Date: Tue,  7 Jul 2020 23:24:27 +0200
Message-Id: <20200707212503.1495927-18-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

See recent commit "error: Document Error API usage rules" for
rationale.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200707160613.848843-18-armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt  |  51 +++++------
 include/qapi/clone-visitor.h  |   8 +-
 include/qapi/visitor-impl.h   |  26 +++---
 include/qapi/visitor.h        | 102 ++++++++++++---------
 audio/audio_legacy.c          |  15 ++--
 qapi/opts-visitor.c           |  66 ++++++++------
 qapi/qapi-clone-visitor.c     |  69 +++++++-------
 qapi/qapi-dealloc-visitor.c   |  27 ++++--
 qapi/qapi-visit-core.c        | 165 ++++++++++++++++++----------------
 qapi/qobject-input-visitor.c  | 109 +++++++++++++---------
 qapi/qobject-output-visitor.c |  27 ++++--
 qapi/string-input-visitor.c   |  62 +++++++------
 qapi/string-output-visitor.c  |  32 ++++---
 scripts/qapi/visit.py         |  58 +++++-------
 14 files changed, 456 insertions(+), 361 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index a7794ef658..9bfc57063c 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1408,42 +1408,38 @@ Example:
     #include "example-qapi-types.h"
 
 
-    void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp);
-    void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
-    void visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp);
+    bool visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp);
+    bool visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
+    bool visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp);
 
-    void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp);
+    bool visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp);
 
     #endif /* EXAMPLE_QAPI_VISIT_H */
     $ cat qapi-generated/example-qapi-visit.c
 [Uninteresting stuff omitted...]
 
-    void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
+    bool visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
     {
         Error *err = NULL;
 
-        visit_type_int(v, "integer", &obj->integer, &err);
-        if (err) {
-            goto out;
+        if (!visit_type_int(v, "integer", &obj->integer, errp)) {
+            return false;
         }
         if (visit_optional(v, "string", &obj->has_string)) {
-            visit_type_str(v, "string", &obj->string, &err);
-            if (err) {
-                goto out;
+            if (!visit_type_str(v, "string", &obj->string, errp)) {
+                return false;
             }
         }
-
-    out:
         error_propagate(errp, err);
+        return !err;
     }
 
-    void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp)
+    bool visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp)
     {
         Error *err = NULL;
 
-        visit_start_struct(v, name, (void **)obj, sizeof(UserDefOne), &err);
-        if (err) {
-            goto out;
+        if (!visit_start_struct(v, name, (void **)obj, sizeof(UserDefOne), errp)) {
+            return false;
         }
         if (!*obj) {
             /* incomplete */
@@ -1461,19 +1457,18 @@ Example:
             qapi_free_UserDefOne(*obj);
             *obj = NULL;
         }
-    out:
         error_propagate(errp, err);
+        return !err;
     }
 
-    void visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp)
+    bool visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp)
     {
         Error *err = NULL;
         UserDefOneList *tail;
         size_t size = sizeof(**obj);
 
-        visit_start_list(v, name, (GenericList **)obj, size, &err);
-        if (err) {
-            goto out;
+        if (!visit_start_list(v, name, (GenericList **)obj, size, errp)) {
+            return false;
         }
 
         for (tail = *obj; tail;
@@ -1492,21 +1487,19 @@ Example:
             qapi_free_UserDefOneList(*obj);
             *obj = NULL;
         }
-    out:
         error_propagate(errp, err);
+        return !err;
     }
 
-    void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp)
+    bool visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp)
     {
         Error *err = NULL;
 
-        visit_type_UserDefOneList(v, "arg1", &obj->arg1, &err);
-        if (err) {
-            goto out;
+        if (!visit_type_UserDefOneList(v, "arg1", &obj->arg1, errp)) {
+            return false;
         }
-
-    out:
         error_propagate(errp, err);
+        return !err;
     }
 
 [Uninteresting stuff omitted...]
diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
index 5b665ee38c..adf9a788e2 100644
--- a/include/qapi/clone-visitor.h
+++ b/include/qapi/clone-visitor.h
@@ -20,10 +20,10 @@
  */
 typedef struct QapiCloneVisitor QapiCloneVisitor;
 
-void *qapi_clone(const void *src, void (*visit_type)(Visitor *, const char *,
+void *qapi_clone(const void *src, bool (*visit_type)(Visitor *, const char *,
                                                      void **, Error **));
 void qapi_clone_members(void *dst, const void *src, size_t sz,
-                        void (*visit_type_members)(Visitor *, void *,
+                        bool (*visit_type_members)(Visitor *, void *,
                                                    Error **));
 
 /*
@@ -34,7 +34,7 @@ void qapi_clone_members(void *dst, const void *src, size_t sz,
  */
 #define QAPI_CLONE(type, src)                                           \
     ((type *)qapi_clone(src,                                            \
-                        (void (*)(Visitor *, const char *, void**,      \
+                        (bool (*)(Visitor *, const char *, void **,     \
                                   Error **))visit_type_ ## type))
 
 /*
@@ -45,7 +45,7 @@ void qapi_clone_members(void *dst, const void *src, size_t sz,
  */
 #define QAPI_CLONE_MEMBERS(type, dst, src)                              \
     qapi_clone_members(dst, src, sizeof(type),                          \
-                       (void (*)(Visitor *, void *,                     \
+                       (bool (*)(Visitor *, void *,                     \
                                  Error **))visit_type_ ## type ## _members)
 
 #endif
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 98dc533d39..7362c043be 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -48,31 +48,31 @@ struct Visitor
      */
 
     /* Must be set to visit structs */
-    void (*start_struct)(Visitor *v, const char *name, void **obj,
+    bool (*start_struct)(Visitor *v, const char *name, void **obj,
                          size_t size, Error **errp);
 
     /* Optional; intended for input visitors */
-    void (*check_struct)(Visitor *v, Error **errp);
+    bool (*check_struct)(Visitor *v, Error **errp);
 
     /* Must be set to visit structs */
     void (*end_struct)(Visitor *v, void **obj);
 
     /* Must be set; implementations may require @list to be non-null,
      * but must document it. */
-    void (*start_list)(Visitor *v, const char *name, GenericList **list,
+    bool (*start_list)(Visitor *v, const char *name, GenericList **list,
                        size_t size, Error **errp);
 
     /* Must be set */
     GenericList *(*next_list)(Visitor *v, GenericList *tail, size_t size);
 
     /* Optional; intended for input visitors */
-    void (*check_list)(Visitor *v, Error **errp);
+    bool (*check_list)(Visitor *v, Error **errp);
 
     /* Must be set */
     void (*end_list)(Visitor *v, void **list);
 
     /* Must be set by input and clone visitors to visit alternates */
-    void (*start_alternate)(Visitor *v, const char *name,
+    bool (*start_alternate)(Visitor *v, const char *name,
                             GenericAlternate **obj, size_t size,
                             Error **errp);
 
@@ -80,33 +80,33 @@ struct Visitor
     void (*end_alternate)(Visitor *v, void **obj);
 
     /* Must be set */
-    void (*type_int64)(Visitor *v, const char *name, int64_t *obj,
+    bool (*type_int64)(Visitor *v, const char *name, int64_t *obj,
                        Error **errp);
 
     /* Must be set */
-    void (*type_uint64)(Visitor *v, const char *name, uint64_t *obj,
+    bool (*type_uint64)(Visitor *v, const char *name, uint64_t *obj,
                         Error **errp);
 
     /* Optional; fallback is type_uint64() */
-    void (*type_size)(Visitor *v, const char *name, uint64_t *obj,
+    bool (*type_size)(Visitor *v, const char *name, uint64_t *obj,
                       Error **errp);
 
     /* Must be set */
-    void (*type_bool)(Visitor *v, const char *name, bool *obj, Error **errp);
+    bool (*type_bool)(Visitor *v, const char *name, bool *obj, Error **errp);
 
     /* Must be set */
-    void (*type_str)(Visitor *v, const char *name, char **obj, Error **errp);
+    bool (*type_str)(Visitor *v, const char *name, char **obj, Error **errp);
 
     /* Must be set to visit numbers */
-    void (*type_number)(Visitor *v, const char *name, double *obj,
+    bool (*type_number)(Visitor *v, const char *name, double *obj,
                         Error **errp);
 
     /* Must be set to visit arbitrary QTypes */
-    void (*type_any)(Visitor *v, const char *name, QObject **obj,
+    bool (*type_any)(Visitor *v, const char *name, QObject **obj,
                      Error **errp);
 
     /* Must be set to visit explicit null values.  */
-    void (*type_null)(Visitor *v, const char *name, QNull **obj,
+    bool (*type_null)(Visitor *v, const char *name, QNull **obj,
                       Error **errp);
 
     /* Must be set for input visitors to visit structs, optional otherwise.
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 5573906966..ebc19ede7f 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -60,7 +60,7 @@
  * All QAPI types have a corresponding function with a signature
  * roughly compatible with this:
  *
- * void visit_type_FOO(Visitor *v, const char *name, T obj, Error **errp);
+ * bool visit_type_FOO(Visitor *v, const char *name, T obj, Error **errp);
  *
  * where T is FOO for scalar types, and FOO * otherwise.  The scalar
  * visitors are declared here; the remaining visitors are generated in
@@ -95,14 +95,16 @@
  * incomplete object, such an object is possible only by manual
  * construction.
  *
+ * visit_type_FOO() returns true on success, false on error.
+ *
  * For the QAPI object types (structs, unions, and alternates), there
  * is an additional generated function in qapi-visit-MODULE.h
  * compatible with:
  *
- * void visit_type_FOO_members(Visitor *v, FOO *obj, Error **errp);
+ * bool visit_type_FOO_members(Visitor *v, FOO *obj, Error **errp);
  *
  * for visiting the members of a type without also allocating the QAPI
- * struct.
+ * struct.  It also returns true on success, false on error.
  *
  * Additionally, QAPI pointer types (structs, unions, alternates, and
  * lists) have a generated function in qapi-types-MODULE.h compatible
@@ -131,8 +133,7 @@
  *  Visitor *v;
  *
  *  v = FOO_visitor_new(...);
- *  visit_type_Foo(v, NULL, &f, &err);
- *  if (err) {
+ *  if (!visit_type_Foo(v, NULL, &f, &err)) {
  *      ...handle error...
  *  } else {
  *      ...use f...
@@ -148,8 +149,7 @@
  *  Visitor *v;
  *
  *  v = FOO_visitor_new(...);
- *  visit_type_FooList(v, NULL, &l, &err);
- *  if (err) {
+ *  if (!visit_type_FooList(v, NULL, &l, &err)) {
  *      ...handle error...
  *  } else {
  *      for ( ; l; l = l->next) {
@@ -186,34 +186,32 @@
  * <example>
  *  Visitor *v;
  *  Error *err = NULL;
+ *  bool ok = false;
  *  int value;
  *
  *  v = FOO_visitor_new(...);
- *  visit_start_struct(v, NULL, NULL, 0, &err);
- *  if (err) {
+ *  if (!visit_start_struct(v, NULL, NULL, 0, &err)) {
  *      goto out;
  *  }
- *  visit_start_list(v, "list", NULL, 0, &err);
- *  if (err) {
+ *  if (!visit_start_list(v, "list", NULL, 0, &err)) {
  *      goto outobj;
  *  }
  *  value = 1;
- *  visit_type_int(v, NULL, &value, &err);
- *  if (err) {
+ *  if (!visit_type_int(v, NULL, &value, &err)) {
  *      goto outlist;
  *  }
  *  value = 2;
- *  visit_type_int(v, NULL, &value, &err);
- *  if (err) {
+ *  if (!visit_type_int(v, NULL, &value, &err)) {
  *      goto outlist;
  *  }
+ *  ok = true;
  * outlist:
- *  if (!err) {
- *      visit_check_list(v, &err);
+ *  if (ok) {
+ *      ok = visit_check_list(v, &err);
  *  }
  *  visit_end_list(v, NULL);
- *  if (!err) {
- *      visit_check_struct(v, &err);
+ *  if (ok) {
+ *      ok = visit_check_struct(v, &err);
  *  }
  * outobj:
  *  visit_end_struct(v, NULL);
@@ -286,6 +284,8 @@ void visit_free(Visitor *v);
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
+ * Return true on success, false on failure.
+ *
  * After visit_start_struct() succeeds, the caller may visit its
  * members one after the other, passing the member's name and address
  * within the struct.  Finally, visit_end_struct() needs to be called
@@ -295,7 +295,7 @@ void visit_free(Visitor *v);
  * FIXME Should this be named visit_start_object, since it is also
  * used for QAPI unions, and maps to JSON objects?
  */
-void visit_start_struct(Visitor *v, const char *name, void **obj,
+bool visit_start_struct(Visitor *v, const char *name, void **obj,
                         size_t size, Error **errp);
 
 /*
@@ -304,12 +304,14 @@ void visit_start_struct(Visitor *v, const char *name, void **obj,
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
+ * Return true on success, false on failure.
+ *
  * Should be called prior to visit_end_struct() if all other
  * intermediate visit steps were successful, to allow the visitor one
  * last chance to report errors.  May be skipped on a cleanup path,
  * where there is no need to check for further errors.
  */
-void visit_check_struct(Visitor *v, Error **errp);
+bool visit_check_struct(Visitor *v, Error **errp);
 
 /*
  * Complete an object visit started earlier.
@@ -341,6 +343,8 @@ void visit_end_struct(Visitor *v, void **obj);
  * On failure, set *@list to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
+ * Return true on success, false on failure.
+ *
  * After visit_start_list() succeeds, the caller may visit its members
  * one after the other.  A real visit (where @list is non-NULL) uses
  * visit_next_list() for traversing the linked list, while a virtual
@@ -351,7 +355,7 @@ void visit_end_struct(Visitor *v, void **obj);
  * same @list to clean up, even if intermediate visits fail.  See the
  * examples above.
  */
-void visit_start_list(Visitor *v, const char *name, GenericList **list,
+bool visit_start_list(Visitor *v, const char *name, GenericList **list,
                       size_t size, Error **errp);
 
 /*
@@ -376,12 +380,14 @@ GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t size);
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
+ * Return true on success, false on failure.
+ *
  * Should be called prior to visit_end_list() if all other
  * intermediate visit steps were successful, to allow the visitor one
  * last chance to report errors.  May be skipped on a cleanup path,
  * where there is no need to check for further errors.
  */
-void visit_check_list(Visitor *v, Error **errp);
+bool visit_check_list(Visitor *v, Error **errp);
 
 /*
  * Complete a list visit started earlier.
@@ -412,11 +418,13 @@ void visit_end_list(Visitor *v, void **list);
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
+ * Return true on success, false on failure.
+ *
  * If successful, this must be paired with visit_end_alternate() with
  * the same @obj to clean up, even if visiting the contents of the
  * alternate fails.
  */
-void visit_start_alternate(Visitor *v, const char *name,
+bool visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
                            Error **errp);
 
@@ -468,12 +476,14 @@ bool visit_optional(Visitor *v, const char *name, bool *present);
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
  *
+ * Return true on success, false on failure.
+ *
  * May call visit_type_str() under the hood, and the enum visit may
  * fail even if the corresponding string visit succeeded; this implies
  * that an input visitor's visit_type_str() must have no unwelcome
  * side effects.
  */
-void visit_type_enum(Visitor *v, const char *name, int *obj,
+bool visit_type_enum(Visitor *v, const char *name, int *obj,
                      const QEnumLookup *lookup, Error **errp);
 
 /*
@@ -499,28 +509,30 @@ bool visit_is_dealloc(Visitor *v);
  *
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
+ *
+ * Return true on success, false on failure.
  */
-void visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **errp);
+bool visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **errp);
 
 /*
  * Visit a uint8_t value.
  * Like visit_type_int(), except clamps the value to uint8_t range.
  */
-void visit_type_uint8(Visitor *v, const char *name, uint8_t *obj,
+bool visit_type_uint8(Visitor *v, const char *name, uint8_t *obj,
                       Error **errp);
 
 /*
  * Visit a uint16_t value.
  * Like visit_type_int(), except clamps the value to uint16_t range.
  */
-void visit_type_uint16(Visitor *v, const char *name, uint16_t *obj,
+bool visit_type_uint16(Visitor *v, const char *name, uint16_t *obj,
                        Error **errp);
 
 /*
  * Visit a uint32_t value.
  * Like visit_type_int(), except clamps the value to uint32_t range.
  */
-void visit_type_uint32(Visitor *v, const char *name, uint32_t *obj,
+bool visit_type_uint32(Visitor *v, const char *name, uint32_t *obj,
                        Error **errp);
 
 /*
@@ -528,34 +540,34 @@ void visit_type_uint32(Visitor *v, const char *name, uint32_t *obj,
  * Like visit_type_int(), except clamps the value to uint64_t range,
  * that is, ensures it is unsigned.
  */
-void visit_type_uint64(Visitor *v, const char *name, uint64_t *obj,
+bool visit_type_uint64(Visitor *v, const char *name, uint64_t *obj,
                        Error **errp);
 
 /*
  * Visit an int8_t value.
  * Like visit_type_int(), except clamps the value to int8_t range.
  */
-void visit_type_int8(Visitor *v, const char *name, int8_t *obj, Error **errp);
+bool visit_type_int8(Visitor *v, const char *name, int8_t *obj, Error **errp);
 
 /*
  * Visit an int16_t value.
  * Like visit_type_int(), except clamps the value to int16_t range.
  */
-void visit_type_int16(Visitor *v, const char *name, int16_t *obj,
+bool visit_type_int16(Visitor *v, const char *name, int16_t *obj,
                       Error **errp);
 
 /*
  * Visit an int32_t value.
  * Like visit_type_int(), except clamps the value to int32_t range.
  */
-void visit_type_int32(Visitor *v, const char *name, int32_t *obj,
+bool visit_type_int32(Visitor *v, const char *name, int32_t *obj,
                       Error **errp);
 
 /*
  * Visit an int64_t value.
  * Identical to visit_type_int().
  */
-void visit_type_int64(Visitor *v, const char *name, int64_t *obj,
+bool visit_type_int64(Visitor *v, const char *name, int64_t *obj,
                       Error **errp);
 
 /*
@@ -564,7 +576,7 @@ void visit_type_int64(Visitor *v, const char *name, int64_t *obj,
  * recognize additional syntax, such as suffixes for easily scaling
  * values.
  */
-void visit_type_size(Visitor *v, const char *name, uint64_t *obj,
+bool visit_type_size(Visitor *v, const char *name, uint64_t *obj,
                      Error **errp);
 
 /*
@@ -578,8 +590,10 @@ void visit_type_size(Visitor *v, const char *name, uint64_t *obj,
  *
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
+ *
+ * Return true on success, false on failure.
  */
-void visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp);
+bool visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp);
 
 /*
  * Visit a string value.
@@ -598,9 +612,11 @@ void visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp);
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
+ * Return true on success, false on failure.
+ *
  * FIXME: Callers that try to output NULL *obj should not be allowed.
  */
-void visit_type_str(Visitor *v, const char *name, char **obj, Error **errp);
+bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp);
 
 /*
  * Visit a number (i.e. double) value.
@@ -614,8 +630,10 @@ void visit_type_str(Visitor *v, const char *name, char **obj, Error **errp);
  *
  * On failure, store an error through @errp.  Can happen only when @v
  * is an input visitor.
+ *
+ * Return true on success, false on failure.
  */
-void visit_type_number(Visitor *v, const char *name, double *obj,
+bool visit_type_number(Visitor *v, const char *name, double *obj,
                        Error **errp);
 
 /*
@@ -631,11 +649,13 @@ void visit_type_number(Visitor *v, const char *name, double *obj,
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
  *
+ * Return true on success, false on failure.
+ *
  * Note that some kinds of input can't express arbitrary QObject.
  * E.g. the visitor returned by qobject_input_visitor_new_keyval()
  * can't create numbers or booleans, only strings.
  */
-void visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp);
+bool visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp);
 
 /*
  * Visit a JSON null value.
@@ -648,8 +668,10 @@ void visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp);
  *
  * On failure, set *@obj to NULL and store an error through @errp.
  * Can happen only when @v is an input visitor.
+ *
+ * Return true on success, false on failure.
  */
-void visit_type_null(Visitor *v, const char *name, QNull **obj,
+bool visit_type_null(Visitor *v, const char *name, QNull **obj,
                      Error **errp);
 
 #endif
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index ebd7d9fa0d..ffdbd0bcce 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -421,11 +421,12 @@ typedef struct {
     GList *path;
 } LegacyPrintVisitor;
 
-static void lv_start_struct(Visitor *v, const char *name, void **obj,
+static bool lv_start_struct(Visitor *v, const char *name, void **obj,
                             size_t size, Error **errp)
 {
     LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
     lv->path = g_list_append(lv->path, g_strdup(name));
+    return true;
 }
 
 static void lv_end_struct(Visitor *v, void **obj)
@@ -453,27 +454,30 @@ static void lv_print_key(Visitor *v, const char *name)
     printf("%s=", name);
 }
 
-static void lv_type_int64(Visitor *v, const char *name, int64_t *obj,
+static bool lv_type_int64(Visitor *v, const char *name, int64_t *obj,
                           Error **errp)
 {
     lv_print_key(v, name);
     printf("%" PRIi64, *obj);
+    return true;
 }
 
-static void lv_type_uint64(Visitor *v, const char *name, uint64_t *obj,
+static bool lv_type_uint64(Visitor *v, const char *name, uint64_t *obj,
                            Error **errp)
 {
     lv_print_key(v, name);
     printf("%" PRIu64, *obj);
+    return true;
 }
 
-static void lv_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
+static bool lv_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
 {
     lv_print_key(v, name);
     printf("%s", *obj ? "on" : "off");
+    return true;
 }
 
-static void lv_type_str(Visitor *v, const char *name, char **obj, Error **errp)
+static bool lv_type_str(Visitor *v, const char *name, char **obj, Error **errp)
 {
     const char *str = *obj;
     lv_print_key(v, name);
@@ -484,6 +488,7 @@ static void lv_type_str(Visitor *v, const char *name, char **obj, Error **errp)
         }
         putchar(*str++);
     }
+    return true;
 }
 
 static void lv_complete(Visitor *v, void *opaque)
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 5fe0276c1c..7781c23a42 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -133,7 +133,7 @@ opts_visitor_insert(GHashTable *unprocessed_opts, const QemuOpt *opt)
 }
 
 
-static void
+static bool
 opts_start_struct(Visitor *v, const char *name, void **obj,
                   size_t size, Error **errp)
 {
@@ -144,7 +144,7 @@ opts_start_struct(Visitor *v, const char *name, void **obj,
         *obj = g_malloc0(size);
     }
     if (ov->depth++ > 0) {
-        return;
+        return true;
     }
 
     ov->unprocessed_opts = g_hash_table_new_full(&g_str_hash, &g_str_equal,
@@ -163,10 +163,11 @@ opts_start_struct(Visitor *v, const char *name, void **obj,
         ov->fake_id_opt->str = g_strdup(ov->opts_root->id);
         opts_visitor_insert(ov->unprocessed_opts, ov->fake_id_opt);
     }
+    return true;
 }
 
 
-static void
+static bool
 opts_check_struct(Visitor *v, Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
@@ -174,7 +175,7 @@ opts_check_struct(Visitor *v, Error **errp)
     GQueue *any;
 
     if (ov->depth > 1) {
-        return;
+        return true;
     }
 
     /* we should have processed all (distinct) QemuOpt instances */
@@ -184,7 +185,9 @@ opts_check_struct(Visitor *v, Error **errp)
 
         first = g_queue_peek_head(any);
         error_setg(errp, QERR_INVALID_PARAMETER, first->name);
+        return false;
     }
+    return true;
 }
 
 
@@ -221,7 +224,7 @@ lookup_distinct(const OptsVisitor *ov, const char *name, Error **errp)
 }
 
 
-static void
+static bool
 opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
                 Error **errp)
 {
@@ -232,12 +235,13 @@ opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
     /* we don't support visits without a list */
     assert(list);
     ov->repeated_opts = lookup_distinct(ov, name, errp);
-    if (ov->repeated_opts) {
-        ov->list_mode = LM_IN_PROGRESS;
-        *list = g_malloc0(size);
-    } else {
+    if (!ov->repeated_opts) {
         *list = NULL;
+        return false;
     }
+    ov->list_mode = LM_IN_PROGRESS;
+    *list = g_malloc0(size);
+    return true;
 }
 
 
@@ -285,13 +289,14 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
 }
 
 
-static void
+static bool
 opts_check_list(Visitor *v, Error **errp)
 {
     /*
      * Unvisited list elements will be reported later when checking
      * whether unvisited struct members remain.
      */
+    return true;
 }
 
 
@@ -341,7 +346,7 @@ processed(OptsVisitor *ov, const char *name)
 }
 
 
-static void
+static bool
 opts_type_str(Visitor *v, const char *name, char **obj, Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
@@ -350,7 +355,7 @@ opts_type_str(Visitor *v, const char *name, char **obj, Error **errp)
     opt = lookup_scalar(ov, name, errp);
     if (!opt) {
         *obj = NULL;
-        return;
+        return false;
     }
     *obj = g_strdup(opt->str ? opt->str : "");
     /* Note that we consume a string even if this is called as part of
@@ -359,11 +364,12 @@ opts_type_str(Visitor *v, const char *name, char **obj, Error **errp)
      * consumed only matters to visit_end_struct() as the final error
      * check if there were no other failures during the visit.  */
     processed(ov, name);
+    return true;
 }
 
 
 /* mimics qemu-option.c::parse_option_bool() */
-static void
+static bool
 opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
@@ -371,7 +377,7 @@ opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
 
     opt = lookup_scalar(ov, name, errp);
     if (!opt) {
-        return;
+        return false;
     }
 
     if (opt->str) {
@@ -386,17 +392,18 @@ opts_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
         } else {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                        "on|yes|y|off|no|n");
-            return;
+            return false;
         }
     } else {
         *obj = true;
     }
 
     processed(ov, name);
+    return true;
 }
 
 
-static void
+static bool
 opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
@@ -407,12 +414,12 @@ opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
 
     if (ov->list_mode == LM_SIGNED_INTERVAL) {
         *obj = ov->range_next.s;
-        return;
+        return true;
     }
 
     opt = lookup_scalar(ov, name, errp);
     if (!opt) {
-        return;
+        return false;
     }
     str = opt->str ? opt->str : "";
 
@@ -425,7 +432,7 @@ opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
         if (*endptr == '\0') {
             *obj = val;
             processed(ov, name);
-            return;
+            return true;
         }
         if (*endptr == '-' && ov->list_mode == LM_IN_PROGRESS) {
             long long val2;
@@ -442,17 +449,18 @@ opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
 
                 /* as if entering on the top */
                 *obj = ov->range_next.s;
-                return;
+                return true;
             }
         }
     }
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                (ov->list_mode == LM_NONE) ? "an int64 value" :
                                             "an int64 value or range");
+    return false;
 }
 
 
-static void
+static bool
 opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
@@ -463,12 +471,12 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
 
     if (ov->list_mode == LM_UNSIGNED_INTERVAL) {
         *obj = ov->range_next.u;
-        return;
+        return true;
     }
 
     opt = lookup_scalar(ov, name, errp);
     if (!opt) {
-        return;
+        return false;
     }
     str = opt->str;
 
@@ -479,7 +487,7 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
         if (*endptr == '\0') {
             *obj = val;
             processed(ov, name);
-            return;
+            return true;
         }
         if (*endptr == '-' && ov->list_mode == LM_IN_PROGRESS) {
             unsigned long long val2;
@@ -494,17 +502,18 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
 
                 /* as if entering on the top */
                 *obj = ov->range_next.u;
-                return;
+                return true;
             }
         }
     }
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                (ov->list_mode == LM_NONE) ? "a uint64 value" :
                                             "a uint64 value or range");
+    return false;
 }
 
 
-static void
+static bool
 opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
@@ -513,17 +522,18 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
 
     opt = lookup_scalar(ov, name, errp);
     if (!opt) {
-        return;
+        return false;
     }
 
     err = qemu_strtosz(opt->str ? opt->str : "", NULL, obj);
     if (err < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                    "a size value");
-        return;
+        return false;
     }
 
     processed(ov, name);
+    return true;
 }
 
 
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index daab6819b4..c45c5caa3b 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -24,7 +24,7 @@ static QapiCloneVisitor *to_qcv(Visitor *v)
     return container_of(v, QapiCloneVisitor, visitor);
 }
 
-static void qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
+static bool qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
                                     size_t size, Error **errp)
 {
     QapiCloneVisitor *qcv = to_qcv(v);
@@ -34,11 +34,12 @@ static void qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
         /* Only possible when visiting an alternate's object
          * branch. Nothing further to do here, since the earlier
          * visit_start_alternate() already copied memory. */
-        return;
+        return true;
     }
 
     *obj = g_memdup(*obj, size);
     qcv->depth++;
+    return true;
 }
 
 static void qapi_clone_end(Visitor *v, void **obj)
@@ -51,11 +52,11 @@ static void qapi_clone_end(Visitor *v, void **obj)
     }
 }
 
-static void qapi_clone_start_list(Visitor *v, const char *name,
+static bool qapi_clone_start_list(Visitor *v, const char *name,
                                   GenericList **listp, size_t size,
                                   Error **errp)
 {
-    qapi_clone_start_struct(v, name, (void **)listp, size, errp);
+    return qapi_clone_start_struct(v, name, (void **)listp, size, errp);
 }
 
 static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
@@ -69,45 +70,48 @@ static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
     return tail->next;
 }
 
-static void qapi_clone_start_alternate(Visitor *v, const char *name,
+static bool qapi_clone_start_alternate(Visitor *v, const char *name,
                                        GenericAlternate **obj, size_t size,
                                        Error **errp)
 {
-    qapi_clone_start_struct(v, name, (void **)obj, size, errp);
+    return qapi_clone_start_struct(v, name, (void **)obj, size, errp);
 }
 
-static void qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
-                                   Error **errp)
-{
-    QapiCloneVisitor *qcv = to_qcv(v);
-
-    assert(qcv->depth);
-    /* Value was already cloned by g_memdup() */
-}
-
-static void qapi_clone_type_uint64(Visitor *v, const char *name,
-                                    uint64_t *obj, Error **errp)
-{
-    QapiCloneVisitor *qcv = to_qcv(v);
-
-    assert(qcv->depth);
-    /* Value was already cloned by g_memdup() */
-}
-
-static void qapi_clone_type_bool(Visitor *v, const char *name, bool *obj,
+static bool qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
                                   Error **errp)
 {
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
     /* Value was already cloned by g_memdup() */
+    return true;
 }
 
-static void qapi_clone_type_str(Visitor *v, const char *name, char **obj,
+static bool qapi_clone_type_uint64(Visitor *v, const char *name,
+                                   uint64_t *obj, Error **errp)
+{
+    QapiCloneVisitor *qcv = to_qcv(v);
+
+    assert(qcv->depth);
+    /* Value was already cloned by g_memdup() */
+    return true;
+}
+
+static bool qapi_clone_type_bool(Visitor *v, const char *name, bool *obj,
                                  Error **errp)
 {
     QapiCloneVisitor *qcv = to_qcv(v);
 
+    assert(qcv->depth);
+    /* Value was already cloned by g_memdup() */
+    return true;
+}
+
+static bool qapi_clone_type_str(Visitor *v, const char *name, char **obj,
+                                Error **errp)
+{
+    QapiCloneVisitor *qcv = to_qcv(v);
+
     assert(qcv->depth);
     /*
      * Pointer was already cloned by g_memdup; create fresh copy.
@@ -117,24 +121,27 @@ static void qapi_clone_type_str(Visitor *v, const char *name, char **obj,
      * string is intended.
      */
     *obj = g_strdup(*obj ?: "");
+    return true;
 }
 
-static void qapi_clone_type_number(Visitor *v, const char *name, double *obj,
-                                    Error **errp)
+static bool qapi_clone_type_number(Visitor *v, const char *name, double *obj,
+                                   Error **errp)
 {
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
     /* Value was already cloned by g_memdup() */
+    return true;
 }
 
-static void qapi_clone_type_null(Visitor *v, const char *name, QNull **obj,
+static bool qapi_clone_type_null(Visitor *v, const char *name, QNull **obj,
                                  Error **errp)
 {
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
     *obj = qnull();
+    return true;
 }
 
 static void qapi_clone_free(Visitor *v)
@@ -167,7 +174,7 @@ static Visitor *qapi_clone_visitor_new(void)
     return &v->visitor;
 }
 
-void *qapi_clone(const void *src, void (*visit_type)(Visitor *, const char *,
+void *qapi_clone(const void *src, bool (*visit_type)(Visitor *, const char *,
                                                      void **, Error **))
 {
     Visitor *v;
@@ -184,7 +191,7 @@ void *qapi_clone(const void *src, void (*visit_type)(Visitor *, const char *,
 }
 
 void qapi_clone_members(void *dst, const void *src, size_t sz,
-                        void (*visit_type_members)(Visitor *, void *,
+                        bool (*visit_type_members)(Visitor *, void *,
                                                    Error **))
 {
     Visitor *v;
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index 2239fc6417..ef283f2966 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -22,9 +22,10 @@ struct QapiDeallocVisitor
     Visitor visitor;
 };
 
-static void qapi_dealloc_start_struct(Visitor *v, const char *name, void **obj,
+static bool qapi_dealloc_start_struct(Visitor *v, const char *name, void **obj,
                                       size_t unused, Error **errp)
 {
+    return true;
 }
 
 static void qapi_dealloc_end_struct(Visitor *v, void **obj)
@@ -41,10 +42,11 @@ static void qapi_dealloc_end_alternate(Visitor *v, void **obj)
     }
 }
 
-static void qapi_dealloc_start_list(Visitor *v, const char *name,
+static bool qapi_dealloc_start_list(Visitor *v, const char *name,
                                     GenericList **list, size_t size,
                                     Error **errp)
 {
+    return true;
 }
 
 static GenericList *qapi_dealloc_next_list(Visitor *v, GenericList *tail,
@@ -59,48 +61,55 @@ static void qapi_dealloc_end_list(Visitor *v, void **obj)
 {
 }
 
-static void qapi_dealloc_type_str(Visitor *v, const char *name, char **obj,
+static bool qapi_dealloc_type_str(Visitor *v, const char *name, char **obj,
                                   Error **errp)
 {
     if (obj) {
         g_free(*obj);
     }
+    return true;
 }
 
-static void qapi_dealloc_type_int64(Visitor *v, const char *name, int64_t *obj,
+static bool qapi_dealloc_type_int64(Visitor *v, const char *name, int64_t *obj,
                                     Error **errp)
 {
+    return true;
 }
 
-static void qapi_dealloc_type_uint64(Visitor *v, const char *name,
+static bool qapi_dealloc_type_uint64(Visitor *v, const char *name,
                                      uint64_t *obj, Error **errp)
 {
+    return true;
 }
 
-static void qapi_dealloc_type_bool(Visitor *v, const char *name, bool *obj,
+static bool qapi_dealloc_type_bool(Visitor *v, const char *name, bool *obj,
                                    Error **errp)
 {
+    return true;
 }
 
-static void qapi_dealloc_type_number(Visitor *v, const char *name, double *obj,
+static bool qapi_dealloc_type_number(Visitor *v, const char *name, double *obj,
                                      Error **errp)
 {
+    return true;
 }
 
-static void qapi_dealloc_type_anything(Visitor *v, const char *name,
+static bool qapi_dealloc_type_anything(Visitor *v, const char *name,
                                        QObject **obj, Error **errp)
 {
     if (obj) {
         qobject_unref(*obj);
     }
+    return true;
 }
 
-static void qapi_dealloc_type_null(Visitor *v, const char *name,
+static bool qapi_dealloc_type_null(Visitor *v, const char *name,
                                    QNull **obj, Error **errp)
 {
     if (obj) {
         qobject_unref(*obj);
     }
+    return true;
 }
 
 static void qapi_dealloc_free(Visitor *v)
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 74aa9c04bd..5a9c47aabf 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -36,7 +36,7 @@ void visit_free(Visitor *v)
     }
 }
 
-void visit_start_struct(Visitor *v, const char *name, void **obj,
+bool visit_start_struct(Visitor *v, const char *name, void **obj,
                         size_t size, Error **errp)
 {
     Error *err = NULL;
@@ -51,14 +51,13 @@ void visit_start_struct(Visitor *v, const char *name, void **obj,
         assert(!err != !*obj);
     }
     error_propagate(errp, err);
+    return !err;
 }
 
-void visit_check_struct(Visitor *v, Error **errp)
+bool visit_check_struct(Visitor *v, Error **errp)
 {
     trace_visit_check_struct(v);
-    if (v->check_struct) {
-        v->check_struct(v, errp);
-    }
+    return v->check_struct ? v->check_struct(v, errp) : true;
 }
 
 void visit_end_struct(Visitor *v, void **obj)
@@ -67,7 +66,7 @@ void visit_end_struct(Visitor *v, void **obj)
     v->end_struct(v, obj);
 }
 
-void visit_start_list(Visitor *v, const char *name, GenericList **list,
+bool visit_start_list(Visitor *v, const char *name, GenericList **list,
                       size_t size, Error **errp)
 {
     Error *err = NULL;
@@ -79,6 +78,7 @@ void visit_start_list(Visitor *v, const char *name, GenericList **list,
         assert(!(err && *list));
     }
     error_propagate(errp, err);
+    return !err;
 }
 
 GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t size)
@@ -88,12 +88,10 @@ GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t size)
     return v->next_list(v, tail, size);
 }
 
-void visit_check_list(Visitor *v, Error **errp)
+bool visit_check_list(Visitor *v, Error **errp)
 {
     trace_visit_check_list(v);
-    if (v->check_list) {
-        v->check_list(v, errp);
-    }
+    return v->check_list ? v->check_list(v, errp) : true;
 }
 
 void visit_end_list(Visitor *v, void **obj)
@@ -102,7 +100,7 @@ void visit_end_list(Visitor *v, void **obj)
     v->end_list(v, obj);
 }
 
-void visit_start_alternate(Visitor *v, const char *name,
+bool visit_start_alternate(Visitor *v, const char *name,
                            GenericAlternate **obj, size_t size,
                            Error **errp)
 {
@@ -118,6 +116,7 @@ void visit_start_alternate(Visitor *v, const char *name,
         assert(v->start_alternate && !err != !*obj);
     }
     error_propagate(errp, err);
+    return !err;
 }
 
 void visit_end_alternate(Visitor *v, void **obj)
@@ -147,155 +146,168 @@ bool visit_is_dealloc(Visitor *v)
     return v->type == VISITOR_DEALLOC;
 }
 
-void visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **errp)
+bool visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **errp)
 {
     assert(obj);
     trace_visit_type_int(v, name, obj);
-    v->type_int64(v, name, obj, errp);
+    return v->type_int64(v, name, obj, errp);
 }
 
-static void visit_type_uintN(Visitor *v, uint64_t *obj, const char *name,
+static bool visit_type_uintN(Visitor *v, uint64_t *obj, const char *name,
                              uint64_t max, const char *type, Error **errp)
 {
-    Error *err = NULL;
     uint64_t value = *obj;
 
     assert(v->type == VISITOR_INPUT || value <= max);
 
-    v->type_uint64(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
-    } else if (value > max) {
+    if (!v->type_uint64(v, name, &value, errp)) {
+        return false;
+    }
+    if (value > max) {
         assert(v->type == VISITOR_INPUT);
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    name ? name : "null", type);
-    } else {
-        *obj = value;
+        return false;
     }
+    *obj = value;
+    return true;
 }
 
-void visit_type_uint8(Visitor *v, const char *name, uint8_t *obj,
+bool visit_type_uint8(Visitor *v, const char *name, uint8_t *obj,
                       Error **errp)
 {
     uint64_t value;
+    bool ok;
 
     trace_visit_type_uint8(v, name, obj);
     value = *obj;
-    visit_type_uintN(v, &value, name, UINT8_MAX, "uint8_t", errp);
+    ok = visit_type_uintN(v, &value, name, UINT8_MAX, "uint8_t", errp);
     *obj = value;
+    return ok;
 }
 
-void visit_type_uint16(Visitor *v, const char *name, uint16_t *obj,
+bool visit_type_uint16(Visitor *v, const char *name, uint16_t *obj,
                        Error **errp)
 {
     uint64_t value;
+    bool ok;
 
     trace_visit_type_uint16(v, name, obj);
     value = *obj;
-    visit_type_uintN(v, &value, name, UINT16_MAX, "uint16_t", errp);
+    ok = visit_type_uintN(v, &value, name, UINT16_MAX, "uint16_t", errp);
     *obj = value;
+    return ok;
 }
 
-void visit_type_uint32(Visitor *v, const char *name, uint32_t *obj,
+bool visit_type_uint32(Visitor *v, const char *name, uint32_t *obj,
                        Error **errp)
 {
     uint64_t value;
+    bool ok;
 
     trace_visit_type_uint32(v, name, obj);
     value = *obj;
-    visit_type_uintN(v, &value, name, UINT32_MAX, "uint32_t", errp);
+    ok = visit_type_uintN(v, &value, name, UINT32_MAX, "uint32_t", errp);
     *obj = value;
+    return ok;
 }
 
-void visit_type_uint64(Visitor *v, const char *name, uint64_t *obj,
+bool visit_type_uint64(Visitor *v, const char *name, uint64_t *obj,
                        Error **errp)
 {
     assert(obj);
     trace_visit_type_uint64(v, name, obj);
-    v->type_uint64(v, name, obj, errp);
+    return v->type_uint64(v, name, obj, errp);
 }
 
-static void visit_type_intN(Visitor *v, int64_t *obj, const char *name,
+static bool visit_type_intN(Visitor *v, int64_t *obj, const char *name,
                             int64_t min, int64_t max, const char *type,
                             Error **errp)
 {
-    Error *err = NULL;
     int64_t value = *obj;
 
     assert(v->type == VISITOR_INPUT || (value >= min && value <= max));
 
-    v->type_int64(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
-    } else if (value < min || value > max) {
+    if (!v->type_int64(v, name, &value, errp)) {
+        return false;
+    }
+    if (value < min || value > max) {
         assert(v->type == VISITOR_INPUT);
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    name ? name : "null", type);
-    } else {
-        *obj = value;
+        return false;
     }
+    *obj = value;
+    return true;
 }
 
-void visit_type_int8(Visitor *v, const char *name, int8_t *obj, Error **errp)
+bool visit_type_int8(Visitor *v, const char *name, int8_t *obj, Error **errp)
 {
     int64_t value;
+    bool ok;
 
     trace_visit_type_int8(v, name, obj);
     value = *obj;
-    visit_type_intN(v, &value, name, INT8_MIN, INT8_MAX, "int8_t", errp);
+    ok = visit_type_intN(v, &value, name, INT8_MIN, INT8_MAX, "int8_t", errp);
     *obj = value;
+    return ok;
 }
 
-void visit_type_int16(Visitor *v, const char *name, int16_t *obj,
+bool visit_type_int16(Visitor *v, const char *name, int16_t *obj,
                       Error **errp)
 {
     int64_t value;
+    bool ok;
 
     trace_visit_type_int16(v, name, obj);
     value = *obj;
-    visit_type_intN(v, &value, name, INT16_MIN, INT16_MAX, "int16_t", errp);
+    ok = visit_type_intN(v, &value, name, INT16_MIN, INT16_MAX, "int16_t",
+                         errp);
     *obj = value;
+    return ok;
 }
 
-void visit_type_int32(Visitor *v, const char *name, int32_t *obj,
+bool visit_type_int32(Visitor *v, const char *name, int32_t *obj,
                       Error **errp)
 {
     int64_t value;
+    bool ok;
 
     trace_visit_type_int32(v, name, obj);
     value = *obj;
-    visit_type_intN(v, &value, name, INT32_MIN, INT32_MAX, "int32_t", errp);
+    ok = visit_type_intN(v, &value, name, INT32_MIN, INT32_MAX, "int32_t",
+                        errp);
     *obj = value;
+    return ok;
 }
 
-void visit_type_int64(Visitor *v, const char *name, int64_t *obj,
+bool visit_type_int64(Visitor *v, const char *name, int64_t *obj,
                       Error **errp)
 {
     assert(obj);
     trace_visit_type_int64(v, name, obj);
-    v->type_int64(v, name, obj, errp);
+    return v->type_int64(v, name, obj, errp);
 }
 
-void visit_type_size(Visitor *v, const char *name, uint64_t *obj,
+bool visit_type_size(Visitor *v, const char *name, uint64_t *obj,
                      Error **errp)
 {
     assert(obj);
     trace_visit_type_size(v, name, obj);
     if (v->type_size) {
-        v->type_size(v, name, obj, errp);
-    } else {
-        v->type_uint64(v, name, obj, errp);
+        return v->type_size(v, name, obj, errp);
     }
+    return v->type_uint64(v, name, obj, errp);
 }
 
-void visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
+bool visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
 {
     assert(obj);
     trace_visit_type_bool(v, name, obj);
-    v->type_bool(v, name, obj, errp);
+    return v->type_bool(v, name, obj, errp);
 }
 
-void visit_type_str(Visitor *v, const char *name, char **obj, Error **errp)
+bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp)
 {
     Error *err = NULL;
 
@@ -310,89 +322,88 @@ void visit_type_str(Visitor *v, const char *name, char **obj, Error **errp)
         assert(!err != !*obj);
     }
     error_propagate(errp, err);
+    return !err;
 }
 
-void visit_type_number(Visitor *v, const char *name, double *obj,
+bool visit_type_number(Visitor *v, const char *name, double *obj,
                        Error **errp)
 {
     assert(obj);
     trace_visit_type_number(v, name, obj);
-    v->type_number(v, name, obj, errp);
+    return v->type_number(v, name, obj, errp);
 }
 
-void visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp)
+bool visit_type_any(Visitor *v, const char *name, QObject **obj, Error **errp)
 {
-    Error *err = NULL;
+    bool ok;
 
     assert(obj);
     assert(v->type != VISITOR_OUTPUT || *obj);
     trace_visit_type_any(v, name, obj);
-    v->type_any(v, name, obj, &err);
+    ok = v->type_any(v, name, obj, errp);
     if (v->type == VISITOR_INPUT) {
-        assert(!err != !*obj);
+        assert(ok != !*obj);
     }
-    error_propagate(errp, err);
+    return ok;
 }
 
-void visit_type_null(Visitor *v, const char *name, QNull **obj,
+bool visit_type_null(Visitor *v, const char *name, QNull **obj,
                      Error **errp)
 {
     trace_visit_type_null(v, name, obj);
-    v->type_null(v, name, obj, errp);
+    return v->type_null(v, name, obj, errp);
 }
 
-static void output_type_enum(Visitor *v, const char *name, int *obj,
+static bool output_type_enum(Visitor *v, const char *name, int *obj,
                              const QEnumLookup *lookup, Error **errp)
 {
     int value = *obj;
     char *enum_str;
 
     enum_str = (char *)qapi_enum_lookup(lookup, value);
-    visit_type_str(v, name, &enum_str, errp);
+    return visit_type_str(v, name, &enum_str, errp);
 }
 
-static void input_type_enum(Visitor *v, const char *name, int *obj,
+static bool input_type_enum(Visitor *v, const char *name, int *obj,
                             const QEnumLookup *lookup, Error **errp)
 {
-    Error *local_err = NULL;
     int64_t value;
     char *enum_str;
 
-    visit_type_str(v, name, &enum_str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+    if (!visit_type_str(v, name, &enum_str, errp)) {
+        return false;
     }
 
     value = qapi_enum_parse(lookup, enum_str, -1, NULL);
     if (value < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER, enum_str);
         g_free(enum_str);
-        return;
+        return false;
     }
 
     g_free(enum_str);
     *obj = value;
+    return true;
 }
 
-void visit_type_enum(Visitor *v, const char *name, int *obj,
+bool visit_type_enum(Visitor *v, const char *name, int *obj,
                      const QEnumLookup *lookup, Error **errp)
 {
     assert(obj && lookup);
     trace_visit_type_enum(v, name, obj);
     switch (v->type) {
     case VISITOR_INPUT:
-        input_type_enum(v, name, obj, lookup, errp);
-        break;
+        return input_type_enum(v, name, obj, lookup, errp);
     case VISITOR_OUTPUT:
-        output_type_enum(v, name, obj, lookup, errp);
-        break;
+        return output_type_enum(v, name, obj, lookup, errp);
     case VISITOR_CLONE:
         /* nothing further to do, scalar value was already copied by
          * g_memdup() during visit_start_*() */
-        break;
+        return true;
     case VISITOR_DEALLOC:
         /* nothing to deallocate for a scalar */
-        break;
+        return true;
+    default:
+        abort();
     }
 }
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 5ce3ec2e5f..f918a05e5f 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -237,7 +237,7 @@ static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
 }
 
 
-static void qobject_input_check_struct(Visitor *v, Error **errp)
+static bool qobject_input_check_struct(Visitor *v, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);
@@ -250,7 +250,9 @@ static void qobject_input_check_struct(Visitor *v, Error **errp)
     if (g_hash_table_iter_next(&iter, (void **)&key, NULL)) {
         error_setg(errp, "Parameter '%s' is unexpected",
                    full_name(qiv, key));
+        return false;
     }
+    return true;
 }
 
 static void qobject_input_stack_object_free(StackObject *tos)
@@ -272,7 +274,7 @@ static void qobject_input_pop(Visitor *v, void **obj)
     qobject_input_stack_object_free(tos);
 }
 
-static void qobject_input_start_struct(Visitor *v, const char *name, void **obj,
+static bool qobject_input_start_struct(Visitor *v, const char *name, void **obj,
                                        size_t size, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -282,12 +284,12 @@ static void qobject_input_start_struct(Visitor *v, const char *name, void **obj,
         *obj = NULL;
     }
     if (!qobj) {
-        return;
+        return false;
     }
     if (qobject_type(qobj) != QTYPE_QDICT) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "object");
-        return;
+        return false;
     }
 
     qobject_input_push(qiv, name, qobj, obj);
@@ -295,6 +297,7 @@ static void qobject_input_start_struct(Visitor *v, const char *name, void **obj,
     if (obj) {
         *obj = g_malloc0(size);
     }
+    return true;
 }
 
 static void qobject_input_end_struct(Visitor *v, void **obj)
@@ -307,7 +310,7 @@ static void qobject_input_end_struct(Visitor *v, void **obj)
 }
 
 
-static void qobject_input_start_list(Visitor *v, const char *name,
+static bool qobject_input_start_list(Visitor *v, const char *name,
                                      GenericList **list, size_t size,
                                      Error **errp)
 {
@@ -319,18 +322,19 @@ static void qobject_input_start_list(Visitor *v, const char *name,
         *list = NULL;
     }
     if (!qobj) {
-        return;
+        return false;
     }
     if (qobject_type(qobj) != QTYPE_QLIST) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "array");
-        return;
+        return false;
     }
 
     entry = qobject_input_push(qiv, name, qobj, list);
     if (entry && list) {
         *list = g_malloc0(size);
     }
+    return true;
 }
 
 static GenericList *qobject_input_next_list(Visitor *v, GenericList *tail,
@@ -348,7 +352,7 @@ static GenericList *qobject_input_next_list(Visitor *v, GenericList *tail,
     return tail->next;
 }
 
-static void qobject_input_check_list(Visitor *v, Error **errp)
+static bool qobject_input_check_list(Visitor *v, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);
@@ -358,7 +362,9 @@ static void qobject_input_check_list(Visitor *v, Error **errp)
     if (tos->entry) {
         error_setg(errp, "Only %u list elements expected in %s",
                    tos->index + 1, full_name_nth(qiv, NULL, 1));
+        return false;
     }
+    return true;
 }
 
 static void qobject_input_end_list(Visitor *v, void **obj)
@@ -370,7 +376,7 @@ static void qobject_input_end_list(Visitor *v, void **obj)
     qobject_input_pop(v, obj);
 }
 
-static void qobject_input_start_alternate(Visitor *v, const char *name,
+static bool qobject_input_start_alternate(Visitor *v, const char *name,
                                           GenericAlternate **obj, size_t size,
                                           Error **errp)
 {
@@ -379,13 +385,14 @@ static void qobject_input_start_alternate(Visitor *v, const char *name,
 
     if (!qobj) {
         *obj = NULL;
-        return;
+        return false;
     }
     *obj = g_malloc0(size);
     (*obj)->type = qobject_type(qobj);
+    return true;
 }
 
-static void qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
+static bool qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
                                      Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -393,33 +400,37 @@ static void qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
     QNum *qnum;
 
     if (!qobj) {
-        return;
+        return false;
     }
     qnum = qobject_to(QNum, qobj);
     if (!qnum || !qnum_get_try_int(qnum, obj)) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "integer");
+        return false;
     }
+    return true;
 }
 
-static void qobject_input_type_int64_keyval(Visitor *v, const char *name,
+static bool qobject_input_type_int64_keyval(Visitor *v, const char *name,
                                             int64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     const char *str = qobject_input_get_keyval(qiv, name, errp);
 
     if (!str) {
-        return;
+        return false;
     }
 
     if (qemu_strtoi64(str, NULL, 0, obj) < 0) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    full_name(qiv, name), "integer");
+        return false;
     }
+    return true;
 }
 
-static void qobject_input_type_uint64(Visitor *v, const char *name,
+static bool qobject_input_type_uint64(Visitor *v, const char *name,
                                       uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -428,7 +439,7 @@ static void qobject_input_type_uint64(Visitor *v, const char *name,
     int64_t val;
 
     if (!qobj) {
-        return;
+        return false;
     }
     qnum = qobject_to(QNum, qobj);
     if (!qnum) {
@@ -436,38 +447,41 @@ static void qobject_input_type_uint64(Visitor *v, const char *name,
     }
 
     if (qnum_get_try_uint(qnum, obj)) {
-        return;
+        return true;
     }
 
     /* Need to accept negative values for backward compatibility */
     if (qnum_get_try_int(qnum, &val)) {
         *obj = val;
-        return;
+        return true;
     }
 
 err:
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                full_name(qiv, name), "uint64");
+    return false;
 }
 
-static void qobject_input_type_uint64_keyval(Visitor *v, const char *name,
+static bool qobject_input_type_uint64_keyval(Visitor *v, const char *name,
                                              uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     const char *str = qobject_input_get_keyval(qiv, name, errp);
 
     if (!str) {
-        return;
+        return false;
     }
 
     if (qemu_strtou64(str, NULL, 0, obj) < 0) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    full_name(qiv, name), "integer");
+        return false;
     }
+    return true;
 }
 
-static void qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
+static bool qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
                                     Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -475,26 +489,27 @@ static void qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     QBool *qbool;
 
     if (!qobj) {
-        return;
+        return false;
     }
     qbool = qobject_to(QBool, qobj);
     if (!qbool) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "boolean");
-        return;
+        return false;
     }
 
     *obj = qbool_get_bool(qbool);
+    return true;
 }
 
-static void qobject_input_type_bool_keyval(Visitor *v, const char *name,
+static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
                                            bool *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     const char *str = qobject_input_get_keyval(qiv, name, errp);
 
     if (!str) {
-        return;
+        return false;
     }
 
     if (!strcmp(str, "on")) {
@@ -504,10 +519,12 @@ static void qobject_input_type_bool_keyval(Visitor *v, const char *name,
     } else {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    full_name(qiv, name), "'on' or 'off'");
+        return false;
     }
+    return true;
 }
 
-static void qobject_input_type_str(Visitor *v, const char *name, char **obj,
+static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
                                    Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -516,28 +533,30 @@ static void qobject_input_type_str(Visitor *v, const char *name, char **obj,
 
     *obj = NULL;
     if (!qobj) {
-        return;
+        return false;
     }
     qstr = qobject_to(QString, qobj);
     if (!qstr) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "string");
-        return;
+        return false;
     }
 
     *obj = g_strdup(qstring_get_str(qstr));
+    return true;
 }
 
-static void qobject_input_type_str_keyval(Visitor *v, const char *name,
+static bool qobject_input_type_str_keyval(Visitor *v, const char *name,
                                           char **obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     const char *str = qobject_input_get_keyval(qiv, name, errp);
 
     *obj = g_strdup(str);
+    return !!str;
 }
 
-static void qobject_input_type_number(Visitor *v, const char *name, double *obj,
+static bool qobject_input_type_number(Visitor *v, const char *name, double *obj,
                                       Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -545,19 +564,20 @@ static void qobject_input_type_number(Visitor *v, const char *name, double *obj,
     QNum *qnum;
 
     if (!qobj) {
-        return;
+        return false;
     }
     qnum = qobject_to(QNum, qobj);
     if (!qnum) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "number");
-        return;
+        return false;
     }
 
     *obj = qnum_get_double(qnum);
+    return true;
 }
 
-static void qobject_input_type_number_keyval(Visitor *v, const char *name,
+static bool qobject_input_type_number_keyval(Visitor *v, const char *name,
                                              double *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -565,20 +585,21 @@ static void qobject_input_type_number_keyval(Visitor *v, const char *name,
     double val;
 
     if (!str) {
-        return;
+        return false;
     }
 
     if (qemu_strtod_finite(str, NULL, &val)) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "number");
-        return;
+        return false;
     }
 
     *obj = val;
+    return true;
 }
 
-static void qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
+static bool qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
                                    Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -586,13 +607,14 @@ static void qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
 
     *obj = NULL;
     if (!qobj) {
-        return;
+        return false;
     }
 
     *obj = qobject_ref(qobj);
+    return true;
 }
 
-static void qobject_input_type_null(Visitor *v, const char *name,
+static bool qobject_input_type_null(Visitor *v, const char *name,
                                     QNull **obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -600,32 +622,35 @@ static void qobject_input_type_null(Visitor *v, const char *name,
 
     *obj = NULL;
     if (!qobj) {
-        return;
+        return false;
     }
 
     if (qobject_type(qobj) != QTYPE_QNULL) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "null");
-        return;
+        return false;
     }
     *obj = qnull();
+    return true;
 }
 
-static void qobject_input_type_size_keyval(Visitor *v, const char *name,
+static bool qobject_input_type_size_keyval(Visitor *v, const char *name,
                                            uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     const char *str = qobject_input_get_keyval(qiv, name, errp);
 
     if (!str) {
-        return;
+        return false;
     }
 
     if (qemu_strtosz(str, NULL, obj) < 0) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    full_name(qiv, name), "size");
+        return false;
     }
+    return true;
 }
 
 static void qobject_input_optional(Visitor *v, const char *name, bool *present)
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 26d7be5ec9..ba6f6ac8a7 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -103,7 +103,7 @@ static void qobject_output_add_obj(QObjectOutputVisitor *qov, const char *name,
     }
 }
 
-static void qobject_output_start_struct(Visitor *v, const char *name,
+static bool qobject_output_start_struct(Visitor *v, const char *name,
                                         void **obj, size_t unused, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
@@ -111,6 +111,7 @@ static void qobject_output_start_struct(Visitor *v, const char *name,
 
     qobject_output_add(qov, name, dict);
     qobject_output_push(qov, dict, obj);
+    return true;
 }
 
 static void qobject_output_end_struct(Visitor *v, void **obj)
@@ -120,7 +121,7 @@ static void qobject_output_end_struct(Visitor *v, void **obj)
     assert(qobject_type(value) == QTYPE_QDICT);
 }
 
-static void qobject_output_start_list(Visitor *v, const char *name,
+static bool qobject_output_start_list(Visitor *v, const char *name,
                                       GenericList **listp, size_t size,
                                       Error **errp)
 {
@@ -129,6 +130,7 @@ static void qobject_output_start_list(Visitor *v, const char *name,
 
     qobject_output_add(qov, name, list);
     qobject_output_push(qov, list, listp);
+    return true;
 }
 
 static GenericList *qobject_output_next_list(Visitor *v, GenericList *tail,
@@ -144,28 +146,31 @@ static void qobject_output_end_list(Visitor *v, void **obj)
     assert(qobject_type(value) == QTYPE_QLIST);
 }
 
-static void qobject_output_type_int64(Visitor *v, const char *name,
+static bool qobject_output_type_int64(Visitor *v, const char *name,
                                       int64_t *obj, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
     qobject_output_add(qov, name, qnum_from_int(*obj));
+    return true;
 }
 
-static void qobject_output_type_uint64(Visitor *v, const char *name,
+static bool qobject_output_type_uint64(Visitor *v, const char *name,
                                        uint64_t *obj, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
     qobject_output_add(qov, name, qnum_from_uint(*obj));
+    return true;
 }
 
-static void qobject_output_type_bool(Visitor *v, const char *name, bool *obj,
+static bool qobject_output_type_bool(Visitor *v, const char *name, bool *obj,
                                      Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
     qobject_output_add(qov, name, qbool_from_bool(*obj));
+    return true;
 }
 
-static void qobject_output_type_str(Visitor *v, const char *name, char **obj,
+static bool qobject_output_type_str(Visitor *v, const char *name, char **obj,
                                     Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
@@ -174,28 +179,32 @@ static void qobject_output_type_str(Visitor *v, const char *name, char **obj,
     } else {
         qobject_output_add(qov, name, qstring_from_str(""));
     }
+    return true;
 }
 
-static void qobject_output_type_number(Visitor *v, const char *name,
+static bool qobject_output_type_number(Visitor *v, const char *name,
                                        double *obj, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
     qobject_output_add(qov, name, qnum_from_double(*obj));
+    return true;
 }
 
-static void qobject_output_type_any(Visitor *v, const char *name,
+static bool qobject_output_type_any(Visitor *v, const char *name,
                                     QObject **obj, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
 
     qobject_output_add_obj(qov, name, qobject_ref(*obj));
+    return true;
 }
 
-static void qobject_output_type_null(Visitor *v, const char *name,
+static bool qobject_output_type_null(Visitor *v, const char *name,
                                      QNull **obj, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
     qobject_output_add(qov, name, qnull());
+    return true;
 }
 
 /* Finish building, and return the root object.
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 730fa4630d..d0ca10aefa 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -60,7 +60,7 @@ static StringInputVisitor *to_siv(Visitor *v)
     return container_of(v, StringInputVisitor, visitor);
 }
 
-static void start_list(Visitor *v, const char *name, GenericList **list,
+static bool start_list(Visitor *v, const char *name, GenericList **list,
                        size_t size, Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -80,6 +80,7 @@ static void start_list(Visitor *v, const char *name, GenericList **list,
         }
         siv->lm = LM_UNPARSED;
     }
+    return true;
 }
 
 static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
@@ -102,7 +103,7 @@ static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
     return tail->next;
 }
 
-static void check_list(Visitor *v, Error **errp)
+static bool check_list(Visitor *v, Error **errp)
 {
     const StringInputVisitor *siv = to_siv(v);
 
@@ -111,9 +112,9 @@ static void check_list(Visitor *v, Error **errp)
     case LM_UINT64_RANGE:
     case LM_UNPARSED:
         error_setg(errp, "Fewer list elements expected");
-        return;
+        return false;
     case LM_END:
-        return;
+        return true;
     default:
         abort();
     }
@@ -178,7 +179,7 @@ static int try_parse_int64_list_entry(StringInputVisitor *siv, int64_t *obj)
     return 0;
 }
 
-static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
+static bool parse_type_int64(Visitor *v, const char *name, int64_t *obj,
                              Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -188,17 +189,17 @@ static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
     case LM_NONE:
         /* just parse a simple int64, bail out if not completely consumed */
         if (qemu_strtoi64(siv->string, NULL, 0, &val)) {
-                error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                           name ? name : "null", "int64");
-            return;
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                       name ? name : "null", "int64");
+            return false;
         }
         *obj = val;
-        return;
+        return true;
     case LM_UNPARSED:
         if (try_parse_int64_list_entry(siv, obj)) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
                        "list of int64 values or ranges");
-            return;
+            return false;
         }
         assert(siv->lm == LM_INT64_RANGE);
         /* fall through */
@@ -211,10 +212,10 @@ static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
             /* end of range, check if there is more to parse */
             siv->lm = siv->unparsed_string[0] ? LM_UNPARSED : LM_END;
         }
-        return;
+        return true;
     case LM_END:
         error_setg(errp, "Fewer list elements expected");
-        return;
+        return false;
     default:
         abort();
     }
@@ -268,7 +269,7 @@ static int try_parse_uint64_list_entry(StringInputVisitor *siv, uint64_t *obj)
     return 0;
 }
 
-static void parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
+static bool parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
                               Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -280,15 +281,15 @@ static void parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
         if (qemu_strtou64(siv->string, NULL, 0, &val)) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
                        "uint64");
-            return;
+            return false;
         }
         *obj = val;
-        return;
+        return true;
     case LM_UNPARSED:
         if (try_parse_uint64_list_entry(siv, obj)) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
                        "list of uint64 values or ranges");
-            return;
+            return false;
         }
         assert(siv->lm == LM_UINT64_RANGE);
         /* fall through */
@@ -301,16 +302,16 @@ static void parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
             /* end of range, check if there is more to parse */
             siv->lm = siv->unparsed_string[0] ? LM_UNPARSED : LM_END;
         }
-        return;
+        return true;
     case LM_END:
         error_setg(errp, "Fewer list elements expected");
-        return;
+        return false;
     default:
         abort();
     }
 }
 
-static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
+static bool parse_type_size(Visitor *v, const char *name, uint64_t *obj,
                             Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -320,13 +321,14 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
     assert(siv->lm == LM_NONE);
     if (!parse_option_size(name, siv->string, &val, &err)) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
 
     *obj = val;
+    return true;
 }
 
-static void parse_type_bool(Visitor *v, const char *name, bool *obj,
+static bool parse_type_bool(Visitor *v, const char *name, bool *obj,
                             Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -336,29 +338,31 @@ static void parse_type_bool(Visitor *v, const char *name, bool *obj,
         !strcasecmp(siv->string, "yes") ||
         !strcasecmp(siv->string, "true")) {
         *obj = true;
-        return;
+        return true;
     }
     if (!strcasecmp(siv->string, "off") ||
         !strcasecmp(siv->string, "no") ||
         !strcasecmp(siv->string, "false")) {
         *obj = false;
-        return;
+        return true;
     }
 
     error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                "boolean");
+    return false;
 }
 
-static void parse_type_str(Visitor *v, const char *name, char **obj,
+static bool parse_type_str(Visitor *v, const char *name, char **obj,
                            Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
 
     assert(siv->lm == LM_NONE);
     *obj = g_strdup(siv->string);
+    return true;
 }
 
-static void parse_type_number(Visitor *v, const char *name, double *obj,
+static bool parse_type_number(Visitor *v, const char *name, double *obj,
                               Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -368,13 +372,14 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     if (qemu_strtod_finite(siv->string, NULL, &val)) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "number");
-        return;
+        return false;
     }
 
     *obj = val;
+    return true;
 }
 
-static void parse_type_null(Visitor *v, const char *name, QNull **obj,
+static bool parse_type_null(Visitor *v, const char *name, QNull **obj,
                             Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -385,10 +390,11 @@ static void parse_type_null(Visitor *v, const char *name, QNull **obj,
     if (siv->string[0]) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "null");
-        return;
+        return false;
     }
 
     *obj = qnull();
+    return true;
 }
 
 static void string_input_free(Visitor *v)
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 0d93605d77..b74aa4d44c 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -123,7 +123,7 @@ static void format_string(StringOutputVisitor *sov, Range *r, bool next,
     }
 }
 
-static void print_type_int64(Visitor *v, const char *name, int64_t *obj,
+static bool print_type_int64(Visitor *v, const char *name, int64_t *obj,
                              Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
@@ -138,7 +138,7 @@ static void print_type_int64(Visitor *v, const char *name, int64_t *obj,
         sov->range_start.s = *obj;
         sov->range_end.s = *obj;
         sov->list_mode = LM_IN_PROGRESS;
-        return;
+        return true;
 
     case LM_IN_PROGRESS:
         if (sov->range_end.s + 1 == *obj) {
@@ -155,7 +155,7 @@ static void print_type_int64(Visitor *v, const char *name, int64_t *obj,
             sov->range_start.s = *obj;
             sov->range_end.s = *obj;
         }
-        return;
+        return true;
 
     case LM_END:
         if (sov->range_end.s + 1 == *obj) {
@@ -197,17 +197,19 @@ static void print_type_int64(Visitor *v, const char *name, int64_t *obj,
         }
         g_string_append(sov->string, ")");
     }
+
+    return true;
 }
 
-static void print_type_uint64(Visitor *v, const char *name, uint64_t *obj,
+static bool print_type_uint64(Visitor *v, const char *name, uint64_t *obj,
                              Error **errp)
 {
     /* FIXME: print_type_int64 mishandles values over INT64_MAX */
     int64_t i = *obj;
-    print_type_int64(v, name, &i, errp);
+    return print_type_int64(v, name, &i, errp);
 }
 
-static void print_type_size(Visitor *v, const char *name, uint64_t *obj,
+static bool print_type_size(Visitor *v, const char *name, uint64_t *obj,
                             Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
@@ -217,7 +219,7 @@ static void print_type_size(Visitor *v, const char *name, uint64_t *obj,
     if (!sov->human) {
         out = g_strdup_printf("%"PRIu64, *obj);
         string_output_set(sov, out);
-        return;
+        return true;
     }
 
     val = *obj;
@@ -226,16 +228,18 @@ static void print_type_size(Visitor *v, const char *name, uint64_t *obj,
     string_output_set(sov, out);
 
     g_free(psize);
+    return true;
 }
 
-static void print_type_bool(Visitor *v, const char *name, bool *obj,
+static bool print_type_bool(Visitor *v, const char *name, bool *obj,
                             Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
     string_output_set(sov, g_strdup(*obj ? "true" : "false"));
+    return true;
 }
 
-static void print_type_str(Visitor *v, const char *name, char **obj,
+static bool print_type_str(Visitor *v, const char *name, char **obj,
                            Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
@@ -247,16 +251,18 @@ static void print_type_str(Visitor *v, const char *name, char **obj,
         out = g_strdup(*obj ? *obj : "");
     }
     string_output_set(sov, out);
+    return true;
 }
 
-static void print_type_number(Visitor *v, const char *name, double *obj,
+static bool print_type_number(Visitor *v, const char *name, double *obj,
                               Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
     string_output_set(sov, g_strdup_printf("%f", *obj));
+    return true;
 }
 
-static void print_type_null(Visitor *v, const char *name, QNull **obj,
+static bool print_type_null(Visitor *v, const char *name, QNull **obj,
                             Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
@@ -268,9 +274,10 @@ static void print_type_null(Visitor *v, const char *name, QNull **obj,
         out = g_strdup("");
     }
     string_output_set(sov, out);
+    return true;
 }
 
-static void
+static bool
 start_list(Visitor *v, const char *name, GenericList **list, size_t size,
            Error **errp)
 {
@@ -285,6 +292,7 @@ start_list(Visitor *v, const char *name, GenericList **list, size_t size,
     if (*list && (*list)->next) {
         sov->list_mode = LM_STARTED;
     }
+    return true;
 }
 
 static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index d5d7a1031f..ba0cf0b074 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -23,7 +23,7 @@ def gen_visit_decl(name, scalar=False):
     if not scalar:
         c_type += '*'
     return mcgen('''
-void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_type)sobj, Error **errp);
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_type)sobj, Error **errp);
 ''',
                  c_name=c_name(name), c_type=c_type)
 
@@ -31,7 +31,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_type)sobj, Error **
 def gen_visit_members_decl(name):
     return mcgen('''
 
-void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp);
+bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp);
 ''',
                  c_name=c_name(name))
 
@@ -39,7 +39,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp);
 def gen_visit_object_members(name, base, members, variants):
     ret = mcgen('''
 
-void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
+bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 {
     Error *err = NULL;
 
@@ -48,9 +48,8 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 
     if base:
         ret += mcgen('''
-    visit_type_%(c_type)s_members(v, (%(c_type)s *)obj, &err);
-    if (err) {
-        goto out;
+    if (!visit_type_%(c_type)s_members(v, (%(c_type)s *)obj, errp)) {
+        return false;
     }
 ''',
                      c_type=base.c_name())
@@ -64,9 +63,8 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                          name=memb.name, c_name=c_name(memb.name))
             push_indent()
         ret += mcgen('''
-    visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, &err);
-    if (err) {
-        goto out;
+    if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
+        return false;
     }
 ''',
                      c_type=memb.type.c_name(), name=memb.name,
@@ -112,15 +110,9 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
     }
 ''')
 
-    # 'goto out' produced for base, for each member, and if variants were
-    # present
-    if base or members or variants:
-        ret += mcgen('''
-
-out:
-''')
     ret += mcgen('''
     error_propagate(errp, err);
+    return !err;
 }
 ''')
     return ret
@@ -129,15 +121,14 @@ out:
 def gen_visit_list(name, element_type):
     return mcgen('''
 
-void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
 {
     Error *err = NULL;
     %(c_name)s *tail;
     size_t size = sizeof(**obj);
 
-    visit_start_list(v, name, (GenericList **)obj, size, &err);
-    if (err) {
-        goto out;
+    if (!visit_start_list(v, name, (GenericList **)obj, size, errp)) {
+        return false;
     }
 
     for (tail = *obj; tail;
@@ -156,8 +147,8 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
         qapi_free_%(c_name)s(*obj);
         *obj = NULL;
     }
-out:
     error_propagate(errp, err);
+    return !err;
 }
 ''',
                  c_name=c_name(name), c_elt_type=element_type.c_name())
@@ -166,11 +157,12 @@ out:
 def gen_visit_enum(name):
     return mcgen('''
 
-void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error **errp)
 {
     int value = *obj;
-    visit_type_enum(v, name, &value, &%(c_name)s_lookup, errp);
+    bool ok = visit_type_enum(v, name, &value, &%(c_name)s_lookup, errp);
     *obj = value;
+    return ok;
 }
 ''',
                  c_name=c_name(name))
@@ -179,14 +171,13 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error
 def gen_visit_alternate(name, variants):
     ret = mcgen('''
 
-void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
 {
     Error *err = NULL;
 
-    visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**obj),
-                          &err);
-    if (err) {
-        goto out;
+    if (!visit_start_alternate(v, name, (GenericAlternate **)obj,
+                               sizeof(**obj), errp)) {
+        return false;
     }
     if (!*obj) {
         /* incomplete */
@@ -245,8 +236,8 @@ out_obj:
         qapi_free_%(c_name)s(*obj);
         *obj = NULL;
     }
-out:
     error_propagate(errp, err);
+    return !err;
 }
 ''',
                  name=name, c_name=c_name(name))
@@ -257,13 +248,12 @@ out:
 def gen_visit_object(name, base, members, variants):
     return mcgen('''
 
-void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
 {
     Error *err = NULL;
 
-    visit_start_struct(v, name, (void **)obj, sizeof(%(c_name)s), &err);
-    if (err) {
-        goto out;
+    if (!visit_start_struct(v, name, (void **)obj, sizeof(%(c_name)s), errp)) {
+        return false;
     }
     if (!*obj) {
         /* incomplete */
@@ -281,8 +271,8 @@ out_obj:
         qapi_free_%(c_name)s(*obj);
         *obj = NULL;
     }
-out:
     error_propagate(errp, err);
+    return !err;
 }
 ''',
                  c_name=c_name(name))
-- 
2.26.2


