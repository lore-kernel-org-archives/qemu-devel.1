Received: from eggs.gnu.org ([2001:4830:134:3::10]:33538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxA-0007vg-A6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtx9-0000dQ-9H
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:06:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtx9-0000dE-3Q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:06:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDAE287ABA
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:06:54 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:22 +0800
Message-Id: <20180228050633.7410-4-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 03/14] qio: introduce
 qio_channel_add_watch_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

It's a more powerful version of qio_channel_add_watch(), which supports
non-default gcontext.  It's stripped from the old one, then we have
g_source_get_id() to fetch the tag ID to keep the old interface.

Note that the new API will return a gsource, meanwhile keep a reference
of it so that callers need to unref them explicitly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel.h | 31 ++++++++++++++++++++++++++++---
 io/channel.c         | 24 +++++++++++++++++++-----
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 3995e243a3..36af5e58ae 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -620,20 +620,45 @@ GSource *qio_channel_create_watch(QIOChannel *ioc,
                                   GIOCondition condition);
 
 /**
- * qio_channel_add_watch:
+ * qio_channel_add_watch_full:
  * @ioc: the channel object
  * @condition: the I/O condition to monitor
  * @func: callback to invoke when the source becomes ready
  * @user_data: opaque data to pass to @func
  * @notify: callback to free @user_data
+ * @context: gcontext to bind the source to
  *
- * Create a new main loop source that is used to watch
+ * Create a new source that is used to watch
  * for the I/O condition @condition. The callback @func
  * will be registered against the source, to be invoked
  * when the source becomes ready. The optional @user_data
  * will be passed to @func when it is invoked. The @notify
  * callback will be used to free @user_data when the
- * watch is deleted
+ * watch is deleted.  The source will be bound to @context if
+ * provided, or main context if it is NULL.
+ *
+ * Note: if a valid source is returned, we need to explicitly unref
+ * the source to destroy it.
+ *
+ * Returns: the source pointer
+ */
+GSource *qio_channel_add_watch_full(QIOChannel *ioc,
+                                    GIOCondition condition,
+                                    QIOChannelFunc func,
+                                    gpointer user_data,
+                                    GDestroyNotify notify,
+                                    GMainContext *context);
+
+/**
+ * qio_channel_add_watch:
+ * @ioc: the channel object
+ * @condition: the I/O condition to monitor
+ * @func: callback to invoke when the source becomes ready
+ * @user_data: opaque data to pass to @func
+ * @notify: callback to free @user_data
+ *
+ * Wrapper of qio_channel_add_watch_full(), but it'll only bind the
+ * source object to default main context.
  *
  * The returned source ID can be used with g_source_remove()
  * to remove and free the source when no longer required.
diff --git a/io/channel.c b/io/channel.c
index ec4b86de7c..3e734cc9a5 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -299,6 +299,22 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
     klass->io_set_aio_fd_handler(ioc, ctx, io_read, io_write, opaque);
 }
 
+GSource *qio_channel_add_watch_full(QIOChannel *ioc,
+                                    GIOCondition condition,
+                                    QIOChannelFunc func,
+                                    gpointer user_data,
+                                    GDestroyNotify notify,
+                                    GMainContext *context)
+{
+    GSource *source;
+
+    source = qio_channel_create_watch(ioc, condition);
+    g_source_set_callback(source, (GSourceFunc)func, user_data, notify);
+    g_source_attach(source, context);
+
+    return source;
+}
+
 guint qio_channel_add_watch(QIOChannel *ioc,
                             GIOCondition condition,
                             QIOChannelFunc func,
@@ -308,11 +324,9 @@ guint qio_channel_add_watch(QIOChannel *ioc,
     GSource *source;
     guint id;
 
-    source = qio_channel_create_watch(ioc, condition);
-
-    g_source_set_callback(source, (GSourceFunc)func, user_data, notify);
-
-    id = g_source_attach(source, NULL);
+    source = qio_channel_add_watch_full(ioc, condition, func,
+                                        user_data, notify, NULL);
+    id = g_source_get_id(source);
     g_source_unref(source);
 
     return id;
-- 
2.14.3
