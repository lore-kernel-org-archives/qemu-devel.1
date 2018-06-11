Received: from eggs.gnu.org ([2001:4830:134:3::10]:43851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnh-0001sk-4u
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTng-0008K7-AV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:29 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:52:00 +0200
Message-Id: <20180611205203.2624-8-mreitz@redhat.com>
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/10] tests: Add QDict clone-flatten test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This new test verifies that qdict_flatten() does not modify a shallow
clone of the given QDict.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/check-block-qdict.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/check-block-qdict.c b/tests/check-block-qdict.c
index 1d20fccbd4..478807f839 100644
--- a/tests/check-block-qdict.c
+++ b/tests/check-block-qdict.c
@@ -125,6 +125,38 @@ static void qdict_flatten_test(void)
     qobject_unref(root);
 }
 
+static void qdict_clone_flatten_test(void)
+{
+    QDict *dict1 = qdict_new();
+    QDict *dict2 = qdict_new();
+    QDict *cloned_dict1;
+
+    /*
+     * Test that we can clone and flatten
+     *    { "a": { "b": 42 } }
+     * without modifying the clone.
+     */
+
+    qdict_put_int(dict2, "b", 42);
+    qdict_put(dict1, "a", dict2);
+
+    cloned_dict1 = qdict_clone_shallow(dict1);
+
+    qdict_flatten(dict1);
+
+    g_assert(qdict_size(dict1) == 1);
+    g_assert(qdict_get_int(dict1, "a.b") == 42);
+
+    g_assert(qdict_size(cloned_dict1) == 1);
+    g_assert(qdict_get_qdict(cloned_dict1, "a") == dict2);
+
+    g_assert(qdict_size(dict2) == 1);
+    g_assert(qdict_get_int(dict2, "b") == 42);
+
+    qobject_unref(dict1);
+    qobject_unref(cloned_dict1);
+}
+
 static void qdict_array_split_test(void)
 {
     QDict *test_dict = qdict_new();
@@ -674,6 +706,7 @@ int main(int argc, char **argv)
 
     g_test_add_func("/public/defaults", qdict_defaults_test);
     g_test_add_func("/public/flatten", qdict_flatten_test);
+    g_test_add_func("/public/clone_flatten", qdict_clone_flatten_test);
     g_test_add_func("/public/array_split", qdict_array_split_test);
     g_test_add_func("/public/array_entries", qdict_array_entries_test);
     g_test_add_func("/public/join", qdict_join_test);
-- 
2.17.1
