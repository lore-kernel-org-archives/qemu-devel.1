Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734CCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B361E204FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcWRJD+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B361E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQSmx-0001j3-KD
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 05:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSf3-0001EE-42
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSf1-0000qx-3H
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:52:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSf0-0000d0-TO
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id q130so8376472wme.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Wh/QH/3UtP8gd1jgQHJ/Qv7q+ZrFPgvBOyLNaqirHw4=;
 b=PcWRJD+2t9c1RwGAyxjqMq/hHwGAencq1Rz+H1oWSHpe2aBI2Vv49/EhUt7sNMkTBu
 qrYeScn/sm7js4jf2JgWznQgI6ryoC8oULJeyH/keLkFYXO9g5S6mqOy6mBAFlzTr2J9
 w2P7Q/JhgVhBUAXovmGrTAgpCIcpFpUPFCY0XpaL91xzXZjSsC2zcGPe4VedocwrczGj
 rc7hVBddwVuTHiFpI0paq/weOCjLPfRh8U5ALb4UzF12OOUKJFWqDvP+2IayzVQAj8y4
 RdO47tGe+BTakUoK0Twh1PGV38pOEI05+Zu92knMLm6uzyqRZ+bpTUtL923A06kySGLf
 xg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wh/QH/3UtP8gd1jgQHJ/Qv7q+ZrFPgvBOyLNaqirHw4=;
 b=OtQQ8iU/Mk0G5NZ9M5ahFw7T4WxilEdCpIHffsuWDgQ+MlpeMXGIjBEqJHXlHZQ7CG
 AmpG03hSBEm056QODIGT1gRDbeJyFsNJJisu/MdERaSfk4LW28J9yqBu5uiJ6z3n1QBY
 xOw1A7gq824Vf+p9SfkYVv57N02RXIcr06qtAERVd/YHbwQKgS48IiC4TkD+R3plf78q
 PdUQPBwBeFawt93Zc6fe6J+OUa97WE/cj0GmPHjBlG6y4J1nznbHcA6lxFzhx2doSi3B
 oTjzTghcZ1BT2+NlpCT9jbNztb5yZKY1r2RgjeHdYu5FUlgt1t1hbNFVzhs+uftHOVCc
 FUrg==
X-Gm-Message-State: APjAAAUi9IAp4/pCzMakRQtkn8xAcYqfgSMP2xqD3VMY/88aaLOGmpnA
 /f1BGJuIZHXsG4Kozg85oA9pj2DD1NCUEc8Z
X-Google-Smtp-Source: APXvYqzIRzau0TZnveTb+rU2IukXzB95XIe4M6w5yQzD89o0iqjdtt+U7CpRjhcMF7ctIWB6MMlPLA==
X-Received: by 2002:a7b:ce0c:: with SMTP id m12mr9325256wmc.38.1572598315697; 
 Fri, 01 Nov 2019 01:51:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d20sm8818922wra.4.2019.11.01.01.51.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:51:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] target/arm: Allow reading flags from FPSCR for M-profile
Date: Fri,  1 Nov 2019 08:51:40 +0000
Message-Id: <20191101085140.5205-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101085140.5205-1-peter.maydell@linaro.org>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Christophe Lyon <christophe.lyon@linaro.org>

rt==15 is a special case when reading the flags: it means the
destination is APSR. This patch avoids rejecting
vmrs apsr_nzcv, fpscr
as illegal instruction.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christophe Lyon <christophe.lyon@linaro.org>
Message-id: 20191025095711.10853-1-christophe.lyon@linaro.org
[PMM: updated the comment]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 9ae980bef63..85c5ef897be 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -703,9 +703,10 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
         /*
          * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
-         * Writes to R15 are UNPREDICTABLE; we choose to undef.
+         * Accesses to R15 are UNPREDICTABLE; we choose to undef.
+         * (FPSCR -> r15 is a special case which writes to the PSR flags.)
          */
-        if (a->rt == 15 || a->reg != ARM_VFP_FPSCR) {
+        if (a->rt == 15 && (!a->l || a->reg != ARM_VFP_FPSCR)) {
             return false;
         }
     }
-- 
2.20.1


