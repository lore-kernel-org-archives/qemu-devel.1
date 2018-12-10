Received: from eggs.gnu.org ([2001:4830:134:3::10]:43272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU5-00085R-3w
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU3-0000Ue-6g
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:36 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU2-0000UG-Rp
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:35 -0500
Received: by mail-wm1-x341.google.com with SMTP id g67so11642428wmd.2
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:34 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:20 +0000
Message-Id: <20181210152829.29271-5-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 04/13] tests/tcg/mips: enable
 mips32-dsp/mips32-dspr2/mipsr5900 linux-user (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>

Convert the existing tests to use our common cross build
infrastructure.

[WIP: mips32r2 disabled to avoid name clash]
[WIP: mipsr5900 disabled due to clashing build flags]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/mips/Makefile.target       |  15 ++-
 tests/tcg/mips/mips32-dsp/Makefile   | 166 +++++----------------------
 tests/tcg/mips/mips32-dspr2/Makefile |  83 +++-----------
 tests/tcg/mips/mipsr5900/Makefile    |  40 +++----
 4 files changed, 75 insertions(+), 229 deletions(-)

diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 086625f533..33bb25bf8d 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -15,8 +15,17 @@ TESTS += $(MIPS_TESTS)
 hello-mips: CFLAGS+=-ffreestanding
 hello-mips: LDFLAGS+=-nostdlib
 
-# For MIPS32 and 64 we have a bunch of extra tests in sub-directories
-# however they are intended for system tests.
-
 run-hello-mips: hello-mips
 	$(call skip-test, $<, "BROKEN")
+
+# For MIPS32 and mipsr5900 we have a bunch of extra tests in sub-directories
+
+ifeq ($(TARGET_NAME),mipsel)
+-include $(MIPS_SRC)/mips32-dsp/Makefile
+
+# FIXME: doesn't build - names clash with mips32-dsp
+#-include $(MIPS_SRC)/mips32-dspr2/Makefile
+
+# FIXME: the docker compiler can't build the binaries
+#-include $(MIPS_SRC)/mipsr5900/Makefile
+endif
diff --git a/tests/tcg/mips/mips32-dsp/Makefile b/tests/tcg/mips/mips32-dsp/Makefile
index c3a0a00944..df2dddceaa 100644
--- a/tests/tcg/mips/mips32-dsp/Makefile
+++ b/tests/tcg/mips/mips32-dsp/Makefile
@@ -1,136 +1,30 @@
--include ../../config-host.mak
-
-CROSS=mips64el-unknown-linux-gnu-
-
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu 74Kf
-
-CC      = $(CROSS)gcc
-CFLAGS  = -mabi=32 -march=mips32r2 -mgp32 -mdsp -static
-
-TESTCASES = absq_s_ph.tst
-TESTCASES += absq_s_w.tst
-TESTCASES += addq_ph.tst
-TESTCASES += addq_s_ph.tst
-TESTCASES += addq_s_w.tst
-TESTCASES += addsc.tst
-TESTCASES += addu_qb.tst
-TESTCASES += addu_s_qb.tst
-TESTCASES += addwc.tst
-TESTCASES += bitrev.tst
-TESTCASES += bposge32.tst
-TESTCASES += cmp_eq_ph.tst
-TESTCASES += cmpgu_eq_qb.tst
-TESTCASES += cmpgu_le_qb.tst
-TESTCASES += cmpgu_lt_qb.tst
-TESTCASES += cmp_le_ph.tst
-TESTCASES += cmp_lt_ph.tst
-TESTCASES += cmpu_eq_qb.tst
-TESTCASES += cmpu_le_qb.tst
-TESTCASES += cmpu_lt_qb.tst
-TESTCASES += dpaq_sa_l_w.tst
-TESTCASES += dpaq_s_w_ph.tst
-TESTCASES += dpau_h_qbl.tst
-TESTCASES += dpau_h_qbr.tst
-TESTCASES += dpsq_sa_l_w.tst
-TESTCASES += dpsq_s_w_ph.tst
-TESTCASES += dpsu_h_qbl.tst
-TESTCASES += dpsu_h_qbr.tst
-TESTCASES += extp.tst
-TESTCASES += extpdp.tst
-TESTCASES += extpdpv.tst
-TESTCASES += extpv.tst
-TESTCASES += extr_rs_w.tst
-TESTCASES += extr_r_w.tst
-TESTCASES += extr_s_h.tst
-TESTCASES += extrv_rs_w.tst
-TESTCASES += extrv_r_w.tst
-TESTCASES += extrv_s_h.tst
-TESTCASES += extrv_w.tst
-TESTCASES += extr_w.tst
-TESTCASES += insv.tst
-TESTCASES += lbux.tst
-TESTCASES += lhx.tst
-TESTCASES += lwx.tst
-TESTCASES += madd.tst
-TESTCASES += maddu.tst
-TESTCASES += maq_sa_w_phl.tst
-TESTCASES += maq_sa_w_phr.tst
-TESTCASES += maq_s_w_phl.tst
-TESTCASES += maq_s_w_phr.tst
-TESTCASES += mfhi.tst
-TESTCASES += mflo.tst
-TESTCASES += modsub.tst
-TESTCASES += msub.tst
-TESTCASES += msubu.tst
-TESTCASES += mthi.tst
-TESTCASES += mthlip.tst
-TESTCASES += mtlo.tst
-TESTCASES += muleq_s_w_phl.tst
-TESTCASES += muleq_s_w_phr.tst
-TESTCASES += muleu_s_ph_qbl.tst
-TESTCASES += muleu_s_ph_qbr.tst
-TESTCASES += mulq_rs_ph.tst
-TESTCASES += mult.tst
-TESTCASES += multu.tst
-TESTCASES += packrl_ph.tst
-TESTCASES += pick_ph.tst
-TESTCASES += pick_qb.tst
-TESTCASES += precequ_ph_qbla.tst
-TESTCASES += precequ_ph_qbl.tst
-TESTCASES += precequ_ph_qbra.tst
-TESTCASES += precequ_ph_qbr.tst
-TESTCASES += preceq_w_phl.tst
-TESTCASES += preceq_w_phr.tst
-TESTCASES += preceu_ph_qbla.tst
-TESTCASES += preceu_ph_qbl.tst
-TESTCASES += preceu_ph_qbra.tst
-TESTCASES += preceu_ph_qbr.tst
-TESTCASES += precrq_ph_w.tst
-TESTCASES += precrq_qb_ph.tst
-TESTCASES += precrq_rs_ph_w.tst
-TESTCASES += precrqu_s_qb_ph.tst
-TESTCASES += raddu_w_qb.tst
-TESTCASES += rddsp.tst
-TESTCASES += repl_ph.tst
-TESTCASES += repl_qb.tst
-TESTCASES += replv_ph.tst
-TESTCASES += replv_qb.tst
-TESTCASES += shilo.tst
-TESTCASES += shilov.tst
-TESTCASES += shll_ph.tst
-TESTCASES += shll_qb.tst
-TESTCASES += shll_s_ph.tst
-TESTCASES += shll_s_w.tst
-TESTCASES += shllv_ph.tst
-TESTCASES += shllv_qb.tst
-TESTCASES += shllv_s_ph.tst
-TESTCASES += shllv_s_w.tst
-TESTCASES += shra_ph.tst
-TESTCASES += shra_r_ph.tst
-TESTCASES += shra_r_w.tst
-TESTCASES += shrav_ph.tst
-TESTCASES += shrav_r_ph.tst
-TESTCASES += shrav_r_w.tst
-TESTCASES += shrl_qb.tst
-TESTCASES += shrlv_qb.tst
-TESTCASES += subq_ph.tst
-TESTCASES += subq_s_ph.tst
-TESTCASES += subq_s_w.tst
-TESTCASES += subu_qb.tst
-TESTCASES += subu_s_qb.tst
-TESTCASES += wrdsp.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-        $(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
+#
+# MIPS32-DSP linux-user tests
+#
+# We don't set the VPATH for these tests as we re-use the VPATH from
+# ../Makefile and add explicit paths for the source to avoid name clashes
+# between the various sub-dirs.
+#
+
+MIPS32DSP_SRC = $(SRC_PATH)/tests/tcg/mips/mips32-dsp
+MIPS32DSP_ALL = $(wildcard $(MIPS32DSP_SRC)/*.c)
+MIPS32DSP_TESTS = $(patsubst $(MIPS32DSP_SRC)/%.c, mips32-dsp/%, $(MIPS32DSP_ALL))
+MIPS32DSP_RUNS = $(patsubst %, run-%, $(MIPS32DSP_TESTS))
+
+# add to the list of tests
+TESTS += $(MIPS32DSP_TESTS)
+
+# We need a rule to ensure we create a sub-directory to build in
+# It is a PHONY target to prevent confusion with MIPS32DSP_SRC
+.PHONY: mips32-dsp.build
+mips32-dsp.build:
+	mkdir -p mips32-dsp
+
+$(MIPS32DSP_TESTS): | mips32-dsp.build
+$(MIPS32DSP_TESTS): CFLAGS+=-mabi=32 -march=mips32r2 -mgp32 -mdsp
+
+$(MIPS32DSP_RUNS): QEMU_OPTS=-cpu 74Kf
+
+# FIXME: I don't know why the general rule in tests/tcg/Makefile isn't enough
+run-mips32-dsp/%: mips32-dsp/%
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on $(TARGET_NAME) $(QEMU_OPTS)")
diff --git a/tests/tcg/mips/mips32-dspr2/Makefile b/tests/tcg/mips/mips32-dspr2/Makefile
index ed19581c7e..6da966abb6 100644
--- a/tests/tcg/mips/mips32-dspr2/Makefile
+++ b/tests/tcg/mips/mips32-dspr2/Makefile
@@ -1,71 +1,24 @@
--include ../../config-host.mak
+#
+# MIPS32-DSPR2 linux-user tests
+#
 
-CROSS=mips64el-unknown-linux-gnu-
+MIPS32_DSPR2_SRC = $(SRC_PATH)/tests/tcg/mips/mips32-dsp
+MIPS32_DSPR2_ALL = $(wildcard $(MIPS32_DSPR2_SRC)/*.c)
+MIPS32_DSPR2_TESTS = $(patsubst $(MIPS32_DSPR2_SRC)/%.c, mips32-dspr2/%, $(MIPS32_DSPR2_ALL))
+MIPS32_DSPR2_RUNS = $(patsubst %, run-%, $(MIPS32_DSPR2_TESTS))
 
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu 74Kf
+# add to the list of tests
+TESTS += $(MIPS32_DSPR2_TESTS)
 
-CC      = $(CROSS)gcc
-CFLAGS  = -mabi=32 -march=mips32r2 -mgp32 -mdspr2 -static
+.PHONY: mips32-dspr2.build
+mips32-dspr2.build:
+	mkdir -p mips32-dspr2
 
-TESTCASES = absq_s_qb.tst
-TESTCASES += addqh_ph.tst
-TESTCASES += addqh_r_ph.tst
-TESTCASES += addqh_r_w.tst
-TESTCASES += addqh_w.tst
-TESTCASES += adduh_qb.tst
-TESTCASES += adduh_r_qb.tst
-TESTCASES += addu_ph.tst
-TESTCASES += addu_s_ph.tst
-TESTCASES += append.tst
-TESTCASES += balign.tst
-TESTCASES += cmpgdu_eq_qb.tst
-TESTCASES += cmpgdu_le_qb.tst
-TESTCASES += cmpgdu_lt_qb.tst
-TESTCASES += dpaqx_sa_w_ph.tst
-TESTCASES += dpa_w_ph.tst
-TESTCASES += dpax_w_ph.tst
-TESTCASES += dpaqx_s_w_ph.tst
-TESTCASES += dpsqx_sa_w_ph.tst
-TESTCASES += dpsqx_s_w_ph.tst
-TESTCASES += dps_w_ph.tst
-TESTCASES += dpsx_w_ph.tst
-TESTCASES += mul_ph.tst
-TESTCASES += mulq_rs_w.tst
-TESTCASES += mulq_s_ph.tst
-TESTCASES += mulq_s_w.tst
-TESTCASES += mulsaq_s_w_ph.tst
-TESTCASES += mulsa_w_ph.tst
-TESTCASES += mul_s_ph.tst
-TESTCASES += precr_qb_ph.tst
-TESTCASES += precr_sra_ph_w.tst
-TESTCASES += precr_sra_r_ph_w.tst
-TESTCASES += prepend.tst
-TESTCASES += shra_qb.tst
-TESTCASES += shra_r_qb.tst
-TESTCASES += shrav_qb.tst
-TESTCASES += shrav_r_qb.tst
-TESTCASES += shrl_ph.tst
-TESTCASES += shrlv_ph.tst
-TESTCASES += subqh_ph.tst
-TESTCASES += subqh_r_ph.tst
-TESTCASES += subqh_r_w.tst
-TESTCASES += subqh_w.tst
-TESTCASES += subuh_qb.tst
-TESTCASES += subuh_r_qb.tst
-TESTCASES += subu_ph.tst
-TESTCASES += subu_s_ph.tst
+$(MIPS32_DSPR2_TESTS): | mips32-dspr2.build
+$(MIPS32_DSPR2_TESTS): CFLAGS+=-mabi=32 -march=mips32r2 -mgp32 -mdspr2
 
-all: $(TESTCASES)
+$(MIPS32_DSPR2_RUNS): QEMU_OPTS=-cpu 74Kf
 
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-		$(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
+# FIXME: I don't know why the general rule in tests/tcg/Makefile isn't enough
+run-mips32-dspr2/%: mips32-dspr2/%
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on $(TARGET_NAME) $(QEMU_OPTS)")
diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index a1c388bc3c..7880e76986 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -1,30 +1,20 @@
--include ../../config-host.mak
+#
+# MIPSR5900 linux-user tests
+#
 
-CROSS=mipsr5900el-unknown-linux-gnu-
+MIPSR5900_SRC = $(SRC_PATH)/tests/tcg/mips/mipsr5900
+MIPSR5900_ALL = $(wildcard $(MIPSR5900_SRC)/*.c)
+MIPSR5900_TESTS = $(patsubst $(MIPSR5900_SRC)/%.c, %, $(MIPSR5900_ALL))
+MIPSR5900_RUNS = $(patsubst %, run-%, $(MIPSR5900_TESTS))
 
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu R5900
+# add to the list of tests
+TESTS += $(MIPSR5900_TESTS)
 
-CC      = $(CROSS)gcc
-CFLAGS  = -Wall -mabi=32 -march=r5900 -static
+.PHONY: mipsr5900.build
+mipsr5900.build:
+	mkdir -p mipsr5900
 
-TESTCASES = div1.tst
-TESTCASES += divu1.tst
-TESTCASES += mflohi1.tst
-TESTCASES += mtlohi1.tst
-TESTCASES += mult.tst
-TESTCASES += multu.tst
+$(MIPS32DSP_TESTS): | mipsr5900.build
+$(MIPSR5900_TESTS): CFLAGS+=-mabi=32 -march=r5900 -msingle-float
 
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-        $(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
+$(MIPSR5900_RUNS): QEMU_OPTS=-cpu R5900
-- 
2.17.1
