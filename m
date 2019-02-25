Received: from eggs.gnu.org ([209.51.188.92]:37461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI52-0000V1-RC
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4u-000143-Oz
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:03 +0100
Message-Id: <20190225152053.15976-22-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/71] aio-posix: Assert that aio_poll() is
 always called in home thread
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

aio_poll() has an existing assertion that the function is only called
from the AioContext's home thread if blocking is allowed.

This is not enough, some handlers make assumptions about the thread they
run in. Extend the assertion to non-blocking calls, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/aio-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 8640dfde9f..6fbfa7924f 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -613,6 +613,8 @@ bool aio_poll(AioContext *ctx, bool blocking)
     int64_t timeout;
     int64_t start =3D 0;
=20
+    assert(in_aio_context_home_thread(ctx));
+
     /* aio_notify can avoid the expensive event_notifier_set if
      * everything (file descriptors, bottom halves, timers) will
      * be re-evaluated before the next blocking poll().  This is
@@ -621,7 +623,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * so disable the optimization now.
      */
     if (blocking) {
-        assert(in_aio_context_home_thread(ctx));
         atomic_add(&ctx->notify_me, 2);
     }
=20
--=20
2.20.1
