Received: from eggs.gnu.org ([2001:4830:134:3::10]:52820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXiz6-0003Uw-9X
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXiz5-0007tr-BC
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:05:56 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 26 Jun 2018 10:05:45 +0200
Message-Id: <20180626080546.3626-2-armbru@redhat.com>
In-Reply-To: <20180626080546.3626-1-armbru@redhat.com>
References: <20180626080546.3626-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block-qdict: Pacify Coverity after commit
 f1b34a248e9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Commit f1b34a248e9 replaced less-than-obvious test in
qdict_flatten_qdict() by the obvious one.  Sadly, it made something
else non-obvious: the fact that @new_key passed to qdict_put_obj()
can't be null, because that depends on the function's precondition
(target == qdict) == !prefix.

Tweak the function some more to help Coverity and human readers alike.

Fixes: CID 1393620
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/block-qdict.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 36129e7379..80c653013f 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -97,7 +97,7 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
     const QDictEntry *entry, *next;
     QDict *dict_val;
     QList *list_val;
-    char *new_key;
+    char *key, *new_key;
 
     entry = qdict_first(qdict);
 
@@ -106,10 +106,12 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
         value = qdict_entry_value(entry);
         dict_val = qobject_to(QDict, value);
         list_val = qobject_to(QList, value);
-        new_key = NULL;
 
         if (prefix) {
-            new_key = g_strdup_printf("%s.%s", prefix, entry->key);
+            key = new_key = g_strdup_printf("%s.%s", prefix, entry->key);
+        } else {
+            key = entry->key;
+            new_key = NULL;
         }
 
         /*
@@ -125,19 +127,17 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
          * well advised not to modify them altogether.)
          */
         if (dict_val && qdict_size(dict_val)) {
-            qdict_flatten_qdict(dict_val, target,
-                                new_key ? new_key : entry->key);
+            qdict_flatten_qdict(dict_val, target, key);
             if (target == qdict) {
                 qdict_del(qdict, entry->key);
             }
         } else if (list_val && !qlist_empty(list_val)) {
-            qdict_flatten_qlist(list_val, target,
-                                new_key ? new_key : entry->key);
+            qdict_flatten_qlist(list_val, target, key);
             if (target == qdict) {
                 qdict_del(qdict, entry->key);
             }
         } else if (target != qdict) {
-            qdict_put_obj(target, new_key, qobject_ref(value));
+            qdict_put_obj(target, key, qobject_ref(value));
         }
 
         g_free(new_key);
-- 
2.17.1
