Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C66C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D232E21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEhIlvVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D232E21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vxG-0003YB-0d
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl0-0002p2-L7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vky-0004Z8-Tb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:58 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:33410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vky-0004XA-Kw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:56 -0500
Received: by mail-pg1-x530.google.com with SMTP id m5so682068pgg.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=RrHJx1N1kyjQHiPtYBUYw+QZriur1pqPCfrIwJOEUL4=;
 b=MEhIlvVbsnuvpLSLEcF7tUZh6DA8hpgHOrcDQgcuo5zWrLIifMe51fCtVSMn7/zUq5
 veAyBRi8/0tVDkUEL/0h8U/hGqPj/7mXsEfqRL+HnVbkiqQdPHhjy3ORLQS1PtPgQxYC
 2DLiG/18aU6nR2XlQPpBPKe3x8LcS4/kRtjBUppAtGQIONUYXIicArckvIfMQqBEHDyr
 CfiyTcaPIJKuub/evGgkc+EmxM+KWiVf/uTk1j7hpa8VDUYu/X1pQd+Zu+cU3g2MxAWG
 GpGC3ngV2pv3nnMpEwMjyX8CG+7UvBvBobkhATUjzual8eWW/oGhWK4xWQ7jzN0Le9tc
 kPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=RrHJx1N1kyjQHiPtYBUYw+QZriur1pqPCfrIwJOEUL4=;
 b=lqOU0iImeBEl7Mv+tB8TVwyWjlcsvWa8j4rijkC3HR3ryc93OfWotAHLrAe+SajgCw
 jy+EfhZot+51XtWs9O0fii52z/kILcsZWiW6a+30PFME+eCIuEw05TzHZinmp6QIWBOT
 PWNDUKmYDAqeTdkRJ3XDoeDuGUqPgMUsfUPI80qklPKo7Erei1Al5Igybms3ix9UkpVd
 fHaFXa3qn2C6yVrIBVD5bSuz3f/d5Eu0LZs2oDmVOcRCU4eJSsBuroeVE16ZJf2GCCf8
 arB+sCm5Y4Nnaz5LfNFlaovqpFcZ72LT4vOXn9U6ZwJkh/E0UpOV3wZB+Gj6MIM45TCh
 0qBg==
X-Gm-Message-State: ANhLgQ3hIUV4oBQifCwIEuFF3rqm0eHLh2MLXWWA3fFkN418docnKMei
 pxxb3RSBZYOAwslgPpyODAzctw==
X-Google-Smtp-Source: ADFU+vvVlew0D2d9EPOfBBD01bjOh9y3yS3nvgrpIp0+scpM2mV0u084bZIhh9X0Z1vbJ6fShgb2zw==
X-Received: by 2002:aa7:8695:: with SMTP id d21mr1594333pfo.199.1583196594192; 
 Mon, 02 Mar 2020 16:49:54 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id s13sm193947pjp.1.2020.03.02.16.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:53 -0800 (PST)
Subject: [PULL 32/38] target/riscv: Set htval and mtval2 on execptions
Date: Mon,  2 Mar 2020 16:48:42 -0800
Message-Id: <20200303004848.136788-33-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9e28b19c29..d3b764e694 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -840,6 +840,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     target_ulong deleg = async ? env->mideleg : env->medeleg;
     target_ulong tval = 0;
+    target_ulong htval = 0;
+    target_ulong mtval2 = 0;
 
     if (!async) {
         /* set tval to badaddr for traps with address information */
@@ -901,6 +903,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
 
+                htval = env->guest_phys_fault_addr;
+
                 riscv_cpu_set_virt_enabled(env, 0);
                 riscv_cpu_set_force_hs_excep(env, 0);
             } else {
@@ -911,6 +915,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                                          get_field(env->mstatus, SSTATUS_SPP));
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
+
+                htval = env->guest_phys_fault_addr;
             }
         }
 
@@ -923,6 +929,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
         env->sbadaddr = tval;
+        env->htval = htval;
         env->pc = (env->stvec >> 2 << 2) +
             ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S);
@@ -937,6 +944,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             env->mstatus = set_field(env->mstatus, MSTATUS_MTL,
                                       riscv_cpu_force_hs_excep_enabled(env));
 
+            mtval2 = env->guest_phys_fault_addr;
+
             /* Trapping to M mode, virt is disabled */
             riscv_cpu_set_virt_enabled(env, 0);
             riscv_cpu_set_force_hs_excep(env, 0);
@@ -951,6 +960,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mcause = cause | ~(((target_ulong)-1) >> async);
         env->mepc = env->pc;
         env->mbadaddr = tval;
+        env->mtval2 = mtval2;
         env->pc = (env->mtvec >> 2 << 2) +
             ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_M);
-- 
2.25.0.265.gbab2e86ba0-goog


