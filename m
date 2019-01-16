Received: from eggs.gnu.org ([209.51.188.92]:42958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrjB-0006vq-HQ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrjA-0006Ih-Cy
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:57 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjrjA-0006AN-2R
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:56 -0500
Received: by mail-wr1-x444.google.com with SMTP id 96so8504407wrb.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 12:23:55 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 16 Jan 2019 20:23:47 +0000
Message-Id: <20190116202349.29272-6-alex.bennee@linaro.org>
In-Reply-To: <20190116202349.29272-1-alex.bennee@linaro.org>
References: <20190116202349.29272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/7] tests/Makefile: add floating point tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Wire up test/fp-test into the main testing Makefile. Currently we skip
some of the extF80 and f128 related tests. Once we re-factor and fix
these tests the plumbing should get simpler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 115 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f403a6571d..43888f3ad5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -878,6 +878,121 @@ check-report-unit.tap: $(check-unit-y)
 check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
 	$(call quiet-command,./scripts/tap-merge.py $^ > $@,"GEN","$@")
 
+# FPU Emulation tests (aka softfloat)
+#
+# As we still have some places that need fixing the rules are a little
+# more complex than they need to be and have to override some of the
+# generic Makefile expansions. Once we are cleanly passing all
+# the tests we can simplify the make syntax.
+
+# the build dir is created by configure
+$(BUILD_DIR)/tests/fp/fp-test: $(BUILD_DIR)/tests/fp
+	$(call quiet-command, \
+	  cd $(BUILD_DIR)/tests/fp && make, \
+          "BUILD", $<)
+
+# The full test suite can take a bit of time, default to a quick run
+ifeq ($(SPEED), quick)
+FP_TL=-l 1
+else
+FP_TL=-l 2 -r all
+endif
+
+# $1 = tests, $2 = description
+test-softfloat = $(call quiet-command, \
+			cd $(BUILD_DIR)/tests/fp && ./fp-test -s $(FP_TL) $1 > $2.out 2> $2.err, \
+			"FLOAT TEST", $2)
+
+# Conversion Routines:
+# FIXME: i32_to_extF80 (broken), i64_to_extF80 (broken)
+#        ui32_to_f128 (not implemented), f128_to_ui32 (not implemented)
+#        extF80_roundToInt (broken)
+#
+check-softfloat-conv: tests/fp/fp-test
+	$(call test-softfloat, \
+		i32_to_f16 i64_to_f16 \
+		i32_to_f32 i64_to_f32 \
+		i32_to_f64 i64_to_f64 \
+		i32_to_f128 i64_to_f128, int-to-float)
+	$(call test-softfloat, \
+		ui32_to_f16 ui64_to_f16 \
+		ui32_to_f32 ui64_to_f32 \
+		ui32_to_f64 ui64_to_f64 \
+		ui64_to_f128, uint-to-float)
+	$(call test-softfloat, \
+		f16_to_i32 f16_to_i32_r_minMag \
+		f32_to_i32 f32_to_i32_r_minMag \
+		f64_to_i32 f64_to_i32_r_minMag \
+		extF80_to_i32 extF80_to_i32_r_minMag \
+		f128_to_i32 f128_to_i32_r_minMag \
+		f16_to_i64 f16_to_i64_r_minMag \
+		f32_to_i64 f32_to_i64_r_minMag \
+		f64_to_i64 f64_to_i64_r_minMag \
+		extF80_to_i64 extF80_to_i64_r_minMag \
+		f128_to_i64 f128_to_i64_r_minMag, \
+		float-to-int)
+	$(call test-softfloat, \
+		f16_to_ui32 f16_to_ui32_r_minMag \
+		f32_to_ui32 f32_to_ui32_r_minMag \
+		f64_to_ui32 f64_to_ui32_r_minMag \
+		f16_to_ui64 f16_to_ui64_r_minMag \
+		f32_to_ui64 f32_to_ui64_r_minMag \
+		f64_to_ui64 f64_to_ui64_r_minMag, \
+		float-to-uint)
+	$(call test-softfloat, \
+		f16_roundToInt f32_roundToInt \
+		f64_roundToInt f128_roundToInt, \
+		round-to-integer)
+
+# Generic rule for all float operations
+#
+# Some patterns are overidden due to broken or missing tests.
+# Hopefully these can be removed over time.
+
+check-softfloat-%: tests/fp/fp-test
+	$(call test-softfloat, f16_$* f32_$* f64_$* extF80_$* f128_$*, $*)
+
+# Float Compare routines
+SF_COMPARE_OPS=eq eq_signaling le le_quiet lt_quiet
+SF_COMPARE_RULES=$(patsubst %,check-softfloat-%, $(SF_COMPARE_OPS))
+
+# FIXME: extF80_le_quiet (broken)
+check-softfloat-le_quiet: tests/fp/fp-test
+	$(call test-softfloat, 				\
+		f16_le_quiet f32_le_quiet f64_le_quiet  \
+		f128_le_quiet, 				\
+		le_quiet)
+
+# FIXME: extF80_lt_quiet (broken)
+check-softfloat-lt_quiet: tests/fp/fp-test
+	$(call test-softfloat, 				\
+		f16_lt_quiet f32_lt_quiet f64_lt_quiet  \
+		f128_lt_quiet, 				\
+		lt_quiet)
+
+.PHONY: check-softfloat-compare
+check-softfloat-compare: $(SF_COMPARE_RULES)
+
+# Math Operations
+
+# FIXME: extF80_mulAdd (missing)
+check-softfloat-mulAdd: tests/fp/fp-test
+	$(call test-softfloat, \
+		f16_mulAdd f32_mulAdd f64_mulAdd f128_mulAdd, \
+		mulAdd)
+
+# FIXME: extF80_rem (broken)
+check-softfloat-rem: tests/fp/fp-test
+	$(call test-softfloat, \
+		f16_rem f32_rem f64_rem f128_rem, \
+		rem)
+
+SF_MATH_OPS=add sub mul mulAdd div rem sqrt
+SF_MATH_RULES=$(patsubst %,check-softfloat-%, $(SF_MATH_OPS))
+
+.PHONY: check-softfloat-ops
+check-softfloat-ops: $(SF_MATH_RULES)
+
 # Per guest TCG tests
 
 LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_DIRS))
-- 
2.17.1
