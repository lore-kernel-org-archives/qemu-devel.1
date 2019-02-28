Received: from eggs.gnu.org ([209.51.188.92]:42653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFX-0000RW-98
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFW-0007MD-8k
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFW-0007K2-1v
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id d17so23389347wre.10
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:45 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:28 +0000
Message-Id: <20190228202537.4638-8-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/16] tests/tcg/xtensa: enable system tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use cross CC for linker
  - fix up test selection to skip linker.ld.S
---
 tests/tcg/xtensa/Makefile                | 93 ------------------------
 tests/tcg/xtensa/Makefile.softmmu-target | 40 ++++++++++
 2 files changed, 40 insertions(+), 93 deletions(-)
 delete mode 100644 tests/tcg/xtensa/Makefile
 create mode 100644 tests/tcg/xtensa/Makefile.softmmu-target

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
deleted file mode 100644
index 2f5691f75b..0000000000
--- a/tests/tcg/xtensa/Makefile
+++ /dev/null
@@ -1,93 +0,0 @@
--include ../../../config-host.mak
-
-CORE=dc232b
-CROSS=xtensa-$(CORE)-elf-
-
-ifndef XT
-SIM = ../../../xtensa-softmmu/qemu-system-xtensa
-SIMFLAGS = -M sim -cpu $(CORE) -nographic -semihosting -icount 6 $(EXTFLAGS) -kernel
-SIMDEBUG = -s -S
-else
-SIM = xt-run
-SIMFLAGS = --xtensa-core=DC_B_232L --exit_with_target_code $(EXTFLAGS)
-SIMDEBUG = --gdbserve=0
-endif
-
-HOST_CC = gcc
-CC      = $(CROSS)gcc
-AS      = $(CROSS)gcc -x assembler-with-cpp
-LD      = $(CROSS)ld
-
-XTENSA_SRC_PATH = $(SRC_PATH)/tests/tcg/xtensa
-INCLUDE_DIRS = $(XTENSA_SRC_PATH) $(SRC_PATH)/target/xtensa/core-$(CORE)
-XTENSA_INC = $(addprefix -I,$(INCLUDE_DIRS))
-
-LDFLAGS = -Tlinker.ld
-
-CRT        = crt.o vectors.o
-
-TESTCASES += test_b.tst
-TESTCASES += test_bi.tst
-#TESTCASES += test_boolean.tst
-TESTCASES += test_break.tst
-TESTCASES += test_bz.tst
-TESTCASES += test_cache.tst
-TESTCASES += test_clamps.tst
-TESTCASES += test_extui.tst
-TESTCASES += test_fail.tst
-TESTCASES += test_interrupt.tst
-TESTCASES += test_loop.tst
-TESTCASES += test_mac16.tst
-TESTCASES += test_max.tst
-TESTCASES += test_min.tst
-TESTCASES += test_mmu.tst
-TESTCASES += test_mul16.tst
-TESTCASES += test_mul32.tst
-TESTCASES += test_nsa.tst
-TESTCASES += test_phys_mem.tst
-ifdef XT
-TESTCASES += test_pipeline.tst
-endif
-TESTCASES += test_quo.tst
-TESTCASES += test_rem.tst
-TESTCASES += test_rst0.tst
-TESTCASES += test_s32c1i.tst
-TESTCASES += test_sar.tst
-TESTCASES += test_sext.tst
-TESTCASES += test_shift.tst
-TESTCASES += test_sr.tst
-TESTCASES += test_timer.tst
-TESTCASES += test_windowed.tst
-
-all: build
-
-linker.ld: $(XTENSA_SRC_PATH)/linker.ld.S
-	$(HOST_CC) $(XTENSA_INC) -E -P $< -o $@
-
-%.o: $(XTENSA_SRC_PATH)/%.c
-	$(CC) $(XTENSA_INC) $(CFLAGS) -c $< -o $@
-
-%.o: $(XTENSA_SRC_PATH)/%.S
-	$(CC) $(XTENSA_INC) $(ASFLAGS) -c $< -o $@
-
-%.tst: %.o linker.ld $(XTENSA_SRC_PATH)/macros.inc $(CRT) Makefile
-	$(LD) $(LDFLAGS) $(NOSTDFLAGS) $(CRT) $< -o $@
-
-build: $(TESTCASES)
-
-check: $(addprefix run-, $(TESTCASES))
-
-run-%.tst: %.tst
-	$(SIM) $(SIMFLAGS) ./$<
-
-run-test_fail.tst: test_fail.tst
-	! $(SIM) $(SIMFLAGS) ./$<
-
-debug-%.tst: %.tst
-	$(SIM) $(SIMDEBUG) $(SIMFLAGS) ./$<
-
-host-debug-%.tst: %.tst
-	gdb --args $(SIM) $(SIMFLAGS) ./$<
-
-clean:
-	$(RM) -fr $(TESTCASES) $(CRT) linker.ld
diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/Makefile.softmmu-target
new file mode 100644
index 0000000000..1a4014506f
--- /dev/null
+++ b/tests/tcg/xtensa/Makefile.softmmu-target
@@ -0,0 +1,40 @@
+#
+# Xtensa softmmu tests
+#
+
+ifneq ($(TARGET_WORDS_BIGENDIAN),y)
+
+XTENSA_SRC = $(SRC_PATH)/tests/tcg/xtensa
+XTENSA_ALL = $(filter-out $(XTENSA_SRC)/linker.ld.S,$(wildcard $(XTENSA_SRC)/*.S))
+XTENSA_TESTS = $(patsubst $(XTENSA_SRC)/%.S, %, $(XTENSA_ALL))
+# Filter out common blobs and broken tests
+XTENSA_BROKEN_TESTS  = crt vectors test_boolean test_pipeline test_fail
+XTENSA_USABLE_TESTS = $(filter-out $(XTENSA_BROKEN_TESTS), $(XTENSA_TESTS))
+
+# add to the list of tests
+TESTS += $(XTENSA_USABLE_TESTS)
+VPATH += $(XTENSA_SRC)
+
+CORE=dc232b
+QEMU_OPTS+=-M sim -cpu $(CORE) -nographic -semihosting -icount 6 $(EXTFLAGS) -kernel
+
+INCLUDE_DIRS = $(SRC_PATH)/target/xtensa/core-$(CORE)
+XTENSA_INC = $(addprefix -I,$(INCLUDE_DIRS))
+
+LDFLAGS = -Tlinker.ld -nostartfiles -nostdlib
+
+CRT        = crt.o vectors.o
+
+linker.ld: linker.ld.S
+	$(CC) $(XTENSA_INC) -E -P $< -o $@
+
+$(XTENSA_USABLE_TESTS): linker.ld macros.inc $(CRT) Makefile.softmmu-target
+
+# special rule for common blobs
+%.o: %.S
+	$(CC) $(XTENSA_INC) $(ASFLAGS) -c $< -o $@
+
+%: %.S
+	$(CC) $(XTENSA_INC) $(ASFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT)
+
+endif
-- 
2.20.1
