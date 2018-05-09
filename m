Received: from eggs.gnu.org ([2001:4830:134:3::10]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNc-0003dG-Ab
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNb-0006pp-KW
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:52 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 18:55:25 +0200
Message-Id: <20180509165530.29561-9-mreitz@redhat.com>
In-Reply-To: <20180509165530.29561-1-mreitz@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 08/13] tests: Add qdict_stringify_for_keyval()
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/check-qdict.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 93e2112b6d..ef5d17f815 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -973,6 +973,57 @@ static void qdict_stress_test(void)
     qobject_unref(qdict);
 }
 
+static void qdict_stringify_for_keyval_test(void)
+{
+    QDict *dict = qdict_new();
+
+    /*
+     * Test stringification of:
+     *
+     * {
+     *     "a": "null",
+     *     "b": 42,
+     *     "c": -23,
+     *     "d": false,
+     *     "e": null,
+     *     "f": "",
+     *     "g": 0.5,
+     *     "h": 0xffffffffffffffff,
+     *     "i": true,
+     *     "j": 0
+     *  }
+     *
+     *  Note that null is not transformed into a string and remains a
+     *  QNull.
+     */
+
+    qdict_put_str(dict, "a", "null");
+    qdict_put_int(dict, "b", 42);
+    qdict_put_int(dict, "c", -23);
+    qdict_put_bool(dict, "d", false);
+    qdict_put_null(dict, "e");
+    qdict_put_str(dict, "f", "");
+    qdict_put(dict, "g", qnum_from_double(0.5));
+    qdict_put(dict, "h", qnum_from_uint(0xffffffffffffffffull));
+    qdict_put_bool(dict, "i", true);
+    qdict_put_int(dict, "j", 0);
+
+    qdict_stringify_for_keyval(dict);
+
+    g_assert(!strcmp(qdict_get_str(dict, "a"), "null"));
+    g_assert(!strcmp(qdict_get_str(dict, "b"), "42"));
+    g_assert(!strcmp(qdict_get_str(dict, "c"), "-23"));
+    g_assert(!strcmp(qdict_get_str(dict, "d"), "off"));
+    g_assert(qobject_type(qdict_get(dict, "e")) == QTYPE_QNULL);
+    g_assert(!strcmp(qdict_get_str(dict, "f"), ""));
+    g_assert(!strcmp(qdict_get_str(dict, "g"), "0.5"));
+    g_assert(!strcmp(qdict_get_str(dict, "h"), "18446744073709551615"));
+    g_assert(!strcmp(qdict_get_str(dict, "i"), "on"));
+    g_assert(!strcmp(qdict_get_str(dict, "j"), "0"));
+
+    qobject_unref(dict);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -1010,6 +1061,9 @@ int main(int argc, char **argv)
 
     g_test_add_func("/public/rename_keys", qdict_rename_keys_test);
 
+    g_test_add_func("/public/stringify_for_keyval",
+                    qdict_stringify_for_keyval_test);
+
     /* The Big one */
     if (g_test_slow()) {
         g_test_add_func("/stress/test", qdict_stress_test);
-- 
2.14.3
