Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhw-0001a7-Uy
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhu-0001a5-MH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:14:56 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 21:14:37 +0200
Message-Id: <20180614191443.14361-13-armbru@redhat.com>
In-Reply-To: <20180614191443.14361-1-armbru@redhat.com>
References: <20180614191443.14361-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/18] block-qdict: Clean up qdict_crumple()
 a bit
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

When you mix scalar and non-scalar keys, whether you get an "already
set as scalar" or an "already set as dict" error depends on qdict
iteration order.  Neither message makes much sense.  Replace by
""Cannot mix scalar and non-scalar keys".  This is similar to the
message we get for mixing list and non-list keys.

I find qdict_crumple()'s first loop hard to understand.  Rearrange it
and add a comment.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/block-qdict.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index a4e1c8d08f..36cf58acc8 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -403,7 +403,7 @@ static int qdict_is_list(QDict *maybe_list, Error **errp)
 QObject *qdict_crumple(const QDict *src, Error **errp)
 {
     const QDictEntry *ent;
-    QDict *two_level, *multi_level = NULL;
+    QDict *two_level, *multi_level = NULL, *child_dict;
     QObject *dst = NULL, *child;
     size_t i;
     char *prefix = NULL;
@@ -422,28 +422,28 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
         }
 
         qdict_split_flat_key(ent->key, &prefix, &suffix);
-
         child = qdict_get(two_level, prefix);
+        child_dict = qobject_to(QDict, child);
+
+        if (child) {
+            /*
+             * If @child_dict, then all previous keys with this prefix
+             * had a suffix.  If @suffix, this one has one as well,
+             * and we're good, else there's a clash.
+             */
+            if (!child_dict || !suffix) {
+                error_setg(errp, "Cannot mix scalar and non-scalar keys");
+                goto error;
+            }
+        }
+
         if (suffix) {
-            QDict *child_dict = qobject_to(QDict, child);
             if (!child_dict) {
-                if (child) {
-                    error_setg(errp, "Key %s prefix is already set as a scalar",
-                               prefix);
-                    goto error;
-                }
-
                 child_dict = qdict_new();
-                qdict_put_obj(two_level, prefix, QOBJECT(child_dict));
+                qdict_put(two_level, prefix, child_dict);
             }
-
             qdict_put_obj(child_dict, suffix, qobject_ref(ent->value));
         } else {
-            if (child) {
-                error_setg(errp, "Key %s prefix is already set as a dict",
-                           prefix);
-                goto error;
-            }
             qdict_put_obj(two_level, prefix, qobject_ref(ent->value));
         }
 
-- 
2.17.1
