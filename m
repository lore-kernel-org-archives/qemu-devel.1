Received: from eggs.gnu.org ([209.51.188.92]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggdR4-0006OZ-2h
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggdR3-000884-5v
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:31:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ggdR3-00087I-0I
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:31:53 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  7 Jan 2019 23:31:46 +0100
Message-Id: <20190107223147.14269-2-pbonzini@redhat.com>
In-Reply-To: <20190107223147.14269-1-pbonzini@redhat.com>
References: <20190107223147.14269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/35] tests/hexloader-test: Don't pass
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

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
index 834ed52c22..8b7aa2d72d 100644
--- a/tests/hexloader-test.c
+++ b/tests/hexloader-test.c
@@ -23,7 +23,7 @@ static void hex_loader_test(void)
     const unsigned int base_addr =3D 0x00010000;
=20
     QTestState *s =3D qtest_initf(
-        "-M vexpress-a9 -nographic -device loader,file=3Dtests/data/hex-=
loader/test.hex");
+        "-M vexpress-a9 -device loader,file=3Dtests/data/hex-loader/test=
.hex");
=20
     for (i =3D 0; i < 256; ++i) {
         uint8_t val =3D qtest_readb(s, base_addr + i);
--=20
2.20.1
