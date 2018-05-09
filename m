Received: from eggs.gnu.org ([2001:4830:134:3::10]:59857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNi-0003k3-Lv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNf-0006yj-OE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:58 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 18:55:26 +0200
Message-Id: <20180509165530.29561-10-mreitz@redhat.com>
In-Reply-To: <20180509165530.29561-1-mreitz@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 09/13] qdict: Make qdict_flatten()
 shallow-clone-friendly
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

In its current form, qdict_flatten() removes all entries from nested
QDicts that are moved to the root QDict.  It is completely sufficient to
remove all old entries from the root QDict, however.  If the nested
dicts have a refcount of 1, this will automatically delete them, too.
And if they have a greater refcount, we probably do not want to modify
them in the first place.

The latter observation means that it was currently (in general)
impossible to qdict_flatten() a shallowly cloned dict because that would
empty nested QDicts in the original dict as well.  This patch changes
this, so you can now use qdict_flatten(qdict_shallow_clone(dict)) to get
a flattened copy without disturbing the original.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qobject/qdict.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/qobject/qdict.c b/qobject/qdict.c
index 83678c4951..63dcb43e73 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -537,7 +537,7 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
     QObject *value;
     const QDictEntry *entry, *next;
     char *new_key;
-    bool delete;
+    bool copied_value;
 
     entry = qdict_first(qdict);
 
@@ -546,7 +546,7 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
         next = qdict_next(qdict, entry);
         value = qdict_entry_value(entry);
         new_key = NULL;
-        delete = false;
+        copied_value = false;
 
         if (prefix) {
             new_key = g_strdup_printf("%s.%s", prefix, entry->key);
@@ -557,23 +557,32 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
              * itself disappears. */
             qdict_flatten_qdict(qobject_to(QDict, value), target,
                                 new_key ? new_key : entry->key);
-            delete = true;
+            copied_value = true;
         } else if (qobject_type(value) == QTYPE_QLIST) {
             qdict_flatten_qlist(qobject_to(QList, value), target,
                                 new_key ? new_key : entry->key);
-            delete = true;
+            copied_value = true;
         } else if (prefix) {
             /* All other objects are moved to the target unchanged. */
             qdict_put_obj(target, new_key, qobject_ref(value));
-            delete = true;
+            copied_value = true;
         }
 
         g_free(new_key);
 
-        if (delete) {
+        if (copied_value && qdict == target) {
+            /* If we have copied a value, and if we are on the root
+             * level, we need to remove the old entry.  Otherwise, we
+             * do not, because by removing these entries on the root
+             * level, the reference counts of nested dicts and listed
+             * will be reduced automatically.  In fact, we probably do
+             * not want to modify nested dicts and lists with
+             * refcounts greater than 1 anyway. */
             qdict_del(qdict, entry->key);
 
-            /* Restart loop after modifying the iterated QDict */
+            /* Restart loop after modifying the iterated QDict.  We
+             * only need to do this if qdict == target, because
+             * otherwise copying the value did not affect qdict. */
             entry = qdict_first(qdict);
             continue;
         }
-- 
2.14.3
