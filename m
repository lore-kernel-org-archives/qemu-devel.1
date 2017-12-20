Received: from eggs.gnu.org ([2001:4830:134:3::10]:56717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyi-0004zw-O5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyh-0007Pm-Fg
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:24 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyh-0007PG-7r
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:23 -0500
Received: by mail-wr0-x242.google.com with SMTP id o2so22901923wro.5
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:55 +0100
Message-Id: <1513790098-9815-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 43/46] test: add some chardev mux event tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Check the expected behaviour of qemu_chr_be_event() on a mux chardev.

For some reason, sending the event on the base chardev broadcast to
all frontends, while sending it on the mux chardev itself should
trigger the event on the currently focused chardev frontend.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20171103152824.21948-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 7ac25ff..911e3f6 100644
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
     FeHandler h1 = { 0, }, h2 = { 0, };
     CharBackend chr_be1, chr_be2;
 
+    muxes_realized = true; /* done after machine init */
     opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
@@ -201,8 +203,23 @@ static void char_mux_test(void)
     g_assert_cmpstr(h2.read_buf, ==, "hello");
     h2.read_count = 0;
 
+    g_assert_cmpint(h1.last_event, !=, 42); /* should be MUX_OUT or OPENED */
+    g_assert_cmpint(h2.last_event, !=, 42); /* should be MUX_IN or OPENED */
+    /* sending event on the base broadcast to all fe, historical reasons? */
+    qemu_chr_be_event(base, 42);
+    g_assert_cmpint(h1.last_event, ==, 42);
+    g_assert_cmpint(h2.last_event, ==, 42);
+    qemu_chr_be_event(chr, -1);
+    g_assert_cmpint(h1.last_event, ==, 42);
+    g_assert_cmpint(h2.last_event, ==, -1);
+
     /* switch focus */
     qemu_chr_be_write(base, (void *)"\1c", 2);
+    g_assert_cmpint(h1.last_event, ==, CHR_EVENT_MUX_IN);
+    g_assert_cmpint(h2.last_event, ==, CHR_EVENT_MUX_OUT);
+    qemu_chr_be_event(chr, -1);
+    g_assert_cmpint(h1.last_event, ==, -1);
+    g_assert_cmpint(h2.last_event, ==, CHR_EVENT_MUX_OUT);
 
     qemu_chr_be_write(base, (void *)"hello", 6);
     g_assert_cmpint(h2.read_count, ==, 0);
-- 
1.8.3.1
