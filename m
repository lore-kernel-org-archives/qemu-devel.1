Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44163C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C96220644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SqQsgaYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C96220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsS8o-0005J5-CY
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47410)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsS87-0004XE-N3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsS86-0007qx-E2
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:25:27 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsS86-0007pW-7d
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:25:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2so56623883wmg.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k60h7N7EIxaxf66BX3JejTtIWy6wazpW1QrSO9+z374=;
 b=SqQsgaYn4x7sPE1mhDmtKxdm3DwOJylh7+/jy+3XPBr2Gd1ivE9/I2YWQpej8mLirR
 SdBnu9+SbHWq61lOdbFQDyh3XlqVtJMuVn7m0pZmUlrIyJTdmjLAtCaAIbQnU5ZjXNB5
 C6QIw5OvyTIutOlN+pfvq/JNibzCBFdCmLkuH2Lto3VCqTIrbo8UeclYBN/oQA7XjuZA
 qAmrYFMi6qlfvuHyrIaXnzoFbNImm62lqvy0ZeXE63+OBr3uFlvI7pnY1Rou8T/05rZN
 LdMKwf8tVowaPordwBMPLdAdOQn+UjxzrRyA76EJOET6yvRzfyS6sVenSjK3mTy1FfKB
 EZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k60h7N7EIxaxf66BX3JejTtIWy6wazpW1QrSO9+z374=;
 b=TI+wj37XbcMszA2YAyF2NfCdivhBccjw2a55kB/WY+zhh+7YY4Wh9vaauv7w2JDVPC
 1ofMibvZiIYBMVO1+30DS4iXSne+4WZKyFnqGm2ppe2aniDVzUP2HrYFkhXwchjA3xlw
 /J2+hZOTyNXsyicB3hBw4z5/I3Pe+5WtXMCb2eG4f/8vjU+p25Gt0dz8gtJOK2FI59f+
 bFDjYX3tChoRBH2PycDYOCkEUvXXiHC37vAGYJm/MQA8uj97nOiUKGpuHZonwdtnjYYG
 3x7xfZLPydcU/PiEzH4POOB7N1m80/FJxKPjsQkl7ErQHM3xjVB4jVwbFe3PmEugjXpy
 g64w==
X-Gm-Message-State: APjAAAVkjD/d6FrVxQFKdx76cTs8+MDkIVewSRjRiT7PcG4NWLkf/wyu
 GFzKU49n1NihJkidv/8S4Kyz/Q==
X-Google-Smtp-Source: APXvYqzYshGyq5SwwStPFWF3ni4qtOvANH3e9PhZZLi5q2xpbc0RegCMuSsFffg39y+/Fb+lcjxF3Q==
X-Received: by 2002:a1c:b457:: with SMTP id
 d84mr111200322wmf.153.1564493124885; 
 Tue, 30 Jul 2019 06:25:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f1sm44391896wml.28.2019.07.30.06.25.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 06:25:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 14:25:22 +0100
Message-Id: <20190730132522.27086-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH for-4.1?] target/arm: Deliver BKPT/BRK
 exceptions to correct exception level
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

Most Arm architectural debug exceptions (eg watchpoints) are ignored
if the configured "debug exception level" is below the current
exception level (so for example EL1 can't arrange to get debug exceptions
for EL2 execution). Exceptions generated by the BRK or BPKT instructions
are a special case -- they must always cause an exception, so if
we're executing above the debug exception level then we
must take them to the current exception level.

This fixes a bug where executing BRK at EL2 could result in an
exception being taken at EL1 (which is strictly forbidden by the
architecture).

Fixes: https://bugs.launchpad.net/qemu/+bug/1838277
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
At this point in the release cycle I'm not sure we should put this
into 4.1 -- it is definitely a bug but it's not a regression as
we've been wrong like this for multiple releases, pretty much
since we put in the debug handling code I suspect.

 target/arm/op_helper.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 1ab91f915e4..5e1625a1c8a 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -370,6 +370,9 @@ void HELPER(exception_with_syndrome)(CPUARMState *env, uint32_t excp,
  */
 void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
 {
+    int debug_el = arm_debug_target_el(env);
+    int cur_el = arm_current_el(env);
+
     /* FSR will only be used if the debug target EL is AArch32. */
     env->exception.fsr = arm_debug_exception_fsr(env);
     /* FAR is UNKNOWN: clear vaddress to avoid potentially exposing
@@ -377,7 +380,18 @@ void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
      * exception/security level.
      */
     env->exception.vaddress = 0;
-    raise_exception(env, EXCP_BKPT, syndrome, arm_debug_target_el(env));
+    /*
+     * Other kinds of architectural debug exception are ignored if
+     * they target an exception level below the current one (in QEMU
+     * this is checked by arm_generate_debug_exceptions()). Breakpoint
+     * instructions are special because they always generate an exception
+     * to somewhere: if they can't go to the configured debug exception
+     * level they are taken to the current exception level.
+     */
+    if (debug_el < cur_el) {
+        debug_el = cur_el;
+    }
+    raise_exception(env, EXCP_BKPT, syndrome, debug_el);
 }
 
 uint32_t HELPER(cpsr_read)(CPUARMState *env)
-- 
2.20.1


