Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F149C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6E8206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="c4hWsaYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6E8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglgt-0004XD-Ml
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleU-0008Gx-GC
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:55:06 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15]:42360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleT-0002EV-L5
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kt2w6hAuCKsYU6v4jIJKAeCYiJdcs8nZZWvTjDJb2Qc=; b=c4hWsaYcJZNYz9P1cfmjF/X/Qy
 Jc+qmOMNQyoq7wRbyZMvm+NehHRfrlogGDRCLwGZtPxcGLN69HyU47JxvBGFkZFw6lrYRL0gmXMrD
 B6iJNyukKSaZT44nOokR9rqA1dlT+38ruH8ulZeUSSRHTajAYKa4aY7DfKK+93+SU7zk=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/15] tests/tcg/tricore: Add bmerge test
Date: Thu,  4 Jun 2020 10:54:33 +0200
Message-Id: <20200604085441.103087-8-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.4.84518, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.4.5740000
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6898287, da=78869968,
 mc=178, sc=3, hc=175, sp=1, fso=6898287, re=0, sd=0, hd=0
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
 tests/tcg/tricore/macros.h                | 24 +++++++++++++++++++++++
 tests/tcg/tricore/test_bmerge.S           |  8 ++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tests/tcg/tricore/test_bmerge.S

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index 1b1f220c7c..abcd5a4e6e 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -8,6 +8,7 @@ ASFLAGS =
 QEMU_OPTS += -M tricore_testboard -nographic -kernel
 
 TESTS += test_abs.tst
+TESTS += test_bmerge.tst
 
 %.pS: $(TESTS_PATH)/%.S
 	$(HOST_CC) -E -o $@ $<
diff --git a/tests/tcg/tricore/macros.h b/tests/tcg/tricore/macros.h
index 76c133132a..52aa936c56 100644
--- a/tests/tcg/tricore/macros.h
+++ b/tests/tcg/tricore/macros.h
@@ -8,7 +8,10 @@
 #define TESTDEV_ADDR 0xf0000000
 /* Register definitions */
 #define DREG_RS1 %d0
+#define DREG_RS2 %d1
 #define DREG_CALC_RESULT %d1
+#define DREG_CALC_PSW %d2
+#define DREG_CORRECT_PSW %d3
 #define DREG_TEMP_LI %d10
 #define DREG_TEMP %d11
 #define DREG_TEST_NUM %d14
@@ -24,6 +27,17 @@ test_ ## num:                                     \
     mov DREG_TEST_NUM, num;                       \
     jne testreg, DREG_CORRECT_RESULT, fail        \
 
+#define TEST_CASE_PSW(num, testreg, correct, correct_psw, code...) \
+test_ ## num:                                                      \
+    code;                                                          \
+    LI(DREG_CORRECT_RESULT, correct)                               \
+    mov DREG_TEST_NUM, num;                                        \
+    jne testreg, DREG_CORRECT_RESULT, fail;                        \
+    mfcr DREG_CALC_PSW, $psw;                                      \
+    LI(DREG_CORRECT_PSW, correct_psw)                              \
+    mov DREG_TEST_NUM, num;                                        \
+    jne DREG_CALC_PSW, DREG_CORRECT_PSW, fail;
+
 /* Actual test case type
  * e.g inst %dX, %dY      -> TEST_D_D
  *     inst %dX, %dY, %dZ -> TEST_D_DD
@@ -35,6 +49,16 @@ test_ ## num:                                     \
     insn DREG_CALC_RESULT, DREG_RS1;          \
     )
 
+#define TEST_D_DD_PSW(insn, num, result, psw, rs1, rs2) \
+    TEST_CASE_PSW(num, DREG_CALC_RESULT, result, psw,   \
+    LI(DREG_RS1, rs1);                                  \
+    LI(DREG_RS2, rs2);                                  \
+    rstv;                                               \
+    insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2;          \
+    )
+
+
+
 /* Pass/Fail handling part */
 #define TEST_PASSFAIL                       \
         j pass;                             \
diff --git a/tests/tcg/tricore/test_bmerge.S b/tests/tcg/tricore/test_bmerge.S
new file mode 100644
index 0000000000..8a0fa6d3f6
--- /dev/null
+++ b/tests/tcg/tricore/test_bmerge.S
@@ -0,0 +1,8 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_DD_PSW(bmerge, 1, 0x555557f7, 0x00000b80, 0x0000001d, 0x0000ffff)
+
+    TEST_PASSFAIL
+
-- 
2.26.2


