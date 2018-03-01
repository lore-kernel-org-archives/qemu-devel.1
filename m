Received: from eggs.gnu.org ([2001:4830:134:3::10]:52466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJpz-0007up-PA
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJpt-000705-Ln
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJpt-0006z6-EK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65D0F80AD238
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:45:08 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:26 +0800
Message-Id: <20180301084438.13594-4-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/15] qio: introduce
 qio_channel_add_watch_{full|source}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Firstly, introduce an internal qio_channel_add_watch_full(), which
enhances qio_channel_add_watch() that context can be specified.

Then add a new API wrapper qio_channel_add_watch_source() to return a
GSource pointer rather than a tag ID.

Note that the _source() call will keep a reference of GSource so that
callers need to unref them explicitly when finished using the GSource.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 io/channel.c         | 40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 3995e243a3..e8cdadb0b0 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -648,6 +648,50 @@ guint qio_channel_add_watch(QIOChannel *ioc,
                             gpointer user_data,
                             GDestroyNotify notify);
 
+/**
+ * qio_channel_add_watch_full:
+ * @ioc: the channel object
+ * @condition: the I/O condition to monitor
+ * @func: callback to invoke when the source becomes ready
+ * @user_data: opaque data to pass to @func
+ * @notify: callback to free @user_data
+ * @context: the context to run the watch source
+ *
+ * Similar as qio_channel_add_watch(), but allows to specify context
+ * to run the watch source.
+ *
+ * Returns: the source ID
+ */
+guint qio_channel_add_watch_full(QIOChannel *ioc,
+                                 GIOCondition condition,
+                                 QIOChannelFunc func,
+                                 gpointer user_data,
+                                 GDestroyNotify notify,
+                                 GMainContext *context);
+
+/**
+ * qio_channel_add_watch_source:
+ * @ioc: the channel object
+ * @condition: the I/O condition to monitor
+ * @func: callback to invoke when the source becomes ready
+ * @user_data: opaque data to pass to @func
+ * @notify: callback to free @user_data
+ * @context: gcontext to bind the source to
+ *
+ * Similar as qio_channel_add_watch(), but allows to specify context
+ * to run the watch source, meanwhile return the GSource object
+ * instead of tag ID, with the GSource referenced already.
+ *
+ * Note: callers is responsible to unref the source when not needed.
+ *
+ * Returns: the source pointer
+ */
+GSource *qio_channel_add_watch_source(QIOChannel *ioc,
+                                      GIOCondition condition,
+                                      QIOChannelFunc func,
+                                      gpointer user_data,
+                                      GDestroyNotify notify,
+                                      GMainContext *context);
 
 /**
  * qio_channel_attach_aio_context:
diff --git a/io/channel.c b/io/channel.c
index ec4b86de7c..8dd0684f5d 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -299,11 +299,12 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
     klass->io_set_aio_fd_handler(ioc, ctx, io_read, io_write, opaque);
 }
 
-guint qio_channel_add_watch(QIOChannel *ioc,
-                            GIOCondition condition,
-                            QIOChannelFunc func,
-                            gpointer user_data,
-                            GDestroyNotify notify)
+guint qio_channel_add_watch_full(QIOChannel *ioc,
+                                 GIOCondition condition,
+                                 QIOChannelFunc func,
+                                 gpointer user_data,
+                                 GDestroyNotify notify,
+                                 GMainContext *context)
 {
     GSource *source;
     guint id;
@@ -312,12 +313,39 @@ guint qio_channel_add_watch(QIOChannel *ioc,
 
     g_source_set_callback(source, (GSourceFunc)func, user_data, notify);
 
-    id = g_source_attach(source, NULL);
+    id = g_source_attach(source, context);
     g_source_unref(source);
 
     return id;
 }
 
+guint qio_channel_add_watch(QIOChannel *ioc,
+                            GIOCondition condition,
+                            QIOChannelFunc func,
+                            gpointer user_data,
+                            GDestroyNotify notify)
+{
+    return qio_channel_add_watch_full(ioc, condition, func,
+                                      user_data, notify, NULL);
+}
+
+GSource *qio_channel_add_watch_source(QIOChannel *ioc,
+                                      GIOCondition condition,
+                                      QIOChannelFunc func,
+                                      gpointer user_data,
+                                      GDestroyNotify notify,
+                                      GMainContext *context)
+{
+    GSource *source;
+    guint id;
+
+    id = qio_channel_add_watch_full(ioc, condition, func,
+                                    user_data, notify, context);
+    source = g_main_context_find_source_by_id(context, id);
+    g_source_ref(source);
+    return source;
+}
+
 
 int qio_channel_shutdown(QIOChannel *ioc,
                          QIOChannelShutdown how,
-- 
2.14.3
