Received: from eggs.gnu.org ([209.51.188.92]:60912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj5CT-0002Ai-8U
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj5CO-00022r-IX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 14 Jan 2019 16:34:16 +0000
Message-Id: <20190114163416.1094-3-stefanha@redhat.com>
In-Reply-To: <20190114163416.1094-1-stefanha@redhat.com>
References: <20190114163416.1094-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] aio-posix: Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Remy Noel <remy.noel@blade-group.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Remy Noel <remy.noel@blade-group.com>

It is possible for an io_poll callback to be concurrently executed along
with an aio_set_fd_handlers. This can cause all sorts of problems, like
a NULL callback or a bad opaque pointer.

This changes set_fd_handlers so that it no longer modify existing handler=
s
entries and instead, always insert those after having proper initialisati=
on.

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Remy Noel <remy.noel@blade-group.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20181220152030.28035-3-remy.noel@blade-group.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 89 ++++++++++++++++++++++++++++--------------------
 util/aio-win32.c | 67 ++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 74 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index a927319d2c..8640dfde9f 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -200,6 +200,31 @@ static AioHandler *find_aio_handler(AioContext *ctx,=
 int fd)
     return NULL;
 }
=20
+static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
+{
+    /* If the GSource is in the process of being destroyed then
+     * g_source_remove_poll() causes an assertion failure.  Skip
+     * removal in that case, because glib cleans up its state during
+     * destruction anyway.
+     */
+    if (!g_source_is_destroyed(&ctx->source)) {
+        g_source_remove_poll(&ctx->source, &node->pfd);
+    }
+
+    /* If a read is in progress, just mark the node as deleted */
+    if (qemu_lockcnt_count(&ctx->list_lock)) {
+        node->deleted =3D 1;
+        node->pfd.revents =3D 0;
+        return false;
+    }
+    /* Otherwise, delete it for real.  We can't just mark it as
+     * deleted because deleted nodes are only cleaned up while
+     * no one is walking the handlers list.
+     */
+    QLIST_REMOVE(node, node);
+    return true;
+}
+
 void aio_set_fd_handler(AioContext *ctx,
                         int fd,
                         bool is_external,
@@ -209,6 +234,7 @@ void aio_set_fd_handler(AioContext *ctx,
                         void *opaque)
 {
     AioHandler *node;
+    AioHandler *new_node =3D NULL;
     bool is_new =3D false;
     bool deleted =3D false;
     int poll_disable_change;
@@ -223,28 +249,6 @@ void aio_set_fd_handler(AioContext *ctx,
             qemu_lockcnt_unlock(&ctx->list_lock);
             return;
         }
-
-        /* If the GSource is in the process of being destroyed then
-         * g_source_remove_poll() causes an assertion failure.  Skip
-         * removal in that case, because glib cleans up its state during
-         * destruction anyway.
-         */
-        if (!g_source_is_destroyed(&ctx->source)) {
-            g_source_remove_poll(&ctx->source, &node->pfd);
-        }
-
-        /* If a read is in progress, just mark the node as deleted */
-        if (qemu_lockcnt_count(&ctx->list_lock)) {
-            node->deleted =3D 1;
-            node->pfd.revents =3D 0;
-        } else {
-            /* Otherwise, delete it for real.  We can't just mark it as
-             * deleted because deleted nodes are only cleaned up while
-             * no one is walking the handlers list.
-             */
-            QLIST_REMOVE(node, node);
-            deleted =3D true;
-        }
         /* Clean events in order to unregister fd from the ctx epoll. */
         node->pfd.events =3D 0;
=20
@@ -252,24 +256,32 @@ void aio_set_fd_handler(AioContext *ctx,
     } else {
         poll_disable_change =3D !io_poll - (node && !node->io_poll);
         if (node =3D=3D NULL) {
-            /* Alloc and insert if it's not already there */
-            node =3D g_new0(AioHandler, 1);
-            node->pfd.fd =3D fd;
-            QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
-
-            g_source_add_poll(&ctx->source, &node->pfd);
             is_new =3D true;
         }
+        /* Alloc and insert if it's not already there */
+        new_node =3D g_new0(AioHandler, 1);
=20
         /* Update handler with latest information */
-        node->io_read =3D io_read;
-        node->io_write =3D io_write;
-        node->io_poll =3D io_poll;
-        node->opaque =3D opaque;
-        node->is_external =3D is_external;
+        new_node->io_read =3D io_read;
+        new_node->io_write =3D io_write;
+        new_node->io_poll =3D io_poll;
+        new_node->opaque =3D opaque;
+        new_node->is_external =3D is_external;
=20
-        node->pfd.events =3D (io_read ? G_IO_IN | G_IO_HUP | G_IO_ERR : =
0);
-        node->pfd.events |=3D (io_write ? G_IO_OUT | G_IO_ERR : 0);
+        if (is_new) {
+            new_node->pfd.fd =3D fd;
+        } else {
+            new_node->pfd =3D node->pfd;
+        }
+        g_source_add_poll(&ctx->source, &new_node->pfd);
+
+        new_node->pfd.events =3D (io_read ? G_IO_IN | G_IO_HUP | G_IO_ER=
R : 0);
+        new_node->pfd.events |=3D (io_write ? G_IO_OUT | G_IO_ERR : 0);
+
+        QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, new_node, node);
+    }
+    if (node) {
+        deleted =3D aio_remove_fd_handler(ctx, node);
     }
=20
     /* No need to order poll_disable_cnt writes against other updates;
@@ -281,7 +293,12 @@ void aio_set_fd_handler(AioContext *ctx,
     atomic_set(&ctx->poll_disable_cnt,
                atomic_read(&ctx->poll_disable_cnt) + poll_disable_change=
);
=20
-    aio_epoll_update(ctx, node, is_new);
+    if (new_node) {
+        aio_epoll_update(ctx, new_node, is_new);
+    } else if (node) {
+        /* Unregister deleted fd_handler */
+        aio_epoll_update(ctx, node, false);
+    }
     qemu_lockcnt_unlock(&ctx->list_lock);
     aio_notify(ctx);
=20
diff --git a/util/aio-win32.c b/util/aio-win32.c
index c58957cc4b..a23b9c364d 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -35,6 +35,22 @@ struct AioHandler {
     QLIST_ENTRY(AioHandler) node;
 };
=20
+static void aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
+{
+    /* If aio_poll is in progress, just mark the node as deleted */
+    if (qemu_lockcnt_count(&ctx->list_lock)) {
+        node->deleted =3D 1;
+        node->pfd.revents =3D 0;
+    } else {
+        /* Otherwise, delete it for real.  We can't just mark it as
+         * deleted because deleted nodes are only cleaned up after
+         * releasing the list_lock.
+         */
+        QLIST_REMOVE(node, node);
+        g_free(node);
+    }
+}
+
 void aio_set_fd_handler(AioContext *ctx,
                         int fd,
                         bool is_external,
@@ -44,41 +60,23 @@ void aio_set_fd_handler(AioContext *ctx,
                         void *opaque)
 {
     /* fd is a SOCKET in our case */
-    AioHandler *node;
+    AioHandler *old_node;
+    AioHandler *node =3D NULL;
=20
     qemu_lockcnt_lock(&ctx->list_lock);
-    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
-        if (node->pfd.fd =3D=3D fd && !node->deleted) {
+    QLIST_FOREACH(old_node, &ctx->aio_handlers, node) {
+        if (old_node->pfd.fd =3D=3D fd && !old_node->deleted) {
             break;
         }
     }
=20
-    /* Are we deleting the fd handler? */
-    if (!io_read && !io_write) {
-        if (node) {
-            /* If aio_poll is in progress, just mark the node as deleted=
 */
-            if (qemu_lockcnt_count(&ctx->list_lock)) {
-                node->deleted =3D 1;
-                node->pfd.revents =3D 0;
-            } else {
-                /* Otherwise, delete it for real.  We can't just mark it=
 as
-                 * deleted because deleted nodes are only cleaned up aft=
er
-                 * releasing the list_lock.
-                 */
-                QLIST_REMOVE(node, node);
-                g_free(node);
-            }
-        }
-    } else {
+    if (io_read || io_write) {
         HANDLE event;
         long bitmask =3D 0;
=20
-        if (node =3D=3D NULL) {
-            /* Alloc and insert if it's not already there */
-            node =3D g_new0(AioHandler, 1);
-            node->pfd.fd =3D fd;
-            QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
-        }
+        /* Alloc and insert if it's not already there */
+        node =3D g_new0(AioHandler, 1);
+        node->pfd.fd =3D fd;
=20
         node->pfd.events =3D 0;
         if (node->io_read) {
@@ -104,9 +102,13 @@ void aio_set_fd_handler(AioContext *ctx,
             bitmask |=3D FD_WRITE | FD_CONNECT;
         }
=20
+        QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
         event =3D event_notifier_get_handle(&ctx->notifier);
         WSAEventSelect(node->pfd.fd, event, bitmask);
     }
+    if (old_node) {
+        aio_remove_fd_handler(ctx, old_node);
+    }
=20
     qemu_lockcnt_unlock(&ctx->list_lock);
     aio_notify(ctx);
@@ -139,18 +141,7 @@ void aio_set_event_notifier(AioContext *ctx,
         if (node) {
             g_source_remove_poll(&ctx->source, &node->pfd);
=20
-            /* aio_poll is in progress, just mark the node as deleted */
-            if (qemu_lockcnt_count(&ctx->list_lock)) {
-                node->deleted =3D 1;
-                node->pfd.revents =3D 0;
-            } else {
-                /* Otherwise, delete it for real.  We can't just mark it=
 as
-                 * deleted because deleted nodes are only cleaned up aft=
er
-                 * releasing the list_lock.
-                 */
-                QLIST_REMOVE(node, node);
-                g_free(node);
-            }
+            aio_remove_fd_handler(ctx, node);
         }
     } else {
         if (node =3D=3D NULL) {
--=20
2.20.1
