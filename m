Received: from eggs.gnu.org ([2001:4830:134:3::10]:44465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqs-00004v-2c
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqr-0005L5-4e
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 13:55:44 +0100
Message-Id: <1490014548-15083-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-1-git-send-email-armbru@redhat.com>
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 1/5] test-keyval: Tweaks to improve
 list coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com

We have a negative test case for a list index with leading zero.  Add
positive ones.

Tweak the test case for list index greater or equal the number of
elements: test "equal" instead of "greater" to guard against
off-by-one mistakes.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-keyval.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 71288b0..e97f6d5 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -218,14 +218,14 @@ static void test_keyval_parse_list(void)
     QDECREF(qdict);
 
     /* Multiple indexes, last one wins */
-    qdict = keyval_parse("list.1=goner,list.0=null,list.1=eins,list.2=zwei",
+    qdict = keyval_parse("list.1=goner,list.0=null,list.01=eins,list.2=zwei",
                          NULL, &error_abort);
     g_assert_cmpint(qdict_size(qdict), ==, 1);
     check_list012(qdict_get_qlist(qdict, "list"));
     QDECREF(qdict);
 
     /* List at deeper nesting */
-    qdict = keyval_parse("a.list.1=eins,a.list.0=null,a.list.2=zwei",
+    qdict = keyval_parse("a.list.1=eins,a.list.00=null,a.list.2=zwei",
                          NULL, &error_abort);
     g_assert_cmpint(qdict_size(qdict), ==, 1);
     sub_qdict = qdict_get_qdict(qdict, "a");
@@ -242,7 +242,7 @@ static void test_keyval_parse_list(void)
     g_assert(!qdict);
 
     /* Missing list indexes */
-    qdict = keyval_parse("list.2=lonely", NULL, &err);
+    qdict = keyval_parse("list.1=lonely", NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
     qdict = keyval_parse("list.0=null,list.2=eins,list.02=zwei", NULL, &err);
-- 
2.7.4
