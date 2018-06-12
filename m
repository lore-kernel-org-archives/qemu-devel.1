Received: from eggs.gnu.org ([2001:4830:134:3::10]:50261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisa-0007Hm-ED
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisX-0003Bm-Tz
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:32 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 12 Jun 2018 14:58:18 +0200
Message-Id: <20180612125821.4229-16-armbru@redhat.com>
In-Reply-To: <20180612125821.4229-1-armbru@redhat.com>
References: <20180612125821.4229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 15/18] check-block-qdict: Cover flattening of
 empty lists and dictionaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-block-qdict.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/check-block-qdict.c b/tests/check-block-qdict.c
index 29f58a2d3d..2da16f01a6 100644
--- a/tests/check-block-qdict.c
+++ b/tests/check-block-qdict.c
@@ -41,6 +41,8 @@ static void qdict_flatten_test(void)
     QList *e = qlist_new();
     QDict *e_1_2 = qdict_new();
     QDict *f = qdict_new();
+    QList *y = qlist_new();
+    QDict *z = qdict_new();
     QDict *root = qdict_new();
 
     /*
@@ -62,7 +64,9 @@ static void qdict_flatten_test(void)
      *         "c": 2,
      *         "d": 3,
      *     },
-     *     "g": 4
+     *     "g": 4,
+     *     "y": [{}],
+     *     "z": {"a": []}
      * }
      *
      * to
@@ -77,6 +81,8 @@ static void qdict_flatten_test(void)
      *     "f.d": 3,
      *     "g": 4
      * }
+     *
+     * Note that "y" and "z" get eaten.
      */
 
     qdict_put_int(e_1_2, "a", 0);
@@ -91,9 +97,15 @@ static void qdict_flatten_test(void)
     qdict_put_int(f, "c", 2);
     qdict_put_int(f, "d", 3);
 
+    qlist_append(y, qdict_new());
+
+    qdict_put(z, "a", qlist_new());
+
     qdict_put(root, "e", e);
     qdict_put(root, "f", f);
     qdict_put_int(root, "g", 4);
+    qdict_put(root, "y", y);
+    qdict_put(root, "z", z);
 
     qdict_flatten(root);
 
-- 
2.17.1
