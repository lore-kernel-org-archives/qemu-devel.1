Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64FBC49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816C1206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMo+23GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816C1206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hiN-0001c3-At
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNp-0005VF-Pe
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNo-00052a-MJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNo-000520-EV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id q17so16120282wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LQ3XAKoDLhaOzqFCNhsIdDGJrHIQSVj/rNDcC6T2wTA=;
 b=CMo+23GR2ChsncBNW3AD8r9qGAl4f70kTqLT5aG9Jjdja+WFEdwIgiGRU3vUBkHmHK
 6g7IHhCCIViRQ7itY+uX+uRkmdTbS6jFCe2GDsFiA+7VDFOPFiQxYrl3BdRIIszrHHQI
 8xqKeC4nzfmjr0TuAA0vuez+W9rFcMyhKQLuda3bYuEg3kZ+5c5H0L88rNXiV72liMKa
 fx4/GDxi3zM6HrfmGQuymVW60BsHXb/JZcHUkYlhonw3vnfSqs/qmJJkUk4FDln6Bghu
 P/oCKXVqQvg1E+IBmwlHkY5bMUnoQJ4gMXT4SRE28PB1FLi+l7PL7ihgxIe/QOPEkN4F
 p4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LQ3XAKoDLhaOzqFCNhsIdDGJrHIQSVj/rNDcC6T2wTA=;
 b=B2w7VyLQ16nPCj8Dedmjnwmsa7IczSkKa5GJNaU1Y5XgDy1TdzBJAWm6Z5CU206ogW
 dJKVdGQBtWKrouCA4krjuJKAtQGCHKiyxMmgdc6bV6i42mZ/trCx6v7jLDhfmn2yQxPS
 ak8yq/D10VGiVQCOr7A97qD8HsohYmbTfuQYo+dVoHoAWB27bdMumwVxGqRsG/U9PIts
 oQ8ntCfJs5y4YnKfjYKrfh2GDfDI9Gh11dnCdqbLR4y1QbeTdmq8ip6EsNUrbaKU8X+D
 af1UukRg87ysF4ZdFxc79zDF3/Ht58Hczi9Hjiv4fOljp5G4Ym0aw7jfe8tZM3vM0bEa
 DdzA==
X-Gm-Message-State: APjAAAVcc6FG1CpeKgLPS1uS/YDZW6PL7w+9MFa3+vZULFO0mJtfT6HX
 k4/NwhhLurPI89KG3/JK2mtUyk0Pe1rhFg==
X-Google-Smtp-Source: APXvYqwTSuSRoBntgDj/KzQenDx0sbxiUbk6vUV45WbULXuar7eWM9Ap2TYHPR6H7uvWX1QSDJ/FbQ==
X-Received: by 2002:a5d:45c3:: with SMTP id b3mr27791244wrs.207.1568126679618; 
 Tue, 10 Sep 2019 07:44:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:23 +0100
Message-Id: <20190910144428.32597-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 08/13] target/arm/arm-semi: Factor out
 implementation of SYS_ISTTY
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

Factor out the implementation of SYS_ISTTY via the new function
tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 48a10dd3c3a..64ed39fc075 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -349,6 +349,7 @@ typedef uint32_t sys_writefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
                              target_ulong buf, uint32_t len);
 typedef uint32_t sys_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
                             target_ulong buf, uint32_t len);
+typedef uint32_t sys_isattyfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf);
 
 static uint32_t host_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
 {
@@ -399,6 +400,11 @@ static uint32_t host_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
     return len - ret;
 }
 
+static uint32_t host_isattyfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
+{
+    return isatty(gf->hostfd);
+}
+
 static uint32_t gdb_closefn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -420,10 +426,16 @@ static uint32_t gdb_readfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf,
                            gf->hostfd, buf, len);
 }
 
+static uint32_t gdb_isattyfn(TaskState *ts, ARMCPU *cpu, GuestFD *gf)
+{
+    return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
     sys_readfn *readfn;
+    sys_isattyfn *isattyfn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
@@ -431,11 +443,13 @@ static const GuestFDFunctions guestfd_fns[] = {
         .closefn = host_closefn,
         .writefn = host_writefn,
         .readfn = host_readfn,
+        .isattyfn = host_isattyfn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
         .writefn = gdb_writefn,
         .readfn = gdb_readfn,
+        .isattyfn = gdb_isattyfn,
     },
 };
 
@@ -600,11 +614,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(ts, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
-        } else {
-            return isatty(gf->hostfd);
-        }
+        return guestfd_fns[gf->type].isattyfn(ts, cpu, gf);
     case TARGET_SYS_SEEK:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1


