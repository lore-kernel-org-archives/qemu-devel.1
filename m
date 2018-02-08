Received: from eggs.gnu.org ([2001:4830:134:3::10]:57747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejro2-00032w-DW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejro1-00013M-I6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:24:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Feb 2018 20:23:10 +0100
Message-Id: <20180208192328.16550-10-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-1-kwolf@redhat.com>
References: <20180208192328.16550-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 09/27] qdict: Introduce qdict_rename_keys()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

A few block drivers will need to rename .bdrv_create options for their
QAPIfication, so let's have a helper function for that.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qapi/qmp/qdict.h |  6 ++++++
 qobject/qdict.c          | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index fc218e7be6..862441b9d3 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -90,4 +90,10 @@ QObject *qdict_crumple(const QDict *src, Error **errp);
 
 void qdict_join(QDict *dest, QDict *src, bool overwrite);
 
+typedef struct QDictRenames {
+    const char *from;
+    const char *to;
+} QDictRenames;
+bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp);
+
 #endif /* QDICT_H */
diff --git a/qobject/qdict.c b/qobject/qdict.c
index e8f15f1132..07ae9489a7 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -1051,3 +1051,33 @@ void qdict_join(QDict *dest, QDict *src, bool overwrite)
         entry = next;
     }
 }
+
+/**
+ * qdict_rename_keys(): Rename keys in qdict according to the replacements
+ * specified in the array renames. The array must be terminated by an entry
+ * with from = NULL.
+ *
+ * Returns true for success, false in error cases.
+ */
+bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp)
+{
+    QObject *qobj;
+
+    while (renames->from) {
+        if (qdict_haskey(qdict, renames->from)) {
+            if (qdict_haskey(qdict, renames->to)) {
+                error_setg(errp, "'%s' and its alias '%s' can't be used at the "
+                           "same time", renames->to, renames->from);
+                return false;
+            }
+
+            qobj = qdict_get(qdict, renames->from);
+            qobject_incref(qobj);
+            qdict_put_obj(qdict, renames->to, qobj);
+            qdict_del(qdict, renames->from);
+        }
+
+        renames++;
+    }
+    return true;
+}
-- 
2.13.6
