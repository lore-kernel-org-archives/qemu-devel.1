Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2C5C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1803020733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLALmue8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1803020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17mT-0002GB-9y
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j17lB-0001FA-Qf
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j17l9-0007PU-IW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:01:53 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j17l9-0007OK-Bi
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:01:51 -0500
Received: by mail-wr1-x443.google.com with SMTP id w12so7342636wrt.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jle24mRVWyhiSlJz0ynMllgtOVUvCHA26143XxrUarU=;
 b=JLALmue86Vj1WLKga3IYxtsrrrSb2fZfVjSA/kJG0pu36CzPRvUzZVsTZS/MLQqECo
 B/pvVjUTXM2FfA6nJobQCJk0k/y8NSiwzqPgxjKcgZAoFz8rn71bfPPxGQCDxk0R24zH
 aFOfDq8za89nqwXw4+yDu+04uuodJjU/HevVrYpZLmUGFY67Vw+4qIB4QNXNXJbhDVc1
 Z8lCl7cLpJmLKfevGWR5mTlnnQxW+GE4v9atmDDeJOxbC3Muo7CKfioLGNM+r1y6Ytd2
 /oFDA7M9wtA1d5esX5qfb7XZGcxOIxqLpQMwOSYNhX+FTBU5VvX+DBqTyMzwO2aDIdTO
 trTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jle24mRVWyhiSlJz0ynMllgtOVUvCHA26143XxrUarU=;
 b=I2ts4ago8Ab0WGd/EYLJ6glaOYi0iIdIIyH7IdvSJhTSpGT6ZEaoNhaJm/MhIyvf6k
 XjoOpkWE3YJoa3Ti5pYOF7M26IgIYFbmgwfu9c0z0thaYBaCn0snQi3ljwNhR5P3nEul
 wekqUDutHuEY2FjUAjbcznzfaFB0ygPFP6rspX8EaozrsaBm4pm9tRw5+e6ARSRx/6Yb
 /DaUUo6kJ89s6YVF2QYbopZFkOHPiGxx9s5jXF9UJsiHZO9QaSen+4lxeMjni4y82rX0
 pxYMsB2T90mkRU87qXlvDuc/aLiytvxfo7yaOvdalwy+ZbhJ+GOn+RWIVd16Yc20Drqa
 z56Q==
X-Gm-Message-State: APjAAAWrO+v7OSA3RhmXxBREwl2H6z6yrbl//65jOyFiSXDcL1Q1VAMc
 mpMVINuCzIta0Ba2L+Axj56RNg==
X-Google-Smtp-Source: APXvYqyY8rjzha/DoA1j0XJXXFrzjrREp1fthxF8UV5BIn+M1Xk/cMSEqSeOnZp4Ay6VXzm0A6gxcQ==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr1637970wro.230.1581336109096; 
 Mon, 10 Feb 2020 04:01:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm311305wmc.24.2020.02.10.04.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 04:01:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Implement ARMv8.1-VMID16 extension
Date: Mon, 10 Feb 2020 12:01:46 +0000
Message-Id: <20200210120146.17631-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Richard Henderson <richard.henderson@linaro.org>
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
---
Not something anybody's been asking for, but worthwhile as
a step towards finishing off support for all the v8.1 extensions.

 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2d97bf45e1e..bf2cf278c03 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -672,6 +672,7 @@ static void aarch64_max_initfn(Object *obj)
         t = cpu->isar.id_aa64mmfr1;
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* VMID16 */
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
-- 
2.20.1


