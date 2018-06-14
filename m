Received: from eggs.gnu.org ([2001:4830:134:3::10]:53424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhw-0001Zs-Pp
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhu-0001aC-Mp
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:14:56 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 21:14:35 +0200
Message-Id: <20180614191443.14361-11-armbru@redhat.com>
In-Reply-To: <20180614191443.14361-1-armbru@redhat.com>
References: <20180614191443.14361-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/18] block-qdict: Simplify
 qdict_flatten_qdict()
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

There's no need to restart the loop.  We don't elsewhere, e.g. in
qdict_extract_subqdict(), qdict_join() and qemu_opts_absorb_qdict().
Simplify accordingly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qobject/block-qdict.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 41f39abc4a..f32df343e8 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -89,16 +89,13 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
     QObject *value;
     const QDictEntry *entry, *next;
     char *new_key;
-    bool delete;
 
     entry = qdict_first(qdict);
 
     while (entry != NULL) {
-
         next = qdict_next(qdict, entry);
         value = qdict_entry_value(entry);
         new_key = NULL;
-        delete = false;
 
         if (prefix) {
             new_key = g_strdup_printf("%s.%s", prefix, entry->key);
@@ -109,27 +106,18 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
              * itself disappears. */
             qdict_flatten_qdict(qobject_to(QDict, value), target,
                                 new_key ? new_key : entry->key);
-            delete = true;
+            qdict_del(qdict, entry->key);
         } else if (qobject_type(value) == QTYPE_QLIST) {
             qdict_flatten_qlist(qobject_to(QList, value), target,
                                 new_key ? new_key : entry->key);
-            delete = true;
+            qdict_del(qdict, entry->key);
         } else if (prefix) {
             /* All other objects are moved to the target unchanged. */
             qdict_put_obj(target, new_key, qobject_ref(value));
-            delete = true;
-        }
-
-        g_free(new_key);
-
-        if (delete) {
             qdict_del(qdict, entry->key);
-
-            /* Restart loop after modifying the iterated QDict */
-            entry = qdict_first(qdict);
-            continue;
         }
 
+        g_free(new_key);
         entry = next;
     }
 }
-- 
2.17.1
