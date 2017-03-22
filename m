Received: from eggs.gnu.org ([2001:4830:134:3::10]:38170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqhVz-00011r-US
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqhVz-0000TF-4l
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:45:32 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 22 Mar 2017 09:45:23 -0500
Message-Id: <20170322144525.18964-2-eblake@redhat.com>
In-Reply-To: <20170322144525.18964-1-eblake@redhat.com>
References: <20170322144525.18964-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] tests: Expose regression in QemuOpts
 visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, lvivier@redhat.com, qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

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

---
v2: s/FIXME/BUG/ in comment, enhance commit message
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
2.9.3
