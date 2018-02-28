Received: from eggs.gnu.org ([2001:4830:134:3::10]:33592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxP-00087s-R6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxO-0000kQ-TA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxO-0000kH-N1
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AE02EAEA0
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:10 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:26 +0800
Message-Id: <20180228050633.7410-8-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 07/14] qio/chardev: update net listener gcontext
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

TCP chardevs can be using QIO network listeners working in the
background when in listening mode.  However the network listeners are
always running in main context.  This can race with chardevs that are
running in non-main contexts.

To solve this: firstly introduce qio_net_listener_set_context() to allow
caller to set gcontext for network listeners.  Then call it in
tcp_chr_update_read_handler(), with the newly cached gcontext.

It's fairly straightforward after we have introduced some net listener
helper functions - basically we unregister the GSources and add them
back with the correct context.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c     |  9 +++++++++
 include/io/net-listener.h | 12 ++++++++++++
 io/net-listener.c         |  7 +++++++
 3 files changed, 28 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 43a2cc2c1c..8f0935cd15 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -559,6 +559,15 @@ static void tcp_chr_update_read_handler(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
+    if (s->listener) {
+        /*
+         * It's possible that chardev context is changed in
+         * qemu_chr_be_update_read_handlers().  Reset it for QIO net
+         * listener if there is.
+         */
+        qio_net_listener_set_context(s->listener, chr->gcontext);
+    }
+
     if (!s->connected) {
         return;
     }
diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 566be283b3..39dede9d6f 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -106,6 +106,18 @@ int qio_net_listener_open_sync(QIONetListener *listener,
                                SocketAddress *addr,
                                Error **errp);
 
+/**
+ * qio_net_listener_set_context:
+ * @listener: the net listener object
+ * @context: the context that we'd like to bind the sources to
+ *
+ * This helper does not do anything but moves existing net listener
+ * sources from the old one to the new one.  It can be seen as a
+ * no-operation if there is no listening source at all.
+ */
+void qio_net_listener_set_context(QIONetListener *listener,
+                                  GMainContext *context);
+
 /**
  * qio_net_listener_add:
  * @listener: the network listener object
diff --git a/io/net-listener.c b/io/net-listener.c
index 7f07a81fed..7ffad72f55 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -145,6 +145,13 @@ static void qio_net_listener_sources_update(QIONetListener *listener,
     }
 }
 
+void qio_net_listener_set_context(QIONetListener *listener,
+                                  GMainContext *context)
+{
+    qio_net_listener_sources_clear(listener);
+    qio_net_listener_sources_update(listener, context);
+}
+
 void qio_net_listener_add(QIONetListener *listener,
                           QIOChannelSocket *sioc)
 {
-- 
2.14.3
