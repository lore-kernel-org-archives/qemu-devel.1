Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26A8C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 17:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC8F20820
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 17:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAh8az9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC8F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw8RD-0004OY-Nu
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 13:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37943)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hw8Qr-0003pc-3U
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 13:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hw8Qq-0006cy-0j
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 13:12:01 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hw8Qp-0006cV-O6
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 13:11:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id r26so10209992pgl.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ytkVX0l93V8o0cYS4Oq6t62B9ZsJBOcYFtRg7HNNvw8=;
 b=OAh8az9D3ZF272uDEsz4bf6PbWDxKUa72Iouu7bUj/0XwOG8R+ydJ66Qp1idhNsXWk
 VSkNV7s+SVOGcxCDS6IaWeqPk0pvrP95MqKBGM2TkY/x3nfbgIds97F5yNTuhgdqvFf/
 iFpChpPIBb29wnBb27DeAe7XnBTuijCLhKScout51dRJnNNT5uSbHHlO6B5dt+W6Cq+/
 wUln9RomXdU52Edlrc7MzgllELLd7LprsH/Eps/gjn7oPwA1iwku1dGgGO2O4Re+K2CO
 PnZ0NfdbGMM9t94dS5dz0deW6v0S6O4Zhbiaojy4E2WkGcW4c2cYRTkO/4DQT7j1sAZL
 oQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ytkVX0l93V8o0cYS4Oq6t62B9ZsJBOcYFtRg7HNNvw8=;
 b=dSWTj1pgSwXcH+hTj6PItGuv613aKIpbKLIiCh8jwQOYPL81G2HCTSzzOue26YJ0rI
 5BaSqKpvKRb/aQWWZVcWcnMcU/akwNiQwPAbtUNchKeP9Nw/2ANrMNq10jHzvO7T8/u9
 umf9Uf88pLITrVMvQX+bTe9vKNA17K0d8hAkD33MOymbTe+eFq2dr1NAg49hetCopg/p
 wzgR0Hn3023JLzX57mxaPxt1c3mwMfEG+JmDydeeuNXS1w/qyr3SzPbycj3Mof3CMtc5
 oH7V7KcCXTqIQ060cMU3mK6bb2sGQ/lhxNeLggB2he+Z+11bfAXSuMt6y+plcb4MCcQ/
 qp2w==
X-Gm-Message-State: APjAAAX9XxxDn/TRqvVUmpjFKiPpBmD8MBI7EBC3SFZYlMkcsiaWtQBy
 9g2kbN+erAByxRd3cFGNUtwOfxNGQNM=
X-Google-Smtp-Source: APXvYqySxdZhIkOeZjsh+xEfUzMrOT9e9uqx6jgRH9jodXLonQ9Ds0TYzh8cPkIhj/P+RcDQ+1szew==
X-Received: by 2002:a62:874d:: with SMTP id i74mr22155960pfe.94.1565370718261; 
 Fri, 09 Aug 2019 10:11:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id l189sm119049433pfl.7.2019.08.09.10.11.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 10:11:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 10:11:56 -0700
Message-Id: <20190809171156.3476-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH] linux-user: Add AT_HWCAP2 for
 aarch64-linux-user
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the HWCAP2_* bits from kernel version v5.3-rc3.
Enable the bits corresponding to ARMv8.5-CondM and ARMv8.5-FRINT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)
---

The HWCAP2_FLAGM2 and HWCAP2_FRINT bits came in during the 
last merge window and will be in the upcoming v5.3 release.
We don't yet implement any of the other extensions that make
up the rest of the HWCAP2 bits.


r~


diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bd43c4817d..4fd2f46f18 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -606,9 +606,23 @@ enum {
     ARM_HWCAP_A64_SB            = 1 << 29,
     ARM_HWCAP_A64_PACA          = 1 << 30,
     ARM_HWCAP_A64_PACG          = 1UL << 31,
+
+    ARM_HWCAP2_A64_DCPODP       = 1 << 0,
+    ARM_HWCAP2_A64_SVE2         = 1 << 1,
+    ARM_HWCAP2_A64_SVEAES       = 1 << 2,
+    ARM_HWCAP2_A64_SVEPMULL     = 1 << 3,
+    ARM_HWCAP2_A64_SVEBITPERM   = 1 << 4,
+    ARM_HWCAP2_A64_SVESHA3      = 1 << 5,
+    ARM_HWCAP2_A64_SVESM4       = 1 << 6,
+    ARM_HWCAP2_A64_FLAGM2       = 1 << 7,
+    ARM_HWCAP2_A64_FRINT        = 1 << 8,
 };
 
-#define ELF_HWCAP get_elf_hwcap()
+#define ELF_HWCAP   get_elf_hwcap()
+#define ELF_HWCAP2  get_elf_hwcap2()
+
+#define GET_FEATURE_ID(feat, hwcap) \
+    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
 static uint32_t get_elf_hwcap(void)
 {
@@ -620,8 +634,6 @@ static uint32_t get_elf_hwcap(void)
     hwcaps |= ARM_HWCAP_A64_CPUID;
 
     /* probe for the extra features */
-#define GET_FEATURE_ID(feat, hwcap) \
-    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
     GET_FEATURE_ID(aa64_aes, ARM_HWCAP_A64_AES);
     GET_FEATURE_ID(aa64_pmull, ARM_HWCAP_A64_PMULL);
@@ -644,11 +656,22 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
 
-#undef GET_FEATURE_ID
+    return hwcaps;
+}
+
+static uint32_t get_elf_hwcap2(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    uint32_t hwcaps = 0;
+
+    GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
+    GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
 
     return hwcaps;
 }
 
+#undef GET_FEATURE_ID
+
 #endif /* not TARGET_AARCH64 */
 #endif /* TARGET_ARM */
 
-- 
2.17.1


