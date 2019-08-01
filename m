Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD4CC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 10:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247D2206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 10:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIVOUUDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247D2206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht8mx-0002F2-BS
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 06:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ht8mK-0001iJ-NJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 06:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ht8mJ-0006YB-DB
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 06:57:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ht8mJ-0006Xj-5M
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 06:57:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id y4so73096047wrm.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i5yczFfVrAVlR4940QCcbKeiFq9wP+iOiA2djQVLfF0=;
 b=SIVOUUDmYzu8CzBNXMzZrqYbvaV+X5Fdm5H8GwoaxpNJb88ybs5sf1HNQwzwXIBwYQ
 lrbUca/7V2THxZsbYTcGHOQ1MtmrdyhL+Jv/maFlX+0liLv2evo+59aOnBYewHsA2b1N
 g46rbGEpyTKRPoSsRjbDagjGmsMOzemlKNkKZ9k2fZaSwCMa0ej/1lAgrMLaedn8Ldz/
 dqOjoHnFFkRsCgs/JW8YVYXsZjn+cBWuAfiz/kDHMVPPrdcFxsK+IOWrDxrHS385MFNR
 wgpKpijAWEaHFNJOea7GR7z5JuOfeeQ1Ki9lf+DHnODqCujgU7g5zJeoG6Y/Wnwh3iiZ
 2+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i5yczFfVrAVlR4940QCcbKeiFq9wP+iOiA2djQVLfF0=;
 b=C1ScFGLGeB2PER29acZbtVYRB5yXSeeAYr1M4dkypkeiFJjV8HbI+Lpyh0GSUkXgUz
 FUJDvPn9q5Pz8A8beIEN3x6GVhlOKl79Itg7dRZXHJ/OTe6ivgK676NhakpQGrG8qCM3
 upZCNgGxo7EVrnz/rfJ7n/w5C/m07utavGkKsS7MHYZK7BI1mE4GHX6hK1bLItU4W+7S
 UQ8Lp1qmLcwqtg8wRBXDJSlOuidbFYr20v9D4ZPWvRYkxMC6vmhwVoxC32WS38IOwGW4
 6WU84IoxP5mD2lW7nJUxI+u6eRRrwPzVOwZNYq3kLDWRNKemitgBV0KTl3jXghL/N6RJ
 Dn9g==
X-Gm-Message-State: APjAAAU/5XPww2/NZoYyjXJvAbi1Ca8SWlABa4LoiqBjdPaymLDfMj0/
 kSEcbrM23xxtx4isSMJbpRDeEg==
X-Google-Smtp-Source: APXvYqwwM9Hawd0U9pUV1WLp+RkK3J/4CO/HAt22unUylWxWOrCpFKlaoXnVeFb9vZaDLingMcjMdQ==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr20438551wrl.79.1564657065815; 
 Thu, 01 Aug 2019 03:57:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j16sm17320424wrp.62.2019.08.01.03.57.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 03:57:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 11:57:42 +0100
Message-Id: <20190801105742.20036-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH for-4.1] target/arm: Avoid bogus NSACR traps on
 M-profile without Security Extension
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

In Arm v8.0 M-profile CPUs without the Security Extension and also in
v7M CPUs, there is no NSACR register. However, the code we have to handle
the FPU does not always check whether the ARM_FEATURE_M_SECURITY bit
is set before testing whether env->v7m.nsacr permits access to the
FPU. This means that for a CPU with an FPU but without the Security
Extension we would always take a bogus fault when trying to stack
the FPU registers on an exception entry.

We could fix this by adding extra feature bit checks for all uses,
but it is simpler to just make the internal value of nsacr 0x3ff
("all non-secure accesses allowed"), since this is not guest
visible when the Security Extension is not present. This allows
us to continue to follow the Arm ARM pseudocode which takes a
similar approach. (In particular, in the v8.1 Arm ARM the register
is documented as reading as 0xcff in this configuration.)

Fixes: https://bugs.launchpad.net/qemu/+bug/1838475
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've marked this as for-4.1 because support for M-profile FPU
is new in this release and this is a pretty bad bug for it.
It probably doesn't qualify as so bad we need an rc4 but I
think we need an rc4 anyway and it probably does merit putting
in at that point.

 target/arm/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9eb40ff755f..ec2ab95dbeb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -266,6 +266,14 @@ static void arm_cpu_reset(CPUState *s)
              * on ARM_FEATURE_V8 (we don't let the guest see the bit).
              */
             env->v7m.aircr = R_V7M_AIRCR_BFHFNMINS_MASK;
+            /*
+             * Set NSACR to indicate "NS access permitted to everything";
+             * this avoids having to have all the tests of it being
+             * conditional on ARM_FEATURE_M_SECURITY. Note also that from
+             * v8.1M the guest-visible value of NSACR in a CPU without the
+             * Security Extension is 0xcff.
+             */
+            env->v7m.nsacr = 0xcff;
         }
 
         /* In v7M the reset value of this bit is IMPDEF, but ARM recommends
-- 
2.20.1


