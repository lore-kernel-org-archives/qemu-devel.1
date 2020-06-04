Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8AE206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="q02vGfrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8AE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglka-0001Fs-Op
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jglen-0000Sg-1n
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:55:25 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15]:42474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jglem-0002Gl-6Y
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0STty3uym+w0LUk6UKXbl1ItmRWZndNSFozxEDd8dLg=; b=q02vGfrv6hDsQ6B5c0Zm3nGAH6
 f9llM1QCKeHFTPXms7Iwh4mO9+Lqe27VSoKarh+H+Jc7iZ7LFPTC8GzDY24hCiGpJS/Y8eiXCGXFh
 Xt7fbEeKr1IyyieitNc1XgQyvqofhrSRTatOS5UPRCv2cPZzxxnb6H3SeNzMVO9HAyfk=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/15] tests/tcg/tricore: Add madd test
Date: Thu,  4 Jun 2020 10:54:39 +0200
Message-Id: <20200604085441.103087-14-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6898295, da=78869976,
 mc=184, sc=3, hc=181, sp=1, fso=6898295, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.4.84518, AntiVirus-Engine: 5.74.0,
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
 tests/tcg/tricore/macros.h                | 18 ++++++++++++++++++
 tests/tcg/tricore/test_madd.S             | 11 +++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 tests/tcg/tricore/test_madd.S

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index a4eebbccb4..4d8d403e80 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -14,6 +14,7 @@ TESTS += test_dvstep.tst
 TESTS += test_fadd.tst
 TESTS += test_fmul.tst
 TESTS += test_ftoi.tst
+TESTS += test_madd.tst
 
 %.pS: $(TESTS_PATH)/%.S
 	$(HOST_CC) -E -o $@ $<
diff --git a/tests/tcg/tricore/macros.h b/tests/tcg/tricore/macros.h
index e6a41cd1a2..0d76fc403a 100644
--- a/tests/tcg/tricore/macros.h
+++ b/tests/tcg/tricore/macros.h
@@ -9,6 +9,7 @@
 /* Register definitions */
 #define DREG_RS1 %d0
 #define DREG_RS2 %d1
+#define DREG_RS3 %d4
 #define DREG_CALC_RESULT %d1
 #define DREG_CALC_PSW %d2
 #define DREG_CORRECT_PSW %d3
@@ -85,6 +86,23 @@ test_ ## num:                                                      \
     insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2;          \
     )
 
+#define TEST_D_DDD_PSW(insn, num, result, psw, rs1, rs2, rs3) \
+    TEST_CASE_PSW(num, DREG_CALC_RESULT, result, psw,         \
+    LI(DREG_RS1, rs1);                                        \
+    LI(DREG_RS2, rs2);                                        \
+    LI(DREG_RS3, rs3);                                        \
+    rstv;                                                     \
+    insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, DREG_RS3;      \
+    )
+
+#define TEST_D_DDI_PSW(insn, num, result, psw, rs1, rs2, imm) \
+    TEST_CASE_PSW(num, DREG_CALC_RESULT, result, psw,         \
+    LI(DREG_RS1, rs1);                                        \
+    LI(DREG_RS2, rs2);                                        \
+    rstv;                                                     \
+    insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, imm;           \
+    )
+
 #define TEST_E_ED(insn, num, res_hi, res_lo, rs1_hi, rs1_lo, rs2) \
     TEST_CASE_E(num, res_lo, res_hi,                              \
     LI(EREG_RS1_LO, rs1_lo);                                      \
diff --git a/tests/tcg/tricore/test_madd.S b/tests/tcg/tricore/test_madd.S
new file mode 100644
index 0000000000..5d839772bb
--- /dev/null
+++ b/tests/tcg/tricore/test_madd.S
@@ -0,0 +1,11 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_DDI_PSW(madd,    1, 0x0000fffd, 0x60000b80, 0x0000ffff, 0x7fffffff,2)
+    TEST_D_DDI_PSW(madd,    2, 0xffff7fff, 0x60000b80, 0xffff8001, 0x7fffffff,2)
+    TEST_D_DDD_PSW(madds.u, 3, 0xffffffff, 0x60000b80, 0x00000000, 0x80000000, \
+                             0x80000000)
+
+    TEST_PASSFAIL
+
-- 
2.26.2


