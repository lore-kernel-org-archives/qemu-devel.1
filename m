Received: from eggs.gnu.org ([2001:4830:134:3::10]:59641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cHCyo-00022x-8C
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cHCyj-00077u-4m
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:04:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cHCyi-00076g-RX
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:04:29 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBEH44vV063305
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 12:04:27 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b8ubdu4p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 12:04:26 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 14 Dec 2016 10:04:26 -0700
From: Greg Kurz <groug@kaod.org>
Date: Wed, 14 Dec 2016 18:04:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148173506053.2583.5116401313254785036.stgit@bahia>
Subject: [Qemu-devel] [PATCH for-2.9 v2] qapi: add explicit null to string
 input and output visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This may be used for deprecated object properties that are kept for
backwards compatibility.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - input visitor to reject non-empty strings

This is needed for David's patch to work:

[RFCv2 10/12] pseries: Move CPU compatibility property to machine

Messag-Id: <1479248275-18889-11-git-send-email-david@gibson.dropbear.id.au>

Since this v2 changes the behavior to reject non-empty null properties,
it is up to getset_compat_deprecated() to ignore the error. The following
folded into patch [RFCv2 10/12] does the trick:

--- a/target-ppc/translate_init.c
+++ b/target-ppc/translate_init.c
@@ -8446,7 +8446,7 @@ static void getset_compat_deprecated(Object *obj, Visitor
     if (!qtest_enabled()) {
         error_report("CPU 'compat' property is deprecated and has no effect; us
     }
-    visit_type_null(v, name, errp);
+    visit_type_null(v, name, NULL);
 }

 static PropertyInfo ppc_compat_deprecated_propinfo = {
---
 qapi/string-input-visitor.c  |   11 +++++++++++
 qapi/string-output-visitor.c |   14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 8dfa5612522b..9e9d2a1d2865 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -314,6 +314,16 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     *obj = val;
 }
 
+static void parse_type_null(Visitor *v, const char *name, Error **errp)
+{
+    StringInputVisitor *siv = to_siv(v);
+
+    if (siv->string && siv->string[0]) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
+                   "null");
+    }
+}
+
 static void parse_optional(Visitor *v, const char *name, bool *present)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -348,6 +358,7 @@ Visitor *string_input_visitor_new(const char *str)
     v->visitor.type_bool = parse_type_bool;
     v->visitor.type_str = parse_type_str;
     v->visitor.type_number = parse_type_number;
+    v->visitor.type_null = parse_type_null;
     v->visitor.start_list = start_list;
     v->visitor.next_list = next_list;
     v->visitor.end_list = end_list;
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 94ac8211d144..5ec5352ca87c 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -266,6 +266,19 @@ static void print_type_number(Visitor *v, const char *name, double *obj,
     string_output_set(sov, g_strdup_printf("%f", *obj));
 }
 
+static void print_type_null(Visitor *v, const char *name, Error **errp)
+{
+    StringOutputVisitor *sov = to_sov(v);
+    char *out;
+
+    if (sov->human) {
+        out = g_strdup("<null>");
+    } else {
+        out = g_strdup("");
+    }
+    string_output_set(sov, out);
+}
+
 static void
 start_list(Visitor *v, const char *name, GenericList **list, size_t size,
            Error **errp)
@@ -351,6 +364,7 @@ Visitor *string_output_visitor_new(bool human, char **result)
     v->visitor.type_bool = print_type_bool;
     v->visitor.type_str = print_type_str;
     v->visitor.type_number = print_type_number;
+    v->visitor.type_null = print_type_null;
     v->visitor.start_list = start_list;
     v->visitor.next_list = next_list;
     v->visitor.end_list = end_list;
