Received: from eggs.gnu.org ([209.51.188.92]:44961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz5D-0005nm-Bd
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz5B-0007gy-Lh
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:03:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz5B-0007ga-FD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:03:01 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:20 +0100
Message-Id: <1547460140-1473-26-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 25/25] tests/hexloader-test: Don't pass
 -nographic to the QEMU under test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Peter Maydell <peter.maydell@linaro.org>

The hexloader test invokes QEMU with the -nographic argument. This
is unnecessary, because the qtest_initf() function will pass it
-display none, which suffices to disable the graphical window.
It also means that the QEMU process will make the stdin/stdout
O_NONBLOCK. Since O_NONBLOCK is not per-file descriptor but per
"file description", this non-blocking behaviour is then shared
with any other process that's using the stdin/stdout of the
'make check' run, including make itself. This can result in make
falling over with "make: write error: stdout" because it got
an unexpected EINTR trying to write output messages to the terminal.
This is particularly noticable if running 'make check' in a loop with
  while make check; do true; done
(It does not affect single make check runs so much because the
shell will remove the O_NONBLOCK status before it reads the
terminal for interactive input.)

Remove the unwanted -nographic argument.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/hexloader-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/hexloader-test.c b/tests/hexloader-test.c
index 834ed52..8b7aa2d 100644
--- a/tests/hexloader-test.c
+++ b/tests/hexloader-test.c
@@ -23,7 +23,7 @@ static void hex_loader_test(void)
     const unsigned int base_addr = 0x00010000;
 
     QTestState *s = qtest_initf(
-        "-M vexpress-a9 -nographic -device loader,file=tests/data/hex-loader/test.hex");
+        "-M vexpress-a9 -device loader,file=tests/data/hex-loader/test.hex");
 
     for (i = 0; i < 256; ++i) {
         uint8_t val = qtest_readb(s, base_addr + i);
-- 
1.8.3.1
