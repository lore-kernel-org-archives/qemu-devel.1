Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BA3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8725A20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDJZ9whY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8725A20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tb0-0006wv-MT
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPO-0003rT-Vq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPN-0002pz-Pl
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:38 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPN-0002ow-Ik
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:37 -0500
Received: by mail-wr1-x441.google.com with SMTP id v9so1193942wrf.10
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GcAJxWDNSGTspp+5s6989zkqDBTuK9utm7+Chogt0Os=;
 b=QDJZ9whYfkbTWWQSMeEN+S5ankQr5zlzSJ8Ji8J/3ELlrw//fnugUdnMK82qlpQDIN
 HGBSAHFSkDoEsffYdFf3GdPajPP0AYltLTiWT2anZQqGGegmSl6/pAdwn5YgEU4tjvFQ
 nnpZeDl0FWpj5SmZ1cHHppqmRcSByMbNsj31uGD+i4kPd3v6x90r28OGFBEysHe2cUAM
 9vxqLBglA3baJYH4O7ZL/6LfxTUubcdkmTi2g2TnIsv+5xtjp+6AQKignF5jsOFP3AsD
 wm7Q35gnp+U1BaM5hXDFnB4UcQK12EE6O5MaSGokdRM1ntZDB38Ir/VcHbhJ30fwvsFh
 zSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GcAJxWDNSGTspp+5s6989zkqDBTuK9utm7+Chogt0Os=;
 b=ICSHTjGnJa7eNY6EADhtX9ZqnHz/Q1VvYI+pJyvbJTAB4514MhNKgJ1S0qFXVjGEHE
 hw14M+VcAXezsuKFu43Dm9Wtc8FBktpOmDPR8TNW35ohvDf91ZElB2Kk9sy11Zr6Xcyy
 Pdu8rAAtQsOKWmZ5iIibB3dHVftd663UneNMfFKek3SFbWaku+sKqQmJZLyAWbjW9aeZ
 bmrjti5qGMboZzmG+//rEFo9kftnCaByRCJbiHOFWGxzroqHlAHVRP4/cRuakUUQ2aMv
 zvBk3TksptghWynGbYtqWgA22FNoxfRZ149loURR4BjgOiusuMVFCq00o0cXxstsNqsn
 hvcA==
X-Gm-Message-State: ANhLgQ0OmKPjDt/4SxYN3JqHrcUYPyJgpdUsajEm1/uRKlu8FjGvK1lS
 Y93kiyiRlOvQHWn8W9gUA21oWNNGYTeN+g==
X-Google-Smtp-Source: ADFU+vuYoRrGcI89o+asApd+wMkPJntQ9ZIn/SU2v9Ah9dcEPCelA4TbIMf4ohFJaJ3KPKnFzjaB+g==
X-Received: by 2002:adf:ee02:: with SMTP id y2mr5083477wrn.23.1583425896249;
 Thu, 05 Mar 2020 08:31:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/37] target/arm: Replicate TBI/TBID bits for single range
 regimes
Date: Thu,  5 Mar 2020 16:30:54 +0000
Message-Id: <20200305163100.22912-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

From: Richard Henderson <richard.henderson@linaro.org>

Replicate the single TBI bit from TCR_EL2 and TCR_EL3 so that
we can unconditionally use pointer bit 55 to index into our
composite TBI1:TBI0 field.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200302175829.2183-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6abf52db660..f7ba34bbf6d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10458,7 +10458,8 @@ static int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
     } else if (mmu_idx == ARMMMUIdx_Stage2) {
         return 0; /* VTCR_EL2 */
     } else {
-        return extract32(tcr, 20, 1);
+        /* Replicate the single TBI bit so we always have 2 bits.  */
+        return extract32(tcr, 20, 1) * 3;
     }
 }
 
@@ -10469,7 +10470,8 @@ static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
     } else if (mmu_idx == ARMMMUIdx_Stage2) {
         return 0; /* VTCR_EL2 */
     } else {
-        return extract32(tcr, 29, 1);
+        /* Replicate the single TBID bit so we always have 2 bits.  */
+        return extract32(tcr, 29, 1) * 3;
     }
 }
 
-- 
2.20.1


