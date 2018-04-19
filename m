Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANX-0004mT-Fm
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANU-00068x-5L
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:38 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ANT-00068H-Uf
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:36 -0400
Received: by mail-wr0-x242.google.com with SMTP id h3-v6so14534057wrh.5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:17:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:59 +0100
Message-Id: <20180419135901.30035-42-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 41/43] tests/tcg/multiarch: add fp-test into
 multiarch set
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

The compile for fp-test is a little funky as we need to include a
build of QEMU's softfloat as well. There is still a problem caused by
the inclusion of config-host.h by osdep.h as it will trigger problems
like:

  In file included from /home/alex/lsrc/qemu/qemu.git/include/qemu/bitops.h:16:0,
                   from /home/alex/lsrc/qemu/qemu.git/fpu/softfloat.c:87:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h: In function ‘mulu64’:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/host-utils.h:35:5: error: unknown type name ‘__uint128_t’
       __uint128_t r = (__uint128_t)a * b;
     ^

When trying to cross build i386 on an x86_64 host.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index a691fd59d3..52adc18625 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -28,3 +28,21 @@ run-test-mmap: test-mmap
 	-$(QEMU) -p 16384 ./test-mmap 16384
 	-$(QEMU) -p 32768 ./test-mmap 32768
 
+#
+# Include the fp-test from the main test suite
+#
+
+VPATH+=$(SRC_PATH)/tests/fp
+VPATH+=$(SRC_PATH)/fpu
+TESTS+=fp-test
+
+FP_CFLAGS := $(CFLAGS) -Wall -O0 -g -fno-strict-aliasing
+FP_CFLAGS += $(QEMU_INCLUDES)
+FP_CFLAGS += -D_GNU_SOURCE -DHW_POISON_H
+
+fp-test.o softfloat.o: %.o: %.c
+	$(CC) $(FP_CFLAGS) -c $< -o $@
+
+fp-test: fp-test.o softfloat.o
+	$(CC) $^ -o $@ -lm -static
+
-- 
2.17.0
