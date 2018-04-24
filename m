Received: from eggs.gnu.org ([2001:4830:134:3::10]:50302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzwR-0005wk-En
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzwO-0001Ld-5q
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:15 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAzwN-0001Kd-VI
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:12 -0400
Received: by mail-wm0-x243.google.com with SMTP id j5so1609397wme.5
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:33:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:23:42 +0100
Message-Id: <20180424152405.10304-24-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 23/46] tests/tcg/x86_64: add Makefile.target
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
index 80ccad3d7b..27086c3f2b 100644
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
