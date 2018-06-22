Received: from eggs.gnu.org ([2001:4830:134:3::10]:56706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO38-0000po-An
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO35-0000ID-5u
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWO34-0000HA-VN
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1761FA2C73
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 22 Jun 2018 17:32:21 +0200
Message-Id: <20180622153228.23594-4-armbru@redhat.com>
In-Reply-To: <20180622153228.23594-1-armbru@redhat.com>
References: <20180622153228.23594-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] qdict: Make qdict_flatten()
 shallow-clone-friendly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

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
Message-Id: <20180611205203.2624-7-mreitz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/block-qdict.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index df833083a7..36129e7379 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -114,19 +114,30 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
 
         /*
          * Flatten non-empty QDict and QList recursively into @target,
-         * copy other objects to @target
+         * copy other objects to @target.
+         * On the root level (if @qdict == @target), remove flattened
+         * nested QDicts and QLists from @qdict.
+         *
+         * (Note that we do not need to remove entries from nested
+         * dicts or lists.  Their reference count is decremented on
+         * the root level, so there are no leaks.  In fact, if they
+         * have a reference count greater than one, we are probably
+         * well advised not to modify them altogether.)
          */
         if (dict_val && qdict_size(dict_val)) {
             qdict_flatten_qdict(dict_val, target,
                                 new_key ? new_key : entry->key);
-            qdict_del(qdict, entry->key);
+            if (target == qdict) {
+                qdict_del(qdict, entry->key);
+            }
         } else if (list_val && !qlist_empty(list_val)) {
             qdict_flatten_qlist(list_val, target,
                                 new_key ? new_key : entry->key);
-            qdict_del(qdict, entry->key);
+            if (target == qdict) {
+                qdict_del(qdict, entry->key);
+            }
         } else if (target != qdict) {
             qdict_put_obj(target, new_key, qobject_ref(value));
-            qdict_del(qdict, entry->key);
         }
 
         g_free(new_key);
-- 
2.17.1
