Received: from eggs.gnu.org ([2001:4830:134:3::10]:34293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRh-0008Ru-2k
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRg-0007sK-2P
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:13 +1000
Message-Id: <20170630104632.27942-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/21] qapi: add explicit null to string input
 and output visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This may be used for deprecated object properties that are kept for
backwards compatibility.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 qapi/string-input-visitor.c  | 11 +++++++++++
 qapi/string-output-visitor.c | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index c089491..63ae115 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -326,6 +326,16 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
     *obj = val;
 }
 
+static void parse_type_null(Visitor *v, const char *name, Error **errp)
+{
+    StringInputVisitor *siv = to_siv(v);
+
+    if (!siv->string || siv->string[0]) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
+                   "null");
+    }
+}
+
 static void string_input_free(Visitor *v)
 {
     StringInputVisitor *siv = to_siv(v);
@@ -349,6 +359,7 @@ Visitor *string_input_visitor_new(const char *str)
     v->visitor.type_bool = parse_type_bool;
     v->visitor.type_str = parse_type_str;
     v->visitor.type_number = parse_type_number;
+    v->visitor.type_null = parse_type_null;
     v->visitor.start_list = start_list;
     v->visitor.next_list = next_list;
     v->visitor.check_list = check_list;
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 53c2175..af649e1 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -256,6 +256,19 @@ static void print_type_number(Visitor *v, const char *name, double *obj,
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
@@ -341,6 +354,7 @@ Visitor *string_output_visitor_new(bool human, char **result)
     v->visitor.type_bool = print_type_bool;
     v->visitor.type_str = print_type_str;
     v->visitor.type_number = print_type_number;
+    v->visitor.type_null = print_type_null;
     v->visitor.start_list = start_list;
     v->visitor.next_list = next_list;
     v->visitor.end_list = end_list;
-- 
2.9.4
