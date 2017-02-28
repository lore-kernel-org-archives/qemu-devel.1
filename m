Received: from eggs.gnu.org ([2001:4830:134:3::10]:49996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkG-0003eO-PZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkD-0005R1-E0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cilkD-0005Q9-4l
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A975C05681A
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:39:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 18:39:08 +0100
Message-Id: <1488303560-18803-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1488303560-18803-1-git-send-email-armbru@redhat.com>
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/26] qapi: Make string input and opts
 visitor require non-null input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The string input visitor tries to cope with null input.  Null input
isn't used anywhere, and isn't covered by tests.  Unsurprisingly, it
doesn't fully work: start_list() crashes because it passes the input
via parse_str() to strtoll() unchecked.

Make string_input_visitor_new() assert its argument isn't null, and
drop the code trying to deal with null input.

The opts visitor crashes when you try to actually visit something with
null input.  Make opts_visitor_new() assert its argument isn't null,
mostly for clarity.

qobject_input_visitor_new() already asserts its argument isn't null.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/opts-visitor.c         |  1 +
 qapi/string-input-visitor.c | 54 ++++++++++++++-------------------------------
 2 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index a0a7c0e..c50dc4b 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -528,6 +528,7 @@ opts_visitor_new(const QemuOpts *opts)
 {
     OptsVisitor *ov;
 
+    assert(opts);
     ov = g_malloc0(sizeof *ov);
 
     ov->visitor.type = VISITOR_INPUT;
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 1a855c5..f126cd9 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -182,12 +182,6 @@ static void parse_type_int64(Visitor *v, const char *name, int64_t *obj,
 {
     StringInputVisitor *siv = to_siv(v);
 
-    if (!siv->string) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "integer");
-        return;
-    }
-
     if (parse_str(siv, name, errp) < 0) {
         return;
     }
@@ -242,13 +236,7 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
     Error *err = NULL;
     uint64_t val;
 
-    if (siv->string) {
-        parse_option_size(name, siv->string, &val, &err);
-    } else {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "size");
-        return;
-    }
+    parse_option_size(name, siv->string, &val, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -262,19 +250,17 @@ static void parse_type_bool(Visitor *v, const char *name, bool *obj,
 {
     StringInputVisitor *siv = to_siv(v);
 
-    if (siv->string) {
-        if (!strcasecmp(siv->string, "on") ||
-            !strcasecmp(siv->string, "yes") ||
-            !strcasecmp(siv->string, "true")) {
-            *obj = true;
-            return;
-        }
-        if (!strcasecmp(siv->string, "off") ||
-            !strcasecmp(siv->string, "no") ||
-            !strcasecmp(siv->string, "false")) {
-            *obj = false;
-            return;
-        }
+    if (!strcasecmp(siv->string, "on") ||
+        !strcasecmp(siv->string, "yes") ||
+        !strcasecmp(siv->string, "true")) {
+        *obj = true;
+        return;
+    }
+    if (!strcasecmp(siv->string, "off") ||
+        !strcasecmp(siv->string, "no") ||
+        !strcasecmp(siv->string, "false")) {
+        *obj = false;
+        return;
     }
 
     error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
@@ -285,13 +271,8 @@ static void parse_type_str(Visitor *v, const char *name, char **obj,
                            Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
-    if (siv->string) {
-        *obj = g_strdup(siv->string);
-    } else {
-        *obj = NULL;
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "string");
-    }
+
+    *obj = g_strdup(siv->string);
 }
 
 static void parse_type_number(Visitor *v, const char *name, double *obj,
@@ -302,10 +283,8 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     double val;
 
     errno = 0;
-    if (siv->string) {
-        val = strtod(siv->string, &endp);
-    }
-    if (!siv->string || errno || endp == siv->string || *endp) {
+    val = strtod(siv->string, &endp);
+    if (errno || endp == siv->string || *endp) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "number");
         return;
@@ -327,6 +306,7 @@ Visitor *string_input_visitor_new(const char *str)
 {
     StringInputVisitor *v;
 
+    assert(str);
     v = g_malloc0(sizeof(*v));
 
     v->visitor.type = VISITOR_INPUT;
-- 
2.7.4
