Received: from eggs.gnu.org ([2001:4830:134:3::10]:40793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPuMC-0000Vc-1f
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPuMB-0002SD-Aa
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:32:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dPuMB-0002R8-3m
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:32:55 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 18:32:48 +0100
Message-Id: <1498584769-12439-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
References: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v3 1/2] tests/test-char.c: Don't use
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
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

In QEMU's main_loop() we used to check whether we should do
a nonblocking call to main_loop(); this was deleted in commit e330c118f2a5,
because now that vCPUs always drop the I/O thread lock it is an unnecessary
optimization.

The loop in test-char.c copied the old QEMU main_loop() code, but
here the nonblocking check has never been necessary because this
standalone test case doesn't hold the I/O lock anyway. Remove it,
so we can drop the main_loop_wait() return value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/test-char.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 9e361c8..94ef708 100644
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
2.7.4
