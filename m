Received: from eggs.gnu.org ([2001:4830:134:3::10]:41296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Ki-0007gE-TV
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Kh-0006hY-QM
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cX3Kh-0006hE-Fa
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:39 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76DE7C009A08
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 10:00:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 27 Jan 2017 10:00:27 +0000
Message-Id: <20170127100029.11356-3-stefanha@redhat.com>
In-Reply-To: <20170127100029.11356-1-stefanha@redhat.com>
References: <20170127100029.11356-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] block/gluster: drop intermediate
 ListElement struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The "qemu/queue.h" data structures are used without intermediate list
node structs.  They are designed to be embedded in the main struct.
Drop the unnecessary ListElement struct.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/gluster.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 516a1e1..171a323 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -56,19 +56,14 @@ typedef struct BDRVGlusterReopenState {
     struct glfs_fd *fd;
 } BDRVGlusterReopenState;
 
-
 typedef struct GlfsPreopened {
     char *volume;
     glfs_t *fs;
     int ref;
+    QLIST_ENTRY(GlfsPreopened) list;
 } GlfsPreopened;
 
-typedef struct ListElement {
-    QLIST_ENTRY(ListElement) list;
-    GlfsPreopened saved;
-} ListElement;
-
-static QLIST_HEAD(glfs_list, ListElement) glfs_list;
+static QLIST_HEAD(glfs_list, GlfsPreopened) glfs_list;
 
 static QemuOptsList qemu_gluster_create_opts = {
     .name = "qemu-gluster-create-opts",
@@ -210,26 +205,26 @@ static QemuOptsList runtime_tcp_opts = {
 
 static void glfs_set_preopened(const char *volume, glfs_t *fs)
 {
-    ListElement *entry = NULL;
+    GlfsPreopened *entry = NULL;
 
-    entry = g_new(ListElement, 1);
+    entry = g_new(GlfsPreopened, 1);
 
-    entry->saved.volume = g_strdup(volume);
+    entry->volume = g_strdup(volume);
 
-    entry->saved.fs = fs;
-    entry->saved.ref = 1;
+    entry->fs = fs;
+    entry->ref = 1;
 
     QLIST_INSERT_HEAD(&glfs_list, entry, list);
 }
 
 static glfs_t *glfs_find_preopened(const char *volume)
 {
-    ListElement *entry = NULL;
+    GlfsPreopened *entry = NULL;
 
     QLIST_FOREACH(entry, &glfs_list, list) {
-        if (strcmp(entry->saved.volume, volume) == 0) {
-            entry->saved.ref++;
-            return entry->saved.fs;
+        if (strcmp(entry->volume, volume) == 0) {
+            entry->ref++;
+            return entry->fs;
         }
     }
 
@@ -238,23 +233,23 @@ static glfs_t *glfs_find_preopened(const char *volume)
 
 static void glfs_clear_preopened(glfs_t *fs)
 {
-    ListElement *entry = NULL;
-    ListElement *next;
+    GlfsPreopened *entry = NULL;
+    GlfsPreopened *next;
 
     if (fs == NULL) {
         return;
     }
 
     QLIST_FOREACH_SAFE(entry, &glfs_list, list, next) {
-        if (entry->saved.fs == fs) {
-            if (--entry->saved.ref) {
+        if (entry->fs == fs) {
+            if (--entry->ref) {
                 return;
             }
 
             QLIST_REMOVE(entry, list);
 
-            glfs_fini(entry->saved.fs);
-            g_free(entry->saved.volume);
+            glfs_fini(entry->fs);
+            g_free(entry->volume);
             g_free(entry);
         }
     }
-- 
2.9.3
