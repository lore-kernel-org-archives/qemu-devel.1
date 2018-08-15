Received: from eggs.gnu.org ([2001:4830:134:3::10]:52280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLk-0004kY-Dr
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLe-0001LD-2r
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:32 +0200
Message-Id: <20180815125537.10651-17-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/21] qdict: Make qdict_extract_subqdict()
 accept dst = NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This function extracts all options from a QDict starting with a
certain prefix and puts them in a new QDict.

We'll have a couple of cases where we simply want to discard those
options instead of copying them, and that's what this patch does.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qobject/block-qdict.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 80c653013f..42054cc274 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -158,20 +158,25 @@ void qdict_flatten(QDict *qdict)
     qdict_flatten_qdict(qdict, qdict, NULL);
 }
 
-/* extract all the src QDict entries starting by start into dst */
+/* extract all the src QDict entries starting by start into dst.
+ * If dst is NULL then the entries are simply removed from src. */
 void qdict_extract_subqdict(QDict *src, QDict **dst, const char *start)
 
 {
     const QDictEntry *entry, *next;
     const char *p;
 
-    *dst = qdict_new();
+    if (dst) {
+        *dst = qdict_new();
+    }
     entry = qdict_first(src);
 
     while (entry != NULL) {
         next = qdict_next(src, entry);
         if (strstart(entry->key, start, &p)) {
-            qdict_put_obj(*dst, p, qobject_ref(entry->value));
+            if (dst) {
+                qdict_put_obj(*dst, p, qobject_ref(entry->value));
+            }
             qdict_del(src, entry->key);
         }
         entry = next;
-- 
2.13.6
