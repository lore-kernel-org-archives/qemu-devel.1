Received: from eggs.gnu.org ([2001:4830:134:3::10]:59790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNb-0003bl-51
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNa-0006nu-D0
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 18:55:24 +0200
Message-Id: <20180509165530.29561-8-mreitz@redhat.com>
In-Reply-To: <20180509165530.29561-1-mreitz@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 07/13] qdict: Add qdict_stringify_for_keyval()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

The purpose of this function is to prepare a QDict for consumption by
the keyval visitor, which only accepts strings and QNull.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/qdict.h |  2 ++
 qobject/qdict.c       | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/block/qdict.h b/include/block/qdict.h
index 825e096a72..05a24677b5 100644
--- a/include/block/qdict.h
+++ b/include/block/qdict.h
@@ -32,4 +32,6 @@ typedef struct QDictRenames {
 } QDictRenames;
 bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp);
 
+void qdict_stringify_for_keyval(QDict *qdict);
+
 #endif
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 0554c64553..83678c4951 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -1087,3 +1087,60 @@ bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp)
     }
     return true;
 }
+
+/**
+ * Convert all values in a QDict so it can be consumed by the keyval
+ * input visitor.  QNull values are left as-is, all other values are
+ * converted to strings.
+ *
+ * @qdict must be flattened, i.e. it may not contain any nested QDicts
+ * or QLists.
+ */
+void qdict_stringify_for_keyval(QDict *qdict)
+{
+    const QDictEntry *e;
+
+    for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
+        QString *new_value = NULL;
+
+        switch (qobject_type(e->value)) {
+        case QTYPE_QNULL:
+            /* leave as-is */
+            break;
+
+        case QTYPE_QNUM: {
+            char *str = qnum_to_string(qobject_to(QNum, e->value));
+            new_value = qstring_from_str(str);
+            g_free(str);
+            break;
+        }
+
+        case QTYPE_QSTRING:
+            /* leave as-is */
+            break;
+
+        case QTYPE_QDICT:
+        case QTYPE_QLIST:
+            /* @qdict must be flattened */
+            abort();
+
+        case QTYPE_QBOOL:
+            if (qbool_get_bool(qobject_to(QBool, e->value))) {
+                new_value = qstring_from_str("on");
+            } else {
+                new_value = qstring_from_str("off");
+            }
+            break;
+
+        case QTYPE_NONE:
+        case QTYPE__MAX:
+            abort();
+        }
+
+        if (new_value) {
+            QDictEntry *mut_e = (QDictEntry *)e;
+            qobject_unref(mut_e->value);
+            mut_e->value = QOBJECT(new_value);
+        }
+    }
+}
-- 
2.14.3
