Received: from eggs.gnu.org ([2001:4830:134:3::10]:58691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8g-0003nz-HK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8e-0000JS-Ha
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:26 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:31 +0200
Message-Id: <20180531171253.21012-32-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/53] mux: fix ctrl-a b again
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
regression, but was inadvertently broken again in merge commit
2d6752d38d8acda.

Fixes:
https://bugs.launchpad.net/qemu/+bug/1654137

Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180515152500.19460-3-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-mux.c | 1 +
 tests/test-char.c  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 1b925c8dec..6055e76293 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -304,6 +304,7 @@ void mux_set_focus(Chardev *chr, int focus)
     }
=20
     d->focus =3D focus;
+    chr->be =3D d->backends[focus];
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
=20
diff --git a/tests/test-char.c b/tests/test-char.c
index 1880d36783..5905d31441 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -214,6 +214,10 @@ static void char_mux_test(void)
     g_assert_cmpint(h2.last_event, =3D=3D, -1);
=20
     /* switch focus */
+    qemu_chr_be_write(base, (void *)"\1b", 2);
+    g_assert_cmpint(h1.last_event, =3D=3D, 42);
+    g_assert_cmpint(h2.last_event, =3D=3D, CHR_EVENT_BREAK);
+
     qemu_chr_be_write(base, (void *)"\1c", 2);
     g_assert_cmpint(h1.last_event, =3D=3D, CHR_EVENT_MUX_IN);
     g_assert_cmpint(h2.last_event, =3D=3D, CHR_EVENT_MUX_OUT);
@@ -227,6 +231,10 @@ static void char_mux_test(void)
     g_assert_cmpstr(h1.read_buf, =3D=3D, "hello");
     h1.read_count =3D 0;
=20
+    qemu_chr_be_write(base, (void *)"\1b", 2);
+    g_assert_cmpint(h1.last_event, =3D=3D, CHR_EVENT_BREAK);
+    g_assert_cmpint(h2.last_event, =3D=3D, CHR_EVENT_MUX_OUT);
+
     /* remove first handler */
     qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
                              NULL, NULL, true);
--=20
2.17.0
