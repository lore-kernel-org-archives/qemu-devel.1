Received: from eggs.gnu.org ([2001:4830:134:3::10]:36205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eAdtl-0004cq-UJ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eAdti-0005dX-Qs
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eAdti-0005dF-LT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:28:42 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Nov 2017 16:28:24 +0100
Message-Id: <20171103152824.21948-3-marcandre.lureau@redhat.com>
In-Reply-To: <20171103152824.21948-1-marcandre.lureau@redhat.com>
References: <20171103152824.21948-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] test: add some chardev mux event tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kirill.shutemov@linux.intel.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Check the expected behaviour of qemu_chr_be_event() on a mux chardev.

For some reason, sending the event on the base chardev broadcast to
all frontends, while sending it on the mux chardev itself should
trigger the event on the currently focused chardev frontend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 7ac25ff73f..911e3f6e8d 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -5,6 +5,7 @@
 #include "qemu/config-file.h"
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
@@ -164,6 +165,7 @@ static void char_mux_test(void)
     FeHandler h1 =3D { 0, }, h2 =3D { 0, };
     CharBackend chr_be1, chr_be2;
=20
+    muxes_realized =3D true; /* done after machine init */
     opts =3D qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
@@ -201,8 +203,23 @@ static void char_mux_test(void)
     g_assert_cmpstr(h2.read_buf, =3D=3D, "hello");
     h2.read_count =3D 0;
=20
+    g_assert_cmpint(h1.last_event, !=3D, 42); /* should be MUX_OUT or OP=
ENED */
+    g_assert_cmpint(h2.last_event, !=3D, 42); /* should be MUX_IN or OPE=
NED */
+    /* sending event on the base broadcast to all fe, historical reasons=
? */
+    qemu_chr_be_event(base, 42);
+    g_assert_cmpint(h1.last_event, =3D=3D, 42);
+    g_assert_cmpint(h2.last_event, =3D=3D, 42);
+    qemu_chr_be_event(chr, -1);
+    g_assert_cmpint(h1.last_event, =3D=3D, 42);
+    g_assert_cmpint(h2.last_event, =3D=3D, -1);
+
     /* switch focus */
     qemu_chr_be_write(base, (void *)"\1c", 2);
+    g_assert_cmpint(h1.last_event, =3D=3D, CHR_EVENT_MUX_IN);
+    g_assert_cmpint(h2.last_event, =3D=3D, CHR_EVENT_MUX_OUT);
+    qemu_chr_be_event(chr, -1);
+    g_assert_cmpint(h1.last_event, =3D=3D, -1);
+    g_assert_cmpint(h2.last_event, =3D=3D, CHR_EVENT_MUX_OUT);
=20
     qemu_chr_be_write(base, (void *)"hello", 6);
     g_assert_cmpint(h2.read_count, =3D=3D, 0);
--=20
2.15.0.rc0.40.gaefcc5f6f
