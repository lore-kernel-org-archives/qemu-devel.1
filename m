Received: from eggs.gnu.org ([2001:4830:134:3::10]:37220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilt-0006b0-Az
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilm-0001le-Oj
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 17:05:46 +0100
Message-Id: <1490198748-4753-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1490198748-4753-1-git-send-email-armbru@redhat.com>
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 15/17] tests: Expose regression in
 QemuOpts visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org

From: Eric Blake <eblake@redhat.com>

Commit 15c2f669e broke the ability of the QemuOpts visitor to
flag extra input parameters, but the regression went unnoticed
because of missing testsuite coverage.  Add a test to cover this;
take the approach already used in 9cb8ef3 of adding a test that
passes (to avoid breaking bisection) but marks with BUG the
behavior that we don't like, so that the actual impact of the
fix in a later patch is easier to see.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-Id: <20170322144525.18964-2-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-opts-visitor.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
index 2238f8e..8e0dda5 100644
--- a/tests/test-opts-visitor.c
+++ b/tests/test-opts-visitor.c
@@ -247,6 +247,24 @@ test_opts_range_beyond(void)
     qemu_opts_del(opts);
 }
 
+static void
+test_opts_dict_unvisited(void)
+{
+    QemuOpts *opts;
+    Visitor *v;
+    UserDefOptions *userdef;
+
+    opts = qemu_opts_parse(qemu_find_opts("userdef"), "i64x=0,bogus=1", false,
+                           &error_abort);
+
+    v = opts_visitor_new(opts);
+    /* BUG: bogus should be diagnosed */
+    visit_type_UserDefOptions(v, NULL, &userdef, &error_abort);
+    visit_free(v);
+    qemu_opts_del(opts);
+    qapi_free_UserDefOptions(userdef);
+}
+
 int
 main(int argc, char **argv)
 {
@@ -343,6 +361,8 @@ main(int argc, char **argv)
     g_test_add_func("/visitor/opts/range/beyond",
                     test_opts_range_beyond);
 
+    g_test_add_func("/visitor/opts/dict/unvisited", test_opts_dict_unvisited);
+
     g_test_run();
     return 0;
 }
-- 
2.7.4
