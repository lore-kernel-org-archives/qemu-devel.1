Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA36C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E8E24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guvLTyNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E8E24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQ4k-0007UR-Jy
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzE-00029m-Ga
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPz6-00020m-3t
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:39 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPz5-000200-Tc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:32 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so310176pjc.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BFKFdYg9bKKfhy9lDw8L1ZCFfQivRqO9ZppMWCQhFOg=;
 b=guvLTyNyQmxd+Dr7uAFv7OVC2074iYqG9Ae5l6y6EebFnYP0BBFNhgCr5HHlb6RjG3
 4QufwmnB87K8iv8cJYew+oYSWbBu/hzzu8YyY+ybXBwwMSQkZ5tGGQu5JF8+/dC9jynf
 tqS9Gz9NpgaqeTVM8+5tlVVg5R4j9hJDDezjbQRjrueW5nA02krA7qQe+GvXjvP4EvL6
 H34HdhHeuK4QB/9BatXAzf+8xJvagyOcDStlm9WdLsQnzejlpENjDASkZDNmzeZWlz3G
 J26B0fVi2iK/sL02LGcubCvGd16IhOwoERZpmZJO4qjsgvxCjEByCVeKxIHYv1ybYp0F
 PAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BFKFdYg9bKKfhy9lDw8L1ZCFfQivRqO9ZppMWCQhFOg=;
 b=n3FlxK8Vm4p4qjbw4R0ab5g8yqfyPhA9dCqhCFadgNt7lslfYyRKy8FPjg5prX3Uws
 4XTxWwg8QmaO0BHatjgnHMGWjqrZ6pBuWJEemXE/bf+XNsSFY2LJ7gncM8iA05Ty0MZm
 /db68W0EfF84NP6lQtTakza3aLLa3Z3sg72tl5rdLZgyFbTyE3E2iOL0k3jC5zF99ynh
 Dx1OiEMFSLcYjdN3s+LQG1Ygc2yXcNzMRH1++9tTgrj/aR/jw/75n7KL7CNzyH5VaNkR
 6zzM9wO0ER8Gy4VXK0nNSCu+FjcwjRcGZkueAq+Ope81y1Li6ikTzDy2rscK6jny1GbH
 wrEA==
X-Gm-Message-State: APjAAAXgqVvTUt1ikfK1OqdALG5pgAEtcShY6fwz4CMxZKEqPZjSUKxV
 Y+nm9hNDEh2YvoBztg/gEqNFjihGFWM=
X-Google-Smtp-Source: APXvYqx17PluGh9J356JA1rBSM8nRgls/9j4DZjMaTVGR0CHc3DFv7bSarMXozt5qj7y14AqwwagKg==
X-Received: by 2002:a17:90a:2e84:: with SMTP id
 r4mr1261013pjd.64.1579737810395; 
 Wed, 22 Jan 2020 16:03:30 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 08/24] target/avr: Add instruction translation - MCU
 Control Instructions
Date: Wed, 22 Jan 2020 14:02:51 -1000
Message-Id: <20200123000307.11541-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.216.65
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes:
    - BREAK
    - NOP
    - SLEEP
    - WDR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <20200118191416.19934-9-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 target/avr/insn.decode |  8 +++++
 2 files changed, 76 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 58775af17c..4c680070e2 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2681,3 +2681,71 @@ static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
 
     return true;
 }
+
+/*
+ * MCU Control Instructions
+ */
+
+/*
+ *  The BREAK instruction is used by the On-chip Debug system, and is
+ *  normally not used in the application software. When the BREAK instruction is
+ *  executed, the AVR CPU is set in the Stopped Mode. This gives the On-chip
+ *  Debugger access to internal resources.  If any Lock bits are set, or either
+ *  the JTAGEN or OCDEN Fuses are unprogrammed, the CPU will treat the BREAK
+ *  instruction as a NOP and will not enter the Stopped mode.  This instruction
+ *  is not available in all devices. Refer to the device specific instruction
+ *  set summary.
+ */
+static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_BREAK)) {
+        return true;
+    }
+
+#ifdef BREAKPOINT_ON_BREAK
+    tcg_gen_movi_tl(cpu_pc, ctx->npc - 1);
+    gen_helper_debug(cpu_env);
+    ctx->bstate = DISAS_EXIT;
+#else
+    /* NOP */
+#endif
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs a single cycle No Operation.
+ */
+static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
+{
+
+    /* NOP */
+
+    return true;
+}
+
+
+/*
+ *  This instruction sets the circuit in sleep mode defined by the MCU
+ *  Control Register.
+ */
+static bool trans_SLEEP(DisasContext *ctx, arg_SLEEP *a)
+{
+    gen_helper_sleep(cpu_env);
+    ctx->bstate = DISAS_NORETURN;
+    return true;
+}
+
+
+/*
+ *  This instruction resets the Watchdog Timer. This instruction must be
+ *  executed within a limited time given by the WD prescaler. See the Watchdog
+ *  Timer hardware specification.
+ */
+static bool trans_WDR(DisasContext *ctx, arg_WDR *a)
+{
+    gen_helper_wdr(cpu_env);
+
+    return true;
+}
diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 4ee55862b2..f8d32f2258 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -172,3 +172,11 @@ BST             1111 101 rd:5 0 bit:3
 BLD             1111 100 rd:5 0 bit:3
 BSET            1001 0100 0 bit:3 1000
 BCLR            1001 0100 1 bit:3 1000
+
+#
+# MCU Control Instructions
+#
+BREAK           1001 0101 1001 1000
+NOP             0000 0000 0000 0000
+SLEEP           1001 0101 1000 1000
+WDR             1001 0101 1010 1000
-- 
2.20.1


