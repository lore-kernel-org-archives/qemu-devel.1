Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5DDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E0A206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLUHhIjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E0A206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqXi-00030r-1T
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7Z-00034x-FF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7D-0006tS-4W
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4azpmc9rB+4CBBmQSzlqTOouprq/lBfFIMBJAbTPG8=;
 b=aLUHhIjoj3pCMO5Bs4d1TNC6+pdpn+gSrbTwYsjMmiQ9ZMF8H0qfDhLMVxqik+RQ6O3x6D
 SqUlkcfwhXlVoiY/aAwRa5xZ//kzB69UWJObEpo347aFNpyYuYsKjNTIl9pauzMYC+nsII
 hSGN4Sjz7VUkeB9RzdjRMrlVI2tbDKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-JgeUcyAYMnO1BwHQV77ZpQ-1; Tue, 07 Jul 2020 12:06:33 -0400
X-MC-Unique: JgeUcyAYMnO1BwHQV77ZpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22FC1804002;
 Tue,  7 Jul 2020 16:06:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9DE21A265;
 Tue,  7 Jul 2020 16:06:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23ADF10C4AE3; Tue,  7 Jul 2020 18:06:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 40/45] qapi: Smooth visitor error checking in generated code
Date: Tue,  7 Jul 2020 18:06:08 +0200
Message-Id: <20200707160613.848843-41-armbru@redhat.com>
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Use visitor functions' return values to check for failure.  Eliminate
error_propagate() that are now unnecessary.  Delete @err that are now
unused.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 60 ++++++++++++++----------------------
 scripts/qapi/commands.py     | 22 ++++++-------
 scripts/qapi/visit.py        | 57 ++++++++++++++--------------------
 3 files changed, 55 insertions(+), 84 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 9bfc57063c..69eede6c28 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1420,8 +1420,6 @@ Example:
 
     bool visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
     {
-        Error *err = NULL;
-
         if (!visit_type_int(v, "integer", &obj->integer, errp)) {
             return false;
         }
@@ -1430,13 +1428,12 @@ Example:
                 return false;
             }
         }
-        error_propagate(errp, err);
-        return !err;
+        return true;
     }
 
     bool visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp)
     {
-        Error *err = NULL;
+        bool ok = false;
 
         if (!visit_start_struct(v, name, (void **)obj, sizeof(UserDefOne), errp)) {
             return false;
@@ -1446,24 +1443,22 @@ Example:
             assert(visit_is_dealloc(v));
             goto out_obj;
         }
-        visit_type_UserDefOne_members(v, *obj, &err);
-        if (err) {
+        if (!visit_type_UserDefOne_members(v, *obj, errp)) {
             goto out_obj;
         }
-        visit_check_struct(v, &err);
+        ok = visit_check_struct(v, errp);
     out_obj:
         visit_end_struct(v, (void **)obj);
-        if (err && visit_is_input(v)) {
+        if (!ok && visit_is_input(v)) {
             qapi_free_UserDefOne(*obj);
             *obj = NULL;
         }
-        error_propagate(errp, err);
-        return !err;
+        return ok;
     }
 
     bool visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp)
     {
-        Error *err = NULL;
+        bool ok = false;
         UserDefOneList *tail;
         size_t size = sizeof(**obj);
 
@@ -1473,33 +1468,27 @@ Example:
 
         for (tail = *obj; tail;
              tail = (UserDefOneList *)visit_next_list(v, (GenericList *)tail, size)) {
-            visit_type_UserDefOne(v, NULL, &tail->value, &err);
-            if (err) {
-                break;
+            if (!visit_type_UserDefOne(v, NULL, &tail->value, errp)) {
+                goto out_obj;
             }
         }
 
-        if (!err) {
-            visit_check_list(v, &err);
-        }
+        ok = visit_check_list(v, errp);
+    out_obj:
         visit_end_list(v, (void **)obj);
-        if (err && visit_is_input(v)) {
+        if (!ok && visit_is_input(v)) {
             qapi_free_UserDefOneList(*obj);
             *obj = NULL;
         }
-        error_propagate(errp, err);
-        return !err;
+        return ok;
     }
 
     bool visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp)
     {
-        Error *err = NULL;
-
         if (!visit_type_UserDefOneList(v, "arg1", &obj->arg1, errp)) {
             return false;
         }
-        error_propagate(errp, err);
-        return !err;
+        return true;
     }
 
 [Uninteresting stuff omitted...]
@@ -1554,15 +1543,12 @@ Example:
 
     static void qmp_marshal_output_UserDefOne(UserDefOne *ret_in, QObject **ret_out, Error **errp)
     {
-        Error *err = NULL;
         Visitor *v;
 
         v = qobject_output_visitor_new(ret_out);
-        visit_type_UserDefOne(v, "unused", &ret_in, &err);
-        if (!err) {
+        if (visit_type_UserDefOne(v, "unused", &ret_in, errp)) {
             visit_complete(v, ret_out);
         }
-        error_propagate(errp, err);
         visit_free(v);
         v = qapi_dealloc_visitor_new();
         visit_type_UserDefOne(v, "unused", &ret_in, NULL);
@@ -1572,33 +1558,32 @@ Example:
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp)
     {
         Error *err = NULL;
+        bool ok = false;
         Visitor *v;
         UserDefOne *retval;
         q_obj_my_command_arg arg = {0};
 
         v = qobject_input_visitor_new(QOBJECT(args));
-        visit_start_struct(v, NULL, NULL, 0, &err);
-        if (err) {
+        if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
             goto out;
         }
-        visit_type_q_obj_my_command_arg_members(v, &arg, &err);
-        if (!err) {
-            visit_check_struct(v, &err);
+        if (visit_type_q_obj_my_command_arg_members(v, &arg, errp)) {
+            ok = visit_check_struct(v, errp);
         }
         visit_end_struct(v, NULL);
-        if (err) {
+        if (!ok) {
             goto out;
         }
 
         retval = qmp_my_command(arg.arg1, &err);
+        error_propagate(errp, err);
         if (err) {
             goto out;
         }
 
-        qmp_marshal_output_UserDefOne(retval, ret, &err);
+        qmp_marshal_output_UserDefOne(retval, ret, errp);
 
     out:
-        error_propagate(errp, err);
         visit_free(v);
         v = qapi_dealloc_visitor_new();
         visit_start_struct(v, NULL, NULL, 0, NULL);
@@ -1606,6 +1591,7 @@ Example:
         visit_end_struct(v, NULL);
         visit_free(v);
     }
+
 [Uninteresting stuff omitted...]
     $ cat qapi-generated/example-qapi-init-commands.h
 [Uninteresting stuff omitted...]
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 6809b0fb6e..3cf9e1110b 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -47,6 +47,7 @@ def gen_call(name, arg_type, boxed, ret_type):
     ret = mcgen('''
 
     %(lhs)sqmp_%(c_name)s(%(args)s&err);
+    error_propagate(errp, err);
 ''',
                 c_name=c_name(name), args=argstr, lhs=lhs)
     if ret_type:
@@ -55,7 +56,7 @@ def gen_call(name, arg_type, boxed, ret_type):
         goto out;
     }
 
-    qmp_marshal_output_%(c_name)s(retval, ret, &err);
+    qmp_marshal_output_%(c_name)s(retval, ret, errp);
 ''',
                      c_name=ret_type.c_name())
     return ret
@@ -66,15 +67,12 @@ def gen_marshal_output(ret_type):
 
 static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out, Error **errp)
 {
-    Error *err = NULL;
     Visitor *v;
 
     v = qobject_output_visitor_new(ret_out);
-    visit_type_%(c_name)s(v, "unused", &ret_in, &err);
-    if (!err) {
+    if (visit_type_%(c_name)s(v, "unused", &ret_in, errp)) {
         visit_complete(v, ret_out);
     }
-    error_propagate(errp, err);
     visit_free(v);
     v = qapi_dealloc_visitor_new();
     visit_type_%(c_name)s(v, "unused", &ret_in, NULL);
@@ -104,6 +102,7 @@ def gen_marshal(name, arg_type, boxed, ret_type):
 %(proto)s
 {
     Error *err = NULL;
+    bool ok = false;
     Visitor *v;
 ''',
                 proto=build_marshal_proto(name))
@@ -123,28 +122,26 @@ def gen_marshal(name, arg_type, boxed, ret_type):
     ret += mcgen('''
 
     v = qobject_input_visitor_new(QOBJECT(args));
-    visit_start_struct(v, NULL, NULL, 0, &err);
-    if (err) {
+    if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
         goto out;
     }
 ''')
 
     if have_args:
         ret += mcgen('''
-    visit_type_%(c_arg_type)s_members(v, &arg, &err);
-    if (!err) {
-        visit_check_struct(v, &err);
+    if (visit_type_%(c_arg_type)s_members(v, &arg, errp)) {
+        ok = visit_check_struct(v, errp);
     }
 ''',
                      c_arg_type=arg_type.c_name())
     else:
         ret += mcgen('''
-    visit_check_struct(v, &err);
+    ok = visit_check_struct(v, errp);
 ''')
 
     ret += mcgen('''
     visit_end_struct(v, NULL);
-    if (err) {
+    if (!ok) {
         goto out;
     }
 ''')
@@ -154,7 +151,6 @@ def gen_marshal(name, arg_type, boxed, ret_type):
     ret += mcgen('''
 
 out:
-    error_propagate(errp, err);
     visit_free(v);
 ''')
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index ba0cf0b074..3fb2f30510 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -41,8 +41,6 @@ def gen_visit_object_members(name, base, members, variants):
 
 bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 {
-    Error *err = NULL;
-
 ''',
                 c_name=c_name(name))
 
@@ -97,8 +95,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
             else:
                 ret += mcgen('''
     case %(case)s:
-        visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, &err);
-        break;
+        return visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, errp);
 ''',
                              case=case_str,
                              c_type=var.type.c_name(), c_name=c_name(var.name))
@@ -111,8 +108,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 ''')
 
     ret += mcgen('''
-    error_propagate(errp, err);
-    return !err;
+    return true;
 }
 ''')
     return ret
@@ -123,7 +119,7 @@ def gen_visit_list(name, element_type):
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
 {
-    Error *err = NULL;
+    bool ok = false;
     %(c_name)s *tail;
     size_t size = sizeof(**obj);
 
@@ -133,22 +129,19 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
 
     for (tail = *obj; tail;
          tail = (%(c_name)s *)visit_next_list(v, (GenericList *)tail, size)) {
-        visit_type_%(c_elt_type)s(v, NULL, &tail->value, &err);
-        if (err) {
-            break;
+        if (!visit_type_%(c_elt_type)s(v, NULL, &tail->value, errp)) {
+            goto out_obj;
         }
     }
 
-    if (!err) {
-        visit_check_list(v, &err);
-    }
+    ok = visit_check_list(v, errp);
+out_obj:
     visit_end_list(v, (void **)obj);
-    if (err && visit_is_input(v)) {
+    if (!ok && visit_is_input(v)) {
         qapi_free_%(c_name)s(*obj);
         *obj = NULL;
     }
-    error_propagate(errp, err);
-    return !err;
+    return ok;
 }
 ''',
                  c_name=c_name(name), c_elt_type=element_type.c_name())
@@ -173,7 +166,7 @@ def gen_visit_alternate(name, variants):
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
 {
-    Error *err = NULL;
+    bool ok = false;
 
     if (!visit_start_alternate(v, name, (GenericAlternate **)obj,
                                sizeof(**obj), errp)) {
@@ -182,6 +175,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     if (!*obj) {
         /* incomplete */
         assert(visit_is_dealloc(v));
+        ok = true;
         goto out_obj;
     }
     switch ((*obj)->type) {
@@ -196,13 +190,11 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
                      case=var.type.alternate_qtype())
         if isinstance(var.type, QAPISchemaObjectType):
             ret += mcgen('''
-        visit_start_struct(v, name, NULL, 0, &err);
-        if (err) {
+        if (!visit_start_struct(v, name, NULL, 0, errp)) {
             break;
         }
-        visit_type_%(c_type)s_members(v, &(*obj)->u.%(c_name)s, &err);
-        if (!err) {
-            visit_check_struct(v, &err);
+        if (visit_type_%(c_type)s_members(v, &(*obj)->u.%(c_name)s, errp)) {
+            ok = visit_check_struct(v, errp);
         }
         visit_end_struct(v, NULL);
 ''',
@@ -210,7 +202,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
                          c_name=c_name(var.name))
         else:
             ret += mcgen('''
-        visit_type_%(c_type)s(v, name, &(*obj)->u.%(c_name)s, &err);
+        ok = visit_type_%(c_type)s(v, name, &(*obj)->u.%(c_name)s, errp);
 ''',
                          c_type=var.type.c_name(),
                          c_name=c_name(var.name))
@@ -224,7 +216,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
         abort();
     default:
         assert(visit_is_input(v));
-        error_setg(&err, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "%(name)s");
         /* Avoid passing invalid *obj to qapi_free_%(c_name)s() */
         g_free(*obj);
@@ -232,12 +224,11 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     }
 out_obj:
     visit_end_alternate(v, (void **)obj);
-    if (err && visit_is_input(v)) {
+    if (!ok && visit_is_input(v)) {
         qapi_free_%(c_name)s(*obj);
         *obj = NULL;
     }
-    error_propagate(errp, err);
-    return !err;
+    return ok;
 }
 ''',
                  name=name, c_name=c_name(name))
@@ -250,7 +241,7 @@ def gen_visit_object(name, base, members, variants):
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
 {
-    Error *err = NULL;
+    bool ok = false;
 
     if (!visit_start_struct(v, name, (void **)obj, sizeof(%(c_name)s), errp)) {
         return false;
@@ -260,19 +251,17 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
         assert(visit_is_dealloc(v));
         goto out_obj;
     }
-    visit_type_%(c_name)s_members(v, *obj, &err);
-    if (err) {
+    if (!visit_type_%(c_name)s_members(v, *obj, errp)) {
         goto out_obj;
     }
-    visit_check_struct(v, &err);
+    ok = visit_check_struct(v, errp);
 out_obj:
     visit_end_struct(v, (void **)obj);
-    if (err && visit_is_input(v)) {
+    if (!ok && visit_is_input(v)) {
         qapi_free_%(c_name)s(*obj);
         *obj = NULL;
     }
-    error_propagate(errp, err);
-    return !err;
+    return ok;
 }
 ''',
                  c_name=c_name(name))
-- 
2.26.2


