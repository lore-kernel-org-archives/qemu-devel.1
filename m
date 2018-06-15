Received: from eggs.gnu.org ([2001:4830:134:3::10]:56212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyL-0000e0-IP
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyH-0007oY-Hq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:25 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuyG-0007nS-Qm
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:20 -0400
Received: by mail-wm0-x243.google.com with SMTP id e16-v6so5264765wmd.0
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:05:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:35 +0100
Message-Id: <20180615194705.28019-25-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 24/54] tests/tcg/arm: fix up test-arm-iwmmxt
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

We need to rename the source file to a .S so we can do a single-line
assemble and link invocation. We also specify the additional CFLAGS
for the compile as it's a non-standard ARM binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[rth: force fpu configuration]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4
  - include rth's -mfpu=fpv4-sp-d16
v5
  - merge fixes
---
 tests/tcg/arm/Makefile.target                          | 5 +++++
 tests/tcg/arm/{test-arm-iwmmxt.s => test-arm-iwmmxt.S} | 0
 2 files changed, 5 insertions(+)
 rename tests/tcg/arm/{test-arm-iwmmxt.s => test-arm-iwmmxt.S} (100%)

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0312293dca..cadb385890 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -8,9 +8,14 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
 
+TESTS += hello-arm test-arm-iwmmxt
 
 hello-arm: CFLAGS+=-marm -ffreestanding
 hello-arm: LDFLAGS+=-nostdlib
 
+test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
+test-arm-iwmmxt: test-arm-iwmmxt.S
+	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
+
 # On ARM Linux only supports 4k pages
 EXTRA_RUNS+=run-test-mmap-4096
diff --git a/tests/tcg/arm/test-arm-iwmmxt.s b/tests/tcg/arm/test-arm-iwmmxt.S
similarity index 100%
rename from tests/tcg/arm/test-arm-iwmmxt.s
rename to tests/tcg/arm/test-arm-iwmmxt.S
-- 
2.17.1
