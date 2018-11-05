Received: from eggs.gnu.org ([2001:4830:134:3::10]:35381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gJeGD-0006oH-Kx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gJeG9-0000tN-N5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:45:39 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gJeG6-0000Dj-16
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:45:35 -0500
Received: by mail-lj1-x242.google.com with SMTP id q186-v6so7872471ljb.5
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:45:21 -0800 (PST)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Mon,  5 Nov 2018 18:45:10 +0600
Message-Id: <ae16b7e9df62708e0556a13a1efa8aa2628c1c56.1541421653.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
References: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
References: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] tests/test-char: add muxed chardev
 testing for open/close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

Validate that frontend callbacks for CHR_EVENT_OPENED/CHR_EVENT_CLOSED
events are being issued when expected and in strictly pairing order.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---
 tests/test-char.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 831e37f..657cb4c 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -16,6 +16,9 @@ static bool quit;
 
 typedef struct FeHandler {
     int read_count;
+    bool is_open;
+    int openclose_count;
+    bool openclose_mismatch;
     int last_event;
     char read_buf[128];
 } FeHandler;
@@ -49,10 +52,24 @@ static void fe_read(void *opaque, const uint8_t *buf, int size)
 static void fe_event(void *opaque, int event)
 {
     FeHandler *h = opaque;
+    bool new_open_state;
 
     h->last_event = event;
-    if (event != CHR_EVENT_BREAK) {
+    switch (event) {
+    case CHR_EVENT_BREAK:
+        break;
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_CLOSED:
+        h->openclose_count++;
+        new_open_state = (event == CHR_EVENT_OPENED);
+        if (h->is_open == new_open_state) {
+            h->openclose_mismatch = true;
+        }
+        h->is_open = new_open_state;
+        /* no break */
+    default:
         quit = true;
+        break;
     }
 }
 
@@ -161,7 +178,7 @@ static void char_mux_test(void)
     QemuOpts *opts;
     Chardev *chr, *base;
     char *data;
-    FeHandler h1 = { 0, }, h2 = { 0, };
+    FeHandler h1 = { 0, false, 0, false, }, h2 = { 0, false, 0, false, };
     CharBackend chr_be1, chr_be2;
 
     opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
@@ -233,6 +250,65 @@ static void char_mux_test(void)
     g_assert_cmpint(h1.last_event, ==, CHR_EVENT_BREAK);
     g_assert_cmpint(h2.last_event, ==, CHR_EVENT_MUX_OUT);
 
+    /* open/close state and corresponding events */
+    g_assert_true(qemu_chr_fe_backend_open(&chr_be1));
+    g_assert_true(qemu_chr_fe_backend_open(&chr_be2));
+    g_assert_true(h1.is_open);
+    g_assert_false(h1.openclose_mismatch);
+    g_assert_true(h2.is_open);
+    g_assert_false(h2.openclose_mismatch);
+
+    h1.openclose_count = h2.openclose_count = 0;
+
+    qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
+                             NULL, NULL, false);
+    qemu_chr_fe_set_handlers(&chr_be2, NULL, NULL, NULL, NULL,
+                             NULL, NULL, false);
+    g_assert_cmpint(h1.openclose_count, ==, 0);
+    g_assert_cmpint(h2.openclose_count, ==, 0);
+
+    h1.is_open = h2.is_open = false;
+    qemu_chr_fe_set_handlers(&chr_be1,
+                             NULL,
+                             NULL,
+                             fe_event,
+                             NULL,
+                             &h1,
+                             NULL, false);
+    qemu_chr_fe_set_handlers(&chr_be2,
+                             NULL,
+                             NULL,
+                             fe_event,
+                             NULL,
+                             &h2,
+                             NULL, false);
+    g_assert_cmpint(h1.openclose_count, ==, 1);
+    g_assert_false(h1.openclose_mismatch);
+    g_assert_cmpint(h2.openclose_count, ==, 1);
+    g_assert_false(h2.openclose_mismatch);
+
+    qemu_chr_be_event(base, CHR_EVENT_CLOSED);
+    qemu_chr_be_event(base, CHR_EVENT_OPENED);
+    g_assert_cmpint(h1.openclose_count, ==, 3);
+    g_assert_false(h1.openclose_mismatch);
+    g_assert_cmpint(h2.openclose_count, ==, 3);
+    g_assert_false(h2.openclose_mismatch);
+
+    qemu_chr_fe_set_handlers(&chr_be2,
+                             fe_can_read,
+                             fe_read,
+                             fe_event,
+                             NULL,
+                             &h2,
+                             NULL, false);
+    qemu_chr_fe_set_handlers(&chr_be1,
+                             fe_can_read,
+                             fe_read,
+                             fe_event,
+                             NULL,
+                             &h1,
+                             NULL, false);
+
     /* remove first handler */
     qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
                              NULL, NULL, true);
-- 
2.7.4
