Received: from eggs.gnu.org ([2001:4830:134:3::10]:46564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWl-0004c4-4g
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWk-0007fk-2Z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:11 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWj-0007fC-TR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:10 -0400
Received: by mail-wm0-x241.google.com with SMTP id p204so30534602wmg.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:19 +0200
Message-Id: <1499238885-26161-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/42] tests/test-char.c: Don't use
 main_loop_wait()'s return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In QEMU's main_loop() we used to check whether we should do
a nonblocking call to main_loop(); this was deleted in commit e330c118f2a5,
because now that vCPUs always drop the I/O thread lock it is an unnecessary
optimization.

The loop in test-char.c copied the old QEMU main_loop() code, but
here the nonblocking check has never been necessary because this
standalone test case doesn't hold the I/O lock anyway. Remove it,
so we can drop the main_loop_wait() return value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1498584769-12439-2-git-send-email-peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 87c724c..b962063 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -20,13 +20,9 @@ typedef struct FeHandler {
 
 static void main_loop(void)
 {
-    bool nonblocking;
-    int last_io = 0;
-
     quit = false;
     do {
-        nonblocking = last_io > 0;
-        last_io = main_loop_wait(nonblocking);
+        main_loop_wait(false);
     } while (!quit);
 }
 
-- 
1.8.3.1
