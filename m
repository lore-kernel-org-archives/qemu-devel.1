Received: from eggs.gnu.org ([2001:4830:134:3::10]:47117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0Wy-000522-QN
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0Wu-0007g6-S3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0Wu-0007fe-M6
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:16 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7AD23D94D
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:47:51 +0100
Message-Id: <20170110174810.17748-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/20] tests: fix linking test-char on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

test.char.exe fails to link:
qemu-char.o: In function `win_chr_free':
/home/elmarco/src/qemu/qemu-char.c:2149: undefined reference to `qemu_del=
_polling_cb'
/home/elmarco/src/qemu/qemu-char.c:2151: undefined reference to `qemu_del=
_polling_cb'
qemu-char.o: In function `win_stdio_thread':
/home/elmarco/src/qemu/qemu-char.c:2568: undefined reference to `qemu_del=
_wait_object'
qemu-char.o: In function `qemu_chr_open_stdio':
/home/elmarco/src/qemu/qemu-char.c:2661: undefined reference to `qemu_add=
_wait_object'
/home/elmarco/src/qemu/qemu-char.c:2646: undefined reference to
`qemu_add_wait_object'
...

It needs main-loop.o symbols, among others. Linking with
$(test-block-obj-y) brings what's necessary. We could try to eventually
strip to the minimum if needed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f776404d86..8368254ddd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -489,7 +489,7 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $(tes=
t-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-q=
om-obj-y)
 tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom=
-obj-y)
=20
-tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(t=
est-util-obj-y) $(qtest-obj-y) $(test-io-obj-y)
+tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(t=
est-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)
 tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y=
)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
--=20
2.11.0
