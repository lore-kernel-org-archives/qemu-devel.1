Received: from eggs.gnu.org ([209.51.188.92]:60020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmDQ-0008TQ-IY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmDO-0007Md-DS
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:07:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grmDO-0007EI-4J
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:07:50 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  7 Feb 2019 17:06:17 +0100
Message-Id: <20190207160617.1142-19-marcandre.lureau@redhat.com>
In-Reply-To: <20190207160617.1142-1-marcandre.lureau@redhat.com>
References: <20190207160617.1142-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/18] tests/test-char: add muxed chardev
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peter.maydell@linaro.org, Artem Pisarenko <artem.k.pisarenko@gmail.com>

From: Artem Pisarenko <artem.k.pisarenko@gmail.com>

Validate that frontend callbacks for CHR_EVENT_OPENED/CHR_EVENT_CLOSED
events are being issued when expected and in strictly pairing order.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <ac67ff2d27dd51a0075d5d634355c9e4f7bb53de.1541507990.git.arte=
m.k.pisarenko@gmail.com>
---
 tests/test-char.c | 80 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 8b478bb67d..82579e6aa5 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -19,6 +19,9 @@ static bool quit;
=20
 typedef struct FeHandler {
     int read_count;
+    bool is_open;
+    int openclose_count;
+    bool openclose_mismatch;
     int last_event;
     char read_buf[128];
 } FeHandler;
@@ -52,10 +55,24 @@ static void fe_read(void *opaque, const uint8_t *buf,=
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
@@ -164,7 +181,7 @@ static void char_mux_test(void)
     QemuOpts *opts;
     Chardev *chr, *base;
     char *data;
-    FeHandler h1 =3D { 0, }, h2 =3D { 0, };
+    FeHandler h1 =3D { 0, false, 0, false, }, h2 =3D { 0, false, 0, fals=
e, };
     CharBackend chr_be1, chr_be2;
=20
     opts =3D qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
@@ -236,6 +253,65 @@ static void char_mux_test(void)
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
2.20.1.519.g8feddda32c
