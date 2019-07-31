Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EA1C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F6020657
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNmCPw3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F6020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvPu-0001j5-Ja
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60703)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMe-00046H-11
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMc-0003LV-Tb
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:23 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMc-0003Km-OO
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:22 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so23999414pld.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hV2eslCkM9+11E22XGBDo1tPxuDz+vxwGvc3iXR5Q+U=;
 b=QNmCPw3GCuujd8LoT8j4bsCJSixD7op8PTLgNifr81NcecAEkA9d/fNMyHEA/3bPl1
 EiN7CzYJbcBQAHqYrBVOkNpnJWkTqJSNeZ+rlLVnDTfVsYVqMi6Yoj/q7Dvy59N7Vgtz
 mJka6IEPmGDCnUAb0ogeiP7XOzvbfjiupgMvRLVzS9MFGibnBjtyq+RPH6PzaiZzP+VN
 KDXE/qyFcvcXMHouwvNzY+Y6OKs/Dgp3aL0sDLLFm9HyDLG9FbXMbXOeCD2ysmSluVLi
 DXlO9v5a31ollQGNny6RsqgeupPNNtM234csP23pUHdMX+760AQ4e/E23fAmqvMfbJjl
 DLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hV2eslCkM9+11E22XGBDo1tPxuDz+vxwGvc3iXR5Q+U=;
 b=MJdBmb/U3TTpd+7BBR9gNOD0oObjyulNZytlQ2SeGEZ2oDQRV3bF1QCeymvYMWi0Qr
 xxjs6PvuNxbsCkEJjKe0crx+t81tlF+/fZy2QkpxVNIvyjUQ+KPdUA08cw3fpR3W/H61
 sy60gb85T+lM7dMvWb8jCjXAV7bGyDBnbqi9Z+u/+RfDHG6edjBCu9v/3Z+vMMdXyYdq
 kHO5VdYNeBKSMyzYBMO5hHkiIlTEIG3dXop4wgbBoGuI3kh047jzpCpnvFISIb9CzCvT
 +KYvgm0RXw3MHYgOtZFVX64RScERNhy6rzncDKBBAvBbCi5fE9aec/qHCnN4Is7tqfzh
 Cp6w==
X-Gm-Message-State: APjAAAWdvNMb/sy1yjpCaYSlQYMAHr/Q9EOz1OsL4NOF3q95lmanFoGY
 QzMiNK6AIW5ZTN55IxxUrQH9vvuK0go=
X-Google-Smtp-Source: APXvYqxOiDSAeJ+RBMLE5SPQtY//yIxMGzLsjoYBWLyI3JToLrJ4Or80Gl67YMLSVzHF3NPv+CWSVA==
X-Received: by 2002:a17:902:aa8a:: with SMTP id
 d10mr124813523plr.154.1564605501580; 
 Wed, 31 Jul 2019 13:38:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:46 -0700
Message-Id: <20190731203813.30765-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 05/32] target/arm: Install ASIDs for EL2
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VMID is the ASID for the 2nd stage page lookup.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c0dc76ed41..65e3ffbb43 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3452,17 +3452,23 @@ static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int vmid;
 
-    /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
-    if (raw_read(env, ri) != value) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0 |
-                            ARMMMUIdxBit_S2NS);
-        raw_write(env, ri, value);
-    }
+    raw_write(env, ri, value);
+
+    /*
+     * TODO: with ARMv8.1-VMID16, aarch64 must examine VTCR.VS
+     * (re-evaluating with changes to VTCR) then use bits [63:48].
+     */
+    vmid = extract64(value, 48, 8);
+
+    /*
+     * A change in VMID to the stage2 page table (S2NS) invalidates
+     * the combined stage 1&2 tlbs (S12NSE1 and S12NSE0).
+     */
+    tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_S2NS,
+                            ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0);
 }
 
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
-- 
2.17.1


