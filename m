Received: from eggs.gnu.org ([209.51.188.92]:34836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldQ-0006JA-Bd
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldP-0002Q5-83
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:14 +0100
Message-Id: <20190218161822.3573-5-kwolf@redhat.com>
In-Reply-To: <20190218161822.3573-1-kwolf@redhat.com>
References: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/12] io: Make qio_channel_yield()
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Similar to how qemu_co_sleep_ns() allows to be preempted by an external
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
