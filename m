Received: from eggs.gnu.org ([2001:4830:134:3::10]:44768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMb-0006DM-31
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMV-00013r-Ga
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:09 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:48 +0100
Message-Id: <1488194450-28056-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 22/24] qapi: New parse_qapi_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/util.h    |  2 ++
 qapi/qapi-util.c       | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/test-qapi-util.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 7ad26c0..7436ed8 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -14,4 +14,6 @@
 int qapi_enum_parse(const char * const lookup[], const char *buf,
                     int max, int def, Error **errp);
 
+int parse_qapi_name(const char *name, bool complete);
+
 #endif
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 818730a..53b27e2 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -33,3 +33,50 @@ int qapi_enum_parse(const char * const lookup[], const char *buf,
     error_setg(errp, "invalid parameter value: %s", buf);
     return def;
 }
+
+/*
+ * Parse a valid QAPI name from @str.
+ * A valid name consists of letters, digits, hyphen and underscore.
+ * It may be prefixed by __RFQDN_ (downstream extension), where RFQDN
+ * may contain only letters, digits and hyphen.
+ * The special exception for enumeration names is not implemented.
+ * See docs/qapi-code-gen.txt for more on QAPI naming rules.
+ * Keep this consistent with scripts/qapi.py!
+ * If @complete, the parse fails unless it consumes @str completely.
+ * Return its length on success, -1 on failure.
+ */
+int parse_qapi_name(const char *str, bool complete)
+{
+    const char *p = str;
+
+    if (*p == '_') {            /* Downstream __RFQDN_ */
+        p++;
+        if (*p != '_') {
+            return -1;
+        }
+        while (*++p) {
+            if (!qemu_isalnum(*p) && *p != '-' && *p != '.') {
+                break;
+            }
+        }
+
+        if (*p != '_') {
+            return -1;
+        }
+        p++;
+    }
+
+    if (!qemu_isalpha(*p)) {
+        return -1;
+    }
+    while (*++p) {
+        if (!qemu_isalnum(*p) && *p != '-' && *p != '_') {
+            break;
+        }
+    }
+
+    if (complete && *p) {
+        return -1;
+    }
+    return p - str;
+}
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index 39db8bf..e869757 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -42,10 +42,44 @@ static void test_qapi_enum_parse(void)
     g_assert_cmpint(ret, ==, QTYPE__MAX - 1);
 }
 
+static void test_parse_qapi_name(void)
+{
+    int ret;
+
+    /* Must start with a letter */
+    ret = parse_qapi_name("a", true);
+    g_assert(ret == 1);
+    ret = parse_qapi_name("a$", false);
+    g_assert(ret == 1);
+    ret = parse_qapi_name("", false);
+    g_assert(ret == -1);
+    ret = parse_qapi_name("1", false);
+    g_assert(ret == -1);
+
+    /* Only letters, digits, hyphen, underscore */
+    ret = parse_qapi_name("A-Za-z0-9_", true);
+    g_assert(ret == 10);
+    ret = parse_qapi_name("A-Za-z0-9_$", false);
+    g_assert(ret == 10);
+    ret = parse_qapi_name("A-Za-z0-9_$", true);
+    g_assert(ret == -1);
+
+    /* __RFQDN_ */
+    ret = parse_qapi_name("__com.redhat_supports", true);
+    g_assert(ret == 21);
+    ret = parse_qapi_name("_com.example_", false);
+    g_assert(ret == -1);
+    ret = parse_qapi_name("__com.example", false);
+    g_assert(ret == -1);
+    ret = parse_qapi_name("__com.example_", false);
+    g_assert(ret == -1);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/qapi/util/qapi_enum_parse", test_qapi_enum_parse);
+    g_test_add_func("/qapi/util/parse_qapi_name", test_parse_qapi_name);
     g_test_run();
     return 0;
 }
-- 
2.7.4
