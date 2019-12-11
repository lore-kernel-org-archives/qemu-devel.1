Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5C5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4980B2073D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zToJGI66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4980B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5hK-0006H2-5A
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WD-0003IC-T5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WB-0003Dv-5K
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:21 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5WA-0003AT-Qv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:19 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so24916392wrr.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EBZ3DPnRoL/gVkfjngBhb96wArtd46lZaB9In16XXlo=;
 b=zToJGI66PDBZiVPjo+8oYb3OOwV0rJoYuExUkXp/R0BDL/KjN3pbKzHWMTo2n1nLDB
 lnOvE6y2XYBmJoBTxYB7q46VKXtJH9SIfx4pHoxzJ4NVY2RuZ0mOFmvRRzaoHYojsHbX
 o/NuX0Tr6nfMYNPmr+1meYsr+lg15NHarSfiCeOajHeJdvP2cFMcc15Xvxcj9Tw83XhK
 /VRGXfXF7SoSdijPLubewE75jwEoqAz2UDYGg2GdJO3WYzOZUkTNO5fq76cMVgrDEaAa
 /jxadglFfuU+OnFM/vhKN1FNO1ZmsjtmIdn/JjTMp/BvSHvHYuilaUyegLNryYrnQ8Xr
 Mdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBZ3DPnRoL/gVkfjngBhb96wArtd46lZaB9In16XXlo=;
 b=MNPeSTS2rnNZQXcDS8vFajf3HQzzZpkqRhcqA/H6yg8CyxPGkDJ59r6oMgAEc7TX6N
 eIBMbZBzh5jJJZsHgfFzipsvX8+8aZ13PgNmPUgUIs9LHxFJiESYABBq9Aq8bXnwOsNK
 U07F88+zwxMUNmjgO97NKELUeKebFXyjeuD/4FfjhH07M9b6odGHkImlrcQT0QErqCJZ
 Vp2RnQmTCh9IH6BF+WGG28aZJwUk5jsHWpj6GfHtVW4zMcngcKO6J4AxV+o8qreqh1yP
 bezBEK3hMJYlX77aRyWUQz3pPAgZJc0fm7AiLQZOOFBVytyR3xf1oD5w16ANDpAL0qbG
 ioRg==
X-Gm-Message-State: APjAAAXYX8Bbnfy+/xb3R/eNtPiA+3Y42VZ43XhTZYIsIqlt47MDKcfk
 nH0h4zAARt0qtSAh9GSB5v0VhcnhKYs=
X-Google-Smtp-Source: APXvYqxqxqKa6h2J7yq0/uDYSOcFtz1QIqt8aC3kb0Hl04gwzKA12eGTVepFRYbLJldzO2Md2MaG7g==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr882775wrp.167.1576084276620;
 Wed, 11 Dec 2019 09:11:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s25sm2808856wmh.4.2019.12.11.09.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:11:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1420E1FF9D;
 Wed, 11 Dec 2019 17:05:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/20] target/arm: don't bother with id_aa64pfr0_read for
 USER_ONLY
Date: Wed, 11 Dec 2019 17:05:14 +0000
Message-Id: <20191211170520.7747-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For system emulation we need to check the state of the GIC before we
report the value. However this isn't relevant to exporting of the
value to linux-user and indeed breaks the exported value as set by
modify_arm_cp_regs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - extend the ifdef and make type CONST with no accessfn
---
 target/arm/helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b6e1fe51d76..58592c86714 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5878,6 +5878,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -5888,6 +5889,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
  * Secure state has already been delt with.
@@ -6308,16 +6310,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * define new registers here.
          */
         ARMCPRegInfo v8_idregs[] = {
-            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we don't
-             * know the right value for the GIC field until after we
-             * define these regs.
+            /*
+             * ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST in system
+             * emulation because we don't know the right value for the
+             * GIC field until after we define these regs.
              */
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_NO_RAW,
+              .access = PL1_R,
+#ifdef CONFIG_USER_ONLY
+              .type = ARM_CP_CONST,
+              .resetvalue = cpu->isar.id_aa64pfr0
+#else
+              .type = ARM_CP_NO_RAW,
               .accessfn = access_aa64_tid3,
               .readfn = id_aa64pfr0_read,
-              .writefn = arm_cp_write_ignore },
+              .writefn = arm_cp_write_ignore
+#endif
+            },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.20.1


