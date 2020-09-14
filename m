Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF68C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43F420756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4/nsqrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43F420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkDg-0005Aj-UV
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9l-0006bn-Lp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35694
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9h-0005DH-GV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8fVyV4Rsx+vMUWvr3Kw0vp2F5RwbCfcOISfLkQDy+k=;
 b=E4/nsqrXuNN/YpNlQdLLOOgm9sDSk1qeVGkP16L7A+hoK9FlLQ3ra9TztJl80sHBjskNmz
 HGZoXsGI495gCFv61mEZ7XUsE7x9SWb2MT4t5/8j2DN7RBfGAaak022Gl+RWkZ9vU6+irp
 xRkgcCVFIPcB0YgEXA5wyUwwWl3jZK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-jrpbV60iOn-2oY3vbLk-Fg-1; Mon, 14 Sep 2020 04:48:05 -0400
X-MC-Unique: jrpbV60iOn-2oY3vbLk-Fg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A37318BA291;
 Mon, 14 Sep 2020 08:48:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A63E7E43C;
 Mon, 14 Sep 2020 08:48:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7974E1138468; Mon, 14 Sep 2020 10:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/8] qapi: Implement deprecated-output=hide for QMP command
 results
Date: Mon, 14 Sep 2020 10:47:56 +0200
Message-Id: <20200914084802.4185028-3-armbru@redhat.com>
In-Reply-To: <20200914084802.4185028-1-armbru@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy suppresses deprecated bits in output, and thus permits
"testing the future".  Implement it for QMP command results.  Example:
when QEMU is run with -compat deprecated-output=hide, then

    {"execute": "query-cpus-fast"}

yields

    {"return": [{"thread-id": 9805, "props": {"core-id": 0, "thread-id": 0, "socket-id": 0}, "qom-path": "/machine/unattached/device[0]", "cpu-index": 0, "target": "x86_64"}]}

instead of

    {"return": [{"arch": "x86", "thread-id": 22436, "props": {"core-id": 0, "thread-id": 0, "socket-id": 0}, "qom-path": "/machine/unattached/device[0]", "cpu-index": 0, "target": "x86_64"}]}

Note the suppression of deprecated member "arch".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qobject-output-visitor.h   |  9 ++++++
 include/qapi/visitor-impl.h             |  3 ++
 include/qapi/visitor.h                  |  9 ++++++
 qapi/qapi-visit-core.c                  |  9 ++++++
 qapi/qobject-output-visitor.c           | 19 +++++++++++
 tests/test-qmp-cmds.c                   | 42 ++++++++++++++++++++++---
 qapi/trace-events                       |  1 +
 scripts/qapi/commands.py                |  2 +-
 scripts/qapi/visit.py                   | 12 +++++++
 tests/qapi-schema/qapi-schema-test.json | 17 +++++-----
 tests/qapi-schema/qapi-schema-test.out  | 18 +++++------
 11 files changed, 118 insertions(+), 23 deletions(-)

diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobject-output-visitor.h
index 2b1726baf5..29f4ea6aad 100644
--- a/include/qapi/qobject-output-visitor.h
+++ b/include/qapi/qobject-output-visitor.h
@@ -53,4 +53,13 @@ typedef struct QObjectOutputVisitor QObjectOutputVisitor;
  */
 Visitor *qobject_output_visitor_new(QObject **result);
 
+/*
+ * Create a QObject output visitor for @obj for use with QMP
+ *
+ * This is like qobject_output_visitor_new(), except it obeys the
+ * policy for handling deprecated management interfaces set with
+ * -compat.
+ */
+Visitor *qobject_output_visitor_new_qmp(QObject **result);
+
 #endif
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 7362c043be..2d853255a3 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -113,6 +113,9 @@ struct Visitor
        The core takes care of the return type in the public interface. */
     void (*optional)(Visitor *v, const char *name, bool *present);
 
+    /* Optional */
+    bool (*deprecated)(Visitor *v, const char *name);
+
     /* Must be set */
     VisitorType type;
 
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index ebc19ede7f..4d23b59853 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -459,6 +459,15 @@ void visit_end_alternate(Visitor *v, void **obj);
  */
 bool visit_optional(Visitor *v, const char *name, bool *present);
 
+/*
+ * Should we visit deprecated member @name?
+ *
+ * @name must not be NULL.  This function is only useful between
+ * visit_start_struct() and visit_end_struct(), since only objects
+ * have deprecated members.
+ */
+bool visit_deprecated(Visitor *v, const char *name);
+
 /*
  * Visit an enum value.
  *
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 7e5f40e7f0..d9726ecaa1 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -135,6 +135,15 @@ bool visit_optional(Visitor *v, const char *name, bool *present)
     return *present;
 }
 
+bool visit_deprecated(Visitor *v, const char *name)
+{
+    trace_visit_deprecated(v, name);
+    if (v->deprecated) {
+        return v->deprecated(v, name);
+    }
+    return true;
+}
+
 bool visit_is_input(Visitor *v)
 {
     return v->type == VISITOR_INPUT;
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index ba6f6ac8a7..5c4aa0f64d 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/compat-policy.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
@@ -31,6 +32,8 @@ typedef struct QStackEntry {
 
 struct QObjectOutputVisitor {
     Visitor visitor;
+    CompatPolicyOutput deprecated_policy;
+
     QSLIST_HEAD(, QStackEntry) stack; /* Stack of unfinished containers */
     QObject *root; /* Root of the output visit */
     QObject **result; /* User's storage location for result */
@@ -207,6 +210,13 @@ static bool qobject_output_type_null(Visitor *v, const char *name,
     return true;
 }
 
+static bool qobject_output_deprecated(Visitor *v, const char *name)
+{
+    QObjectOutputVisitor *qov = to_qov(v);
+
+    return qov->deprecated_policy != COMPAT_POLICY_OUTPUT_HIDE;
+}
+
 /* Finish building, and return the root object.
  * The root object is never null. The caller becomes the object's
  * owner, and should use qobject_unref() when done with it.  */
@@ -256,6 +266,7 @@ Visitor *qobject_output_visitor_new(QObject **result)
     v->visitor.type_number = qobject_output_type_number;
     v->visitor.type_any = qobject_output_type_any;
     v->visitor.type_null = qobject_output_type_null;
+    v->visitor.deprecated = qobject_output_deprecated;
     v->visitor.complete = qobject_output_complete;
     v->visitor.free = qobject_output_free;
 
@@ -264,3 +275,11 @@ Visitor *qobject_output_visitor_new(QObject **result)
 
     return &v->visitor;
 }
+
+Visitor *qobject_output_visitor_new_qmp(QObject **result)
+{
+    QObjectOutputVisitor *v = to_qov(qobject_output_visitor_new(result));
+
+    v->deprecated_policy = compat_policy.deprecated_output;
+    return &v->visitor;
+}
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index d12ff47e26..bca89f8e88 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qapi/compat-policy.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qnum.h"
@@ -45,12 +46,17 @@ void qmp_user_def_cmd1(UserDefOne * ud1, Error **errp)
 {
 }
 
-void qmp_test_features0(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
-                       FeatureStruct2 *fs2, FeatureStruct3 *fs3,
-                       FeatureStruct4 *fs4, CondFeatureStruct1 *cfs1,
-                       CondFeatureStruct2 *cfs2, CondFeatureStruct3 *cfs3,
-                       Error **errp)
+FeatureStruct1 *qmp_test_features0(bool has_fs0, FeatureStruct0 *fs0,
+                                   bool has_fs1, FeatureStruct1 *fs1,
+                                   bool has_fs2, FeatureStruct2 *fs2,
+                                   bool has_fs3, FeatureStruct3 *fs3,
+                                   bool has_fs4, FeatureStruct4 *fs4,
+                                   bool has_cfs1, CondFeatureStruct1 *cfs1,
+                                   bool has_cfs2, CondFeatureStruct2 *cfs2,
+                                   bool has_cfs3, CondFeatureStruct3 *cfs3,
+                                   Error **errp)
 {
+    return g_new0(FeatureStruct1, 1);
 }
 
 void qmp_test_command_features1(Error **errp)
@@ -271,6 +277,30 @@ static void test_dispatch_cmd_io(void)
     qobject_unref(ret3);
 }
 
+static void test_dispatch_cmd_ret_deprecated(void)
+{
+    const char *cmd = "{ 'execute': 'test-features0' }";
+    QDict *ret;
+
+    memset(&compat_policy, 0, sizeof(compat_policy));
+
+    /* default accept */
+    ret = qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) == 1);
+    qobject_unref(ret);
+
+    compat_policy.has_deprecated_output = true;
+    compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_ACCEPT;
+    ret = qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) == 1);
+    qobject_unref(ret);
+
+    compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_HIDE;
+    ret = qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) == 0);
+    qobject_unref(ret);
+}
+
 /* test generated dealloc functions for generated types */
 static void test_dealloc_types(void)
 {
@@ -345,6 +375,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
     g_test_add_func("/qmp/dispatch_cmd_success_response",
                     test_dispatch_cmd_success_response);
+    g_test_add_func("/qmp/dispatch_cmd_ret_deprecated",
+                    test_dispatch_cmd_ret_deprecated);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
 
diff --git a/qapi/trace-events b/qapi/trace-events
index 5eb4afa110..eff1fbd199 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -17,6 +17,7 @@ visit_start_alternate(void *v, const char *name, void *obj, size_t size) "v=%p n
 visit_end_alternate(void *v, void *obj) "v=%p obj=%p"
 
 visit_optional(void *v, const char *name, bool *present) "v=%p name=%s present=%p"
+visit_deprecated(void *v, const char *name) "v=%p name=%s"
 
 visit_type_enum(void *v, const char *name, int *obj) "v=%p name=%s obj=%p"
 visit_type_int(void *v, const char *name, int64_t *obj) "v=%p name=%s obj=%p"
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 3cf9e1110b..14662515f3 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -69,7 +69,7 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
 {
     Visitor *v;
 
-    v = qobject_output_visitor_new(ret_out);
+    v = qobject_output_visitor_new_qmp(ret_out);
     if (visit_type_%(c_name)s(v, "unused", &ret_in, errp)) {
         visit_complete(v, ret_out);
     }
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index cdabc5fa28..110563e56f 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -53,6 +53,7 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                      c_type=base.c_name())
 
     for memb in members:
+        deprecated = 'deprecated' in [f.name for f in memb.features]
         ret += gen_if(memb.ifcond)
         if memb.optional:
             ret += mcgen('''
@@ -60,6 +61,12 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 ''',
                          name=memb.name, c_name=c_name(memb.name))
             push_indent()
+        if deprecated:
+            ret += mcgen('''
+    if (visit_deprecated(v, "%(name)s")) {
+''',
+                         name=memb.name)
+            push_indent()
         ret += mcgen('''
     if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
         return false;
@@ -67,6 +74,11 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 ''',
                      c_type=memb.type.c_name(), name=memb.name,
                      c_name=c_name(memb.name))
+        if deprecated:
+            pop_indent()
+            ret += mcgen('''
+    }
+''')
         if memb.optional:
             pop_indent()
             ret += mcgen('''
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 3a9f2cbb33..309e60566d 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -298,14 +298,15 @@
   'features': [ 'feature1' ] }
 
 { 'command': 'test-features0',
-  'data': { 'fs0': 'FeatureStruct0',
-            'fs1': 'FeatureStruct1',
-            'fs2': 'FeatureStruct2',
-            'fs3': 'FeatureStruct3',
-            'fs4': 'FeatureStruct4',
-            'cfs1': 'CondFeatureStruct1',
-            'cfs2': 'CondFeatureStruct2',
-            'cfs3': 'CondFeatureStruct3' },
+  'data': { '*fs0': 'FeatureStruct0',
+            '*fs1': 'FeatureStruct1',
+            '*fs2': 'FeatureStruct2',
+            '*fs3': 'FeatureStruct3',
+            '*fs4': 'FeatureStruct4',
+            '*cfs1': 'CondFeatureStruct1',
+            '*cfs2': 'CondFeatureStruct2',
+            '*cfs3': 'CondFeatureStruct3' },
+  'returns': 'FeatureStruct1',
   'features': [] }
 
 { 'command': 'test-command-features1',
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 891b4101e0..cd53323abd 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -407,15 +407,15 @@ alternate FeatureAlternate1
     case eins: FeatureStruct1
     feature feature1
 object q_obj_test-features0-arg
-    member fs0: FeatureStruct0 optional=False
-    member fs1: FeatureStruct1 optional=False
-    member fs2: FeatureStruct2 optional=False
-    member fs3: FeatureStruct3 optional=False
-    member fs4: FeatureStruct4 optional=False
-    member cfs1: CondFeatureStruct1 optional=False
-    member cfs2: CondFeatureStruct2 optional=False
-    member cfs3: CondFeatureStruct3 optional=False
-command test-features0 q_obj_test-features0-arg -> None
+    member fs0: FeatureStruct0 optional=True
+    member fs1: FeatureStruct1 optional=True
+    member fs2: FeatureStruct2 optional=True
+    member fs3: FeatureStruct3 optional=True
+    member fs4: FeatureStruct4 optional=True
+    member cfs1: CondFeatureStruct1 optional=True
+    member cfs2: CondFeatureStruct2 optional=True
+    member cfs3: CondFeatureStruct3 optional=True
+command test-features0 q_obj_test-features0-arg -> FeatureStruct1
     gen=True success_response=True boxed=False oob=False preconfig=False
 command test-command-features1 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
-- 
2.26.2


