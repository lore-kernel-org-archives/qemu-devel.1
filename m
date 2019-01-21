Received: from eggs.gnu.org ([209.51.188.92]:51678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy7-0004Mb-2y
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy6-00049N-8S
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:43 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldy6-00048i-0k
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:42 -0500
Received: by mail-wr1-x435.google.com with SMTP id q18so24433738wrx.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:49 +0100
Message-Id: <1548093980-43088-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/49] tests/hexloader-test: Don't pass
 -nographic to the QEMU under test
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
Message-Id: <20190104145018.16950-1-peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
