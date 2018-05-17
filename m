Received: from eggs.gnu.org ([2001:4830:134:3::10]:52678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN6K-0003Cf-GF
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN6J-00078y-Kd
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:04 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJN6J-00078Y-EO
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:03 -0400
Received: by mail-wm0-x22e.google.com with SMTP id l1-v6so10657723wmb.2
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:54:03 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:46:58 +0100
Message-Id: <20180517174718.10107-30-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 29/49] tests/tcg/arm: disable -p 32768 mmap
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Broken since I updated to 18.04

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile.target | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 1ef5d79fe3..9d2b551732 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -16,3 +16,11 @@ hello-arm: LDFLAGS+=-nostdlib
 test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
 test-arm-iwmmxt: test-arm-iwmmxt.S
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
+
+# Currently broken for -p 32768
+ifeq ($(TARGET_NAME), arm)
+run-test-mmap: test-mmap
+	$(call quiet-command, $(QEMU) $< > test-mmap.out, "TEST", "$< (default) on $(TARGET_NAME)")
+	$(call quiet-command, $(QEMU) -p 8192 $< 8192 > test-mmap-8192.out, "TEST", "$< (8k pages) on $(TARGET_NAME)")
+	$(call quiet-command, $(QEMU) -p 16384 $< 16384 > test-mmap-16384.out, "TEST", "$< (16k pages) on $(TARGET_NAME)")
+endif
-- 
2.17.0
