Received: from eggs.gnu.org ([2001:4830:134:3::10]:39519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqAIQ-0001YZ-Hs
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqAIN-0000RR-Tt
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Mar 2017 22:17:05 -0500
Message-Id: <20170321031705.22291-3-eblake@redhat.com>
In-Reply-To: <20170321031705.22291-1-eblake@redhat.com>
References: <20170321031705.22291-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qapi: Fix QemuOpts visitor regression on
 unvisited input
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

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/opts-visitor.c       |  6 +++---
 tests/test-opts-visitor.c | 15 +++++++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 026d25b..b54da81 100644
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
+     * Unvisited list elements will be reported later when checking if
+     * unvisited struct members remain.
      */
 }

diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
index a47c344..1766919 100644
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
@@ -239,7 +241,7 @@ test_opts_range_beyond(void)
     error_free_or_abort(&err);
     visit_end_list(v, (void **)&list);

-    visit_check_struct(v, &error_abort);
+    visit_check_struct(v, &err);
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
-    /* FIXME: bogus should be diagnosed */
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
2.9.3
