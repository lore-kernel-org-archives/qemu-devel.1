Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49937C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C6F20679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpQysJr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C6F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbS95-0005o4-7T
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43486)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbQrO-0002bJ-77
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbQrM-0002oF-2T
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:37:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbQrK-0002lb-7I
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:37:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so18408980wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vg7Xo5/UC1VbFfsv57lBg2sMr1tbPeBB7dgbx/Rj6+I=;
 b=PpQysJr3UfhlfG8/PoFpVoWNqOdZpq+eqslUhspPaWdgr+li5AzXV1FXe1fmmNBgwz
 AclDX0N/iPz4q0+k+zSQ63PuQIBONq6zSN3qfyHhQncfeYjwEpXRYhAoO+BgHdzT/oI+
 xk+MB+h3NE+mWSMpkWRsnAjlqEKwhihAnl6PJERaLCNYVbYQfPe/l2auV+VufFNuqHGO
 FqJCY+RNadEJJU2cilCvG0nTKSCTkBIfmFbVL6plz94u8SZFq+3CsiO5mBwsXyqe4smo
 Yj3pWoB9ozWNOMnxPeLe0bwVCwPj7drlWEHnpRC6QdkEx2cOrXh4vXSMYXWEBNlUOL44
 ITlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vg7Xo5/UC1VbFfsv57lBg2sMr1tbPeBB7dgbx/Rj6+I=;
 b=s+sSIjl7JOwGpoLIQwl4r8q3tAQv39zLpTQ69THFkvzEkJVUgg3AwqB6z6yx8luE8J
 btAXJXH29IaU1FDyd7cpGmt57U+mf+BIhAn6KDHt7G/3Q2WXuLMU6hxSgR7wy24/NtzB
 +5d1caQ2vlVZ8ZR24jtztzjWrJYWSDP5KwA49lKVikWEOroIsyVe2eL3eE081SHmDIuv
 u9wjaCrJY1OBp4vYEdvtqhY8Btj+2hHl9cDC+I4aQfyy5novyIiLjwnPY+q9xYm2Gfzy
 XV1CMOpWfoMiSlG1VSnk23z5aqHpOJtW0SSRGn4ANWxmL5kENsurvLU6ywOKNbwBpQUo
 VEBA==
X-Gm-Message-State: APjAAAUFtEnRWkCvelx8jVbvbFw4d2DyZWgpdwHik6VE4SBXsMcFidqc
 ESP8FB08Umo3T52T/UBKfkH1MQ==
X-Google-Smtp-Source: APXvYqxZ6otB1rSV1A6SDeJeENHh83bcRYL2/YgH/F9f4fetn0N03a1lJhOlijFuMTq/qmkkslfGMQ==
X-Received: by 2002:adf:9023:: with SMTP id h32mr60639641wrh.95.1560436663820; 
 Thu, 13 Jun 2019 07:37:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l12sm3080344wrb.81.2019.06.13.07.37.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 07:37:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 15:37:41 +0100
Message-Id: <20190613143741.15128-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [RISU PATCH] arm.risu: Avoid VTRN with Vd == Vm
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AArch32 VTRN instruction is specified to give an UNKNOWN
result if Vd and Vm are the same register; avoid generating
this in risu output, as we already do for VUZP and VZIP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Alex: this pattern error is why we don't pass your
testcases/aarch32-all/insn_VTRN__INC.risu.bin when compared
with a real Cortex-A7. You probably want to update that.

 arm.risu | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arm.risu b/arm.risu
index 9009e6b..c16d245 100644
--- a/arm.risu
+++ b/arm.risu
@@ -613,7 +613,8 @@ VCLT0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 100 q m 0 vm:4
 VABS A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 110 q m 0 vm:4
 VNEG A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 111 q m 0 vm:4
 VSWP A1 1111 0011 1 d 11 sz:2 10 vd:4 00000 q m 0 vm:4
-VTRN A1 1111 0011 1 d 11 sz:2 10 vd:4 00001 q m 0 vm:4
+# d == m gives UNKNOWN results, so avoid it
+VTRN A1 1111 0011 1 d 11 sz:2 10 vd:4 00001 q m 0 vm:4 { ($d != $m) || ($vd != $vm); }
 # d == m gives UNKNOWN results, so avoid it
 VUZP A1 1111 0011 1 d 11 sz:2 10 vd:4 00010 q m 0 vm:4 { ($d != $m) || ($vd != $vm); }
 VZIP A1 1111 0011 1 d 11 sz:2 10 vd:4 00011 q m 0 vm:4 { ($d != $m) || ($vd != $vm); }
-- 
2.20.1


