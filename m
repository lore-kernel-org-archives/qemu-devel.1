Received: from eggs.gnu.org ([2001:4830:134:3::10]:47297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADt-0004Xs-OP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADs-0005LT-KS
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:41 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ADs-0005HQ-9X
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:40 -0400
Received: by mail-wr0-x244.google.com with SMTP id u11-v6so14408163wri.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:07:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:59:00 +0100
Message-Id: <20180419135901.30035-43-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 42/43] tests/tcg: disable fp-test for 32 bit
 (HACK!)
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

This prevents us trying to build fp-test for 32 bit guests as they
would fail due to pollution from config-host.h when including osdep.h.
As keeping softfloat.o would be useful maybe we can conditionally
disabled it?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 52adc18625..8bf6f3f8dc 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -31,6 +31,7 @@ run-test-mmap: test-mmap
 #
 # Include the fp-test from the main test suite
 #
+ifneq (,$(findstring 64,$(TARGET_NAME)))
 
 VPATH+=$(SRC_PATH)/tests/fp
 VPATH+=$(SRC_PATH)/fpu
@@ -46,3 +47,4 @@ fp-test.o softfloat.o: %.o: %.c
 fp-test: fp-test.o softfloat.o
 	$(CC) $^ -o $@ -lm -static
 
+endif
-- 
2.17.0
