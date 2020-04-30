Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2CCC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7738720757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t629mrB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7738720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7uq-0000SK-KH
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jn-0003VM-A6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jk-0000Sf-J5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jk-0000S8-5f
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id x25so1516707wmc.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wt7yqTcgLmF8JzV1SCxT47djUoUbTeewI0QoooN4y4U=;
 b=t629mrB1Igtt1yuc0y8PjYGlnrtr4RJ9rbE2WScZ/U+cxmHplriamrEgxvhfG7WfTr
 NyqCdhR2oIHlm57iyNVTr/akpfpP85P4vAw+Vas02I0UyfS2Dg+Ul47ZO6IgRr19hKMW
 SOBk8tbRJal+IaZRieGrVvLZwD5hgNLQ4K2DFSm3lwCiuGCJNHxCtNHnCNrdWntrU+4B
 HfnGgcvml8dAKNlzNuR9hWuRCoSd0lm5wWzmOGG7MgOExC7X2vfPM7hRqpNmyJA1NcS2
 uLVNCvHpDsoxAcqghWlF3CAc0FQnhKNA6LtYQWGzdoL7I19+FpyvSdBGJT/ndW3bKbGP
 1Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wt7yqTcgLmF8JzV1SCxT47djUoUbTeewI0QoooN4y4U=;
 b=NNZGl0dBafph7qygJuuP3apslt1BSNTMQWOeP60x00erRj7fHBjOIbyXGcfyzEM5eA
 hKNT3Qcv2s1POSrrGX/AmGo1k6CiB7k7f7MMX6f49FNHP0a8oKUHRF4CYFUy37FFOkwz
 ZhmqxVsLLBqMHDfRcsQZy6jiBeKaOS998leEf9A2wI/Ffwf7zxfFJLIK0xscYbw69/RV
 bxTviMgS9wxVAu8B6o5iZunqxEJh562AS80avWlEQ5sUvCRybyqAELmpwWuB6u4JP3mX
 3ZYP570fSBvn4LyGcpoNPUlkZLdtn8RW+W3DlQjrfENWxVcqOAse5NdvAMfFbjVR7JPP
 S4iw==
X-Gm-Message-State: AGi0PuZFXuMX2CfHHcW2XeXAlPaEHHKBDxZjRzmuszpPkY0M8GCPqNtJ
 +GABN42Qau59SzijbfyOvA2CY+zdCsXghg==
X-Google-Smtp-Source: APiQypJZiMd7WesfSIN4WOwclYf2u2Zczw5Whe5qzKlk/C9r/OmQW2AfeqfZ44bgGRjjkHYYNSKSSA==
X-Received: by 2002:a1c:4304:: with SMTP id q4mr2757248wma.152.1588247534493; 
 Thu, 30 Apr 2020 04:52:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/31] target/arm/cpu: Update coding style to make
 checkpatch.pl happy
Date: Thu, 30 Apr 2020 12:51:38 +0100
Message-Id: <20200430115142.13430-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32d
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We will move this code in the next commit. Clean it up
first to avoid checkpatch.pl errors.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200423073358.27155-5-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 30e961f7754..a1e38b38ba1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -582,7 +582,8 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     CPUARMState *env = &cpu->env;
     bool ret = false;
 
-    /* ARMv7-M interrupt masking works differently than -A or -R.
+    /*
+     * ARMv7-M interrupt masking works differently than -A or -R.
      * There is no FIQ/IRQ distinction. Instead of I and F bits
      * masking FIQ and IRQ interrupts, an exception is taken only
      * if it is higher priority than the current execution priority
@@ -1912,7 +1913,8 @@ static void arm1026_initfn(Object *obj)
 static void arm1136_r2_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    /* What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
+    /*
+     * What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
      * older core than plain "arm1136". In particular this does not
      * have the v6K features.
      * These ID register values are correct for 1136 but may be wrong
@@ -2698,7 +2700,8 @@ static const ARMCPUInfo arm_cpus[] = {
     { .name = "arm926",      .initfn = arm926_initfn },
     { .name = "arm946",      .initfn = arm946_initfn },
     { .name = "arm1026",     .initfn = arm1026_initfn },
-    /* What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
+    /*
+     * What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
      * older core than plain "arm1136". In particular this does not
      * have the v6K features.
      */
-- 
2.20.1


