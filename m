Received: from eggs.gnu.org ([2001:4830:134:3::10]:44663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMW-00067j-O4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMU-00012X-F7
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:49 +0100
Message-Id: <1488194450-28056-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 23/24] keyval: Restrict key components to valid
 QAPI names
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

Restricting the key components to something sane leaves us room for
evolving key syntax.  Since they will be commonly used as QAPI member
names by the QObject input visitor, we can just as well borrow the
QAPI naming rules here.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-keyval.c | 10 ++++++++++
 util/keyval.c       | 12 ++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index f6496d7..6eceafb 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -41,6 +41,11 @@ static void test_keyval_parse(void)
     error_free_or_abort(&err);
     g_assert(!qdict);
 
+    /* Invalid non-empty key (qemu_opts_parse() doesn't care) */
+    qdict = keyval_parse("7up=val", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
     /* Overlong key */
     memset(long_key, 'a', 127);
     long_key[127] = 'z';
@@ -73,6 +78,11 @@ static void test_keyval_parse(void)
     QDECREF(qdict);
     g_free(params);
 
+    /* Crap after valid key */
+    qdict = keyval_parse("key[0]=val", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
     /* Multiple keys, last one wins */
     qdict = keyval_parse("a=1,b=2,,x,a=3", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 2);
diff --git a/util/keyval.c b/util/keyval.c
index 3904c39..1170dad 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -34,6 +34,8 @@
  *   doesn't have one, because R.a must be an object to satisfy a.b=1
  *   and a string to satisfy a=2.
  *
+ * Key-fragments must be valid QAPI names.
+ *
  * The length of any key-fragment must be between 1 and 127.
  *
  * Design flaw: there is no way to denote an empty non-root object.
@@ -51,12 +53,12 @@
  * where no-key is syntactic sugar for implied-key=val-no-key.
  *
  * TODO support lists
- * TODO support key-fragment with __RFQDN_ prefix (downstream extensions)
  */
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/util.h"
 #include "qemu/option.h"
 
 /*
@@ -115,6 +117,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
     size_t len;
     char key_in_cur[128];
     QDict *cur;
+    int ret;
     QObject *next;
     QString *val;
 
@@ -134,9 +137,10 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
     cur = qdict;
     s = key;
     for (;;) {
-        for (len = 0; s + len < key_end && s[len] != '.'; len++) {
-        }
-        if (!len) {
+        ret = parse_qapi_name(s, false);
+        len = ret < 0 ? 0 : ret;
+        assert(s + len <= key_end);
+        if (!len || (s + len < key_end && s[len] != '.')) {
             assert(key != implied_key);
             error_setg(errp, "Invalid parameter '%.*s'",
                        (int)(key_end - key), key);
-- 
2.7.4
