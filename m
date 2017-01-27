Received: from eggs.gnu.org ([2001:4830:134:3::10]:41319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Km-0007jJ-9l
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Kl-0006iW-3u
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cX3Kk-0006iA-JF
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0AD2C04D31A
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 10:00:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 27 Jan 2017 10:00:28 +0000
Message-Id: <20170127100029.11356-4-stefanha@redhat.com>
In-Reply-To: <20170127100029.11356-1-stefanha@redhat.com>
References: <20170127100029.11356-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] block/gluster: use conventional names for
 GlfsPreopened functions
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

The naming of GlfsPreopened functions is a little unusual:

glfs_set_preopened() appends items to the list.  Normally this operation
is called "add".

glfs_find_preopened() is paired with glfs_clear_preopened().  Normally
this is called "get" and "put" (or "ref" and "unref").

This patch renames these functions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/gluster.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 171a323..181b345 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -203,7 +203,7 @@ static QemuOptsList runtime_tcp_opts = {
     },
 };
 
-static void glfs_set_preopened(const char *volume, glfs_t *fs)
+static void glfs_add_preopened(const char *volume, glfs_t *fs)
 {
     GlfsPreopened *entry = NULL;
 
@@ -217,7 +217,7 @@ static void glfs_set_preopened(const char *volume, glfs_t *fs)
     QLIST_INSERT_HEAD(&glfs_list, entry, list);
 }
 
-static glfs_t *glfs_find_preopened(const char *volume)
+static glfs_t *glfs_get_preopened(const char *volume)
 {
     GlfsPreopened *entry = NULL;
 
@@ -231,7 +231,7 @@ static glfs_t *glfs_find_preopened(const char *volume)
     return NULL;
 }
 
-static void glfs_clear_preopened(glfs_t *fs)
+static void glfs_put_preopened(glfs_t *fs)
 {
     GlfsPreopened *entry = NULL;
     GlfsPreopened *next;
@@ -393,7 +393,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
     GlusterServerList *server;
     unsigned long long port;
 
-    glfs = glfs_find_preopened(gconf->volume);
+    glfs = glfs_get_preopened(gconf->volume);
     if (glfs) {
         return glfs;
     }
@@ -403,7 +403,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
         goto out;
     }
 
-    glfs_set_preopened(gconf->volume, glfs);
+    glfs_add_preopened(gconf->volume, glfs);
 
     for (server = gconf->server; server; server = server->next) {
         if (server->value->type  == GLUSTER_TRANSPORT_UNIX) {
@@ -463,7 +463,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
 out:
     if (glfs) {
         old_errno = errno;
-        glfs_clear_preopened(glfs);
+        glfs_put_preopened(glfs);
         errno = old_errno;
     }
     return NULL;
@@ -844,7 +844,7 @@ out:
         glfs_close(s->fd);
     }
 
-    glfs_clear_preopened(s->glfs);
+    glfs_put_preopened(s->glfs);
 
     return ret;
 }
@@ -913,7 +913,7 @@ static void qemu_gluster_reopen_commit(BDRVReopenState *state)
         glfs_close(s->fd);
     }
 
-    glfs_clear_preopened(s->glfs);
+    glfs_put_preopened(s->glfs);
 
     /* use the newly opened image / connection */
     s->fd         = reop_s->fd;
@@ -938,7 +938,7 @@ static void qemu_gluster_reopen_abort(BDRVReopenState *state)
         glfs_close(reop_s->fd);
     }
 
-    glfs_clear_preopened(reop_s->glfs);
+    glfs_put_preopened(reop_s->glfs);
 
     g_free(state->opaque);
     state->opaque = NULL;
@@ -1062,7 +1062,7 @@ static int qemu_gluster_create(const char *filename,
 out:
     g_free(tmp);
     qapi_free_BlockdevOptionsGluster(gconf);
-    glfs_clear_preopened(glfs);
+    glfs_put_preopened(glfs);
     return ret;
 }
 
@@ -1135,7 +1135,7 @@ static void qemu_gluster_close(BlockDriverState *bs)
         glfs_close(s->fd);
         s->fd = NULL;
     }
-    glfs_clear_preopened(s->glfs);
+    glfs_put_preopened(s->glfs);
 }
 
 static coroutine_fn int qemu_gluster_co_flush_to_disk(BlockDriverState *bs)
-- 
2.9.3
