Received: from eggs.gnu.org ([2001:4830:134:3::10]:45934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4r-0004Xw-VO
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4m-0007ZT-8Y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:54 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:39453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVJ4m-0007Z3-1J
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:48 -0400
Received: by mail-wm0-x22f.google.com with SMTP id p11-v6so1407498wmc.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:01:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:43:58 +0100
Message-Id: <20180619154435.18898-20-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/56] tests/tcg/x86_64: add Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The sources for x86_64 are shared in the i386 directory which will be
included thanks to TARGET_BASE_ARCH. However not all sources build so
we need to filter out the ones we can't build in the 64 bit world and
those that can't be built for 32 bit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v4
  - update MAINTAINERS
v5
  - merge with disable i386 version of test-i386-ssse

diff --git a/MAINTAINERS b/MAINTAINERS
index ea298cc910..57c828644f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -284,6 +284,7 @@ M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
 F: target/i386/
 F: tests/tcg/i386/
+F: tests/tcg/x86_64/
 F: hw/i386/
 F: disas/i386.c
 T: git git://github.com/ehabkost/qemu.git x86-next
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 64d241cfdf..cd173363ee 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -7,9 +7,9 @@ VPATH 		+= $(I386_SRC)
 
 I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
 I386_TESTS=$(I386_SRCS:.c=)
-
+I386_ONLY_TESTS=$(filter-out test-i386-ssse3, $(I386_TESTS))
 # Update TESTS
-TESTS+=$(I386_TESTS)
+TESTS+=$(I386_ONLY_TESTS)
 
 ifneq ($(TARGET_NAME),x86_64)
 CFLAGS+=-m32
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
2.17.1
