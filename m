Received: from eggs.gnu.org ([2001:4830:134:3::10]:50399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS46-00034R-Lu
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS41-0004f0-TJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:14 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS41-0004eg-M8
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:09 -0500
Received: by mail-wm0-x22a.google.com with SMTP id 143so8638785wma.5
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:18:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:17:04 +0100
Message-Id: <1516112253-14480-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/51] tests: fix coroutine leak in
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The coroutine is not finished by the time the test ends, resulting in
ASAN warning:

==7005==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 312 byte(s) in 1 object(s) allocated from:
    #0 0x7fd35290fa38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea38)
    #1 0x7fd3506c5f75 in g_malloc0 ../glib/gmem.c:124
    #2 0x55994af03e47 in qemu_coroutine_new /home/elmarco/src/qemu/util/coroutine-ucontext.c:144
    #3 0x55994aefed99 in qemu_coroutine_create /home/elmarco/src/qemu/util/qemu-coroutine.c:76
    #4 0x55994ac1eb50 in verify_entered_step_1 /home/elmarco/src/qemu/tests/test-coroutine.c:80
    #5 0x55994af03c75 in coroutine_trampoline /home/elmarco/src/qemu/util/coroutine-ucontext.c:119
    #6 0x7fd34ec02bef  (/lib64/libc.so.6+0x50bef)

Do not yield() to let the coroutine terminate.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180104160523.22995-17-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-coroutine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index abd97c2..76c6461 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -67,7 +67,6 @@ static void coroutine_fn verify_entered_step_2(void *opaque)
     /* Once more to check it still works after yielding */
     g_assert(qemu_coroutine_entered(caller));
     g_assert(qemu_coroutine_entered(qemu_coroutine_self()));
-    qemu_coroutine_yield();
 }
 
 static void coroutine_fn verify_entered_step_1(void *opaque)
-- 
1.8.3.1
