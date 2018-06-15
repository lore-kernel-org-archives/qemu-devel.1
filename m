Received: from eggs.gnu.org ([2001:4830:134:3::10]:59049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbU-00060q-Do
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbT-0003eY-Bf
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:20:56 +0200
Message-Id: <20180615142108.27814-15-kwolf@redhat.com>
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/26] block-qdict: Simplify
 qdict_flatten_qdict()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

There's no need to restart the loop.  We don't elsewhere, e.g. in
qdict_extract_subqdict(), qdict_join() and qemu_opts_absorb_qdict().
Simplify accordingly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.6
