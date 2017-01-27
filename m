Received: from eggs.gnu.org ([2001:4830:134:3::10]:33611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r2-000597-7D
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qz-00044B-Vz
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:16 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qz-00043h-Pi
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:13 -0500
Received: by mail-wm0-x244.google.com with SMTP id r144so58440563wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:13 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:29 +0100
Message-Id: <1485524749-118532-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/41] tests: fix linking test-char on win32
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

test.char.exe fails to link:
qemu-char.o: In function `win_chr_free':
/home/elmarco/src/qemu/qemu-char.c:2149: undefined reference to `qemu_del_polling_cb'
/home/elmarco/src/qemu/qemu-char.c:2151: undefined reference to `qemu_del_polling_cb'
qemu-char.o: In function `win_stdio_thread':
/home/elmarco/src/qemu/qemu-char.c:2568: undefined reference to `qemu_del_wait_object'
qemu-char.o: In function `qemu_chr_open_stdio':
/home/elmarco/src/qemu/qemu-char.c:2661: undefined reference to `qemu_add_wait_object'
/home/elmarco/src/qemu/qemu-char.c:2646: undefined reference to
`qemu_add_wait_object'
...

It needs main-loop.o symbols, among others. Linking with
$(test-block-obj-y) brings what's necessary. We could try to eventually
strip to the minimum if needed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 22ea256..33b4f88 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -510,7 +510,7 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom-obj-y)
 tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y)
 
-tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y)
+tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)
 tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
-- 
1.8.3.1
