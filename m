Received: from eggs.gnu.org ([2001:4830:134:3::10]:46985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1g7ONr-0006fZ-JQ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1g7ONp-0006It-VS
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:39421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1g7ONp-0006Ie-OU
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id q8-v6so2972116wmq.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 10:22:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  2 Oct 2018 19:22:46 +0200
Message-Id: <1538500966-5506-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1538500966-5506-1-git-send-email-pbonzini@redhat.com>
References: <1538500966-5506-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 53/80] test-char: fix random socket test failure
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

Peter reported a test failure on FreeBSD with the new reconnect test:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=quick tests/test-char
TEST: tests/test-char... (pid=16190)
  /char/null:                                                          OK
  /char/invalid:                                                       OK
  /char/ringbuf:                                                       OK
  /char/mux:                                                           OK
  /char/stdio:                                                         OK
  /char/pipe:                                                          OK
  /char/file:                                                          OK
  /char/file-fifo:                                                     OK
  /char/udp:                                                           OK
  /char/serial:                                                        OK
  /char/hotswap:                                                       OK
  /char/socket/basic:                                                  OK
  /char/socket/reconnect:                                              FAIL
GTester: last random seed: R02S521380d9c12f1dac3ad1763bf5665c27
(pid=16367)
  /char/socket/fdpass:                                                 OK
FAIL: tests/test-char
**
ERROR:tests/test-char.c:353:char_socket_test_common: assertion failed:
(object_property_get_bool(OBJECT(chr_client), "connected",
&error_abort))

It turns out that the socket test code checks both server and client
connection states, but doesn't wait for both.

Wait for the client side as well.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180823143125.16767-5-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 2a2ff32..431577a 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -347,6 +347,12 @@ static void char_socket_test_common(Chardev *chr)
     g_assert_cmpint(id, >, 0);
     main_loop();
 
+    d.chr = chr_client;
+    id = g_idle_add(char_socket_test_idle, &d);
+    g_source_set_name_by_id(id, "test-idle");
+    g_assert_cmpint(id, >, 0);
+    main_loop();
+
     g_assert(object_property_get_bool(OBJECT(chr), "connected", &error_abort));
     g_assert(object_property_get_bool(OBJECT(chr_client),
                                       "connected", &error_abort));
@@ -356,6 +362,7 @@ static void char_socket_test_common(Chardev *chr)
 
     object_unparent(OBJECT(chr_client));
 
+    d.chr = chr;
     d.conn_expected = false;
     g_idle_add(char_socket_test_idle, &d);
     main_loop();
-- 
1.8.3.1
