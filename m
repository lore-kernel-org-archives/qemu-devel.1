Received: from eggs.gnu.org ([2001:4830:134:3::10]:38009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCh-0002Iu-AY
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCg-0000PK-A8
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:51 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  7 Mar 2018 11:25:28 +0000
Message-Id: <20180307112532.24248-3-berrange@redhat.com>
In-Reply-To: <20180307112532.24248-1-berrange@redhat.com>
References: <20180307112532.24248-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] qio: introduce
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Firstly, introduce an internal qio_channel_add_watch_full(), which
enhances qio_channel_add_watch() that context can be specified.

Then add a new API wrapper qio_channel_add_watch_source() to return a
GSource pointer rather than a tag ID.

Note that the _source() call will keep a reference of GSource so that
callers need to unref them explicitly when finished using the GSource.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
=20
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
=20
 /**
  * qio_channel_attach_aio_context:
diff --git a/io/channel.c b/io/channel.c
index ec4b86de7c..8dd0684f5d 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -299,11 +299,12 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc=
,
     klass->io_set_aio_fd_handler(ioc, ctx, io_read, io_write, opaque);
 }
=20
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
=20
     g_source_set_callback(source, (GSourceFunc)func, user_data, notify);
=20
-    id =3D g_source_attach(source, NULL);
+    id =3D g_source_attach(source, context);
     g_source_unref(source);
=20
     return id;
 }
=20
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
+    id =3D qio_channel_add_watch_full(ioc, condition, func,
+                                    user_data, notify, context);
+    source =3D g_main_context_find_source_by_id(context, id);
+    g_source_ref(source);
+    return source;
+}
+
=20
 int qio_channel_shutdown(QIOChannel *ioc,
                          QIOChannelShutdown how,
--=20
2.14.3
