Received: from eggs.gnu.org ([2001:4830:134:3::10]:43369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNUD-0008HD-9K
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNUA-0000YN-18
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:44 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU9-0000Xp-KD
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id j10so10911291wru.4
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:29 +0000
Message-Id: <20181210152829.29271-14-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 13/13] tests/tcg: enable cris system tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Currently we don't actually run them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include          |   1 +
 tests/tcg/cris/Makefile                | 168 -------------------------
 tests/tcg/cris/Makefile.include        |   6 +
 tests/tcg/cris/Makefile.softmmu-target |  50 ++++++++
 4 files changed, 57 insertions(+), 168 deletions(-)
 delete mode 100644 tests/tcg/cris/Makefile
 create mode 100644 tests/tcg/cris/Makefile.include
 create mode 100644 tests/tcg/cris/Makefile.softmmu-target

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 9467e9d088..e1ed0df5f9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -128,6 +128,7 @@ docker-image-tricore-cross: docker-image-debian9
 DOCKER_PARTIAL_IMAGES += debian-alpha-cross debian-hppa-cross debian-m68k-cross debian-sh4-cross
 DOCKER_PARTIAL_IMAGES += debian-sparc64-cross debian-mips64-cross debian-riscv64-cross
 DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross fedora-i386-cross
+DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 
 # Rules for building linux-user powered images
 #
diff --git a/tests/tcg/cris/Makefile b/tests/tcg/cris/Makefile
deleted file mode 100644
index 664b30ce81..0000000000
--- a/tests/tcg/cris/Makefile
+++ /dev/null
@@ -1,168 +0,0 @@
--include ../../../config-host.mak
-
-CROSS=crisv32-axis-linux-gnu-
-SIM=../../../cris-linux-user/qemu-cris -L ./
-SIMG=cris-axis-linux-gnu-run --sysroot=./
-
-CC      = $(CROSS)gcc
-#AS      = $(CROSS)as
-AS	= $(CC) -x assembler-with-cpp
-SIZE    = $(CROSS)size
-LD      = $(CC)
-OBJCOPY = $(CROSS)objcopy
-
-# we rely on GCC inline:ing the stuff we tell it to in many places here.
-CFLAGS  = -Winline -Wall -g -O2 -static
-NOSTDFLAGS = -nostartfiles -nostdlib
-ASFLAGS += -g -Wa,-I,$(SRC_PATH)/tests/tcg/cris/
-LDLIBS  =
-NOSTDLIBS = -lgcc
-
-CRT        = crt.o
-SYS        = sys.o
-TESTCASES += check_abs.tst
-TESTCASES += check_addc.tst
-TESTCASES += check_addcm.tst
-TESTCASES += check_addcv17.tst
-TESTCASES += check_addo.tst
-TESTCASES += check_addoq.tst
-TESTCASES += check_addi.tst
-TESTCASES += check_addiv32.tst
-TESTCASES += check_addm.tst
-TESTCASES += check_addr.tst
-TESTCASES += check_addq.tst
-TESTCASES += check_addxc.tst
-TESTCASES += check_addxm.tst
-TESTCASES += check_addxr.tst
-TESTCASES += check_andc.tst
-TESTCASES += check_andm.tst
-TESTCASES += check_andr.tst
-TESTCASES += check_andq.tst
-TESTCASES += check_asr.tst
-TESTCASES += check_ba.tst
-TESTCASES += check_bas.tst
-TESTCASES += check_bcc.tst
-TESTCASES += check_bound.tst
-TESTCASES += check_boundc.tst
-TESTCASES += check_boundr.tst
-TESTCASES += check_btst.tst
-TESTCASES += check_clearfv32.tst
-TESTCASES += check_cmpc.tst
-TESTCASES += check_cmpr.tst
-TESTCASES += check_cmpq.tst
-TESTCASES += check_cmpm.tst
-TESTCASES += check_cmpxc.tst
-TESTCASES += check_cmpxm.tst
-TESTCASES += check_cmp-2.tst
-TESTCASES += check_clrjmp1.tst
-TESTCASES += check_dstep.tst
-TESTCASES += check_ftag.tst
-TESTCASES += check_int64.tst
-# check_jsr is broken.
-#TESTCASES += check_jsr.tst
-TESTCASES += check_mcp.tst
-TESTCASES += check_movei.tst
-TESTCASES += check_mover.tst
-TESTCASES += check_moverm.tst
-TESTCASES += check_moveq.tst
-TESTCASES += check_movemr.tst
-TESTCASES += check_movemrv32.tst
-TESTCASES += check_movecr.tst
-TESTCASES += check_movmp.tst
-TESTCASES += check_movpr.tst
-TESTCASES += check_movprv32.tst
-TESTCASES += check_movdelsr1.tst
-TESTCASES += check_movpmv32.tst
-TESTCASES += check_movsr.tst
-TESTCASES += check_movsm.tst
-TESTCASES += check_movscr.tst
-TESTCASES += check_movur.tst
-TESTCASES += check_movum.tst
-TESTCASES += check_movucr.tst
-TESTCASES += check_mulx.tst
-TESTCASES += check_mulv32.tst
-TESTCASES += check_neg.tst
-TESTCASES += check_not.tst
-TESTCASES += check_lz.tst
-TESTCASES += check_lapc.tst
-TESTCASES += check_lsl.tst
-TESTCASES += check_lsr.tst
-TESTCASES += check_orc.tst
-TESTCASES += check_orm.tst
-TESTCASES += check_orr.tst
-TESTCASES += check_orq.tst
-TESTCASES += check_ret.tst
-TESTCASES += check_swap.tst
-TESTCASES += check_scc.tst
-TESTCASES += check_subc.tst
-TESTCASES += check_subq.tst
-TESTCASES += check_subr.tst
-TESTCASES += check_subm.tst
-TESTCASES += check_glibc_kernelversion.tst
-TESTCASES += check_xarith.tst
-
-TESTCASES += check_hello.ctst
-TESTCASES += check_stat1.ctst
-TESTCASES += check_stat2.ctst
-TESTCASES += check_stat3.ctst
-TESTCASES += check_stat4.ctst
-TESTCASES += check_openpf1.ctst
-TESTCASES += check_openpf2.ctst
-TESTCASES += check_openpf3.ctst
-TESTCASES += check_openpf5.ctst
-TESTCASES += check_mapbrk.ctst
-TESTCASES += check_mmap1.ctst
-TESTCASES += check_mmap2.ctst
-TESTCASES += check_mmap3.ctst
-TESTCASES += check_sigalrm.ctst
-TESTCASES += check_time2.ctst
-TESTCASES += check_settls1.ctst
-
-TESTCASES += check_gcctorture_pr28634-1.ctst
-#TESTCASES += check_gcctorture_pr28634.ctst
-
-all: build
-
-%.o: $(SRC_PATH)/tests/tcg/cris/%.c
-	$(CC) $(CFLAGS) -c $< -o $@
-
-%.o: $(SRC_PATH)/tests/tcg/cris/%.s
-	$(AS) $(ASFLAGS) -c $< -o $@
-
-%.tst: %.o
-	$(CC) $(CFLAGS) $(NOSTDFLAGS) $(LDLIBS) $(NOSTDLIBS) $(CRT) $< $(SYS) -o $@
-
-%.ctst: %.o
-	$(CC) $(CFLAGS) $(LDLIBS) $< -o $@
-
-
-sysv10.o: sys.c
-	$(CC) $(CFLAGS) -mcpu=v10 -c $< -o $@
-
-crtv10.o: crt.s
-	$(AS) $(ASFLAGS) -mcpu=v10 -c $< -o $@
-
-check_addcv17.tst: ASFLAGS += -mcpu=v10
-check_addcv17.tst: CRT := crtv10.o
-check_addcv17.tst: SYS := sysv10.o
-check_addcv17.tst: crtv10.o sysv10.o
-
-build: $(CRT) $(SYS) $(TESTCASES)
-
-check: $(CRT) $(SYS) $(TESTCASES)
-	@printf "\nQEMU simulator.\n"
-	for case in $(TESTCASES); do \
-		printf %s "$$case "; \
-		SIMARGS=; \
-		case $$case in *v17*) SIMARGS="-cpu crisv17";; esac; \
-		$(SIM) $$SIMARGS ./$$case; \
-	done
-check-g: $(CRT) $(SYS) $(TESTCASES)
-	@printf "\nGDB simulator.\n"
-	@for case in $(TESTCASES); do \
-		printf %s "$$case "; \
-		$(SIMG) $$case; \
-	done
-
-clean:
-	$(RM) -fr $(TESTCASES) *.o
diff --git a/tests/tcg/cris/Makefile.include b/tests/tcg/cris/Makefile.include
new file mode 100644
index 0000000000..1c037824bf
--- /dev/null
+++ b/tests/tcg/cris/Makefile.include
@@ -0,0 +1,6 @@
+#
+# Makefile.include for all CRIS targets
+#
+
+DOCKER_IMAGE=fedora-cris-cross
+DOCKER_CROSS_COMPILER=cris-linux-gnu-gcc
diff --git a/tests/tcg/cris/Makefile.softmmu-target b/tests/tcg/cris/Makefile.softmmu-target
new file mode 100644
index 0000000000..988741f1b3
--- /dev/null
+++ b/tests/tcg/cris/Makefile.softmmu-target
@@ -0,0 +1,50 @@
+# -*- Mode: makefile -*-
+#
+# Cris softmmu tests
+#
+
+CRIS_SRC = $(SRC_PATH)/tests/tcg/cris/system
+CRIS_ALL = $(wildcard $(CRIS_SRC)/*.s)
+CRIS_TESTS = $(patsubst $(CRIS_SRC)/%.s, %, $(CRIS_ALL))
+# Filter out common blobs and broken tests
+CRIS_BROKEN_TESTS  = crt check_jsr
+# upstream GCC doesn't support v32
+CRIS_BROKEN_TESTS += check_mcp check_mulv32 check_addiv32 check_movpmv32
+CRIS_BROKEN_TESTS += check_movprv32 check_clearfv32 check_movemrv32 check_bas
+CRIS_BROKEN_TESTS += check_lapc check_movei
+# no sure why
+CRIS_BROKEN_TESTS += check_scc check_xarith
+
+CRIS_USABLE_TESTS = $(filter-out $(CRIS_BROKEN_TESTS), $(CRIS_TESTS))
+CRIS_RUNS = $(patsubst %, run-%, $(CRIS_USABLE_TESTS))
+
+# add to the list of tests
+TESTS += $(CRIS_USABLE_TESTS)
+VPATH += $(CRIS_SRC)
+
+AS	= $(CC) -x assembler-with-cpp
+LD      = $(CC)
+
+# we rely on GCC inline:ing the stuff we tell it to in many places here.
+CFLAGS  = -Winline -Wall -g -O2 -static
+NOSTDFLAGS = -nostartfiles -nostdlib
+ASFLAGS += -mcpu=v10 -g -Wa,-I,$(SRC_PATH)/tests/tcg/cris/system
+CRT_FILES = crt.o sys.o
+
+# stop make deleting crt files if build fails
+.PRECIOUS: $(CRT_FILES)
+
+%.o: %.c
+	$(CC) -c $< -o $@
+
+%.o: %.s
+	$(AS) $(ASFLAGS) -c $< -o $@
+
+%: %.s $(CRT_FILES)
+	$(CC) $(ASFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT_FILES)
+
+# Currently we skip these as the system tests originally targeted the
+# GNU Simulator and probably need some crafting to load as a kernel
+# into QEMU
+$(CRIS_RUNS):
+	$(call skip-test, $@, "NEEDS MAGIC INVOCATION")
-- 
2.17.1
