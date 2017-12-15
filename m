Received: from eggs.gnu.org ([2001:4830:134:3::10]:42650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePrar-0004pz-52
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePran-0001og-2H
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:08:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ePram-0001oR-Sh
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:08:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 322CFC04AC45
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:08:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Dec 2017 16:06:59 +0100
Message-Id: <20171215150659.1811-14-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-1-marcandre.lureau@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/13] tests: fix coroutine leak in
 /basic/entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The coroutine is not finished by the time the test ends, resulting in
ASAN warning:

=3D=3D7005=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 312 byte(s) in 1 object(s) allocated from:
    #0 0x7fd35290fa38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea3=
8)
    #1 0x7fd3506c5f75 in g_malloc0 ../glib/gmem.c:124
    #2 0x55994af03e47 in qemu_coroutine_new /home/elmarco/src/qemu/util/c=
oroutine-ucontext.c:144
    #3 0x55994aefed99 in qemu_coroutine_create /home/elmarco/src/qemu/uti=
l/qemu-coroutine.c:76
    #4 0x55994ac1eb50 in verify_entered_step_1 /home/elmarco/src/qemu/tes=
ts/test-coroutine.c:80
    #5 0x55994af03c75 in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:119
    #6 0x7fd34ec02bef  (/lib64/libc.so.6+0x50bef)

Do not yield() to let the coroutine terminate.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-coroutine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index abd97c23c1..76c646107e 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -67,7 +67,6 @@ static void coroutine_fn verify_entered_step_2(void *op=
aque)
     /* Once more to check it still works after yielding */
     g_assert(qemu_coroutine_entered(caller));
     g_assert(qemu_coroutine_entered(qemu_coroutine_self()));
-    qemu_coroutine_yield();
 }
=20
 static void coroutine_fn verify_entered_step_1(void *opaque)
--=20
2.15.1.355.g36791d7216
