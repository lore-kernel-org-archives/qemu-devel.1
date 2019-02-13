Received: from eggs.gnu.org ([209.51.188.92]:39140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG4-00043Q-4S
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG2-0005Jg-0Z
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxG1-00059q-F4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:18:50 +0100
Message-Id: <20190213161913.22107-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 02/25] tests/test-char: add muxed chardev
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
Cc: peter.maydell@linaro.org

From: Artem Pisarenko <artem.k.pisarenko@gmail.com>

Validate that frontend callbacks for CHR_EVENT_OPENED/CHR_EVENT_CLOSED
events are being issued when expected and in strictly pairing order.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <ac67ff2d27dd51a0075d5d634355c9e4f7bb53de.1541507990.git.arte=
m.k.pisarenko@gmail.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 80 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 19c3efad72..018e2eed93 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -16,6 +16,9 @@ static bool quit;
=20
 typedef struct FeHandler {
     int read_count;
+    bool is_open;
+    int openclose_count;
+    bool openclose_mismatch;
     int last_event;
     char read_buf[128];
 } FeHandler;
@@ -49,10 +52,24 @@ static void fe_read(void *opaque, const uint8_t *buf,=
 int size)
 static void fe_event(void *opaque, int event)
 {
     FeHandler *h =3D opaque;
+    bool new_open_state;
=20
     h->last_event =3D event;
-    if (event !=3D CHR_EVENT_BREAK) {
+    switch (event) {
+    case CHR_EVENT_BREAK:
+        break;
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_CLOSED:
+        h->openclose_count++;
+        new_open_state =3D (event =3D=3D CHR_EVENT_OPENED);
+        if (h->is_open =3D=3D new_open_state) {
+            h->openclose_mismatch =3D true;
+        }
+        h->is_open =3D new_open_state;
+        /* no break */
+    default:
         quit =3D true;
+        break;
     }
 }
=20
@@ -161,7 +178,7 @@ static void char_mux_test(void)
     QemuOpts *opts;
     Chardev *chr, *base;
     char *data;
-    FeHandler h1 =3D { 0, }, h2 =3D { 0, };
+    FeHandler h1 =3D { 0, false, 0, false, }, h2 =3D { 0, false, 0, fals=
e, };
     CharBackend chr_be1, chr_be2;
=20
     opts =3D qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
@@ -233,6 +250,65 @@ static void char_mux_test(void)
     g_assert_cmpint(h1.last_event, =3D=3D, CHR_EVENT_BREAK);
     g_assert_cmpint(h2.last_event, =3D=3D, CHR_EVENT_MUX_OUT);
=20
+    /* open/close state and corresponding events */
+    g_assert_true(qemu_chr_fe_backend_open(&chr_be1));
+    g_assert_true(qemu_chr_fe_backend_open(&chr_be2));
+    g_assert_true(h1.is_open);
+    g_assert_false(h1.openclose_mismatch);
+    g_assert_true(h2.is_open);
+    g_assert_false(h2.openclose_mismatch);
+
+    h1.openclose_count =3D h2.openclose_count =3D 0;
+
+    qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
+                             NULL, NULL, false);
+    qemu_chr_fe_set_handlers(&chr_be2, NULL, NULL, NULL, NULL,
+                             NULL, NULL, false);
+    g_assert_cmpint(h1.openclose_count, =3D=3D, 0);
+    g_assert_cmpint(h2.openclose_count, =3D=3D, 0);
+
+    h1.is_open =3D h2.is_open =3D false;
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
+    g_assert_cmpint(h1.openclose_count, =3D=3D, 1);
+    g_assert_false(h1.openclose_mismatch);
+    g_assert_cmpint(h2.openclose_count, =3D=3D, 1);
+    g_assert_false(h2.openclose_mismatch);
+
+    qemu_chr_be_event(base, CHR_EVENT_CLOSED);
+    qemu_chr_be_event(base, CHR_EVENT_OPENED);
+    g_assert_cmpint(h1.openclose_count, =3D=3D, 3);
+    g_assert_false(h1.openclose_mismatch);
+    g_assert_cmpint(h2.openclose_count, =3D=3D, 3);
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
--=20
2.21.0.rc0.1.g036caf7885
