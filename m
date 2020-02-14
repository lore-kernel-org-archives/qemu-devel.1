Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBEC3B1B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21AF620873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZ/DlAqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AF620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fJK-0002lg-Bi
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7x-00069A-OC
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7w-00015L-Ij
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:45 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7w-0000zN-Bh
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so11551442wmi.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vPNGprCOMcg0mBZ7UWesyY+l4Nq3dOFKdfD9K6E8o5Y=;
 b=fZ/DlAqoLG6noh2KEyBpJOnoWSqe8nLugbokpyEiB+RCEud6RDqwBJCWa18Ygo+zVv
 uj9B2KfA18hBmI6o920dald9AxfPdUOBAbACJ9uQS50xzdbSgppAC5tkCd7DaTJAeGEf
 vi3UJEVAnBEgFl4MNTED9oz9Q082DrPCdSlOmwv9rxhSN8BsjEn5GjhIYHVPMsKi8Q83
 nlyzFqPINTUTmDr0u6ctzxOThfZNP6m8509ELEYHBOwxsfmwufDugNGVHQWR8n4XGmud
 dzVmazI9r2+v7Jp1hcPsYEUoIRRw6PR9IGNRn+mkBFMxmEghGDA6IYssaOyHNtXkF4PK
 tsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vPNGprCOMcg0mBZ7UWesyY+l4Nq3dOFKdfD9K6E8o5Y=;
 b=i+Nm5w2fMfuTFYaQ0qCOb61EN48tC7A1Mrsd486wVoce3MZ0jl0k102Q9yPJ2M4+Ry
 eAKEj8Vykk1RvHmpqoenXa8hnr+PlScw9EFpnmHohnslxUREqHRHBGy8m91Hg7aEfC1z
 qgSkVxUmAqJrzp8YhzyLaxQKv4e5m2NNEtn8uz84BLXopnJxYksDBW4cst80mWOSKZC9
 PzdLi/YcODN314r06boejB1NWRrzCuiZCMNejwBDvglBcumsOQQqP6GW+1yZMiu0FFlG
 NfshxkES3pGcjb/EGDOBXn/FKXzGPoK2lS8GyEcg8QlMedG5D/iX/8x/EE7MBku7IJ+J
 Bd4w==
X-Gm-Message-State: APjAAAUpNHp+PsL75Wz6jpDyGCJBI/Oupn3krRcyZhefR8+CjVPTPZVJ
 iNppiSr4sDt3QJIlv7qzeqzn2A==
X-Google-Smtp-Source: APXvYqzx7EpzyD7roVoNtWBfLOfGKMFdJSOTZJTG7jEISbiBUY2RR172xi9wnNi2s7SCCB9cBlcGrw==
X-Received: by 2002:a05:600c:294:: with SMTP id
 20mr5973217wmk.135.1581702702178; 
 Fri, 14 Feb 2020 09:51:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 17/21] target/arm: Correct handling of PMCR_EL0.LC bit
Date: Fri, 14 Feb 2020 17:51:12 +0000
Message-Id: <20200214175116.9164-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The LC bit in the PMCR_EL0 register is supposed to be:
 * read/write
 * RES1 on an AArch64-only implementation
 * an architecturally UNKNOWN value on reset
(and use of LC==0 by software is deprecated).

We were implementing it incorrectly as read-only always zero,
though we do have all the code needed to test it and behave
accordingly.

Instead make it a read-write bit which resets to 1 always, which
satisfies all the architectural requirements above.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2ebfa6c6545..468e4e89848 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1023,6 +1023,11 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMCRC   0x4
 #define PMCRP   0x2
 #define PMCRE   0x1
+/*
+ * Mask of PMCR bits writeable by guest (not including WO bits like C, P,
+ * which can be written as 1 to trigger behaviour but which stay RAZ).
+ */
+#define PMCR_WRITEABLE_MASK (PMCRLC | PMCRDP | PMCRX | PMCRD | PMCRE)
 
 #define PMXEVTYPER_P          0x80000000
 #define PMXEVTYPER_U          0x40000000
@@ -1577,9 +1582,8 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         }
     }
 
-    /* only the DP, X, D and E bits are writable */
-    env->cp15.c9_pmcr &= ~0x39;
-    env->cp15.c9_pmcr |= (value & 0x39);
+    env->cp15.c9_pmcr &= ~PMCR_WRITEABLE_MASK;
+    env->cp15.c9_pmcr |= (value & PMCR_WRITEABLE_MASK);
 
     pmu_op_finish(env);
 }
@@ -6370,7 +6374,8 @@ static void define_pmu_regs(ARMCPU *cpu)
         .access = PL0_RW, .accessfn = pmreg_access,
         .type = ARM_CP_IO,
         .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-        .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
+        .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT) |
+                      PMCRLC,
         .writefn = pmcr_write, .raw_writefn = raw_write,
     };
     define_one_arm_cp_reg(cpu, &pmcr);
-- 
2.20.1


