Received: from eggs.gnu.org ([2001:4830:134:3::10]:57239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ6-0006eH-3z
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ1-0006yj-2u
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:04 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SJ0-0006yC-Ru
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:59 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 80so17868393wrb.2
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:36 +0200
Message-Id: <1522071403-52486-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/16] vhost-user-test: do not hang if chardev
 creation failed
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

Before the chardev name fix, the following error may happen: "attempt
to add duplicate property 'chr-test' to object (type 'container')",
due to races.

Sadly, error_vprintf() uses g_test_message(), so you have to use
read the cryptic --debug-log to see it. Later, it would make sense to
use g_critical() instead, and catch errors with
g_test_expect_message() (in glib 2.34).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180215212552.26997-5-marcandre.lureau@redhat.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 22e9202..f87afee 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -494,6 +494,7 @@ static void test_server_create_chr(TestServer *server, const gchar *opt)
     chr = qemu_chr_new(server->chr_name, chr_path);
     g_free(chr_path);
 
+    g_assert_nonnull(chr);
     qemu_chr_fe_init(&server->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&server->chr, chr_can_read, chr_read,
                              chr_event, NULL, server, NULL, true);
-- 
1.8.3.1
