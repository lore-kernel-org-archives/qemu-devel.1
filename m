Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154FFC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCD4206B8
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEZ1ygaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCD4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYtY-0000cw-Na
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYsR-00082f-LE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYsQ-0004zp-Cb
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:12:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYsP-0004x9-FN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:12:45 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so5656486wma.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gY20XIqz7mV7zfDHHT5A+VN6sPrcRfLAjkaDTVDSoOA=;
 b=KEZ1ygaGTHnpisWtq1VhUxy6tnUQuFKb6vPzeZSqPQnhlCLKp68SNULldgrqXJX2TY
 Zn4FF+qDsodkNd/Th1Y+HZqhw5omMIR+sagolW+Gq59LItrp7tr8Dlka8rldwCBeVtJJ
 r4ES9aDcO4q+eipy4r9gYZAVNZXGEmay4KXhHaOg1Ds+HvJ6LaqvDGIVZclMmmWB3hPB
 g+wo8f7gFkS1xbvtlAAoA6JEGVA+BD8FvmtGBOKCuoQJh8LiD5SzrBeKo1f5p761gIbT
 CkKG1KQaYBQfANCt4qTicRoWqffBjn6zBUfeFeIsrhI3/5OYAdNCKR8NhggFvA1HWyHy
 GzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gY20XIqz7mV7zfDHHT5A+VN6sPrcRfLAjkaDTVDSoOA=;
 b=ER3evkBhsFTZB5PbwdGM2zXDSP2vaa2xnxvAgSDCjXEyRa8E1yUs1MXyEsz7PdYFBE
 xRlk99NEQ78x75dCPUGvXOvE3DXAjzau3Dpj/Wy9pfI/I7lt1LxQNdG6qckddEXQp8yA
 G5JFcYNvFlzGVws0tmJMiUVK0z9knMNQjTuB1Hbw8WfwWTxuDgA9HbJR+UmHluUvdt8t
 0HIJsc7O9KotWztPdL5/d5AzxbSCGbaMJTA3tpVh86A4n1QT3VhZeXTH7RrObiQggnzI
 WS7x95dwKFVFXt6T5ikNIpzElXWeFgb7bybDBFLaMR9NGj139XpWfFx9rbKaDOsA3nme
 PMtg==
X-Gm-Message-State: APjAAAX3f+qGHl64tmQ1qSJ6PXRc/IvsC8k4xF9yWz+spIcQlLpUMvv6
 efK5HWeHfsa4An/tH/wKQaa4nA==
X-Google-Smtp-Source: APXvYqwclBEHaJdzgMBhYqtV8ugDNqk9R2hwXQ8H0E5vbluQxddrOlRUatdhmQz/Ti/jIz0V9s4hIQ==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr4158324wma.107.1562850763731; 
 Thu, 11 Jul 2019 06:12:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c30sm7684800wrb.15.2019.07.11.06.12.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 06:12:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 14:12:41 +0100
Message-Id: <20190711131241.22231-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 for-4.1] target/arm: Set VFP-related MVFR0
 fields for arm926 and arm1026
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ARMv5 architecture didn't specify detailed per-feature ID
registers. Now that we're using the MVFR0 register fields to
gate the existence of VFP instructions, we need to set up
the correct values in the cpu->isar structure so that we still
provide an FPU to the guest.

This fixes a regression in the arm926 and arm1026 CPUs, which
are the only ones that both have VFP and are ARMv5 or earlier.
This regression was introduced by the VFP refactoring, and more
specifically by commits 1120827fa182f0e76 and 266bd25c485597c,
which accidentally disabled VFP short-vector support and
double-precision support on these CPUs.

Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 1120827fa182f0e
Fixes: 266bd25c485597c
Fixes: https://bugs.launchpad.net/qemu/+bug/1836192
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
v1->v2: just move the arm1026_initfn() part up a few lines;
this seems trivial so I've retained the reviewed-by tags.

 target/arm/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e75a64a25a4..05b78ba2662 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1666,6 +1666,12 @@ static void arm926_initfn(Object *obj)
      * set the field to indicate Jazelle support within QEMU.
      */
     cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+    /*
+     * Similarly, we need to set MVFR0 fields to enable double precision
+     * and short vector support even though ARMv5 doesn't have this register.
+     */
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
 }
 
 static void arm946_initfn(Object *obj)
@@ -1702,6 +1708,12 @@ static void arm1026_initfn(Object *obj)
      * set the field to indicate Jazelle support within QEMU.
      */
     cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+    /*
+     * Similarly, we need to set MVFR0 fields to enable double precision
+     * and short vector support even though ARMv5 doesn't have this register.
+     */
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
 
     {
         /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0,0,2 */
-- 
2.20.1


