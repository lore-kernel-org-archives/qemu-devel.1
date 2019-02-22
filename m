Received: from eggs.gnu.org ([209.51.188.92]:41839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7Xp-0006iL-Bz
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7Xo-0007dX-8p
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:01 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gx7Xf-0007An-TS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:54:55 -0500
Received: by mail-wr1-x42d.google.com with SMTP id n2so1646488wrw.8
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 01:54:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 09:54:21 +0000
Message-Id: <20190222095421.28938-10-alex.bennee@linaro.org>
In-Reply-To: <20190222095421.28938-1-alex.bennee@linaro.org>
References: <20190222095421.28938-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 9/9] tests/cdrom-test: only include isapc cdrom
 test when g_test_slow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

We are seeing instability on our CI runs which has been there since
the test was introduced. I suspect it triggers more on Travis due to
their heavy load.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>

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
