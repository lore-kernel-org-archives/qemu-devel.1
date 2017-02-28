Received: from eggs.gnu.org ([2001:4830:134:3::10]:33690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDw-00058W-4a
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDu-0000bX-3Y
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDt-0000Zw-MJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:21 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD4FF3B731
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SMQK6l026291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:26:21 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:26:10 +0100
Message-Id: <1488320775-9849-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 19/24] keyval: Restrict key components to valid
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

Restricting the key components to something sane leaves us room for
evolving key syntax.  Since they will be commonly used as QAPI member
names by the QObject input visitor, we can just as well borrow the
QAPI naming rules here.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-20-git-send-email-armbru@redhat.com>
---
 tests/test-keyval.c | 10 ++++++++++
 util/keyval.c       | 12 ++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 1c2aeea..efe27cd 100644
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
index 990126f..29a6368 100644
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
@@ -118,6 +120,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
     size_t len;
     char key_in_cur[128];
     QDict *cur;
+    int ret;
     QObject *next;
     QString *val;
 
@@ -137,9 +140,10 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
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
