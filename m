Received: from eggs.gnu.org ([209.51.188.92]:36322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwobA-0001hI-0R
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwob8-00048k-Ox
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:41:11 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwob8-00047g-Hp
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:41:10 -0500
Received: by mail-wr1-x442.google.com with SMTP id d17so15821303wre.10
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 05:41:10 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Feb 2019 13:41:01 +0000
Message-Id: <20190221134101.13903-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tests/cdrom-test: only include isapc cdrom
 test when g_test_slow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We are seeing instability on our CI runs which has been there since
the test was introduced. I suspect it triggers more on Travis due to
their heavy load.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/cdrom-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 14bd981336..05611da648 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -132,8 +132,14 @@ static void add_x86_tests(void)
     qtest_add_data_func("cdrom/boot/virtio-scsi",
                         "-device virtio-scsi -device scsi-cd,drive=cdr "
                         "-blockdev file,node-name=cdr,filename=", test_cdboot);
-    qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
-                        "-drive if=ide,media=cdrom,file=", test_cdboot);
+    /*
+     * Unstable CI test under load
+     * See https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05509.html
+     */
+    if (g_test_slow()) {
+        qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
+                            "-drive if=ide,media=cdrom,file=", test_cdboot);
+    }
     qtest_add_data_func("cdrom/boot/am53c974",
                         "-device am53c974 -device scsi-cd,drive=cd1 "
                         "-drive if=none,id=cd1,format=raw,file=", test_cdboot);
-- 
2.20.1
