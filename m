Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B084C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7D22071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlMMxwl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7D22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjBp-0005XQ-Ai
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj0G-0003fY-5I
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj05-0006Us-AD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id v12so847885wmh.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/laYIHxdeuLm4zI4TxtRJea7G0QuLHmDlWkSfYuWKHs=;
 b=HlMMxwl8+PC3pA3Sr/sTZydSI5j+D664XV83/6VdyRSS7HtMwdDV2WD9ug4WIJt2Rs
 sSqMujPxBS0s2aTOculircjlqvvClMUpc/L0KPbQKITWb7uEVmdON+ghqnAUJQWOHWUk
 dNBLTUvrCViir0eJpBtIDu+1362oe1SAlBQbaqvNtNVlW6O91ZcDt0AfOplnKyqZFHK+
 g6R8pvVZlm4cP5Zkq7+7LIGJZ1XqZGSq6FIZnXFkpde//TR/R524VTNX5CHSqco43qd1
 3XMFXYRVn/DfGMpKAfzeI3obIGnJDJ7EFiHHrrzHuuDutoVuZjBWs5ZuyOac08VjTmYf
 13DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/laYIHxdeuLm4zI4TxtRJea7G0QuLHmDlWkSfYuWKHs=;
 b=s/xyMxtAs4qpgTdWZTFb/Oq/IUto/ePADSqbhWV1cJ0+u9hVw/XJKfEThXJFA6s4TJ
 pWqkEXfLlS+91ELMW5J66U9di4eALUP+jyirZ90cnZLwRDrVt/uM++IRhGFQ8MekIOuF
 tHZngz+2Jx+U/3fhhkeBYpFOy8+696/wErEG5QUeYnZkNdfD57REe/LA6hFscw0Pcs9S
 yfSfP7LhqVnfqguqrSYmB6DdbXLHtpUsLRf1224IgC9Y0lFfInAbJRhUHK9FT/qp1O7l
 inRMq4+ohDpWi+/Gf4Qfp4v+MBmaEnLQMJhrj3VqAEmKZZTKskFrUM1hWLMCYOiJ3qGU
 hINw==
X-Gm-Message-State: AOAM531isHx9KkDLFmNwZPOvRdGHQaKoC5zrwcGJM/KDgZ/nfmkt6Hgw
 xMlcZL2PtpnPtocyr5whR20NOPbORN7/NA==
X-Google-Smtp-Source: ABdhPJyYAmlLApYaq5bv/1AqnZ4wdXICdZ39c4Pmz7Ovvtcy7/ifc5ayQGlxTUlFud4JfCo9WScIdA==
X-Received: by 2002:a1c:2ed0:: with SMTP id u199mr4736303wmu.125.1601498813436; 
 Wed, 30 Sep 2020 13:46:53 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:52 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 14/14] tests/tcg: ARC: Add TCG instruction definition tests
Date: Wed, 30 Sep 2020 21:46:04 +0100
Message-Id: <20200930204604.20663-15-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudiu Zissulescu <claziss@synopsys.com>

The added tests verify basic instructions execution as well
as more advanced features such as zero overhead loops interrupt
system, memory management unit and memory protection unit.

Signed-off-by: Claudiu Zissulescu <claziss@synopsys.com>
---
 tests/Makefile.include                |   1 +
 tests/tcg/Makefile.qemu               |  16 +-
 tests/tcg/Makefile.target             |   9 +-
 tests/tcg/arc/Makefile                | 112 ++++
 tests/tcg/arc/Makefile.softmmu-target |  36 ++
 tests/tcg/arc/Makefile.target         | 101 ++++
 tests/tcg/arc/check_add.S             |  11 +
 tests/tcg/arc/check_addx.S            |  71 +++
 tests/tcg/arc/check_andx.S            |  36 ++
 tests/tcg/arc/check_aslx.S            |  57 ++
 tests/tcg/arc/check_asrx.S            |  86 ++++
 tests/tcg/arc/check_basic1.S          |  30 ++
 tests/tcg/arc/check_basic2.S          |  26 +
 tests/tcg/arc/check_beq.S             |  14 +
 tests/tcg/arc/check_beqx.S            |  26 +
 tests/tcg/arc/check_big_tb.S          | 173 +++++++
 tests/tcg/arc/check_bnex.S            |  26 +
 tests/tcg/arc/check_breqx.S           |  26 +
 tests/tcg/arc/check_brgex.S           |  26 +
 tests/tcg/arc/check_brhsx.S           |  27 +
 tests/tcg/arc/check_brlox.S           |  26 +
 tests/tcg/arc/check_brltx.S           |  26 +
 tests/tcg/arc/check_brnex.S           |  26 +
 tests/tcg/arc/check_bta.S             | 294 +++++++++++
 tests/tcg/arc/check_carry.S           |  15 +
 tests/tcg/arc/check_enter_leave.S     | 715 ++++++++++++++++++++++++++
 tests/tcg/arc/check_excp.S            |  17 +
 tests/tcg/arc/check_excp_1.c          |  15 +
 tests/tcg/arc/check_excp_jumpdl_mmu.S |  44 ++
 tests/tcg/arc/check_excp_mmu.S        |  69 +++
 tests/tcg/arc/check_flags.S           |  23 +
 tests/tcg/arc/check_ldaw_mmu.S        |  71 +++
 tests/tcg/arc/check_ldstx.S           |  37 ++
 tests/tcg/arc/check_lp.S              |  12 +
 tests/tcg/arc/check_lp02.S            |  72 +++
 tests/tcg/arc/check_lp03.S            |  49 ++
 tests/tcg/arc/check_lp04.S            |  48 ++
 tests/tcg/arc/check_lp05.S            |  23 +
 tests/tcg/arc/check_lp06.S            | 163 ++++++
 tests/tcg/arc/check_lsrx.S            |  33 ++
 tests/tcg/arc/check_mac.S             | 228 ++++++++
 tests/tcg/arc/check_manip_10_mmu.S    | 173 +++++++
 tests/tcg/arc/check_manip_4_mmu.S     | 158 ++++++
 tests/tcg/arc/check_manip_5_mmu.S     | 166 ++++++
 tests/tcg/arc/check_manip_mmu.S       | 565 ++++++++++++++++++++
 tests/tcg/arc/check_mmu.S             |  59 +++
 tests/tcg/arc/check_mpu.S             | 703 +++++++++++++++++++++++++
 tests/tcg/arc/check_mpyd.S            | 543 +++++++++++++++++++
 tests/tcg/arc/check_mpyw.S            |  41 ++
 tests/tcg/arc/check_norm.S            |  40 ++
 tests/tcg/arc/check_orx.S             |  34 ++
 tests/tcg/arc/check_prefetch.S        |  37 ++
 tests/tcg/arc/check_rolx.S            |  47 ++
 tests/tcg/arc/check_rorx.S            |  64 +++
 tests/tcg/arc/check_rtc.S             |  29 ++
 tests/tcg/arc/check_rtie_user.S       |  30 ++
 tests/tcg/arc/check_stld.S            |  10 +
 tests/tcg/arc/check_subf.S            |  67 +++
 tests/tcg/arc/check_subx.S            |  43 ++
 tests/tcg/arc/check_swi.S             | 115 +++++
 tests/tcg/arc/check_swirq.S           |  27 +
 tests/tcg/arc/check_swirq1.S          |  31 ++
 tests/tcg/arc/check_swirq3.S          |  49 ++
 tests/tcg/arc/check_t01.S             |  12 +
 tests/tcg/arc/check_t02.S             |   9 +
 tests/tcg/arc/check_timer0.S          |  36 ++
 tests/tcg/arc/check_timer0_loop.S     |  34 ++
 tests/tcg/arc/check_timer0_loop3.S    |  46 ++
 tests/tcg/arc/check_timer0_retrig.S   |  29 ++
 tests/tcg/arc/check_timer0_sleep.S    |  33 ++
 tests/tcg/arc/check_timerX_freq.S     |  87 ++++
 tests/tcg/arc/check_vadd.S            | 510 ++++++++++++++++++
 tests/tcg/arc/check_vsub.S            | 510 ++++++++++++++++++
 tests/tcg/arc/check_xorx.S            |  32 ++
 tests/tcg/arc/ivt.S                   |  38 ++
 tests/tcg/arc/macros.inc              | 261 ++++++++++
 tests/tcg/arc/memory.x                |  12 +
 tests/tcg/arc/mmu.inc                 | 132 +++++
 tests/tcg/arc/mpu.inc                 | 269 ++++++++++
 tests/tcg/arc/tarc.ld                 |  15 +
 tests/tcg/arc/tarc_mmu.ld             |  15 +
 tests/tcg/arc/test_macros.h           | 257 +++++++++
 tests/tcg/configure.sh                |   3 +-
 83 files changed, 8280 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/arc/Makefile
 create mode 100644 tests/tcg/arc/Makefile.softmmu-target
 create mode 100644 tests/tcg/arc/Makefile.target
 create mode 100644 tests/tcg/arc/check_add.S
 create mode 100644 tests/tcg/arc/check_addx.S
 create mode 100644 tests/tcg/arc/check_andx.S
 create mode 100644 tests/tcg/arc/check_aslx.S
 create mode 100644 tests/tcg/arc/check_asrx.S
 create mode 100644 tests/tcg/arc/check_basic1.S
 create mode 100644 tests/tcg/arc/check_basic2.S
 create mode 100644 tests/tcg/arc/check_beq.S
 create mode 100644 tests/tcg/arc/check_beqx.S
 create mode 100644 tests/tcg/arc/check_big_tb.S
 create mode 100644 tests/tcg/arc/check_bnex.S
 create mode 100644 tests/tcg/arc/check_breqx.S
 create mode 100644 tests/tcg/arc/check_brgex.S
 create mode 100644 tests/tcg/arc/check_brhsx.S
 create mode 100644 tests/tcg/arc/check_brlox.S
 create mode 100644 tests/tcg/arc/check_brltx.S
 create mode 100644 tests/tcg/arc/check_brnex.S
 create mode 100644 tests/tcg/arc/check_bta.S
 create mode 100644 tests/tcg/arc/check_carry.S
 create mode 100644 tests/tcg/arc/check_enter_leave.S
 create mode 100644 tests/tcg/arc/check_excp.S
 create mode 100644 tests/tcg/arc/check_excp_1.c
 create mode 100644 tests/tcg/arc/check_excp_jumpdl_mmu.S
 create mode 100644 tests/tcg/arc/check_excp_mmu.S
 create mode 100644 tests/tcg/arc/check_flags.S
 create mode 100644 tests/tcg/arc/check_ldaw_mmu.S
 create mode 100644 tests/tcg/arc/check_ldstx.S
 create mode 100644 tests/tcg/arc/check_lp.S
 create mode 100644 tests/tcg/arc/check_lp02.S
 create mode 100644 tests/tcg/arc/check_lp03.S
 create mode 100644 tests/tcg/arc/check_lp04.S
 create mode 100644 tests/tcg/arc/check_lp05.S
 create mode 100644 tests/tcg/arc/check_lp06.S
 create mode 100644 tests/tcg/arc/check_lsrx.S
 create mode 100644 tests/tcg/arc/check_mac.S
 create mode 100644 tests/tcg/arc/check_manip_10_mmu.S
 create mode 100644 tests/tcg/arc/check_manip_4_mmu.S
 create mode 100644 tests/tcg/arc/check_manip_5_mmu.S
 create mode 100644 tests/tcg/arc/check_manip_mmu.S
 create mode 100644 tests/tcg/arc/check_mmu.S
 create mode 100644 tests/tcg/arc/check_mpu.S
 create mode 100644 tests/tcg/arc/check_mpyd.S
 create mode 100644 tests/tcg/arc/check_mpyw.S
 create mode 100644 tests/tcg/arc/check_norm.S
 create mode 100644 tests/tcg/arc/check_orx.S
 create mode 100644 tests/tcg/arc/check_prefetch.S
 create mode 100644 tests/tcg/arc/check_rolx.S
 create mode 100644 tests/tcg/arc/check_rorx.S
 create mode 100644 tests/tcg/arc/check_rtc.S
 create mode 100644 tests/tcg/arc/check_rtie_user.S
 create mode 100644 tests/tcg/arc/check_stld.S
 create mode 100644 tests/tcg/arc/check_subf.S
 create mode 100644 tests/tcg/arc/check_subx.S
 create mode 100644 tests/tcg/arc/check_swi.S
 create mode 100644 tests/tcg/arc/check_swirq.S
 create mode 100644 tests/tcg/arc/check_swirq1.S
 create mode 100644 tests/tcg/arc/check_swirq3.S
 create mode 100644 tests/tcg/arc/check_t01.S
 create mode 100644 tests/tcg/arc/check_t02.S
 create mode 100644 tests/tcg/arc/check_timer0.S
 create mode 100644 tests/tcg/arc/check_timer0_loop.S
 create mode 100644 tests/tcg/arc/check_timer0_loop3.S
 create mode 100644 tests/tcg/arc/check_timer0_retrig.S
 create mode 100644 tests/tcg/arc/check_timer0_sleep.S
 create mode 100644 tests/tcg/arc/check_timerX_freq.S
 create mode 100644 tests/tcg/arc/check_vadd.S
 create mode 100644 tests/tcg/arc/check_vsub.S
 create mode 100644 tests/tcg/arc/check_xorx.S
 create mode 100644 tests/tcg/arc/ivt.S
 create mode 100644 tests/tcg/arc/macros.inc
 create mode 100644 tests/tcg/arc/memory.x
 create mode 100644 tests/tcg/arc/mmu.inc
 create mode 100644 tests/tcg/arc/mpu.inc
 create mode 100644 tests/tcg/arc/tarc.ld
 create mode 100644 tests/tcg/arc/tarc_mmu.ld
 create mode 100644 tests/tcg/arc/test_macros.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 40d909badc..7e45f36e55 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -54,6 +54,7 @@ build-tcg-tests-%: $(if $(CONFIG_PLUGIN),test-plugins)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) \
+		BUILD_DIR=$(BUILD_DIR) \
 	       	V="$(V)" TARGET="$*" guest-tests, \
 		"BUILD", "TCG tests for $*")
 
diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
index 0332bad10f..04beee1a11 100644
--- a/tests/tcg/Makefile.qemu
+++ b/tests/tcg/Makefile.qemu
@@ -16,7 +16,7 @@ DOCKER_IMAGE:=
 -include $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak
 
 GUEST_BUILD=
-TCG_MAKE=../Makefile.target
+TCG_MAKE=$(SRC_PATH)/tests/tcg/Makefile.target
 
 # We also need the Docker make rules to depend on
 SKIP_DOCKER_BUILD=1
@@ -24,12 +24,21 @@ include $(SRC_PATH)/tests/docker/Makefile.include
 
 # Support installed Cross Compilers
 
-ifdef CROSS_CC_GUEST
+ifneq ($(CROSS_CC_GUEST),)
 
 .PHONY: cross-build-guest-tests
 cross-build-guest-tests:
+	@echo  $(TARGET)
+	@echo $(SRC_PATH)
+	@echo $(TCG_MAKE)
+	touch /tmp/bla
+	mkdir -p $(BUILD_DIR)/tests/tcg/$(TARGET)
+	cd $(BUILD_DIR)/tests/tcg/$(TARGET)
+	$(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC="$(CROSS_CC_GUEST)" \
+		SRC_PATH="$(SRC_PATH)" BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
+		EXTRA_CFLAGS="$(CROSS_CC_GUEST_CFLAGS) V=1 --trace"
 	$(call quiet-command, \
-	   (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
+	   (touch /tmp/bla && mkdir -p $(BUILD_DIR)/tests/tcg/$(TARGET) && cd $(BUILD_DIR)/tests/tcg/$(TARGET) && \
 	    $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC="$(CROSS_CC_GUEST)" \
 			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
 			EXTRA_CFLAGS="$(CROSS_CC_GUEST_CFLAGS)"), \
@@ -79,6 +88,7 @@ run-guest-tests: guest-tests
 
 else
 guest-tests:
+	@echo $(CROSS_CC_GUEST)
 	$(call quiet-command, /bin/true, "BUILD", \
 		"$(TARGET) guest-tests SKIPPED")
 
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 2ae86776cd..2615bb90c9 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -29,9 +29,8 @@
 # We also expect to be in the tests build dir for the FOO-(linux-user|softmmu).
 #
 
-all:
--include ../../../config-host.mak
--include ../config-$(TARGET).mak
+-include $(SRC_PATH)/tests/tcg/arc-softmmu/../../../config-host.mak
+-include $(SRC_PATH)/tests/tcg/arc-softmmu/../config-$(TARGET).mak
 
 # for including , in command strings
 COMMA := ,
@@ -112,6 +111,7 @@ else
 endif
 
 all: $(TESTS) $(EXTRA_TESTS)
+	@echo $(TESTS)
 
 #
 # Test Runners
@@ -181,4 +181,7 @@ gdb-%: %
 .PHONY: run
 run: $(RUN_TESTS)
 
+#test-arc:
+#	$(MAKE) -C arc check
+
 # There is no clean target, the calling make just rm's the tests build dir
diff --git a/tests/tcg/arc/Makefile b/tests/tcg/arc/Makefile
new file mode 100644
index 0000000000..881bb2dec8
--- /dev/null
+++ b/tests/tcg/arc/Makefile
@@ -0,0 +1,112 @@
+-include ../../../config-host.mak
+
+CROSS = arc-elf32-
+#CROSS = arc-snps-linux-uclibc-
+
+SIM = ../../../arc-softmmu/qemu-system-arc
+SIM_FLAGS = -M arc-sim -m 3G -nographic -no-reboot -monitor none \
+	-serial stdio -global cpu.mpu-numreg=8 -kernel
+#SIM_FLAGS=-cpu archs
+TST_PATH = $(SRC_PATH)/tests/tcg/arc
+
+CC = $(CROSS)gcc
+LD = $(CROSS)ld
+AS = $(CROSS)as
+CFLAGS  = -mcpu=archs -O2 --specs=qemu.specs
+ASFLAGS = -mcpu=archs
+
+TESTCASES = check_add.tst
+TESTCASES += check_lp.tst
+TESTCASES += check_lp02.tst
+TESTCASES += check_lp03.tst
+TESTCASES += check_lp04.tst
+TESTCASES += check_lp05.tst
+TESTCASES += check_lp06.tst
+TESTCASES += check_addx.tst
+TESTCASES += check_andx.tst
+TESTCASES += check_aslx.tst
+TESTCASES += check_asrx.tst
+TESTCASES += check_orx.tst
+TESTCASES += check_rolx.tst
+TESTCASES += check_rorx.tst
+TESTCASES += check_subx.tst
+TESTCASES += check_xorx.tst
+TESTCASES += check_beqx.tst
+TESTCASES += check_bnex.tst
+TESTCASES += check_brhsx.tst
+TESTCASES += check_brlox.tst
+TESTCASES += check_breqx.tst
+TESTCASES += check_brnex.tst
+TESTCASES += check_brltx.tst
+TESTCASES += check_brgex.tst
+TESTCASES += check_ldstx.tst
+TESTCASES += check_stld.tst
+TESTCASES += check_lsrx.tst
+TESTCASES += check_beq.tst
+TESTCASES += check_carry.tst
+TESTCASES += check_flags.tst
+TESTCASES += check_t01.tst
+TESTCASES += check_t02.tst
+TESTCASES += check_basic1.tst
+TESTCASES += check_basic2.tst
+TESTCASES += check_norm.tst
+TESTCASES += check_excp.tst
+TESTCASES += check_excp_1.ctst
+TESTCASES += check_mmu.tst
+TESTCASES += check_excp_mmu.tst
+TESTCASES += check_excp_jumpdl_mmu.tst
+TESTCASES += check_timer0.tst
+TESTCASES += check_timer0_loop.tst
+TESTCASES += check_timer0_loop3.tst
+TESTCASES += check_timer0_retrig.tst
+TESTCASES += check_timer0_sleep.tst
+TESTCASES += check_timerX_freq.tst
+TESTCASES += check_swi.tst
+TESTCASES += check_swirq.tst
+TESTCASES += check_swirq1.tst
+TESTCASES += check_swirq3.tst
+TESTCASES += check_mpyw.tst
+TESTCASES += check_subf.tst
+TESTCASES += check_prefetch.tst
+TESTCASES += check_mac.tst
+TESTCASES += check_ldaw_mmu.tst
+TESTCASES += check_manip_4_mmu.tst
+TESTCASES += check_manip_5_mmu.tst
+TESTCASES += check_manip_10_mmu.tst
+TESTCASES += check_manip_mmu.tst
+TESTCASES += check_rtie_user.tst
+TESTCASES += check_rtc.tst
+TESTCASES += check_mpu.tst
+TESTCASES += check_big_tb.tst
+TESTCASES += check_enter_leave.tst
+TESTCASES += check_bta.tst
+TESTCASES += check_vadd.tst
+TESTCASES += check_vsub.tst
+TESTCASES += check_mpyd.tst
+
+all: $(TESTCASES)
+OBJECTS = ivt.o
+
+%.o: $(SRC_PATH)/tests/tcg/arc/%.S
+	echo "Running: $(CC) $(ASFLAGS) -c $< -o $@ -I$(TST_PATH)"; \
+	$(CC) $(ASFLAGS) -c $< -o $@ -I$(TST_PATH)
+
+%_mmu.tst: %_mmu.o ${OBJECTS} $(SRC_PATH)/tests/tcg/arc/macros.inc $(SRC_PATH)/tests/tcg/arc/mmu.inc
+	echo "Running: $(LD) -T $(TST_PATH)/tarc_mmu.ld ${OBJECTS} $< -o $@"; \
+	$(LD) -T $(TST_PATH)/tarc_mmu.ld ${OBJECTS} $< -o $@
+
+%.tst: %.o ${OBJECTS} $(SRC_PATH)/tests/tcg/arc/macros.inc
+	echo "Running: $(LD) -T $(TST_PATH)/tarc.ld ${OBJECTS} $< -o $@"; \
+	$(LD) -T $(TST_PATH)/tarc.ld ${OBJECTS} $< -o $@
+
+%.ctst: $(SRC_PATH)/tests/tcg/arc/%.c
+	$(CC) $(CFLAGS) -Wl,-marcv2elfx -L $(SRC_PATH)/tests/tcg/arc/ $< -o $@
+
+check: $(TESTCASES)
+	@for case in $(TESTCASES); do \
+	echo $(SIM) $(SIM_FLAGS) ./$$case;\
+	$(SIM) $(SIM_FLAGS) ./$$case; \
+	done
+
+clean:
+	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/arc/Makefile.softmmu-target b/tests/tcg/arc/Makefile.softmmu-target
new file mode 100644
index 0000000000..ff3631b2ec
--- /dev/null
+++ b/tests/tcg/arc/Makefile.softmmu-target
@@ -0,0 +1,36 @@
+#
+# ARC softmmu tests
+#
+
+ARC_SRC = $(SRC_PATH)/tests/tcg/arc
+ARC_ALL = $(filter-out $(ARC_SRC)/ivt.S,$(wildcard $(ARC_SRC)/*.S))
+ARC_TESTS = $(patsubst $(ARC_SRC)/%.S, %, $(ARC_ALL))
+# Filter out common blobs and broken tests
+ARC_BROKEN_TESTS = ivt
+ARC_USABLE_TESTS = $(filter-out $(ARC_BROKEN_TESTS), $(ARC_TESTS))
+
+# add to the list of tests
+TESTS += $(ARC_USABLE_TESTS)
+VPATH += $(ARC_SRC)
+
+QEMU_OPTS+=-M arc-sim -m 3G -nographic -no-reboot -serial stdio -global cpu.mpu-numreg=8 -kernel
+
+#CROSS = arc-elf32-
+#
+#CC = $(CROSS)gcc
+#LD = $(CROSS)ld
+#AS = $(CROSS)as
+
+ASFLAGS = -mcpu=archs
+LDFLAGS = --specs=qemu.specs -T $(ARC_SRC)/tarc.ld -nostartfiles -nostdlib
+
+CRT = ivt.o
+
+$(ARC_USABLE_TESTS): $(CRT) Makefile.softmmu-target
+
+# special rule for common blobs
+%.o: %.S
+$(CC) -I$(ARC_SRC) $($*ASFLAGS) $(ASFLAGS) $(EXTRACFLAGS) -c $< -o $@
+
+%: %.S
+$(CC) -I$(ARC_SRC) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT)
diff --git a/tests/tcg/arc/Makefile.target b/tests/tcg/arc/Makefile.target
new file mode 100644
index 0000000000..abbf1a7b79
--- /dev/null
+++ b/tests/tcg/arc/Makefile.target
@@ -0,0 +1,101 @@
+# -*- Mode: makefile -*-
+#
+# ARC specific tweaks
+
+ARC_SRC=$(SRC_PATH)/tests/tcg/arc-softmmu
+VPATH+=$(ARC_SRC)
+
+ARC_TESTS = check_add.tst
+ARC_TESTS += check_lp.tst
+ARC_TESTS += check_lp02.tst
+ARC_TESTS += check_lp03.tst
+ARC_TESTS += check_lp04.tst
+ARC_TESTS += check_lp05.tst
+ARC_TESTS += check_lp06.tst
+ARC_TESTS += check_addx.tst
+ARC_TESTS += check_andx.tst
+ARC_TESTS += check_aslx.tst
+ARC_TESTS += check_asrx.tst
+ARC_TESTS += check_orx.tst
+ARC_TESTS += check_rolx.tst
+ARC_TESTS += check_rorx.tst
+ARC_TESTS += check_subx.tst
+ARC_TESTS += check_xorx.tst
+ARC_TESTS += check_beqx.tst
+ARC_TESTS += check_bnex.tst
+ARC_TESTS += check_brhsx.tst
+ARC_TESTS += check_brlox.tst
+ARC_TESTS += check_breqx.tst
+ARC_TESTS += check_brnex.tst
+ARC_TESTS += check_brltx.tst
+ARC_TESTS += check_brgex.tst
+ARC_TESTS += check_ldstx.tst
+ARC_TESTS += check_stld.tst
+ARC_TESTS += check_lsrx.tst
+ARC_TESTS += check_beq.tst
+ARC_TESTS += check_carry.tst
+ARC_TESTS += check_flags.tst
+ARC_TESTS += check_t01.tst
+ARC_TESTS += check_t02.tst
+ARC_TESTS += check_basic1.tst
+ARC_TESTS += check_basic2.tst
+ARC_TESTS += check_norm.tst
+ARC_TESTS += check_excp.tst
+ARC_TESTS += check_excp_1.ctst
+ARC_TESTS += check_mmu.tst
+ARC_TESTS += check_excp_mmu.tst
+ARC_TESTS += check_excp_jumpdl_mmu.tst
+ARC_TESTS += check_timer0.tst
+ARC_TESTS += check_timer0_loop.tst
+ARC_TESTS += check_timer0_loop3.tst
+ARC_TESTS += check_timer0_retrig.tst
+ARC_TESTS += check_timer0_sleep.tst
+ARC_TESTS += check_timerX_freq.tst
+ARC_TESTS += check_swi.tst
+ARC_TESTS += check_swirq.tst
+ARC_TESTS += check_swirq1.tst
+ARC_TESTS += check_swirq3.tst
+ARC_TESTS += check_mpyw.tst
+ARC_TESTS += check_subf.tst
+ARC_TESTS += check_prefetch.tst
+ARC_TESTS += check_mac.tst
+ARC_TESTS += check_ldaw_mmu.tst
+ARC_TESTS += check_manip_4_mmu.tst
+ARC_TESTS += check_manip_5_mmu.tst
+ARC_TESTS += check_manip_10_mmu.tst
+ARC_TESTS += check_manip_mmu.tst
+ARC_TESTS += check_rtie_user.tst
+ARC_TESTS += check_rtc.tst
+ARC_TESTS += check_mpu.tst
+ARC_TESTS += check_big_tb.tst
+ARC_TESTS += check_enter_leave.tst
+ARC_TESTS += check_bta.tst
+ARC_TESTS += check_vadd.tst
+ARC_TESTS += check_vsub.tst
+ARC_TESTS += check_mpyd.tst
+
+TESTS+=$(ARC_TESTS)
+
+%.o: $(ARC_SRC)/%.S
+	echo "Running: $(CC) $(ASFLAGS) -c $< -o $@ -I$(TST_PATH)"; \
+	$(CC) $(ASFLAGS) -c $< -o $@ -I$(TST_PATH)
+
+%_mmu.tst: %_mmu.o ${OBJECTS} $(ARC_SRC)/macros.inc $(ARC_SRC)/mmu.inc
+	echo "Running: $(LD) -T $(TST_PATH)/tarc_mmu.ld ${OBJECTS} $< -o $@"; \
+	$(LD) -T $(TST_PATH)/tarc_mmu.ld ${OBJECTS} $< -o $@
+
+%.tst: %.o ${OBJECTS} $(ARC_SRC)/macros.inc
+	echo "Running: $(LD) -T $(TST_PATH)/tarc.ld ${OBJECTS} $< -o $@"; \
+	$(LD) -T $(TST_PATH)/tarc.ld ${OBJECTS} $< -o $@
+
+%.ctst: $(ARC_SRC)/%.c
+	$(CC) $(CFLAGS) -Wl,-marcv2elfx -L $(ARC_SRC)/ $< -o $@
+
+#test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
+#test-cmov: test-cond.c
+#	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+#
+#run-test-cmov: test-cmov
+#
+## On Alpha Linux only supports 8k pages
+#EXTRA_RUNS+=run-test-mmap-8192
diff --git a/tests/tcg/arc/check_add.S b/tests/tcg/arc/check_add.S
new file mode 100644
index 0000000000..be400cf788
--- /dev/null
+++ b/tests/tcg/arc/check_add.S
@@ -0,0 +1,11 @@
+.include "macros.inc"
+
+	start
+
+	test_name ADD_1
+	mov	r2,0x10ff01ff
+	mov	r3,0x10010001
+	add	r2,r2,r3
+	check_r2	0x21000200
+
+	end
diff --git a/tests/tcg/arc/check_addx.S b/tests/tcg/arc/check_addx.S
new file mode 100644
index 0000000000..467679823f
--- /dev/null
+++ b/tests/tcg/arc/check_addx.S
@@ -0,0 +1,71 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# add.S
+#-----------------------------------------------------------------------------
+#
+# Test add instruction.
+#
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Arithmetic tests
+  #-------------------------------------------------------------
+
+  TEST_IMM_OP( 2,  add, 0x00000000, 0x00000000, 0x000 )
+  TEST_IMM_OP( 3,  add, 0x00000002, 0x00000001, 0x001 )
+  TEST_IMM_OP( 4,  add, 0x0000000a, 0x00000003, 0x007 )
+
+  TEST_IMM_OP( 5,  add, 0xfffffffffffff800, 0x0000000000000000, 0x800 )
+  TEST_IMM_OP( 6,  add, 0xffffffff80000000, 0xffffffff80000000, 0x000 )
+  TEST_IMM_OP( 7,  add, 0xffffffff7ffff800, 0xffffffff80000000, 0x800 )
+
+  TEST_IMM_OP( 8,  add, 0x00000000000007ff, 0x00000000, 0x7ff )
+  TEST_IMM_OP( 9,  add, 0x000000007fffffff, 0x7fffffff, 0x000 )
+  TEST_IMM_OP( 10, add, 0x00000000800007fe, 0x7fffffff, 0x7ff )
+
+  TEST_IMM_OP( 11, add, 0xffffffff800007ff, 0xffffffff80000000, 0x7ff )
+  TEST_IMM_OP( 12, add, 0x000000007ffff7ff, 0x000000007fffffff, 0x800 )
+
+  TEST_IMM_OP( 13, add, 0xffffffffffffffff, 0x0000000000000000, 0xfff )
+  TEST_IMM_OP( 14, add, 0x0000000000000000, 0xffffffffffffffff, 0x001 )
+  TEST_IMM_OP( 15, add, 0xfffffffffffffffe, 0xffffffffffffffff, 0xfff )
+
+  TEST_IMM_OP( 16, add, 0x0000000080000000, 0x7fffffff, 0x001 )
+
+  TEST_RR_3OP( 17,  add, 0x00000000, 0x00000000, 0x00000000 )
+  TEST_RR_3OP( 18,  add, 0x00000002, 0x00000001, 0x00000001 )
+  TEST_RR_3OP( 19,  add, 0x0000000a, 0x00000003, 0x00000007 )
+
+  TEST_RR_3OP( 20,  add, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 )
+  TEST_RR_3OP( 21,  add, 0xffffffff80000000, 0xffffffff80000000, 0x00000000 )
+  TEST_RR_3OP( 22,  add, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 )
+
+  TEST_RR_3OP( 23,  add, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff )
+  TEST_RR_3OP( 24,  add, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 )
+  TEST_RR_3OP( 25,  add, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff )
+
+  TEST_RR_3OP( 26,  add, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff )
+  TEST_RR_3OP( 27,  add, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 )
+
+  TEST_RR_3OP( 28,  add, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff )
+  TEST_RR_3OP( 29,  add, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 )
+  TEST_RR_3OP( 30,  add, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff )
+
+  TEST_RR_3OP( 31,  add, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff )
+
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+
+  TEST_IMM_SRC1_EQ_DEST( 32, add, 24, 13, 11 )
+
+  TEST_RR_SRC1_EQ_DEST( 33, add, 24, 13, 11 )
+  TEST_RR_SRC2_EQ_DEST( 34, add, 25, 14, 11 )
+  TEST_RR_SRC12_EQ_DEST( 35, add, 26, 13 )
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_andx.S b/tests/tcg/arc/check_andx.S
new file mode 100644
index 0000000000..efdec10ae3
--- /dev/null
+++ b/tests/tcg/arc/check_andx.S
@@ -0,0 +1,36 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# and.S
+#-----------------------------------------------------------------------------
+#
+# Test and instruction.
+#
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+
+  TEST_IMM_OP( 2, and, 0xff00ff00, 0xff00ff00, 0xf0f );
+  TEST_IMM_OP( 3, and, 0x000000f0, 0x0ff00ff0, 0x0f0 );
+  TEST_IMM_OP( 4, and, 0x0000000f, 0x00ff00ff, 0x70f );
+  TEST_IMM_OP( 5, and, 0x00000000, 0xf00ff00f, 0x0f0 );
+  TEST_RR_3OP( 6, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
+  TEST_RR_3OP( 7, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
+  TEST_RR_3OP( 8, and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
+  TEST_RR_3OP( 9, and, 0xf000f000, 0xf00ff00f, 0xf0f0f0f0 );
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+
+  TEST_IMM_SRC1_EQ_DEST( 10, and, 0x00000000, 0xff00ff00, 0x0f0 );
+  TEST_RR_SRC1_EQ_DEST( 11, and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
+  TEST_RR_SRC2_EQ_DEST( 12, and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
+  TEST_RR_SRC12_EQ_DEST( 13, and, 0xff00ff00, 0xff00ff00 );
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_aslx.S b/tests/tcg/arc/check_aslx.S
new file mode 100644
index 0000000000..77eb3c65cc
--- /dev/null
+++ b/tests/tcg/arc/check_aslx.S
@@ -0,0 +1,57 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# check_aslx.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+# .--------------.----------.--------------.
+# | instruction  | check CC | update flags |
+# |--------------+----------+--------------|
+# | asl          | no       | Z, N, C, V   |
+# | asl multiple | yes      | Z, N, C      |
+# `--------------^----------^--------------'
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+  TEST_RR_3OP(2, asl, 0x12345678, 0x12345678,  0);
+  TEST_RR_3OP(3, asl, 0x23456780, 0x12345678,  4);
+  TEST_RR_3OP(4, asl, 0x80000000, 0x12345671, 31);
+
+  TEST_RR_2OP(5, asl, 0x00000002, 0x00000001);
+  TEST_RR_2OP(6, asl, 0x00000000, 0x80000000);
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+  TEST_RR_SRC1_EQ_DEST    (7, asl,  0xf7780000, 0xdeedbeef, 0x00000013);
+  TEST_RR_2OP_SRC1_EQ_DEST(8, asl,  0x000804ca, 0x80040265);
+
+  #-------------------------------------------------------------
+  # Flag tests
+  #-------------------------------------------------------------
+  TEST_2OP_CARRY   ( 9, asl, 0, 0x10000000, 0x02);
+  TEST_2OP_CARRY   (10, asl, 1, 0x80000000, 0x01);
+  TEST_2OP_CARRY   (11, asl, 0, 0xffffffff, 0x00);
+  TEST_2OP_ZERO    (12, asl, 1, 0x12345670, 0xbf);
+  TEST_2OP_NEGATIVE(13, asl, 1, 0x1F345678, 0x04);
+  # no overflow flag update in "asl multiple"
+  TEST_2OP_OVERFLOW(14, asl, 0, 0x80000000, 0x01);
+
+  TEST_1OP_CARRY   (15, asl, 0, 0x40000000);
+  TEST_1OP_CARRY   (16, asl, 1, 0x80000000);
+  TEST_1OP_ZERO    (17, asl, 0, 0x00001000);
+  TEST_1OP_ZERO    (18, asl, 1, 0x80000000);
+  TEST_1OP_NEGATIVE(19, asl, 0, 0x20000000);
+  TEST_1OP_NEGATIVE(20, asl, 1, 0x40000000);
+  TEST_1OP_OVERFLOW(21, asl, 1, 0x80000000);
+  TEST_1OP_OVERFLOW(22, asl, 0, 0xffffffff);
+  TEST_1OP_OVERFLOW(23, asl, 1, 0x40000000);
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_asrx.S b/tests/tcg/arc/check_asrx.S
new file mode 100644
index 0000000000..6729f0c42b
--- /dev/null
+++ b/tests/tcg/arc/check_asrx.S
@@ -0,0 +1,86 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# check_asrx.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+# .--------------.----------.--------------.
+# | instruction  | check CC | update flags |
+# |--------------+----------+--------------|
+# | asr          | no       | Z, N, C      |
+# | asr multiple | yes      | Z, N, C      |
+# | asr8         | no       | Z, N         |
+# | asr16        | no       | Z, N         |
+# `--------------^----------^--------------'
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+  TEST_RR_3OP( 2, asr  , 0x12345678, 0x12345678,  0);
+  TEST_RR_3OP( 3, asr  , 0x01234567, 0x12345678,  4);
+  TEST_RR_3OP( 4, asr  , 0xFF234567, 0xF2345678,  4);
+  TEST_RR_3OP( 5, asr  , 0xffffffff, 0x8fffffff, 31);
+  TEST_RR_3OP( 6, asr  , 0x00000001, 0x7fffffff, 30);
+
+  TEST_RR_2OP( 7, asr  , 0x00000009, 0x00000012);
+  TEST_RR_2OP( 8, asr  , 0xc0000000, 0x80000000);
+  TEST_RR_2OP( 9, asr  , 0x20000000, 0x40000000);
+
+  TEST_RR_2OP(10, asr8 , 0x00000100, 0x00010000);
+  TEST_RR_2OP(11, asr8 , 0xffff0000, 0xff000000);
+  TEST_RR_2OP(12, asr8 , 0xff800000, 0x80000000);
+  TEST_RR_2OP(13, asr8 , 0x007f0000, 0x7f000000);
+  TEST_RR_2OP(14, asr8 , 0x00000000, 0x000000ff);
+
+  TEST_RR_2OP(15, asr16, 0x00000001, 0x00010000);
+  TEST_RR_2OP(16, asr16, 0xffffffff, 0xffff0000);
+  TEST_RR_2OP(17, asr16, 0xffff8000, 0x80000000);
+  TEST_RR_2OP(18, asr16, 0x00007fff, 0x7fff0000);
+  TEST_RR_2OP(19, asr16, 0x00000000, 0x0000ff00);
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+  TEST_RR_SRC1_EQ_DEST    (20, asr  ,  0xfffffbdd, 0xdeedbeef, 0x00000013);
+  TEST_RR_2OP_SRC1_EQ_DEST(21, asr  ,  0xc0020132, 0x80040265);
+  TEST_RR_2OP_SRC1_EQ_DEST(22, asr8 ,  0xff800402, 0x80040265);
+  TEST_RR_2OP_SRC1_EQ_DEST(23, asr16,  0xffff8004, 0x80040265);
+
+  #-------------------------------------------------------------
+  # Flag tests
+  #-------------------------------------------------------------
+  TEST_2OP_CARRY   (24, asr  , 0, 0x00000001, 0x02);
+  TEST_2OP_CARRY   (25, asr  , 1, 0x00000001, 0x01);
+  TEST_2OP_ZERO    (26, asr  , 0, 0x00000004, 0x02);
+  TEST_2OP_ZERO    (27, asr  , 1, 0x12345678, 0xbf);
+  TEST_2OP_NEGATIVE(28, asr  , 1, 0xFF345678, 0x04);
+  TEST_2OP_NEGATIVE(29, asr  , 0, 0x7F345678, 0x04);
+
+  TEST_1OP_CARRY   (30, asr  , 0, 0x00000002);
+  TEST_1OP_CARRY   (31, asr  , 1, 0x00000001);
+  TEST_1OP_ZERO    (32, asr  , 0, 0x00000002);
+  TEST_1OP_ZERO    (33, asr  , 1, 0x00000001);
+  TEST_1OP_NEGATIVE(34, asr  , 1, 0x80000000);
+  TEST_1OP_NEGATIVE(35, asr  , 0, 0x7fffffff);
+
+  TEST_1OP_CARRY   (36, asr8 , 0, 0x0000007f);
+  TEST_1OP_CARRY   (37, asr8 , 0, 0xffffffff);
+  TEST_1OP_ZERO    (38, asr8 , 0, 0x00000100);
+  TEST_1OP_ZERO    (39, asr8 , 1, 0x000000ff);
+  TEST_1OP_NEGATIVE(40, asr8 , 1, 0x80000000);
+  TEST_1OP_NEGATIVE(41, asr8 , 0, 0x7fffffff);
+
+  TEST_1OP_CARRY   (42, asr16, 0, 0x00007fff);
+  TEST_1OP_CARRY   (43, asr16, 0, 0xffffffff);
+  TEST_1OP_ZERO    (44, asr16, 0, 0x00010000);
+  TEST_1OP_ZERO    (45, asr16, 1, 0x0000ffff);
+  TEST_1OP_NEGATIVE(46, asr16, 1, 0x80000000);
+  TEST_1OP_NEGATIVE(47, asr16, 0, 0x7fffffff);
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_basic1.S b/tests/tcg/arc/check_basic1.S
new file mode 100644
index 0000000000..b26c548bc2
--- /dev/null
+++ b/tests/tcg/arc/check_basic1.S
@@ -0,0 +1,30 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# ror.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+  TEST_RR_3OP( 2, ror,  0xca000804, 0x000804ca, 0xfff80008);
+  TEST_RR_3OP( 3, add1, 0x00000096, 0x00000002, 0x0000004a);
+  TEST_RR_3OP( 4, add2, 0x0000025a, 0x00000002, 0x00000096);
+  TEST_RR_3OP( 5, asr,  0x000007da, 0x00000fb5, 0xfff00001);
+  TEST_RR_3OP( 6, bic,  0x01010101, 0x29292909, 0x2a2a2a0a);
+  TEST_RR_3OP( 7, rsub, 0x00000011, 0x50005134, 0x50005145);
+  TEST_RR_3OP( 8, sub1, 0xfffff720, 0x0000046e, 0x000006a7);
+  TEST_RR_3OP( 9, sub3, 0xfffff9e4, 0x000008ac, 0x000001d9);
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_basic2.S b/tests/tcg/arc/check_basic2.S
new file mode 100644
index 0000000000..31de81a2e4
--- /dev/null
+++ b/tests/tcg/arc/check_basic2.S
@@ -0,0 +1,26 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# ror.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+  TEST_RR_3OP( 2, bmsk, 0x010101FF, 0x010101FF, 0x800289bf);
+  TEST_RR_3OP( 3, bmsk, 0x00000001, 0x01010101, 0x89000007);
+  TEST_RR_3OP( 4, min,  0xffffff00, 0xffffff00, 0x000000ff);
+  TEST_RR_3OP( 5, lsr,  0x658403fd, 0xcb0807fb, 0x89000001);
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_beq.S b/tests/tcg/arc/check_beq.S
new file mode 100644
index 0000000000..841f4c6760
--- /dev/null
+++ b/tests/tcg/arc/check_beq.S
@@ -0,0 +1,14 @@
+.include "macros.inc"
+
+	start
+	test_name BEQ_1
+	mov.f	r2,0
+	beq	1f
+	check_r2 0x01
+1:
+	beq.d	2f
+	mov	r2,0x01
+	check_r2 0x00
+2:
+	check_r2 0x01
+	end
diff --git a/tests/tcg/arc/check_beqx.S b/tests/tcg/arc/check_beqx.S
new file mode 100644
index 0000000000..2c246da2ce
--- /dev/null
+++ b/tests/tcg/arc/check_beqx.S
@@ -0,0 +1,26 @@
+#*****************************************************************************
+# beq.S
+#-----------------------------------------------------------------------------
+#
+# Test beq instruction.
+#
+
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Branch tests
+  #-------------------------------------------------------------
+
+  # Each test checks both forward and backward branches
+
+  TEST_BR2_OP_TAKEN( 2, beq,  0,  0 );
+  TEST_BR2_OP_TAKEN( 3, beq,  1,  1 );
+  TEST_BR2_OP_TAKEN( 4, beq, -1, -1 );
+
+  TEST_BR2_OP_NOTTAKEN( 5, beq,  0,  1 );
+  TEST_BR2_OP_NOTTAKEN( 6, beq,  1,  0 );
+  TEST_BR2_OP_NOTTAKEN( 7, beq, -1,  1 );
+  TEST_BR2_OP_NOTTAKEN( 8, beq,  1, -1 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_big_tb.S b/tests/tcg/arc/check_big_tb.S
new file mode 100644
index 0000000000..1c22b811ae
--- /dev/null
+++ b/tests/tcg/arc/check_big_tb.S
@@ -0,0 +1,173 @@
+.equ   POWER_DEVICE,  0xF0000008      ; power management device
+
+.text
+.global main
+.align 4
+main:
+
+add3	r6,sp,0x38
+mov_s	r7,0x152f8
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x34
+mov_s	r7,0x152d8
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x30
+mov_s	r7,0x152b8
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x2c
+mov_s	r7,0x15298
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x28
+mov_s	r7,0x15278
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x24
+mov_s	r7,0x15258
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x20
+mov_s	r7,0x15238
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x1c
+mov_s	r7,0x15218
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x18
+mov_s	r7,0x151f8
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x14
+mov_s	r7,0x151d8
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x10
+mov_s	r7,0x151b8
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0xc
+mov_s	r7,0x15198
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add3	r6,sp,0x8
+mov_s	r7,0x15178
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+add	r6,sp,0x20
+mov_s	r7,0x15158
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+mov_s	r6,sp
+mov_s	r7,0x15138
+ldd	r4r5,[r7]
+ldd	r2r3,[r7,8]
+std	r4r5,[r6]
+ldd	r4r5,[r7,16]
+std	r2r3,[r6,8]
+ldd	r2r3,[r7,24]
+std	r4r5,[r6,16]
+std	r2r3,[r6,24]
+ld	r0,[0x15118]
+ld	r1,[0x1511c]
+ld	r2,[0x15120]
+ld	r3,[0x15124]
+ld	r4,[0x15128]
+ld	r5,[0x1512c]
+ld	r6,[0x15130]
+ld	r7,[0x15134]
+bl	@fin
+
+nop_s
+nop_s
+.align 4
+
+fin:
+st 1, [POWER_DEVICE]
diff --git a/tests/tcg/arc/check_bnex.S b/tests/tcg/arc/check_bnex.S
new file mode 100644
index 0000000000..4b7c0cfed9
--- /dev/null
+++ b/tests/tcg/arc/check_bnex.S
@@ -0,0 +1,26 @@
+#*****************************************************************************
+# bne.S
+#-----------------------------------------------------------------------------
+#
+# Test bne instruction.
+#
+
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Branch tests
+  #-------------------------------------------------------------
+
+  # Each test checks both forward and backward branches
+
+  TEST_BR2_OP_TAKEN( 2, bne,  0,  1 );
+  TEST_BR2_OP_TAKEN( 3, bne,  1,  0 );
+  TEST_BR2_OP_TAKEN( 4, bne, -1,  1 );
+  TEST_BR2_OP_TAKEN( 5, bne,  1, -1 );
+
+  TEST_BR2_OP_NOTTAKEN( 6, bne,  0,  0 );
+  TEST_BR2_OP_NOTTAKEN( 7, bne,  1,  1 );
+  TEST_BR2_OP_NOTTAKEN( 8, bne, -1, -1 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_breqx.S b/tests/tcg/arc/check_breqx.S
new file mode 100644
index 0000000000..a3a3dd1160
--- /dev/null
+++ b/tests/tcg/arc/check_breqx.S
@@ -0,0 +1,26 @@
+#*****************************************************************************
+# breq.S
+#-----------------------------------------------------------------------------
+#
+# Test breq instruction.
+#
+
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Branch tests
+  #-------------------------------------------------------------
+
+  # Each test checks both forward and backward branches
+
+  TEST_BR_OP_TAKEN( 2, breq,  0,  0 );
+  TEST_BR_OP_TAKEN( 3, breq,  1,  1 );
+  TEST_BR_OP_TAKEN( 4, breq, -1, -1 );
+
+  TEST_BR_OP_NOTTAKEN( 5, breq,  0,  1 );
+  TEST_BR_OP_NOTTAKEN( 6, breq,  1,  0 );
+  TEST_BR_OP_NOTTAKEN( 7, breq, -1,  1 );
+  TEST_BR_OP_NOTTAKEN( 8, breq,  1, -1 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_brgex.S b/tests/tcg/arc/check_brgex.S
new file mode 100644
index 0000000000..ddd6003b7c
--- /dev/null
+++ b/tests/tcg/arc/check_brgex.S
@@ -0,0 +1,26 @@
+#*****************************************************************************
+# brge.S
+#-----------------------------------------------------------------------------
+#
+# Test brge instruction.
+#
+
+#defirge ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Branch tests
+  #-------------------------------------------------------------
+
+  # Each test checks both forward and backward branches
+
+  TEST_BR_OP_NOTTAKEN( 2, brge,  0,  1 );
+  TEST_BR_OP_TAKEN( 3, brge,  1,  0 );
+  TEST_BR_OP_NOTTAKEN( 4, brge, -1,  1 );
+  TEST_BR_OP_TAKEN( 5, brge,  1, -1 );
+
+  TEST_BR_OP_TAKEN( 6, brge,  0,  0 );
+  TEST_BR_OP_TAKEN( 7, brge,  1,  1 );
+  TEST_BR_OP_TAKEN( 8, brge, -1, -1 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_brhsx.S b/tests/tcg/arc/check_brhsx.S
new file mode 100644
index 0000000000..6a05b53f8e
--- /dev/null
+++ b/tests/tcg/arc/check_brhsx.S
@@ -0,0 +1,27 @@
+#*****************************************************************************
+# brhs.S
+#-----------------------------------------------------------------------------
+#
+# Test brhs instruction.
+#
+
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Branch tests
+  #-------------------------------------------------------------
+
+  # Each test checks both forward and backward branches
+
+  TEST_BR_OP_TAKEN( 2, brhs,  0,  0 );
+  TEST_BR_OP_TAKEN( 3, brhs,  1,  1 );
+  TEST_BR_OP_TAKEN( 4, brhs, -1, -1 );
+  TEST_BR_OP_TAKEN( 5, brhs, -1,  1 );
+
+  TEST_BR_OP_NOTTAKEN( 6, brhs,  0,  1 );
+  TEST_BR_OP_NOTTAKEN( 7, brhs,  1, -1 );
+  TEST_BR_OP_NOTTAKEN( 8, brhs,  33, 0x2aaaaaab );
+  TEST_BR_OP_NOTTAKEN( 9, brhs,  123, 124 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_brlox.S b/tests/tcg/arc/check_brlox.S
new file mode 100644
index 0000000000..53a15b27d1
--- /dev/null
+++ b/tests/tcg/arc/check_brlox.S
@@ -0,0 +1,26 @@
+#*****************************************************************************
+# brlo.S
+#-----------------------------------------------------------------------------
+#
+# Test brlo instruction.
+#
+
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Branch tests
+  #-------------------------------------------------------------
+
+  # Each test checks both forward and backward branches
+
+  TEST_BR_OP_NOTTAKEN( 2, brlo,  0,  0 );
+  TEST_BR_OP_NOTTAKEN( 3, brlo,  1,  1 );
+  TEST_BR_OP_NOTTAKEN( 4, brlo, -1, -1 );
+  TEST_BR_OP_NOTTAKEN( 5, brlo, -1,  1 );
+
+  TEST_BR_OP_TAKEN( 6, brlo,  0,  1 );
+  TEST_BR_OP_TAKEN( 7, brlo,  1, -1 );
+  TEST_BR_OP_TAKEN( 8, brlo,  33, 0x2aaaaaab );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_brltx.S b/tests/tcg/arc/check_brltx.S
new file mode 100644
index 0000000000..475d3ddf1c
--- /dev/null
+++ b/tests/tcg/arc/check_brltx.S
@@ -0,0 +1,26 @@
+#*****************************************************************************
+# brlt.S
+#-----------------------------------------------------------------------------
+#
+# Test brlt instruction.
+#
+
+#defirlt ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Branch tests
+  #-------------------------------------------------------------
+
+  # Each test checks both forward and backward branches
+
+  TEST_BR_OP_TAKEN( 2, brlt,  0,  1 );
+  TEST_BR_OP_NOTTAKEN( 3, brlt,  1,  0 );
+  TEST_BR_OP_TAKEN( 4, brlt, -1,  1 );
+  TEST_BR_OP_NOTTAKEN( 5, brlt,  1, -1 );
+
+  TEST_BR_OP_NOTTAKEN( 6, brlt,  0,  0 );
+  TEST_BR_OP_NOTTAKEN( 7, brlt,  1,  1 );
+  TEST_BR_OP_NOTTAKEN( 8, brlt, -1, -1 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_brnex.S b/tests/tcg/arc/check_brnex.S
new file mode 100644
index 0000000000..6f37c33930
--- /dev/null
+++ b/tests/tcg/arc/check_brnex.S
@@ -0,0 +1,26 @@
+#*****************************************************************************
+# brne.S
+#-----------------------------------------------------------------------------
+#
+# Test brne instruction.
+#
+
+#defirne ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Branch tests
+  #-------------------------------------------------------------
+
+  # Each test checks both forward and backward branches
+
+  TEST_BR_OP_TAKEN( 2, brne,  0,  1 );
+  TEST_BR_OP_TAKEN( 3, brne,  1,  0 );
+  TEST_BR_OP_TAKEN( 4, brne, -1,  1 );
+  TEST_BR_OP_TAKEN( 5, brne,  1, -1 );
+
+  TEST_BR_OP_NOTTAKEN( 6, brne,  0,  0 );
+  TEST_BR_OP_NOTTAKEN( 7, brne,  1,  1 );
+  TEST_BR_OP_NOTTAKEN( 8, brne, -1, -1 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_bta.S b/tests/tcg/arc/check_bta.S
new file mode 100644
index 0000000000..abef1a33fc
--- /dev/null
+++ b/tests/tcg/arc/check_bta.S
@@ -0,0 +1,294 @@
+; check_bta.S
+; Tests for setting Branch Target Address register.
+; The BTA register is updated if and only if the
+; branch is going to be taken (cc = true) AND there
+; is a delay slot:
+;                 ,-----------.-----------.
+;                 | not taken |   taken   |
+; ,---------------|-----------+-----------|
+; | no delay slot |     -     |     -     |
+; |---------------|-----------+-----------|
+; |    delay slot |     -     |  UPDATE   |
+; `---------------^-----------^-----------'
+; In other words, BTA is updated only when STATUS32.DE is set.
+;
+; TODO: Add test cases for Bcc, JL, JLcc, BBITn
+; TODO: the following test cases fail in QEMU: 3, 9
+;       the condition of the tests are (not taken, delay slot)
+;       and yet QEMU insists on updating the BTA.
+
+  .include "macros.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;; Test checking routines ;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+.data
+; Test case counter
+test_nr:
+  .word 0x0
+; Saved BTA
+saved_bta:
+  .word 0x0
+
+; Increment the test counter
+.macro prep_test_case
+  ld    r13, [test_nr]
+  add_s r13, r13, 1       ; Increase test case counter
+  st    r13, [test_nr]
+  lr    r13, [bta]
+  st    r13, [saved_bta]  ; Some tests need this to check if BTA changed.
+.endm
+
+; Compares the current BTA with the value saved at the start of a
+; test by PREP_TEST_CASE. If not the same, the test will fail.
+.macro check_bta_remained_intact
+  ld    r13, [saved_bta]
+  lr    r12, [bta]
+  cmp   r13, r12
+  bne   @fail
+.endm
+
+; Checks the BTA against the EXPECTED_BTA.
+; If they're not the same, the test will fail.
+.macro check_bta    expected_bta
+  mov   r13, \expected_bta
+  lr    r12, [bta]
+  cmp   r13, r12
+  bne   @fail
+.endm
+
+; Checks if the given REGs are equal. Fails, if not.
+.macro check_equal  reg, expected_reg
+  cmp   \expected_reg, \reg
+  bne   @fail
+.endm
+
+; Checks if REG is one number bigger than ORIG_REG.
+.macro check_one_above    reg, orig_reg
+  mov   r13, \orig_reg
+  add_s r13, r13, 1
+  cmp   r13, \reg
+  bne   @fail
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Conditonal branches ;;;;;;;;;;;;;;;;;;;;;;;;;
+
+start
+
+; Test case 1
+; Conditional branch is not taken and there is no delay slot.
+; BTA mustn't be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  add    r1, r0, 1
+  breq   r0, r1, @test_01_target
+  check_bta_remained_intact
+  b      @test_01_end
+test_01_target:
+  b      @fail
+test_01_end:
+  ; Fall through
+
+; Test case 2
+; Conditional branch is taken but there is no delay slot.
+; BTA mustn't be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  mov    r1, r0
+  breq   r0, r1, @test_02_target
+  b      @fail
+test_02_target:
+  check_bta_remained_intact
+
+; Test case 3
+; Conditional branch is not taken but there is a delay slot.
+; BTA mustn't be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  add    r1, r0, 1
+  breq.d r0, r1, @test_03_target
+  add_s  r0, r0, 1
+  check_bta_remained_intact
+  check_equal r0, r1
+  b      @test_03_end
+test_03_target:
+  b      @fail
+test_03_end:
+  ; Fall through
+
+; Test case 4
+; Conditional branch is taken AND there is a delay slot.
+; BTA must be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  mov    r1, r0
+  breq.d r0, r1, @test_04_target
+  add_s  r0, r0, 1
+  b      @fail
+test_04_target:
+  check_bta   @test_04_target
+  check_one_above r0, r1
+
+;;;;;;;;;;;;;;;;;;;;;;;; Unconditonal branches ;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 5
+; Branch unconditionally but there is no delay slot.
+; BTA mustn't be updated.
+  prep_test_case
+  b      @test_05_target
+  b      @fail
+test_05_target:
+  check_bta_remained_intact
+
+; Test case 6
+; Branch unconditionally AND there is a delay slot.
+; BTA must be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  mov    r1, r0
+  b.d    @test_06_target
+  add_s  r0, r0, 1
+  b      @fail
+test_06_target:
+  check_bta   @test_06_target
+  check_one_above r0, r1
+
+;;;;;;;;;;;;;;;;;;;;;;;;;; Conditonal jumps ;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 7
+; Conditional jump is not taken and there is no delay slot.
+; BTA mustn't be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  add    r1, r0, 1
+  cmp    r0, r1
+  jz     @test_07_target
+  check_bta_remained_intact
+  b      @test_07_end
+test_07_target:
+  b      @fail
+test_07_end:
+  ; Fall through
+
+; Test case 8
+; Conditional jump is taken but there is no delay slot.
+; BTA mustn't be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  mov    r1, r0
+  cmp    r0, r1
+  jz     @test_08_target
+  add_s  r0, r0, 1
+
+  b      @fail
+test_08_target:
+  check_bta_remained_intact
+
+; Test case 9
+; Conditional jump is not taken but there is a delay slot.
+; BTA mustn't be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  add    r1, r0, 1
+  mov    r2, @test_09_target
+  cmp    r0, r1
+  jz.d   [r2]
+  add_s  r0, r0, 1
+  check_bta_remained_intact
+  check_equal r0, r1
+  b      @test_09_end
+test_09_target:
+  b      @fail
+test_09_end:
+  ; Fall through
+
+; Test case 10
+; Conditional jump is taken AND there is a delay slot.
+; BTA must be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  mov    r1, r0
+  mov    r2, @test_10_target
+  cmp    r0, r1
+  jz.d   [r2]
+  add_s  r0, r0, 1
+  b      @fail
+test_10_target:
+  check_bta   @test_10_target
+  check_one_above r0, r1
+
+;;;;;;;;;;;;;;;;;;;;;;; Conditonal short jumps ;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 11
+; Conditional short jump is not taken (there can't be a delay slot).
+; BTA mustn't be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  add    r1, r0, 1
+  mov    blink, @test_11_target
+  cmp    r0, r1
+  jeq_s  [blink]
+  check_bta_remained_intact
+  check_one_above r1, r0
+  b      @test_11_end
+test_11_target:
+  b      @fail
+test_11_end:
+  ; Fall through
+
+; Test case 12
+; Conditional short jump is taken (there can't be a delay slot).
+; BTA mustn't be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  add    r1, r0, 1
+  mov    blink, @test_12_target
+  cmp    r0, r1
+  jne_s  [blink]
+  add_s  r0, r0, 1
+  b      @fail
+test_12_target:
+  check_bta_remained_intact
+  check_one_above r1, r0
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Unconditonal jumps ;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 13
+; Jump unconditionally but there is no delay slot.
+; BTA mustn't be updated.
+  prep_test_case
+  j      @test_13_target
+  b      @fail
+test_13_target:
+  check_bta_remained_intact
+
+; Test case 14
+; Jump unconditionally AND there is a delay slot.
+; BTA must be updated.
+  prep_test_case
+  ld     r0, [test_nr]
+  mov    r1, r0
+  mov    r2, @test_14_target
+  j.d    [r2]
+  add_s  r0, r0, 1
+  b      @fail
+test_14_target:
+  check_bta   @test_14_target
+  check_one_above r0, r1
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [test_nr]
+  ;print_number r0
+  print "[FAIL]"
+1:
+  print " BTA register (implicit) writing\n"
+  end
diff --git a/tests/tcg/arc/check_carry.S b/tests/tcg/arc/check_carry.S
new file mode 100644
index 0000000000..5928897911
--- /dev/null
+++ b/tests/tcg/arc/check_carry.S
@@ -0,0 +1,15 @@
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+	ARCTEST_BEGIN
+
+test_2:
+	mov	r0, 10
+	mov	r1, 12
+	cmp	r0,r1		;Carry is set here
+	mov.lo.f	0, 0x0
+	mov.hs.f	0, 0x1
+
+	bne	@fail
+
+	ARCTEST_END
diff --git a/tests/tcg/arc/check_enter_leave.S b/tests/tcg/arc/check_enter_leave.S
new file mode 100644
index 0000000000..9bb8180b29
--- /dev/null
+++ b/tests/tcg/arc/check_enter_leave.S
@@ -0,0 +1,715 @@
+;; These are the tests cases for verifying the functionality of
+;; enter_s and leave_s. It is assumed that there are 32 general
+;; purpose registers available (r0 ... r31). It is also good to
+;; remark the aliases for some of the registers:
+;; r27: fp
+;; r28: sp
+;; r31: blink
+
+  .include "macros.inc"
+
+;;;;;;;;;;;;;;;;;;; / Exception Verification Helpers \ ;;;;;;;;;;;;;;;;;;;;;;
+; these are the parameters that the exception routine uses as reference
+  .data
+  .align 4
+ecr_ref    : .word 0x0
+eret_ref   : .word 0x0
+efa_ref    : .word 0x0
+erbta_ref  : .word 0x0
+cont_addr  : .word 0x0
+test_number: .word 0x0
+  .text
+  .align 4
+
+; macro:      set_excep_params
+; regs used:  r11
+;
+; this macro writes the provided parameters to a temporary place holder
+; that later will be used by ProtV exception above to verify as reference
+.macro set_excep_params ecr, eret, efa, erbta, continue, test_num
+  mov  r11, \ecr
+  st   r11, [ecr_ref]
+  mov  r11, \efa
+  st   r11, [efa_ref]
+  mov  r11, \eret
+  st   r11, [eret_ref]
+  mov  r11, \erbta
+  st   r11, [erbta_ref]
+  mov  r11, \continue
+  st   r11, [cont_addr]
+  mov  r11, \test_num
+  st   r11, [test_number]
+.endm
+
+; exception verification routine
+; regs used: r11, r12
+;
+; this is a parameterized exception that will check the followings:
+; ecr   == ecr_ref
+; efa   == efa_ref
+; eret  == eret_ref
+; if everything passes, it will jump to 'cont_addr' parameter. it will clear
+; the user bit before the jump, ie if an exception  is  raised in user mode,
+; the continuation after exception will be in kernel mode.
+; the parameters must be set beforehand using 'set_except_params' macro.
+; last but not least, this requires ivt.S file to be compiled and linked.
+  .align 4
+  .global instruction_error
+  .global EV_Misaligned
+  .type instruction_error, @function
+  .type EV_Misaligned, @function
+instruction_error:
+EV_Misaligned:
+  ld   r11, [ecr_ref]
+  lr   r12, [ecr]
+  brne r12, r11, @exc_fail
+  ld   r11, [eret_ref]
+  lr   r12, [eret]
+  brne r12, r11, @exc_fail
+  ld   r11, [efa_ref]
+  lr   r12, [efa]
+  brne r12, r11, @exc_fail
+  ld   r11, [erbta_ref]
+  lr   r12, [erbta]
+  brne r12, r11, @exc_fail
+  ; do not pursue the branch target anymore
+  lr   r11, [erstatus]
+  and  r11, r11, ~0x8040    ; clear ES and DE bit
+  sr   r11, [erstatus]
+  ; going back to given address
+  ld   r11, [cont_addr]
+  sr   r11, [eret]
+  rtie
+exc_fail:
+  ld   r11, [test_number]
+  print_number r11
+  print "[FAIL] :exception is not sane:"
+  b @endtest
+;;;;;;;;;;;;;;;;;;; \ Exception Verification Helpers / ;;;;;;;;;;;;;;;;;;;;;;
+
+  start
+  mov     sp , 0x1000     ; let's set sp to 0x100 for all the tests
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; u6=0 leads to doing nothing
+test00:
+  mov     r10, sp
+  enter_s 0                ; enter_s []
+  brne    sp, r10, @test00_fail
+  j       @test01
+
+test00_fail:
+  print "[FAIL] :test00:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; saving first 3 general purpose registers
+test01:
+  mov     r10, sp       ; ,-- top ---.
+  mov     r13, 13       ; | r13 = 13 |
+  mov     r14, 14       ; | r14 = 14 |
+  mov     r15, 15       ; | r15 = 15 |
+  enter_s [r13-r15]     ; `- bottom -'
+  pop     r3
+  pop     r4
+  pop     r5
+  brne    r3,  13, @test01_fail
+  brne    r4,  14, @test01_fail
+  brne    r5,  15, @test01_fail
+  brne    sp, r10, @test01_fail
+  j       @test02
+
+test01_fail:
+  print "[FAIL] :test01:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; saving blink register
+test02:
+  mov     r10, sp
+  mov     blink, 0x123
+  enter_s [blink]
+  pop     r1
+  brne    r1, 0x123, @test02_fail
+  brne    sp,   r10, @test02_fail
+  j       @test03
+
+test02_fail:
+  print "[FAIL] :test02:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; saving fp register
+test03:
+  mov     r10, sp
+  mov     fp, 0x321
+
+  enter_s [fp]
+  mov     r9, sp     ; save current sp before poping
+  pop     r1
+  brne    r1, 0x321, @test03_fail
+  brne    fp,    r9, @test03_fail
+  brne    sp,   r10, @test03_fail
+  j       @test04
+
+test03_fail:
+  print "[FAIL] :test03:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; saving all registers
+  .data
+  .align 4
+sp_orig: .word 0x0
+  .text
+test04:
+  st      sp   , [sp_orig]          ; ,----- top -----.
+  mov     blink, 0x456              ; | blink = 0x456 |
+  mov     r13  , 13                 ; | r13   = 13    |
+  mov     r14  , 14                 ; | r14   = 14    |
+  mov     r15  , 15                 ; | r15   = 15    |
+  mov     r16  , 16                 ; | r16   = 16    |
+  mov     r17  , 17                 ; | r17   = 17    |
+  mov     r18  , 18                 ; | r18   = 18    |
+  mov     r19  , 19                 ; | r19   = 19    |
+  mov     r20  , 20                 ; | r20   = 20    |
+  mov     r21  , 21                 ; | r21   = 21    |
+  mov     r22  , 22                 ; | r22   = 22    |
+  mov     r23  , 23                 ; | r23   = 23    |
+  mov     r24  , 24                 ; | r24   = 24    |
+  mov     r25  , 25                 ; | r25   = 25    |
+  mov     r26  , 26                 ; | r26   = 26    |
+  mov     fp   , 0x789              ; | fp    = 0x789 |
+  enter_s [r13-r26, fp, blink]      ; `--- bottom ----'
+  mov     r0, sp                    ; save current sp before poping
+  pop     r1                        ; blink
+  pop     r3                        ; r13
+  pop     r4                        ; r14
+  pop     r5                        ; r15
+  pop     r6                        ; r16
+  pop     r7                        ; r17
+  pop     r8                        ; r18
+  pop     r9                        ; r19
+  pop     r10                       ; r20
+  pop     r11                       ; r21
+  pop     r12                       ; r22
+  pop     r13                       ; r23
+  pop     r14                       ; r24
+  pop     r15                       ; r25
+  pop     r16                       ; r26
+  pop     r2                        ; fp
+  brne    fp,    r0, @test04_fail   ; sp value before all the pops
+  brne    r1, 0x456, @test04_fail   ; blink value during save
+  brne    r2, 0x789, @test04_fail   ; frame pointer value during save
+  brne    r3,    13, @test04_fail   ; stored r13 value
+  brne    r4,    14, @test04_fail   ; stored r14 value
+  brne    r5,    15, @test04_fail   ; stored r15 value
+  brne    r6,    16, @test04_fail   ; stored r16 value
+  brne    r7,    17, @test04_fail   ; stored r17 value
+  brne    r8,    18, @test04_fail   ; stored r18 value
+  brne    r9,    19, @test04_fail   ; stored r19 value
+  brne    r10,   20, @test04_fail   ; stored r20 value
+  brne    r11,   21, @test04_fail   ; stored r21 value
+  brne    r12,   22, @test04_fail   ; stored r22 value
+  brne    r13,   23, @test04_fail   ; stored r23 value
+  brne    r14,   24, @test04_fail   ; stored r24 value
+  brne    r15,   25, @test04_fail   ; stored r25 value
+  brne    r16,   26, @test04_fail   ; stored r26 value
+  ld      r10, [sp_orig]            ; original sp value spilled
+  brne    sp,   r10, @test04_fail   ; original sp value
+  j       @test05
+
+test04_fail:
+  print "[FAIL] :test04:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; sp's value is not 32-bit aligned --> misaligned exception
+; this happens irrelevant of status32.AD bit
+test05:
+  .equ  TEST05_SP        , 0x111  ; an address which is not 32-bit aligned
+  .equ  TEST05_STACK_SIZE, 60     ; saving r13-r26 (14x4) + fp (4)
+  .equ  TEST05_EFA       , TEST05_SP - TEST05_STACK_SIZE
+  lr      r1, [status32]
+  or      r1, r1, 0x80000         ; set AD bit
+  mov     r2, @test05_excep_prep
+  sr      r1, [erstatus]          ; enable AD bit
+  sr      r2, [eret]              ; continue with the test
+  rtie
+
+test05_excep_prep:
+  lr      r7, [erbta]             ; don't care for erbta
+  set_excep_params ecr=MISALIGNED_DATA_ACCESS, \
+                   eret=@test05_enter        , \
+                   efa=TEST05_EFA            , \
+                   erbta=r7                  , \
+                   continue=@test05_wrapup   , \
+                   test_num=5
+  mov     r10, sp                 ; backup sp to restore later
+  mov     sp, TEST05_SP           ; an address which is not 32-bit aligned
+test05_enter:
+  enter_s [r13-r26, fp]           ; just being flamboyant
+  print "[FAIL] :test05:"        ; this code must not fall through
+  b @endtest
+
+test05_wrapup:
+  mov     sp, r10
+  lr      r1, [status32]
+  and     r1, r1, ~0x80000        ; clear AD bit
+  mov     r2, @test06             ; go to next test
+  sr      r1, [erstatus]          ; disable AD bit
+  sr      r2, [eret]              ; continue with next test
+  rtie
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; a delay slot instruction --> illegal instruction sequence exception
+; the tricky thing in this test is that gas does not allow us to put
+; an "enter_s" in a delay slot (good job there!). however, we work
+; around it by writing the opcode at runtime.
+test06:
+  set_excep_params ecr=ILLEGAL_INSTRUCTION_SEQUENCE, \
+                   eret=@test06_delay              , \
+                   efa=@test06_delay               , \
+                   erbta=@test06_fail              , \
+                   continue=@test07                , \
+                   test_num=6
+  mov     r1, 0xc0e2          ; opcode for enter_s [r13]
+  sth     r1, [test06_delay]
+  b       @test06_dummy_tb    ; by having 'b' here, it is end of this tb.
+test06_dummy_tb:              ; so this one will be decoded after mutation.
+  b.d     @test06_fail
+test06_delay:
+  nop_s
+  nop_s
+
+test06_fail:
+  print "[FAIL] :test06:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; an execution slot instruction --> illegal instruction sequence exception
+; TODO (issue #73): enable this after EI_S has been implemented.
+test07:
+;  mov     r1, @test07_ei_table
+;  sr      r1, [ei_base]
+;  j       @test07_begin
+;
+;  .align 4
+;test07_ei_table:
+;  enter_s [r13]
+;
+;test07_begin:
+;  set_excep_params ecr=ILLEGAL_INSTRUCTION_SEQUENCE, \
+;                   eret=@test07_ei_table           , \
+;                   efa=@test07_ei_table            , \
+;                   erbta=@test07_fail              , \
+;                   continue=@test08                , \
+;                   test_num=7
+;  ei_s    0
+;
+;test07_fail:
+;  print "failed: test07\n"
+;  end
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; it is allowed to have "enter_s 0" in delay/execution slot because it is
+; like a nop then and is not a multi-cycle instruction.
+; TODO (issue #73): enable the ei_check part after EI_S has been done.
+test08:
+  mov     r1, 0xc0e0          ; opcode for enter_s []
+  sth     r1, [test08_delay]
+  b       @test08_dummy_tb    ; by having 'b' here, it is end of this tb.
+test08_dummy_tb:              ; so this one will be decoded after mutation.
+  b.d     @test08_ei_check
+test08_delay:
+  nop_s                       ; at runtime this is enter_s [] and is ok
+  nop_s
+
+  .align 4
+test08_ei_table:
+  enter_s 0
+
+test08_ei_check:
+  ; TODO (issue #73): enable after EI_S is implemented.
+  ;mov     r1, @test08_ei_table
+  ;sr      r1, [ei_base]
+  ;ei_s    0
+  ; fall through to the next test
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; 32 general registers configured AND u[3:0] > 14 (r13-r26)
+;                           OR
+; 16 general registers configured AND u[3:0] > 3 (r13-r15)
+; --> illegal instruction exception
+; TODO (issue #52): this test case must be executed with
+;                   -global cpu.num-regs=16.
+test09:
+;  lr      r7, [bta]               ; don't care for erbta (use current bta)
+;  set_excep_params ecr=ILLEGAL_INSTRUCTION, \
+;                   eret=@test09_big_u3    , \
+;                   efa=@test09_big_u3     , \
+;                   erbta=r7               , \
+;                   continue=@test10       , \
+;                   test_num=9
+;test09_big_u3:      ; enter_s encoding : 1100 00UU 111u uuu0
+;  enter_s 4
+;
+;test09_fail:
+;  print "failed: test09\n"
+;  end
+;;;;;;;;;;;;;;;;;;;;;;;;;;;; \ Enter Tests / ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;; / Leave Tests \ ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; u7=0 leads to doing nothing
+test10:
+  mov     r10, sp
+  leave_s 0
+  brne    sp,  r10, @test10_fail
+  j       @test11
+
+test10_fail:
+  print "[FAIL] :test10:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; restoring first 3 general purpose registers
+test11:
+  mov     r10, sp       ; ,--- top ---.
+  mov     r3, 113       ; | r13 = 113 |
+  mov     r4, 114       ; | r14 = 114 |
+  mov     r5, 115       ; | r15 = 115 |
+  push    r5            ; `-- bottom -'
+  push    r4
+  push    r3
+  leave_s [r13-r15]
+  brne    r13, 113, @test11_fail
+  brne    r14, 114, @test11_fail
+  brne    r15, 115, @test11_fail
+  brne    sp , r10, @test11_fail
+  j       @test12
+
+test11_fail:
+  print "[FAIL] :test11:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; restoring blink register
+test12:
+  mov     r10, sp
+  mov     r1, 0x10123
+  push    r1
+  leave_s [blink]
+  brne    blink, 0x10123, @test12_fail
+  brne    sp   ,     r10, @test12_fail
+  j       @test13
+
+test12_fail:
+  print "[FAIL] :test12:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; restoring fp register
+test13:
+  mov     r10, sp
+  mov     r1, 0x11321
+  push    r1
+  mov     fp, sp            ; fp is pointing current frame now
+  mov     sp, 0x4009        ; botch sp
+  leave_s [fp]              ; 'leave_s' must look into fp for restoring
+  brne    fp, 0x11321, @test13_fail
+  brne    sp,     r10, @test13_fail
+  j       @test14
+
+test13_fail:
+  print "[FAIL] :test13"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; jumping to what blink holds
+test14:
+  mov     r10, sp
+  mov     blink, @test14_cont
+  leave_s [pcl]                     ; jump to whatever blink points to
+  j       @test14_fail              ; this should not be reached
+test14_cont:
+  brne    sp, r10, @test14_fail
+  j       @test15
+
+test14_fail:
+  print "[FAIL] :test14:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; restoring first 3 general purpose registers
+test15:
+  mov     r0 , sp                   ; ,--------- top ----------.
+  mov     r1 , @test15_return       ; | blink = @test15_return |
+  mov     r3 , 213                  ; | r3    = 213            |
+  mov     r4 , 214                  ; | r4    = 214            |
+  mov     r5 , 215                  ; | r5    = 215            |
+  mov     r6 , 216                  ; | r6    = 216            |
+  mov     r7 , 217                  ; | r7    = 217            |
+  mov     r8 , 218                  ; | r8    = 218            |
+  mov     r9 , 219                  ; | r9    = 219            |
+  mov     r10, 220                  ; | r10   = 220            |
+  mov     r11, 221                  ; | r11   = 221            |
+  mov     r12, 222                  ; | r12   = 222            |
+  mov     r13, 223                  ; | r13   = 223            |
+  mov     r14, 224                  ; | r14   = 224            |
+  mov     r15, 225                  ; | r15   = 225            |
+  mov     r16, 226                  ; | r16   = 226            |
+  mov     r2, 0x14456               ; | fp    = 0x14456        |
+  push    r2                        ; `-------- bottom --------'
+  push    r16
+  push    r15
+  push    r14
+  push    r13
+  push    r12
+  push    r11
+  push    r10
+  push    r9
+  push    r8
+  push    r7
+  push    r6
+  push    r5
+  push    r4
+  push    r3
+  push    r1
+  mov     fp, sp
+  mov     sp, 0x1337                ; both sp again
+  leave_s [r13-r26, fp, blink, pcl] ; restore and do everything
+  j       @test15_fail
+test15_return:
+  brne    sp   ,             r0, @test15_fail
+  brne    blink, @test15_return, @test15_fail
+  brne    r13  ,            213, @test15_fail
+  brne    r14  ,            214, @test15_fail
+  brne    r15  ,            215, @test15_fail
+  brne    r16  ,            216, @test15_fail
+  brne    r17  ,            217, @test15_fail
+  brne    r18  ,            218, @test15_fail
+  brne    r19  ,            219, @test15_fail
+  brne    r20  ,            220, @test15_fail
+  brne    r21  ,            221, @test15_fail
+  brne    r22  ,            222, @test15_fail
+  brne    r23  ,            223, @test15_fail
+  brne    r24  ,            224, @test15_fail
+  brne    r25  ,            225, @test15_fail
+  brne    r26  ,            226, @test15_fail
+  brne    fp   ,        0x14456, @test15_fail
+  j       @test16
+
+test15_fail:
+  print "[FAIL] :test15:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; sp's value is not 32-bit aligned --> misaligned exception
+; this happens irrelevant of status32.AD bit
+test16:
+  .equ  TEST16_FP, 0x777  ; an address which is not 32-bit aligned
+  lr      r1, [status32]
+  or      r1, r1, 0x80000         ; set AD bit
+  mov     r2, @test16_excep_prep
+  sr      r1, [erstatus]          ; enable AD bit
+  sr      r2, [eret]              ; continue with the test
+  rtie
+
+test16_excep_prep:
+  lr      r7, [erbta]             ; don't care for erbta
+  set_excep_params ecr=MISALIGNED_DATA_ACCESS, \
+                   eret=@test16_enter        , \
+                   efa=TEST16_FP             , \
+                   erbta=r7                  , \
+                   continue=@test16_wrapup   , \
+                   test_num=16
+  mov     r10, sp                 ; backup sp to restore later
+  mov     fp, TEST16_FP           ; an address which is not 32-bit aligned
+test16_enter:
+  leave_s [r13-r26, fp]           ; first fp's value is put into sp
+  print "[FAIL] :test16:"        ; this code must not fall through
+  b @endtest
+
+test16_wrapup:
+  mov     sp, r10
+  lr      r1, [status32]
+  and     r1, r1, ~0x80000        ; clear AD bit
+  mov     r2, @test17             ; go to next test
+  sr      r1, [erstatus]          ; disable AD bit
+  sr      r2, [eret]              ; continue with next test
+  rtie
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; a delay slot instruction --> illegal instruction sequence exception
+; the tricky thing in this test is that gas does not allow us to put
+; an "leave_s" in a delay slot (good job there!). however, we work
+; around it by writing the opcode at runtime.
+test17:
+  set_excep_params ecr=ILLEGAL_INSTRUCTION_SEQUENCE, \
+                   eret=@test17_delay              , \
+                   efa=@test17_delay               , \
+                   erbta=@test17_fail              , \
+                   continue=@test18                , \
+                   test_num=17
+  mov     r1, 0xc0c2          ; opcode for leave_s [13]
+  sth     r1, [test17_delay]
+  b       @test17_dummy_tb    ; by having 'b' here, it is end of this tb.
+test17_dummy_tb:              ; so this one will be decoded after mutation.
+  b.d     @test17_fail
+test17_delay:
+  nop_s
+  nop_s
+
+test17_fail:
+  print "[FAIL] :test17:"
+  b @endtest
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; an execution slot instruction --> illegal instruction sequence exception
+; TODO (issue #73): enable this after EI_S has been implemented.
+test18:
+;  mov     r1, @test18_ei_table
+;  sr      r1, [ei_base]
+;  j       @test18_begin
+;
+;  .align 4
+;test18_ei_table:
+;  leave_s [r13]
+;
+;test18_begin:
+;  set_excep_params ecr=ILLEGAL_INSTRUCTION_SEQUENCE, \
+;                   eret=@test18_ei_table           , \
+;                   efa=@test18_ei_table            , \
+;                   erbta=@test18_fail              , \
+;                   continue=@test19                , \
+;                   test_num=18
+;  ei_s    0
+;
+;test18_fail:
+;  print "[FAIL] : test18\n"
+;  end
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; it is allowed to have "leave_s 0" in delay/execution slot because it is
+; like a nop then and is not a multi-cycle instruction.
+; TODO (issue #73): enable the ei_check part after EI_S has been done.
+test19:
+  mov     r1, 0xc0c0          ; opcode for leave_s []
+  sth     r1, [test19_delay]
+  b       @test19_dummy_tb    ; by having 'b' here, it is end of this tb.
+test19_dummy_tb:              ; so this one will be decoded after mutation.
+  b.d     @test19_ei_check
+test19_delay:
+  nop_s                       ; at runtime this is leave_s [] and is ok
+  nop_s
+
+  .align 4
+test19_ei_table:
+  leave_s 0
+
+test19_ei_check:
+  ; TODO (issue #73): enable after EI_S is implemented.
+  ;mov     r1, @test19_ei_table
+  ;sr      r1, [ei_base]
+  ;ei_s    0
+  ; fall through to the next test
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; 32 general registers configured AND u[3:0] > 14 (r13-r26)
+;                           OR
+; 16 general registers configured AND u[3:0] > 3 (r13-r15)
+; --> illegal instruction exception
+; TODO (issue #52): this test case must be executed with
+;                   -global cpu.num-regs=16.
+test20:
+;  lr      r7, [bta]               ; don't care for erbta (use current bta)
+;  set_excep_params ecr=ILLEGAL_INSTRUCTION, \
+;                   eret=@test20_big_u3    , \
+;                   efa=@test20_big_u3     , \
+;                   erbta=r7               , \
+;                   continue=@test21       , \
+;                   test_num=20
+;test20_big_u3:      ; leave_s encoding : 1100 0UUU 110u uuu0
+;  leave_s 4
+;
+;test20_fail:
+;  print "[FAIL] : test20\n"
+;  b @endtest
+;;;;;;;;;;;;;;;;;;;;;;;;;;;; \ Leave Tests / ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+;;;;;;;;;;;;;;;;;;;;;;;;; / Enter/Leave Test \ ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; testing enter_s/leave_s together full fledged.
+test21:
+  mov     r0 , sp                   ; original sp
+  mov     r13, 0x80000013
+  mov     r14, 0x80000014
+  mov     r15, 0x80000015
+  mov     r16, 0x80000016
+  mov     r17, 0x80000017
+  mov     r18, 0x80000018
+  mov     r19, 0x80000019
+  mov     r20, 0x8000001a
+  mov     r21, 0x8000001b
+  mov     r22, 0x8000001c
+  mov     r23, 0x8000001d
+  mov     r24, 0x8000001e
+  mov     r25, 0x8000001f
+  mov     r26, 0x80000020
+  mov     r27, 0x88888888           ; fp
+  mov     r31, @test21_verify       ; blink
+
+  enter_s [r13-r26, fp, blink]
+  ; botching all except for fp. it's already changed to current sp.
+  breq    r28, 0x88888888, @test21_fail   ; sanity check that fp changed
+  mov     r1 , 0xdeadbeef
+  mov     r13, r1
+  mov     r14, r1
+  mov     r15, r1
+  mov     r16, r1
+  mov     r17, r1
+  mov     r18, r1
+  mov     r19, r1
+  mov     r20, r1
+  mov     r21, r1
+  mov     r22, r1
+  mov     r23, r1
+  mov     r24, r1
+  mov     r25, r1
+  mov     r26, r1
+  mov     r28, r1                   ; botch sp
+  mov     r31, r1                   ; botch blink
+  leave_s [r13-r26, fp, blink, pcl]
+  j       @test21_fail
+
+test21_verify:
+  brne    r13,     0x80000013, @test21_fail
+  brne    r14,     0x80000014, @test21_fail
+  brne    r15,     0x80000015, @test21_fail
+  brne    r16,     0x80000016, @test21_fail
+  brne    r17,     0x80000017, @test21_fail
+  brne    r18,     0x80000018, @test21_fail
+  brne    r19,     0x80000019, @test21_fail
+  brne    r20,     0x8000001a, @test21_fail
+  brne    r21,     0x8000001b, @test21_fail
+  brne    r22,     0x8000001c, @test21_fail
+  brne    r23,     0x8000001d, @test21_fail
+  brne    r24,     0x8000001e, @test21_fail
+  brne    r25,     0x8000001f, @test21_fail
+  brne    r26,     0x80000020, @test21_fail
+  brne    r27,     0x88888888, @test21_fail
+  brne    r28,             r0, @test21_fail
+  breq    r31, @test21_verify, @valhalla
+
+test21_fail:
+  print "[FAIL] :test20:"
+  b @endtest
+;;;;;;;;;;;;;;;;;;;;;;;;; \ Enter/Leave Test / ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+	print "[PASS]"
+endtest:
+	print " enter/leave\n"
+  end
+
+
+; vim: set syntax=asm ts=2 sw=2 et:
diff --git a/tests/tcg/arc/check_excp.S b/tests/tcg/arc/check_excp.S
new file mode 100644
index 0000000000..18b436dec7
--- /dev/null
+++ b/tests/tcg/arc/check_excp.S
@@ -0,0 +1,17 @@
+	.include "macros.inc"
+
+	start
+
+	test_name TRAP_1
+	trap_s 0
+	print "[PASS] TRAP_1:1\n"
+	trap_s 1
+	print "[PASS] TRAP_1:2\n"
+	end
+
+	.align 4
+	.global EV_Trap
+	.type EV_Trap, @function
+EV_SWI:
+EV_Trap:
+	rtie
diff --git a/tests/tcg/arc/check_excp_1.c b/tests/tcg/arc/check_excp_1.c
new file mode 100644
index 0000000000..f06720c119
--- /dev/null
+++ b/tests/tcg/arc/check_excp_1.c
@@ -0,0 +1,15 @@
+#include <stdio.h>
+
+void main (void)
+{
+  __builtin_arc_trap_s (0);
+  printf ("[PASS] TRAPC:1\n");
+  __builtin_arc_trap_s (1);
+  printf ("[PASS] TRAPC:2\n");
+}
+
+void __attribute__ ((interrupt("ilink")))
+EV_Trap (void)
+{
+  printf ("[PASS] TRAPC:IRQ\n");
+}
diff --git a/tests/tcg/arc/check_excp_jumpdl_mmu.S b/tests/tcg/arc/check_excp_jumpdl_mmu.S
new file mode 100644
index 0000000000..a98229eba2
--- /dev/null
+++ b/tests/tcg/arc/check_excp_jumpdl_mmu.S
@@ -0,0 +1,44 @@
+.include "macros.inc"
+
+.equ PHYSICAL_ADDRESS_START, 0x80000000
+.equ MMU_ENABLE_FLAG       , 0x80000000
+
+start
+
+; use physical address range for handling exceptions (ivt)
+mov r0, PHYSICAL_ADDRESS_START
+sr  r0, [int_vector_base]
+
+# enable mmu
+mov   r3, MMU_ENABLE_FLAG
+sr    r3, [pid]
+xor_s r3, r3, r3
+
+; write to some virtual address range in a delay slot
+mov r2, 0x1000
+mov r1, @check
+j_s.d [r1]        # let's enjoy the code after delay slot is executed.
+st  r0, [r2]      # oh, oh: exception!
+
+# this line should not be executed
+add_s r3, r3, 1
+
+check:
+brgt r3, 0, @fail
+print "[ OK]"
+b @rest
+fail:
+print "[NOK]"
+
+rest:
+print " Exception in a delay slot.\n"
+
+end
+
+	.align 4
+	.global EV_TLBMissD
+	.type EV_TLBMissD, @function
+EV_TLBMissD:
+  # disable mmu
+  sr r3, [pid]
+	rtie
diff --git a/tests/tcg/arc/check_excp_mmu.S b/tests/tcg/arc/check_excp_mmu.S
new file mode 100644
index 0000000000..8d1cf83445
--- /dev/null
+++ b/tests/tcg/arc/check_excp_mmu.S
@@ -0,0 +1,69 @@
+.include "macros.inc"
+.include "mmu.inc"
+
+; courtesy of macros.inc and mmu.inc
+.extern REG_IVT_BASE
+.extern PAGE_NUMBER_MSK
+.extern REG_PD0_GLOBAL
+.extern REG_PD0_VALID
+.extern REG_PD1_KRNL_W
+
+; test data
+; making an entry for the TLB
+;
+; ,------------------------------------.
+; | VPN(VA), G=1, V=1 | PPN(PHY), Wk=1 |
+; `------------------------------------'
+; where:
+; VPN(VA) is the virtual page number of logical address
+; G is the global bit
+; V is the validity bit
+; PPN(PHY) is the physical page number
+; Wk is the write permission in kernel mode
+
+; obviously, the offsets in both addresses must be the same
+.equ VIRT_ADR , 0x13371334     ; the virtual address; word aligned
+.equ PHYS_ADR , 0x73311334     ; the physical address > 0x7FFFFFFF
+.equ MAGICDATA, 0x00BADB07     ; the test value to write and verify
+.equ PD0_VPN  , (VIRT_ADR & PAGE_NUMBER_MSK)
+.equ PD1_PPN  , (PHYS_ADR & PAGE_NUMBER_MSK)
+.equ PD0_BITS , (PD0_VPN | REG_PD0_GLOBAL | REG_PD0_VALID)
+.equ PD1_BITS , (PD1_PPN | REG_PD1_KRNL_W)
+.equ INT_VECT_ADDRESS, 0x80000000 ; physical address for IVT
+
+start
+
+; use physicall address range for handling exceptions (ivt)
+mov r0, INT_VECT_ADDRESS
+sr  r0, [REG_IVT_BASE]
+
+mmu_enable
+
+; write to the mapped virtual address
+mov r0, MAGICDATA
+st  r0, [VIRT_ADR]
+
+mmu_disable
+
+; with mmu disabled, read from physical address and
+; verify that it is the same  as the  value written
+; to the mapped virtual address earlier
+ld  r1, [PHYS_ADR]
+cmp r0, r1           ; r0 contains the MAGICDATA
+beq @goodboy
+
+print "nope, still no MMU!\n"
+j   @adios
+
+goodboy:
+print "Yay, you got the MMU right :)\n"
+
+adios:
+end
+
+	.align 4
+	.global EV_TLBMissD
+	.type EV_TLBMissD, @function
+EV_TLBMissD:
+	mmu_tlb_insert PD0_BITS, PD1_BITS
+	rtie
diff --git a/tests/tcg/arc/check_flags.S b/tests/tcg/arc/check_flags.S
new file mode 100644
index 0000000000..92faf18c15
--- /dev/null
+++ b/tests/tcg/arc/check_flags.S
@@ -0,0 +1,23 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# flags.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+	TEST_2OP_CARRY (2, sub, 0, 0x00000000, 0x0000000) ;
+	TEST_2OP_CARRY (3, sub, 1, 0x00000000, 0x0000001) ;
+	TEST_2OP_ZERO (4, sub, 0, 0x00000001, 0x0000000) ;
+	TEST_2OP_ZERO (5, sub, 1, 0x00000001, 0x0000001) ;
+	TEST_2OP_NEGATIVE (6, sub, 0, 0x00000000, 0x00000000) ;
+	TEST_2OP_NEGATIVE (7, sub, 1, 0x00000000, 0x00000001) ;
+	TEST_2OP_OVERFLOW (8, sub, 0, 0x00000000, 0x00000000) ;
+	TEST_2OP_OVERFLOW (9, sub, 1, 0x00000000, 0x80000000) ;
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_ldaw_mmu.S b/tests/tcg/arc/check_ldaw_mmu.S
new file mode 100644
index 0000000000..a503c607b9
--- /dev/null
+++ b/tests/tcg/arc/check_ldaw_mmu.S
@@ -0,0 +1,71 @@
+.include "macros.inc"
+.include "mmu.inc"
+
+; courtesy of mmu.inc
+.extern PAGE_NUMBER_MSK
+.extern REG_PD0_GLOBAL
+.extern REG_PD0_VALID
+.extern REG_PD1_KRNL_W
+
+; test data
+; making an entry for the TLB
+;
+; ,------------------------------------.
+; | VPN(VA), G=1, V=1 | PPN(PHY), Wk=1 |
+; `------------------------------------'
+; where:
+; VPN(VA) is the virtual page number of logical address
+; G is the global bit
+; V is the validity bit
+; PPN(PHY) is the physical page number
+; Wk is the write permission in kernel mode
+
+; obviously, the offsets in both addresses must be the same
+.equ VIRT_ADR , 0x13371334     ; the virtual address; word aligned
+.equ PHYS_ADR , 0x73311334     ; the physical address > 0x7FFFFFFF
+.equ MAGICDATA, 0x00BADB07     ; the test value to write and verify
+.equ PD0_VPN  , (VIRT_ADR & PAGE_NUMBER_MSK)
+.equ PD1_PPN  , (PHYS_ADR & PAGE_NUMBER_MSK)
+.equ PD0_BITS , (PD0_VPN | REG_PD0_GLOBAL | REG_PD0_VALID)
+.equ PD1_BITS , (PD1_PPN | REG_PD1_KRNL_R)
+.equ INT_VECT_ADDRESS, 0x80000000 ; physical address for IVT
+
+start
+
+; use physicall address range for handling exceptions (ivt)
+mov r0, INT_VECT_ADDRESS
+sr  r0, [REG_IVT_BASE]
+
+; initialize the data in physical address
+mov r0, MAGICDATA
+st  r0, [PHYS_ADR]
+
+mmu_enable
+
+; read from the mapped virtual address
+mov r2, 0
+ld.aw  r1, [r2, VIRT_ADR]
+
+mmu_disable
+
+; with mmu disabled, read from physical address and
+; verify that it is the same  as the  value written
+; to the mapped virtual address earlier
+cmp r0, r1           ; r0 contains the MAGICDATA
+beq @goodboy
+
+print "nope, still no MMU!\n"
+j   @adios
+
+goodboy:
+print "Yay, you got the MMU right :)\n"
+
+adios:
+end
+
+.align 4
+.global EV_TLBMissD
+.type EV_TLBMissD, @function
+EV_TLBMissD:
+mmu_tlb_insert PD0_BITS, PD1_BITS
+rtie
diff --git a/tests/tcg/arc/check_ldstx.S b/tests/tcg/arc/check_ldstx.S
new file mode 100644
index 0000000000..ac181d9a51
--- /dev/null
+++ b/tests/tcg/arc/check_ldstx.S
@@ -0,0 +1,37 @@
+#*****************************************************************************
+# ldst.S
+#-----------------------------------------------------------------------------
+#
+# This test verifies that ld, ldb, ldw work as expected.
+#
+
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+	TEST_CASE(2, r0, 0x40000000, "ld:2", ld r1,[@tdat]` ld r0,[r1,@tdat])
+	TEST_CASE(3, r0, 0xbeef,     "ld:3", mov r1, 16` ldw r0,[r1, @tdat])
+	TEST_CASE(4, r0, 0xbe,       "ld:4", mov r1, 20` ldb r0,[r1, @tdat])
+	TEST_CASE(5, r0, 0xffffbeef, "ld:5", mov r1, 16` ldw.x r0,[r1, @tdat])
+	TEST_CASE(6, r0, 0xffffffbe, "ld:6", mov r1, 20` ldb.x r0,[r1, @tdat])
+
+	TEST_CASE(7, r0, 0xbeef,      "ld:7", mov r1, @tdat` ldw.as r0,[r1,8])
+	TEST_CASE(8, r0, 0xcafebabe,  "ld:8", mov r1, @tdat` ld.as r0,[r1, 5])
+	TEST_CASE(9, r0, 0xcafebabe,  "ld:9", mov r2, 5` mov r1, @tdat` ld_s.as r0,[r1, r2])
+	TEST_CASE(10, r0, 0x40400000, "ld:10", ldd.as r0,[@tdat,2])
+	TEST_CASE(11, r1, 0xc0800000, "ld:11", ldd.as r0,[@tdat,2])
+
+
+ARCTEST_END
+#  TEST_DATA
+
+tdat:
+.word 0x00000004
+.word 0x40000000
+.word 0x40400000
+.word 0xc0800000
+.word 0xdeadbeef
+.word 0xcafebabe
+.word 0xabad1dea
+.word 0x1337d00d
diff --git a/tests/tcg/arc/check_lp.S b/tests/tcg/arc/check_lp.S
new file mode 100644
index 0000000000..4074cfa1e5
--- /dev/null
+++ b/tests/tcg/arc/check_lp.S
@@ -0,0 +1,12 @@
+.include "macros.inc"
+
+	start
+	mov_s r2,0x28cc
+	sub r3,0x28d8,r2
+	mov  lp_count,0x00fffff0
+	lpne bla
+	st.ab r3,[r2,4]
+	mov 0,0
+bla:
+	print	"[PASS] LP: simple\n"
+	end
diff --git a/tests/tcg/arc/check_lp02.S b/tests/tcg/arc/check_lp02.S
new file mode 100644
index 0000000000..866fa01f36
--- /dev/null
+++ b/tests/tcg/arc/check_lp02.S
@@ -0,0 +1,72 @@
+.include "macros.inc"
+
+	start
+	mov	r3,0
+	mov	r2, 0x2e10
+	mov.f	lp_count,0x10
+	lpne	2f
+	st.ab	r3,[r2,4]
+2:
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+	mov	r2,0x1000
+	mov_s	r3,0xa
+        and.f	lp_count,r3, 0x1f
+        lpnz	2f
+        add 	r2,r2,r2
+2:      # end single insn loop
+
+	print	"[PASS] LP01\n"
+	end
diff --git a/tests/tcg/arc/check_lp03.S b/tests/tcg/arc/check_lp03.S
new file mode 100644
index 0000000000..76e70958f0
--- /dev/null
+++ b/tests/tcg/arc/check_lp03.S
@@ -0,0 +1,49 @@
+	.include "macros.inc"
+
+	start
+	test_name ZOLvsIRQ
+	;; Program the Timer such that we get fast interrupts
+	sr	0x01,[control0]
+	sr	0x1ff,[limit0]
+	sr	0,[count0]
+	mov	r0,0
+	mov	sp,0x1000
+	;; enable global interrupts
+	seti
+	;; Make a short ZOL
+	mov	lp_count,0x1ffff
+	lp	1f
+	nop
+1:
+	clri
+	stb.ab	0,[sp,1]
+2:
+	rem	r2,r0,10
+	add	r2,r2,0x30
+	stb.ab	r2,[sp,1]
+	div.f	r0,r0,10
+	bne	2b
+3:
+	ld.aw	r2,[sp,-1]
+	breq	r2,0,4f
+	;; 	stb	r2,[OUTPUT_DEVICE]
+	brne	r2,0,3b
+4:
+	print	"[PASS] "
+	printl	r30
+	end
+
+	;; Timer ISR
+	.align	4
+	.global	IRQ_Timer0
+	.type	IRQ_Timer0, @function
+IRQ_Timer0:
+	clri
+	;; reset the pending interrupt and reneable it.
+	sr	0x01,[control0]
+	sr	0,[count0]
+	add	r0,r0,1
+	rtie
+	print   "[FAIL] "
+	printl  r30
+	end
diff --git a/tests/tcg/arc/check_lp04.S b/tests/tcg/arc/check_lp04.S
new file mode 100644
index 0000000000..8a2ca6e432
--- /dev/null
+++ b/tests/tcg/arc/check_lp04.S
@@ -0,0 +1,48 @@
+.include "macros.inc"
+
+  start
+
+  ; memset params
+  mov    r0, data     ; address to write
+  mov    r1, 0        ; data to write
+  mov    r2, 0x13     ; size of memory to clear
+
+  ; align the address
+  and    r4, r0, 3
+  rsub.f  lp_count, r4, 4
+  lpne   @main_clear
+  stb.ab r1, [r0, 1]
+  sub    r2, r2, 1
+
+main_clear:
+  ; main setting to zero
+  and.f    lp_count, r2, 0x1f
+  lpne   @verify
+  stb.ab r1, [r0, 1]
+
+verify:
+  ld     r1, [data, 0x12]
+  cmp    r1, 0x66665500
+  beq    @good
+  print  "[FAIL] "
+  j      @the_end
+good:
+  print  "[PASS] "
+the_end:
+  print  "LP04\n"
+  end
+
+.align 4
+make_unaligned:
+  .2byte 0xffff
+data:
+  .4byte 0x11111111
+  .4byte 0x22222222
+  .4byte 0x33333333
+  .4byte 0x44444444
+  .4byte 0x55555555
+  .4byte 0x66666666
+  .4byte 0x77777777
+  .4byte 0x88888888
+  .4byte 0x99999999
+  .4byte 0xAAAAAAAA
diff --git a/tests/tcg/arc/check_lp05.S b/tests/tcg/arc/check_lp05.S
new file mode 100644
index 0000000000..2fc9e40b97
--- /dev/null
+++ b/tests/tcg/arc/check_lp05.S
@@ -0,0 +1,23 @@
+	.include "macros.inc"
+;;; Test what is happening when we have a trap_s at the end of a zol
+	start
+	mov r0,0
+	mov lp_count, 0x1f
+	lp  1f
+	trap_s  0
+1:
+	breq    r0,0x1f,1f
+	print   "[FAIL]"
+	b 2f
+1:
+	print   "[PASS]"
+2:
+	print   " LP05\n"
+    end
+
+    .align  4
+    .global EV_Trap
+    .type EV_Trap, @function
+EV_Trap:
+	add r0,r0,1
+	rtie
diff --git a/tests/tcg/arc/check_lp06.S b/tests/tcg/arc/check_lp06.S
new file mode 100644
index 0000000000..60e7a66309
--- /dev/null
+++ b/tests/tcg/arc/check_lp06.S
@@ -0,0 +1,163 @@
+; check_lp06.S
+;
+; Tests for Zero overhead loop: interrupting the loop
+; If the test fails, check the end of this file for how to troubleshoot.
+
+  .include "macros.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;; Test checking routines ;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case counter
+.data
+test_nr:
+  .word 0x0
+
+; Increment the test counter.
+.macro prep_test_case
+  ld    r13, [test_nr]
+  add_s r13, r13, 1       ; increase test case counter
+  st    r13, [test_nr]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Exception related code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Handler of the day.
+  .align 4
+handler : .word 0x0
+
+; An exception handler routine that merely jumps to whatever address
+; it was told to by the test. See set_except_handler macro. This
+; requires ivt.S file to be compiled and linked.
+  .align 4
+  .global EV_Trap
+  .global EV_SWI
+  .type EV_Trap, @function
+  .type EV_SWI, @function
+EV_SWI:
+EV_Trap:
+  ld  r11, [handler]
+  j   [r11]
+
+; macro:      set_except_handler
+; regs used:  r11
+;
+; This macro writes the provided ADDR to a temporary place holder
+; that later the exception handler routine will jump to.
+.macro set_except_handler   addr
+  mov  r11, \addr
+  st   r11, [handler]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ZOL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Let the tests begin
+  start
+
+; Test case 1
+; Having a 'trap_s' at the end of a loop body. The exception handler
+; must return to the _next instruction_ after the trap which is the
+; LOOP_END. Consequently, it should end up in the LOOP_START if the
+; LP_COUNT != 1. To cut a long story short:
+; next instruction(trap) = loop_start and all iterations should finish
+; before getting out of the loop.
+  prep_test_case
+  set_except_handler @test_1_except_handler
+  mov    r0, 0
+  mov    lp_count, 0x1f
+  lp     @test_1_loop_end
+  trap_s 0
+test_1_loop_end:
+  cmp    r0, 0x1f      ; has the loop finished completely?
+  bne    @fail
+  b      @test_1_end   ; success
+test_1_except_handler:
+  add    r0, r0, 1
+  rtie
+test_1_end:
+  ; Fall through
+
+; Test case 2
+; Having a 'swi' at the end of a loop body. The exception handler
+; must return to the _last instruction_ of the loop body and the
+; whole loop must finish completely.
+; Going back to 'swi' is tricky because it keeps triggering the
+; exception. So, after the first trigger, we change it to NOPs.
+  prep_test_case
+  set_except_handler @test_2_except_handler
+  mov    r0, 0          ; exception trigger mark
+  mov    r1, 0          ; loop counting
+  mov    lp_count, 0x1f
+  lp     @test_2_loop_end
+  add    r1, r1, 1
+test_2_last_insn_loop:
+  swi
+test_2_loop_end:
+  cmp    r1, 0x1f       ; has the loop finished completely?
+  bne    @fail
+  cmp    r0, 1          ; exception triggered?
+  bne    @fail
+  b      @test_2_end    ; success
+test_2_except_handler:
+  add    r0, r0, 1
+  mov    r11, @test_2_last_insn_loop
+  mov    r12, 0x78e0          ; NOP_S opcode
+  sth.ab r12, [r11,2]         ; write two NOP_S instead of one NOP
+  sth    r12, [r11]           ; to avoid misaligned exception.
+  rtie
+test_2_end:
+  ; Fall through
+
+; Test case 3
+; Check if _any_ fetch of instruction at address LOOP_END trigger
+; going back to the loop start if the LP_COUNT is not 1. To test
+; that:
+; Jump out of the loop prematurely.
+; Then outside the loop jump back inside the lopp.
+; This should trigger going back to the loop, but do not jump out
+; prematurely anymore.
+  prep_test_case
+  mov    r0, 0                ; loop counter
+  mov    r2, 0                ; indicator if we jumped to LOOP_END before
+  mov    lp_count, 17
+  lp     @test_3_loop_end
+  cmp    r2, 1
+  bne    @test_3_outside_loop
+test_3_last_insn_loop:
+  add    r0, r0, 1
+test_3_loop_end:
+  add    r3, r2, r0           ; r3 = 1 + 17
+test_3_outside_loop:
+  add    r2, r2, 1
+  cmp    r2, 1
+  beq    @test_3_last_insn_loop
+  cmp    r0, 17               ; sanity checks begin
+  bne    @fail
+  cmp    r2, 2                ; once we jumped there, once fall through.
+  bne    @fail
+  cmp    r3, 18
+  bne    @fail
+
+; Next test cases
+; Timer interrupt and a single insn ZOL. We need to check if indeed we get multiple interrupts, while in ZOL.
+; Timer interrupt and CLRI/SETI body ZOL. The same as above, 2 tests with seti/clri and clri/seti instruction order.
+; Last instruction of a ZOL gets a MMU TLBI miss.
+; Last instruction of a ZOL gets a MMU TLBD miss (load/store).
+; Last instruction of a ZOL gets a MMU TLBI fallowed by a MMU TLBD miss.
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [test_nr]
+  ;print_number r0
+  print "[FAIL]"
+1:
+  print " Zero overhead loop: interrupting the loop\n"
+  end
diff --git a/tests/tcg/arc/check_lsrx.S b/tests/tcg/arc/check_lsrx.S
new file mode 100644
index 0000000000..9f72e84eb5
--- /dev/null
+++ b/tests/tcg/arc/check_lsrx.S
@@ -0,0 +1,33 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# lsr.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+  TEST_RR_3OP ( 2, lsr, 0x00000000, 0x00000000,   0);
+  TEST_RR_3OP ( 3, lsr, 0x12345678, 0x12345678,   0);
+  TEST_RR_3OP ( 4, lsr, 0x01234567, 0x12345678,   4);
+  TEST_RR_3OP ( 5, lsr, 0x0ABCDEF4, 0xABCDEF45,   4);
+  TEST_RR_3OP ( 6, lsr, 0x00000000, 0x7FFFFFFF,  31);
+  TEST_RR_3OP ( 7, lsr, 0x00000001, 0xFFFFFFFF,  31);
+
+  #-------------------------------------------------------------
+  # Flag tests
+  #-------------------------------------------------------------
+  TEST_2OP_CARRY( 9, lsr, 0, 0x00000001, 0x02);
+  TEST_2OP_CARRY(10, lsr, 1, 0x00000001, 0x01);
+  TEST_2OP_ZERO( 11, lsr, 1, 0x00000001, 0x01);
+  TEST_2OP_NEGATIVE( 12, lsr, 1, 0x80000000, 0x00);
+
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_mac.S b/tests/tcg/arc/check_mac.S
new file mode 100644
index 0000000000..7e172457ab
--- /dev/null
+++ b/tests/tcg/arc/check_mac.S
@@ -0,0 +1,228 @@
+.include "macros.inc"
+
+.equ NOTSET, 47806
+
+; conditionally sets the ACC data
+.macro setup_acc acch, accl
+  .if \accl <> NOTSET
+    mov r58, \accl
+  .endif
+  .if \acch <> NOTSET
+    mov r59, \acch
+  .endif
+.endm
+
+; conditionally checks if ACC holds the given value
+.macro verify_acc racch, raccl, test_num
+  .if \raccl <> NOTSET
+    assert_eq r58, \raccl, \test_num
+  .endif
+  .if \racch <> NOTSET
+    assert_eq r59, \racch, \test_num
+  .endif
+.endm
+
+; all Z, N, C, V flags are cleared and ACC will become 0
+.macro clear_flags_and_accu
+  ; clearing the Z N C V flags
+  mov r0, 1
+  add.f r0, r0, r0
+  ; clearing the acc
+  mov r58, 0
+  mov r59, 0
+.endm
+
+; checks if Z, N, C, and V flags are set correctly
+.macro verify_flags z=0, n=0, c=0, v=0, test_num
+  assert_flag REG_STAT_Z, \z, \test_num
+  assert_flag REG_STAT_N, \n, \test_num
+  assert_flag REG_STAT_C, \c, \test_num
+  assert_flag REG_STAT_V, \v, \test_num
+.endm
+
+; macro for testing "MAC" instruction
+.macro mac_test acch=NOTSET, accl=NOTSET, val1, val2, res, racch=NOTSET, raccl=NOTSET, n=0, v=0, test_num
+  ; initializing data
+  setup_acc \acch, \accl
+  mov   r0, \val1
+  mov   r1, \val2
+  ; operation under test
+  mac.f r0, r0, r1
+  ; checking the results
+  verify_flags n=\n, v=\v, test_num=\test_num
+  assert_eq \res, r0, \test_num
+  verify_acc \racch, \raccl, \test_num
+.endm
+
+; macro for testing "MACU" instruction
+.macro macu_test acch=NOTSET, accl=NOTSET, val1, val2, res, racch=NOTSET, raccl=NOTSET, v=0, test_num
+  ; initializing data
+  setup_acc \acch, \accl
+  mov    r0, \val1
+  mov    r1, \val2
+  ; operation under test
+  macu.f r0, r0, r1
+  ; checking the results
+  verify_flags v=\v, test_num=\test_num
+  assert_eq \res, r0, \test_num
+  verify_acc \racch, \raccl, \test_num
+.endm
+
+
+; macro for testing "MACD" instruction
+.macro macd_test acch=NOTSET, accl=NOTSET, val1, val2, resh, resl, racch=NOTSET, raccl=NOTSET, n=0, v=0, test_num
+  ; initializing data
+  setup_acc \acch, \accl
+  mov    r0, \val1
+  mov    r1, \val2
+  ; operation under test
+  macd.f r0, r0, r1
+  ; checking the results
+  verify_flags n=\n, v=\v, test_num=\test_num
+  assert_eq \resl, r0, \test_num
+  assert_eq \resh, r1, \test_num
+  verify_acc \racch, \raccl, \test_num
+.endm
+
+; macro for testing "MACU" instruction
+.macro macdu_test acch=NOTSET, accl=NOTSET, val1, val2, resh, resl, racch=NOTSET, raccl=NOTSET, v=0, test_num
+  ; initializing data
+  setup_acc \acch, \accl
+  mov     r0, \val1
+  mov     r1, \val2
+  ; operation under test
+  macdu.f r0, r0, r1
+  ; checking the results
+  verify_flags v=\v, test_num=\test_num
+  assert_eq \resl, r0, \test_num
+  assert_eq \resh, r1, \test_num
+  verify_acc \racch, \raccl, \test_num
+.endm
+
+
+start
+
+;;;;;;;;;;;;;;;;;;;;;; MAC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; acc =  0 +  4*5 = 20
+mac_test val1=4, val2=5, res=20, test_num=1
+; acc = 20 +  5*1 = 25
+mac_test val1=1, val2=5, res=25, test_num=2
+; acc = 25 + -1*5 = 20
+mac_test val1=0xFFFFFFFF, val2=0x5, res=20, racch=0x0, raccl=20, n=0, test_num=3
+; acc = 20 + -3*9 = -7
+mac_test val1=0xFFFFFFFD, val2=0x09, res=0xFFFFFFF9, racch=0xFFFFFFFF, raccl=0xFFFFFFF9, n=1, test_num=4
+; producing a result that sets both acch and accl
+mac_test acch=0, accl=0, val1=0x7FFFFFFF, val2=0x7FFFFFFF, res=1, racch=0x3FFFFFFF, raccl=0x01, n=0, v=0, test_num=5
+; acc is 0x3FFFFFFF00000001
+mac_test val1=0x80000000, val2=0x80000000, res=1, racch=0x7FFFFFFF, raccl=0x01, n=0, v=0, test_num=6
+; acc is 0x7FFFFFFF00000001; going for the kill: N and V will be set
+mac_test val1=0x12344321, val2=0x56788654, res=0xE1C14CD5, racch=0x86262098, raccl=0xE1C14CD5, n=1, v=1, test_num=7
+; "mac" is not supposed to clear the overflow bit
+mac_test acch=0, accl=0, val1=0, val2=0, res=0, racch=0, raccl=0, n=0, v=1, test_num=8
+clear_flags_and_accu
+
+
+;;;;;;;;;;;;;;;;;;;;;; MACU ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; acc =  0 +  4*5 = 20
+macu_test val1=4, val2=5, res=20, test_num=9
+; acc = 20 +  5*1 = 25
+macu_test val1=1, val2=5, res=25, test_num=10
+; acc = 25 + 21,474,836,475 = 21,474,836,500 (0x00000005,0x00000014)
+macu_test val1=0xFFFFFFFF, val2=0x5, res=20, racch=5, raccl=20, test_num=11
+; acc = 21,474,836,500 + 38,654,705,637 = 60,129,542,137 (0x0000000D,0xFFFFFFF9)
+macu_test val1=0xFFFFFFFD, val2=0x09, res=0xFFFFFFF9, racch=0x0D, raccl=0xFFFFFFF9, test_num=12
+; producing a result that sets both acch and accl
+macu_test acch=0, accl=0, val1=0x7FFFFFFF, val2=0x7FFFFFFF, res=1, racch=0x3FFFFFFF, raccl=0x01, v=0, test_num=13
+; acc is 0x3FFFFFFF00000001
+macu_test val1=0x80000000, val2=0x80000000, res=1, racch=0x7FFFFFFF, raccl=0x01, v=0, test_num=14
+; acc is 0x7FFFFFFF00000001; line below still will not trigger an overflow for MACU
+macu_test val1=0x12344321, val2=0x56788654, res=0xE1C14CD5, racch=0x86262098, raccl=0xE1C14CD5, v=0, test_num=15
+; cause an overflow
+macu_test acch=0xFFFFFFFF, accl=0xFFFFFFFF, val1=1, val2=1, res=0, racch=0, raccl=0, v=1, test_num=16
+; "macu" is not supposed to clear the overflow bit
+macu_test acch=0, accl=0, val1=0, val2=0, res=0, racch=0, raccl=0, v=1, test_num=17
+clear_flags_and_accu
+
+
+;;;;;;;;;;;;;;;;;;;;; MACD ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+macd_test val1=4, val2=5, resh=0, resl=20, test_num=18
+; acc is now 20
+macd_test val1=1, val2=5, resh=0, resl=25, test_num=19
+; acc = 25 + -1*5 = 20
+macd_test val1=0xFFFFFFFF, val2=0x5, resh=0, resl=20, racch=0x0, raccl=20, n=0, test_num=20
+; acc = 20 + -3*9 = -7
+macd_test val1=0xFFFFFFFD, val2=0x09, resh = 0xFFFFFFFF, resl=0xFFFFFFF9, racch=0xFFFFFFFF, raccl=0xFFFFFFF9, n=1, test_num=21
+; producing a result that sets both acch and accl
+macd_test acch=0, accl=0, val1=0x7FFFFFFF, val2=0x7FFFFFFF, resh=0x3FFFFFFF, resl=0x01, racch=0x3FFFFFFF, raccl=0x01, v=0, test_num=22
+; acc is 0x3FFFFFFF00000001
+macd_test val1=0x80000000, val2=0x80000000, resh=0x7FFFFFFF, resl=0x01, racch=0x7FFFFFFF, raccl=0x01, v=0, test_num=23
+; acc is 0x7FFFFFFF00000001; going for the kill: N and V will be set
+macd_test val1=0x12344321, val2=0x56788654, resh=0x86262098, resl=0xE1C14CD5, racch=0x86262098, raccl=0xE1C14CD5, n=1, v=1, test_num=24
+; "macd" is not supposed to clear the overflow bit
+macd_test acch=0, accl=0, val1=0, val2=0, resh=0, resl=0, racch=0, raccl=0, n=0, v=1, test_num=25
+clear_flags_and_accu
+
+
+;;;;;;;;;;;;;;;;;;;; MACDU ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+macdu_test val1=4, val2=5, resh=0, resl=20, test_num=26
+; acc is now 20
+macdu_test val1=1, val2=5, resh=0, resl=25, test_num=27
+; acc = 25 + 21,474,836,475 = 21,474,836,500 (0x00000005,0x00000014)
+macdu_test val1=0xFFFFFFFF, val2=0x5, resh=5, resl=20, racch=5, raccl=20, test_num=28
+; acc = 21,474,836,500 + 38,654,705,637 = 60,129,542,137 (0x0000000D,0xFFFFFFF9)
+macdu_test val1=0xFFFFFFFD, val2=0x09, resh=0x0D, resl=0xFFFFFFF9, racch=0x0D, raccl=0xFFFFFFF9, test_num=29
+; producing a result that sets both acch and accl
+macdu_test acch=0, accl=0, val1=0x7FFFFFFF, val2=0x7FFFFFFF, resh=0x3FFFFFFF, resl=0x01, racch=0x3FFFFFFF, raccl=0x01, v=0, test_num=30
+; acc is 0x3FFFFFFF00000001
+macdu_test val1=0x80000000, val2=0x80000000, resh=0x7FFFFFFF, resl=0x01, racch=0x7FFFFFFF, raccl=0x01, v=0, test_num=31
+; acc is 0x7FFFFFFF00000001; line below still will not trigger an overflow for MACU
+macdu_test val1=0x12344321, val2=0x56788654, resh=0x86262098, resl=0xE1C14CD5, racch=0x86262098, raccl=0xE1C14CD5, v=0, test_num=32
+; cause an overflow
+macdu_test acch=0xFFFFFFFF, accl=0xFFFFFFFF, val1=1, val2=1, resh=0, resl=0, racch=0, raccl=0, v=1, test_num=33
+; "macdu" is not supposed to clear the overflow bit
+macdu_test acch=0, accl=0, val1=0, val2=0, resh=0, resl=0, racch=0, raccl=0, v=1, test_num=34
+clear_flags_and_accu
+
+
+;;;;;;;;;;;;;;;;;;; CC anf FF ;;;;;;;;;;;;;;;;;;;;;;;;;
+mov r0, 0xFFFFFFFF
+mov r1, 0x11111111
+mac.f r2, r0, r1
+assert_flag REG_STAT_N, 1, test_num=35
+clear_flags_and_accu
+
+mov r0, 0xFFFFFFFF
+mov r1, 0x11111111
+mac r2, r0, r1
+assert_flag REG_STAT_N, 0, test_num=36
+clear_flags_and_accu
+
+setup_acc acch=0xFFFFFFFF, accl=0xFFFFFFFF
+mov r0, 0x01
+mov r1, 0x01
+; earlier, this caused an overflow; see test case 25
+macdu r2, r0, r1
+assert_flag REG_STAT_V, 0, test_num=37
+clear_flags_and_accu
+
+; FIXME: uncomment code below when assmbler starts supporting conditon codes
+; cause an overflow and then execute based on CC
+;mov r0, 42
+;mov r1, 1
+;mov r2, 0x1337
+;;macu.v r2, r1, r0        ; assembler does not support this line
+;assert_eq 0x1337, r2, test_num=38
+;
+;mov r0, 42
+;mov r1, 1
+;; causing the N bit to be set
+;mov r4, 0xFFFFFFFF
+;add.f r4, r4, r4
+;; conditional execution and update flags
+;macd.N.f r2, r1, r0      ; assembler does not support this line
+;assert_flag REG_STAT_N, 0, test_num=39
+;assert_eq 42, r2, test_num=39
+
+
+;;;;;;;;;;;;;;;;;;; Finished ;;;;;;;;;;;;;;;;;;;;;;;;;;
+end
diff --git a/tests/tcg/arc/check_manip_10_mmu.S b/tests/tcg/arc/check_manip_10_mmu.S
new file mode 100644
index 0000000000..be426d89e9
--- /dev/null
+++ b/tests/tcg/arc/check_manip_10_mmu.S
@@ -0,0 +1,173 @@
+; check_manip_5_mmu.S
+;
+; Tests for MMU: manipulate MMU table in exception routines.
+; If the test fails, check the end of this file for how to troubleshoot.
+; The running code for this test needs to be in address range >= 0x8000_0000.
+
+  .include "macros.inc"
+  .include "mmu.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bunch of constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+  .equ INT_VECT_ADDRESS, 0x80000000 ; physical address for IVT
+  .equ STATUS32_AD_BIT , 19         ; Alignment Disable bit
+  ; courtesy of macros.inc and mmu.inc
+  .extern REG_IVT_BASE
+  .extern PAGE_NUMBER_MSK
+  .extern REG_PD0_GLOBAL
+  .extern REG_PD0_VALID
+  .extern REG_PD1_KRNL_W
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Exception related code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Handler of the day.
+  .align 4
+handler : .word 0x0
+
+; An exception handler routine that merely jumps to whatever address
+; it was told to by the test. See set_except_handler macro. This
+; requires ivt.S file to be compiled and linked.
+  .align 4
+  .global EV_TLBMissI
+  .global EV_TLBMissD
+  .global EV_ProtV
+  .type   EV_TLBMissI, @function
+  .type   EV_TLBMissD, @function
+  .type   EV_ProtV, @function
+EV_TLBMissI:
+EV_TLBMissD:
+EV_ProtV:
+  ld  r11, [handler]
+  j   [r11]
+
+; macro:      set_except_handler
+; regs used:  r11
+;
+; This macro writes the provided ADDR to a temporary place holder
+; that later the exception handler routine will jump to.
+.macro set_except_handler   addr
+  mov  r11, \addr
+  st   r11, [handler]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Tests ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Let the tests begin
+  start
+  ; use physicall address range for handling exceptions (ivt)
+  mov   r0, INT_VECT_ADDRESS
+  sr    r0, [REG_IVT_BASE]
+
+; Test case 5
+; Like previous test but with a "branch and link". This is even trickier.
+; BL needs to decode the delay instruction to know its length. It uses
+; this information to determine what value should "BLINK" register hold.
+; Below is the pertinent semantic:
+;
+;   delay_insn_addr = bl_insn_addr + bl_insn_len
+;   delay_insn_len  = decode(delay_insn_addr)
+; BLINK = bl_insn_addr + bl_insn_len + delay_insn_len
+;
+; If the "delay slot" instruction is on a missing page, a TLBMissI is
+; raised during "decode(delay_insn_addr)". This all happens while the
+; "BL" instruction is being handled (and not the delay slot):
+;
+; ecr   = 0x40000 (TLBMissI)
+; eret  = bl_insn_addr   --> for previous test, this is delay_insn_addr
+; efa   = delay_insn_addr
+; blink = old value (not updated)
+  .equ T5_VIRT_ADDR, 0x00602000      ; virtual page address
+  .equ T5_PHYS_ADDR, 0xA0008000      ; physical page address
+  .equ T5_ADDR_OFS,  0x00001FF8      ; the offset in the page
+  .equ T5_PD0, ((T5_VIRT_ADDR+T5_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T5_PD1, ((T5_PHYS_ADDR+T5_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R | REG_PD1_KRNL_E)
+  .equ T5_size, test_10_embedded_code_end - test_10_embedded_code_start
+
+  mmu_prep_test_case
+  mmu_prep_test_case
+  ; Copy the embedded code into physical page
+  xor_s   r3, r3, r3
+  mov     r0, @test_10_embedded_code_start
+  mov     r1, @T5_PHYS_ADDR+T5_ADDR_OFS
+test_10_copy:
+  ldb.ab  r2, [r0, 1]
+  stb.ab  r2, [r1, 1]
+  add_s   r3, r3, 1
+  cmp     r3, T5_size
+  blt     @test_10_copy
+  ; Add MMU
+  set_except_handler @test_10_except_handler
+  mmu_tlb_insert T5_PD0, T5_PD1
+  mmu_enable
+  lr      r8, [bta]         ; remember the old bta value
+  mov     r0, 0x80000000    ; will be used by the code to be executed
+  mov     r1, T5_VIRT_ADDR+T5_ADDR_OFS  ; jump to the copied code
+  ; Have embedded code word-aligned at a place where it will be put.
+
+  mov     r5, 0
+  mov     r4, 1
+  sub.f   0, r5, r4
+  j       [r1]
+
+test_10_control:
+  sub r7, r4, r5     ; 1
+  sub.f 0, r7, r6    ;
+
+  bne     @fail
+  add r5, r5, 1
+
+  sub.f 0, r5, 2
+  beq      @test_10_end
+
+  sub.f   0, r5, r4
+  j	  [r1]
+
+  .align 4
+test_10_embedded_code_start:
+  mov	  r6, 1
+  bne.d   @to_jump
+  ld     r7, [r0]
+  mov	  r6, 0
+to_jump:
+  j       @test_10_control
+  nop
+test_10_virt_finish:
+  mov	  r6, 1
+  j       @test_10_control
+test_10_embedded_code_end:
+; Exception routine that will add entry for the second page
+test_10_except_handler:
+  mmu_prep_test_case_address
+  lr      r9, [ecr]
+  cmp     r9, 0x40000                ; TLBMissI?
+  bne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [eret]
+  cmp     r9, @T5_VIRT_ADDR+0x2000 ; Beginning of second page?
+  jne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [efa]
+  cmp     r9, @T5_VIRT_ADDR+0x2000   ; Beginning of second page?
+  jne     @fail
+  mmu_tlb_insert T5_PD0+0x2000, T5_PD1+0x2000
+  rtie
+test_10_end:
+   ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [mmu_test_nr]
+  ;print_number r0
+  print "[FAIL]"
+1:
+  print " MMU: manipulate MMU table in exception routines\n"
+  end
diff --git a/tests/tcg/arc/check_manip_4_mmu.S b/tests/tcg/arc/check_manip_4_mmu.S
new file mode 100644
index 0000000000..599cd2a95a
--- /dev/null
+++ b/tests/tcg/arc/check_manip_4_mmu.S
@@ -0,0 +1,158 @@
+; check_manip_4_mmu.S
+;
+; Tests for MMU: manipulate MMU table in exception routines.
+; If the test fails, check the end of this file for how to troubleshoot.
+; The running code for this test needs to be in address range >= 0x8000_0000.
+
+  .include "macros.inc"
+  .include "mmu.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bunch of constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+  .equ INT_VECT_ADDRESS, 0x80000000 ; physical address for IVT
+  .equ STATUS32_AD_BIT , 19         ; Alignment Disable bit
+  ; courtesy of macros.inc and mmu.inc
+  .extern REG_IVT_BASE
+  .extern PAGE_NUMBER_MSK
+  .extern REG_PD0_GLOBAL
+  .extern REG_PD0_VALID
+  .extern REG_PD1_KRNL_W
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Exception related code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Handler of the day.
+  .align 4
+handler : .word 0x0
+
+; An exception handler routine that merely jumps to whatever address
+; it was told to by the test. See set_except_handler macro. This
+; requires ivt.S file to be compiled and linked.
+  .align 4
+  .global EV_TLBMissI
+  .global EV_TLBMissD
+  .global EV_ProtV
+  .type   EV_TLBMissI, @function
+  .type   EV_TLBMissD, @function
+  .type   EV_ProtV, @function
+EV_TLBMissI:
+EV_TLBMissD:
+EV_ProtV:
+  ld  r11, [handler]
+  j   [r11]
+
+; macro:      set_except_handler
+; regs used:  r11
+;
+; This macro writes the provided ADDR to a temporary place holder
+; that later the exception handler routine will jump to.
+.macro set_except_handler   addr
+  mov  r11, \addr
+  st   r11, [handler]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Tests ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Let the tests begin
+  start
+  ; use physicall address range for handling exceptions (ivt)
+  mov   r0, INT_VECT_ADDRESS
+  sr    r0, [REG_IVT_BASE]
+; Test case 4
+; Straddle a "branch" and its "delay slot" on two consecutive pages.
+; The first virtual page has an entry in TLB, but the second one (which
+; the delay slot is on) does not. We want to see when fetching the delay
+; slot causes a TLBMissI, things will go back smoothly.
+;
+; first page with TLB entry
+; ,-----.
+; | ... |
+; | nop |
+; | b.d |  branch instruction as the last instruction of the page
+; `-----'
+; ,-----.
+; | dly |  delay instruction on the next page
+; | ... |
+; |     |
+; `-----'
+; second page without TLB entry
+  .equ T4_VIRT_ADDR, 0x00402000      ; virtual page address
+  .equ T4_PHYS_ADDR, 0x90008000      ; physical page address
+  .equ T4_ADDR_OFS,  0x00001FF8      ; the offset in the page
+  .equ T4_PD0, ((T4_VIRT_ADDR+T4_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T4_PD1, ((T4_PHYS_ADDR+T4_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R | REG_PD1_KRNL_E)
+  .equ T4_size, test_4_embedded_code_end - test_4_embedded_code_start
+
+  mmu_prep_test_case
+  ; Copy the embedded code into physical page
+  xor_s   r3, r3, r3
+  mov     r0, @test_4_embedded_code_start
+  mov     r1, @T4_PHYS_ADDR+T4_ADDR_OFS
+test_4_copy:
+  ldb.ab  r2, [r0, 1]
+  stb.ab  r2, [r1, 1]
+  add_s   r3, r3, 1
+  cmp     r3, T4_size
+  blt     @test_4_copy
+  ; Add MMU
+  set_except_handler @test_4_except_handler
+  mmu_tlb_insert T4_PD0, T4_PD1
+  mmu_enable
+  mov     r0, 0x80000000    ; will be used by the code to be executed
+  mov     r1, T4_VIRT_ADDR+T4_ADDR_OFS  ; jump to the copied code
+  j       [r1]
+  ; Have embedded code word-aligned at a place where it will be put.
+  .align 4
+test_4_embedded_code_start:
+  nop
+  b.d     @test_4_virt_finish
+  ld      r1, [r0]
+  nop
+  j       @fail
+  nop
+test_4_virt_finish:
+  j       @test_4_end
+test_4_embedded_code_end:
+; Exception routine that will add entry for the second page
+test_4_except_handler:
+  mmu_prep_test_case_address
+  lr      r9, [ecr]
+  cmp     r9, 0x40000                ; TLBMissI?
+  bne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [eret]
+  cmp     r9, @T4_VIRT_ADDR+0x2000   ; Beginning of second page?
+  jne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [efa]
+  cmp     r9, @T4_VIRT_ADDR+0x2000   ; Beginning of second page?
+  jne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [bta]
+  cmp     r9, @T4_VIRT_ADDR+T4_ADDR_OFS+T4_size-8    ; BTA correct?
+  jne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [erbta]
+  cmp     r9, @T4_VIRT_ADDR+T4_ADDR_OFS+T4_size-8    ; ERBTA correct?
+  jne     @fail
+  mmu_tlb_insert T4_PD0+0x2000, T4_PD1+0x2000
+  rtie
+test_4_end:
+   ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [mmu_test_nr]
+  ;print_number r0
+  print "[FAIL]"
+1:
+  print " MMU: manipulate MMU table in exception routines\n"
+  end
diff --git a/tests/tcg/arc/check_manip_5_mmu.S b/tests/tcg/arc/check_manip_5_mmu.S
new file mode 100644
index 0000000000..17ea00bfe8
--- /dev/null
+++ b/tests/tcg/arc/check_manip_5_mmu.S
@@ -0,0 +1,166 @@
+; check_manip_5_mmu.S
+;
+; Tests for MMU: manipulate MMU table in exception routines.
+; If the test fails, check the end of this file for how to troubleshoot.
+; The running code for this test needs to be in address range >= 0x8000_0000.
+
+  .include "macros.inc"
+  .include "mmu.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bunch of constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+  .equ INT_VECT_ADDRESS, 0x80000000 ; physical address for IVT
+  .equ STATUS32_AD_BIT , 19         ; Alignment Disable bit
+  ; courtesy of macros.inc and mmu.inc
+  .extern REG_IVT_BASE
+  .extern PAGE_NUMBER_MSK
+  .extern REG_PD0_GLOBAL
+  .extern REG_PD0_VALID
+  .extern REG_PD1_KRNL_W
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Exception related code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Handler of the day.
+  .align 4
+handler : .word 0x0
+
+; An exception handler routine that merely jumps to whatever address
+; it was told to by the test. See set_except_handler macro. This
+; requires ivt.S file to be compiled and linked.
+  .align 4
+  .global EV_TLBMissI
+  .global EV_TLBMissD
+  .global EV_ProtV
+  .type   EV_TLBMissI, @function
+  .type   EV_TLBMissD, @function
+  .type   EV_ProtV, @function
+EV_TLBMissI:
+EV_TLBMissD:
+EV_ProtV:
+  ld  r11, [handler]
+  j   [r11]
+
+; macro:      set_except_handler
+; regs used:  r11
+;
+; This macro writes the provided ADDR to a temporary place holder
+; that later the exception handler routine will jump to.
+.macro set_except_handler   addr
+  mov  r11, \addr
+  st   r11, [handler]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Tests ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Let the tests begin
+  start
+  ; use physicall address range for handling exceptions (ivt)
+  mov   r0, INT_VECT_ADDRESS
+  sr    r0, [REG_IVT_BASE]
+
+; Test case 5
+; Like previous test but with a "branch and link". This is even trickier.
+; BL needs to decode the delay instruction to know its length. It uses
+; this information to determine what value should "BLINK" register hold.
+; Below is the pertinent semantic:
+;
+;   delay_insn_addr = bl_insn_addr + bl_insn_len
+;   delay_insn_len  = decode(delay_insn_addr)
+; BLINK = bl_insn_addr + bl_insn_len + delay_insn_len
+;
+; If the "delay slot" instruction is on a missing page, a TLBMissI is
+; raised during "decode(delay_insn_addr)". This all happens while the
+; "BL" instruction is being handled (and not the delay slot):
+;
+; ecr   = 0x40000 (TLBMissI)
+; eret  = bl_insn_addr   --> for previous test, this is delay_insn_addr
+; efa   = delay_insn_addr
+; blink = old value (not updated)
+  .equ T5_VIRT_ADDR, 0x00602000      ; virtual page address
+  .equ T5_PHYS_ADDR, 0xA0008000      ; physical page address
+  .equ T5_ADDR_OFS,  0x00001FF8      ; the offset in the page
+  .equ T5_PD0, ((T5_VIRT_ADDR+T5_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T5_PD1, ((T5_PHYS_ADDR+T5_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R | REG_PD1_KRNL_E)
+  .equ T5_size, test_5_embedded_code_end - test_5_embedded_code_start
+
+  mmu_prep_test_case
+  mmu_prep_test_case
+  ; Copy the embedded code into physical page
+  xor_s   r3, r3, r3
+  mov     r0, @test_5_embedded_code_start
+  mov     r1, @T5_PHYS_ADDR+T5_ADDR_OFS
+test_5_copy:
+  ldb.ab  r2, [r0, 1]
+  stb.ab  r2, [r1, 1]
+  add_s   r3, r3, 1
+  cmp     r3, T5_size
+  blt     @test_5_copy
+  ; Add MMU
+  set_except_handler @test_5_except_handler
+  mmu_tlb_insert T5_PD0, T5_PD1
+  mmu_enable
+  lr      r4, [bta]         ; remember the old bta value
+  mov     r0, 0x80000000    ; will be used by the code to be executed
+  mov     r1, T5_VIRT_ADDR+T5_ADDR_OFS  ; jump to the copied code
+  j       [r1]
+  ; Have embedded code word-aligned at a place where it will be put.
+  .align 4
+test_5_embedded_code_start:
+  nop
+  bl.d     @test_5_virt_finish
+  ld      r1, [r0]
+  nop
+  j       @fail
+  nop
+test_5_virt_finish:
+  j       @test_5_end
+test_5_embedded_code_end:
+; Exception routine that will add entry for the second page
+test_5_except_handler:
+  mmu_prep_test_case_address
+  lr      r9, [ecr]
+  print_number_hex r9
+  cmp     r9, 0x40000                ; TLBMissI?
+  bne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [eret]
+  print_number_hex r9
+  cmp     r9, @T5_VIRT_ADDR+0x2000-4 ; Beginning of second page?
+  jne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [efa]
+  print_number_hex r9
+  cmp     r9, @T5_VIRT_ADDR+0x2000   ; Beginning of second page?
+  jne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [bta]
+  print_number_hex r9
+  cmp     r9, r4                     ; BTA not updated? (still old?)
+  jne     @fail
+  mmu_prep_test_case_address
+  lr      r9, [erbta]
+  cmp     r9, r4                     ; ERBTA same as not updated BTA?
+  jne     @fail
+  mmu_tlb_insert T5_PD0+0x2000, T5_PD1+0x2000
+  rtie
+test_5_end:
+   ; Fall through
+
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [mmu_test_nr]
+  ;print_number r0
+  print "[FAIL]"
+1:
+  print " MMU: manipulate MMU table in exception routines\n"
+  end
diff --git a/tests/tcg/arc/check_manip_mmu.S b/tests/tcg/arc/check_manip_mmu.S
new file mode 100644
index 0000000000..c2bab099f9
--- /dev/null
+++ b/tests/tcg/arc/check_manip_mmu.S
@@ -0,0 +1,565 @@
+; check_manip_mmu.S
+;
+; Tests for MMU: manipulate MMU table in exception routines.
+; If the test fails, check the end of this file for how to troubleshoot.
+; The running code for this test needs to be in address range >= 0x8000_0000.
+
+  .include "macros.inc"
+  .include "mmu.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bunch of constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+  .equ INT_VECT_ADDRESS, 0x80000000 ; physical address for IVT
+  .equ STATUS32_AD_BIT , 19         ; Alignment Disable bit
+  ; courtesy of macros.inc and mmu.inc
+  .extern REG_IVT_BASE
+  .extern PAGE_NUMBER_MSK
+  .extern REG_PD0_GLOBAL
+  .extern REG_PD0_VALID
+  .extern REG_PD1_KRNL_W
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Exception related code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Handler of the day.
+  .align 4
+handler : .word 0x0
+
+; An exception handler routine that merely jumps to whatever address
+; it was told to by the test. See set_except_handler macro. This
+; requires ivt.S file to be compiled and linked.
+  .align 4
+  .global EV_TLBMissI
+  .global EV_TLBMissD
+  .global EV_ProtV
+  .global instruction_error
+  .type   EV_TLBMissI, @function
+  .type   EV_TLBMissD, @function
+  .type   EV_ProtV, @function
+  .type   instruction_error, @function
+EV_TLBMissI:
+EV_TLBMissD:
+EV_ProtV:
+instruction_error:
+  ld  r11, [handler]
+  j   [r11]
+
+; macro:      set_except_handler
+; regs used:  r11
+;
+; This macro writes the provided ADDR to a temporary place
+; that later the exception handler routine will jump to.
+.macro set_except_handler   addr
+  mov  r11, \addr
+  st   r11, [handler]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Tests ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Let the tests begin
+  start
+  ; use physicall address range for handling exceptions (ivt)
+  mov   r0, INT_VECT_ADDRESS
+  sr    r0, [REG_IVT_BASE]
+
+; Test case 1:
+; Reading from a virtual address that has no entry in TLB. This will
+; cause a TLBMissD exception. In return, the exception routine handler
+; will add the corresponding entry:
+; ,-----------------.------------------.----------------------.
+; | virtual address | physical address | (kernel) permissions |
+; |-----------------+------------------+----------------------|
+; | 0x1337_1334     | 0x7331_1334      | R--                  |
+; `-----------------^------------------^----------------------'
+; After returning from the exception, the "ld" should go OK.
+; Then there comes a write ("st") that will trigger a ProtV exception.
+; This time, we allow writing as well:
+; ,-----------------.------------------.----------------------.
+; | virtual address | physical address | (kernel) permissions |
+; |-----------------+------------------+----------------------|
+; | 0x1337_1334     | 0x7331_1334      | RW-                  |
+; `-----------------^------------------^----------------------'
+; the "st" to the same address should go fine.
+  .equ T1_VIRT_ADDR, 0x13371334     ; the virtual address; word aligned
+  .equ T1_PHYS_ADDR, 0x73311334     ; the physical address (same page offset as VA)
+  .equ T1_DATA_1   , 0x00BADB07     ; the test value to read and verify
+  .equ T1_DATA_2   , 0x00B07BAD     ; the test value to write and verify
+  .equ T1_PD0   , ((T1_VIRT_ADDR & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T1_PD1_R , ((T1_PHYS_ADDR & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R)
+  .equ T1_PD1_RW, (T1_PD1_R | REG_PD1_KRNL_W)
+  mmu_prep_test_case
+  mov     r2, 0               ; exception handler counter
+  mov     r1, T1_DATA_1       ; plant the data ...
+  st      r1, [T1_PHYS_ADDR]  ; ... into the physical address
+  set_except_handler @test_1_except_handler
+  mmu_enable
+test_1_ld:
+  ld      r0, [T1_VIRT_ADDR]  ; TLBMissD causing instruction
+  cmp     r0, T1_DATA_1
+  bne     @fail
+  mov     r0, T1_DATA_2
+test_1_st:
+  st      r0, [T1_VIRT_ADDR]  ; TLBProtV causing instruction
+  mmu_disable                 ; MMU bye-bye!
+  ld      r1, [T1_PHYS_ADDR]  ; Load the final destination of "st"
+  cmp     r1, T1_DATA_2       ; was it written successfuly?
+  bne     @fail
+  b       @test_1_end
+test_1_except_handler:
+  add_s   r2, r2, 1
+  cmp     r2, 1               ; TLBMissD while loading?
+  bne     @1f
+  lr      r11, [ecr]
+  cmp     r11, TLB_MISS_D_READ; TLBMissD during a load?
+  bne     @fail
+  lr      r11, [eret]
+  cmp     r11, @test_1_ld     ; instruction causing the exception
+  lr      r11, [efa]
+  cmp     r11, T1_VIRT_ADDR   ; faulty address is correct?
+  jne     @fail
+  mov     r11, 0
+  sr      r11, [efa]          ; clearing EFA
+  mmu_tlb_insert T1_PD0, T1_PD1_R
+  rtie
+1:
+  cmp     r2, 2               ; ProtV during write?
+  bne     @fail
+  lr      r11, [ecr]
+  cmp     r11, 0x60208        ; ProtV from MMU during a write?
+  bne     @fail
+  lr      r11, [eret]
+  cmp     r11, @test_1_st     ; instruction causing the exception
+  lr      r11, [efa]
+  cmp     r11, T1_VIRT_ADDR   ; faulty address is correct?
+  jne     @fail
+  mmu_tlb_insert T1_PD0, T1_PD1_RW
+  rtie
+test_1_end:
+  ; Fall through
+
+; Test case 2
+; Load a double word data straddled over two consecutive virtual pages:
+; ,-------------------------------.,-----------------------------.
+; |               ... x0 x1 x2 x3 || x4 x5 x6 x7 x8 ...          |
+; `-------------------------------'`-----------------------------'
+;  virt=0x0050_2000..0x0050_4000      virt=0x0050_4000..0x050_6000
+;
+; Only the first page has an entry in TLB:
+; ,-----------------.------------------.----------------------.
+; | virtual address | physical address | (kernel) permissions |
+; |-----------------+------------------+----------------------|
+; | 0x0050_2000     | 0x3000_8000      | R--                  |
+; `-----------------^------------------^----------------------'
+;
+; An "ldd" from the last 4 byte of the first page will span to
+; the second page. This will lead to an exception (TLBMissD).
+  .equ T2_VIRT_ADDR, 0x00502000      ; virtual page address
+  .equ T2_PHYS_ADDR, 0x30008000      ; physical page address
+  .equ T2_ADDR_OFS,  0x00001FFC      ; the offset in the page
+  .equ T2_PD0, ((T2_VIRT_ADDR+T2_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T2_PD1, ((T2_PHYS_ADDR             & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R)
+
+  mmu_prep_test_case
+  mov     r2, 0               ; exception handler counter
+  set_except_handler @test_2_except_handler
+  mmu_tlb_insert T2_PD0, T2_PD1
+  mmu_enable
+test_2_ldd:
+  ldd     r0, [T2_VIRT_ADDR+T2_ADDR_OFS]
+  cmp     r2, 1
+  bne     @fail
+  b       @test_2_end         ; success!
+test_2_except_handler:
+  add     r2, r2, 1           ; increase the counter
+  lr      r11, [ecr]
+  cmp     r11, 0x50100        ; TLBMissD during a load?
+  bne     @fail
+  lr      r11, [eret]
+  cmp     r11, @test_2_ldd
+  jne     @fail
+  lr      r11, [efa]
+  cmp     r11, T2_VIRT_ADDR+T2_ADDR_OFS+4 ; beginning of next page
+  jne     @fail
+  mmu_disable
+  rtie
+test_2_end:
+  ; Fall through
+
+; Test case 3
+; Load a data word (0x12345678) straddled over two consecutive
+; virtual pages:
+; ,--------------------.,--------------------.
+; |           ... 0x78 || 0x56 0x34 0x12 ... |
+; `--------------------'`--------------------'
+;  virt=0x0000...0x2000  virt=0x2000...0x4000
+;
+; Only the first page has an entry in TLB:
+; ,-----------------.------------------.----------------------.
+; | virtual address | physical address | (kernel) permissions |
+; |-----------------+------------------+----------------------|
+; | 0x0000_0000     | 0x7000_0000      | R--                  |
+; `-----------------^------------------^----------------------'
+;
+; An "ld" (word-sized) from the last byte of the first page will
+; span to the first 3 bytes of the second page. This will lead
+; to an exception (TLBMissD). The exception routine will add the
+; entry for the second page:
+; ,-----------------.------------------.----------------------.
+; | virtual address | physical address | (kernel) permissions |
+; |-----------------+------------------+----------------------|
+; | 0x0000_0000     | 0x7000_0000      | R--                  |
+; | 0x0000_2000     | 0x6000_2000      | R--                  |
+; `-----------------^------------------^----------------------'
+;
+; And in the end, we must have fetched the data (0x12345678).
+; To make the test realistic, the physical page addresses are not
+; consecutive as opposed to their virtual counter parts.
+; The alignment check should be disabled for this test.
+  .equ T3_VIRT_ADDR_1, 0x00000000      ; two virtual page addresses ...
+  .equ T3_VIRT_ADDR_2, 0x00002000      ; ... that are consecutive.
+  .equ T3_PHYS_ADDR_1, 0x70000000      ; two physical page addresses ...
+  .equ T3_PHYS_ADDR_2, 0x60002000      ; ... that are inconsecutive.
+  .equ T3_ADDR_1_OFS,  0x00001FFF      ; the offset in the first pages.
+  .equ T3_PD0_ENT1, ((T3_VIRT_ADDR_1+T3_ADDR_1_OFS & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T3_PD1_ENT1, ((T3_PHYS_ADDR_1               & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R)
+  .equ T3_PD0_ENT2, ((T3_VIRT_ADDR_2               & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T3_PD1_ENT2, ((T3_PHYS_ADDR_2               & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R)
+  mmu_prep_test_case
+  ; Plant data at the physical addresses
+  mov     r1, 0x12345678
+  stb     r1, [T3_PHYS_ADDR_1+T3_ADDR_1_OFS]  ; 0x78 at the end of first page
+  lsr8    r1, r1
+  sth     r1, [T3_PHYS_ADDR_2]                ; 0x56 0x34 at the beginning of 2nd page
+  lsr16   r1, r1
+  stb     r1, [T3_PHYS_ADDR_2+2]              ; 0x12 The 3rd byte on the 2nd page
+  mov     r1, 0                               ; exception handler counter
+  disable_alignment
+  set_except_handler @test_3_except_handler
+  mmu_tlb_insert T3_PD0_ENT1, T3_PD1_ENT1
+  mmu_enable
+  ; Exception-causing instruction
+test_3_ld:
+  ld      r0, [T3_VIRT_ADDR_1+T3_ADDR_1_OFS]
+  mov     r3, 0x12345678
+  cmp     r0, r3
+  bne     @fail
+  cmp     r1, 1
+  bne     @fail
+  b       @test_3_end         ; success!
+test_3_except_handler:
+  add     r1, r1, 1           ; increase the counter
+  lr      r11, [ecr]
+  cmp     r11, 0x50100        ; TLBMissD during a load?
+  bne     @fail
+  lr      r11, [eret]
+  cmp     r11, @test_3_ld
+  jne     @fail
+  lr      r11, [efa]
+  cmp     r11, @T3_VIRT_ADDR_2
+  jne     @fail
+  mmu_tlb_insert T3_PD0_ENT2, T3_PD1_ENT2
+  rtie
+test_3_end:
+  ; Fall through
+
+; Test case 4
+; Straddle a "branch" and its "delay slot" on two consecutive pages.
+; The first virtual page has an entry in TLB, but the second one (which
+; the delay slot is on) does not. We want to see when fetching the delay
+; slot causes a TLBMissI, things will go back smoothly.
+;
+; first page with TLB entry
+; ,-----.
+; | ... |
+; | nop |
+; | b.d |  branch instruction as the last instruction of the page
+; `-----'
+; ,-----.
+; | dly |  delay instruction on the next page
+; | ... |
+; |     |
+; `-----'
+; second page without TLB entry
+  .equ T4_VIRT_ADDR, 0x00402000      ; virtual page address
+  .equ T4_PHYS_ADDR, 0x90008000      ; physical page address
+  .equ T4_ADDR_OFS,  0x00001FF8      ; the offset in the page
+  .equ T4_PD0, ((T4_VIRT_ADDR+T4_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T4_PD1, ((T4_PHYS_ADDR+T4_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R | REG_PD1_KRNL_E)
+  .equ T4_size, test_4_embedded_code_end - test_4_embedded_code_start
+
+  mmu_prep_test_case
+  ; Copy the embedded code into physical page
+  xor_s   r3, r3, r3
+  mov     r0, @test_4_embedded_code_start
+  mov     r1, @T4_PHYS_ADDR+T4_ADDR_OFS
+test_4_copy:
+  ldb.ab  r2, [r0, 1]
+  stb.ab  r2, [r1, 1]
+  add_s   r3, r3, 1
+  cmp     r3, T4_size
+  blt     @test_4_copy
+  ; Add MMU
+  set_except_handler @test_4_except_handler
+  mmu_tlb_insert T4_PD0, T4_PD1
+  mmu_enable
+  mov     r1, T4_VIRT_ADDR+T4_ADDR_OFS  ; jump to the copied code
+  j       [r1]
+  ; Have embedded code word-aligned at a place where it will be put.
+  .align 4
+test_4_embedded_code_start:
+  nop
+  b.d     @test_4_virt_finish
+  add     r1, r0, r0
+  nop
+  j       @fail
+  nop
+test_4_virt_finish:
+  j       @test_4_end
+test_4_embedded_code_end:
+; Exception routine that will add entry for the second page
+test_4_except_handler:
+  lr      r11, [ecr]
+  cmp     r11, TLB_MISS_I
+  bne     @fail
+  lr      r11, [eret]
+  cmp     r11, @T4_VIRT_ADDR+0x2000   ; Beginning of second page?
+  jne     @fail
+  lr      r11, [efa]
+  cmp     r11, @T4_VIRT_ADDR+0x2000   ; Beginning of second page?
+  jne     @fail
+  lr      r11, [bta]
+  cmp     r11, @T4_VIRT_ADDR+T4_ADDR_OFS+T4_size-8    ; BTA correct?
+  jne     @fail
+  lr      r11, [erbta]
+  cmp     r11, @T4_VIRT_ADDR+T4_ADDR_OFS+T4_size-8    ; ERBTA correct?
+  jne     @fail
+  mmu_tlb_insert T4_PD0+0x2000, T4_PD1+0x2000
+  rtie
+test_4_end:
+   ; Fall through
+
+; Test case 5
+; Like previous test but with a "branch and link". This is even trickier.
+; BL needs to decode the delay instruction to know its length. It uses
+; this information to determine what value should "BLINK" register hold.
+; Below is the pertinent semantic:
+;
+;   delay_insn_addr = bl_insn_addr + bl_insn_len
+;   delay_insn_len  = decode(delay_insn_addr)
+; BLINK = bl_insn_addr + bl_insn_len + delay_insn_len
+;
+; If the "delay slot" instruction is on a missing page, a TLBMissI is
+; raised during "decode(delay_insn_addr)". This all happens while the
+; "BL" instruction is being handled (and not the delay slot):
+;
+; ecr   = 0x40000 (TLBMissI)
+; eret  = bl_insn_addr   --> for previous test, this is delay_insn_addr
+; efa   = delay_insn_addr
+; bta   = old value (not updated)
+; blink = old value (not updated)
+  .equ T5_VIRT_ADDR, 0x00602000      ; virtual page address
+  .equ T5_PHYS_ADDR, 0xA0008000      ; physical page address
+  .equ T5_ADDR_OFS,  0x00001FF8      ; the offset in the page
+  .equ T5_PD0, ((T5_VIRT_ADDR+T5_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T5_PD1, ((T5_PHYS_ADDR+T5_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R | REG_PD1_KRNL_E)
+  .equ T5_size, test_5_embedded_code_end - test_5_embedded_code_start
+
+  mmu_prep_test_case
+  ; Copy the embedded code into physical page
+  xor_s   r3, r3, r3
+  mov     r0, @test_5_embedded_code_start
+  mov     r1, @T5_PHYS_ADDR+T5_ADDR_OFS
+test_5_copy:
+  ldb.ab  r2, [r0, 1]
+  stb.ab  r2, [r1, 1]
+  add_s   r3, r3, 1
+  cmp     r3, T5_size
+  blt     @test_5_copy
+  ; Add MMU
+  set_except_handler @test_5_except_handler
+  mmu_tlb_insert T5_PD0, T5_PD1
+  mmu_enable
+  lr      r4, [bta]         ; remember the old bta value
+  mov     r5, blink         ; remember the old blink value
+  mov     r1, T5_VIRT_ADDR+T5_ADDR_OFS  ; jump to the copied code
+  j       [r1]
+  ; Have embedded code word-aligned at a place where it will be put.
+  .align 4
+test_5_embedded_code_start:
+  nop
+  bl.d    @test_5_virt_finish
+  add     r1, r0, r0
+  nop
+  j       @fail
+  nop
+test_5_virt_finish:
+  j       @test_5_end
+test_5_embedded_code_end:
+; Exception routine that will add entry for the second page
+test_5_except_handler:
+  lr      r11, [ecr]
+  cmp     r11, TLB_MISS_I
+  bne     @fail
+  lr      r11, [eret]
+  cmp     r11, @T5_VIRT_ADDR+0x2000-4 ; Last instruction of the first page (bl)?
+  jne     @fail
+  lr      r11, [efa]
+  cmp     r11, @T5_VIRT_ADDR+0x2000   ; Beginning of second page?
+  jne     @fail
+  lr      r11, [bta]
+  cmp     r11, r4                     ; BTA not updated? (still old?)
+  jne     @fail
+  lr      r11, [erbta]
+  cmp     r11, r4                     ; ERBTA same as not-updated-BTA?
+  mov     r11, blink
+  cmp     r11, r5                     ; BLINK not updated? (still old?)
+  jne     @fail
+  mmu_tlb_insert T5_PD0+0x2000, T5_PD1+0x2000
+  rtie
+test_5_end:
+   ; Fall through
+
+; Test case 6: BLINK register must be updated immediately after "BL".
+  mmu_prep_test_case
+  bl.d    @test_6_branch_taken
+  mov     r0, blink
+test_6_after_delay_slot:
+  b       @fail
+  .align 4
+test_6_branch_taken:
+  mov     r1, @test_6_after_delay_slot
+  cmp     r0, r1
+  bne     @fail
+
+; Test case 7: BTA register must be updated immediately after "BL".
+  mmu_prep_test_case
+  bl.d    @test_7_branch_taken
+  lr      r0, [bta]
+  b       @fail
+  .align 4
+test_7_branch_taken:
+  mov     r1, @test_7_branch_taken
+  cmp     r0, r1
+  bne     @fail
+
+;; Test case 8: Exceptions other than TLBMissI for the delay slot of BL
+;; In this case, such exceptions are deep in decoding pipeline and should
+;; cause a normal exception like any other instructions, where ERET is
+;; pointing to the delay slot and not the BL instruction, like the previous
+;; tests.
+;  mmu_prep_test_case
+;  set_except_handler @test_8_except_handler
+;  bl.d    @test_8_end
+;test_8_delay_slot:
+;  lr      r0, [blink]              ; InstructionError
+;  b       @fail
+;; Exception routine that will add entry for the second page
+;test_8_except_handler:
+;  lr      r11, [ecr]
+;  cmp     r11, ILLEGAL_INSTRUCTION
+;  bne     @fail
+;  lr      r11, [eret]
+;  cmp     r11, @test_8_delay_slot
+;  jne     @fail
+;  lr      r11, [efa]
+;  cmp     r11, @test_8_delay_slot
+;  jne     @fail
+;  lr      r11, [erbta]
+;  cmp     r11, @test_8_end
+;  jne     @fail
+;  lr      r11, [bta]
+;  cmp     r11, @test_8_end
+;  jne     @fail
+;  sr      r11, [eret]             ; Get out of delay slot by jumping to BTA
+;  lr      r11, [erstatus]
+;  bclr    r11, r11, 6             ; Clear delay slot execution flag
+;  sr      r11, [erstatus]
+;  rtie
+;  b       @fail
+;  .align 4
+;test_8_end:
+;  ; Fall through
+
+; Test case 9
+; Like test case 5, but the CC is false here. Although, there is no need
+; for the calculation of BLINK and the _early_ decode of delay slot
+; instruction, still TLBMissI exception for the delay slot instruction
+; happens during the execution of "BLne.D". This is how the hardware
+; works.
+; ecr   = 0x40000 (TLBMissI)
+; eret  = bl_insn_addr
+; efa   = delay_insn_addr
+; bta   = old value (not updated)
+; blink = old value (not updated)
+  .equ T9_VIRT_ADDR, 0x00606000      ; virtual page address
+  .equ T9_PHYS_ADDR, 0xA000A000      ; physical page address
+  .equ T9_ADDR_OFS,  0x00001FF4      ; the offset in the page
+  .equ T9_PD0, ((T9_VIRT_ADDR+T9_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD0_GLOBAL | REG_PD0_VALID)
+  .equ T9_PD1, ((T9_PHYS_ADDR+T9_ADDR_OFS & PAGE_NUMBER_MSK) | REG_PD1_KRNL_R | REG_PD1_KRNL_E)
+  .equ T9_size, test_9_embedded_code_end - test_9_embedded_code_start
+
+  mmu_prep_test_case
+  ; Copy the embedded code into physical page
+  xor_s   r3, r3, r3
+  mov     r0, @test_9_embedded_code_start
+  mov     r1, @T9_PHYS_ADDR+T9_ADDR_OFS
+test_9_copy:
+  ldb.ab  r2, [r0, 1]
+  stb.ab  r2, [r1, 1]
+  add_s   r3, r3, 1
+  cmp     r3, T9_size
+  blt     @test_9_copy
+  ; Add MMU
+  set_except_handler @test_9_except_handler
+  mmu_tlb_insert T9_PD0, T9_PD1
+  mmu_enable
+  lr      r4, [bta]                     ; remember the old bta value
+  mov     r1, T9_VIRT_ADDR+T9_ADDR_OFS  ; jump to the copied code
+  j       [r1]
+  ; Have embedded code word-aligned at a place where it will be put.
+  .align 4
+test_9_embedded_code_start:
+  add.f   0, 0, 0
+  blne.d  @fail
+  add     r0, r0, r0
+  j       @test_9_end
+test_9_embedded_code_end:
+; Exception routine that will add entry for the second page
+test_9_except_handler:
+  lr      r11, [ecr]
+  cmp     r11, TLB_MISS_I
+  bne     @fail
+  lr      r11, [eret]
+  cmp     r11, @T9_VIRT_ADDR+0x2000-4 ; Last instruction of the first page (blne.d)?
+  jne     @fail
+  lr      r11, [efa]
+  cmp     r11, @T9_VIRT_ADDR+0x2000   ; Beginning of second page?
+  jne     @fail
+  lr      r11, [bta]
+  cmp     r11, r4                     ; BTA not updated? (still old?)
+  jne     @fail
+  lr      r11, [erbta]
+  cmp     r11, r4                     ; ERBTA same as not updated BTA?
+  jne     @fail
+  mmu_tlb_insert T9_PD0+0x2000, T9_PD1+0x2000
+  rtie
+test_9_end:
+   ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+.align 4
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [mmu_test_nr]
+  ;print_number r0
+  print "[FAIL]"
+1:
+  print " MMU: manipulate MMU table in exception routines\n"
+  end
diff --git a/tests/tcg/arc/check_mmu.S b/tests/tcg/arc/check_mmu.S
new file mode 100644
index 0000000000..69a38e30d5
--- /dev/null
+++ b/tests/tcg/arc/check_mmu.S
@@ -0,0 +1,59 @@
+.include "macros.inc"
+.include "mmu.inc"
+
+; courtesy of mmu.inc
+.extern PAGE_NUMBER_MSK
+.extern REG_PD0_GLOBAL
+.extern REG_PD0_VALID
+.extern REG_PD1_KRNL_W
+
+; test data
+; making an entry for the TLB
+;
+; ,------------------------------------.
+; | VPN(VA), G=1, V=1 | PPN(PHY), Wk=1 |
+; `------------------------------------'
+; where:
+; VPN(VA) is the virtual page number of logical address
+; G is the global bit
+; V is the validity bit
+; PPN(PHY) is the physical page number
+; Wk is the write permission in kernel mode
+
+; obviously, the offsets in both addresses must be the same
+.equ VIRT_ADR , 0x13371334     ; the virtual address; word aligned
+.equ PHYS_ADR , 0x73311334     ; the physical address > 0x7FFFFFFF
+.equ MAGICDATA, 0x00BADB07     ; the test value to write and verify
+.equ PD0_VPN  , (VIRT_ADR & PAGE_NUMBER_MSK)
+.equ PD1_PPN  , (PHYS_ADR & PAGE_NUMBER_MSK)
+.equ PD0_BITS , (PD0_VPN | REG_PD0_GLOBAL | REG_PD0_VALID)
+.equ PD1_BITS , (PD1_PPN | REG_PD1_KRNL_W)
+
+start
+
+mmu_enable
+
+; insert into table: VA 0x13371337 (Global) --> PHY: 0x73311337 (RW kernel)
+mmu_tlb_insert PD0_BITS, PD1_BITS
+
+; write to the mapped virtual address
+mov r0, MAGICDATA
+st  r0, [VIRT_ADR]
+
+mmu_disable
+
+; with mmu disabled, read from physical address and
+; verify that it is the same  as the  value written
+; to the mapped virtual address earlier
+ld  r1, [PHYS_ADR]
+cmp r0, r1           ; r0 contains the MAGICDATA
+beq @goodboy
+
+print "nope, still no MMU!\n"
+j   @adios
+
+goodboy:
+print "Yay, you got the MMU right :)\n"
+
+adios:
+end
diff --git a/tests/tcg/arc/check_mpu.S b/tests/tcg/arc/check_mpu.S
new file mode 100644
index 0000000000..e840b95403
--- /dev/null
+++ b/tests/tcg/arc/check_mpu.S
@@ -0,0 +1,703 @@
+; check_mpu.S
+;
+; Tests for MPUv3: Memory protection unit v3.
+; If the test fails, check the end of this file for how to troubleshoot.
+
+  .include "macros.inc"
+  .include "mpu.inc"
+  .include "mmu.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;; Test checking routines ;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case counter
+.data
+test_nr:
+  .word 0x0
+
+; Increment the test counter and set (Z,N,C,V) to (0,0,0,0).
+.macro prep_test_case
+  ld    r13, [test_nr]
+  add_s r13, r13, 1       ; increase test case counter
+  st    r13, [test_nr]
+  add.f 0, 0, 1           ; (Z, N, C, V) = (0, 0, 0, 0)
+.endm
+
+; macro:     auxreg_write_read
+; input:     reg      - the register we are talking about
+;            write    - value to write
+;            read     - value expected to be read
+; regs used: r11, r12
+; example:   auxreg_write_read mpuen, 0xffffffff, 0x400001f8
+;
+; description:
+;   Not always, "write" and "read" values are the same. This true about
+;   the registers who have reserved bits or read as zero in user mode,
+;   etc.
+;   Be careful, what is the result of you writing to to "reg". It may
+;   have consequences like enabling page protection or so.
+.macro auxreg_write_read reg, write, read
+  mov   r11, \write
+  sr    r11, [\reg]
+  ; using a different register to reduce the chande of false equality
+  lr    r12, [\reg]
+  cmp   r12, \read
+  bne   @fail
+.endm
+
+  start
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; check the MPU_BUILD
+test_00:
+  .equ VERSION   , 0x03
+  .equ NR_REGIONS, 0x08
+  .equ MPU_BCR_REF, (NR_REGIONS << 8) | VERSION
+  lr    r0, [mpu_build]
+  cmp   r0, MPU_BCR_REF
+  bne   @fail
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; All of the registers should be accessible in kernel mode
+; this test (check_mpu) is based on 8 regions.
+test_01:
+  prep_test_case
+  ; mpuen : momentarily enabled with full access
+  ; when read, only relevant bits must be set.
+  auxreg_write_read mpuen   , 0xffffffff, 0x400001f8
+  ; disable mpu at once
+  mpu_disable
+  auxreg_write_read mpurdb0 , 0xffffffff, 0xffffffe1
+  auxreg_write_read mpurdp0 , 0xffffffff, 0x00000ffb
+  auxreg_write_read mpurdb1 , 0xffffffff, 0xffffffe1
+  auxreg_write_read mpurdp1 , 0xffffffff, 0x00000ffb
+  auxreg_write_read mpurdb2 , 0xffffffff, 0xffffffe1
+  auxreg_write_read mpurdp2 , 0xffffffff, 0x00000ffb
+  auxreg_write_read mpurdb3 , 0xffffffff, 0xffffffe1
+  auxreg_write_read mpurdp3 , 0xffffffff, 0x00000ffb
+  auxreg_write_read mpurdb4 , 0xffffffff, 0xffffffe1
+  auxreg_write_read mpurdp4 , 0xffffffff, 0x00000ffb
+  auxreg_write_read mpurdb5 , 0xffffffff, 0xffffffe1
+  auxreg_write_read mpurdp5 , 0xffffffff, 0x00000ffb
+  auxreg_write_read mpurdb6 , 0xffffffff, 0xffffffe1
+  auxreg_write_read mpurdp6 , 0xffffffff, 0x00000ffb
+  auxreg_write_read mpurdb7 , 0xffffffff, 0xffffffe1
+  auxreg_write_read mpurdp7 , 0xffffffff, 0x00000ffb
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; None of the registers should be accessible in user mode
+test_02:
+  prep_test_case
+  mpu_reset
+  ; prep the exception for the end
+  lr    r0, [mpuic]    ; don't care for mpu_ecr value
+  mpu_set_except_params mpu_ecr  = r0                  , \
+                        ecr      = PRIVILEGE_VIOLATION , \
+                        efa      = @test_02_user_space+4, \
+                        eret     = @test_02_user_space+4, \
+                        continue = @test_02_end
+  enter_user_mode @test_02_user_space
+test_02_user_space:
+  add   r0, r0, r0           ; some filler to make a basic block
+  ; accessing MPU registers in user mode is not allowed
+  lr    r0, [mpu_build]
+  b     @fail                ; an exception must have been raised
+test_02_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Running with -global cpu.has-mpu=false or reading a region register
+; which is higher than the configured number of regions causes an
+; instuction error: ecr=0x020000
+test_03:
+  prep_test_case
+  mpu_reset
+  ; prep the exception for 'lr'ing a region that does not exist
+  lr    r0, [mpuic]    ; don't care for mpu_ecr value
+  mpu_set_except_params mpu_ecr  = r0                     , \
+                        ecr      = ILLEGAL_INSTRUCTION    , \
+                        efa      = @test_03_illegal_lr_rgn, \
+                        eret     = @test_03_illegal_lr_rgn, \
+                        continue = @test_03_cont
+test_03_illegal_lr_rgn:
+  lr    r1, [mpurdb15]
+  b     @fail                ; exception must have been raised
+test_03_cont:
+  ; prep the exception for 'sr'ing a region that does not exist
+  lr    r0, [mpuic]    ; don't care for mpu_ecr value
+  mpu_set_except_params mpu_ecr  = r0                     , \
+                        ecr      = ILLEGAL_INSTRUCTION    , \
+                        efa      = @test_03_illegal_sr_rgn, \
+                        eret     = @test_03_illegal_sr_rgn, \
+                        continue = @test_03_end
+test_03_illegal_sr_rgn:
+  sr    r1, [mpurdp8]
+  b     @fail                ; an exception must have been raised
+test_03_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Verifying the KR permission for region 1.
+; Checking if "read" is OK and "write" raises an exception.
+test_04:
+  .equ MEM_ADDR04  , 0x16000
+  .equ DATA04      , 0x1337
+  .equ MPU_ECR_W_R1, MPU_ECR_WRITE | 1
+  prep_test_case
+  mpu_reset
+  mpu_add_base    mpurdb1, MEM_ADDR04
+  mpu_add_region  mpurdp1, REG_MPU_EN_KR, MPU_SIZE_32B
+  mpu_write_data  DATA04, MEM_ADDR04
+  mpu_enable
+  ; read permission check
+  mpu_verify_data DATA04, MEM_ADDR04
+  ; write permission check
+  mpu_set_except_params mpu_ecr  = MPU_ECR_W_R1            , \
+                        ecr      = PROTV_WRITE_MPU         , \
+                        efa      = MEM_ADDR04              , \
+                        eret     = @test_04_illegal_store+4, \
+                        continue = @test_04_end
+test_04_illegal_store:
+  add   r0, r0, r0           ; filler; so exception happens in...
+  st    r1, [MEM_ADDR04]     ; ...the middle of a translation block
+  b     @fail                ; an exception must have been raised
+test_04_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Having 2 small regions next to each other: one with write permission
+; and the other with read permission. Check if permissions are respected
+; accordingly. This tests how MPU sets QEmu's internal TLB and if it is
+; able to set the TLB's entry size correctly.
+test_05:
+  .equ MEM_ADDR05, 0x16024     ; 4 bytes above the multiple of 32
+  .equ DATA05    , 0xbabe
+  prep_test_case
+  mpu_reset
+  mpu_add_base    mpurdb0, MEM_ADDR05   ; effective address would be 0x4020
+  mpu_add_region  mpurdp0, REG_MPU_EN_KW, MPU_SIZE_32B
+  mpu_add_base    mpurdb1, MEM_ADDR05+32; effective address would be 0x4040
+  mpu_add_region  mpurdp1, REG_MPU_EN_KR, MPU_SIZE_32B
+  mpu_write_data  DATA05, MEM_ADDR05+32 ; write to 0x4044 (region1)
+  ; let the fun begin
+  mpu_enable
+  mpu_verify_data DATA05, MEM_ADDR05+32
+  st    r7, [MEM_ADDR05]       ; write bogus data (region 0)
+  ; now time for some exception
+  mpu_set_except_params mpu_ecr  = MPU_ECR_W_R1          , \
+                        ecr      = PROTV_WRITE_MPU       , \
+                        efa      = MEM_ADDR05+32         , \
+                        eret     = @test_05_illegal_store, \
+                        continue = @test_05_end
+test_05_illegal_store:
+  st    r7, [MEM_ADDR05+32]    ; this shouldn't be allowed
+  b     @fail                  ; an exception must have been raised
+test_05_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Update a region's permission and size to check if they are taken
+; into account.
+test_06:
+  .equ MEM_ADDR06,   0x30000
+  .equ MPU_ECR_R_R3, MPU_ECR_READ | 3
+  prep_test_case
+  mpu_reset
+  mpu_add_base    mpurdb3, MEM_ADDR06
+  mpu_add_region  mpurdp3, REG_MPU_EN_KR, MPU_SIZE_64B
+  mpu_enable
+  ld r7, [MEM_ADDR06+32]    ; this should be allowed
+  ; changing permission (deliberately mpu is not disabled)
+  mpu_add_region  mpurdp3, REG_MPU_EN_KE, MPU_SIZE_64B ; update (KR -> KE)
+  ; prep for exception
+  mpu_set_except_params mpu_ecr  = MPU_ECR_R_R3         , \
+                        ecr      = PROTV_READ_MPU       , \
+                        efa      = MEM_ADDR06+32        , \
+                        eret     = @test_06_illegal_read, \
+                        continue = @test_06_change_size
+test_06_illegal_read:
+  ld    r7, [MEM_ADDR06+32]    ; this is not allowed anymore
+  b     @fail                  ; an exception must have been raised
+test_06_change_size:
+  ; changing size (deliberately mpu is not disabled)
+  mpu_add_region  mpurdp3, REG_MPU_EN_KE, MPU_SIZE_32B ; update (64 -> 32)
+  mpu_enable
+  ld    r7, [MEM_ADDR06+32]    ; this is allowed again (+32 is in def. region)
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Check a permission that has only execute permission.
+; The read should not be possible.
+test_07:
+  .equ NOP_OPCODE, 0x7000264a
+  .equ JR1_OPCODE, 0x00402020
+  .equ CODE_CAVE07, 0x40000
+  .equ MPU_ECR_R_R0, MPU_ECR_READ | 0
+  prep_test_case
+  mpu_reset
+  mpu_add_base    mpurdb0, CODE_CAVE07
+  mpu_add_region  mpurdp0, REG_MPU_EN_KE, MPU_SIZE_32B
+  mov   r0, NOP_OPCODE
+  mov   r1, @test_07_rest
+  mov   r2, JR1_OPCODE
+  st    r0, [CODE_CAVE07]    ; nop
+  st    r2, [CODE_CAVE07+4]  ; j [r1]
+  st    r0, [CODE_CAVE07+8]  ; nop
+  mpu_enable
+  ; let's take a leap of faith
+  j     CODE_CAVE07
+
+test_07_rest:
+  ; wow, if we just came back, let's raise hell
+  mpu_set_except_params mpu_ecr  = MPU_ECR_R_R0         , \
+                        ecr      = PROTV_READ_MPU       , \
+                        efa      = CODE_CAVE07+4        , \
+                        eret     = @test_07_illegal_read, \
+                        continue = @test_07_end
+test_07_illegal_read:
+  ld    r7, [CODE_CAVE07+4]    ; this shouldn't be allowed
+  b     @fail                  ; an exception must have been raised
+test_07_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; One region to rule them all
+; 1) We are testing a very big region here.
+; 2) Moreover we change its permission and size in the middle
+test_08:
+  .equ MEM_ADDR08   , 0x00000000
+  .equ BIG_ADDR08   , 0x7FFFFFE0
+  .equ MPU_ECR_W_R7 , MPU_ECR_WRITE | 7
+  .equ MPU_ECR_R_DEF, MPU_ECR_READ | 0xFF
+  .equ DATA08_1     , 0x34fa                ; random magic
+  .equ DATA08_2     , 0x987afb              ; random magic
+  prep_test_case
+  mpu_reset
+  ; planting the data
+  mpu_write_data  DATA08_1, BIG_ADDR08
+  ; a 4 gigabyte region with read and execute permissions
+  mpu_add_base    mpurdb7, MEM_ADDR08
+  mpu_add_region  mpurdp7, REG_MPU_EN_KR | REG_MPU_EN_KE , MPU_SIZE_4G
+  ; prepping exception (must be before enable, otherwise no write access)
+  mpu_set_except_params mpu_ecr  = MPU_ECR_W_R7              , \
+                        ecr      = PROTV_WRITE_MPU           , \
+                        efa      = BIG_ADDR08                , \
+                        eret     = @test_08_illegal_write    , \
+                        continue = @test_08_change_permission, \
+  ; default region with only write permission
+  mpu_enable REG_MPU_EN_KW
+  ; checking read (BIG_ADDR08) and exec (current instruction) permissions
+  mpu_verify_data DATA08_1, BIG_ADDR08
+test_08_illegal_write:
+  st    r7, [BIG_ADDR08]       ; no write is allowed
+  b     @fail                  ; an exception must have been raised
+test_08_change_permission:
+  ; change permission _and_ size
+  mpu_add_region  mpurdp7, REG_MPU_EN_FULL_ACCESS , MPU_SIZE_2G
+  ; now there should be no problem in writing either
+  mpu_write_data  DATA08_2, BIG_ADDR08
+  mpu_verify_data DATA08_2, BIG_ADDR08
+  ; prepping second exception: default region has no read access
+  mpu_set_except_params mpu_ecr  = MPU_ECR_R_DEF            , \
+                        ecr      = PROTV_READ_MPU           , \
+                        efa      = BIG_ADDR08+0xF0          , \
+                        eret     = @test_08_illegal_def_read, \
+                        continue = @test_08_end
+test_08_illegal_def_read:
+  ld    r7, [BIG_ADDR08+0xF0]  ; this is default region now and not sanctioned
+  b     @fail                  ; an exception must have been raised
+test_08_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; A user cannot have kernel permissions, but a kernel inherits granted
+; user permissions as well.
+test_09:
+  .equ MEM_ADDR09_1, 0x60000
+  .equ MEM_ADDR09_2, 0x62000              ; 8k after
+  .equ MPU_ECR_W_R6, MPU_ECR_WRITE | 6
+  .equ DATA09      , 0x89091              ; another random data from beyond
+  prep_test_case
+  mpu_reset
+  ; a region for user to write
+  mpu_add_base   mpurdb5, MEM_ADDR09_1
+  mpu_add_region mpurdp5, REG_MPU_EN_UW, MPU_SIZE_8K
+  ; a region only for kernel
+  mpu_add_base   mpurdb6, MEM_ADDR09_2
+  mpu_add_region mpurdp6, REG_MPU_EN_KR | REG_MPU_EN_KW, MPU_SIZE_8K
+  ; prep the exception for the end
+  mpu_set_except_params mpu_ecr  = MPU_ECR_W_R6             , \
+                        ecr      = PROTV_WRITE_MPU          , \
+                        efa      = MEM_ADDR09_2             , \
+                        eret     = @test_09_user_space+8    , \
+                        continue = @test_09_rest_kernel_mode
+  ; let's have at it
+  mpu_enable REG_MPU_EN_UE | REG_MPU_EN_KR
+  enter_user_mode @test_09_user_space
+test_09_user_space:
+  st    r7, [MEM_ADDR09_2-4]   ; write to the end of user region
+  st    r7, [MEM_ADDR09_2]     ; uh-oh: causing trouble
+  b     @fail                  ; an exception must have been raised
+test_09_rest_kernel_mode:
+  ; a simple write and verify chore in kernel mode
+  mpu_write_data  DATA09, MEM_ADDR09_2+64
+  mpu_verify_data DATA09, MEM_ADDR09_2+64
+  ; also writing to user region because of implied write access
+  mpu_write_data  DATA09, MEM_ADDR09_1+64
+  mpu_disable       ; else we cannot verify (no read access)
+  mpu_verify_data DATA09, MEM_ADDR09_1+64
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; A region with only user read access should not be fetchable.
+test_10:
+  .equ CODE_CAVE10 , 0x100000
+  .equ DATA10      , 0x010101
+  .equ MPU_ECR_E_R4, MPU_ECR_FETCH | 4
+  prep_test_case
+  mpu_reset
+  mpu_add_base   mpurdb4, CODE_CAVE10
+  mpu_add_region mpurdp4, REG_MPU_EN_UR, MPU_SIZE_64K
+  ; plant the data
+  mpu_write_data DATA10, CODE_CAVE10
+  ; prep the exception for the region being not executable
+  mpu_set_except_params mpu_ecr  = MPU_ECR_E_R4   , \
+                        ecr      = PROTV_FETCH_MPU, \
+                        efa      = CODE_CAVE10    , \
+                        eret     = CODE_CAVE10    , \
+                        continue = @test_10_end
+  mpu_enable
+  enter_user_mode @test_10_user_space
+test_10_user_space:
+  mpu_verify_data DATA10, CODE_CAVE10  ; read must be OK
+  j @CODE_CAVE10                       ; this one not
+  b     @fail                  ; an exception must have been raised
+test_10_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; KE must be enough for raising exceptions.
+; The tricky thing about this test is that it is allowing the
+; parameters for the exceptions to be readable. As a result,
+; the test assumes that there is 32 byte region that these
+; parameters fit in AND it does not overlap with the exception
+; routine itself.
+test_11:
+  .equ MEM_ADDR11, 0x900
+  prep_test_case
+  mpu_reset
+  ; allowing exception parameters to be read
+  mpu_add_base   mpurdb0, @mpu_ecr_ref
+  mpu_add_region mpurdp0, REG_MPU_EN_KR, MPU_SIZE_32B
+  ; prep for the exception
+  mpu_set_except_params mpu_ecr  = MPU_ECR_R_DEF        , \
+                        ecr      = PROTV_READ_MPU       , \
+                        efa      = MEM_ADDR11           , \
+                        eret     = @test_11_illegal_read, \
+                        continue = @test_11_end
+  mpu_enable REG_MPU_EN_KE
+  add   r0, r0, r0           ; just a random guy making a difference
+test_11_illegal_read:
+  ld    r0, [MEM_ADDR11]
+  b     @fail                ; an exception must have been raised
+test_11_end:
+  mpu_disable
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Double exception must raise Machine Check with memory management disabled.
+; This test hangs in nSIM if MMU exists. Apparently, nSIM sets the halt flag
+; if a MachineCheck is raised and there is MMU in the system. The  presence
+; of MMU is necessary for test 14.
+test_12:
+  .equ MPU_ECR_E_DEF, MPU_ECR_FETCH | 0xFF
+  prep_test_case
+  mpu_reset
+  ; enable MPU with no access whatsoever
+  mpu_enable 0x0
+test_12_doomed:
+  add   r0, r0, r0
+  lr    r0, [mpuen]
+  cmp   r0, 0
+  bne   @fail
+  j     @test_12_end
+  ; the machine check routine to be executed eventually
+	.global	 EV_MachineCheck
+	.type	   EV_MachineCheck, @function
+	.align 4
+EV_MachineCheck:
+  lr   r0, [mpuen]
+  cmp  r0, REG_MPU_EN_EN
+  bne  @fail
+  lr   r0, [mpuic]
+  cmp  r0, MPU_ECR_E_DEF
+  bne  @fail
+  lr   r0, [ecr]
+  cmp  r0, MACHINE_CHECK
+  bne  @fail
+  lr   r0, [eret]
+  cmp  r0, @test_12_doomed
+  bne  @fail
+  lr   r1, [efa]
+  cmp  r0, r1
+  bne  @fail
+  mpu_disable         ; disable MPU in a civilized way
+  lr   r0, [erstatus] ; undo the mess:
+  and  r0, r0, ~32    ; clear AE bit
+  sr   r0, [erstatus] ; and
+  rtie                ; return
+test_12_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Page size for the default region: best effort 8K, else 1 byte. You need
+; to look into tracing to see if it is doing the right thing.
+test_13:
+  .equ TWO_PAGES_BEFORE , 0x7C000
+  .equ ONE_PAGE_BEFORE  , 0x7E000
+  .equ MEM_ADDR13_1     , 0x80000
+  .equ SAME_PAGE_BETWEEN, 0x80050
+  .equ MEM_ADDR13_2     , 0x80100
+  .equ SAME_PAGE_AFTER  , 0x81000
+  .equ ONE_PAGE_AFTER   , 0x82000
+  .equ MPU_ECR_R_R1     , MPU_ECR_READ | 1
+  prep_test_case
+  mpu_reset
+  mpu_add_base   mpurdb3, MEM_ADDR13_1        ; \
+  mpu_add_region mpurdp3, 0x0, MPU_SIZE_32B   ;  | two black holes
+  mpu_add_base   mpurdb1, MEM_ADDR13_2        ;  | alike regions
+  mpu_add_region mpurdp1, 0x0, MPU_SIZE_32B   ; /
+  ; your exception shall be your salvation
+  mpu_set_except_params mpu_ecr  = MPU_ECR_R_R1         , \
+                        ecr      = PROTV_READ_MPU       , \
+                        efa      = MEM_ADDR13_2         , \
+                        eret     = @test_13_illegal_read, \
+                        continue = @test_13_end
+  mpu_enable
+  ld r0, [TWO_PAGES_BEFORE+0x1000]    ; must cache the page
+  ld r0, [TWO_PAGES_BEFORE+0x1100]    ; reuse same information
+  ld r0, [ONE_PAGE_BEFORE +0x1FFC]    ; oooh, just before the black hole
+  ld r0, [ONE_PAGE_BEFORE +0x0500]    ; reuse from above
+  ld r0, [SAME_PAGE_BETWEEN      ]    ; too narrow to cache the page
+  ld r0, [SAME_PAGE_BETWEEN+0x10 ]    ; permissions must be totally checked
+  ld r0, [SAME_PAGE_AFTER        ]    ; same page as the black holes
+  ld r0, [SAME_PAGE_AFTER+0x10   ]    ; no caching must be used
+  ld r0, [ONE_PAGE_AFTER         ]    ; this area is safe and ...
+  ld r0, [ONE_PAGE_AFTER+0x04    ]    ; ...can be cached
+test_13_illegal_read:
+  ld r0, [MEM_ADDR13_2           ]    ; oops!
+  b     @fail                         ; an exception must have been raised
+test_13_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; MMU and MPU may coexist but do not overlap.
+; This test assumes an "rwe" access for exception routine checks and an "re"
+; access for the page this test case is loaded in. If these two pages happen
+; to be the same, e.g. previous tests are commented out, then things will
+; get nasty, because the last attribute will be used for both.
+test_14:
+  .equ MMU_KRNL_RE , REG_PD1_KRNL_E | REG_PD1_KRNL_R
+  .equ MMU_KRNL_RWE, REG_PD1_KRNL_E | REG_PD1_KRNL_W | REG_PD1_KRNL_R
+  .equ MMU_VPN_GV  , REG_PD0_GLOBAL | REG_PD0_VALID
+  .equ MEM_ADDR14  , 0x80000100          ; an address in MPU's interest
+  ; creates an entry in TLB with given permissions.
+  ; the translation is identical (virt = physical)
+  .macro add_mmu_entry addr, permission
+    mov r2, \addr
+    and r2, r2, PAGE_NUMBER_MSK
+    or  r3, r2, \permission  ; r3 holds physical address and permissoins
+    or  r2, r2, MMU_VPN_GV   ; r2 is a global valid virtual address
+    mmu_tlb_insert r2, r3    ; add entry for MMU
+  .endm
+  prep_test_case
+  mpu_reset
+  b     @test_14_after_align
+  ; guarantee that current page won't be the same as @mp_ecr_ref's page
+  .align 0x2000
+test_14_after_align:
+  ; add a read/write/execute permission for exception part page
+  ; @mpu_ecr_ref and ProtV handler must be in the same page.
+  add_mmu_entry @mpu_ecr_ref, MMU_KRNL_RWE
+  ; add a read/write/execute permission for vector table.
+  add_mmu_entry 0x0, MMU_KRNL_RWE
+  ; add a read/execute permission for current page
+  lr r1, [pc]
+  add_mmu_entry r1, MMU_KRNL_RE
+  ; exception for writing to the (2nd) MMU page
+  lr    r0, [mpuic]          ; don't care for mpu_ecr value
+  mpu_set_except_params mpu_ecr  = r0                    , \
+                        ecr      = PROTV_WRITE_MMU       , \
+                        efa      = r1                    , \
+                        eret     = @test_14_illegal_write, \
+                        continue = @test_14_mpu
+  ; enable the guys
+  mmu_enable                 ; enable MMU
+  mpu_enable REG_MPU_EN_KW   ; enable MPU with kernel write access
+  ; this is happening in MMU's territory
+test_14_illegal_write:
+  st    r0, [r1]             ; no write for this entry in TLB
+  b     @fail                ; an exception must have been raised
+
+test_14_mpu:
+  add   r0, r0, r0           ; a happy camper
+  st    r0, [MEM_ADDR14]     ; in MPU realm
+  ; MPU exception now
+  mpu_set_except_params mpu_ecr  = MPU_ECR_R_DEF        , \
+                        ecr      = PROTV_READ_MPU       , \
+                        efa      = MEM_ADDR14           , \
+                        eret     = @test_14_illegal_read, \
+                        continue = @test_14_end
+test_14_illegal_read:
+  ld    r0, [MEM_ADDR14]     ; uh-oh...
+  b     @fail                ; an exception must have been raised
+test_14_end:
+  mpu_disable
+  mmu_disable
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Two overlapping regions test. One is 2 pages long and the other is inside
+; the second page of the first region:
+;        ,----------.
+;        | R2:rw-   | region nr 2 with read/write permission.
+; page1  |          |
+;        |          |
+; .......|..........|.......
+;        |          |
+; page2  |,________.|
+;        ||R1:r--  || region nr 1 with read only permission.
+;        |`--------'| this region is inside region nr 2.
+;        `----------'
+; setup: R2 is 16kb with rw-
+;        R1 is  4kb with r--
+; write to the first page           --> must go ok.
+; write to the first half of page 2 --> must go ok.
+; write to R1                       --> expect an exception.
+; in the end read from R1           --> must go ok.
+test_15:
+  .equ MEM_ADDR15_R2   , 0x150000
+  .equ MEM_ADDR15_R2_P2, MEM_ADDR15_R2 + PAGE_SIZE
+  .equ MEM_ADDR15_R1   , MEM_ADDR15_R2_P2 + PAGE_SIZE/2
+  .equ DATA15_1        , 0x3ff0293f    ; random magic
+  .equ DATA15_2        , DATA15_1+1
+  .equ DATA15_3        , DATA15_1+2
+  .equ MPU_ECR_W_R1, MPU_ECR_WRITE | 1
+  prep_test_case
+  mpu_reset
+  mpu_add_base    mpurdb1, MEM_ADDR15_R1
+  mpu_add_region  mpurdp1, REG_MPU_EN_KR, MPU_SIZE_4K
+  mpu_add_base    mpurdb2, MEM_ADDR15_R2
+  mpu_add_region  mpurdp2, REG_MPU_EN_KR|REG_MPU_EN_KW, MPU_SIZE_16K
+  ; planting some data (for later read)
+  mpu_write_data  DATA15_1, MEM_ADDR15_R1+24
+  ; let the fun begin
+  mpu_enable
+  mpu_write_data  DATA15_2, MEM_ADDR15_R2+20
+  mpu_verify_data DATA15_2, MEM_ADDR15_R2+20
+  mpu_write_data  DATA15_3, MEM_ADDR15_R2+20+PAGE_SIZE
+  mpu_verify_data DATA15_3, MEM_ADDR15_R2+20+PAGE_SIZE
+  ; now time for some exception
+  mpu_set_except_params mpu_ecr  = MPU_ECR_W_R1          , \
+                        ecr      = PROTV_WRITE_MPU       , \
+                        efa      = MEM_ADDR15_R1+24      , \
+                        eret     = @test_15_illegal_store, \
+                        continue = @test_15_cont
+  st    r7, [MEM_ADDR15_R2_P2+32] ; write bogus data (region 2, page 2)
+test_15_illegal_store:
+  st    r7, [MEM_ADDR15_R1+24]    ; this shouldn't be allowed
+  b     @fail                     ; an exception must have been raised
+test_15_cont:
+  mpu_verify_data DATA15_1, MEM_ADDR15_R1+24  ; this is allowed
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; Another overlapping regions test. In previous one, a page (nr=2) was split
+; among two regions.  in  this  test, the page  is contained inside  another
+; region, which in return is inside yet another region:
+;        ,----------.
+; page1  | R5:r---  | region nr 5 with read only permission.
+; .......|..........|.......
+; page2  |          |
+; .......|..........|.......
+; page3  |          |
+; .......|..........|.......
+; page4  |          |
+; .......|,________.|.......
+; page5  ||R3:-w-  || region nr 3 with write only permission.
+; .......||........||.......
+; page6  ||        || this region is inside region nr 5.
+; .......|`--------'|.......
+; page7  |          |
+; .......|..........|.......
+; page8  |          |
+;        `----------'
+; setup: R3 is 16kb with -w-
+;        R5 is 64kb with r--
+; read from the fourth page  --> must go ok.
+; read from page 7           --> must go ok.
+; write to page 4            --> expect an exception.
+; write to page 5            --> must go ok.
+; read from page 6           --> expect an exception.
+test_16:
+  .equ MEM_ADDR16_R5   , 0x160000
+  .equ MEM_ADDR16_R5_P4, MEM_ADDR16_R5 + 3*PAGE_SIZE
+  .equ MEM_ADDR16_R5_P7, MEM_ADDR16_R5 + 6*PAGE_SIZE
+  .equ MEM_ADDR16_R3   , MEM_ADDR16_R5 + 4*PAGE_SIZE
+  .equ MEM_ADDR16_R3_P5, MEM_ADDR16_R3
+  .equ MEM_ADDR16_R3_P6, MEM_ADDR16_R5 + 5*PAGE_SIZE
+  .equ DATA16_1        , 0x93822093    ; random magic
+  .equ DATA16_2        , DATA16_1+1
+  .equ DATA16_3        , DATA16_1+2
+  .equ MPU_ECR_R_R3, MPU_ECR_READ  | 3
+  .equ MPU_ECR_W_R5, MPU_ECR_WRITE | 5
+  prep_test_case
+  mpu_reset
+  mpu_add_base    mpurdb3, MEM_ADDR16_R3
+  mpu_add_region  mpurdp3, REG_MPU_EN_KW, MPU_SIZE_16K
+  mpu_add_base    mpurdb5, MEM_ADDR16_R5
+  mpu_add_region  mpurdp5, REG_MPU_EN_KR, MPU_SIZE_64K
+  ; planting some data (for later read)
+  mpu_write_data  DATA16_1, MEM_ADDR16_R5_P4+24
+  mpu_write_data  DATA16_3, MEM_ADDR16_R5_P7+24
+  ; let the fun begin
+  mpu_enable
+  mpu_verify_data DATA16_1, MEM_ADDR16_R5_P4+24
+  mpu_verify_data DATA16_3, MEM_ADDR16_R5_P7+24
+  ; first exception because of writing in region 5
+  mpu_set_except_params mpu_ecr  = MPU_ECR_W_R5          , \
+                        ecr      = PROTV_WRITE_MPU       , \
+                        efa      = MEM_ADDR16_R5_P4+24   , \
+                        eret     = @test_16_illegal_store, \
+                        continue = @test_16_cont
+test_16_illegal_store:
+  st    r7, [MEM_ADDR16_R5_P4+24] ; this shouldn't be allowed
+  b     @fail                     ; an exception must have been raised
+test_16_cont:
+  mpu_write_data  DATA16_2, MEM_ADDR16_R3_P5+24 ;will be checked later
+  ; second exception while reading in region 3
+  mpu_set_except_params mpu_ecr  = MPU_ECR_R_R3         , \
+                        ecr      = PROTV_READ_MPU       , \
+                        efa      = MEM_ADDR16_R3_P6+24  , \
+                        eret     = @test_16_illegal_read, \
+                        continue = @test_16_end
+test_16_illegal_read:
+  ld    r7, [MEM_ADDR16_R3_P6+24] ; this shouldn't be allowed
+  b     @fail                     ; an exception must have been raised
+test_16_end:
+  mpu_disable
+  mpu_verify_data DATA16_2, MEM_ADDR16_R3_P5+24  ; check if written
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [test_nr]
+  print "[FAIL"
+  print ":"
+  print_number r0
+  print "]"
+1:
+  print " MPUv3: Memory protection unit v3.\n"
+  end
diff --git a/tests/tcg/arc/check_mpyd.S b/tests/tcg/arc/check_mpyd.S
new file mode 100644
index 0000000000..1e94431d21
--- /dev/null
+++ b/tests/tcg/arc/check_mpyd.S
@@ -0,0 +1,543 @@
+; check_mpyd.S
+;
+; Tests for mpyd: mpyd mpydu
+; If the test fails, check the end of this file for how to troubleshoot.
+
+  .include "macros.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;; Test checking routines ;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case counter
+.data
+test_nr:
+  .word 0x0
+
+; Increment the test counter and set (Z,N,C,V) to (0,0,0,0).
+.macro prep_test_case
+  ld    r13, [test_nr]
+  add_s r13, r13, 1       ; increase test case counter
+  st    r13, [test_nr]
+  add.f 0, 0, 1           ; (Z, N, C, V) = (0, 0, 0, 0)
+.endm
+
+; These flag checking macros do not directly load the
+; status32 register. Instead, they rely on the value
+; provided by the caller. The rationale is with all these
+; "cmp"s status32 will change. One must use a recorded
+; version of status32 at the right time and then try the
+; macros.
+.macro check_Z_is_clear status
+  mov   r11, \status
+  mov   r12, REG_STAT_Z
+  and   r11, r11, r12
+  cmp   r11, 0
+  bne   @fail
+.endm
+.macro check_N_is_set status
+  mov   r11, \status
+  mov   r12, REG_STAT_N
+  and   r11, r11, r12
+  cmp   r11, REG_STAT_N
+  bne   @fail
+.endm
+.macro check_N_is_clear status
+  mov   r11, \status
+  mov   r12, REG_STAT_N
+  and   r11, r11, r12
+  cmp   r11, 0
+  bne   @fail
+.endm
+.macro check_V_is_set status
+  mov   r11, \status
+  mov   r12, REG_STAT_V
+  and   r11, r11, r12
+  cmp   r11, REG_STAT_V
+  bne   @fail
+.endm
+.macro check_V_is_clear status
+  mov   r11, \status
+  mov   r12, REG_STAT_V
+  and   r11, r11, r12
+  cmp   r11, 0
+  bne   @fail
+.endm
+
+; pair(HI, LOW) == pair(REG_HI, REG_LO) == pair(R59, R58)
+.macro  check_64bit_result      hi, low, reg_hi, reg_lo
+  mov   r11, \hi
+  mov   r10, \low
+  cmp   r11, \reg_hi
+  bne   @fail
+  cmp   r11, r59
+  bne   @fail
+  cmp   r10, \reg_lo
+  bne   @fail
+  cmp   r10, r58
+  bne   @fail
+.endm
+
+; (Z, N, C, V) = (0, 0, 0, 1)
+.macro  clear_N_set_V
+  mov   r11, 0x80000000   ; very small negative number
+  add.f 0, r11, r11       ; cause an overflow (with carry)
+  rol.f 0, 0x01           ; keep the V flag, set the rests to 0
+.endm
+
+; (Z, N, C, V) = (0, 1, 0, 1)
+.macro  set_N_set_V
+  add.f 0, 0x7fffffff, 1  ; negative result with an overflow
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Exception related code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; parameters that an IllegalInstruction exception may set.
+  .align 4
+ecr_ref  : .word ILLEGAL_INSTRUCTION
+addr_ref : .word 0x0                  ; for both eret and efa
+cont_addr: .word 0x0
+
+; exception: IllegalInstruction
+; regs used: r11, r12
+;
+; A parameterized IllegalInstruction exception that checks the followings:
+; ecr  == Illegal instruction
+; efa  == efa_ref
+; eret == eret_ref
+; If everything passes, it will jump to 'cont_addr' parameter. The parameters
+; must be set beforehand using 'set_except_params' macro.  This requires
+; ivt.S file to be compiled and linked.
+  .align 4
+  .global instruction_error
+  .type instruction_error, @function
+instruction_error:
+  ld   r11, [ecr_ref]
+  lr   r12, [ecr]
+  cmp  r12, r11
+  bne  @fail
+  ld   r11, [addr_ref]
+  lr   r12, [eret]
+  cmp  r12, r11
+  bne  @fail
+  lr   r12, [efa]
+  cmp  r12, r11
+  bne  @fail
+  ; Success: continuing
+  ld   r11, [cont_addr]
+  sr   r11, [eret]
+  rtie
+
+; macro:      set_except_params
+; regs used:  r11
+;
+; This macro writes the provided parameters to a temporary place holder
+; that later will be used by exception above to verify as reference.
+.macro set_except_params addr, continue
+  mov  r11, \addr
+  st   r11, [addr_ref]
+  mov  r11, \continue
+  st   r11, [cont_addr]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MPYD ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Let the tests begin
+  start
+
+; Test case 1
+; reg4 <- reg4, reg4
+; 1 = (-1)*(-1)
+  prep_test_case
+  mov     r4, -1
+  mpyd    r4, r4, r4
+  check_64bit_result  0x0, 0x1, r5, r4
+
+; Test case 2
+; reg0 <- reg1, reg0
+; 0 = 0 * 0x22334455
+  prep_test_case
+  mov     r0, 0x22334455    ; bogus data
+  mov     r1, 0
+  set_N_set_V               ; (Z,N,C,V)=(0,1,0,1)
+  mpyd.f  r0, r1, r0
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_Z_is_clear r5
+  check_N_is_clear r5
+  check_V_is_clear r5
+  check_64bit_result  0x0, 0x0, r1, r0
+
+; Test case 3
+; reg2 <- reg3, limm
+; 0xc0000000_80000000 = 0x7ffffffff*0x80000000
+; -4611686016279904256= 2147483647 * -2147483648
+  prep_test_case
+  mov     r3, 0x7fffffff      ; biggest 32-bit positive number
+  clear_N_set_V               ; (Z,N,C,V)=(0,0,0,1)
+  mpyd.f  r2, r3, 0x80000000  ; smallest 32-bit negative number
+  lr      r5, [status32]      ; take a snapshot of statu32 as is
+  check_N_is_set   r5
+  check_V_is_clear r5
+  check_64bit_result  0xc0000000, 0x80000000, r3, r2
+
+; Test case 4
+; reg2 <- limm, reg3
+; 0xffffffff_87654321 = 0x87654321 * 1
+; This is like a sign extension
+  prep_test_case
+  mov     r3, 1
+  clear_N_set_V               ; (Z,N,C,V)=(0,0,0,1)
+  mpyd.f  r2, 0x87654321, r3
+  lr      r5, [status32]      ; take a snapshot of statu32 as is
+  check_N_is_set   r5
+  check_V_is_clear r5
+  check_64bit_result  0xffffffff, 0x87654321, r3, r2
+
+; Test case 5
+; reg0 <- limm, limm
+; 0x3fffffff_00000001 = 0x7fffffff*0x7fffffff
+; 4611686014132420609 = 2147483647*2147483647
+  prep_test_case
+  set_N_set_V                 ; (Z,N,C,V)=(0,1,0,1)
+  mpyd    r0, 0x7fffffff, 0x7fffffff
+  lr      r5, [status32]      ; take a snapshot of statu32 as is
+  check_N_is_set r5
+  check_V_is_set r5
+  check_64bit_result 0x3fffffff, 0x00000001, r1, r0
+
+; Test case 6
+; 0 <- limm, limm       only (acch,accl) will be set.
+; It is expected that V=0 and N=0
+; 4761 = 69 * 69
+  prep_test_case
+  set_N_set_V               ; (Z,N,C,V)=(0,1,0,1)
+  mpyd.f  0, 69, 69
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_N_is_clear r5
+  check_V_is_clear r5
+  check_64bit_result 0, 4761, r59, r58
+
+; Test case 7
+; 0 <- limm, u6         only (acch,accl) will be set.
+; Checking that a result of 0 does not set the Z flag.
+; 0 = 0x12345678 * 0
+  prep_test_case
+  set_N_set_V               ; (Z,N,C,V)=(0,1,0,1)
+  mpyd.f  0, 0x12345678, 0
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_Z_is_clear r5       ; Z must have remained 0
+  check_N_is_clear r5
+  check_V_is_clear r5
+  check_64bit_result 0, 0, r59, r58
+
+; Test case 8
+; 0 <- reg2, limm    (V is already 1)
+; Nothing should change, other than (acch,accl).
+; 0x2468a = 2 * 0x12345
+  prep_test_case
+  mov     r2, 2
+  clear_N_set_V             ; (Z,N,C,V)=(0,0,0,1)
+  mpyd    0, r2, 0x12345
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_V_is_set r5
+  check_64bit_result 0, 0x2468a, r59, r58
+
+; Test case 9
+; reg0 <- reg2, u6
+; -63 = -1 * 63
+  prep_test_case
+  mov     r2, -1
+  mpyd    r0, r2, 63
+  check_64bit_result 0xffffffff, 0xffffffc1, r1, r0
+
+; Test case 10
+; reg2 <- limm, u6
+; 0x2_7d27d268 = 0x12345678 * 35
+  prep_test_case
+  mpyd    r2, 0x12345678, 35
+  check_64bit_result 0x00000002, 0x7d27d268, r3, r2
+
+; Test case 11
+; reg4 <- reg4, s12
+; 0x0000002f_1c71c71c =  0x87654321 * 0xf9c
+;        202340681500 = -2023406815 * -100
+  prep_test_case
+  mov     r4, 0x87654321
+  mpyd    r4, r4, -100
+  check_64bit_result 0x0000002f, 0x1c71c71c, r5, r4
+
+; Test case 12
+; 0 <- limm, s12
+; It is expected that V is cleared and N=1
+; -1250000 = -10000 * 125
+  prep_test_case
+  clear_N_set_V             ; (Z,N,C,V)=(0,0,0,1)
+  mpyd.f  0, -10000 , 125
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_N_is_set   r5
+  check_V_is_clear r5
+  check_64bit_result -1, -1250000, r59, r58
+
+; Test case 13
+; Testing when cc condition is met
+; 0 <- limm, u6      (V is already set)
+; It is expected that V is cleared and N=1
+; -126 = -2 * 63
+  prep_test_case
+  clear_N_set_V             ; (Z,N,C,V)=(0,0,0,1)
+  mpyd.v.f 0, -2, 63
+  lr       r5, [status32]   ; take a snapshot of statu32 as is
+  check_N_is_set   r5
+  check_V_is_clear r5
+  check_64bit_result -1, -126, r59, r58
+
+; Test case 14
+; Testing when cc condition is not met
+; reg0 <- reg0, reg2 (V is already set)
+; It is expected that V is remanins set
+  prep_test_case
+  clear_N_set_V             ; (Z,N,C,V)=(0,0,0,1)
+  mov       r0, 0xc0de      ; must remain ...
+  mov       r1, 0x1337      ; ... (0x1337,0xc0de)
+  mov       r2, 0xf00d      ; don't care ...
+  mov       r3, 0xbad       ; as long as not (0x0,0x1)
+  mov       r4, r58         ; record accl
+  mov       r5, r59         ; record acch
+  mpyd.nv.f r0, r0, r2
+  lr        r2, [status32]  ; take a snapshot of statu32 as is
+  check_V_is_set r2
+  cmp       r1, 0x1337
+  bne       @fail
+  cmp       r0, 0xc0de
+  bne       @fail
+  check_64bit_result r5, r4, r59, r58
+
+; Test case 15
+; Raise an Illegal Instruction exception if an odd register as dest.
+  prep_test_case
+  set_except_params @test_15_exception, @test_15_end
+test_15_exception:
+  mpyd  r3, r2, r4
+  b     @fail
+test_15_end:
+  ; Fall through
+
+; Test case 16
+; Raise an Illegal Instruction exception if an odd register as dest.
+; The exception should be made even if the CC indicates no execution.
+  prep_test_case
+  set_except_params @test_16_exception, @test_16_end
+  add.f   0,0,1         ; (Z,N,C,V)=(0,0,0,0)
+test_16_exception:
+  mpyd.z  r1, r1, r4
+  b       @fail
+test_16_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MPYDU ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 17
+; reg2 <- reg2, reg2
+; 1 = (-1)*(-1)
+; 0xfffffffe_00000001 = 0xffffffff * 0xffffffff
+  prep_test_case
+  mov     r2, -1
+  mpydu   r2, r2, r2
+  check_64bit_result  0xfffffffe, 0x00000001, r3, r2
+
+; Test case 18
+; reg2 <- reg3, reg2
+; 0 = 0 * 0x22334455
+  prep_test_case
+  mov     r2, 0x22334455    ; bogus data
+  mov     r3, 0
+  set_N_set_V               ; (Z,N,C,V)=(0,1,0,1)
+  mpydu.f r2, r3, r2
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_Z_is_clear r5
+  check_N_is_set   r5
+  check_V_is_clear r5
+  check_64bit_result  0x0, 0x0, r3, r2
+
+; Test case 19
+; reg2 <- reg3, limm
+; 0x3fffffff_80000000 = 0x7ffffffff*0x80000000
+; 4611686016279904256 = 2147483647 * 2147483648
+  prep_test_case
+  mov     r3, 0x7fffffff      ; what used to be the largest 32-bit number
+  clear_N_set_V               ; (Z,N,C,V)=(0,0,0,1)
+  mpydu.f r2, r3, 0x80000000  ; just another positive number
+  lr      r5, [status32]      ; take a snapshot of statu32 as is
+  check_V_is_clear r5
+  check_64bit_result  0x3fffffff, 0x80000000, r3, r2
+
+; Test case 20
+; reg4 <- limm, reg5
+; 0x00000000_87654321 = 0x87654321 * 1
+; This is like an unsigned extension
+  prep_test_case
+  mov     r5, 1
+  set_N_set_V                 ; (Z,N,C,V)=(0,1,0,1)
+  mpydu.f r4, 0x87654321, r5
+  lr      r3, [status32]      ; take a snapshot of statu32 as is
+  check_N_is_set   r3
+  check_V_is_clear r3
+  check_64bit_result  0x00000000, 0x87654321, r5, r4
+
+; Test case 21
+; reg0 <- limm, limm
+; 0x40000000_00000000 = 0x80000000*0x80000000
+; 4611686018427387904 = 2147483648*2147483648
+  prep_test_case
+  set_N_set_V                 ; (Z,N,C,V)=(0,1,0,1)
+  mpydu   r0, 0x80000000, 0x80000000
+  lr      r5, [status32]      ; take a snapshot of statu32 as is
+  check_N_is_set r5
+  check_V_is_set r5
+  check_64bit_result 0x40000000, 0x00000000, r1, r0
+
+; Test case 22
+; 0 <- limm, limm       only (acch,accl) will be set.
+; It is expected that V=0 and N=0
+; 3876961 = 1969 * 1969
+  prep_test_case
+  set_N_set_V               ; (Z,N,C,V)=(0,1,0,1)
+  mpydu.f 0, 1969, 1969
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_N_is_set   r5
+  check_V_is_clear r5
+  check_64bit_result 0, 3876961, r59, r58
+
+; Test case 23
+; 0 <- limm, u6         only (acch,accl) will be set.
+; Checking that a result of 0 does not set the Z flag.
+; 0 = 0x12345678 * 0
+  prep_test_case
+  set_N_set_V               ; (Z,N,C,V)=(0,1,0,1)
+  mpydu.f 0, 0x12345678, 0
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_Z_is_clear r5       ; Z must have remained 0
+  check_N_is_set   r5
+  check_V_is_clear r5
+  check_64bit_result 0, 0, r59, r58
+
+; Test case 24
+; 0 <- reg2, limm    (V is already 1)
+; Nothing should change, other than (acch,accl).
+; 0x00001eac_0d5d17a4 = 0x1af54154 * 0x12345
+;      33724307412900 = 452280660  * 74565
+  prep_test_case
+  mov     r2, 0x1af54154    ; I let an ant walk on the keyboard
+  clear_N_set_V             ; (Z,N,C,V)=(0,0,0,1)
+  mpydu   0, r2, 0x12345
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_V_is_set r5
+  check_64bit_result 0x1eac, 0x0d5d17a4, r59, r58
+
+; Test case 25
+; reg0 <- reg2, u6
+; 0x3e_ffffffc1 = 0xffffffff * 0x3f
+;  270582939585 = 4294967295 * 63
+  prep_test_case
+  mov     r2, -1
+  mpydu   r0, r2, 63
+  check_64bit_result 0x3e, 0xffffffc1, r1, r0
+
+; Test case 26
+; reg4 <- limm, u6
+; 0x2_7d27d268 = 0x12345678 * 35
+  prep_test_case
+  mpydu   r4, 0x12345678, 35
+  check_64bit_result 0x00000002, 0x7d27d268, r5, r4
+
+; Test case 27
+; reg2 <- reg2, s12
+; 0x000003e3_8e36b328 =  0xfedcba09 * 0x3e8
+;      4275878409000  =  4275878409 *  1000
+  prep_test_case
+  mov     r2, 0xfedcba09
+  mpydu   r2, r2, 1000
+  check_64bit_result 0x000003e3, 0x8e36b328, r3, r2
+
+; Test case 28
+; 0 <- limm, s12
+; It is expected that V is cleared
+; 1250000 = 10000 * 125
+  prep_test_case
+  clear_N_set_V             ; (Z,N,C,V)=(0,0,0,1)
+  mpydu.f 0, 10000 , 125
+  lr      r5, [status32]    ; take a snapshot of statu32 as is
+  check_V_is_clear r5
+  check_64bit_result 0, 1250000, r59, r58
+
+; Test case 29
+; Testing when cc condition is met
+; 0 <- limm, u6      (V is already set)
+; It is expected that V is cleared and N=1
+; 1781818164 = 28282828 * 63
+  prep_test_case
+  set_N_set_V               ; (Z,N,C,V)=(0,1,0,1)
+  mpydu.n.f 0, 28282828, 63
+  lr        r5, [status32]  ; take a snapshot of statu32 as is
+  check_N_is_set   r5
+  check_V_is_clear r5
+  check_64bit_result 0, 1781818164, r59, r58
+
+; Test case 30
+; Testing when cc condition is not met
+; reg0 <- reg0, reg2 (V is already set)
+; It is expected that V is remanins set
+  prep_test_case
+  set_N_set_V               ; (Z,N,C,V)=(0,1,0,1)
+  mov       r0, 0xc0de      ; must remain ...
+  mov       r1, 0x1337      ; ... (0x1337,0xc0de)
+  mov       r2, 0xf00d      ; don't care ...
+  mov       r3, 0xbad       ; as long as not (0x0,0x1)
+  mov       r4, r58         ; record accl
+  mov       r5, r59         ; record acch
+  mpyd.p.f r0, r0, r2       ; execute only if positive (N==0)
+  lr        r2, [status32]  ; take a snapshot of statu32 as is
+  check_V_is_set r2
+  cmp       r1, 0x1337
+  bne       @fail
+  cmp       r0, 0xc0de
+  bne       @fail
+  check_64bit_result r5, r4, r59, r58
+
+; Test case 31
+; Raise an Illegal Instruction exception if an odd register as dest.
+  prep_test_case
+  set_except_params @test_31_exception, @test_31_end
+test_31_exception:
+  mpydu r1, r4, r0
+  b     @fail
+test_31_end:
+  ; Fall through
+
+; Test case 32
+; Raise an Illegal Instruction exception if an odd register as dest.
+; The exception should be made even if the CC indicates no execution.
+  prep_test_case
+  set_except_params @test_32_exception, @test_32_end
+  add.f   0,0,1         ; (Z,N,C,V)=(0,0,0,0)
+test_32_exception:
+  mpydu.v r5, r5, r4
+  b       @fail
+test_32_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [test_nr]
+  print_number r0
+  print "[FAIL]"
+1:
+  print " mpyd: mpyd mpydu\n"
+  end
diff --git a/tests/tcg/arc/check_mpyw.S b/tests/tcg/arc/check_mpyw.S
new file mode 100644
index 0000000000..091ee98975
--- /dev/null
+++ b/tests/tcg/arc/check_mpyw.S
@@ -0,0 +1,41 @@
+.include "macros.inc"
+
+
+.macro mul_test val1, val2, res, test_num
+  mov    r0, \val1
+  mov    r1, \val2
+  mpyw   r2, r0, r1
+  assert_eq \res, r2, \test_num
+.endm
+
+
+.macro mul_flags_test val1, val2, res, z=0, n=0, v=0, test_num
+  mov    r0, \val1
+  mov    r1, \val2
+  mpyw.f r2, r0, r1
+  assert_eq   \res, r2, \test_num
+  assert_flag REG_STAT_Z, \z, \test_num
+  assert_flag REG_STAT_N, \n, \test_num
+  assert_flag REG_STAT_C,  0, \test_num
+  assert_flag REG_STAT_V, \v, \test_num
+.endm
+
+start
+
+; 21 * 2 = 42
+mul_test  21, 2, 42, test_num=1
+
+; make sure only the lower 16 bits are taken into account
+; 0x11220005 * 0x00120020 --> 0x0005 * 0x0020 = 160
+mul_test  0x11220005, 0x00120020, 160, test_num=2
+
+; testing sign extension and the signed result
+; 0xFFFFFFFF * 0x00000007 --> 0xFFFF (-1) * 0x0007 = 0xFFFFFFF9 (-7)
+mul_test  0xFFFFFFFF, 0x00000007, 0xFFFFFFF9, test_num=3
+
+; testing flags
+mul_flags_test 1337  , 0     , res=0         , z=1, test_num=4
+mul_flags_test 0x7FFF, 0x7FFF, res=0x3FFF0001, v=0, test_num=5
+mul_flags_test 0xFFFF, 0x0C  , res=0xFFFFFFF4, n=1, test_num=6
+
+end
diff --git a/tests/tcg/arc/check_norm.S b/tests/tcg/arc/check_norm.S
new file mode 100644
index 0000000000..4e55b71589
--- /dev/null
+++ b/tests/tcg/arc/check_norm.S
@@ -0,0 +1,40 @@
+.include "macros.inc"
+
+	start
+
+	test_name NORM_1
+	norm r2, 0x0
+	check_r2	0x1f
+
+	test_name NORM_2
+	norm r2, 0x1
+	check_r2	0x1e
+
+	test_name NORM_3
+	norm r2, 0x1fffffff
+	check_r2	0x02
+
+	test_name NORM_4
+	norm r2, 0x3fffffff
+	check_r2	0x01
+
+	test_name NORM_5
+	norm r2, 0x7fffffff
+	check_r2	0x00
+
+	test_name NORM_6
+	norm r2, 0x80000000
+	check_r2	0x00
+
+	test_name NORM_8
+	norm r2, 0xc0000000
+	check_r2	0x01
+
+	test_name NORM_9
+	norm r2, 0xe0000000
+	check_r2	0x02
+
+	test_name NORM_10
+	norm r2, 0xffffffff
+	check_r2	0x1f
+	end
diff --git a/tests/tcg/arc/check_orx.S b/tests/tcg/arc/check_orx.S
new file mode 100644
index 0000000000..c7a96b4edb
--- /dev/null
+++ b/tests/tcg/arc/check_orx.S
@@ -0,0 +1,34 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# or.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+  TEST_IMM_OP( 2, or, 0xffffffffffffff0f, 0xffffffffff00ff00, 0xf0f );
+  TEST_IMM_OP( 3, or, 0x000000000ff00ff0, 0x000000000ff00ff0, 0x0f0 );
+  TEST_IMM_OP( 4, or, 0x0000000000ff07ff, 0x0000000000ff00ff, 0x70f );
+  TEST_IMM_OP( 5, or, 0xfffffffff00ff0ff, 0xfffffffff00ff00f, 0x0f0 );
+  TEST_RR_3OP( 6, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
+  TEST_RR_3OP( 7, or, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
+  TEST_RR_3OP( 8, or, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );
+  TEST_RR_3OP( 9, or, 0xf0fff0ff, 0xf00ff00f, 0xf0f0f0f0 );
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+
+  TEST_IMM_SRC1_EQ_DEST( 10, or, 0xff00fff0, 0xff00ff00, 0x0f0 );
+  TEST_RR_SRC1_EQ_DEST( 11, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
+  TEST_RR_SRC2_EQ_DEST( 12, or, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
+  TEST_RR_SRC12_EQ_DEST( 13, or, 0xff00ff00, 0xff00ff00 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_prefetch.S b/tests/tcg/arc/check_prefetch.S
new file mode 100644
index 0000000000..3eb9900de0
--- /dev/null
+++ b/tests/tcg/arc/check_prefetch.S
@@ -0,0 +1,37 @@
+#*****************************************************************************
+# prefetch
+#-----------------------------------------------------------------------------
+#
+# This test verifies that prefetch works as expected
+#
+
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  # testing the decoding
+  TEST_CASE( 2, r0, 0x00000000, "prefetch:2", prefetch    [0x12]`      mov r0, 0x0)
+  TEST_CASE( 3, r0, 0x00000000, "prefetch:3", prefetchw   [0x12]`      mov r0, 0x0)
+  TEST_CASE( 4, r0, 0x00000000, "prefetch:4", prefetchw   [r1, r2]`    mov r0, 0x0)
+  TEST_CASE( 5, r0, 0x00000000, "prefetch:5", prefetchw   [0x12, 0x1]` mov r0, 0x0)
+  TEST_CASE( 6, r0, 0x00000000, "prefetch:6", prefetch    [r1, r2]`    mov r0, 0x0)
+  TEST_CASE( 7, r0, 0x00000000, "prefetch:7", prefetch    [0x12, 0x1]` mov r0, 0x0)
+
+	mov	r13, @tdat
+	TEST_CASE( 8, r0, 0x00000004, "prefetch:8", prefetch    [r13]`       ld r0,[r13])
+	TEST_CASE( 9, r0, 0x40000000, "prefetch:9", prefetch.aw [r13,4]`     ld r0,[r13])
+	TEST_CASE(10, r0, 0x40400000, "prefetch:10", prefetch.ab [r13,4]`     ld r0,[r13])
+
+ARCTEST_END
+#  TEST_DATA
+
+tdat:
+.word 0x00000004
+.word 0x40000000
+.word 0x40400000
+.word 0xc0800000
+.word 0xdeadbeef
+.word 0xcafebabe
+.word 0xabad1dea
+.word 0x1337d00d
diff --git a/tests/tcg/arc/check_rolx.S b/tests/tcg/arc/check_rolx.S
new file mode 100644
index 0000000000..4f2d939f69
--- /dev/null
+++ b/tests/tcg/arc/check_rolx.S
@@ -0,0 +1,47 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# check_rolx.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+# .-------------.----------.--------------.
+# | instruction | check CC | update flags |
+# |-------------+----------+--------------|
+# | rol         | no       | Z, N, C      |
+# | rol8        | no       | Z, N         |
+# `-------------^----------^--------------'
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+  TEST_RR_2OP(2, rol , 0xbd5b7ddf, 0xdeadbeef);
+  TEST_RR_2OP(3, rol8, 0x00000001, 0x01000000);
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+  TEST_RR_2OP_SRC1_EQ_DEST(4, rol,  0x94001009, 0xca000804);
+
+  #-------------------------------------------------------------
+  # Flag tests
+  #-------------------------------------------------------------
+  TEST_1OP_CARRY   ( 5, rol , 0, 0x40000000);
+  TEST_1OP_CARRY   ( 6, rol , 1, 0x80000000);
+  TEST_1OP_ZERO    ( 8, rol , 0, 0x00001000);
+  TEST_1OP_ZERO    ( 9, rol , 1, 0x00000000);
+  TEST_1OP_NEGATIVE(10, rol , 0, 0x80000000);
+  TEST_1OP_NEGATIVE(11, rol , 1, 0x40000000);
+  #rol8 does not update carry
+  TEST_1OP_CARRY   (12, rol8, 0, 0x000000ff);
+  TEST_1OP_ZERO    (13, rol8, 0, 0x00001000);
+  TEST_1OP_ZERO    (14, rol8, 1, 0x00000000);
+  TEST_1OP_NEGATIVE(15, rol8, 0, 0x00000040);
+  TEST_1OP_NEGATIVE(16, rol8, 1, 0x00800000);
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_rorx.S b/tests/tcg/arc/check_rorx.S
new file mode 100644
index 0000000000..2634e4e4a5
--- /dev/null
+++ b/tests/tcg/arc/check_rorx.S
@@ -0,0 +1,64 @@
+#define ARCTEST_ARC32
+
+#*****************************************************************************
+# check_rorx.S
+#-----------------------------------------------------------------------------
+#
+# Test or instruction.
+#
+# .--------------.----------.--------------.
+# | instruction  | check CC | update flags |
+# |--------------+----------+--------------|
+# | ror          | no       | Z, N, C      |
+# | ror multiple | yes      | Z, N, C      |
+# | ror8         | no       | Z, N         |
+# `--------------^----------^--------------'
+
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+  TEST_RR_3OP( 2, ror , 0xdeadbeef, 0xdeadbeef, 0x00000000);
+  TEST_RR_3OP( 3, ror , 0x00000001, 0x00000001, 0x00000000);
+  TEST_RR_3OP( 4, ror , 0x80000000, 0x80000000, 0x00000000);
+  TEST_RR_3OP( 5, ror , 0xbd5b7ddf, 0xdeadbeef, 0x0000001f);
+  TEST_RR_3OP( 6, ror , 0x00000002, 0x00000001, 0x0000001f);
+  TEST_RR_3OP( 7, ror , 0x00000001, 0x80000000, 0x0000001f);
+  TEST_RR_2OP( 8, ror , 0x80000000, 0x00000001);
+  TEST_RR_2OP( 9, ror , 0xdeadbeef, 0xbd5b7ddf);
+  TEST_RR_2OP(10, ror8, 0x01000000, 0x00000001);
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+  TEST_RR_SRC1_EQ_DEST    (11, ror,  0xca000804, 0x000804ca, 0xfff80008);
+  TEST_RR_2OP_SRC1_EQ_DEST(12, ror,  0x80040265, 0x000804cb);
+
+  #-------------------------------------------------------------
+  # Flag tests
+  #-------------------------------------------------------------
+  TEST_2OP_CARRY   (13, ror , 0, 0x00000001, 0x02);
+  TEST_2OP_CARRY   (14, ror , 1, 0x00000001, 0x01);
+  TEST_2OP_ZERO    (15, ror , 0, 0x00000100, 0xbf);
+  TEST_2OP_ZERO    (16, ror , 1, 0x00000000, 0xbf);
+  TEST_2OP_NEGATIVE(17, ror , 0, 0x00000001, 0x02);
+  TEST_2OP_NEGATIVE(18, ror , 1, 0x80000000, 0x00);
+  TEST_2OP_CARRY   (19, ror , 1, 0x000000ff, 0x08);
+  TEST_1OP_CARRY   (20, ror , 0, 0x00000002);
+  TEST_1OP_CARRY   (21, ror , 1, 0x00000001);
+  TEST_1OP_ZERO    (22, ror , 0, 0x00000100);
+  TEST_1OP_ZERO    (23, ror , 1, 0x00000000);
+  TEST_1OP_NEGATIVE(24, ror , 0, 0x80000000);
+  TEST_1OP_NEGATIVE(25, ror , 1, 0x00000001);
+  TEST_1OP_CARRY   (26, ror , 1, 0x80000001);
+  #ror8 does not update carry
+  TEST_1OP_CARRY   (27, ror8, 0, 0x000000ff);
+  TEST_1OP_ZERO    (28, ror8, 0, 0x00001000);
+  TEST_1OP_ZERO    (29, ror8, 1, 0x00000000);
+  TEST_1OP_NEGATIVE(30, ror8, 0, 0x00000040);
+  TEST_1OP_NEGATIVE(31, ror8, 1, 0x00000080);
+
+ARCTEST_END
diff --git a/tests/tcg/arc/check_rtc.S b/tests/tcg/arc/check_rtc.S
new file mode 100644
index 0000000000..cb8a6ead9f
--- /dev/null
+++ b/tests/tcg/arc/check_rtc.S
@@ -0,0 +1,29 @@
+	.include "macros.inc"
+
+;;; Simple RTC test, read RTC value if it exists, spend some time, and
+;;; re-read it. Fail if the value is the same..data
+test_nr:
+  .word 0x0
+
+	start
+	test_name RTC
+	lr	r0,[timer_build]
+	and.f	0,r0,0x400
+	beq	@.lfail
+	sr	1,[0x103]
+	lr	r2,[0x104]
+.loop:
+	sub.f	r0,r0,1
+	bnz	@.loop
+	lr	r0,[0x104]
+	breq	r0,r2,@.lfail
+	print	"[PASS] "
+	b @1f
+
+.lfail:
+	ld r0, [test_nr]
+	;print_number r0
+	print "[FAIL] "
+1:
+	printl r30
+	end
diff --git a/tests/tcg/arc/check_rtie_user.S b/tests/tcg/arc/check_rtie_user.S
new file mode 100644
index 0000000000..b29618a6ac
--- /dev/null
+++ b/tests/tcg/arc/check_rtie_user.S
@@ -0,0 +1,30 @@
+  .include "macros.inc"
+
+  start
+  enter_user_mode @user_mode
+
+user_mode:
+  nop
+  ; must cause privilege violation exception
+faulty:
+  rtie
+
+good:
+  print "You're on a righteous path.\n"
+  end
+
+  .align 4
+  .global EV_PrivilegeV
+  .type EV_PrivilegeV, @function
+EV_PrivilegeV:
+  lr r0, [eret]
+  brne r0, @faulty, @sucks
+  lr r0, [efa]
+  brne r0, @faulty, @sucks
+  mov r0, @good
+  sr  r0, [eret]
+  rtie
+
+sucks:
+  print "Life sucks. Get over it!\n"
+  end
diff --git a/tests/tcg/arc/check_stld.S b/tests/tcg/arc/check_stld.S
new file mode 100644
index 0000000000..3817678b98
--- /dev/null
+++ b/tests/tcg/arc/check_stld.S
@@ -0,0 +1,10 @@
+.include "macros.inc"
+
+	start
+
+	test_name STLD_1
+	st	-32,[0x10000]
+	ld 	r2,[0x10000]
+	check_r2	-32
+
+	end
diff --git a/tests/tcg/arc/check_subf.S b/tests/tcg/arc/check_subf.S
new file mode 100644
index 0000000000..10b98e803b
--- /dev/null
+++ b/tests/tcg/arc/check_subf.S
@@ -0,0 +1,67 @@
+.include "macros.inc"
+
+.macro validate res, actual, z, n, c, v, test_num
+  assert_eq   \res, \actual, \test_num
+  assert_flag REG_STAT_Z, \z, \test_num
+  assert_flag REG_STAT_N, \n, \test_num
+  assert_flag REG_STAT_C, \c, \test_num
+  assert_flag REG_STAT_V, \v, \test_num
+.endm
+
+.macro sub0_flags_test val1, val2, res, z=0, n=0, c=0, v=0, test_num=1
+  mov    r0, \val1
+  mov    r1, \val2
+  sub.f  r2, r0, r1
+  validate  \res, r2, \z, \n, \c, \v, \test_num
+.endm
+
+.macro sub1_flags_test val1, val2, res, z=0, n=0, c=0, v=0, test_num=1
+  mov    r0, \val1
+  mov    r1, \val2
+  sub1.f r2, r0, r1
+  validate  \res, r2, \z, \n, \c, \v, \test_num
+.endm
+
+.macro sub2_flags_test val1, val2, res, z=0, n=0, c=0, v=0, test_num=1
+  mov    r0, \val1
+  mov    r1, \val2
+  sub2.f r2, r0, r1
+  validate  \res, r2, \z, \n, \c, \v, \test_num
+.endm
+
+.macro sub3_flags_test val1, val2, res, z=0, n=0, c=0, v=0, test_num=1
+  mov    r0, \val1
+  mov    r1, \val2
+  sub3.f r2, r0, r1
+  validate  \res, r2, \z, \n, \c, \v, \test_num
+.endm
+
+
+start
+
+sub0_flags_test 0xA0000000, 0xB0000000, 0xF0000000, z=0, n=1, c=1, v=0, test_num=0x01
+sub1_flags_test 0xA0000000, 0x58000000, 0xF0000000, z=0, n=1, c=1, v=0, test_num=0x02
+sub2_flags_test 0xA0000000, 0x2C000000, 0xF0000000, z=0, n=1, c=1, v=0, test_num=0x03
+sub3_flags_test 0xA0000000, 0x16000000, 0xF0000000, z=0, n=1, c=1, v=0, test_num=0x04
+
+sub0_flags_test 0xFFFFFF80, 0xF0000000, 0x0FFFFF80, z=0, n=0, c=0, v=0, test_num=0x05
+sub1_flags_test 0xFFFFFF80, 0x78000000, 0x0FFFFF80, z=0, n=0, c=0, v=0, test_num=0x06
+sub2_flags_test 0xFFFFFF80, 0x3C000000, 0x0FFFFF80, z=0, n=0, c=0, v=0, test_num=0x07
+sub3_flags_test 0xFFFFFF80, 0x1E000000, 0x0FFFFF80, z=0, n=0, c=0, v=0, test_num=0x08
+
+sub0_flags_test 0x80000000, 0x80000000, 0x00000000, z=1, n=0, c=0, v=0, test_num=0x09
+sub1_flags_test 0x80000000, 0x40000000, 0x00000000, z=1, n=0, c=0, v=0, test_num=0x10
+sub2_flags_test 0x80000000, 0x20000000, 0x00000000, z=1, n=0, c=0, v=0, test_num=0x11
+sub3_flags_test 0x80000000, 0x10000000, 0x00000000, z=1, n=0, c=0, v=0, test_num=0x12
+
+sub0_flags_test 0x80000000, 0xC0000000, 0xC0000000, z=0, n=1, c=1, v=0, test_num=0x13
+sub1_flags_test 0x80000000, 0x60000000, 0xC0000000, z=0, n=1, c=1, v=0, test_num=0x14
+sub2_flags_test 0x80000000, 0x30000000, 0xC0000000, z=0, n=1, c=1, v=0, test_num=0x15
+sub3_flags_test 0x80000000, 0x18000000, 0xC0000000, z=0, n=1, c=1, v=0, test_num=0x16
+
+sub0_flags_test 0x80000000, 0x00000008, 0x7FFFFFF8, z=0, n=0, c=0, v=1, test_num=0x17
+sub1_flags_test 0x80000000, 0x00000004, 0x7FFFFFF8, z=0, n=0, c=0, v=1, test_num=0x18
+sub2_flags_test 0x80000000, 0x00000002, 0x7FFFFFF8, z=0, n=0, c=0, v=1, test_num=0x19
+sub3_flags_test 0x80000000, 0x00000001, 0x7FFFFFF8, z=0, n=0, c=0, v=1, test_num=0x20
+
+end
diff --git a/tests/tcg/arc/check_subx.S b/tests/tcg/arc/check_subx.S
new file mode 100644
index 0000000000..7e4c4b1009
--- /dev/null
+++ b/tests/tcg/arc/check_subx.S
@@ -0,0 +1,43 @@
+#*****************************************************************************
+# sub.S
+#-----------------------------------------------------------------------------
+#
+# Test sub instruction.
+#
+
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+
+  #-------------------------------------------------------------
+  # Arithmetic tests
+  #-------------------------------------------------------------
+
+  TEST_RR_3OP( 2,  sub, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
+  TEST_RR_3OP( 3,  sub, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
+  TEST_RR_3OP( 4,  sub, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );
+
+  TEST_RR_3OP( 5,  sub, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
+  TEST_RR_3OP( 6,  sub, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
+  TEST_RR_3OP( 7,  sub, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );
+
+  TEST_RR_3OP( 8,  sub, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
+  TEST_RR_3OP( 9,  sub, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
+  TEST_RR_3OP( 10, sub, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );
+
+  TEST_RR_3OP( 11, sub, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
+  TEST_RR_3OP( 12, sub, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );
+
+  TEST_RR_3OP( 13, sub, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
+  TEST_RR_3OP( 14, sub, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
+  TEST_RR_3OP( 15, sub, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+
+  TEST_RR_SRC1_EQ_DEST( 16, sub, 2, 13, 11 );
+  TEST_RR_SRC2_EQ_DEST( 17, sub, 3, 14, 11 );
+  TEST_RR_SRC12_EQ_DEST( 18, sub, 0, 13 );
+ARCTEST_END
diff --git a/tests/tcg/arc/check_swi.S b/tests/tcg/arc/check_swi.S
new file mode 100644
index 0000000000..6786807acd
--- /dev/null
+++ b/tests/tcg/arc/check_swi.S
@@ -0,0 +1,115 @@
+  .include "macros.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; exception facilitators
+  .align 4
+ecr_ref    : .word 0x0
+efa_ref    : .word 0x0
+eret_ref   : .word 0x0
+cont_addr  : .word 0x0
+test_number: .word 0x0
+
+; macro:      set_excep_params
+; regs used:  r11
+;
+; this macro writes the provided parameters to a temporary place holder
+; later it will be used by SWI exception routine as a reference
+.macro set_excep_params ecr, efa, eret, continue, test_num
+  mov  r11, \ecr
+  st   r11, [ecr_ref]
+  mov  r11, \efa
+  st   r11, [efa_ref]
+  mov  r11, \eret
+  st   r11, [eret_ref]
+  mov  r11, \continue
+  st   r11, [cont_addr]
+  mov  r11, \test_num
+  st   r11, [test_number]
+.endm
+
+; exception: software interrupt
+; regs used: r11, r12
+;
+; this is a parameterized SWI exception that will check the followings:
+; ecr   == ecr_ref
+; efa   == efa_ref
+; eret  == eret_ref
+; if everything passes, it will jump to 'cont_addr' parameter.
+; the parameters must be set beforehand using 'set_except_params' macro.
+; last but not least, this requires ivt.S file to be compiled and linked.
+  .align 4
+  .global EV_SWI
+  .type EV_SWI, @function
+EV_SWI:
+  ld   r11, [ecr_ref]
+  lr   r12, [ecr]
+  brne r12, r11, @exc_fail
+  ld   r11, [eret_ref]
+  lr   r12, [eret]
+  brne r12, r11, @exc_fail
+  ld   r11, [efa_ref]
+  lr   r12, [efa]
+  brne r12, r11, @exc_fail
+  ; going back to the given address
+  ld   r11, [cont_addr]
+  sr   r11, [eret]
+  rtie
+exc_fail:
+	ld   r11, [test_number]
+	print "[FAIL] "
+  print_number r11
+  print ": exception is not sane!\n"
+  end
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; let the test code begin
+  start
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; check swi_s with no argument
+test01:
+  set_excep_params ecr      = SOFTWARE_INTERRUPT, \
+                   efa      = @test01_swis_addr , \
+                   eret     = @test01_swis_addr , \
+                   continue = @test02           , \
+                   test_num = 0x01
+
+test01_swis_addr:
+  swi_s
+
+  assert_eq 0, 1, 1          ; exception must have been raised
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; check swi_s with a u6 immediate
+test02:
+  .equ INTERRUPT_NUM  , 42
+  .equ TEST02_EXCP_REF, SOFTWARE_INTERRUPT | INTERRUPT_NUM
+  set_excep_params ecr      = TEST02_EXCP_REF,\
+                   efa      = @test02_swis_addr , \
+                   eret     = @test02_swis_addr , \
+                   continue = @test03           , \
+                   test_num = 0x02
+
+test02_swis_addr:
+  swi_s INTERRUPT_NUM
+
+  assert_eq 0, 1, 2          ; exception must have been raised
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+; check swi
+test03:
+  set_excep_params ecr      = SOFTWARE_INTERRUPT, \
+                   efa      = @test03_swi_addr  , \
+                   eret     = @test03_swi_addr  , \
+                   continue = @finish           , \
+                   test_num = 0x01
+
+test03_swi_addr:
+  swi
+
+  assert_eq 0, 1, 3          ; exception must have been raised
+
+
+finish:
+  print "[PASS] Software Interrupt\n"
+  end
diff --git a/tests/tcg/arc/check_swirq.S b/tests/tcg/arc/check_swirq.S
new file mode 100644
index 0000000000..f3fb69d1ed
--- /dev/null
+++ b/tests/tcg/arc/check_swirq.S
@@ -0,0 +1,27 @@
+	.include "macros.inc"
+
+	start
+	;; 	print "Start\n"
+	mov	sp, 0x1000
+	seti
+	sr	18, [aux_irq_hint]
+	print "[PASS] SW-IRQ:End\n"
+	end
+
+	/* The delay between writing to the AUX_IRQ_HINT register and
+	the interrupt being taken is implementation specific.  Hence,
+	we need to save/restore any clobber register by ISR.  */
+	.align 4
+	.global IRQ_18
+	.type IRQ_18, @function
+IRQ_18:
+	clri
+	push	r11
+	push	r12
+	sr	0, [aux_irq_hint]
+	print "[PASS] SW-IRQ:IRQ\n"
+	pop	r12
+	pop	r11
+	rtie
+	print "[FAIL] SW-IRQ\n"
+	end
diff --git a/tests/tcg/arc/check_swirq1.S b/tests/tcg/arc/check_swirq1.S
new file mode 100644
index 0000000000..ca8e301dd3
--- /dev/null
+++ b/tests/tcg/arc/check_swirq1.S
@@ -0,0 +1,31 @@
+	.include "macros.inc"
+
+	start
+	;; print	"Check normal IRQ functioning.\n"
+	;; Set the stack somewhere
+	mov	sp, 0x1000
+	;; Use IRQ18 for the test, change to a level 1, irq so we can
+	;; avoid firq.
+	sr	18,[REG_IRQ_SELECT]
+	sr	1,[irq_priority]
+  set_interrupt_prio_level 1
+	sr	16,[aux_irq_ctrl]
+	;; Enable the interrupt system, and trigger the IRQ 18.
+	seti
+	sr	18, [aux_irq_hint]
+	print "[PASS] IRQ:End\n"
+	end
+
+	/* The delay between writing to the AUX_IRQ_HINT register and
+	the interrupt being taken is implementation specific.  Hence,
+	we need to save/restore any clobber register by ISR.  */
+	.align 4
+	.global IRQ_18
+	.type IRQ_18, @function
+IRQ_18:
+	clri
+	sr	0, [aux_irq_hint]
+	print "[PASS] IRQ:IRQ\n"
+	rtie
+	print "[FAIL] IRQ\n"
+	end
diff --git a/tests/tcg/arc/check_swirq3.S b/tests/tcg/arc/check_swirq3.S
new file mode 100644
index 0000000000..2aa5bb8d82
--- /dev/null
+++ b/tests/tcg/arc/check_swirq3.S
@@ -0,0 +1,49 @@
+	.include "macros.inc"
+
+	start
+;;; 	print "Check if an IRQ gets re-trigger while in ISR:"
+	;; Set the stack somewhere
+	mov	sp, 0x1000
+	seti
+	mov	r0,0
+	;; Use IRQ18 for the test.
+	sr	18, [AUX_IRQ_HINT]
+	;; wait (sleep doesn't work as expected because all the irq
+	;; are triggered BEFORE sleep is even fetch/executed.
+.llocal00:
+	breq	r0, 0, @.llocal00
+	brlt	r0, 2, @.failMe
+	print "[PASS] SW-IRQ3\n"
+	end
+.failMe:
+	print "[PASS] SW-IRQ3\n"
+	end
+
+	/* The delay between writing to the AUX_IRQ_HINT register and
+	the interrupt being taken is implementation specific.  Hence,
+	we need to save/restore any clobber register by ISR.  */
+	.align 4
+	.global IRQ_18
+	.type IRQ_18, @function
+IRQ_18:
+#define AUX_IRQ_SELECT  0x40b
+#define AUX_IRQ_ENABLE  0x40c
+	clri
+	add	r0,r0,1
+        mov     r1, AUX_IRQ_SELECT
+        mov     r2, AUX_IRQ_ENABLE
+	;; clean the IRQ
+        sr      18, [r1]
+        sr      0, [r2]
+	sr	0, [AUX_IRQ_HINT]
+	brgt	r0,1,@.extisr
+	;; retrigger the irq
+	sr	18, [AUX_IRQ_HINT]
+        sr      18, [r1]
+        sr      1, [r2]
+	;; 	print " SW-IRQ 0,"
+	rtie
+.extisr:
+	;; 	print " SW-IRQ 1,"
+	rtie
+	end
diff --git a/tests/tcg/arc/check_t01.S b/tests/tcg/arc/check_t01.S
new file mode 100644
index 0000000000..c6cb9d0052
--- /dev/null
+++ b/tests/tcg/arc/check_t01.S
@@ -0,0 +1,12 @@
+	.include "macros.inc"
+
+	start
+	test_name LOOP_1
+	mov	r2, 4
+.L1:
+	sub_s	r2,r2,1
+	tst_s	r2,r2
+	bne	@.L1
+	check_r2	0x0
+
+	end
diff --git a/tests/tcg/arc/check_t02.S b/tests/tcg/arc/check_t02.S
new file mode 100644
index 0000000000..1567bfe1d4
--- /dev/null
+++ b/tests/tcg/arc/check_t02.S
@@ -0,0 +1,9 @@
+	.include "macros.inc"
+	start
+	test_name PREDICATE_1
+	mov	r2,2
+	lsr.f	r2,r2
+	mov.nc	r2,1
+	mov.cs	r2,-1	# Should not execute
+	check_r2	0x01
+	end
diff --git a/tests/tcg/arc/check_timer0.S b/tests/tcg/arc/check_timer0.S
new file mode 100644
index 0000000000..f2afa83200
--- /dev/null
+++ b/tests/tcg/arc/check_timer0.S
@@ -0,0 +1,36 @@
+	.include "macros.inc"
+
+	start
+	test_name TIMER0
+	sr	0,[count0]
+	print	 "......"
+	lr 	r2,[count0]
+	breq	r2, 0, @.lfail
+	print	"X"
+	lr	r0,[count0]
+	breq	r0,r2,@.lfail
+	print	"Pass\n"
+	sr	0x01,[control0]
+	mov	r0, 0xffff
+	sr	r0,[limit0]
+	sr	0,[count0]
+	mov	r3, 0
+	seti
+.loop0:
+	breq	r3, 0, @.loop0
+	print	"The end\n"
+	end
+.lfail:
+	print	"Fail\n"
+	end
+
+	.align 4
+	.global IRQ_Timer0
+	.type IRQ_Timer0, @function
+IRQ_Timer0:
+	clri
+	sr	0x00,[control0]
+	print "Pass IRQ\n"
+	mov	r3, 1
+	rtie
+	end
diff --git a/tests/tcg/arc/check_timer0_loop.S b/tests/tcg/arc/check_timer0_loop.S
new file mode 100644
index 0000000000..a1910a02ae
--- /dev/null
+++ b/tests/tcg/arc/check_timer0_loop.S
@@ -0,0 +1,34 @@
+	.include "macros.inc"
+
+	start
+	test_name TIMER0
+	;; enable TIMER0 interrupts
+	sr	0x01,[control0]
+	mov	r0, 0x1fffff
+	sr	r0,[limit0]
+	sr	0,[count0]
+	;; Now wait for the counter to reach it's limit
+	mov	r0,0
+.loop1:
+	lr	r0,[control0]
+	bbit0	r0,3,@.loop1
+	;; Now enable PIC interrupts, we expect the pending interrupt
+	;; to kick in.
+	mov	r3, 0
+	seti
+.loop0:
+	breq	r3, 0, @.loop0
+	print	"The end\n"
+	end
+
+	.align 4
+	.global IRQ_Timer0
+	.type IRQ_Timer0, @function
+IRQ_Timer0:
+	clri
+	;; reset interrupts
+	sr	0x00,[control0]
+	print "Pass IRQ\n"
+	mov	r3, 1
+	rtie
+	end
diff --git a/tests/tcg/arc/check_timer0_loop3.S b/tests/tcg/arc/check_timer0_loop3.S
new file mode 100644
index 0000000000..c5a1013db4
--- /dev/null
+++ b/tests/tcg/arc/check_timer0_loop3.S
@@ -0,0 +1,46 @@
+
+	.include "macros.inc"
+
+.equ LIMIT,  0x1ff
+
+	start
+	test_name TIMER0
+	;; enable TIMER0 interrupts
+	sr	0x01,[control0]
+	mov	r0, LIMIT
+	sr	r0,[limit0]
+	sr	0,[count0]
+	;; Now wait for the counter to reach it's limit
+	mov	r0,0
+.loop1:
+	lr	r0,[count0]
+	brgt	r0,LIMIT,@.loop0
+	;; Now enable PIC interrupts, we expect the pending interrupt
+	;; to kick in.
+	mov	r3, 0
+	seti
+.loop0:
+	lr	r4,[count0]
+	breq	r3, 1, @.pass
+	brgt	r4,LIMIT,@.fail1
+	j 	@.loop0
+.pass:
+	print	"[PASS]"
+	j	@.end
+.fail1:
+	print   "[FAIL]"
+	;; 	print_number r4
+.end:
+	print	" TIMER0: Overflow\n"
+	end
+
+	.align 4
+	.global IRQ_Timer0
+	.type IRQ_Timer0, @function
+IRQ_Timer0:
+	clri
+	;; reset interrupts
+	sr	0x00,[control0]
+	mov	r3, 1
+	rtie
+	end
diff --git a/tests/tcg/arc/check_timer0_retrig.S b/tests/tcg/arc/check_timer0_retrig.S
new file mode 100644
index 0000000000..f48e09504a
--- /dev/null
+++ b/tests/tcg/arc/check_timer0_retrig.S
@@ -0,0 +1,29 @@
+	.include "macros.inc"
+
+	start
+	test_name TIMER0_RETRIG
+	;; enable TIMER0 interrupts
+	sr	0x01,[control0]
+	mov	r0, 0x1fffff
+	sr	r0,[limit0]
+	sr	0,[count0]
+	;; Now wait for the counter to reach it's limit
+	mov	r0,0
+	seti
+.loop0:
+	brlt	r3, 2, @.loop0
+	print	"[PASS] TIMER0: Re-trigger\n"
+	end
+
+	.align 4
+	.global IRQ_Timer0
+	.type IRQ_Timer0, @function
+IRQ_Timer0:
+	clri
+	;; reset interrupts & enable IRQ
+	sr	0x01,[control0]
+	;; The timer needs to continue counting, and we expect a new
+	;; interrupt soon.
+	add	r3, r3, 1
+	rtie
+	end
diff --git a/tests/tcg/arc/check_timer0_sleep.S b/tests/tcg/arc/check_timer0_sleep.S
new file mode 100644
index 0000000000..87b58fcc78
--- /dev/null
+++ b/tests/tcg/arc/check_timer0_sleep.S
@@ -0,0 +1,33 @@
+  .include "macros.inc"
+
+  start
+
+  ; enable TIMER0 interrupts
+  sr  0x01,[control0]
+  mov r0, 0x5ffff
+  sr  r0,[limit0]
+  sr  0,[count0]
+  mov r3, 0
+  seti
+
+  sleep
+
+  breq  r3, 1, @.passMe
+  print "[FAIL]"
+  b @.endtest
+.passMe:
+  print "[PASS]"
+.endtest:
+  print " TIMER0: sleep irq\n"
+  end
+
+  .align 4
+  .global IRQ_Timer0
+  .type IRQ_Timer0, @function
+IRQ_Timer0:
+  clri
+  ; reset interrupts
+  sr  0x00,[control0]
+  mov r3, 1
+  rtie
+  end
diff --git a/tests/tcg/arc/check_timerX_freq.S b/tests/tcg/arc/check_timerX_freq.S
new file mode 100644
index 0000000000..606c3ca82d
--- /dev/null
+++ b/tests/tcg/arc/check_timerX_freq.S
@@ -0,0 +1,87 @@
+	.include "macros.inc"
+
+	start
+	test_name TIMER0vsTIMER1
+	;; enable TIMER0 interrupts
+	sr	0x01,[control0]
+	mov	r0, 0x1ffff
+	sr	r0,[limit0]
+	sr	0,[count0]
+
+	;; enable TIMER1 interrupts
+	sr	0x01,[control1]
+	mov	r0, 0x3fffe	;Twice slower
+	sr	r0,[limit1]
+	sr	0,[count1]
+	mov	r4,0
+	mov	r5,0
+	mov	sp,0x1000
+	seti
+	mov	r3, 0
+.loop:
+	sleep
+	add	r3,r3,1
+	brne	r3,10,@.loop
+	clri
+	stb.ab	0,[sp,1]
+	mov	r0,r4
+.L02:
+	rem	r2,r0,10
+	add	r2,r2,0x30
+	stb.ab	r2,[sp,1]
+	div.f	r0,r0,10
+	bne	@.L02
+.L03:
+	ld.aw	r2,[sp,-1]
+	breq	r2,0,@.L04
+	;; 	stb	r2,[OUTPUT_DEVICE]
+	brne	r2,0,@.L03
+.L04:
+
+	;; print	">>>"
+	stb.ab	0,[sp,1]
+	mov	r0,r5
+.L12:
+	rem	r2,r0,10
+	add	r2,r2,0x30
+	stb.ab	r2,[sp,1]
+	div.f	r0,r0,10
+	bne	@.L12
+.L13:
+	ld.aw	r2,[sp,-1]
+	breq	r2,0,@.L14
+	;; 	stb	r2,[OUTPUT_DEVICE]
+	brne	r2,0,@.L13
+.L14:
+	breq	r5, 0, @.failMe
+	brgt	r4,r5, @.passMe
+.failMe:
+	print	"[FAIL] "
+	b	1f
+.passMe:
+	print	"[PASS] "
+1:
+	printl	r30
+	end
+
+	.align 4
+	.global IRQ_Timer0
+	.type IRQ_Timer0, @function
+IRQ_Timer0:
+	clri
+	;; reset interrupts
+	sr	0x01,[control0]
+	sr	0,[count0]
+	add	r4,r4,1
+	rtie
+
+	.global IRQ_Timer1
+	.type IRQ_Timer1, @function
+IRQ_Timer1:
+	clri
+	;; reset interrupts
+	sr	0x01,[control1]
+	sr	0,[count1]
+	add	r5,r5,1
+	rtie
+	end
diff --git a/tests/tcg/arc/check_vadd.S b/tests/tcg/arc/check_vadd.S
new file mode 100644
index 0000000000..39ceac3743
--- /dev/null
+++ b/tests/tcg/arc/check_vadd.S
@@ -0,0 +1,510 @@
+; check_vadd.S
+;
+; Tests for vadd: vadd2 vadd2h vadd4h
+; If the test fails, check the end of this file for how to troubleshoot.
+
+  .include "macros.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;; Test checking routines ;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case counter
+.data
+test_nr:
+  .word 0x0
+
+; Increment the test counter and set (Z,N,C,V) to (0,0,0,0).
+.macro prep_test_case
+  ld    r13, [test_nr]
+  add_s r13, r13, 1       ; increase test case counter
+  st    r13, [test_nr]
+  add.f 0, 0, 1           ; (Z, N, C, V) = (0, 0, 0, 0)
+.endm
+
+; Checks if (Z,N,C,V) == (0,0,0,0). This relies on "ADD.F 0,0,1"
+; instruction in PREP_TEST_CASE macro. From a PREP_TEST_CASE macro
+; in a test case, and thence to a VECTOR instruction and finally to
+; this macro, none of the aforementioned flags must have been set,
+; because VECTOR instructions aren't supposed to do so.
+.macro  check_flags_remained_zero
+  lr    r11, [status32]
+  mov   r12, REG_STAT_Z
+  or    r12, r12, REG_STAT_N
+  or    r12, r12, REG_STAT_C
+  or    r12, r12, REG_STAT_V
+  and   r11, r11, r12
+  cmp   r11, 0
+  bne   @fail
+.endm
+
+; pair(HI, LOW) == pair(REG_HI, REG_LO)
+; HI, LO:         32-bit
+; REG_HI, REG_LO: 32-bit
+.macro  check_64bit_double      hi, low, reg_hi, reg_lo
+  check_flags_remained_zero
+  mov   r11, \hi
+  mov   r10, \low
+  cmp   r11, \reg_hi
+  bne   @fail
+  cmp   r10, \reg_lo
+  bne   @fail
+.endm
+
+; REG == (HI, LO)
+; HI, LO: 16-bit
+; REG:    32-bit
+.macro  check_32bit_double      hi, low, reg
+  check_flags_remained_zero
+  mov   r11, \hi
+  and   r11, r11, 0xffff
+  lsl16 r11, r11
+  mov   r12, \low
+  and   r12, r12, 0xffff
+  or    r11, r11, r12
+  cmp   r11, \reg
+  bne   @fail
+.endm
+
+; quartet(q3, q2, q1, q0) == pair64(REG_HI, REG_LO)
+; Q3, Q2, Q1, Q0: 16-bit
+; REG_HI, REG_LO: 32-bit
+.macro  check_64bit_quadruple   q3, q2, q1, q0, reg_hi, reg_lo
+  check_flags_remained_zero
+  mov   r11, \q3
+  and   r11, r11, 0xffff
+  lsl16 r11, r11
+  mov   r12, \q2
+  and   r12, r12, 0xffff
+  or    r11, r11, r12
+  mov   r10, \q1
+  and   r10, r10, 0xffff
+  lsl16 r10, r10
+  mov   r12, \q0
+  and   r12, r12, 0xffff
+  or    r10, r10, r12
+  cmp   r11, \reg_hi
+  bne   @fail
+  cmp   r10, \reg_lo
+  bne   @fail
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Exception related code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; parameters that an IllegalInstruction exception may set.
+  .align 4
+ecr_ref  : .word ILLEGAL_INSTRUCTION
+addr_ref : .word 0x0                  ; for both eret and efa
+cont_addr: .word 0x0
+
+; exception: IllegalInstruction
+; regs used: r11, r12
+;
+; A parameterized IllegalInstruction exception that checks the followings:
+; ecr  == Illegal instruction
+; efa  == efa_ref
+; eret == eret_ref
+; If everything passes, it will jump to 'cont_addr' parameter. The parameters
+; must be set beforehand using 'set_except_params' macro.  This requires
+; ivt.S file to be compiled and linked.
+  .align 4
+  .global instruction_error
+  .type instruction_error, @function
+instruction_error:
+  ld   r11, [ecr_ref]
+  lr   r12, [ecr]
+  cmp  r12, r11
+  bne  @fail
+  ld   r11, [addr_ref]
+  lr   r12, [eret]
+  cmp  r12, r11
+  bne  @fail
+  lr   r12, [efa]
+  cmp  r12, r11
+  bne  @fail
+  ; Success: continuing
+  ld   r11, [cont_addr]
+  sr   r11, [eret]
+  rtie
+
+; macro:      set_except_params
+; regs used:  r11
+;
+; This macro writes the provided parameters to a temporary place holder
+; that later will be used by exception above to verify as reference.
+.macro set_except_params addr, continue
+  mov  r11, \addr
+  st   r11, [addr_ref]
+  mov  r11, \continue
+  st   r11, [cont_addr]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VADD2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Let the tests begin
+  start
+
+; Test case 1
+; reg2 <- reg2, reg2
+; (0x00000006,0x00000004)=(0x80000003,0x80000002)+(0x80000003,0x80000002)
+; To boot, C and V flags must not be set.
+  prep_test_case
+  mov   r2, 0x80000002
+  mov   r3, 0x80000003
+  vadd2 r2, r2, r2
+  check_64bit_double 0x00000006, 0x00000004, r3, r2
+
+; Test case 2
+; reg0 <- reg2, reg0
+; (4,6)=(1,2)+(3,4)
+  prep_test_case
+  mov   r3, 0x00000001
+  mov   r2, 0x00000002
+  mov   r1, 0x00000003
+  mov   r0, 0x00000004
+  vadd2 r0, r2, r0
+  check_64bit_double 4, 6, r1, r0
+
+; Test case 3
+; reg0 <- limm, reg4
+; (0x00000000,0x00000000)=(0x12345678,0x12345678)+(0xedcba988,0xedcba988)
+; Moreover, Z flag mustn't be set.
+  prep_test_case
+  mov   r0, 0x11111111            ; bogus data
+  mov   r1, 0x22222222            ; bogus data
+  mov   r4, 0xedcba988            ; neg(0x12345678)
+  mov   r5, 0xedcba988            ; neg(0x12345678)
+  vadd2 r0, 0x12345678, r4
+  check_64bit_double 0x00, 0x00, r1, r0
+
+; Test case 4
+; reg4 <- reg2, limm
+; (-3,-2)=(-2,-1)+(-1,-1)
+; The N flag must not be set, irrespective of having negative results.
+  prep_test_case
+  mov   r2, -1
+  mov   r3, -2
+  vadd2 r4, r2, -1
+  check_64bit_double -3, -2, r5, r4
+
+; Test case 5
+; reg2 <- limm, limm  (both limm should be the same)
+; (0x2468acf0,0x2468acf0)=(0x12345678,0x12345678)+(0x12345678,0x12345678)
+  prep_test_case
+  vadd2 r2, 0x12345678, 0x12345678
+  check_64bit_double 0x2468acf0, 0x2468acf0, r3, r2
+
+; Test case 6
+; reg4 <- limm, u6
+; (0x01020343,0x01020343)=(0x01020304,0x01020304)+(0x3f,0x3f)
+  prep_test_case
+  vadd2 r4, 0x01020304, 63
+  check_64bit_double 0x01020343, 0x01020343, r5, r4
+
+; Test case 7
+; reg2 <- reg4, 0(u6)
+; (0x08070605,0x04030201)=(0x08070605,0x04030201)+(0,0)
+  prep_test_case
+  mov   r5, 0x08070605
+  mov   r4, 0x04030201
+  vadd2 r2, r4, 0
+  check_64bit_double 0x08070605, 0x04030201, r3, r2
+
+; Test case 8
+; reg2 <- reg2, s12
+; (3000002048,2000002048)=(3000004096,2000004096)+(-2048,-2048)
+  prep_test_case
+  mov   r3, 3000004096
+  mov   r2, 2000004096
+  vadd2 r2, r2, -2048
+  check_64bit_double 3000002048, 2000002048, r3, r2
+
+; Test case 9
+; 0 <- limm, s12
+; (X,X)=(0xffeeddbb,0xffeeddbb)+(-2048,-2048)
+  prep_test_case
+  vadd2 0, 0xffeeddbb, -2048
+
+; Test case 10
+; Testing when cc condition is met
+; (6,4)=(3,2)+(3,2)
+  prep_test_case
+  mov     r2, 2
+  mov     r3, 3
+  mov     r4, 0x80000000  ; setting...
+  add.f   0,r4,r4         ; ...C=1
+  vadd2.c r2, r2, r2
+  add.f   0,0,1           ; so that CHECK_FLAGS_REMAINED_ZERO won't fail.
+  check_64bit_double 6, 4, r3, r2
+
+; Test case 11
+; Testing when cc condition is not met
+; (2,0)
+  prep_test_case
+  mov     r2, 0
+  mov     r3, 2
+  vadd2.z r2, r2, r2  ; Z=0 because of PREP_TEST_CASE
+  check_64bit_double 2, 0, r3, r2
+
+; Test case 12
+; Raise an Illegal Instruction exception if an odd register is used.
+; Even if there is no register to save the result to.
+  prep_test_case
+  set_except_params @test_12_exception, @test_12_end
+test_12_exception:
+  vadd2 0, r3, r0
+  b     @fail
+test_12_end:
+  ; Fall through
+
+; Test case 13
+; Raise an Illegal Instruction exception if an odd register is used.
+; The exception should be made even if the CC indicates no execution.
+  prep_test_case        ; (Z,N,C,V)=(0,0,0,0)
+  set_except_params @test_13_exception, @test_13_end
+test_13_exception:
+  vadd2.z r5, r5, r0
+  b       @fail
+test_13_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VADD2H ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 14
+; reg1 <- reg1, reg1
+; (0x0006,0x0004)=(0x8003,0x8002)+(0x8003,0x8002)
+; Moreover, the C and V flags are not going to be set.
+  prep_test_case
+  mov    r1, 0x80038002
+  vadd2h r1, r1, r1
+  check_32bit_double 0x0006, 0x0004, r1
+
+; Test case 15
+; reg1 <- reg1, reg3
+; (4,6)=(1,2)+(3,4)
+  prep_test_case
+  mov    r3, 0x00010002
+  mov    r1, 0x00030004
+  vadd2h r1, r1, r3
+  check_32bit_double 4, 6, r1
+
+; Test case 16
+; reg0 <- limm, reg4
+; (0x0000,0x0000)=(0x1234,0x5678)+(0xedcc,0xa988)
+; The Z flag must not be set.
+  prep_test_case
+  mov    r0, 0x11112222           ; bogus data
+  mov    r4, 0xedcca988           ; (neg(0x1234),neg(0x5678))
+  vadd2h r0, 0x12345678, r4
+  check_32bit_double 0x0000, 0x0000, r0
+
+; Test case 17
+; reg5 <- reg3, limm
+; (-3,-2)=(-2,-1)+(-1,-1)
+; The N flag mustn't be set, irrespective of having negative results.
+  prep_test_case
+  mov    r3, 0xfffeffff           ; (-2,-1)
+  vadd2h r5, r3, -1
+  check_32bit_double -3, -2, r5
+
+; Test case 18
+; reg1 <- limm, limm  (both limm should be the same)
+; (0x2468,0xacf0)=(0x1234,0x5678)+(0x1234,0x5678)
+  prep_test_case
+  vadd2h r1, 0x12345678, 0x12345678
+  check_32bit_double 0x2468, 0xacf0, r1
+
+; Test case 19
+; reg0 <- limm, u6
+; (0x0141,0x0343)=(0x0102,0x0304)+(0x3f,0x3f)
+  prep_test_case
+  vadd2h r0, 0x01020304, 63
+  check_32bit_double 0x0141, 0x0343, r0
+
+; Test case 20
+; reg1 <- reg0, 0(u6)
+; (0x0403,0x0201)=(0x0403,0x0201)+(0,0)
+  prep_test_case
+  mov    r0, 0x04030201
+  vadd2h r1, r0, 0
+  check_32bit_double 0x0403, 0x0201, r1
+
+; Test case 21
+; reg3 <- reg3, s12
+  ; (30064,-1)=(30000,-65)+(-125,-125)
+  prep_test_case
+  mov    r3, 0x7530ffbf     ; (30000,-65)
+  vadd2h r3, r3, -125
+  check_32bit_double 29875, -190, r3
+
+; Test case 22
+; 0 <- limm, s12
+; (X,X)=(0xffee,0xddbb)+(-2048,-2048)
+  prep_test_case
+  vadd2h 0, 0xffeeddbb, -2048
+
+; Test case 23
+; Testing when cc condition is met
+; (6,4)=(3,2)+(3,2)
+  prep_test_case
+  mov      r1, 0x00030002
+  mov      r0, 0x80000000   ; setting...
+  add.f    0,r0,r0          ; ...V=1
+  vadd2h.v r1, r1, r1
+  add.f    0,0,1            ; so that CHECK_FLAGS_REMAINED_ZERO won't fail.
+  check_32bit_double 6, 4, r1
+
+; Test case 24
+; Testing when cc condition is not met
+; (2,0)
+  prep_test_case
+  mov      r4, 0x00020000
+  vadd2h.n r4, r4, r4           ; N is already 0 because of PRE_TEST_CASE.
+  check_32bit_double 2, 0, r4
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VADD4H ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 25
+; reg2 <- reg2, reg2
+; (0x0000,0x0006,0x0000,0x0004)=(0x8000,0x8003,0x8000,0x8002)+
+;                               (0x8000,0x8003,0x8000,0x8002)
+; Moreover, the C and V flags must not be set.
+  prep_test_case
+  mov    r2, 0x80008002
+  mov    r3, 0x80008003
+  vadd4h r2, r2, r2
+  check_64bit_quadruple 0x0000, 0x0006, 0x0000, 0x0004, r3, r2
+
+; Test case 26
+; reg0 <- reg2, reg0
+; (6,8,10,12)=(1,2,3,4)+(5,6,7,8)
+  prep_test_case
+  mov    r3, 0x00010002
+  mov    r2, 0x00030004
+  mov    r1, 0x00050006
+  mov    r0, 0x00070008
+  vadd4h r0, r2, r0
+  check_64bit_quadruple 6, 8, 10, 12, r1, r0
+
+; Test case 27
+; reg0 <- limm, reg4
+; (0x0000,0x0000,0x0000,0x0000)=(0x1234,0x5678,0x1234,0x5678)+
+;                               (0xedcc,0xa988,0xedcc,0xa988)
+; also the Z flag mustn't be set.
+  prep_test_case
+  mov    r0, 0x11111111           ; bogus data
+  mov    r1, 0x22222222           ; bogus data
+  mov    r4, 0xedcca988           ; (neg(0x1234),neg(0x5678))
+  mov    r5, 0xedcca988           ; (neg(0x1234),neg(0x5678))
+  vadd4h r0, 0x12345678, r4
+  check_64bit_quadruple 0x00, 0x00, 0x00, 0x00, r1, r0
+
+; Test case 28
+; reg4 <- reg2, limm
+; (-5,-4,-3,-2)=(-4,-3,-2,-1)+(-1,-1,-1,-1)
+; The N flag must not be set, irrespective of having negative results.
+  prep_test_case
+  mov    r2, 0xfffeffff           ; (-2,-1)
+  mov    r3, 0xfffcfffd           ; (-4,-3)
+  vadd4h r4, r2, -1
+  check_64bit_quadruple -5, -4, -3, -2, r5, r4
+
+; Test case 29
+; reg2 <- limm, limm  (both limm should be the same)
+; (0x2468,0xacf0,0x2468,0xacf0)=(0x1234,0x5678,0x1234,0x5678)+
+;                               (0x1234,0x5678,0x1234,0x5678)
+  prep_test_case
+  vadd4h r2, 0x12345678, 0x12345678
+  check_64bit_quadruple 0x2468, 0xacf0, 0x2468, 0xacf0, r3, r2
+
+; Test case 30
+; reg4 <- limm, u6
+; (0x0141,0x0343,0x0141,0x0343)=(0x0102,0x0304,0x0102,0x0304)+
+;                               (  0x3f,  0x3f,  0x3f,  0x3f)
+  prep_test_case
+  vadd4h r4, 0x01020304, 63
+  check_64bit_quadruple 0x0141, 0x0343, 0x0141, 0x0343, r5, r4
+
+; Test case 31
+; reg0 <- reg4, 0(u6)
+; (0x1122,0x3344,0x5566,0x7788)=(0x1122,0x3344,0x5566,0x7788)+
+;                               (0x0000,0x0000,0x0000,0x0000)
+  prep_test_case
+  mov    r5, 0x11223344
+  mov    r4, 0x55667788
+  vadd4h r0, r4, 0
+  check_64bit_quadruple 0x1122, 0x3344, 0x5566, 0x7788, r1, r0
+
+; Test case 32
+; reg0 <- reg0, s12
+; (2048,2046,2049,2035)=(1,-1,2,-12)+(2047,2047,2047,2047)
+  prep_test_case
+  mov    r1, 0x0001ffff     ; (1,-1)
+  mov    r0, 0x0002fff4     ; (2,-12)
+  vadd4h r0, r0, 2047
+  check_64bit_quadruple 2048, 2046, 2049, 2035, r1, r0
+
+; Test case 33
+; 0 <- limm, s12
+; (X,X,X,X)=(0xffee,0xddbb,0xffee,0xddbb)+(-2048,-2048,-2048,-2048)
+  prep_test_case
+  vadd4h 0, 0xffeeddbb, -2048
+
+; Test case 34
+; Testing when cc condition is met
+; (40,80,120,160)=(20,40,60,80)+(20,40,60,80)
+  prep_test_case
+  mov      r2, 0x003c0050   ; (60,80)
+  mov      r3, 0x00140028   ; (20,40)
+  mov      r4, 0x80000000   ; setting...
+  add.f    0,r4,r4          ; ...C=1
+  vadd4h.c r2, r2, r2
+  add.f    0,0,1            ; so that CHECK_FLAGS_REMAINED_ZERO won't fail.
+  check_64bit_quadruple 40, 80, 120, 160, r3, r2
+
+; Test case 35
+; Testing when cc condition is not met
+; (2,0)
+  prep_test_case
+  mov      r2, 0x00020000
+  mov      r3, 0x00020000
+  vadd4h.z r2, r2, r2       ; Z is already 0 because of PREP_TEST_CASE.
+  check_64bit_quadruple 2, 0, 2, 0, r3, r2
+
+; Test case 36
+; Raise an Illegal Instruction exception if an odd register is used.
+; Even if there is no register to save the result to.
+  prep_test_case
+  set_except_params @test_36_exception, @test_36_end
+test_36_exception:
+  vadd4h 0, r2, r3
+  b      @fail
+test_36_end:
+  ; Fall through
+
+; Test case 37
+; Raise an Illegal Instruction exception if an odd register is used.
+; The exception should be made even if the CC indicates no execution.
+  prep_test_case        ; (Z,N,C,V)=(0,0,0,0)
+  set_except_params @test_37_exception, @test_37_end
+test_37_exception:
+  vadd4h.n r1, r1, r0
+  b        @fail
+test_37_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [test_nr]
+  ;print_number r0
+  print "[FAIL]"
+1:
+  print " vadd: vadd2 vadd2h vadd4h\n"
+  end
diff --git a/tests/tcg/arc/check_vsub.S b/tests/tcg/arc/check_vsub.S
new file mode 100644
index 0000000000..db25bbdf16
--- /dev/null
+++ b/tests/tcg/arc/check_vsub.S
@@ -0,0 +1,510 @@
+; check_vsub.S
+;
+; Tests for vsub: vsub2 vsub2h vsub4h
+; If the test fails, check the end of this file for how to troubleshoot.
+
+  .include "macros.inc"
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;; Test checking routines ;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case counter
+.data
+test_nr:
+  .word 0x0
+
+; Increment the test counter and set (Z,N,C,V) to (0,0,0,0).
+.macro prep_test_case
+  ld    r13, [test_nr]
+  add_s r13, r13, 1       ; increase test case counter
+  st    r13, [test_nr]
+  add.f 0, 0, 1           ; (Z, N, C, V) = (0, 0, 0, 0)
+.endm
+
+; Checks if (Z,N,C,V) == (0,0,0,0). This relies on "ADD.F 0,0,1"
+; instruction in PREP_TEST_CASE macro. From a PREP_TEST_CASE macro
+; in a test case, and thence to a VECTOR instruction and finally to
+; this macro, none of the aforementioned flags must have been set,
+; because VECTOR instructions aren't supposed to do so.
+.macro  check_flags_remained_zero
+  lr    r11, [status32]
+  mov   r12, REG_STAT_Z
+  or    r12, r12, REG_STAT_N
+  or    r12, r12, REG_STAT_C
+  or    r12, r12, REG_STAT_V
+  and   r11, r11, r12
+  cmp   r11, 0
+  bne   @fail
+.endm
+
+; pair(HI, LOW) == pair(REG_HI, REG_LO)
+; HI, LO:         32-bit
+; REG_HI, REG_LO: 32-bit
+.macro  check_64bit_double      hi, low, reg_hi, reg_lo
+  check_flags_remained_zero
+  mov   r11, \hi
+  mov   r10, \low
+  cmp   r11, \reg_hi
+  bne   @fail
+  cmp   r10, \reg_lo
+  bne   @fail
+.endm
+
+; REG == (HI, LO)
+; HI, LO: 16-bit
+; REG:    32-bit
+.macro  check_32bit_double      hi, low, reg
+  check_flags_remained_zero
+  mov   r11, \hi
+  and   r11, r11, 0xffff
+  lsl16 r11, r11
+  mov   r12, \low
+  and   r12, r12, 0xffff
+  or    r11, r11, r12
+  cmp   r11, \reg
+  bne   @fail
+.endm
+
+; quartet(q3, q2, q1, q0) == pair64(REG_HI, REG_LO)
+; Q3, Q2, Q1, Q0: 16-bit
+; REG_HI, REG_LO: 32-bit
+.macro  check_64bit_quadruple   q3, q2, q1, q0, reg_hi, reg_lo
+  check_flags_remained_zero
+  mov   r11, \q3
+  and   r11, r11, 0xffff
+  lsl16 r11, r11
+  mov   r12, \q2
+  and   r12, r12, 0xffff
+  or    r11, r11, r12
+  mov   r10, \q1
+  and   r10, r10, 0xffff
+  lsl16 r10, r10
+  mov   r12, \q0
+  and   r12, r12, 0xffff
+  or    r10, r10, r12
+  cmp   r11, \reg_hi
+  bne   @fail
+  cmp   r10, \reg_lo
+  bne   @fail
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;; Exception related code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; parameters that an IllegalInstruction exception may set.
+  .align 4
+ecr_ref  : .word ILLEGAL_INSTRUCTION
+addr_ref : .word 0x0                  ; for both eret and efa
+cont_addr: .word 0x0
+
+; exception: IllegalInstruction
+; regs used: r11, r12
+;
+; A parameterized IllegalInstruction exception that checks the followings:
+; ecr  == Illegal instruction
+; efa  == efa_ref
+; eret == eret_ref
+; If everything passes, it will jump to 'cont_addr' parameter. The parameters
+; must be set beforehand using 'set_except_params' macro.  This requires
+; ivt.S file to be compiled and linked.
+  .align 4
+  .global instruction_error
+  .type instruction_error, @function
+instruction_error:
+  ld   r11, [ecr_ref]
+  lr   r12, [ecr]
+  cmp  r12, r11
+  bne  @fail
+  ld   r11, [addr_ref]
+  lr   r12, [eret]
+  cmp  r12, r11
+  bne  @fail
+  lr   r12, [efa]
+  cmp  r12, r11
+  bne  @fail
+  ; Success: continuing
+  ld   r11, [cont_addr]
+  sr   r11, [eret]
+  rtie
+
+; macro:      set_except_params
+; regs used:  r11
+;
+; This macro writes the provided parameters to a temporary place holder
+; that later will be used by exception above to verify as reference.
+.macro set_except_params addr, continue
+  mov  r11, \addr
+  st   r11, [addr_ref]
+  mov  r11, \continue
+  st   r11, [cont_addr]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VSUB2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Let the tests begin
+  start
+
+; Test case 1
+; reg2 <- reg2, reg2
+; (0x00000000,0x00000000)=(0x80000000,0xffffffff)-(0x80000000,0xffffffff)
+; The Z flag must remain 0.
+  prep_test_case
+  mov   r2, 0xffffffff
+  mov   r3, 0x80000000
+  vsub2 r2, r2, r2
+  check_64bit_double 0, 0, r3, r2
+
+; Test case 2
+; reg0 <- reg2, reg0
+; (0x7fffffff,0x80000000)=(-1,0x7fffffff)-(0x80000000,-1)
+; The V and N flags must remain zero.
+  prep_test_case
+  mov   r3, 0xffffffff
+  mov   r2, 0x7fffffff
+  mov   r1, 0x80000000
+  mov   r0, 0xffffffff
+  vsub2 r0, r2, r0
+  check_64bit_double 0x7fffffff, 0x80000000, r1, r0
+
+; Test case 3
+; reg0 <- limm, reg4
+; (0x90abcdef,0x00000001)=(0x12345678,0x12345678)-(0x81888889,0x12345677)
+  prep_test_case
+  mov   r0, 0x11111111            ; bogus data
+  mov   r1, 0x22222222            ; bogus data
+  mov   r4, 0x12345677
+  mov   r5, 0x81888889
+  vsub2 r0, 0x12345678, r4
+  check_64bit_double 0x90abcdef, 0x01, r1, r0
+
+; Test case 4
+; reg4 <- reg2, limm
+; (-999999999,-999999998)=(1,2)-(1000000000,1000000000)
+; The N flag must not be set, irrespective of having negative results.
+  prep_test_case
+  mov   r2, 2
+  mov   r3, 1
+  vsub2 r4, r2, 0x3b9aca00    ; 0x3b9aca00=1000000000
+  check_64bit_double -999999999, -999999998, r5, r4
+
+; Test case 5
+; reg2 <- limm, limm  (both limm should be the same)
+; (0x00,0x00)=(0x12345678,0x12345678)-(0x12345678,0x12345678)
+  prep_test_case
+  vsub2 r2, 0x12345678, 0x12345678
+  check_64bit_double 0, 0, r3, r2
+
+; Test case 6
+; reg4 <- limm, u6
+; (0x010202c5,0x010202c5)=(0x01020304,0x01020304)-(0x3f,0x3f)
+  prep_test_case
+  vsub2 r4, 0x01020304, 63
+  check_64bit_double 0x010202c5, 0x010202c5, r5, r4
+
+; Test case 7
+; reg2 <- reg4, 0(u6)
+; (0x08070605,0x04030201)=(0x08070605,0x04030201)-(0,0)
+  prep_test_case
+  mov   r5, 0x08070605
+  mov   r4, 0x04030201
+  vsub2 r2, r4, 0
+  check_64bit_double 0x08070605, 0x04030201, r3, r2
+
+; Test case 8
+; reg0 <- reg0, s12
+; (2048,-200000000)=(0,-2000002048)-(-2048,-2048)
+  prep_test_case
+  mov   r1, 0
+  mov   r0, -2000002048
+  vsub2 r0, r0, -2048
+  check_64bit_double 2048, -2000000000, r1, r0
+
+; Test case 9
+; 0 <- limm, s12
+; (X,X)=(0xffeeddbb,0xffeeddbb)-(-2048,-2048)
+  prep_test_case
+  vsub2 0, 0xffeeddbb, -2048
+
+; Test case 10
+; Testing when cc condition is met
+; (0,0)=(3,2)+(3,2)
+  prep_test_case
+  mov     r2, 2
+  mov     r3, 3
+  mov     r4, 0x80000000  ; setting...
+  add.f   0,r4,r4         ; ...C=1
+  vsub2.c r2, r2, r2
+  add.f   0,0,1           ; so that CHECK_FLAGS_REMAINED_ZERO won't fail.
+  check_64bit_double 0, 0, r3, r2
+
+; Test case 11
+; Testing when cc condition is not met
+; (2,0)
+  prep_test_case
+  mov     r2, 0
+  mov     r3, 2
+  vsub2.z r2, r2, r2  ; Z=0 because of PREP_TEST_CASE
+  check_64bit_double 2, 0, r3, r2
+
+; Test case 12
+; Raise an Illegal Instruction exception if an odd register is used.
+; Even if there is no register to save the result to.
+  prep_test_case
+  set_except_params @test_12_exception, @test_12_end
+test_12_exception:
+  vsub2 0, r5, r0
+  b     @fail
+test_12_end:
+  ; Fall through
+
+; Test case 13
+; Raise an Illegal Instruction exception if an odd register is used.
+; The exception should be made even if the CC indicates no execution.
+  prep_test_case        ; (Z,N,C,V)=(0,0,0,0)
+  set_except_params @test_13_exception, @test_13_end
+test_13_exception:
+  vsub2.c r1, r1, r0
+  b       @fail
+test_13_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VSUB2H ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 14
+; reg1 <- reg1, reg1
+; (0x0000,0x0000)=(0x8000,0xffff)-(0x8000,0xffff)
+; To boot, the Z flag must remain unsett.
+  prep_test_case
+  mov    r1, 0x8000ffff
+  vsub2h r1, r1, r1
+  check_32bit_double 0, 0, r1
+
+; Test case 15
+; reg1 <- reg1, reg3
+; (0x7fff,0x8000)=(-1,0x7fff)-(0x8000,-1)
+; The V and N flags must remain zero.
+  prep_test_case
+  mov    r1, 0xffff7fff
+  mov    r3, 0x8000ffff
+  vsub2h r1, r1, r3
+  check_32bit_double 0x7fff, 0x8000, r1
+
+; Test case 16
+; reg0 <- limm, reg4
+; (0x4321,0x0001)=(0x1234,0x5678)-(0xcf13,0x5677)
+  prep_test_case
+  mov    r0, 0x11111111           ; bogus data
+  mov    r4, 0xcf135677
+  vsub2h r0, 0x12345678, r4
+  check_32bit_double 0x4321, 0x0001, r0
+
+; Test case 17
+; reg5 <- reg3, limm
+; (-9999,-9998)=(1,2)-(10000,10000)
+; The N flag must not be set, irrespective of having negative results.
+  prep_test_case
+  mov    r3, 0x00010002           ; (1,2)
+  vsub2h r5, r3, 0x27102710       ; (1,2)-(10000,10000)
+  check_32bit_double -9999, -9998, r5
+
+; Test case 18
+; reg1 <- limm, limm  (both limm should be the same)
+; (0x00,0x00)=(0x1234,0x5678)-(0x1234,0x5678)
+  prep_test_case
+  vsub2h r1, 0x12345678, 0x12345678
+  check_32bit_double 0, 0, r1
+
+; Test case 19
+; reg0 <- limm, u6
+; (0x00c3,0x02c5)=(0x0102,0x0304)-(0x3f,0x3f)
+  prep_test_case
+  vsub2h r0, 0x01020304, 63
+  check_32bit_double 0x00c3, 0x02c5, r0
+
+; Test case 20
+; reg1 <- reg0, 0(u6)
+; (0x0403,0x0201)=(0x0403,0x0201)-(0,0)
+  prep_test_case
+  mov    r0, 0x04030201
+  vsub2h r1, r0, 0
+  check_32bit_double 0x0403, 0x0201, r1
+
+; Test case 21
+; reg5 <- reg5, s12
+; (66,-20415)=(1,-20480)-(-65,-65)
+  prep_test_case
+  mov    r5, 0x0001b000   ; (1,-20480)
+  vsub2h r5, r5, -65
+  check_32bit_double 66, -20415, r5
+
+; Test case 22
+; 0 <- limm, s12
+; (X,X)=(0xffee,0xddbb)-(-2048,-2048)
+  prep_test_case
+  vsub2h 0, 0xffeeddbb, -2048
+
+; Test case 23
+; Testing when cc condition is met
+; (0,0)=(3,2)+(3,2)
+  prep_test_case
+  mov      r1, 0x00030002
+  mov      r0, 0x80000000 ; setting...
+  add.f    0,r0,r0        ; ...V=1
+  vsub2h.v r1, r1, r1
+  add.f    0,0,1          ; so that CHECK_FLAGS_REMAINED_ZERO won't fail.
+  check_32bit_double 0, 0, r1
+
+; Test case 24
+; Testing when cc condition is not met
+; (2,0)
+  prep_test_case
+  mov      r4, 0x00020000
+  vsub2h.n r4, r4, r4  ; N=0 because of PREP_TEST_CASE
+  check_32bit_double 2, 0, r4
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VSUB4H ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case 25
+; reg2 <- reg2, reg2
+; (0x0000,0x0000,0x0000,0x0000)=(0x8000,0x7000,0xfffe,0xffff)-
+;                               (0x8000,0x7000,0xfffe,0xffff)
+; The Z flag must remain 0.
+  prep_test_case
+  mov    r2, 0xfffeffff
+  mov    r3, 0x80007000
+  vsub4h r2, r2, r2
+  check_64bit_quadruple 0, 0, 0, 0, r3, r2
+
+; Test case 26
+; reg0 <- reg2, reg0
+; (0x7fff,-2,977,0x8000)=(-1,10,1000,0x7fff)-(0x8000,12,23,-1)
+; The V and N flags must remain zero.
+  prep_test_case
+  mov    r3, 0xffff000a     ; (-1    ,     10)
+  mov    r2, 0x03e87fff     ; (1000  , 0x7fff)
+  mov    r1, 0x8000000c     ; (0x8000,     12)
+  mov    r0, 0x0017ffff     ; (23    ,     -1)
+  vsub4h r0, r2, r0
+  check_64bit_quadruple 0x7fff, -2, 977, 0x8000, r1, r0
+
+; Test case 27
+; reg0 <- limm, reg4
+; (0x4321,0x8765,0x90ab,0xcdef)=(0x1234,0x5678,0x1234,0x5678)-
+;                               (0xcf13,0xcf13,0x8189,0x8889)
+  prep_test_case
+  mov    r0, 0x11111111           ; bogus data
+  mov    r1, 0x22222222           ; bogus data
+  mov    r5, 0xcf13cf13
+  mov    r4, 0x81898889
+  vsub4h r0, 0x12345678, r4
+  check_64bit_quadruple 0x4321, 0x8765, 0x90ab, 0xcdef, r1, r0
+
+; Test case 28
+; reg4 <- reg2, limm
+; (-9999,-10,-9653,417)=(1,2,347,429)-(10000,12,10000,12)
+; The N flag must not be set, irrespective of having negative results.
+  prep_test_case
+  mov    r3, 0x00010002         ; (1  ,   2)
+  mov    r2, 0x015b01ad         ; (347, 429)
+  vsub4h r4, r2, 0x2710000c     ; (0x2710,000c)=(10000,12)
+  check_64bit_quadruple -9999, -10, -9653, 417, r5, r4
+
+; Test case 29
+; reg2 <- limm, limm  (both limm should be the same)
+; (0x0000,0x0000,0x0000,0x0000)=(0x1234,0x5678,0x1234,0x5678)-
+;                               (0x1234,0x5678,0x1234,0x5678)
+  prep_test_case
+  vsub4h r2, 0x12345678, 0x12345678
+  check_64bit_quadruple 0, 0, 0, 0, r3, r2
+
+; Test case 30
+; reg4 <- limm, u6
+; (0x00c3,0x02c5,0x00c3,0x02c5)=(0x0102,0x0304,0x0102,0x0304)-
+;                               (  0x3f,  0x3f,  0x3f,  0x3f)
+  prep_test_case
+  vsub4h r4, 0x01020304, 63
+  check_64bit_quadruple 0x00c3,0x02c5, 0x00c3, 0x02c5, r5, r4
+
+; Test case 31
+; reg0 <- reg4, 0(u6)
+; (0x1122,0x3344,0x5566,0x7788)=(0x1122,0x3344,0x5566,0x7788)-
+;                               (0x0000,0x0000,0x0000,0x0000)
+  prep_test_case
+  mov    r5, 0x11223344
+  mov    r4, 0x55667788
+  vsub4h r0, r4, 0
+  check_64bit_quadruple 0x1122, 0x3344, 0x5566, 0x7788, r1, r0
+
+; Test case 32
+; reg2 <- reg2, s12
+; (-4094,1,-2035,-2049)=(-2047,2048,12,-2)-(2047,2047,2047,2047)
+  prep_test_case
+  mov    r3, 0xf8010800
+  mov    r2, 0x000cfffe     ; (12, -2)
+  vsub4h r2, r2, 2047
+  check_64bit_quadruple -4094, 1, -2035, -2049, r3, r2
+
+; Test case 33
+; 0 <- limm, s12
+; (X,X,X,X)=(0xffee,0xddbb,0xffee,0xddbb)-(-2048,-2048,-2048,-2048)
+  prep_test_case
+  vsub4h 0, 0xffeeddbb, -2048
+
+; Test case 34
+; Testing when cc condition is met
+; (0,0,0,0)=(3,2,1,0)-(3,2,1,0)
+  prep_test_case
+  mov      r3, 0x00030002
+  mov      r2, 0x00010000
+  mov      r4, 0x80000000   ; setting...
+  add.f    0,r4,r4          ; ...C=1
+  vsub4h.c r2, r2, r2
+  add.f    0,0,1            ; so that CHECK_FLAGS_REMAINED_ZERO won't fail.
+  check_64bit_quadruple 0, 0, 0, 0, r3, r2
+
+; Test case 35
+; Testing when cc condition is not met
+; (2,0,2,0)
+  prep_test_case
+  mov      r3, 0x00020000
+  mov      r2, 0x00020000
+  vsub4h.z r2, r2, r2       ; Z=0 because of PREP_TEST_CASE
+  check_64bit_quadruple 2, 0, 2, 0, r3, r2
+
+; Test case 36
+; Raise an Illegal Instruction exception if an odd register is used.
+; Even if there is no register to save the result to.
+  prep_test_case
+  set_except_params @test_36_exception, @test_36_end
+test_36_exception:
+  vsub4h 0, r3, r0
+  b      @fail
+test_36_end:
+  ; Fall through
+
+; Test case 37
+; Raise an Illegal Instruction exception if an odd register is used.
+; The exception should be made even if the CC indicates no execution.
+  prep_test_case        ; (Z,N,C,V)=(0,0,0,0)
+  set_except_params @test_37_exception, @test_37_end
+test_37_exception:
+  vsub4h.v r5, r5, r0
+  b        @fail
+test_37_end:
+  ; Fall through
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Reporting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+valhalla:
+  print "[PASS]"
+  b @1f
+
+; If a test fails, it jumps here. Although, for the sake of uniformity,
+; the printed output does not say much about which test case failed,
+; one can uncomment the print_number line below or set a breakpoint
+; here to check the R0 register for the test case number.
+fail:
+  ld r0, [test_nr]
+  ;print_number r0
+  print "[FAIL]"
+1:
+  print " vsub: vsub2 vsub2h vsub4h\n"
+  end
diff --git a/tests/tcg/arc/check_xorx.S b/tests/tcg/arc/check_xorx.S
new file mode 100644
index 0000000000..b0f5963eac
--- /dev/null
+++ b/tests/tcg/arc/check_xorx.S
@@ -0,0 +1,32 @@
+#*****************************************************************************
+# xor.S
+#-----------------------------------------------------------------------------
+#
+# Test xor instruction.
+#
+#define ARCTEST_ARC32
+#include "test_macros.h"
+
+ARCTEST_BEGIN
+  #-------------------------------------------------------------
+  # Logical tests
+  #-------------------------------------------------------------
+
+  TEST_IMM_OP( 2, xor, 0xffffffffff00f00f, 0x0000000000ff0f00, 0xf0f );
+  TEST_IMM_OP( 3, xor, 0x000000000ff00f00, 0x000000000ff00ff0, 0x0f0 );
+  TEST_IMM_OP( 4, xor, 0x0000000000ff0ff0, 0x0000000000ff08ff, 0x70f );
+  TEST_IMM_OP( 5, xor, 0xfffffffff00ff0ff, 0xfffffffff00ff00f, 0x0f0 );
+  TEST_RR_3OP( 6, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
+  TEST_RR_3OP( 7, xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
+  TEST_RR_3OP( 8, xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
+  TEST_RR_3OP( 9, xor, 0x00ff00ff, 0xf00ff00f, 0xf0f0f0f0 );
+
+  #-------------------------------------------------------------
+  # Source/Destination tests
+  #-------------------------------------------------------------
+
+  TEST_IMM_SRC1_EQ_DEST( 10, xor, 0xffffffffff00f00f, 0xffffffffff00f700, 0x70f );
+  TEST_RR_SRC1_EQ_DEST( 11, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
+  TEST_RR_SRC2_EQ_DEST( 12, xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
+  TEST_RR_SRC12_EQ_DEST( 13, xor, 0x00000000, 0xff00ff00 );
+ARCTEST_END
diff --git a/tests/tcg/arc/ivt.S b/tests/tcg/arc/ivt.S
new file mode 100644
index 0000000000..39af256ed8
--- /dev/null
+++ b/tests/tcg/arc/ivt.S
@@ -0,0 +1,38 @@
+  .include "macros.inc"
+
+  .section .ivt, "a", @progbits
+#define IVT_ENTRY(name) \
+    .word name `\
+    .weak name `\
+    .set name, _exit_halt
+
+; handler's name,                  number, name,        offset in IVT (hex/dec)
+  IVT_ENTRY(main)              ;  0  program entry point  0x00     0
+  IVT_ENTRY(memory_error)      ;  1  memory_error         0x04     4
+  IVT_ENTRY(instruction_error) ;  2  instruction_error    0x08     8
+  IVT_ENTRY(EV_MachineCheck)   ;  3  EV_MachineCheck      0x0C    12
+  IVT_ENTRY(EV_TLBMissI)       ;  4  EV_TLBMissI          0x10    16
+  IVT_ENTRY(EV_TLBMissD)       ;  5  EV_TLBMissD          0x14    20
+  IVT_ENTRY(EV_ProtV)          ;  6  EV_ProtV             0x18    24
+  IVT_ENTRY(EV_PrivilegeV)     ;  7  EV_PrivilegeV        0x1C    28
+  IVT_ENTRY(EV_SWI)            ;  8  EV_SWI               0x20    32
+  IVT_ENTRY(EV_Trap)           ;  9  EV_Trap              0x24    36
+  IVT_ENTRY(EV_Extension)      ; 10  EV_Extension         0x28    40
+  IVT_ENTRY(EV_DivZero)        ; 11  EV_DivZero           0x2C    44
+  IVT_ENTRY(EV_DCError)        ; 12  EV_DCError           0x30    48
+  IVT_ENTRY(EV_Misaligned)     ; 13  EV_Misaligned        0x34    52
+  IVT_ENTRY(EV_Ex14)           ; 14  unused               0x38    56
+  IVT_ENTRY(EV_Ex15)           ; 15  unused               0x3C    60
+  IVT_ENTRY(IRQ_Timer0)        ; 16  Timer 0              0x40    64
+  IVT_ENTRY(IRQ_Timer1)        ; 17  Timer 1              0x44    68
+  IVT_ENTRY(IRQ_18)            ; 18                       0x48    72
+  IVT_ENTRY(IRQ_19)            ; 19                       0x4C    76
+  IVT_ENTRY(IRQ_20)            ; 20                       0x50    80
+
+  .text
+  .global  _exit_halt
+  .type  _exit_halt, @function
+  .align 4
+_exit_halt:
+  print "Fail\n"
+  end
diff --git a/tests/tcg/arc/macros.inc b/tests/tcg/arc/macros.inc
new file mode 100644
index 0000000000..37530ecf3e
--- /dev/null
+++ b/tests/tcg/arc/macros.inc
@@ -0,0 +1,261 @@
+.equ MAX_TESTNAME_LEN, 32
+.macro test_name name
+    .data
+tn_\name:
+    .asciz "\name\n"
+    .space MAX_TESTNAME_LEN - (. - tn_\name), ' '
+    .align 4
+    .text
+    mov    r30, @tn_\name
+.endm
+
+.macro check_r2 val
+  sub.f     r0, r2, \val
+  bne       @1000f
+  print     "[PASS] "
+  b         @1001f
+1000:
+  print     "[FAIL] "
+1001:
+  printl    r30
+.endm
+
+
+.macro start
+  .text
+  .global main
+  .align 4
+  main:
+.endm
+
+.macro end
+1001:
+  st 1, [POWER_DEVICE]
+  b @1001b
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+.equ   OUTPUT_DEVICE, 0x90000000      ; output device address in QEMU
+.equ   POWER_DEVICE,  0xF0000008      ; power management device
+
+; macro:     print
+; input:     message - the string to be printed
+; regs used: r11, r12
+; example:   print "hello world\n"
+.macro  print message
+
+  .data
+  2010:
+  .asciz "\message"
+  .align 4
+
+  .text
+  mov_s     r11, @2010b                 ; the message to be printed
+  1010:
+    ldb.ab  r12, [r11, 1]
+    breq    r12, 0, @1011f
+    stb     r12, [OUTPUT_DEVICE]
+    j       @1010b
+  1011:
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; macro:     printl
+; input:     label - pointer to the string to be printed
+; regs used: r11, r12
+; example:   print @l1
+.macro  printl reg
+
+  .text
+  mov       r11, \reg                ; the message to be printed
+  3010:
+    ldb.ab  r12, [r11, 1]
+    breq    r12, 0, @3011f
+    stb     r12, [OUTPUT_DEVICE]
+    j       @3010b
+  3011:
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; macro:     print_number
+; input:     number
+; regs used: r11, r12, r13, r14
+; example:   print_number 0x123
+;            print_number 11
+;
+; description:
+;   given a number, prints it to the output as a decimal string.
+.macro print_number   number
+  .data
+  .align 4
+2020:         ; place holder for printed number in reverse
+  .skip 12
+
+  .text
+  mov    r11, \number
+  mov    r13, @2020b
+  mov    r14, @2020b
+1020:
+  remu   r12, r11, 10
+  add_s  r12, r12, 0x30
+  stb.ab r12, [r13, 1]
+  divu   r11, r11, 10
+  brne   r11, 0, @1020b
+
+1021:
+  ldb.aw r12, [r13, -1]
+  stb    r12, [0x90000000]
+  brne   r13, r14, @1021b
+.endm
+
+
+; macro:     print_number_hex
+; input:     number
+; regs used: r11, r12, r13, r14
+; example:   print_number_hex 0x123
+;            print_number_hex 11
+;
+; description:
+;   given a number, prints it to the output with "0x" prefix and in
+;   hexadecimal format.
+.macro print_number_hex  num
+  .data
+  .align 4
+2030:           ; number printed in reverse order
+  .skip 12
+
+  .text
+  mov   r11, \num
+  mov   r13, @2030b
+  mov   r14, @2030b
+1030:
+  and   r12, r11, 0x0F
+  brgt  r12, 9, @1031f
+  add_s r12, r12, '0'
+  j     @1032f
+1031:
+  add_s r12, r12, 'W'
+1032:
+  stb.ab r12, [r13, 1]
+  lsr.f  r11, r11, 4
+  bnz    @1030b
+
+  print "0x"
+10333:
+  ldb.aw r12, [r13, -1]
+  stb    r12, [OUTPUT_DEVICE]
+  brgt   r13, r14, @10333b
+.endm
+
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; macro:     assert_eq
+; input:     a, b     - two values/registers to be compared
+;            test_num - optional: printed error number, default is 1.
+; regs used: r11, r12
+; example:   assert_eq 12, r2
+;            assert_eq r1, 8
+;            assert_eq r3, r4
+;            assert_eq 8 , 9     (although useless for tests)
+;
+; description:
+;   compares  the  two inputs. if they are equal, nothing happens.
+;   but if not, then it is going to print "Ret:1" and exit.
+.macro assert_eq a, b, test_num=1
+  mov   r11, \a
+  mov   r12, \b
+  breq  r11, r12, @1040f
+  print "FAIL:"
+  print_number \test_num
+  end
+1040:
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Auxilary registers
+.equ REG_IRQ_SELECT, 0x40B
+
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Exceptions
+.equ ILLEGAL_INSTRUCTION         , 0x00020000
+.equ ILLEGAL_INSTRUCTION_SEQUENCE, 0x00020100
+.equ MACHINE_CHECK               , 0x00030000
+.equ TLB_MISS_I                  , 0x00040000
+.equ TLB_MISS_D_READ             , 0x00050100
+.equ PRIVILEGE_VIOLATION         , 0x00070000
+.equ SOFTWARE_INTERRUPT          , 0x00080000
+.equ MISALIGNED_DATA_ACCESS      , 0x000D0000
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; macro:     set_interrupt_prio_level
+; input:     prio - number in range 0..7
+; regs used: r11
+; example:   set_interrupt_prio_level 1
+;
+; description:
+;   sets the bits 1 to 3 of "status" register to the given priority.
+.macro set_interrupt_prio_level  prio
+  lr  r11, [status32]
+  asl r12, \prio
+  and r12, r12, 0xE
+  or  r11, r11, r12
+  sr  r11, [status32]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; STATUS register and its masks
+.equ REG_STAT,     0x0A   ; STATUS32 register
+.equ REG_IVT_BASE, 0x25   ; Interrupt vector base
+.equ REG_STAT_V,   0x0100 ; mask for Over flow bit
+.equ REG_STAT_C,   0x0200 ; mask for Carry bit
+.equ REG_STAT_N,   0x0400 ; mask for Negative bit
+.equ REG_STAT_Z,   0x0800 ; mask for Zero bit
+
+; macro:     assert_flag
+; input:     reg_stat_flag - index to get the corresponding flag
+;            bit           - verification value: 0 or 1
+;            test_num      - optional: printed error number, default
+;                            is 1. valid range is: [0 ... 9]
+; regs used: r11, r12
+; example:   assert_flag REG_STAT_Z, 1, num=8
+;            assert_flag 0x0200    , 0, num=3
+;
+; description:
+;   extracts the corresponding bit at given index by reg_stat_flag.
+;   if it holds  the  same value  as  given 'bit', nothing happens,
+;   else it will print an error and exit.
+.macro assert_flag reg_stat_flag, bit, test_num
+  lr     r11, [REG_STAT]
+  and    r11, r11, \reg_stat_flag
+  ; if bit=0 then checking if r11 == 0
+  ; if bit=1 then checking if r11 == bit_mask
+  assert_eq r11, \bit*\reg_stat_flag, \test_num
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; macro:     enter_user_mode
+; input:     user_space - where the user code begins
+;
+; regs used: r11
+; example:   enter_user_mode @my_user_space_entry
+;
+; description:
+;  this piece of code sets the user flag and jumps to given address
+.macro enter_user_mode user_space
+  lr  r11, [status32]
+  or  r11, r11, 0x80       ; set the STATUS32.U
+  sr  r11, [erstatus]
+  mov r11, \user_space
+  sr  r11, [eret]
+  rtie
+.endm
diff --git a/tests/tcg/arc/memory.x b/tests/tcg/arc/memory.x
new file mode 100644
index 0000000000..53772484fc
--- /dev/null
+++ b/tests/tcg/arc/memory.x
@@ -0,0 +1,12 @@
+MEMORY
+{
+    RAM : ORIGIN = 0x00000000, LENGTH = 128M
+}
+
+REGION_ALIAS("startup", RAM)
+REGION_ALIAS("text", RAM)
+REGION_ALIAS("data", RAM)
+REGION_ALIAS("sdata", RAM)
+
+PROVIDE (__stack_top = (0xFFFF & -4) );
+PROVIDE (__end_heap = (0xFFFF) );
diff --git a/tests/tcg/arc/mmu.inc b/tests/tcg/arc/mmu.inc
new file mode 100644
index 0000000000..c20c6e6bdd
--- /dev/null
+++ b/tests/tcg/arc/mmu.inc
@@ -0,0 +1,132 @@
+
+; auxilary registers
+.equ REG_PD0     , 0x460  ; TLBPD0
+.equ REG_PD1     , 0x461  ; TLBPD1
+.equ REG_TLB_INDX, 0x464  ; TLB index
+.equ REG_TLB_CMD , 0x465  ; TLB command
+.equ REG_PID     , 0x468  ; Process Identity
+
+; exceptions (ecr values)
+.equ PROTV_FETCH_MMU, 0x060008
+.equ PROTV_READ_MMU , 0x060108
+.equ PROTV_WRITE_MMU, 0x060208
+.equ PROTV_RW_MMU   , 0x060308
+
+; PID register bit masks
+.equ REG_PID_TLB_SET, 0x80000000       ; TLB enable bit in PID
+.equ REG_PID_TLB_CLR, ~REG_PID_TLB_SET ; TLB disable bit in PID
+
+; bit masks related to page size
+.equ PAGE_INDEX_BITS, 13               ; page size is _assumed_ to be 8 KB
+.equ PAGE_SIZE      , 1 << PAGE_INDEX_BITS
+.equ PAGE_OFFSET_MSK, PAGE_SIZE - 1
+.equ PAGE_NUMBER_MSK, ~PAGE_OFFSET_MSK
+
+; TLBPD0 bit masks
+.equ REG_PD0_GLOBAL, 0x100     ; Global bit
+.equ REG_PD0_VALID , 0x200     ; Valid bit
+
+; TLBPD1 bit masks
+.equ REG_PD1_KRNL_E, 0x10           ; kernel execute
+.equ REG_PD1_KRNL_W, 0x20           ; kernel write
+.equ REG_PD1_KRNL_R, 0x40           ; kernel read
+
+; TLB commands
+.equ TLB_CMD_WRITE   , 0x01           ; write
+.equ TLB_CMD_READ    , 0x02           ; read
+.equ TLB_CMD_GET_INDX, 0x03           ; get index
+.equ TLB_CMD_PROBE   , 0x04           ; probe
+.equ TLB_CMD_INSERT  , 0x07           ; insert
+.equ TLB_CMD_DELETE  , 0x08           ; delete
+
+
+.macro  extract_page_number   address
+  (address & PAGE_NUMBER_MSK)
+.endm
+
+
+; macro:     mmu_enable
+; regs used: r11
+;
+; enable MMU on ARC HS systems
+.macro  mmu_enable
+  lr  r11, [REG_PID]
+  or  r11, r11, REG_PID_TLB_SET
+  sr  r11, [REG_PID]
+.endm
+
+
+; macro:     mmu_disable
+; regs used: r11
+;
+; disable MMU on ARC HS systems
+.macro  mmu_disable
+  lr  r11, [REG_PID]
+  and r11, r11, REG_PID_TLB_CLR
+  sr  r11, [REG_PID]
+.endm
+
+
+; macro:     mmu_tlb_insert
+; regs used: r11
+;
+; inserts (TLBPD0, TLBPD1) registers as a TLB entry
+.macro mmu_tlb_insert  PD0, PD1
+  mov r11, \PD0
+  sr  r11, [REG_PD0]
+  mov r11, \PD1
+  sr  r11, [REG_PD1]
+  mov r11, TLB_CMD_INSERT
+  sr  r11, [REG_TLB_CMD]
+.endm
+
+
+; macro:     mmu_tlb_delete
+; regs used: r11
+;
+; removes any entry with PD0 as page description
+.macro mmu_tlb_delete  PD0, PD1
+  mov r11, \PD0
+  sr  r11, [REG_PD0]
+  mov r11, \PD1
+  sr  r11, [REG_PD1]
+  mov r11, TLB_CMD_INSERT
+  sr  r11, [REG_TLB_CMD]
+.endm
+; vim: set syntax=asm ts=2 sw=2 et:
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;; Test checking routines ;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Test case counter
+.data
+mmu_test_nr:
+  .word 0x0
+
+; Increment the test counter
+.macro mmu_prep_test_case
+  ld    r13, [mmu_test_nr]
+  add_s r13, r13, 1       ; increase test case counter
+  st    r13, [mmu_test_nr]
+  mmu_disable
+  set_except_handler 0x0
+  enable_alignment
+.endm
+
+; Increment the test counter
+.macro mmu_prep_test_case_address
+  st    pcl, [mmu_test_nr]
+.endm
+
+; Disable alignment so there will be no Misaligned exception
+.macro disable_alignment
+  lr    r11, [status32]
+  bset  r11, r11, STATUS32_AD_BIT
+  flag  r11
+.endm
+
+; Enable alignment again.
+.macro enable_alignment
+  lr    r11, [status32]
+  bclr  r11, r11, STATUS32_AD_BIT
+  flag  r11
+.endm
diff --git a/tests/tcg/arc/mpu.inc b/tests/tcg/arc/mpu.inc
new file mode 100644
index 0000000000..421cd96846
--- /dev/null
+++ b/tests/tcg/arc/mpu.inc
@@ -0,0 +1,269 @@
+; MPU related defines and macros
+
+  .equ REG_MPU_EN_EN , 0x40000000  ; enable bit
+  .equ REG_MPU_EN_KR , 0b100000000 ; kernel read
+  .equ REG_MPU_EN_KW , 0b010000000 ; kernel write
+  .equ REG_MPU_EN_KE , 0b001000000 ; kernel execute
+  .equ REG_MPU_EN_UR , 0b000100000 ; user read
+  .equ REG_MPU_EN_UW , 0b000010000 ; user write
+  .equ REG_MPU_EN_UE , 0b000001000 ; user execute
+  .equ REG_MPU_EN_MSK, REG_MPU_EN_EN | REG_MPU_EN_KR | REG_MPU_EN_KW | REG_MPU_EN_KE | REG_MPU_EN_UR | REG_MPU_EN_UW | REG_MPU_EN_UE
+
+  ; full access for user ===> if a user can access, kernel can too
+  .equ REG_MPU_EN_FULL_ACCESS, REG_MPU_EN_UR | REG_MPU_EN_UW | REG_MPU_EN_UE
+
+  .equ MPU_SIZE_32B , 0b00100
+  .equ MPU_SIZE_64B , 0b00101
+  .equ MPU_SIZE_128B, 0b00110
+  .equ MPU_SIZE_256B, 0b00111
+  .equ MPU_SIZE_512B, 0b01000
+  .equ MPU_SIZE_1K  , 0b01001
+  .equ MPU_SIZE_2K  , 0b01010
+  .equ MPU_SIZE_4K  , 0b01011
+  .equ MPU_SIZE_8K  , 0b01100
+  .equ MPU_SIZE_16K , 0b01101
+  .equ MPU_SIZE_32K , 0b01110
+  .equ MPU_SIZE_64K , 0b01111
+  .equ MPU_SIZE_128K, 0b10000
+  .equ MPU_SIZE_256K, 0b10001
+  .equ MPU_SIZE_512K, 0b10010
+  .equ MPU_SIZE_1M  , 0b10011
+  .equ MPU_SIZE_2M  , 0b10100
+  .equ MPU_SIZE_4M  , 0b10101
+  .equ MPU_SIZE_8M  , 0b10110
+  .equ MPU_SIZE_16M , 0b10111
+  .equ MPU_SIZE_32M , 0b11000
+  .equ MPU_SIZE_64M , 0b11001
+  .equ MPU_SIZE_128M, 0b11010
+  .equ MPU_SIZE_256M, 0b11011
+  .equ MPU_SIZE_512M, 0b11100
+  .equ MPU_SIZE_1G  , 0b11101
+  .equ MPU_SIZE_2G  , 0b11110
+  .equ MPU_SIZE_4G  , 0b11111
+
+  ; least byte is used for region
+  .equ MPU_ECR_FETCH,   0x060000
+  .equ MPU_ECR_READ,    0x060100
+  .equ MPU_ECR_WRITE,   0x060200
+  .equ MPU_ECR_RW,      0x060300
+
+  .equ PROTV_FETCH_MPU, 0x060004
+  .equ PROTV_READ_MPU,  0x060104
+  .equ PROTV_WRITE_MPU, 0x060204
+  .equ PROTV_RW_MPU,    0x060304
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Macro:     mpu_enable
+; Regs used: r11
+;
+; Enable MPU on ARC HS systems
+; "def_access" determines the _default region_ access
+.macro mpu_enable   def_access=REG_MPU_EN_FULL_ACCESS
+  mov   r11, \def_access
+  or    r11, r11, REG_MPU_EN_EN
+  and   r11, r11, REG_MPU_EN_MSK
+  sr    r11, [mpuen]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+.macro mpu_disable
+  mov   r11, 0
+  sr    r11, [mpuen]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Macro:     mpu_add_base
+; Regs used: r11
+;
+; Adds the base address to the given MPU base register.
+; "reg" is the mpu base register: mpurdb0 ... mpurdb15
+; "addr" is the base address you are interested in, e.g.: 0x4000
+.macro mpu_add_base   reg, addr
+  mov   r11, \addr
+  and   r11, r11, 0xffffffe0  ; the last 5 bits must be 0
+  or    r11, r11, 1           ; set valid flag
+  sr    r11, [\reg]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Macro:     mpu_add_region
+; Regs used: r11, r12
+;
+; Adds the region permission and size to the given MPU permission register.
+; "reg" is the mpu permission register: mpurdp0 ... mpurdp15
+; "access" detemines the access type
+; "size" is the region size: 00100b (32 bytes) ... 11111b (4 gigabytes)
+.macro mpu_add_region   reg, access, size=0b100
+  mov   r12, \size
+  and   r11, r12, 3           ; get the lower 2 bits
+  asl   r12, r12, 7           ; getting the upper 3 bits in position
+  and   r12, r12, 0xe00       ; keeping only bits[11:9] in place
+  or    r11, r11, r12         ; r11 has the size bits now
+  or    r11, r11, \access
+  sr    r11, [\reg]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Macro:     mpu_reset
+; Regs used: r11
+;
+; Resets all the regions and disables MPU
+.macro mpu_reset
+  lr   r12, [mpu_build]
+  and  r11, r12, 0xff
+  breq r11, 0, @6666f   ; no mpu? then skip!
+  mpu_disable
+  lsr  r12, r12, 8
+  brlt r12, 1, @6666f   ; no region at all? then skip!
+  mov  r11, 0
+  sr   r11, [mpurdb0]
+  sr   r11, [mpurdp0]
+  brlt r12, 2, @6666f   ; only 1 region? then skip!
+  sr   r11, [mpurdb1]
+  sr   r11, [mpurdp1]
+  brlt r12, 4, @6666f   ; only 2 regions? then skip!
+  sr   r11, [mpurdb2]
+  sr   r11, [mpurdp2]
+  sr   r11, [mpurdb3]
+  sr   r11, [mpurdp3]
+  brlt r12, 8, @6666f   ; only 4 regions? then skip!
+  sr   r11, [mpurdb4]
+  sr   r11, [mpurdp4]
+  sr   r11, [mpurdb5]
+  sr   r11, [mpurdp5]
+  sr   r11, [mpurdb6]
+  sr   r11, [mpurdp6]
+  sr   r11, [mpurdb7]
+  sr   r11, [mpurdp7]
+  brlt r12, 16, @6666f  ; only 8 regions? then skip!
+  sr   r11, [mpurdb8]
+  sr   r11, [mpurdp8]
+  sr   r11, [mpurdb9]
+  sr   r11, [mpurdp9]
+  sr   r11, [mpurdb10]
+  sr   r11, [mpurdp10]
+  sr   r11, [mpurdb11]
+  sr   r11, [mpurdp11]
+  sr   r11, [mpurdb12]
+  sr   r11, [mpurdp12]
+  sr   r11, [mpurdb13]
+  sr   r11, [mpurdp13]
+  sr   r11, [mpurdb14]
+  sr   r11, [mpurdp14]
+  sr   r11, [mpurdb15]
+  sr   r11, [mpurdp15]
+6666:
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; These are the parameters that the ProtV exception routine uses as reference
+; There are tests that want to disable the R(ead) permission for the whole
+; memory layout, but they do make an exception for the parameters below. To
+; achieve that, they allow reading for a region of 32 bytes (minimum possible
+; size for a region) that these parameters reside in. Therefore, we have to
+; make sure these are the one and only things in this region by guarding them
+; with ".align 32" and nothing else.
+  .align 32
+mpu_ecr_ref: .word 0x0
+ecr_ref    : .word 0x0
+efa_ref    : .word 0x0
+eret_ref   : .word 0x0
+cont_addr  : .word 0x0
+  .align 32
+
+; Exception: Protection Violation
+; Regs used: r11, r12
+;
+; This is a parameterized ProtV exception that will check the followings:
+; mpuic == mpu_ecr_ref
+; ecr   == ecr_ref
+; efa   == efa_ref
+; eret  == eret_ref
+; If everything passes, it will jump to 'cont_addr' parameter. It will clear
+; the user bit before the jump, i.e. if an exception is raised in user mode,
+; the continuation after exception will be in kernel mode. If the check
+; should fail, it jumps to "fail" label which must exist in the test file.
+; The parameters must be set beforehand using 'mpu_set_except_params' macro.
+; Last but not least, this requires ivt.S file to be compiled and linked.
+  .align 4
+  .global instruction_error
+  .global EV_PrivilegeV
+  .global EV_ProtV
+  .type instruction_error, @function
+  .type EV_PrivilegeV, @function
+  .type EV_ProtV, @function
+instruction_error:
+EV_PrivilegeV:
+EV_ProtV:
+  ld   r11, [mpu_ecr_ref]
+  lr   r12, [mpuic]
+  cmp  r12, r11
+  bne  @fail
+  ld   r11, [ecr_ref]
+  lr   r12, [ecr]
+  cmp  r12, r11
+  bne  @fail
+  ld   r11, [eret_ref]
+  lr   r12, [eret]
+  cmp  r12, r11
+  bne  @fail
+  ld   r11, [efa_ref]
+  lr   r12, [efa]
+  cmp  r12, r11
+  bne  @fail
+  ; going back to the given address in kernel mode
+  ld   r11, [cont_addr]
+  sr   r11, [eret]
+  lr   r11, [erstatus]
+  and  r11, r11, ~0x80       ; clear user mode bit
+  sr   r11, [erstatus]
+  rtie
+
+; Macro:      mpu_set_except_params
+; Regs used:  r11
+;
+; This macro writes the provided parameters to a temporary place holder
+; that later will be used by ProtV exception above to verify as reference.
+.macro mpu_set_except_params mpu_ecr, ecr, efa, eret, continue
+  mov  r11, \mpu_ecr
+  st   r11, [mpu_ecr_ref]
+  mov  r11, \ecr
+  st   r11, [ecr_ref]
+  mov  r11, \efa
+  st   r11, [efa_ref]
+  mov  r11, \eret
+  st   r11, [eret_ref]
+  mov  r11, \continue
+  st   r11, [cont_addr]
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Macro:     mpu_verify_data
+; Regs used: r11, r12
+;
+; Reads the data at the given address and check if it holds a certain value.
+; It requires the test source file to have "fail" label.
+.macro mpu_verify_data  ref, addr
+  ld   r11, [\addr]
+  mov  r12, \ref
+  cmp  r11, r12
+  bne  @fail
+.endm
+
+;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
+
+; Macro:     mpu_write_data
+; Regs used: r11, r12
+.macro mpu_write_data  data, addr
+  mov  r11, \data
+  st   r11, [\addr]
+.endm
+
+; vim: set syntax=asm ts=2 sw=2 et:
diff --git a/tests/tcg/arc/tarc.ld b/tests/tcg/arc/tarc.ld
new file mode 100644
index 0000000000..8146162d12
--- /dev/null
+++ b/tests/tcg/arc/tarc.ld
@@ -0,0 +1,15 @@
+ENTRY(main)
+SECTIONS
+{
+ .ivt 0x00 :
+ {
+  KEEP (*(.ivt));
+ }
+ . = 0x100;
+ .text : { *(.text) }
+ .data : { *(.data) }
+ .bss : { *(.bss COMMON) }
+ . = ALIGN(8);
+ . = . + 0x1000; /* 4kB of stack memory */
+ stack_top = .;
+}
diff --git a/tests/tcg/arc/tarc_mmu.ld b/tests/tcg/arc/tarc_mmu.ld
new file mode 100644
index 0000000000..4112c0a927
--- /dev/null
+++ b/tests/tcg/arc/tarc_mmu.ld
@@ -0,0 +1,15 @@
+ENTRY(main)
+SECTIONS
+{
+ .ivt 0x80000000 :
+ {
+  KEEP (*(.ivt));
+ }
+ . = 0x80000100;
+ .text : { *(.text) }
+ .data : { *(.data) }
+ .bss : { *(.bss COMMON) }
+ . = ALIGN(8);
+ . = . + 0x1000; /* 4kB of stack memory */
+ stack_top = .;
+}
diff --git a/tests/tcg/arc/test_macros.h b/tests/tcg/arc/test_macros.h
new file mode 100644
index 0000000000..15325e1ffa
--- /dev/null
+++ b/tests/tcg/arc/test_macros.h
@@ -0,0 +1,257 @@
+#ifndef __TEST_MACROS_SCALAR_H
+#define __TEST_MACROS_SCALAR_H
+
+#ifdef ARCTEST_ARC32
+#define __arc_xlen 32
+#else
+#define __arc_xlen 64
+#endif
+
+#define xstr(a) str(a)
+#define str(a) #a
+
+#define MASK_XLEN(x) ((x) & ((1 << (__arc_xlen - 1) << 1) - 1))
+#define SEXT_IMM(x) ((x) | (-(((x) >> 11) & 1) << 11))
+
+#define TEST_CASE( testnum, testreg, correctval, name, code... ) \
+    test_ ## testnum:                                       \
+    code`                                                   \
+    mov  r12, testnum`                                      \
+    sub.f 0,testreg, correctval`                            \
+    bne  @fail`                                             \
+    PASS_TEST(name)
+
+#define TEST_IMM_OP( testnum, inst, result, val1, imm ) \
+    TEST_CASE( testnum, r0, result, xstr(inst) ":" xstr(testnum),       \
+               mov  r1, MASK_XLEN(val1)`                \
+               inst r0, r1, SEXT_IMM(imm)               \
+        )
+
+#define TEST_RR_3OP( testnum, inst, result, val1, val2 ) \
+    TEST_CASE( testnum, r0, result, xstr(inst) ":" xstr(testnum),  \
+               mov  r1, MASK_XLEN(val1)`                \
+               mov  r2, MASK_XLEN(val2)`                \
+               inst r0, r1, r2                          \
+        )
+
+#define TEST_RR_2OP( testnum, inst, result, val)         \
+    TEST_CASE( testnum, r0, result, xstr(inst) ":" xstr(testnum),  \
+               mov  r1, MASK_XLEN(val)`                 \
+               inst r0, r1                              \
+        )
+
+#define TEST_IMM_SRC1_EQ_DEST( testnum, inst, result, val1, imm ) \
+    TEST_CASE( testnum, r1, result, xstr(inst) ":" xstr(testnum),           \
+               mov  r1, MASK_XLEN(val1)`                          \
+               inst r1, r1, SEXT_IMM(imm)                         \
+        )
+
+#define TEST_RR_SRC1_EQ_DEST( testnum, inst, result, val1, val2 ) \
+    TEST_CASE( testnum, r1, result, xstr(inst) ":" xstr(testnum),           \
+               mov  r1, MASK_XLEN(val1)`                          \
+               mov  r2, MASK_XLEN(val2)`                          \
+               inst r1, r1, r2                                    \
+        )
+
+#define TEST_RR_2OP_SRC1_EQ_DEST( testnum, inst, result, val )     \
+    TEST_CASE( testnum, r1, result, xstr(inst) ":" xstr(testnum),            \
+               mov  r1, MASK_XLEN(val)`                            \
+               inst r1, r1                                         \
+        )
+
+#define TEST_RR_SRC2_EQ_DEST( testnum, inst, result, val1, val2 )  \
+    TEST_CASE( testnum, r2, result, xstr(inst) ":" xstr(testnum),            \
+               mov  r1, MASK_XLEN(val1)`                           \
+               mov  r2, MASK_XLEN(val2)`                           \
+               inst r2, r1, r2                                     \
+        )
+
+#define TEST_RR_SRC12_EQ_DEST( testnum, inst, result, val1 ) \
+    TEST_CASE( testnum, r1, result, xstr(inst) ":" xstr(testnum),      \
+               mov  r1, MASK_XLEN(val1)`                     \
+               inst r1, r1, r1                               \
+        )
+
+#define TEST_2OP_CARRY( testnum, inst, expected, val1, val2) \
+    test_ ## testnum:                                        \
+    mov  r12, testnum`                                       \
+        mov  r1, MASK_XLEN(val1)`                            \
+        mov  r2, MASK_XLEN(val2)`                            \
+        inst.f   0, r1, r2`                                  \
+        mov.cs   r3,(~expected) & 0x01`                      \
+        mov.cc   r3, (expected) & 0x01`                      \
+        cmp      r3, 0`                                      \
+        bne      @fail
+
+#define TEST_1OP_CARRY( testnum, inst, expected, val) \
+    test_ ## testnum:                                 \
+    mov  r12, testnum`                                \
+        add.f    0, r0, r0`                           \
+        mov      r1, MASK_XLEN(val)`                  \
+        inst.f   0, r1`                               \
+        mov.cs   r3,(~expected) & 0x01`               \
+        mov.cc   r3, (expected) & 0x01`               \
+        cmp      r3, 0`                               \
+        bne      @fail
+
+#define TEST_2OP_ZERO( testnum, inst, expected, val1, val2)  \
+    test_ ## testnum:                                        \
+    mov  r12, testnum`                                       \
+        mov      r1, MASK_XLEN(val1)`                        \
+        mov      r2, MASK_XLEN(val2)`                        \
+        inst.f   0, r1, r2`                                  \
+        mov.eq   r3, (~expected) & 0x01`                     \
+        mov.ne   r3, (expected) & 0x01`                      \
+        cmp      r3, 0`                                      \
+        bne      @fail
+
+#define TEST_1OP_ZERO( testnum, inst, expected, val)  \
+    test_ ## testnum:                                 \
+    mov  r12, testnum`                                \
+        add.f    0, r0, r0`                           \
+        mov      r1, MASK_XLEN(val)`                  \
+        inst.f   0, r1`                               \
+        mov.eq   r3, (~expected) & 0x01`              \
+        mov.ne   r3, (expected) & 0x01`               \
+        cmp      r3, 0`                               \
+        bne      @fail
+
+#define TEST_2OP_OVERFLOW( testnum, inst, expected, val1, val2) \
+    test_ ## testnum:                                           \
+    mov  r12, testnum`                                          \
+        mov      r1, MASK_XLEN(val1)`                           \
+        mov      r2, MASK_XLEN(val2)`                           \
+        inst.f   0, r1, r2`                                     \
+        mov.vs   r3,(~expected) & 0x01`                         \
+        mov.vc   r3, (expected) & 0x01`                         \
+        cmp      r3, 0`                                         \
+        bne      @fail
+
+#define TEST_1OP_OVERFLOW( testnum, inst, expected, val) \
+    test_ ## testnum:                                    \
+    mov  r12, testnum`                                   \
+        add.f    0, r0, r0`                              \
+        mov      r1, MASK_XLEN(val)`                     \
+        inst.f   0, r1`                                  \
+        mov.vs   r3,(~expected) & 0x01`                  \
+        mov.vc   r3, (expected) & 0x01`                  \
+        cmp      r3, 0`                                  \
+        bne      @fail
+
+#define TEST_2OP_NEGATIVE( testnum, inst, expected, val1, val2)    \
+    test_ ## testnum:                                              \
+    mov  r12, testnum`                                             \
+        mov      r1, MASK_XLEN(val1)`                              \
+        mov      r2, MASK_XLEN(val2)`                              \
+        inst.f   0, r1, r2`                                        \
+        mov.mi   r3,(~expected) & 0x01`                            \
+        mov.pl   r3, (expected) & 0x01`                            \
+        cmp      r3, 0`                                            \
+        bne      @fail
+
+#define TEST_1OP_NEGATIVE( testnum, inst, expected, val)    \
+    test_ ## testnum:                                       \
+    mov  r12, testnum`                                      \
+        add.f    0, r0, r0`                                 \
+        mov      r1, MASK_XLEN(val)`                        \
+        inst.f   0, r1`                                     \
+        mov.mi   r3,(~expected) & 0x01`                     \
+        mov.pl   r3, (expected) & 0x01`                     \
+        cmp      r3, 0`                                     \
+        bne      @fail
+
+
+#endif
+
+#define TEST_BR2_OP_TAKEN( testnum, inst, val1, val2 )  \
+    test_ ## testnum:`                                  \
+        mov  r12, testnum`                              \
+        mov  r1, val1`                                  \
+        mov  r2, val2`                                  \
+        sub.f 0,r1,r2`                                  \
+        inst 1f`                                        \
+        b @fail`                                        \
+        1:
+
+#define TEST_BR2_OP_NOTTAKEN( testnum, inst, val1, val2 ) \
+    test_ ## testnum:`                                    \
+    mov  r12,testnum`                                     \
+        mov  r1, val1`                                    \
+        mov  r2, val2`                                    \
+        sub.f 0,r1,r2`                                    \
+        inst @fail
+
+#define TEST_BR_OP_TAKEN( testnum, inst, val1, val2 )  \
+    test_ ## testnum:`                                  \
+        mov  r12, testnum`                              \
+        mov  r1, val1`                                  \
+        mov  r2, val2`                                  \
+        inst r1,r2,1f`                                  \
+        b @fail`                                        \
+        1:
+
+#define TEST_BR_OP_NOTTAKEN( testnum, inst, val1, val2 ) \
+    test_ ## testnum:`                                    \
+        mov  r12,testnum`                                 \
+        mov  r1, val1`                                    \
+        mov  r2, val2`                                    \
+        inst r1,r2,@fail
+
+#define ARCTEST_BEGIN \
+    .text`                                      \
+        .align 4 `                              \
+        .global main`                           \
+    main:                                       \
+        test_1:`                                \
+        mov r12,1`                              \
+        mov.f 0,0`                              \
+        bne @fail
+
+#define ARCTEST_END \
+         .align 4 ` \
+1:`\
+        st 1,[0xf0000008]`\
+        b @1b`\
+fail:`\
+        mov     r2, '['`\
+        st      r2, [0x90000000]`\
+        mov     r2, 'F'`\
+        st      r2, [0x90000000]`\
+        mov     r2, 'a'`\
+        st      r2, [0x90000000]`\
+        mov     r2, 'i'`\
+        st      r2, [0x90000000]`\
+        mov     r2, 'l'`\
+        st      r2, [0x90000000]`\
+        mov     r2, ']'`\
+        st      r2, [0x90000000]`\
+        mov     r2, ' '`\
+        st      r2, [0x90000000]`\
+        mov r13, r12`\
+        mov r15, 0x30`\
+        mov r14, r12`\
+loop_z: `\
+        sub.f   r13, r13, 0x0A`\
+        add.pl  r15, r15, 1`\
+        mov.pl  r14, r13 `\
+        bpl     @loop_z`\
+        st      r15, [0x90000000]`\
+        add     r14, r14, 0x30`\
+        st      r14, [0x90000000]`\
+        mov     r2, '\n'`\
+        st      r2, [0x90000000]`\
+        b       1b`
+
+#define PASS_TEST(name)\
+    .data `            \
+2010:`\
+    .ascii "[PASS] ",name ,"\n\0"` \
+  .align 4`\
+  .text`\
+  mov_s     r11, @2010b`\
+  1010:`\
+    ldb.ab  r12, [r11, 1]`\
+    breq    r12, 0, @1011f`\
+    stb     r12, [0x90000000]`\
+    j       @1010b`\
+  1011:`
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 598a50cd4f..0bcd1a9ba0 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -47,6 +47,7 @@ fi
 : ${cross_cc_aarch64_be="$cross_cc_aarch64"}
 : ${cross_cc_cflags_aarch64_be="-mbig-endian"}
 : $(cross_cc_alpha="alpha-linux-gnu-gcc")
+: ${cross_cc_arc="arc-elf32-gcc"}
 : ${cross_cc_arm="arm-linux-gnueabihf-gcc"}
 : ${cross_cc_cflags_armeb="-mbig-endian"}
 : ${cross_cc_hppa="hppa-linux-gnu-gcc"}
@@ -94,7 +95,7 @@ for target in $target_list; do
     xtensa|xtensaeb)
       arches=xtensa
       ;;
-    alpha|cris|hppa|i386|lm32|microblaze|microblazeel|m68k|openrisc|riscv64|s390x|sh4|sparc64)
+    arc|alpha|cris|hppa|i386|lm32|microblaze|microblazeel|m68k|openrisc|riscv64|s390x|sh4|sparc64)
       arches=$target
       ;;
     *)
-- 
2.20.1


