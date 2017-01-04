Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cOsev-0004Pm-6n
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cOses-0000g7-5d
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:59:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cOser-0000fA-Vk
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:59:42 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1332F37F1F
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 20:59:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  4 Jan 2017 21:59:36 +0100
Message-Id: <20170104205936.27279-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] win32: fix main-loop busy loop on socket/fd
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Commit 05e514b1d4d5bd4209e2c8bbc76ff05c85a235f3 introduced an AIO
context optimization to avoid calling event_notifier_test_and_clear() on
ctx->notifier. On Windows, the same notifier is being used to wakeup the
wait on socket events (see commit
d3385eb448e38f828c78f8f68ec5d79c66a58b5d).

The ctx->notifier event is added to the gpoll sources in
aio_set_event_notifier(), aio_ctx_check() should clear the event
regardless of ctx->notified, since Windows sets the event by itself,
bypassing the aio->notified. This fixes qemu not clearing the event
resulting in a busy loop.

Paolo suggested to me on irc to call event_notifier_test_and_clear()
after select() >0 from aio-win32.c's aio_prepare. Unfortunately, not all
fds associated with ctx->notifiers are in AIO fd handlers set.
(qemu_set_nonblock() in util/oslib-win32.c calls qemu_fd_register()).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/block/aio.h | 2 ++
 async.c             | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index ca551e346f..a6da135bf3 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -100,6 +100,7 @@ struct AioContext {
      */
     int walking_bh;
=20
+#ifndef _WIN32
     /* Used by aio_notify.
      *
      * "notified" is used to avoid expensive event_notifier_test_and_cle=
ar
@@ -113,6 +114,7 @@ struct AioContext {
      * in the docs/aio_notify_accept.promela formal model.
      */
     bool notified;
+#endif
     EventNotifier notifier;
=20
     /* Thread pool for performing work and receiving completion callback=
s */
diff --git a/async.c b/async.c
index b2de360c23..8c2a68b6cc 100644
--- a/async.c
+++ b/async.c
@@ -329,15 +329,21 @@ void aio_notify(AioContext *ctx)
     smp_mb();
     if (ctx->notify_me) {
         event_notifier_set(&ctx->notifier);
+#ifndef _WIN32
         atomic_mb_set(&ctx->notified, true);
+#endif
     }
 }
=20
 void aio_notify_accept(AioContext *ctx)
 {
+#ifndef _WIN32
     if (atomic_xchg(&ctx->notified, false)) {
+#endif
         event_notifier_test_and_clear(&ctx->notifier);
+#ifndef _WIN32
     }
+#endif
 }
=20
 static void aio_timerlist_notify(void *opaque)
--=20
2.11.0
