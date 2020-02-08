Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2346C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B0E20726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNSpIODd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B0E20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pn6-0004KU-PV
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgr-0000Xr-1y
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgq-0004mw-0L
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:28 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgp-0004kT-Qi
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:27 -0500
Received: by mail-wr1-x443.google.com with SMTP id z9so2005214wrs.10
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ovq6zgHOTulKMgq/xQFAYxCo50RIglYC4qMYC5kDj6w=;
 b=wNSpIODde3vl4gV01F+TyZqhfEtZmnarHKukxP47IeFAbl4vXActWeUuJBMk86i7rT
 1sGvexGBYJORTMwCnlEmIPnIUkxFLdAfgDZ1g66WMX0kIQE0ktKFrpfUYlYNieAilHXn
 4xNGGXnv5col+ns2c50YwReQ+A6YzhuiScKo9U4acenMV3VzXVz9qC251/r+FjLjwp4d
 tgcra/tDgKYAWAfinbKCJiKLrN9KueEBmYSbBD5WfyQdOFMPO1S9Y1YGqRcVgenf3hDa
 vlk2MMZeKvM/c1Mc1Hb9RfSYyEgtHnDY+rZ4un14BYDPXKxY5PoB/sjG1HJb8CGREwTp
 9dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ovq6zgHOTulKMgq/xQFAYxCo50RIglYC4qMYC5kDj6w=;
 b=Zyj9LhUEFEzehpiPv0zva0DaQLZhNFGKH1gUs7FwWCYPfcZf6lH5kxN0wTKs6i4Qsy
 icOWFJuKRqog0KnUMqmZ8yfbaz3gsy1THMogGuJSDLI1cod5Bi/ppBko1Vt8c+g/xFdk
 NzVRxM6/lYvQLTviuRRUNpnUWybsg9m/gVUkK7ZqXfr1yObvWA4sbebJmzkB9oHBr6CJ
 0kx3Xn8cTtSRTOG/UYyKXb6lOSMQemligWBnoJBQEhCB60npLBTi6N7YMMru9dtTZi1N
 A+va+BR9kAf9tHtPlcZ6OtvruBXBqorhb+OVLww+8lnX28Mk6aj9XN4ioFGtnwPgWBAK
 ONCQ==
X-Gm-Message-State: APjAAAXCEZSa3Ha4oIV9hV8VmMM3o3+nxTuya0kXsMZFay5Kl/JA0pyX
 1z228TgW6ctO1cV40dibdqdTQhya5EMvfA==
X-Google-Smtp-Source: APXvYqy/5Eijl4VJVcExrbNT/l7sAiGGfvPTVQ2QKIRuwU0xtKRRhYcbEXDmlFd2WfYhuVHjeCRqLw==
X-Received: by 2002:adf:ea4a:: with SMTP id j10mr5202640wrn.119.1581166706692; 
 Sat, 08 Feb 2020 04:58:26 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/20] target/arm: Remove CPSR_RESERVED
Date: Sat,  8 Feb 2020 12:58:05 +0000
Message-Id: <20200208125816.14954-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only remaining use was in op_helper.c.  Use PSTATE_SS
directly, and move the commentary so that it is more obvious
what is going on.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 6 ------
 target/arm/op_helper.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 694b074298..c6dff1d55b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1186,12 +1186,6 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_IT_2_7 (0xfc00U)
 #define CPSR_GE (0xfU << 16)
 #define CPSR_IL (1U << 20)
-/* Note that the RESERVED bits include bit 21, which is PSTATE_SS in
- * an AArch64 SPSR but RES0 in AArch32 SPSR and CPSR. In QEMU we use
- * env->uncached_cpsr bit 21 to store PSTATE.SS when executing in AArch32,
- * where it is live state but not accessible to the AArch32 code.
- */
-#define CPSR_RESERVED (0x7U << 21)
 #define CPSR_J (1U << 24)
 #define CPSR_IT_0_1 (3U << 25)
 #define CPSR_Q (1U << 27)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index acf1815ea3..af3020b78f 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -387,7 +387,14 @@ void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
 
 uint32_t HELPER(cpsr_read)(CPUARMState *env)
 {
-    return cpsr_read(env) & ~(CPSR_EXEC | CPSR_RESERVED);
+    /*
+     * We store the ARMv8 PSTATE.SS bit in env->uncached_cpsr.
+     * This is convenient for populating SPSR_ELx, but must be
+     * hidden from aarch32 mode, where it is not visible.
+     *
+     * TODO: ARMv8.4-DIT -- need to move SS somewhere else.
+     */
+    return cpsr_read(env) & ~(CPSR_EXEC | PSTATE_SS);
 }
 
 void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
-- 
2.20.1


