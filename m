Received: from eggs.gnu.org ([2001:4830:134:3::10]:32959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIbpF-0002ET-0O
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIbpD-0005px-Eu
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 15 May 2018 12:25:00 -0300
Message-Id: <20180515152500.19460-3-f4bug@amsat.org>
In-Reply-To: <20180515152500.19460-1-f4bug@amsat.org>
References: <20180515152500.19460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/2] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
regression, but was inadvertently broken again in merge commit
2d6752d38d8acda.

Fixes:
https://bugs.launchpad.net/qemu/+bug/1654137

Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
 
     d->focus = focus;
+    chr->be = d->backends[focus];
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
diff --git a/tests/test-char.c b/tests/test-char.c
index 1880d36783..5905d31441 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -214,6 +214,10 @@ static void char_mux_test(void)
     g_assert_cmpint(h2.last_event, ==, -1);
 
     /* switch focus */
+    qemu_chr_be_write(base, (void *)"\1b", 2);
+    g_assert_cmpint(h1.last_event, ==, 42);
+    g_assert_cmpint(h2.last_event, ==, CHR_EVENT_BREAK);
+
     qemu_chr_be_write(base, (void *)"\1c", 2);
     g_assert_cmpint(h1.last_event, ==, CHR_EVENT_MUX_IN);
     g_assert_cmpint(h2.last_event, ==, CHR_EVENT_MUX_OUT);
@@ -227,6 +231,10 @@ static void char_mux_test(void)
     g_assert_cmpstr(h1.read_buf, ==, "hello");
     h1.read_count = 0;
 
+    qemu_chr_be_write(base, (void *)"\1b", 2);
+    g_assert_cmpint(h1.last_event, ==, CHR_EVENT_BREAK);
+    g_assert_cmpint(h2.last_event, ==, CHR_EVENT_MUX_OUT);
+
     /* remove first handler */
     qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
                              NULL, NULL, true);
-- 
2.17.0
