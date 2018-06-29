Received: from eggs.gnu.org ([2001:4830:134:3::10]:41738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fYrjC-0001rp-67
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fYriz-0005HR-HF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:38:14 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 29 Jun 2018 14:36:59 +0300
Message-Id: <6d4bbe2a722855e10655f9f5ee1dbf4e94f62e59.1530270904.git.berto@igalia.com>
In-Reply-To: <cover.1530270904.git.berto@igalia.com>
References: <cover.1530270904.git.berto@igalia.com>
In-Reply-To: <cover.1530270904.git.berto@igalia.com>
References: <cover.1530270904.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/5] qdict: Make qdict_extract_subqdict()
 accept dst = NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

This function extracts all options from a QDict starting with a
certain prefix and puts them in a new QDict.

We'll have a couple of cases where we simply want to discard those
options instead of copying them, and that's what this patch does.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 qobject/block-qdict.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 36129e7379..ef443cb8d5 100644
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
2.11.0
