Received: from eggs.gnu.org ([2001:4830:134:3::10]:35770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm8h-00057i-Me
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm8g-0006BO-Un
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:38:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm8g-0006AF-Ls
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:38:58 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:23 +0800
Message-Id: <20170929033844.26935-2-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 01/22] char-io: fix possible race on
 IOWatchPoll
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is not a problem if we are only having one single loop thread like
before.  However, after per-monitor thread is introduced, this is not
true any more, and the race can happen.

The race can be triggered with "make check -j8" sometimes:

  qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
  io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' failed.

This patch keeps the reference for the watch object when creating in
io_add_watch_poll(), so that the object will never be released in the
context main loop, especially when the context loop is running in
another standalone thread.  Meanwhile, when we want to remove the watch
object, we always first detach the watch object from its owner context,
then we continue with the cleanup.

Without this patch, calling io_remove_watch_poll() in main loop thread
is not thread-safe, since the other per-monitor thread may be modifying
the watch object at the same time.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-io.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index f81052481a..50b5bac704 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -122,7 +122,6 @@ GSource *io_add_watch_poll(Chardev *chr,
     g_free(name);
=20
     g_source_attach(&iwp->parent, context);
-    g_source_unref(&iwp->parent);
     return (GSource *)iwp;
 }
=20
@@ -131,12 +130,25 @@ static void io_remove_watch_poll(GSource *source)
     IOWatchPoll *iwp;
=20
     iwp =3D io_watch_poll_from_source(source);
+
+    /*
+     * Here the order of destruction really matters.  We need to first
+     * detach the IOWatchPoll object from the context (which may still
+     * be running in another loop thread), only after that could we
+     * continue to operate on iwp->src, or there may be race condition
+     * between current thread and the context loop thread.
+     *
+     * Let's blame the glib bug mentioned in commit 2b316774f6
+     * ("qemu-char: do not operate on sources from finalize
+     * callbacks") for this extra complexity.
+     */
+    g_source_destroy(&iwp->parent);
     if (iwp->src) {
         g_source_destroy(iwp->src);
         g_source_unref(iwp->src);
         iwp->src =3D NULL;
     }
-    g_source_destroy(&iwp->parent);
+    g_source_unref(&iwp->parent);
 }
=20
 void remove_fd_in_watch(Chardev *chr)
--=20
2.13.5
