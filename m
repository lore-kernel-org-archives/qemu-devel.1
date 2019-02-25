Received: from eggs.gnu.org ([209.51.188.92]:37270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4h-00009w-A8
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4b-0000pZ-3E
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:47 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:55 +0100
Message-Id: <20190225152053.15976-14-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/71] io: Remove redundant read/write_coroutine
 assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

qio_channel_yield() now updates ioc->read_write/coroutine and calls
qio_channel_set_aio_fd_handlers(), so the code in the handlers has
become redundant and can be removed.

This does not make a difference in intermediate states because
aio_co_wake() really enters the coroutine immediately here: These
handlers are never run in coroutine context, and we're in the right
AioContext because qio_channel_attach_aio_context() asserts that the
handlers are inactive.

To make these conditions more obvious, assert the right AioContext.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 io/channel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/io/channel.c b/io/channel.c
index 303376e08d..2a26c2a2c0 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -400,15 +400,14 @@ off_t qio_channel_io_seek(QIOChannel *ioc,
 }
=20
=20
-static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc);
-
 static void qio_channel_restart_read(void *opaque)
 {
     QIOChannel *ioc =3D opaque;
     Coroutine *co =3D ioc->read_coroutine;
=20
-    ioc->read_coroutine =3D NULL;
-    qio_channel_set_aio_fd_handlers(ioc);
+    /* Assert that aio_co_wake() reenters the coroutine directly */
+    assert(qemu_get_current_aio_context() =3D=3D
+           qemu_coroutine_get_aio_context(co));
     aio_co_wake(co);
 }
=20
@@ -417,8 +416,9 @@ static void qio_channel_restart_write(void *opaque)
     QIOChannel *ioc =3D opaque;
     Coroutine *co =3D ioc->write_coroutine;
=20
-    ioc->write_coroutine =3D NULL;
-    qio_channel_set_aio_fd_handlers(ioc);
+    /* Assert that aio_co_wake() reenters the coroutine directly */
+    assert(qemu_get_current_aio_context() =3D=3D
+           qemu_coroutine_get_aio_context(co));
     aio_co_wake(co);
 }
=20
--=20
2.20.1
