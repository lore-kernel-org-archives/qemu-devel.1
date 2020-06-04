Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B3FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75034206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="oqwrVF33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75034206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgln3-0005Ig-OB
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleX-0008Pf-R2
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:55:09 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15]:42388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleW-0002Ew-Rx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gO8bEj/mx5UuSUi4k2ZGG7ty4/X40ZTxcn3g0BboSJc=; b=oqwrVF33d3cFh4aSX/A1FfnWOZ
 cl3KIJaKvPaZtLl40zcA1gWGr4I2pzr7oRFOqRRknmAUFL4q8XLqtxHBC05q5WD7nkmcloORRs2VN
 yXaNkrCbOM+sNSnqvdpNYs/fkJiGYM/7PCXnZcq+T3gWVM9eFHkzPImItBz0mzzKsQAo=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/15] tests/tcg/tricore: Add dvstep test
Date: Thu,  4 Jun 2020 10:54:35 +0200
Message-Id: <20200604085441.103087-10-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6898290, da=78869971,
 mc=180, sc=3, hc=177, sp=1, fso=6898290, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.4.84817, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.4.5740000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile.softmmu-target |  1 +
 tests/tcg/tricore/macros.h                | 29 ++++++++++++++++++++++-
 tests/tcg/tricore/test_dvstep.S           | 15 ++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/tricore/test_dvstep.S

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index 7a08b656a6..a70fa9643d 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -10,6 +10,7 @@ QEMU_OPTS += -M tricore_testboard -nographic -kernel
 TESTS += test_abs.tst
 TESTS += test_bmerge.tst
 TESTS += test_clz.tst
+TESTS += test_dvstep.tst
 
 %.pS: $(TESTS_PATH)/%.S
 	$(HOST_CC) -E -o $@ $<
diff --git a/tests/tcg/tricore/macros.h b/tests/tcg/tricore/macros.h
index 52aa936c56..59b4b9a352 100644
--- a/tests/tcg/tricore/macros.h
+++ b/tests/tcg/tricore/macros.h
@@ -19,6 +19,18 @@
 
 #define DREG_DEV_ADDR %a15
 
+#define EREG_RS1 %e6
+#define EREG_RS1_LO %d6
+#define EREG_RS1_HI %d7
+#define EREG_RS2 %e8
+#define EREG_RS2_LO %d8
+#define EREG_RS2_HI %d9
+#define EREG_CALC_RESULT %e8
+#define EREG_CALC_RESULT_HI %d9
+#define EREG_CALC_RESULT_LO %d8
+#define EREG_CORRECT_RESULT_LO %d0
+#define EREG_CORRECT_RESULT_HI %d1
+
 /* Test case wrappers */
 #define TEST_CASE(num, testreg, correct, code...) \
 test_ ## num:                                     \
@@ -27,6 +39,15 @@ test_ ## num:                                     \
     mov DREG_TEST_NUM, num;                       \
     jne testreg, DREG_CORRECT_RESULT, fail        \
 
+#define TEST_CASE_E(num, correct_lo, correct_hi, code...)  \
+test_ ## num:                                              \
+    code;                                                  \
+    mov DREG_TEST_NUM, num;                                \
+    LI(EREG_CORRECT_RESULT_LO, correct_lo)                 \
+    jne EREG_CALC_RESULT_LO, EREG_CORRECT_RESULT_LO, fail; \
+    LI(EREG_CORRECT_RESULT_HI, correct_hi)                 \
+    jne EREG_CALC_RESULT_HI, EREG_CORRECT_RESULT_HI, fail;
+
 #define TEST_CASE_PSW(num, testreg, correct, correct_psw, code...) \
 test_ ## num:                                                      \
     code;                                                          \
@@ -57,7 +78,13 @@ test_ ## num:                                                      \
     insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2;          \
     )
 
-
+#define TEST_E_ED(insn, num, res_hi, res_lo, rs1_hi, rs1_lo, rs2) \
+    TEST_CASE_E(num, res_lo, res_hi,                              \
+    LI(EREG_RS1_LO, rs1_lo);                                      \
+    LI(EREG_RS1_HI, rs1_hi);                                      \
+    LI(DREG_RS2, rs2);                                            \
+    insn EREG_CALC_RESULT, EREG_RS1, DREG_RS2;                    \
+    )
 
 /* Pass/Fail handling part */
 #define TEST_PASSFAIL                       \
diff --git a/tests/tcg/tricore/test_dvstep.S b/tests/tcg/tricore/test_dvstep.S
new file mode 100644
index 0000000000..858dbc62dd
--- /dev/null
+++ b/tests/tcg/tricore/test_dvstep.S
@@ -0,0 +1,15 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    #                              Result                   RS1            RS2
+    TEST_E_ED(dvstep,   1, 0x000001ff, 0xfffe5cff, 0x00000001, 0xfffffe5c, 0x0)
+    TEST_E_ED(dvstep,   2, 0x00000000, 0x000000ff, 0x00000000, 0x00000000, 0x0)
+    TEST_E_ED(dvstep,   3, 0x0000f000, 0x000000fd, 0x010000f0, 0x00000000, 0x0)
+    TEST_E_ED(dvstep,   4, 0xfffff000, 0x00000000, 0x7ffffff0, 0x00000000, 0x0)
+    TEST_E_ED(dvstep.u, 5, 0xffffff00, 0x100008ff, 0xffffffff, 0x00100008, 0x0)
+    TEST_E_ED(dvstep.u, 6, 0x00000100, 0x00000000, 0x08000001, 0x00000000, \
+                           0xffffff2d)
+
+    TEST_PASSFAIL
+
-- 
2.26.2


