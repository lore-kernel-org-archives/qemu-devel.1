Received: from eggs.gnu.org ([2001:4830:134:3::10]:42244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTsv9-0005Qi-CU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTsv6-0005uP-Fi
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTsv6-0005sd-Aq
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:08 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BA36C05FBCD
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:17:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 18 Jan 2017 10:16:50 -0600
Message-Id: <20170118161653.19296-4-eblake@redhat.com>
In-Reply-To: <20170118161653.19296-1-eblake@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] qlist: Add convenience helpers for
 wrapped appends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Similar to the qdict additions of the previous patch, although
this time there are not as many clients.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qlist.h |  8 ++++++++
 tests/check-qdict.c      | 10 +++++-----
 tests/check-qlist.c      |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index a84117e..659325a 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -29,6 +29,14 @@ typedef struct QList {
 #define qlist_append(qlist, obj) \
         qlist_append_obj(qlist, QOBJECT(obj))

+/* Helpers for int, bool, and const char*. */
+#define qlist_append_int(qlist, value) \
+        qlist_append(qlist, qint_from_int(value))
+#define qlist_append_bool(qlist, value) \
+        qlist_append(qlist, qbool_from_bool(value))
+#define qlist_append_str(qlist, value) \
+        qlist_append(qlist, qstring_from_str(value))
+
 #define QLIST_FOREACH_ENTRY(qlist, var)             \
         for ((var) = ((qlist)->head.tqh_first);     \
             (var);                                  \
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index d00b411..6d4f8a7 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -297,11 +297,11 @@ static void qdict_flatten_test(void)
     qdict_put_int(dict1, "a", 0);
     qdict_put_int(dict1, "b", 1);

-    qlist_append_obj(list1, QOBJECT(qint_from_int(23)));
-    qlist_append_obj(list1, QOBJECT(qint_from_int(66)));
-    qlist_append_obj(list1, QOBJECT(dict1));
-    qlist_append_obj(list2, QOBJECT(qint_from_int(42)));
-    qlist_append_obj(list2, QOBJECT(list1));
+    qlist_append_int(list1, 23);
+    qlist_append_int(list1, 66);
+    qlist_append(list1, dict1);
+    qlist_append_int(list2, 42);
+    qlist_append(list2, list1);

     qdict_put_int(dict2, "c", 2);
     qdict_put_int(dict2, "d", 3);
diff --git a/tests/check-qlist.c b/tests/check-qlist.c
index e16da5e..38463f1 100644
--- a/tests/check-qlist.c
+++ b/tests/check-qlist.c
@@ -74,7 +74,7 @@ static void qlist_destroy_test(void)
     qlist = qlist_new();

     for (i = 0; i < 42; i++)
-        qlist_append(qlist, qint_from_int(i));
+        qlist_append_int(qlist, i);

     QDECREF(qlist);
 }
-- 
2.9.3
