Received: from eggs.gnu.org ([2001:4830:134:3::10]:52709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkNB-0007uh-7M
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN8-0001Nj-R8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:37 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 18:48:28 +0100
Message-Id: <1490204908-26567-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1490204908-26567-1-git-send-email-armbru@redhat.com>
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 for-2.9 17/17] qapi: Fix QemuOpts visitor
 regression on unvisited input
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

An off-by-one in commit 15c2f669e meant that we were failing to
check for unparsed input in all QemuOpts visitors.  Recent testsuite
additions show that fixing the obvious bug with bogus fields will
also fix the case of an incomplete list visit; update the tests to
match the new behavior.

Simple testcase:

./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio -numa node,size=1g

failed to diagnose that 'size' is not a valid argument to -numa, and
now once again reports:

qemu-system-x86_64: -numa node,size=1g: Invalid parameter 'size'

See also https://bugzilla.redhat.com/show_bug.cgi?id=1434666

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170322144525.18964-4-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Fixup squashed in]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/opts-visitor.c       |  6 +++---
 qom/object_interfaces.c   |  1 +
 tests/test-opts-visitor.c | 13 ++++++++-----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 026d25b..324b197 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -164,7 +164,7 @@ opts_check_struct(Visitor *v, Error **errp)
     GHashTableIter iter;
     GQueue *any;
 
-    if (ov->depth > 0) {
+    if (ov->depth > 1) {
         return;
     }
 
@@ -276,8 +276,8 @@ static void
 opts_check_list(Visitor *v, Error **errp)
 {
     /*
-     * FIXME should set error when unvisited elements remain.  Mostly
-     * harmless, as the generated visits always visit all elements.
+     * Unvisited list elements will be reported later when checking
+     * whether unvisited struct members remain.
      */
 }
 
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index cc9a694..9c271ad 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -122,6 +122,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
     }
     if (!id) {
         error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        g_free(type);
         return NULL;
     }
 
diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
index 8e0dda5..23e8970 100644
--- a/tests/test-opts-visitor.c
+++ b/tests/test-opts-visitor.c
@@ -175,6 +175,7 @@ expect_u64_max(OptsVisitorFixture *f, gconstpointer test_data)
 static void
 test_opts_range_unvisited(void)
 {
+    Error *err = NULL;
     intList *list = NULL;
     intList *tail;
     QemuOpts *opts;
@@ -199,10 +200,11 @@ test_opts_range_unvisited(void)
     g_assert_cmpint(tail->value, ==, 1);
     tail = (intList *)visit_next_list(v, (GenericList *)tail, sizeof(*list));
     g_assert(tail);
-    visit_check_list(v, &error_abort); /* BUG: unvisited tail not reported */
+    visit_check_list(v, &error_abort); /* unvisited tail ignored until... */
     visit_end_list(v, (void **)&list);
 
-    visit_check_struct(v, &error_abort);
+    visit_check_struct(v, &err); /* ...here */
+    error_free_or_abort(&err);
     visit_end_struct(v, NULL);
 
     qapi_free_intList(list);
@@ -250,6 +252,7 @@ test_opts_range_beyond(void)
 static void
 test_opts_dict_unvisited(void)
 {
+    Error *err = NULL;
     QemuOpts *opts;
     Visitor *v;
     UserDefOptions *userdef;
@@ -258,11 +261,11 @@ test_opts_dict_unvisited(void)
                            &error_abort);
 
     v = opts_visitor_new(opts);
-    /* BUG: bogus should be diagnosed */
-    visit_type_UserDefOptions(v, NULL, &userdef, &error_abort);
+    visit_type_UserDefOptions(v, NULL, &userdef, &err);
+    error_free_or_abort(&err);
     visit_free(v);
     qemu_opts_del(opts);
-    qapi_free_UserDefOptions(userdef);
+    g_assert(!userdef);
 }
 
 int
-- 
2.7.4
