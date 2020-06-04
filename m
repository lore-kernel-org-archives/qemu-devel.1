Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AECFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54672207D3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="XAtw/kCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54672207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglfe-0001X2-Ij
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleQ-00087y-TS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:55:02 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15]:42324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleQ-0002E3-3k
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MpbdUh0ybsPNtHPHjnJ/5VHUFX7xWOSoCrPVaFL9Wew=; b=XAtw/kCzzNJ/PYkP+vHAG9y0n0
 0PWD7GIvN7vuR0t4BkDEvcIs1HHPi3S/sSHuo2yQ7XLyRgrAHft5tu5LxJk9qqYF3vQz4qbrfbKg+
 Kyqn/Ob0vm+EmK80tM3fFMkYVnsNKascuIwZ0YqK2i+c8GMw+ZmZKe+dpDZTx+he9cAY=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/15] tests/tcg/tricore: Add build infrastructure
Date: Thu,  4 Jun 2020 10:54:31 +0200
Message-Id: <20200604085441.103087-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.4.84518, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.3.5740003
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6898283, da=78869964,
 mc=176, sc=3, hc=173, sp=1, fso=6898283, re=0, sd=0, hd=0
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

this includes the Makefile and linker script to build all the tests.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile.softmmu-target | 17 +++++++
 tests/tcg/tricore/link.ld                 | 60 +++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 create mode 100644 tests/tcg/tricore/link.ld

diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
new file mode 100644
index 0000000000..4a2cd6f218
--- /dev/null
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -0,0 +1,17 @@
+HOST_CC = gcc
+
+TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
+
+LDFLAGS = -T$(TESTS_PATH)/link.ld
+ASFLAGS =
+
+QEMU_OPTS += -M tricore_testboard -nographic -kernel
+
+%.pS: $(TESTS_PATH)/%.S
+	$(HOST_CC) -E -o $@ $<
+
+%.o: %.pS
+	$(AS) $(ASFLAGS) -o $@ $<
+
+%.tst: %.o
+	$(LD) $(LDFLAGS) $< -o $@
diff --git a/tests/tcg/tricore/link.ld b/tests/tcg/tricore/link.ld
new file mode 100644
index 0000000000..364bcdc00a
--- /dev/null
+++ b/tests/tcg/tricore/link.ld
@@ -0,0 +1,60 @@
+/* Default linker script, for normal executables */
+OUTPUT_FORMAT("elf32-tricore")
+OUTPUT_ARCH(tricore)
+ENTRY(_start)
+
+/* the internal ram description */
+MEMORY
+{
+  text_ram (rx!p): org = 0x80000000, len = 15K
+  data_ram (w!xp): org = 0xd0000000, len = 130K
+}
+/*
+ * Define the sizes of the user and system stacks.
+ */
+__USTACK_SIZE = DEFINED (__USTACK_SIZE) ? __USTACK_SIZE : 1K ;
+/*
+ * Define the start address and the size of the context save area.
+ */
+__CSA_BEGIN =  0xd0000000 ;
+__CSA_SIZE =  8k ;
+__CSA_END = __CSA_BEGIN + __CSA_SIZE ;
+
+SECTIONS
+{
+  .text  :
+  {
+    *(.text)
+    . = ALIGN(8);
+  } > text_ram
+
+  .rodata :
+  {
+    *(.rodata)
+    *(.rodata1)
+  } > data_ram
+
+  .data :
+  {
+    . = ALIGN(8) ;
+    *(.data)
+    *(.data.*)
+    . = ALIGN(8) ;
+    __USTACK = . + __USTACK_SIZE -768;
+
+  } > data_ram
+  /*
+   * Allocate space for BSS sections.
+   */
+  .bss  :
+  {
+    BSS_BASE = . ;
+    *(.bss)
+    *(COMMON)
+    . = ALIGN(8) ;
+  } > data_ram
+  /* Make sure CSA, stack and heap addresses are properly aligned.  */
+  _. = ASSERT ((__CSA_BEGIN & 0x3f) == 0 , "illegal CSA start address") ;
+  _. = ASSERT ((__CSA_SIZE & 0x3f) == 0 , "illegal CSA size") ;
+
+}
-- 
2.26.2


