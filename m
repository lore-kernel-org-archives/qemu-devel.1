Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC1C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED64920756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XV5XqzMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED64920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkEu-0007X6-UE
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9m-0006cn-O6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9j-0005Dk-DV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1xzQ9OKgozbVFDbN1rz6hXKlTxyjndGGNrLvi6gbZY=;
 b=XV5XqzMMsXML+BL+AABkq1O59hjiVq1WjY3oWg7G+67RH7fLvbJcsm9B11uUhvB//wt72l
 Os6F8ahcG+WRiuljcmZf0fzrCOsmfaV2OJAaWL/e2x0HCtNG+DPFMsfMuCwuTbUdmHuHce
 pQQQpx9uzIMkLYgNia93ObekpeK5Kks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-iDpInMY3NeefTL_Q_2mOew-1; Mon, 14 Sep 2020 04:48:08 -0400
X-MC-Unique: iDpInMY3NeefTL_Q_2mOew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54EEA18BA2AE;
 Mon, 14 Sep 2020 08:48:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A90DF6FEE6;
 Mon, 14 Sep 2020 08:48:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B2781141D22; Mon, 14 Sep 2020 10:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/8] qapi: Implement deprecated-input=reject for QMP
 command arguments
Date: Mon, 14 Sep 2020 10:48:01 +0200
Message-Id: <20200914084802.4185028-8-armbru@redhat.com>
In-Reply-To: <20200914084802.4185028-1-armbru@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy rejects deprecated input, and thus permits "testing the
future".  Implement it for QMP command arguments: reject commands with
deprecated ones.  Example: when QEMU is run with -compat
deprecated-input=reject, then

    {"execute": "eject", "arguments": {"device": "cd"}}

fails like this

    {"error": {"class": "GenericError", "desc": "Deprecated parameter 'device' disabled by policy"}}

When the deprecated parameter is removed, the error will change to

    {"error": {"class": "GenericError", "desc": "Parameter 'device' is unexpected"}}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qobject-input-visitor.h |  9 +++++++++
 include/qapi/visitor-impl.h          |  3 +++
 include/qapi/visitor.h               |  9 +++++++++
 qapi/qapi-visit-core.c               |  9 +++++++++
 qapi/qobject-input-visitor.c         | 28 ++++++++++++++++++++++++++++
 tests/test-qmp-cmds.c                | 25 +++++++++++++++++++++++++
 qapi/trace-events                    |  1 +
 scripts/qapi/commands.py             |  2 +-
 scripts/qapi/visit.py                |  3 +++
 9 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
index 95985e25e5..cbc54de4ac 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -58,6 +58,15 @@ typedef struct QObjectInputVisitor QObjectInputVisitor;
  */
 Visitor *qobject_input_visitor_new(QObject *obj);
 
+/*
+ * Create a QObject input visitor for @obj for use with QMP
+ *
+ * This is like qobject_input_visitor_new(), except it obeys the
+ * policy for handling deprecated management interfaces set with
+ * -compat.
+ */
+Visitor *qobject_input_visitor_new_qmp(QObject *obj);
+
 /*
  * Create a QObject input visitor for @obj for use with keyval_parse()
  *
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 2d853255a3..3b950f6e3d 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -113,6 +113,9 @@ struct Visitor
        The core takes care of the return type in the public interface. */
     void (*optional)(Visitor *v, const char *name, bool *present);
 
+    /* Optional */
+    bool (*deprecated_accept)(Visitor *v, const char *name, Error **errp);
+
     /* Optional */
     bool (*deprecated)(Visitor *v, const char *name);
 
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 4d23b59853..b3c9ef7a81 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -459,6 +459,15 @@ void visit_end_alternate(Visitor *v, void **obj);
  */
 bool visit_optional(Visitor *v, const char *name, bool *present);
 
+/*
+ * Should we reject deprecated member @name?
+ *
+ * @name must not be NULL.  This function is only useful between
+ * visit_start_struct() and visit_end_struct(), since only objects
+ * have deprecated members.
+ */
+bool visit_deprecated_accept(Visitor *v, const char *name, Error **errp);
+
 /*
  * Should we visit deprecated member @name?
  *
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index d9726ecaa1..a641adec51 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -135,6 +135,15 @@ bool visit_optional(Visitor *v, const char *name, bool *present)
     return *present;
 }
 
+bool visit_deprecated_accept(Visitor *v, const char *name, Error **errp)
+{
+    trace_visit_deprecated_accept(v, name);
+    if (v->deprecated_accept) {
+        return v->deprecated_accept(v, name, errp);
+    }
+    return true;
+}
+
 bool visit_deprecated(Visitor *v, const char *name)
 {
     trace_visit_deprecated(v, name);
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f918a05e5f..91e2d84ad2 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include <math.h>
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor-impl.h"
@@ -43,6 +44,7 @@ typedef struct StackObject {
 
 struct QObjectInputVisitor {
     Visitor visitor;
+    CompatPolicyInput deprecated_policy;
 
     /* Root of visit at visitor creation. */
     QObject *root;
@@ -666,6 +668,23 @@ static void qobject_input_optional(Visitor *v, const char *name, bool *present)
     *present = true;
 }
 
+static bool qobject_input_deprecated_accept(Visitor *v, const char *name,
+                                            Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+
+    switch (qiv->deprecated_policy) {
+    case COMPAT_POLICY_INPUT_ACCEPT:
+        return true;
+    case COMPAT_POLICY_INPUT_REJECT:
+        error_setg(errp, "Deprecated parameter '%s' disabled by policy",
+                   name);
+        return false;
+    default:
+        abort();
+    }
+}
+
 static void qobject_input_free(Visitor *v)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -700,6 +719,7 @@ static QObjectInputVisitor *qobject_input_visitor_base_new(QObject *obj)
     v->visitor.end_list = qobject_input_end_list;
     v->visitor.start_alternate = qobject_input_start_alternate;
     v->visitor.optional = qobject_input_optional;
+    v->visitor.deprecated_accept = qobject_input_deprecated_accept;
     v->visitor.free = qobject_input_free;
 
     v->root = qobject_ref(obj);
@@ -722,6 +742,14 @@ Visitor *qobject_input_visitor_new(QObject *obj)
     return &v->visitor;
 }
 
+Visitor *qobject_input_visitor_new_qmp(QObject *obj)
+{
+    QObjectInputVisitor *v = to_qiv(qobject_input_visitor_new(obj));
+
+    v->deprecated_policy = compat_policy.deprecated_input;
+    return &v->visitor;
+}
+
 Visitor *qobject_input_visitor_new_keyval(QObject *obj)
 {
     QObjectInputVisitor *v = qobject_input_visitor_base_new(obj);
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 033d5dae9d..9aec9da2ce 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -299,6 +299,29 @@ static void test_dispatch_cmd_deprecated(void)
     do_qmp_dispatch_error(false, ERROR_CLASS_COMMAND_NOT_FOUND, cmd);
 }
 
+static void test_dispatch_cmd_arg_deprecated(void)
+{
+    const char *cmd = "{ 'execute': 'test-features0',"
+        " 'arguments': { 'fs1': { 'foo': 42 } } }";
+    QDict *ret;
+
+    memset(&compat_policy, 0, sizeof(compat_policy));
+
+    /* accept */
+    ret = qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) == 1);
+    qobject_unref(ret);
+
+    compat_policy.has_deprecated_input = true;
+    compat_policy.deprecated_input = COMPAT_POLICY_INPUT_ACCEPT;
+    ret = qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) == 1);
+    qobject_unref(ret);
+
+    compat_policy.deprecated_input = COMPAT_POLICY_INPUT_REJECT;
+    do_qmp_dispatch_error(false, ERROR_CLASS_GENERIC_ERROR, cmd);
+}
+
 static void test_dispatch_cmd_ret_deprecated(void)
 {
     const char *cmd = "{ 'execute': 'test-features0' }";
@@ -399,6 +422,8 @@ int main(int argc, char **argv)
                     test_dispatch_cmd_success_response);
     g_test_add_func("/qmp/dispatch_cmd_deprecated",
                     test_dispatch_cmd_deprecated);
+    g_test_add_func("/qmp/dispatch_cmd_arg_deprecated",
+                    test_dispatch_cmd_arg_deprecated);
     g_test_add_func("/qmp/dispatch_cmd_ret_deprecated",
                     test_dispatch_cmd_ret_deprecated);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
diff --git a/qapi/trace-events b/qapi/trace-events
index eff1fbd199..3cabe912ae 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -17,6 +17,7 @@ visit_start_alternate(void *v, const char *name, void *obj, size_t size) "v=%p n
 visit_end_alternate(void *v, void *obj) "v=%p obj=%p"
 
 visit_optional(void *v, const char *name, bool *present) "v=%p name=%s present=%p"
+visit_deprecated_accept(void *v, const char *name) "v=%p name=%s"
 visit_deprecated(void *v, const char *name) "v=%p name=%s"
 
 visit_type_enum(void *v, const char *name, int *obj) "v=%p name=%s obj=%p"
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 5f4b16fed0..9c9b119f32 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -121,7 +121,7 @@ def gen_marshal(name, arg_type, boxed, ret_type):
 
     ret += mcgen('''
 
-    v = qobject_input_visitor_new(QOBJECT(args));
+    v = qobject_input_visitor_new_qmp(QOBJECT(args));
     if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
         goto out;
     }
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 110563e56f..ad1747a84f 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -63,6 +63,9 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
             push_indent()
         if deprecated:
             ret += mcgen('''
+    if (!visit_deprecated_accept(v, "%(name)s", errp)) {
+        return false;
+    }
     if (visit_deprecated(v, "%(name)s")) {
 ''',
                          name=memb.name)
-- 
2.26.2


