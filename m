Received: from eggs.gnu.org ([2001:4830:134:3::10]:39673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsqed-0001Xj-Us
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsqed-0004L5-2q
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:32:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsqec-0004Kb-P6
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:32:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70ED97A7E9
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 14:32:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Aug 2018 16:31:24 +0200
Message-Id: <20180823143125.16767-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180823143125.16767-1-marcandre.lureau@redhat.com>
References: <20180823143125.16767-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/5] test-char: fix random socket test
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Peter reported a test failure on FreeBSD with the new reconnect test:

MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=3Dquick tests/test-char
TEST: tests/test-char... (pid=3D16190)
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
  /char/socket/reconnect:                                              FA=
IL
GTester: last random seed: R02S521380d9c12f1dac3ad1763bf5665c27
(pid=3D16367)
  /char/socket/fdpass:                                                 OK
FAIL: tests/test-char
**
ERROR:tests/test-char.c:353:char_socket_test_common: assertion failed:
(object_property_get_bool(OBJECT(chr_client), "connected",
&error_abort))

It turns out that the socket test code checks both server and client
connection states, but doesn't wait for both.

Wait for the client side as well.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 5905d31441..2b1e400542 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -349,6 +349,12 @@ static void char_socket_test_common(Chardev *chr)
     g_assert_cmpint(id, >, 0);
     main_loop();
=20
+    d.chr =3D chr_client;
+    id =3D g_idle_add(char_socket_test_idle, &d);
+    g_source_set_name_by_id(id, "test-idle");
+    g_assert_cmpint(id, >, 0);
+    main_loop();
+
     g_assert(object_property_get_bool(OBJECT(chr), "connected", &error_a=
bort));
     g_assert(object_property_get_bool(OBJECT(chr_client),
                                       "connected", &error_abort));
@@ -358,6 +364,7 @@ static void char_socket_test_common(Chardev *chr)
=20
     object_unparent(OBJECT(chr_client));
=20
+    d.chr =3D chr;
     d.conn_expected =3D false;
     g_idle_add(char_socket_test_idle, &d);
     main_loop();
--=20
2.18.0.547.g1d89318c48
