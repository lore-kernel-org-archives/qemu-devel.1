Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E7C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8317E20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lk71exPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8317E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G82-0006wj-J3
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhS-0004vf-2u
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhQ-0002WM-Ve
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:41 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhQ-0002TE-PD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:40 -0500
Received: by mail-wr1-x430.google.com with SMTP id y11so6977917wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iWwaon9BlRJ6IRsO5FFrvf144MipU5RYg6PS8QIH0hk=;
 b=Lk71exPORdaSvPe5/fddMtjBxmxb3W+KzuUS56nBM0FXoIIlu9U1Zu+TX3RXqyj1No
 C0x0HFCHTmRX6Xzpm+sRSlvR2yx780RNtjTOihzW623HBa0/ZG/BDCBwv4/jxWi+DkG3
 n3AyLs1/NByCGcWxooHwolAXxG4t7g9rJuQjsCb4V6sEe049SBKXYDy/jFeAr2KaJb0s
 a+c+38zV0HcVy3wKVovmczXnaOaY01Q1X04ArE+SYFI4YMR6M0cA8s3GaLa8od/sG9eZ
 iqw7MaA+YrRtKtzX6ZHilZ/B4XKfvxK3/3gEZQ5Q7z/gKtLXBju3sg0IftQj90WhorhA
 LbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iWwaon9BlRJ6IRsO5FFrvf144MipU5RYg6PS8QIH0hk=;
 b=o0cWp21Hna16xrHsx/ViSMhBLMMrL1/GdKfvjkGNKc+Diq1+WW0dKbGxHaRea+Y3mV
 HAy5sK/BsobnMQ3cfQiK8qn0vfwK1xezcAxMy89vOV2wVCwTXP7zoc3xgIJat3/EVNhQ
 XuvsZYM/P2gpYBSYgt+GAv7dCO3mDUeMF9icD7uJnIZ3KVt2izrvoPJ1EN93bDZ/ccNx
 rJpVNkiMoYcJ/YKrW/gj04ND4OfutEWwO1BO1a8JiUe4UNQwb6hUeXEmgTeYtlU0GXCY
 N1aVrhoICp3OL/F5WCOLWUnOf8mzFOFe/d/+jXCd1HZeXVfLgUFwi4wI+vrzm05q7qB4
 PmtA==
X-Gm-Message-State: APjAAAUa92JVYfFY1geTIgIIvR1ONBN1GHiK6q2ORRJAROgjVh8WnxT3
 pDli93bc1gOP2B6kqntcn2pJggdSuME=
X-Google-Smtp-Source: APXvYqzAv9BtiwHKUielbgPSN92VtlIJ3B88G/bPVGJAsEu3NBV9qbvogEUq2liVf+dfBjM9+Nso1A==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr21701309wrv.3.1581604958432;
 Thu, 13 Feb 2020 06:42:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/46] target/arm: Implement ARMv8.1-VMID16 extension
Date: Thu, 13 Feb 2020 14:41:45 +0000
Message-Id: <20200213144145.818-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

The ARMv8.1-VMID16 extension extends the VMID from 8 bits to 16 bits:

 * the ID_AA64MMFR1_EL1.VMIDBits field specifies whether the VMID is
   8 or 16 bits
 * the VMID field in VTTBR_EL2 is extended to 16 bits
 * VTCR_EL2.VS lets the guest specify whether to use the full 16 bits,
   or use the backwards-compatible 8 bits

For QEMU implementing this is trivial:
 * we do not track VMIDs in TLB entries, so we never use the VMID field
 * we treat any write to VTTBR_EL2, not just a change to the VMID field
   bits, as a "possible VMID change" that causes us to throw away TLB
   entries, so that code doesn't need changing
 * we allow the guest to read/write the VTCR_EL2.VS bit already

So all that's missing is the ID register part: report that we support
VMID16 in our 'max' CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200210120146.17631-1-peter.maydell@linaro.org
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1359564c554..f0d98bc79d1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -674,6 +674,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
+        t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* VMID16 */
         cpu->isar.id_aa64mmfr1 = t;
 
         t = cpu->isar.id_aa64mmfr2;
-- 
2.20.1


