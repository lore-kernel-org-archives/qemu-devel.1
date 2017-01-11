Received: from eggs.gnu.org ([2001:4830:134:3::10]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgn-0003V1-Me
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgm-0003VA-JA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:05 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:21 +0100
Message-Id: <1484163327-111841-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/33] char: fix ctrl-a b not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-stable@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

CharDriverState.be should be updated to point to the current
associated backend.

Fix the regression introduced in the "mux" chardev from commit
a4afa548fc6dd9842ed86639b4d37d4d1c4ad480.

https://bugs.launchpad.net/bugs/1654137

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170110110621.15287-1-marcandre.lureau@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-char.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 2c9940c..676944a 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -499,7 +499,7 @@ void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
 
 static void remove_fd_in_watch(CharDriverState *chr);
 static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *context);
-static void mux_set_focus(MuxDriver *d, int focus);
+static void mux_set_focus(CharDriverState *chr, int focus);
 
 static int null_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
@@ -666,7 +666,7 @@ static int mux_proc_byte(CharDriverState *chr, MuxDriver *d, int ch)
         case 'c':
             assert(d->mux_cnt > 0); /* handler registered with first fe */
             /* Switch to the next registered device */
-            mux_set_focus(d, (d->focus + 1) % d->mux_cnt);
+            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
             break;
         case 't':
             d->timestamps = !d->timestamps;
@@ -826,8 +826,10 @@ static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *context)
                              context, true);
 }
 
-static void mux_set_focus(MuxDriver *d, int focus)
+static void mux_set_focus(CharDriverState *chr, int focus)
 {
+    MuxDriver *d = chr->opaque;
+
     assert(focus >= 0);
     assert(focus < d->mux_cnt);
 
@@ -836,6 +838,7 @@ static void mux_set_focus(MuxDriver *d, int focus)
     }
 
     d->focus = focus;
+    chr->be = d->backends[focus];
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
@@ -935,7 +938,9 @@ void qemu_chr_fe_deinit(CharBackend *b)
 
     if (b->chr) {
         qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
-        b->chr->be = NULL;
+        if (b->chr->be == b) {
+            b->chr->be = NULL;
+        }
         if (b->chr->is_mux) {
             MuxDriver *d = b->chr->opaque;
             d->backends[b->tag] = NULL;
@@ -999,7 +1004,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
     }
 
     if (b->chr->is_mux) {
-        mux_set_focus(b->chr->opaque, b->tag);
+        mux_set_focus(b->chr, b->tag);
     }
 }
 
-- 
1.8.3.1
