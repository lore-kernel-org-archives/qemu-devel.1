Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E597C2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcURd9P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E597C2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lfH-0007cF-Rz
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOo-0005du-C2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54420
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOg-0006VW-Sy
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ASUwD4PPSshZ+ytJnGEbUPUWwaQJtI8u2AJ9N0Hi9M0=;
 b=BcURd9P0wFDwjwASwqR8z25T63TWrBFnqykV1Qo4ey5CWF1KjWUGnqwGsNoB31BOmVrQli
 zpcMx5D1Js1/fTy+bH10EKXwWFPWpqpnXGdj6NAWZaTmtXpOMQdpgzaLiLXZiDnoNER3iW
 L0viFnSHPlj+gaOe5HU2RM5AarJJGnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-NdZATha4NiCRXwYax9v30A-1; Thu, 06 Aug 2020 15:17:47 -0400
X-MC-Unique: NdZATha4NiCRXwYax9v30A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0430D1DE1
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:47 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 281061D3
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 047/143] meson: convert tests/fp and check-softfloat
Date: Thu,  6 Aug 2020 21:14:43 +0200
Message-Id: <1596741379-12902-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              |   2 +-
 tests/Makefile.include | 160 +------------
 tests/fp/Makefile      | 600 ----------------------------------------------
 tests/fp/meson.build   | 628 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/meson.build      |   4 +
 5 files changed, 636 insertions(+), 758 deletions(-)
 delete mode 100644 tests/fp/Makefile
 create mode 100644 tests/fp/meson.build

diff --git a/configure b/configure
index 8026778..3c54abf 100755
--- a/configure
+++ b/configure
@@ -8319,7 +8319,7 @@ DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
-LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
+LINKS="$LINKS tests/tcg/Makefile.target"
 LINKS="$LINKS tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3ae7f88..f7ffecc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -437,9 +437,6 @@ tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
 tests/atomic64-bench$(EXESUF): tests/atomic64-bench.o $(test-util-obj-y)
 
-tests/fp/%:
-	$(MAKE) -C $(dir $@) $(notdir $@)
-
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
 	hw/core/bus.o \
@@ -675,157 +672,6 @@ check-report-unit.tap: $(check-unit-y)
 
 check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
 
-# FPU Emulation tests (aka softfloat)
-#
-# As we still have some places that need fixing the rules are a little
-# more complex than they need to be and have to override some of the
-# generic Makefile expansions. Once we are cleanly passing all
-# the tests we can simplify the make syntax.
-
-FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test
-
-# the build dir is created by configure
-$(FP_TEST_BIN): config-host.h $(test-util-obj-y)
-	$(call quiet-command, \
-	 	$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" $(notdir $@), \
-	         "BUILD", "$(notdir $@)")
-
-# The full test suite can take a bit of time, default to a quick run
-# "-l 2 -r all" can take more than a day for some operations and is best
-# run manually
-FP_TL=-l 1 -r all
-
-# $1 = tests, $2 = description, $3 = test flags
-test-softfloat = $(call quiet-command, \
-			cd $(BUILD_DIR)/tests/fp && \
-			./fp-test -s $(if $3,$3,$(FP_TL)) $1 > $2.out 2>&1 || \
-			(cat $2.out && exit 1;), \
-			"FLOAT TEST", $2)
-
-# Conversion Routines: Float to Float
-# FIXME: f32_to_f128 (broken), f64_to_f128 (broken)
-# FIXME: f128_to_f32(broken), f128_to_f64 (broken)
-# FIXME: f128_to_extF80 (broken)
-check-softfloat-conv-f2f: $(FP_TEST_BIN)
-	$(call test-softfloat, \
-		f16_to_f32 f16_to_f64 \
-		f16_to_extF80 f16_to_f128 \
-		f32_to_f16 f32_to_f64 \
-		f32_to_extF80 \
-		f64_to_f16 f64_to_f32 \
-		extF80_to_f16 extF80_to_f32 \
-		extF80_to_f64 extF80_to_f128 \
-		f128_to_f16, \
-		float-to-float)
-
-# Conversion Routines: Int and Uint to Float
-# FIXME: i32_to_extF80 (broken), i64_to_extF80 (broken)
-#        ui32_to_f128 (not implemented)
-check-softfloat-conv-to-float: $(FP_TEST_BIN)
-	$(call test-softfloat, \
-		i32_to_f16 i64_to_f16 \
-		i32_to_f32 i64_to_f32 \
-		i32_to_f64 i64_to_f64 \
-		i32_to_f128 i64_to_f128, int-to-float)
-	$(call test-softfloat, \
-		ui32_to_f16 ui64_to_f16 \
-		ui32_to_f32 ui64_to_f32 \
-		ui32_to_f64 ui64_to_f64 \
-		ui32_to_extF80 ui64_to_extF80 \
-		ui64_to_f128, uint-to-float)
-
-# Conversion Routines: Float to integers
-# FIXME: extF80_roundToInt (broken)
-check-softfloat-conv-to-int: $(FP_TEST_BIN)
-	$(call test-softfloat, \
-		f16_to_i32 f16_to_i32_r_minMag \
-		f32_to_i32 f32_to_i32_r_minMag \
-		f64_to_i32 f64_to_i32_r_minMag \
-		extF80_to_i32 extF80_to_i32_r_minMag \
-		f128_to_i32 f128_to_i32_r_minMag \
-		f16_to_i64 f16_to_i64_r_minMag \
-		f32_to_i64 f32_to_i64_r_minMag \
-		f64_to_i64 f64_to_i64_r_minMag \
-		extF80_to_i64 extF80_to_i64_r_minMag \
-		f128_to_i64 f128_to_i64_r_minMag, \
-		float-to-int)
-	$(call test-softfloat, \
-		f16_to_ui32 f16_to_ui32_r_minMag \
-		f32_to_ui32 f32_to_ui32_r_minMag \
-		f64_to_ui32 f64_to_ui32_r_minMag \
-		extF80_to_ui32 extF80_to_ui32_r_minMag \
-		f128_to_ui32 f128_to_ui32_r_minMag \
-		f16_to_ui64 f16_to_ui64_r_minMag \
-		f32_to_ui64 f32_to_ui64_r_minMag \
-		f64_to_ui64 f64_to_ui64_r_minMag \
-		extF80_to_ui64 extF80_to_ui64_r_minMag \
-		f128_to_ui64 f128_to_ui64_r_minMag, \
-		float-to-uint)
-	$(call test-softfloat, \
-		f16_roundToInt f32_roundToInt \
-		f64_roundToInt f128_roundToInt, \
-		round-to-integer)
-
-.PHONY: check-softfloat-conv
-check-softfloat-conv: check-softfloat-conv-f2f
-check-softfloat-conv: check-softfloat-conv-to-float
-check-softfloat-conv: check-softfloat-conv-to-int
-
-# Generic rule for all float operations
-#
-# Some patterns are overridden due to broken or missing tests.
-# Hopefully these can be removed over time.
-
-check-softfloat-%: $(FP_TEST_BIN)
-	$(call test-softfloat, f16_$* f32_$* f64_$* extF80_$* f128_$*, $*)
-
-# Float Compare routines
-SF_COMPARE_OPS=eq eq_signaling le le_quiet lt_quiet
-SF_COMPARE_RULES=$(patsubst %,check-softfloat-%, $(SF_COMPARE_OPS))
-
-# FIXME: extF80_lt_quiet (broken)
-check-softfloat-lt_quiet: $(FP_TEST_BIN)
-	$(call test-softfloat, 				\
-		f16_lt_quiet f32_lt_quiet f64_lt_quiet  \
-		f128_lt_quiet, 				\
-		lt_quiet)
-
-.PHONY: check-softfloat-compare
-check-softfloat-compare: $(SF_COMPARE_RULES)
-
-# Math Operations
-
-# FIXME: extF80_mulAdd (missing)
-check-softfloat-mulAdd: $(FP_TEST_BIN)
-	$(call test-softfloat, \
-		f16_mulAdd f32_mulAdd f64_mulAdd f128_mulAdd, \
-		mulAdd,-l 1)
-
-# FIXME: extF80_rem (broken)
-check-softfloat-rem: $(FP_TEST_BIN)
-	$(call test-softfloat, \
-		f16_rem f32_rem f64_rem f128_rem, \
-		rem)
-
-SF_MATH_OPS=add sub mul mulAdd div rem sqrt
-SF_MATH_RULES=$(patsubst %,check-softfloat-%, $(SF_MATH_OPS))
-
-.PHONY: check-softfloat-ops
-check-softfloat-ops: $(SF_MATH_RULES)
-
-# Finally a generic rule to test all of softfoat. If TCG isnt't
-# enabled we define a null operation which skips the tests.
-
-.PHONY: check-softfloat
-ifeq ($(CONFIG_TCG),y)
-build-softfloat: $(FP_TEST_BIN)
-check-softfloat: build-softfloat check-softfloat-conv check-softfloat-compare check-softfloat-ops
-else
-build-softfloat check-softfloat:
-	$(call quiet-command, /bin/true, "FLOAT TEST", \
-		"SKIPPED for non-TCG builds")
-endif
-
 # Plugins
 ifeq ($(CONFIG_PLUGIN),y)
 .PHONY: plugins
@@ -955,9 +801,9 @@ check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
 endif
-check-build: build-unit build-softfloat build-qtest
+check-build: build-unit build-qtest
 
-check: check-block check-qapi-schema check-unit check-softfloat check-qtest
+check: check-block check-qapi-schema check-unit check-qtest
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y:%=tests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)))
@@ -965,7 +811,7 @@ check-clean:
 	rm -f tests/qtest/dbus-vmstate1-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
-check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+check: check-block check-qapi-schema check-unit check-qtest check-decodetree
 
 clean: check-clean
 
diff --git a/tests/fp/Makefile b/tests/fp/Makefile
deleted file mode 100644
index 56768ec..0000000
--- a/tests/fp/Makefile
+++ /dev/null
@@ -1,600 +0,0 @@
-BUILD_DIR := $(CURDIR)/../..
-
-include $(BUILD_DIR)/config-host.mak
-include $(SRC_PATH)/rules.mak
-
-SOFTFLOAT_DIR := $(SRC_PATH)/tests/fp/berkeley-softfloat-3
-TESTFLOAT_DIR := $(SRC_PATH)/tests/fp/berkeley-testfloat-3
-
-SF_SOURCE_DIR  := $(SOFTFLOAT_DIR)/source
-SF_INCLUDE_DIR := $(SOFTFLOAT_DIR)/source/include
-# we could use any specialize here, it doesn't matter
-SF_SPECIALIZE := 8086-SSE
-SF_SPECIALIZE_DIR := $(SF_SOURCE_DIR)/$(SF_SPECIALIZE)
-
-TF_SOURCE_DIR := $(TESTFLOAT_DIR)/source
-
-$(call set-vpath, $(SRC_PATH)/fpu $(SRC_PATH)/tests/fp)
-
-LIBQEMUUTIL := $(BUILD_DIR)/libqemuutil.a
-
-# Use this variable to be clear when we pull in our own implementation
-# We build the object with a default rule thanks to the vpath above
-QEMU_SOFTFLOAT_OBJ := softfloat.o
-
-QEMU_INCLUDES += -I$(SRC_PATH)/tests/fp
-QEMU_INCLUDES += -I$(SF_INCLUDE_DIR)
-QEMU_INCLUDES += -I$(SF_SPECIALIZE_DIR)
-QEMU_INCLUDES += -I$(TF_SOURCE_DIR)
-
-# work around TARGET_* poisoning
-QEMU_CFLAGS += -DHW_POISON_H
-# define a target to match testfloat's implementation-defined choices, such as
-# whether to raise the invalid flag when dealing with NaNs in muladd.
-QEMU_CFLAGS += -DTARGET_ARM
-
-# capstone has a platform.h file that clashes with softfloat's
-QEMU_CFLAGS := $(filter-out %capstone, $(QEMU_CFLAGS))
-
-# softfloat defines
-SF_OPTS :=
-SF_OPTS += -DSOFTFLOAT_ROUND_ODD
-SF_OPTS += -DINLINE_LEVEL=5
-SF_OPTS += -DSOFTFLOAT_FAST_DIV32TO16
-SF_OPTS += -DSOFTFLOAT_FAST_DIV64TO32
-SF_OPTS += -DSOFTFLOAT_FAST_INT64
-QEMU_CFLAGS += $(SF_OPTS)
-
-# silence the build of softfloat objects
-SF_CFLAGS += -Wno-missing-prototypes
-SF_CFLAGS += -Wno-redundant-decls
-SF_CFLAGS += -Wno-return-type
-SF_CFLAGS += -Wno-error
-
-# testfloat defines
-TF_OPTS :=
-TF_OPTS += -DFLOAT16
-TF_OPTS += -DFLOAT64
-TF_OPTS += -DEXTFLOAT80
-TF_OPTS += -DFLOAT128
-TF_OPTS += -DFLOAT_ROUND_ODD
-TF_OPTS += -DLONG_DOUBLE_IS_EXTFLOAT80
-QEMU_CFLAGS += $(TF_OPTS)
-
-# silence the build of testfloat objects
-TF_CFLAGS :=
-TF_CFLAGS += -Wno-strict-prototypes
-TF_CFLAGS += -Wno-unknown-pragmas
-TF_CFLAGS += -Wno-uninitialized
-TF_CFLAGS += -Wno-missing-prototypes
-TF_CFLAGS += -Wno-return-type
-TF_CFLAGS += -Wno-unused-function
-TF_CFLAGS += -Wno-error
-
-# softfloat objects
-SF_OBJS_PRIMITIVES :=
-SF_OBJS_PRIMITIVES += s_eq128.o
-SF_OBJS_PRIMITIVES += s_le128.o
-SF_OBJS_PRIMITIVES += s_lt128.o
-SF_OBJS_PRIMITIVES += s_shortShiftLeft128.o
-SF_OBJS_PRIMITIVES += s_shortShiftRight128.o
-SF_OBJS_PRIMITIVES += s_shortShiftRightJam64.o
-SF_OBJS_PRIMITIVES += s_shortShiftRightJam64Extra.o
-SF_OBJS_PRIMITIVES += s_shortShiftRightJam128.o
-SF_OBJS_PRIMITIVES += s_shortShiftRightJam128Extra.o
-SF_OBJS_PRIMITIVES += s_shiftRightJam32.o
-SF_OBJS_PRIMITIVES += s_shiftRightJam64.o
-SF_OBJS_PRIMITIVES += s_shiftRightJam64Extra.o
-SF_OBJS_PRIMITIVES += s_shiftRightJam128.o
-SF_OBJS_PRIMITIVES += s_shiftRightJam128Extra.o
-SF_OBJS_PRIMITIVES += s_shiftRightJam256M.o
-SF_OBJS_PRIMITIVES += s_countLeadingZeros8.o
-SF_OBJS_PRIMITIVES += s_countLeadingZeros16.o
-SF_OBJS_PRIMITIVES += s_countLeadingZeros32.o
-SF_OBJS_PRIMITIVES += s_countLeadingZeros64.o
-SF_OBJS_PRIMITIVES += s_add128.o
-SF_OBJS_PRIMITIVES += s_add256M.o
-SF_OBJS_PRIMITIVES += s_sub128.o
-SF_OBJS_PRIMITIVES += s_sub256M.o
-SF_OBJS_PRIMITIVES += s_mul64ByShifted32To128.o
-SF_OBJS_PRIMITIVES += s_mul64To128.o
-SF_OBJS_PRIMITIVES += s_mul128By32.o
-SF_OBJS_PRIMITIVES += s_mul128To256M.o
-SF_OBJS_PRIMITIVES += s_approxRecip_1Ks.o
-SF_OBJS_PRIMITIVES += s_approxRecip32_1.o
-SF_OBJS_PRIMITIVES += s_approxRecipSqrt_1Ks.o
-SF_OBJS_PRIMITIVES += s_approxRecipSqrt32_1.o
-
-SF_OBJS_SPECIALIZE :=
-SF_OBJS_SPECIALIZE += softfloat_raiseFlags.o
-SF_OBJS_SPECIALIZE += s_f16UIToCommonNaN.o
-SF_OBJS_SPECIALIZE += s_commonNaNToF16UI.o
-SF_OBJS_SPECIALIZE += s_propagateNaNF16UI.o
-SF_OBJS_SPECIALIZE += s_f32UIToCommonNaN.o
-SF_OBJS_SPECIALIZE += s_commonNaNToF32UI.o
-SF_OBJS_SPECIALIZE += s_propagateNaNF32UI.o
-SF_OBJS_SPECIALIZE += s_f64UIToCommonNaN.o
-SF_OBJS_SPECIALIZE += s_commonNaNToF64UI.o
-SF_OBJS_SPECIALIZE += s_propagateNaNF64UI.o
-SF_OBJS_SPECIALIZE += extF80M_isSignalingNaN.o
-SF_OBJS_SPECIALIZE += s_extF80UIToCommonNaN.o
-SF_OBJS_SPECIALIZE += s_commonNaNToExtF80UI.o
-SF_OBJS_SPECIALIZE += s_propagateNaNExtF80UI.o
-SF_OBJS_SPECIALIZE += f128M_isSignalingNaN.o
-SF_OBJS_SPECIALIZE += s_f128UIToCommonNaN.o
-SF_OBJS_SPECIALIZE += s_commonNaNToF128UI.o
-SF_OBJS_SPECIALIZE += s_propagateNaNF128UI.o
-
-SF_OBJS_OTHERS :=
-SF_OBJS_OTHERS += s_roundToUI32.o
-SF_OBJS_OTHERS += s_roundToUI64.o
-SF_OBJS_OTHERS += s_roundToI32.o
-SF_OBJS_OTHERS += s_roundToI64.o
-SF_OBJS_OTHERS += s_normSubnormalF16Sig.o
-SF_OBJS_OTHERS += s_roundPackToF16.o
-SF_OBJS_OTHERS += s_normRoundPackToF16.o
-SF_OBJS_OTHERS += s_addMagsF16.o
-SF_OBJS_OTHERS += s_subMagsF16.o
-SF_OBJS_OTHERS += s_mulAddF16.o
-SF_OBJS_OTHERS += s_normSubnormalF32Sig.o
-SF_OBJS_OTHERS += s_roundPackToF32.o
-SF_OBJS_OTHERS += s_normRoundPackToF32.o
-SF_OBJS_OTHERS += s_addMagsF32.o
-SF_OBJS_OTHERS += s_subMagsF32.o
-SF_OBJS_OTHERS += s_mulAddF32.o
-SF_OBJS_OTHERS += s_normSubnormalF64Sig.o
-SF_OBJS_OTHERS += s_roundPackToF64.o
-SF_OBJS_OTHERS += s_normRoundPackToF64.o
-SF_OBJS_OTHERS += s_addMagsF64.o
-SF_OBJS_OTHERS += s_subMagsF64.o
-SF_OBJS_OTHERS += s_mulAddF64.o
-SF_OBJS_OTHERS += s_normSubnormalExtF80Sig.o
-SF_OBJS_OTHERS += s_roundPackToExtF80.o
-SF_OBJS_OTHERS += s_normRoundPackToExtF80.o
-SF_OBJS_OTHERS += s_addMagsExtF80.o
-SF_OBJS_OTHERS += s_subMagsExtF80.o
-SF_OBJS_OTHERS += s_normSubnormalF128Sig.o
-SF_OBJS_OTHERS += s_roundPackToF128.o
-SF_OBJS_OTHERS += s_normRoundPackToF128.o
-SF_OBJS_OTHERS += s_addMagsF128.o
-SF_OBJS_OTHERS += s_subMagsF128.o
-SF_OBJS_OTHERS += s_mulAddF128.o
-SF_OBJS_OTHERS += softfloat_state.o
-SF_OBJS_OTHERS += ui32_to_f16.o
-SF_OBJS_OTHERS += ui32_to_f32.o
-SF_OBJS_OTHERS += ui32_to_f64.o
-SF_OBJS_OTHERS += ui32_to_extF80.o
-SF_OBJS_OTHERS += ui32_to_extF80M.o
-SF_OBJS_OTHERS += ui32_to_f128.o
-SF_OBJS_OTHERS += ui32_to_f128M.o
-SF_OBJS_OTHERS += ui64_to_f16.o
-SF_OBJS_OTHERS += ui64_to_f32.o
-SF_OBJS_OTHERS += ui64_to_f64.o
-SF_OBJS_OTHERS += ui64_to_extF80.o
-SF_OBJS_OTHERS += ui64_to_extF80M.o
-SF_OBJS_OTHERS += ui64_to_f128.o
-SF_OBJS_OTHERS += ui64_to_f128M.o
-SF_OBJS_OTHERS += i32_to_f16.o
-SF_OBJS_OTHERS += i32_to_f32.o
-SF_OBJS_OTHERS += i32_to_f64.o
-SF_OBJS_OTHERS += i32_to_extF80.o
-SF_OBJS_OTHERS += i32_to_extF80M.o
-SF_OBJS_OTHERS += i32_to_f128.o
-SF_OBJS_OTHERS += i32_to_f128M.o
-SF_OBJS_OTHERS += i64_to_f16.o
-SF_OBJS_OTHERS += i64_to_f32.o
-SF_OBJS_OTHERS += i64_to_f64.o
-SF_OBJS_OTHERS += i64_to_extF80.o
-SF_OBJS_OTHERS += i64_to_extF80M.o
-SF_OBJS_OTHERS += i64_to_f128.o
-SF_OBJS_OTHERS += i64_to_f128M.o
-SF_OBJS_OTHERS += f16_to_ui32.o
-SF_OBJS_OTHERS += f16_to_ui64.o
-SF_OBJS_OTHERS += f16_to_i32.o
-SF_OBJS_OTHERS += f16_to_i64.o
-SF_OBJS_OTHERS += f16_to_ui32_r_minMag.o
-SF_OBJS_OTHERS += f16_to_ui64_r_minMag.o
-SF_OBJS_OTHERS += f16_to_i32_r_minMag.o
-SF_OBJS_OTHERS += f16_to_i64_r_minMag.o
-SF_OBJS_OTHERS += f16_to_f32.o
-SF_OBJS_OTHERS += f16_to_f64.o
-SF_OBJS_OTHERS += f16_to_extF80.o
-SF_OBJS_OTHERS += f16_to_extF80M.o
-SF_OBJS_OTHERS += f16_to_f128.o
-SF_OBJS_OTHERS += f16_to_f128M.o
-SF_OBJS_OTHERS += f16_roundToInt.o
-SF_OBJS_OTHERS += f16_add.o
-SF_OBJS_OTHERS += f16_sub.o
-SF_OBJS_OTHERS += f16_mul.o
-SF_OBJS_OTHERS += f16_mulAdd.o
-SF_OBJS_OTHERS += f16_div.o
-SF_OBJS_OTHERS += f16_rem.o
-SF_OBJS_OTHERS += f16_sqrt.o
-SF_OBJS_OTHERS += f16_eq.o
-SF_OBJS_OTHERS += f16_le.o
-SF_OBJS_OTHERS += f16_lt.o
-SF_OBJS_OTHERS += f16_eq_signaling.o
-SF_OBJS_OTHERS += f16_le_quiet.o
-SF_OBJS_OTHERS += f16_lt_quiet.o
-SF_OBJS_OTHERS += f16_isSignalingNaN.o
-SF_OBJS_OTHERS += f32_to_ui32.o
-SF_OBJS_OTHERS += f32_to_ui64.o
-SF_OBJS_OTHERS += f32_to_i32.o
-SF_OBJS_OTHERS += f32_to_i64.o
-SF_OBJS_OTHERS += f32_to_ui32_r_minMag.o
-SF_OBJS_OTHERS += f32_to_ui64_r_minMag.o
-SF_OBJS_OTHERS += f32_to_i32_r_minMag.o
-SF_OBJS_OTHERS += f32_to_i64_r_minMag.o
-SF_OBJS_OTHERS += f32_to_f16.o
-SF_OBJS_OTHERS += f32_to_f64.o
-SF_OBJS_OTHERS += f32_to_extF80.o
-SF_OBJS_OTHERS += f32_to_extF80M.o
-SF_OBJS_OTHERS += f32_to_f128.o
-SF_OBJS_OTHERS += f32_to_f128M.o
-SF_OBJS_OTHERS += f32_roundToInt.o
-SF_OBJS_OTHERS += f32_add.o
-SF_OBJS_OTHERS += f32_sub.o
-SF_OBJS_OTHERS += f32_mul.o
-SF_OBJS_OTHERS += f32_mulAdd.o
-SF_OBJS_OTHERS += f32_div.o
-SF_OBJS_OTHERS += f32_rem.o
-SF_OBJS_OTHERS += f32_sqrt.o
-SF_OBJS_OTHERS += f32_eq.o
-SF_OBJS_OTHERS += f32_le.o
-SF_OBJS_OTHERS += f32_lt.o
-SF_OBJS_OTHERS += f32_eq_signaling.o
-SF_OBJS_OTHERS += f32_le_quiet.o
-SF_OBJS_OTHERS += f32_lt_quiet.o
-SF_OBJS_OTHERS += f32_isSignalingNaN.o
-SF_OBJS_OTHERS += f64_to_ui32.o
-SF_OBJS_OTHERS += f64_to_ui64.o
-SF_OBJS_OTHERS += f64_to_i32.o
-SF_OBJS_OTHERS += f64_to_i64.o
-SF_OBJS_OTHERS += f64_to_ui32_r_minMag.o
-SF_OBJS_OTHERS += f64_to_ui64_r_minMag.o
-SF_OBJS_OTHERS += f64_to_i32_r_minMag.o
-SF_OBJS_OTHERS += f64_to_i64_r_minMag.o
-SF_OBJS_OTHERS += f64_to_f16.o
-SF_OBJS_OTHERS += f64_to_f32.o
-SF_OBJS_OTHERS += f64_to_extF80.o
-SF_OBJS_OTHERS += f64_to_extF80M.o
-SF_OBJS_OTHERS += f64_to_f128.o
-SF_OBJS_OTHERS += f64_to_f128M.o
-SF_OBJS_OTHERS += f64_roundToInt.o
-SF_OBJS_OTHERS += f64_add.o
-SF_OBJS_OTHERS += f64_sub.o
-SF_OBJS_OTHERS += f64_mul.o
-SF_OBJS_OTHERS += f64_mulAdd.o
-SF_OBJS_OTHERS += f64_div.o
-SF_OBJS_OTHERS += f64_rem.o
-SF_OBJS_OTHERS += f64_sqrt.o
-SF_OBJS_OTHERS += f64_eq.o
-SF_OBJS_OTHERS += f64_le.o
-SF_OBJS_OTHERS += f64_lt.o
-SF_OBJS_OTHERS += f64_eq_signaling.o
-SF_OBJS_OTHERS += f64_le_quiet.o
-SF_OBJS_OTHERS += f64_lt_quiet.o
-SF_OBJS_OTHERS += f64_isSignalingNaN.o
-SF_OBJS_OTHERS += extF80_to_ui32.o
-SF_OBJS_OTHERS += extF80_to_ui64.o
-SF_OBJS_OTHERS += extF80_to_i32.o
-SF_OBJS_OTHERS += extF80_to_i64.o
-SF_OBJS_OTHERS += extF80_to_ui32_r_minMag.o
-SF_OBJS_OTHERS += extF80_to_ui64_r_minMag.o
-SF_OBJS_OTHERS += extF80_to_i32_r_minMag.o
-SF_OBJS_OTHERS += extF80_to_i64_r_minMag.o
-SF_OBJS_OTHERS += extF80_to_f16.o
-SF_OBJS_OTHERS += extF80_to_f32.o
-SF_OBJS_OTHERS += extF80_to_f64.o
-SF_OBJS_OTHERS += extF80_to_f128.o
-SF_OBJS_OTHERS += extF80_roundToInt.o
-SF_OBJS_OTHERS += extF80_add.o
-SF_OBJS_OTHERS += extF80_sub.o
-SF_OBJS_OTHERS += extF80_mul.o
-SF_OBJS_OTHERS += extF80_div.o
-SF_OBJS_OTHERS += extF80_rem.o
-SF_OBJS_OTHERS += extF80_sqrt.o
-SF_OBJS_OTHERS += extF80_eq.o
-SF_OBJS_OTHERS += extF80_le.o
-SF_OBJS_OTHERS += extF80_lt.o
-SF_OBJS_OTHERS += extF80_eq_signaling.o
-SF_OBJS_OTHERS += extF80_le_quiet.o
-SF_OBJS_OTHERS += extF80_lt_quiet.o
-SF_OBJS_OTHERS += extF80_isSignalingNaN.o
-SF_OBJS_OTHERS += extF80M_to_ui32.o
-SF_OBJS_OTHERS += extF80M_to_ui64.o
-SF_OBJS_OTHERS += extF80M_to_i32.o
-SF_OBJS_OTHERS += extF80M_to_i64.o
-SF_OBJS_OTHERS += extF80M_to_ui32_r_minMag.o
-SF_OBJS_OTHERS += extF80M_to_ui64_r_minMag.o
-SF_OBJS_OTHERS += extF80M_to_i32_r_minMag.o
-SF_OBJS_OTHERS += extF80M_to_i64_r_minMag.o
-SF_OBJS_OTHERS += extF80M_to_f16.o
-SF_OBJS_OTHERS += extF80M_to_f32.o
-SF_OBJS_OTHERS += extF80M_to_f64.o
-SF_OBJS_OTHERS += extF80M_to_f128M.o
-SF_OBJS_OTHERS += extF80M_roundToInt.o
-SF_OBJS_OTHERS += extF80M_add.o
-SF_OBJS_OTHERS += extF80M_sub.o
-SF_OBJS_OTHERS += extF80M_mul.o
-SF_OBJS_OTHERS += extF80M_div.o
-SF_OBJS_OTHERS += extF80M_rem.o
-SF_OBJS_OTHERS += extF80M_sqrt.o
-SF_OBJS_OTHERS += extF80M_eq.o
-SF_OBJS_OTHERS += extF80M_le.o
-SF_OBJS_OTHERS += extF80M_lt.o
-SF_OBJS_OTHERS += extF80M_eq_signaling.o
-SF_OBJS_OTHERS += extF80M_le_quiet.o
-SF_OBJS_OTHERS += extF80M_lt_quiet.o
-SF_OBJS_OTHERS += f128_to_ui32.o
-SF_OBJS_OTHERS += f128_to_ui64.o
-SF_OBJS_OTHERS += f128_to_i32.o
-SF_OBJS_OTHERS += f128_to_i64.o
-SF_OBJS_OTHERS += f128_to_ui32_r_minMag.o
-SF_OBJS_OTHERS += f128_to_ui64_r_minMag.o
-SF_OBJS_OTHERS += f128_to_i32_r_minMag.o
-SF_OBJS_OTHERS += f128_to_i64_r_minMag.o
-SF_OBJS_OTHERS += f128_to_f16.o
-SF_OBJS_OTHERS += f128_to_f32.o
-SF_OBJS_OTHERS += f128_to_extF80.o
-SF_OBJS_OTHERS += f128_to_f64.o
-SF_OBJS_OTHERS += f128_roundToInt.o
-SF_OBJS_OTHERS += f128_add.o
-SF_OBJS_OTHERS += f128_sub.o
-SF_OBJS_OTHERS += f128_mul.o
-SF_OBJS_OTHERS += f128_mulAdd.o
-SF_OBJS_OTHERS += f128_div.o
-SF_OBJS_OTHERS += f128_rem.o
-SF_OBJS_OTHERS += f128_sqrt.o
-SF_OBJS_OTHERS += f128_eq.o
-SF_OBJS_OTHERS += f128_le.o
-SF_OBJS_OTHERS += f128_lt.o
-SF_OBJS_OTHERS += f128_eq_signaling.o
-SF_OBJS_OTHERS += f128_le_quiet.o
-SF_OBJS_OTHERS += f128_lt_quiet.o
-SF_OBJS_OTHERS += f128_isSignalingNaN.o
-SF_OBJS_OTHERS += f128M_to_ui32.o
-SF_OBJS_OTHERS += f128M_to_ui64.o
-SF_OBJS_OTHERS += f128M_to_i32.o
-SF_OBJS_OTHERS += f128M_to_i64.o
-SF_OBJS_OTHERS += f128M_to_ui32_r_minMag.o
-SF_OBJS_OTHERS += f128M_to_ui64_r_minMag.o
-SF_OBJS_OTHERS += f128M_to_i32_r_minMag.o
-SF_OBJS_OTHERS += f128M_to_i64_r_minMag.o
-SF_OBJS_OTHERS += f128M_to_f16.o
-SF_OBJS_OTHERS += f128M_to_f32.o
-SF_OBJS_OTHERS += f128M_to_extF80M.o
-SF_OBJS_OTHERS += f128M_to_f64.o
-SF_OBJS_OTHERS += f128M_roundToInt.o
-SF_OBJS_OTHERS += f128M_add.o
-SF_OBJS_OTHERS += f128M_sub.o
-SF_OBJS_OTHERS += f128M_mul.o
-SF_OBJS_OTHERS += f128M_mulAdd.o
-SF_OBJS_OTHERS += f128M_div.o
-SF_OBJS_OTHERS += f128M_rem.o
-SF_OBJS_OTHERS += f128M_sqrt.o
-SF_OBJS_OTHERS += f128M_eq.o
-SF_OBJS_OTHERS += f128M_le.o
-SF_OBJS_OTHERS += f128M_lt.o
-SF_OBJS_OTHERS += f128M_eq_signaling.o
-SF_OBJS_OTHERS += f128M_le_quiet.o
-SF_OBJS_OTHERS += f128M_lt_quiet.o
-
-SF_OBJS_ALL_NOSPEC :=
-SF_OBJS_ALL_NOSPEC += $(SF_OBJS_PRIMITIVES)
-SF_OBJS_ALL_NOSPEC += $(SF_OBJS_OTHERS)
-
-SF_OBJS_ALL :=
-SF_OBJS_ALL += $(SF_OBJS_ALL_NOSPEC)
-SF_OBJS_ALL += $(SF_OBJS_SPECIALIZE)
-
-# testfloat objects
-TF_OBJS_GENCASES :=
-TF_OBJS_GENCASES += genCases_ui32.o
-TF_OBJS_GENCASES += genCases_ui64.o
-TF_OBJS_GENCASES += genCases_i32.o
-TF_OBJS_GENCASES += genCases_i64.o
-TF_OBJS_GENCASES += genCases_f16.o
-TF_OBJS_GENCASES += genCases_f32.o
-TF_OBJS_GENCASES += genCases_f64.o
-TF_OBJS_GENCASES += genCases_extF80.o
-TF_OBJS_GENCASES += genCases_f128.o
-
-TF_OBJS_WRITECASE :=
-TF_OBJS_WRITECASE += writeCase_a_ui32.o
-TF_OBJS_WRITECASE += writeCase_a_ui64.o
-TF_OBJS_WRITECASE += writeCase_a_f16.o
-TF_OBJS_WRITECASE += writeCase_ab_f16.o
-TF_OBJS_WRITECASE += writeCase_abc_f16.o
-TF_OBJS_WRITECASE += writeCase_a_f32.o
-TF_OBJS_WRITECASE += writeCase_ab_f32.o
-TF_OBJS_WRITECASE += writeCase_abc_f32.o
-TF_OBJS_WRITECASE += writeCase_a_f64.o
-TF_OBJS_WRITECASE += writeCase_ab_f64.o
-TF_OBJS_WRITECASE += writeCase_abc_f64.o
-TF_OBJS_WRITECASE += writeCase_a_extF80M.o
-TF_OBJS_WRITECASE += writeCase_ab_extF80M.o
-TF_OBJS_WRITECASE += writeCase_a_f128M.o
-TF_OBJS_WRITECASE += writeCase_ab_f128M.o
-TF_OBJS_WRITECASE += writeCase_abc_f128M.o
-TF_OBJS_WRITECASE += writeCase_z_bool.o
-TF_OBJS_WRITECASE += writeCase_z_ui32.o
-TF_OBJS_WRITECASE += writeCase_z_ui64.o
-TF_OBJS_WRITECASE += writeCase_z_f16.o
-TF_OBJS_WRITECASE += writeCase_z_f32.o
-TF_OBJS_WRITECASE += writeCase_z_f64.o
-TF_OBJS_WRITECASE += writeCase_z_extF80M.o
-TF_OBJS_WRITECASE += writeCase_z_f128M.o
-
-TF_OBJS_TEST :=
-TF_OBJS_TEST += test_a_ui32_z_f16.o
-TF_OBJS_TEST += test_a_ui32_z_f32.o
-TF_OBJS_TEST += test_a_ui32_z_f64.o
-TF_OBJS_TEST += test_a_ui32_z_extF80.o
-TF_OBJS_TEST += test_a_ui32_z_f128.o
-TF_OBJS_TEST += test_a_ui64_z_f16.o
-TF_OBJS_TEST += test_a_ui64_z_f32.o
-TF_OBJS_TEST += test_a_ui64_z_f64.o
-TF_OBJS_TEST += test_a_ui64_z_extF80.o
-TF_OBJS_TEST += test_a_ui64_z_f128.o
-TF_OBJS_TEST += test_a_i32_z_f16.o
-TF_OBJS_TEST += test_a_i32_z_f32.o
-TF_OBJS_TEST += test_a_i32_z_f64.o
-TF_OBJS_TEST += test_a_i32_z_extF80.o
-TF_OBJS_TEST += test_a_i32_z_f128.o
-TF_OBJS_TEST += test_a_i64_z_f16.o
-TF_OBJS_TEST += test_a_i64_z_f32.o
-TF_OBJS_TEST += test_a_i64_z_f64.o
-TF_OBJS_TEST += test_a_i64_z_extF80.o
-TF_OBJS_TEST += test_a_i64_z_f128.o
-TF_OBJS_TEST += test_a_f16_z_ui32_rx.o
-TF_OBJS_TEST += test_a_f16_z_ui64_rx.o
-TF_OBJS_TEST += test_a_f16_z_i32_rx.o
-TF_OBJS_TEST += test_a_f16_z_i64_rx.o
-TF_OBJS_TEST += test_a_f16_z_ui32_x.o
-TF_OBJS_TEST += test_a_f16_z_ui64_x.o
-TF_OBJS_TEST += test_a_f16_z_i32_x.o
-TF_OBJS_TEST += test_a_f16_z_i64_x.o
-TF_OBJS_TEST += test_a_f16_z_f32.o
-TF_OBJS_TEST += test_a_f16_z_f64.o
-TF_OBJS_TEST += test_a_f16_z_extF80.o
-TF_OBJS_TEST += test_a_f16_z_f128.o
-TF_OBJS_TEST += test_az_f16.o
-TF_OBJS_TEST += test_az_f16_rx.o
-TF_OBJS_TEST += test_abz_f16.o
-TF_OBJS_TEST += test_abcz_f16.o
-TF_OBJS_TEST += test_ab_f16_z_bool.o
-TF_OBJS_TEST += test_a_f32_z_ui32_rx.o
-TF_OBJS_TEST += test_a_f32_z_ui64_rx.o
-TF_OBJS_TEST += test_a_f32_z_i32_rx.o
-TF_OBJS_TEST += test_a_f32_z_i64_rx.o
-TF_OBJS_TEST += test_a_f32_z_ui32_x.o
-TF_OBJS_TEST += test_a_f32_z_ui64_x.o
-TF_OBJS_TEST += test_a_f32_z_i32_x.o
-TF_OBJS_TEST += test_a_f32_z_i64_x.o
-TF_OBJS_TEST += test_a_f32_z_f16.o
-TF_OBJS_TEST += test_a_f32_z_f64.o
-TF_OBJS_TEST += test_a_f32_z_extF80.o
-TF_OBJS_TEST += test_a_f32_z_f128.o
-TF_OBJS_TEST += test_az_f32.o
-TF_OBJS_TEST += test_az_f32_rx.o
-TF_OBJS_TEST += test_abz_f32.o
-TF_OBJS_TEST += test_abcz_f32.o
-TF_OBJS_TEST += test_ab_f32_z_bool.o
-TF_OBJS_TEST += test_a_f64_z_ui32_rx.o
-TF_OBJS_TEST += test_a_f64_z_ui64_rx.o
-TF_OBJS_TEST += test_a_f64_z_i32_rx.o
-TF_OBJS_TEST += test_a_f64_z_i64_rx.o
-TF_OBJS_TEST += test_a_f64_z_ui32_x.o
-TF_OBJS_TEST += test_a_f64_z_ui64_x.o
-TF_OBJS_TEST += test_a_f64_z_i32_x.o
-TF_OBJS_TEST += test_a_f64_z_i64_x.o
-TF_OBJS_TEST += test_a_f64_z_f16.o
-TF_OBJS_TEST += test_a_f64_z_f32.o
-TF_OBJS_TEST += test_a_f64_z_extF80.o
-TF_OBJS_TEST += test_a_f64_z_f128.o
-TF_OBJS_TEST += test_az_f64.o
-TF_OBJS_TEST += test_az_f64_rx.o
-TF_OBJS_TEST += test_abz_f64.o
-TF_OBJS_TEST += test_abcz_f64.o
-TF_OBJS_TEST += test_ab_f64_z_bool.o
-TF_OBJS_TEST += test_a_extF80_z_ui32_rx.o
-TF_OBJS_TEST += test_a_extF80_z_ui64_rx.o
-TF_OBJS_TEST += test_a_extF80_z_i32_rx.o
-TF_OBJS_TEST += test_a_extF80_z_i64_rx.o
-TF_OBJS_TEST += test_a_extF80_z_ui32_x.o
-TF_OBJS_TEST += test_a_extF80_z_ui64_x.o
-TF_OBJS_TEST += test_a_extF80_z_i32_x.o
-TF_OBJS_TEST += test_a_extF80_z_i64_x.o
-TF_OBJS_TEST += test_a_extF80_z_f16.o
-TF_OBJS_TEST += test_a_extF80_z_f32.o
-TF_OBJS_TEST += test_a_extF80_z_f64.o
-TF_OBJS_TEST += test_a_extF80_z_f128.o
-TF_OBJS_TEST += test_az_extF80.o
-TF_OBJS_TEST += test_az_extF80_rx.o
-TF_OBJS_TEST += test_abz_extF80.o
-TF_OBJS_TEST += test_ab_extF80_z_bool.o
-TF_OBJS_TEST += test_a_f128_z_ui32_rx.o
-TF_OBJS_TEST += test_a_f128_z_ui64_rx.o
-TF_OBJS_TEST += test_a_f128_z_i32_rx.o
-TF_OBJS_TEST += test_a_f128_z_i64_rx.o
-TF_OBJS_TEST += test_a_f128_z_ui32_x.o
-TF_OBJS_TEST += test_a_f128_z_ui64_x.o
-TF_OBJS_TEST += test_a_f128_z_i32_x.o
-TF_OBJS_TEST += test_a_f128_z_i64_x.o
-TF_OBJS_TEST += test_a_f128_z_f16.o
-TF_OBJS_TEST += test_a_f128_z_f32.o
-TF_OBJS_TEST += test_a_f128_z_f64.o
-TF_OBJS_TEST += test_a_f128_z_extF80.o
-TF_OBJS_TEST += test_az_f128.o
-TF_OBJS_TEST += test_az_f128_rx.o
-TF_OBJS_TEST += test_abz_f128.o
-TF_OBJS_TEST += test_abcz_f128.o
-TF_OBJS_TEST += test_ab_f128_z_bool.o
-
-TF_OBJS_LIB :=
-TF_OBJS_LIB += uint128_inline.o
-TF_OBJS_LIB += uint128.o
-TF_OBJS_LIB += fail.o
-TF_OBJS_LIB += functions_common.o
-TF_OBJS_LIB += functionInfos.o
-TF_OBJS_LIB += standardFunctionInfos.o
-TF_OBJS_LIB += random.o
-TF_OBJS_LIB += genCases_common.o
-TF_OBJS_LIB += $(TF_OBJS_GENCASES)
-TF_OBJS_LIB += genCases_writeTestsTotal.o
-TF_OBJS_LIB += verCases_inline.o
-TF_OBJS_LIB += verCases_common.o
-TF_OBJS_LIB += verCases_writeFunctionName.o
-TF_OBJS_LIB += readHex.o
-TF_OBJS_LIB += writeHex.o
-TF_OBJS_LIB += $(TF_OBJS_WRITECASE)
-TF_OBJS_LIB += testLoops_common.o
-TF_OBJS_LIB += $(TF_OBJS_TEST)
-
-BINARIES := fp-test$(EXESUF) fp-bench$(EXESUF)
-
-# We require artefacts from the main build including config-host.h
-# because platform.h includes it. Rather than re-invoking the main
-# build we just error out if things aren't there.
-$(LIBQEMUUTIL) $(BUILD_DIR)/config-host.h:
-	$(error $@ missing, re-run parent build)
-
-all: $(BUILD_DIR)/config-host.h $(BINARIES)
-
-# libtestfloat.a depends on libsoftfloat.a, so specify it first
-FP_TEST_LIBS := libtestfloat.a libsoftfloat.a $(LIBQEMUUTIL)
-
-fp-test$(EXESUF): fp-test.o slowfloat.o $(QEMU_SOFTFLOAT_OBJ) $(FP_TEST_LIBS)
-
-# Custom rule to build with SF_CFLAGS
-SF_BUILD = $(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-		$(QEMU_CFLAGS) $(SF_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
-		$($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-$(SF_OBJS_ALL_NOSPEC): %.o: $(SF_SOURCE_DIR)/%.c
-	$(SF_BUILD)
-$(SF_OBJS_SPECIALIZE): %.o: $(SF_SPECIALIZE_DIR)/%.c
-	$(SF_BUILD)
-
-libsoftfloat.a: $(SF_OBJS_ALL)
-
-# Custom rule to build with TF_CFLAGS
-$(TF_OBJS_LIB) slowfloat.o: %.o: $(TF_SOURCE_DIR)/%.c
-	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-		$(QEMU_CFLAGS) $(TF_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
-		$($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-libtestfloat.a: $(TF_OBJS_LIB)
-
-fp-bench$(EXESUF): fp-bench.o $(QEMU_SOFTFLOAT_OBJ) $(LIBQEMUUTIL)
-
-clean:
-	rm -f *.o *.d $(BINARIES)
-	rm -f *.gcno *.gcda *.gcov
-	rm -f fp-test$(EXESUF)
-	rm -f fp-bench$(EXESUF)
-	rm -f libsoftfloat.a
-	rm -f libtestfloat.a
-
--include $(wildcard *.d)
diff --git a/tests/fp/meson.build b/tests/fp/meson.build
new file mode 100644
index 0000000..eed9780
--- /dev/null
+++ b/tests/fp/meson.build
@@ -0,0 +1,628 @@
+fpcflags = [
+  # softfloat defines
+  '-DSOFTFLOAT_ROUND_ODD',
+  '-DINLINE_LEVEL=5',
+  '-DSOFTFLOAT_FAST_DIV32TO16',
+  '-DSOFTFLOAT_FAST_DIV64TO32',
+  '-DSOFTFLOAT_FAST_INT64',
+  # testfloat defines
+  '-DFLOAT16',
+  '-DFLOAT64',
+  '-DEXTFLOAT80',
+  '-DFLOAT128',
+  '-DFLOAT_ROUND_ODD',
+  '-DLONG_DOUBLE_IS_EXTFLOAT80',
+]
+
+sfdir = 'berkeley-softfloat-3/source'
+sfspedir = sfdir / '8086-SSE'
+tfdir = 'berkeley-testfloat-3/source'
+
+sfinc = include_directories(sfdir / 'include', sfspedir)
+
+tfcflags = [
+  '-Wno-strict-prototypes',
+  '-Wno-unknown-pragmas',
+  '-Wno-uninitialized',
+  '-Wno-missing-prototypes',
+  '-Wno-return-type',
+  '-Wno-unused-function',
+  '-Wno-error',
+]
+
+tfgencases = [
+  tfdir / 'genCases_ui32.c',
+  tfdir / 'genCases_ui64.c',
+  tfdir / 'genCases_i32.c',
+  tfdir / 'genCases_i64.c',
+  tfdir / 'genCases_f16.c',
+  tfdir / 'genCases_f32.c',
+  tfdir / 'genCases_f64.c',
+  tfdir / 'genCases_extF80.c',
+  tfdir / 'genCases_f128.c',
+]
+
+tfwritecase = [
+  tfdir / 'writeCase_a_ui32.c',
+  tfdir / 'writeCase_a_ui64.c',
+  tfdir / 'writeCase_a_f16.c',
+  tfdir / 'writeCase_ab_f16.c',
+  tfdir / 'writeCase_abc_f16.c',
+  tfdir / 'writeCase_a_f32.c',
+  tfdir / 'writeCase_ab_f32.c',
+  tfdir / 'writeCase_abc_f32.c',
+  tfdir / 'writeCase_a_f64.c',
+  tfdir / 'writeCase_ab_f64.c',
+  tfdir / 'writeCase_abc_f64.c',
+  tfdir / 'writeCase_a_extF80M.c',
+  tfdir / 'writeCase_ab_extF80M.c',
+  tfdir / 'writeCase_a_f128M.c',
+  tfdir / 'writeCase_ab_f128M.c',
+  tfdir / 'writeCase_abc_f128M.c',
+  tfdir / 'writeCase_z_bool.c',
+  tfdir / 'writeCase_z_ui32.c',
+  tfdir / 'writeCase_z_ui64.c',
+  tfdir / 'writeCase_z_f16.c',
+  tfdir / 'writeCase_z_f32.c',
+  tfdir / 'writeCase_z_f64.c',
+  tfdir / 'writeCase_z_extF80M.c',
+  tfdir / 'writeCase_z_f128M.c',
+]
+
+tftest = [
+  tfdir / 'test_a_ui32_z_f16.c',
+  tfdir / 'test_a_ui32_z_f32.c',
+  tfdir / 'test_a_ui32_z_f64.c',
+  tfdir / 'test_a_ui32_z_extF80.c',
+  tfdir / 'test_a_ui32_z_f128.c',
+  tfdir / 'test_a_ui64_z_f16.c',
+  tfdir / 'test_a_ui64_z_f32.c',
+  tfdir / 'test_a_ui64_z_f64.c',
+  tfdir / 'test_a_ui64_z_extF80.c',
+  tfdir / 'test_a_ui64_z_f128.c',
+  tfdir / 'test_a_i32_z_f16.c',
+  tfdir / 'test_a_i32_z_f32.c',
+  tfdir / 'test_a_i32_z_f64.c',
+  tfdir / 'test_a_i32_z_extF80.c',
+  tfdir / 'test_a_i32_z_f128.c',
+  tfdir / 'test_a_i64_z_f16.c',
+  tfdir / 'test_a_i64_z_f32.c',
+  tfdir / 'test_a_i64_z_f64.c',
+  tfdir / 'test_a_i64_z_extF80.c',
+  tfdir / 'test_a_i64_z_f128.c',
+  tfdir / 'test_a_f16_z_ui32_rx.c',
+  tfdir / 'test_a_f16_z_ui64_rx.c',
+  tfdir / 'test_a_f16_z_i32_rx.c',
+  tfdir / 'test_a_f16_z_i64_rx.c',
+  tfdir / 'test_a_f16_z_ui32_x.c',
+  tfdir / 'test_a_f16_z_ui64_x.c',
+  tfdir / 'test_a_f16_z_i32_x.c',
+  tfdir / 'test_a_f16_z_i64_x.c',
+  tfdir / 'test_a_f16_z_f32.c',
+  tfdir / 'test_a_f16_z_f64.c',
+  tfdir / 'test_a_f16_z_extF80.c',
+  tfdir / 'test_a_f16_z_f128.c',
+  tfdir / 'test_az_f16.c',
+  tfdir / 'test_az_f16_rx.c',
+  tfdir / 'test_abz_f16.c',
+  tfdir / 'test_abcz_f16.c',
+  tfdir / 'test_ab_f16_z_bool.c',
+  tfdir / 'test_a_f32_z_ui32_rx.c',
+  tfdir / 'test_a_f32_z_ui64_rx.c',
+  tfdir / 'test_a_f32_z_i32_rx.c',
+  tfdir / 'test_a_f32_z_i64_rx.c',
+  tfdir / 'test_a_f32_z_ui32_x.c',
+  tfdir / 'test_a_f32_z_ui64_x.c',
+  tfdir / 'test_a_f32_z_i32_x.c',
+  tfdir / 'test_a_f32_z_i64_x.c',
+  tfdir / 'test_a_f32_z_f16.c',
+  tfdir / 'test_a_f32_z_f64.c',
+  tfdir / 'test_a_f32_z_extF80.c',
+  tfdir / 'test_a_f32_z_f128.c',
+  tfdir / 'test_az_f32.c',
+  tfdir / 'test_az_f32_rx.c',
+  tfdir / 'test_abz_f32.c',
+  tfdir / 'test_abcz_f32.c',
+  tfdir / 'test_ab_f32_z_bool.c',
+  tfdir / 'test_a_f64_z_ui32_rx.c',
+  tfdir / 'test_a_f64_z_ui64_rx.c',
+  tfdir / 'test_a_f64_z_i32_rx.c',
+  tfdir / 'test_a_f64_z_i64_rx.c',
+  tfdir / 'test_a_f64_z_ui32_x.c',
+  tfdir / 'test_a_f64_z_ui64_x.c',
+  tfdir / 'test_a_f64_z_i32_x.c',
+  tfdir / 'test_a_f64_z_i64_x.c',
+  tfdir / 'test_a_f64_z_f16.c',
+  tfdir / 'test_a_f64_z_f32.c',
+  tfdir / 'test_a_f64_z_extF80.c',
+  tfdir / 'test_a_f64_z_f128.c',
+  tfdir / 'test_az_f64.c',
+  tfdir / 'test_az_f64_rx.c',
+  tfdir / 'test_abz_f64.c',
+  tfdir / 'test_abcz_f64.c',
+  tfdir / 'test_ab_f64_z_bool.c',
+  tfdir / 'test_a_extF80_z_ui32_rx.c',
+  tfdir / 'test_a_extF80_z_ui64_rx.c',
+  tfdir / 'test_a_extF80_z_i32_rx.c',
+  tfdir / 'test_a_extF80_z_i64_rx.c',
+  tfdir / 'test_a_extF80_z_ui32_x.c',
+  tfdir / 'test_a_extF80_z_ui64_x.c',
+  tfdir / 'test_a_extF80_z_i32_x.c',
+  tfdir / 'test_a_extF80_z_i64_x.c',
+  tfdir / 'test_a_extF80_z_f16.c',
+  tfdir / 'test_a_extF80_z_f32.c',
+  tfdir / 'test_a_extF80_z_f64.c',
+  tfdir / 'test_a_extF80_z_f128.c',
+  tfdir / 'test_az_extF80.c',
+  tfdir / 'test_az_extF80_rx.c',
+  tfdir / 'test_abz_extF80.c',
+  tfdir / 'test_ab_extF80_z_bool.c',
+  tfdir / 'test_a_f128_z_ui32_rx.c',
+  tfdir / 'test_a_f128_z_ui64_rx.c',
+  tfdir / 'test_a_f128_z_i32_rx.c',
+  tfdir / 'test_a_f128_z_i64_rx.c',
+  tfdir / 'test_a_f128_z_ui32_x.c',
+  tfdir / 'test_a_f128_z_ui64_x.c',
+  tfdir / 'test_a_f128_z_i32_x.c',
+  tfdir / 'test_a_f128_z_i64_x.c',
+  tfdir / 'test_a_f128_z_f16.c',
+  tfdir / 'test_a_f128_z_f32.c',
+  tfdir / 'test_a_f128_z_f64.c',
+  tfdir / 'test_a_f128_z_extF80.c',
+  tfdir / 'test_az_f128.c',
+  tfdir / 'test_az_f128_rx.c',
+  tfdir / 'test_abz_f128.c',
+  tfdir / 'test_abcz_f128.c',
+  tfdir / 'test_ab_f128_z_bool.c',
+]
+
+libtestfloat = static_library(
+  'testfloat',
+  files(
+    tfdir / 'uint128_inline.c',
+    tfdir / 'uint128.c',
+    tfdir / 'fail.c',
+    tfdir / 'functions_common.c',
+    tfdir / 'functionInfos.c',
+    tfdir / 'standardFunctionInfos.c',
+    tfdir / 'random.c',
+    tfdir / 'genCases_common.c',
+    tfgencases,
+    tfdir / 'genCases_writeTestsTotal.c',
+    tfdir / 'verCases_inline.c',
+    tfdir / 'verCases_common.c',
+    tfdir / 'verCases_writeFunctionName.c',
+    tfdir / 'readHex.c',
+    tfdir / 'writeHex.c',
+    tfwritecase,
+    tfdir / 'testLoops_common.c',
+    tftest,
+  ),
+  include_directories: sfinc,
+  c_args: tfcflags + fpcflags,
+)
+
+sfcflags = [
+  '-Wno-missing-prototypes',
+  '-Wno-redundant-decls',
+  '-Wno-return-type',
+  '-Wno-error',
+]
+
+libsoftfloat = static_library(
+  'softfloat',
+  files(
+    # primitives
+    sfdir / 's_eq128.c',
+    sfdir / 's_le128.c',
+    sfdir / 's_lt128.c',
+    sfdir / 's_shortShiftLeft128.c',
+    sfdir / 's_shortShiftRight128.c',
+    sfdir / 's_shortShiftRightJam64.c',
+    sfdir / 's_shortShiftRightJam64Extra.c',
+    sfdir / 's_shortShiftRightJam128.c',
+    sfdir / 's_shortShiftRightJam128Extra.c',
+    sfdir / 's_shiftRightJam32.c',
+    sfdir / 's_shiftRightJam64.c',
+    sfdir / 's_shiftRightJam64Extra.c',
+    sfdir / 's_shiftRightJam128.c',
+    sfdir / 's_shiftRightJam128Extra.c',
+    sfdir / 's_shiftRightJam256M.c',
+    sfdir / 's_countLeadingZeros8.c',
+    sfdir / 's_countLeadingZeros16.c',
+    sfdir / 's_countLeadingZeros32.c',
+    sfdir / 's_countLeadingZeros64.c',
+    sfdir / 's_add128.c',
+    sfdir / 's_add256M.c',
+    sfdir / 's_sub128.c',
+    sfdir / 's_sub256M.c',
+    sfdir / 's_mul64ByShifted32To128.c',
+    sfdir / 's_mul64To128.c',
+    sfdir / 's_mul128By32.c',
+    sfdir / 's_mul128To256M.c',
+    sfdir / 's_approxRecip_1Ks.c',
+    sfdir / 's_approxRecip32_1.c',
+    sfdir / 's_approxRecipSqrt_1Ks.c',
+    sfdir / 's_approxRecipSqrt32_1.c',
+    # others
+    sfdir / 's_roundToUI32.c',
+    sfdir / 's_roundToUI64.c',
+    sfdir / 's_roundToI32.c',
+    sfdir / 's_roundToI64.c',
+    sfdir / 's_normSubnormalF16Sig.c',
+    sfdir / 's_roundPackToF16.c',
+    sfdir / 's_normRoundPackToF16.c',
+    sfdir / 's_addMagsF16.c',
+    sfdir / 's_subMagsF16.c',
+    sfdir / 's_mulAddF16.c',
+    sfdir / 's_normSubnormalF32Sig.c',
+    sfdir / 's_roundPackToF32.c',
+    sfdir / 's_normRoundPackToF32.c',
+    sfdir / 's_addMagsF32.c',
+    sfdir / 's_subMagsF32.c',
+    sfdir / 's_mulAddF32.c',
+    sfdir / 's_normSubnormalF64Sig.c',
+    sfdir / 's_roundPackToF64.c',
+    sfdir / 's_normRoundPackToF64.c',
+    sfdir / 's_addMagsF64.c',
+    sfdir / 's_subMagsF64.c',
+    sfdir / 's_mulAddF64.c',
+    sfdir / 's_normSubnormalExtF80Sig.c',
+    sfdir / 's_roundPackToExtF80.c',
+    sfdir / 's_normRoundPackToExtF80.c',
+    sfdir / 's_addMagsExtF80.c',
+    sfdir / 's_subMagsExtF80.c',
+    sfdir / 's_normSubnormalF128Sig.c',
+    sfdir / 's_roundPackToF128.c',
+    sfdir / 's_normRoundPackToF128.c',
+    sfdir / 's_addMagsF128.c',
+    sfdir / 's_subMagsF128.c',
+    sfdir / 's_mulAddF128.c',
+    sfdir / 'softfloat_state.c',
+    sfdir / 'ui32_to_f16.c',
+    sfdir / 'ui32_to_f32.c',
+    sfdir / 'ui32_to_f64.c',
+    sfdir / 'ui32_to_extF80.c',
+    sfdir / 'ui32_to_extF80M.c',
+    sfdir / 'ui32_to_f128.c',
+    sfdir / 'ui32_to_f128M.c',
+    sfdir / 'ui64_to_f16.c',
+    sfdir / 'ui64_to_f32.c',
+    sfdir / 'ui64_to_f64.c',
+    sfdir / 'ui64_to_extF80.c',
+    sfdir / 'ui64_to_extF80M.c',
+    sfdir / 'ui64_to_f128.c',
+    sfdir / 'ui64_to_f128M.c',
+    sfdir / 'i32_to_f16.c',
+    sfdir / 'i32_to_f32.c',
+    sfdir / 'i32_to_f64.c',
+    sfdir / 'i32_to_extF80.c',
+    sfdir / 'i32_to_extF80M.c',
+    sfdir / 'i32_to_f128.c',
+    sfdir / 'i32_to_f128M.c',
+    sfdir / 'i64_to_f16.c',
+    sfdir / 'i64_to_f32.c',
+    sfdir / 'i64_to_f64.c',
+    sfdir / 'i64_to_extF80.c',
+    sfdir / 'i64_to_extF80M.c',
+    sfdir / 'i64_to_f128.c',
+    sfdir / 'i64_to_f128M.c',
+    sfdir / 'f16_to_ui32.c',
+    sfdir / 'f16_to_ui64.c',
+    sfdir / 'f16_to_i32.c',
+    sfdir / 'f16_to_i64.c',
+    sfdir / 'f16_to_ui32_r_minMag.c',
+    sfdir / 'f16_to_ui64_r_minMag.c',
+    sfdir / 'f16_to_i32_r_minMag.c',
+    sfdir / 'f16_to_i64_r_minMag.c',
+    sfdir / 'f16_to_f32.c',
+    sfdir / 'f16_to_f64.c',
+    sfdir / 'f16_to_extF80.c',
+    sfdir / 'f16_to_extF80M.c',
+    sfdir / 'f16_to_f128.c',
+    sfdir / 'f16_to_f128M.c',
+    sfdir / 'f16_roundToInt.c',
+    sfdir / 'f16_add.c',
+    sfdir / 'f16_sub.c',
+    sfdir / 'f16_mul.c',
+    sfdir / 'f16_mulAdd.c',
+    sfdir / 'f16_div.c',
+    sfdir / 'f16_rem.c',
+    sfdir / 'f16_sqrt.c',
+    sfdir / 'f16_eq.c',
+    sfdir / 'f16_le.c',
+    sfdir / 'f16_lt.c',
+    sfdir / 'f16_eq_signaling.c',
+    sfdir / 'f16_le_quiet.c',
+    sfdir / 'f16_lt_quiet.c',
+    sfdir / 'f16_isSignalingNaN.c',
+    sfdir / 'f32_to_ui32.c',
+    sfdir / 'f32_to_ui64.c',
+    sfdir / 'f32_to_i32.c',
+    sfdir / 'f32_to_i64.c',
+    sfdir / 'f32_to_ui32_r_minMag.c',
+    sfdir / 'f32_to_ui64_r_minMag.c',
+    sfdir / 'f32_to_i32_r_minMag.c',
+    sfdir / 'f32_to_i64_r_minMag.c',
+    sfdir / 'f32_to_f16.c',
+    sfdir / 'f32_to_f64.c',
+    sfdir / 'f32_to_extF80.c',
+    sfdir / 'f32_to_extF80M.c',
+    sfdir / 'f32_to_f128.c',
+    sfdir / 'f32_to_f128M.c',
+    sfdir / 'f32_roundToInt.c',
+    sfdir / 'f32_add.c',
+    sfdir / 'f32_sub.c',
+    sfdir / 'f32_mul.c',
+    sfdir / 'f32_mulAdd.c',
+    sfdir / 'f32_div.c',
+    sfdir / 'f32_rem.c',
+    sfdir / 'f32_sqrt.c',
+    sfdir / 'f32_eq.c',
+    sfdir / 'f32_le.c',
+    sfdir / 'f32_lt.c',
+    sfdir / 'f32_eq_signaling.c',
+    sfdir / 'f32_le_quiet.c',
+    sfdir / 'f32_lt_quiet.c',
+    sfdir / 'f32_isSignalingNaN.c',
+    sfdir / 'f64_to_ui32.c',
+    sfdir / 'f64_to_ui64.c',
+    sfdir / 'f64_to_i32.c',
+    sfdir / 'f64_to_i64.c',
+    sfdir / 'f64_to_ui32_r_minMag.c',
+    sfdir / 'f64_to_ui64_r_minMag.c',
+    sfdir / 'f64_to_i32_r_minMag.c',
+    sfdir / 'f64_to_i64_r_minMag.c',
+    sfdir / 'f64_to_f16.c',
+    sfdir / 'f64_to_f32.c',
+    sfdir / 'f64_to_extF80.c',
+    sfdir / 'f64_to_extF80M.c',
+    sfdir / 'f64_to_f128.c',
+    sfdir / 'f64_to_f128M.c',
+    sfdir / 'f64_roundToInt.c',
+    sfdir / 'f64_add.c',
+    sfdir / 'f64_sub.c',
+    sfdir / 'f64_mul.c',
+    sfdir / 'f64_mulAdd.c',
+    sfdir / 'f64_div.c',
+    sfdir / 'f64_rem.c',
+    sfdir / 'f64_sqrt.c',
+    sfdir / 'f64_eq.c',
+    sfdir / 'f64_le.c',
+    sfdir / 'f64_lt.c',
+    sfdir / 'f64_eq_signaling.c',
+    sfdir / 'f64_le_quiet.c',
+    sfdir / 'f64_lt_quiet.c',
+    sfdir / 'f64_isSignalingNaN.c',
+    sfdir / 'extF80_to_ui32.c',
+    sfdir / 'extF80_to_ui64.c',
+    sfdir / 'extF80_to_i32.c',
+    sfdir / 'extF80_to_i64.c',
+    sfdir / 'extF80_to_ui32_r_minMag.c',
+    sfdir / 'extF80_to_ui64_r_minMag.c',
+    sfdir / 'extF80_to_i32_r_minMag.c',
+    sfdir / 'extF80_to_i64_r_minMag.c',
+    sfdir / 'extF80_to_f16.c',
+    sfdir / 'extF80_to_f32.c',
+    sfdir / 'extF80_to_f64.c',
+    sfdir / 'extF80_to_f128.c',
+    sfdir / 'extF80_roundToInt.c',
+    sfdir / 'extF80_add.c',
+    sfdir / 'extF80_sub.c',
+    sfdir / 'extF80_mul.c',
+    sfdir / 'extF80_div.c',
+    sfdir / 'extF80_rem.c',
+    sfdir / 'extF80_sqrt.c',
+    sfdir / 'extF80_eq.c',
+    sfdir / 'extF80_le.c',
+    sfdir / 'extF80_lt.c',
+    sfdir / 'extF80_eq_signaling.c',
+    sfdir / 'extF80_le_quiet.c',
+    sfdir / 'extF80_lt_quiet.c',
+    sfdir / 'extF80_isSignalingNaN.c',
+    sfdir / 'extF80M_to_ui32.c',
+    sfdir / 'extF80M_to_ui64.c',
+    sfdir / 'extF80M_to_i32.c',
+    sfdir / 'extF80M_to_i64.c',
+    sfdir / 'extF80M_to_ui32_r_minMag.c',
+    sfdir / 'extF80M_to_ui64_r_minMag.c',
+    sfdir / 'extF80M_to_i32_r_minMag.c',
+    sfdir / 'extF80M_to_i64_r_minMag.c',
+    sfdir / 'extF80M_to_f16.c',
+    sfdir / 'extF80M_to_f32.c',
+    sfdir / 'extF80M_to_f64.c',
+    sfdir / 'extF80M_to_f128M.c',
+    sfdir / 'extF80M_roundToInt.c',
+    sfdir / 'extF80M_add.c',
+    sfdir / 'extF80M_sub.c',
+    sfdir / 'extF80M_mul.c',
+    sfdir / 'extF80M_div.c',
+    sfdir / 'extF80M_rem.c',
+    sfdir / 'extF80M_sqrt.c',
+    sfdir / 'extF80M_eq.c',
+    sfdir / 'extF80M_le.c',
+    sfdir / 'extF80M_lt.c',
+    sfdir / 'extF80M_eq_signaling.c',
+    sfdir / 'extF80M_le_quiet.c',
+    sfdir / 'extF80M_lt_quiet.c',
+    sfdir / 'f128_to_ui32.c',
+    sfdir / 'f128_to_ui64.c',
+    sfdir / 'f128_to_i32.c',
+    sfdir / 'f128_to_i64.c',
+    sfdir / 'f128_to_ui32_r_minMag.c',
+    sfdir / 'f128_to_ui64_r_minMag.c',
+    sfdir / 'f128_to_i32_r_minMag.c',
+    sfdir / 'f128_to_i64_r_minMag.c',
+    sfdir / 'f128_to_f16.c',
+    sfdir / 'f128_to_f32.c',
+    sfdir / 'f128_to_extF80.c',
+    sfdir / 'f128_to_f64.c',
+    sfdir / 'f128_roundToInt.c',
+    sfdir / 'f128_add.c',
+    sfdir / 'f128_sub.c',
+    sfdir / 'f128_mul.c',
+    sfdir / 'f128_mulAdd.c',
+    sfdir / 'f128_div.c',
+    sfdir / 'f128_rem.c',
+    sfdir / 'f128_sqrt.c',
+    sfdir / 'f128_eq.c',
+    sfdir / 'f128_le.c',
+    sfdir / 'f128_lt.c',
+    sfdir / 'f128_eq_signaling.c',
+    sfdir / 'f128_le_quiet.c',
+    sfdir / 'f128_lt_quiet.c',
+    sfdir / 'f128_isSignalingNaN.c',
+    sfdir / 'f128M_to_ui32.c',
+    sfdir / 'f128M_to_ui64.c',
+    sfdir / 'f128M_to_i32.c',
+    sfdir / 'f128M_to_i64.c',
+    sfdir / 'f128M_to_ui32_r_minMag.c',
+    sfdir / 'f128M_to_ui64_r_minMag.c',
+    sfdir / 'f128M_to_i32_r_minMag.c',
+    sfdir / 'f128M_to_i64_r_minMag.c',
+    sfdir / 'f128M_to_f16.c',
+    sfdir / 'f128M_to_f32.c',
+    sfdir / 'f128M_to_extF80M.c',
+    sfdir / 'f128M_to_f64.c',
+    sfdir / 'f128M_roundToInt.c',
+    sfdir / 'f128M_add.c',
+    sfdir / 'f128M_sub.c',
+    sfdir / 'f128M_mul.c',
+    sfdir / 'f128M_mulAdd.c',
+    sfdir / 'f128M_div.c',
+    sfdir / 'f128M_rem.c',
+    sfdir / 'f128M_sqrt.c',
+    sfdir / 'f128M_eq.c',
+    sfdir / 'f128M_le.c',
+    sfdir / 'f128M_lt.c',
+    sfdir / 'f128M_eq_signaling.c',
+    sfdir / 'f128M_le_quiet.c',
+    sfdir / 'f128M_lt_quiet.c',
+    # spe
+    sfspedir / 'softfloat_raiseFlags.c',
+    sfspedir / 's_f16UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToF16UI.c',
+    sfspedir / 's_propagateNaNF16UI.c',
+    sfspedir / 's_f32UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToF32UI.c',
+    sfspedir / 's_propagateNaNF32UI.c',
+    sfspedir / 's_f64UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToF64UI.c',
+    sfspedir / 's_propagateNaNF64UI.c',
+    sfspedir / 'extF80M_isSignalingNaN.c',
+    sfspedir / 's_extF80UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToExtF80UI.c',
+    sfspedir / 's_propagateNaNExtF80UI.c',
+    sfspedir / 'f128M_isSignalingNaN.c',
+    sfspedir / 's_f128UIToCommonNaN.c',
+    sfspedir / 's_commonNaNToF128UI.c',
+    sfspedir / 's_propagateNaNF128UI.c',
+  ),
+  include_directories: sfinc,
+  c_args: sfcflags + fpcflags,
+)
+
+fpcflags += [
+  # work around TARGET_* poisoning
+  '-DHW_POISON_H',
+  # define a target to match testfloat's implementation-defined choices, such as
+  # whether to raise the invalid flag when dealing with NaNs in muladd.
+  '-DTARGET_ARM',
+  # FIXME: uiZ may be used uninitialized in this function
+  '-Wno-uninitialized',
+]
+
+fptest = executable(
+  'fp-test',
+  ['fp-test.c', tfdir / 'slowfloat.c', '../../fpu/softfloat.c'],
+  link_with: [libtestfloat, libsoftfloat],
+  dependencies: [qemuutil],
+  include_directories: [sfinc, include_directories(tfdir)],
+  c_args: fpcflags,
+)
+softfloat_conv_tests = {
+    'float-to-float': 'f16_to_f32 f16_to_f64 f16_to_extF80 f16_to_f128 ' +
+                      'f32_to_f16 f32_to_f64 f32_to_extF80 ' +
+                      'f64_to_f16 f64_to_f32 ' +
+                      'extF80_to_f16 extF80_to_f32 ' +
+                      'extF80_to_f64 extF80_to_f128 ' +
+                      'f128_to_f16',
+    'int-to-float': 'i32_to_f16 i64_to_f16 i32_to_f32 i64_to_f32 ' +
+                    'i32_to_f64 i64_to_f64 i32_to_f128 i64_to_f128',
+    'uint-to-float': 'ui32_to_f16 ui64_to_f16 ui32_to_f32 ui64_to_f32 ' +
+                     'ui32_to_f64 ui64_to_f64 ui64_to_f128 ' +
+                     'ui32_to_extF80 ui64_to_extF80',
+    'float-to-int': 'f16_to_i32 f16_to_i32_r_minMag ' +
+                    'f32_to_i32 f32_to_i32_r_minMag ' +
+                    'f64_to_i32 f64_to_i32_r_minMag ' +
+                    'extF80_to_i32 extF80_to_i32_r_minMag ' +
+                    'f128_to_i32 f128_to_i32_r_minMag ' +
+                    'f16_to_i64 f16_to_i64_r_minMag ' +
+                    'f32_to_i64 f32_to_i64_r_minMag ' +
+                    'f64_to_i64 f64_to_i64_r_minMag ' +
+                    'extF80_to_i64 extF80_to_i64_r_minMag ' +
+                    'f128_to_i64 f128_to_i64_r_minMag',
+    'float-to-uint': 'f16_to_ui32 f16_to_ui32_r_minMag ' +
+                     'f32_to_ui32 f32_to_ui32_r_minMag ' +
+                     'f64_to_ui32 f64_to_ui32_r_minMag ' +
+                     'extF80_to_ui32 extF80_to_ui32_r_minMag ' +
+                     'f128_to_ui32 f128_to_ui32_r_minMag ' +
+                     'f16_to_ui64 f16_to_ui64_r_minMag ' +
+                     'f32_to_ui64 f32_to_ui64_r_minMag ' +
+                     'f64_to_ui64 f64_to_ui64_r_minMag ' +
+                     'extF80_to_ui64 extF80_to_ui64_r_minMag ' +
+                     'f128_to_ui64 f128_to_ui64_r_minMag',
+    'round-to-integer': 'f16_roundToInt f32_roundToInt ' +
+                        'f64_roundToInt f128_roundToInt'
+}
+softfloat_tests = {
+    'eq_signaling' : 'compare',
+    'le' : 'compare',
+    'le_quiet' : 'compare',
+    'lt_quiet' : 'compare',
+    'add': 'ops',
+    'sub': 'ops',
+    'mul': 'ops',
+    'div': 'ops',
+    'rem': 'ops',
+    'sqrt': 'ops'
+}
+# The full test suite can take a bit of time, default to a quick run
+# "-l 2 -r all" can take more than a day for some operations and is best
+# run manually
+fptest_args = ['-s', '-l', '1']
+fptest_rounding_args = ['-r', 'all']
+
+# Conversion Routines:
+# FIXME: i32_to_extF80 (broken), i64_to_extF80 (broken)
+#        extF80_roundToInt (broken)
+foreach k, v : softfloat_conv_tests
+  test('fp-test:' + k, fptest,
+       args: fptest_args + fptest_rounding_args + v.split(),
+       suite: ['softfloat', 'softfloat-conv'])
+endforeach
+
+# FIXME: extF80_{lt_quiet, rem} (broken),
+#        extF80_{mulAdd} (missing)
+foreach k, v : softfloat_tests
+  extF80_broken = ['lt_quiet', 'rem'].contains(k)
+  test('fp-test:' + k, fptest,
+       args: fptest_args + fptest_rounding_args +
+             ['f16_' + k, 'f32_' + k, 'f64_' + k, 'f128_' + k] +
+             (extF80_broken ? [] : ['extF80_' + k]),
+       suite: ['softfloat', 'softfloat-' + v])
+endforeach
+test('fp-test:mulAdd', fptest,
+     # no fptest_rounding_args
+     args: fptest_args +
+           ['f16_mulAdd', 'f32_mulAdd', 'f64_mulAdd', 'f128_mulAdd'],
+     suite: ['softfloat-slow', 'softfloat-ops-slow'], timeout: 60)
+
+fpbench = executable(
+  'fp-bench',
+  ['fp-bench.c', '../../fpu/softfloat.c'],
+  link_with: [libtestfloat, libsoftfloat],
+  dependencies: [qemuutil],
+  include_directories: [sfinc, include_directories(tfdir)],
+  c_args: fpcflags,
+)
diff --git a/tests/meson.build b/tests/meson.build
index 5c52021..ec26f92 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -2,3 +2,7 @@ test('decodetree', sh,
      args: [ files('decode/check.sh'), config_host['PYTHON'], files('../scripts/decodetree.py') ],
      workdir: meson.current_source_dir() / 'decode',
      suite: 'decodetree')
+
+if 'CONFIG_TCG' in config_host
+  subdir('fp')
+endif
-- 
1.8.3.1



