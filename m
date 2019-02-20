Received: from eggs.gnu.org ([209.51.188.92]:51755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwVzh-0005LD-4u
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwVzf-0005BR-5e
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:49:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Feb 2019 18:48:34 +0100
Message-Id: <20190220174843.8847-5-kwolf@redhat.com>
In-Reply-To: <20190220174843.8847-1-kwolf@redhat.com>
References: <20190220174843.8847-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/13] io: Make qio_channel_yield()
 interruptible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Similar to how qemu_co_sleep_ns() allows preemption from an external
coroutine entry, allow reentering qio_channel_yield() early.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/io/channel.h |  9 ++++++---
 io/channel.c         | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index da2f138200..59460cb1ec 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -739,10 +739,13 @@ void qio_channel_detach_aio_context(QIOChannel *ioc=
);
  * addition, no two coroutine can be waiting on the same condition
  * and channel at the same time.
  *
- * This must only be called from coroutine context
+ * This must only be called from coroutine context. It is safe to
+ * reenter the coroutine externally while it is waiting; in this
+ * case the function will return even if @condition is not yet
+ * available.
  */
-void qio_channel_yield(QIOChannel *ioc,
-                       GIOCondition condition);
+void coroutine_fn qio_channel_yield(QIOChannel *ioc,
+                                    GIOCondition condition);
=20
 /**
  * qio_channel_wait:
diff --git a/io/channel.c b/io/channel.c
index 8dd0684f5d..303376e08d 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -469,6 +469,16 @@ void coroutine_fn qio_channel_yield(QIOChannel *ioc,
     }
     qio_channel_set_aio_fd_handlers(ioc);
     qemu_coroutine_yield();
+
+    /* Allow interrupting the operation by reentering the coroutine othe=
r than
+     * through the aio_fd_handlers. */
+    if (condition =3D=3D G_IO_IN && ioc->read_coroutine) {
+        ioc->read_coroutine =3D NULL;
+        qio_channel_set_aio_fd_handlers(ioc);
+    } else if (condition =3D=3D G_IO_OUT && ioc->write_coroutine) {
+        ioc->write_coroutine =3D NULL;
+        qio_channel_set_aio_fd_handlers(ioc);
+    }
 }
=20
=20
--=20
2.20.1
