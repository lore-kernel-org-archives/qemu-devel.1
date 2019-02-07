Received: from eggs.gnu.org ([209.51.188.92]:49393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjeu-0001Dq-PI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjeu-0004Bg-58
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:04 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:59535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grjet-000405-Jo
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:04 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  7 Feb 2019 15:23:21 +0200
Message-Id: <c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
In-Reply-To: <cover.1549545591.git.berto@igalia.com>
References: <cover.1549545591.git.berto@igalia.com>
In-Reply-To: <cover.1549545591.git.berto@igalia.com>
References: <cover.1549545591.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/3] main-loop: Don't leak GSources attached to
 a GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

After g_source_attach() the GMainContext holds a reference to the
GSource, so the caller does not need to keep it.

pty_chr_state() and qio_task_thread_worker() are not doing this, so
the GSource is being leaked in both cases (pty_chr_open_src_cancel()
is the exception here because it does remove the extra reference
correctly).

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 chardev/char-pty.c | 2 +-
 io/task.c          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index f681d637c1..f16a5e8d59 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -60,7 +60,6 @@ static void pty_chr_open_src_cancel(PtyChardev *s)
 {
     if (s->open_source) {
         g_source_destroy(s->open_source);
-        g_source_unref(s->open_source);
         s->open_source = NULL;
     }
 }
@@ -216,6 +215,7 @@ static void pty_chr_state(Chardev *chr, int connected)
                                   qemu_chr_be_generic_open_func,
                                   chr, NULL);
             g_source_attach(s->open_source, chr->gcontext);
+            g_source_unref(s->open_source);
         }
         if (!chr->gsource) {
             chr->gsource = io_add_watch_poll(chr, s->ioc,
diff --git a/io/task.c b/io/task.c
index 2886a2c1bc..c8489fb790 100644
--- a/io/task.c
+++ b/io/task.c
@@ -120,6 +120,7 @@ static gpointer qio_task_thread_worker(gpointer opaque)
     idle = g_idle_source_new();
     g_source_set_callback(idle, qio_task_thread_result, data, NULL);
     g_source_attach(idle, data->context);
+    g_source_unref(idle);
 
     return NULL;
 }
-- 
2.11.0
