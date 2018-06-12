Received: from eggs.gnu.org ([2001:4830:134:3::10]:50197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisY-0007FP-Te
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisW-0003A2-Fd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 12 Jun 2018 14:58:14 +0200
Message-Id: <20180612125821.4229-12-armbru@redhat.com>
In-Reply-To: <20180612125821.4229-1-armbru@redhat.com>
References: <20180612125821.4229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 11/18] block-qdict: Tweak qdict_flatten_qdict(),
 qdict_flatten_qlist()
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

qdict_flatten_qdict() skips copying scalars from @qdict to @target
when the two are the same.  Fair enough, but it uses a non-obvious
test for "same".  Replace it by the obvious one.  While there, improve
comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/block-qdict.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index f32df343e8..a4e1c8d08f 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -71,12 +71,15 @@ static void qdict_flatten_qlist(QList *qlist, QDict *target, const char *prefix)
         value = qlist_entry_obj(entry);
         new_key = g_strdup_printf("%s.%i", prefix, i);
 
+        /*
+         * Flatten non-empty QDict and QList recursively into @target,
+         * copy other objects to @target
+         */
         if (qobject_type(value) == QTYPE_QDICT) {
             qdict_flatten_qdict(qobject_to(QDict, value), target, new_key);
         } else if (qobject_type(value) == QTYPE_QLIST) {
             qdict_flatten_qlist(qobject_to(QList, value), target, new_key);
         } else {
-            /* All other types are moved to the target unchanged. */
             qdict_put_obj(target, new_key, qobject_ref(value));
         }
 
@@ -101,9 +104,11 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
             new_key = g_strdup_printf("%s.%s", prefix, entry->key);
         }
 
+        /*
+         * Flatten non-empty QDict and QList recursively into @target,
+         * copy other objects to @target
+         */
         if (qobject_type(value) == QTYPE_QDICT) {
-            /* Entries of QDicts are processed recursively, the QDict object
-             * itself disappears. */
             qdict_flatten_qdict(qobject_to(QDict, value), target,
                                 new_key ? new_key : entry->key);
             qdict_del(qdict, entry->key);
@@ -111,8 +116,7 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
             qdict_flatten_qlist(qobject_to(QList, value), target,
                                 new_key ? new_key : entry->key);
             qdict_del(qdict, entry->key);
-        } else if (prefix) {
-            /* All other objects are moved to the target unchanged. */
+        } else if (target != qdict) {
             qdict_put_obj(target, new_key, qobject_ref(value));
             qdict_del(qdict, entry->key);
         }
-- 
2.17.1
