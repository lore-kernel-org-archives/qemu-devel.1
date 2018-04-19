Received: from eggs.gnu.org ([2001:4830:134:3::10]:42838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5r-0006Ab-BZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5q-0002h2-CD
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:23 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9A5q-0002er-52
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:22 -0400
Received: by mail-wr0-x241.google.com with SMTP id w3-v6so14354563wrg.2
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:59:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:40 +0100
Message-Id: <20180419135901.30035-23-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 22/43] tests/tcg/x86_64: add Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The sources for x86_64 are shared in the i386 directory which will be
included thanks to TARGET_BASE_ARCH. However not all sources build so
we need to filter out the ones we can't build in the 64 bit world.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.target   |  2 +-
 tests/tcg/x86_64/Makefile.target | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/x86_64/Makefile.target

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index a6cc76664c..3a2736616c 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -7,7 +7,7 @@ VPATH 		+= $(I386_SRC)
 
 I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
 I386_TESTS=$(I386_SRCS:.c=)
-
+I386_ONLY_TESTS=$(filter-out test-i386-ssse3, $(I386_TESTS))
 # Update TESTS
 TESTS+=$(I386_ONLY_TESTS)
 
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
new file mode 100644
index 0000000000..74f170b9ed
--- /dev/null
+++ b/tests/tcg/x86_64/Makefile.target
@@ -0,0 +1,15 @@
+# -*- Mode: makefile -*-
+#
+# x86_64 tests - included from tests/tcg/Makefile.target
+#
+# Currently we only build test-x86_64 and test-i386-ssse3 from
+# $(SRC)/tests/tcg/i386/
+#
+
+X86_64_TESTS=$(filter-out $(I386_ONLY_TESTS), $(TESTS))
+X86_64_TESTS+=test-x86_64
+TESTS:=$(X86_64_TESTS)
+
+test-x86_64: LDFLAGS+=-lm -lc
+test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
+	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
-- 
2.17.0
