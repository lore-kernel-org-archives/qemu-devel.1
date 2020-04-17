Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F01C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD182076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gztDRzsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD182076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWTm-0000wy-Ci
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNi-0002go-OK
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNh-0005LX-Jk
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:30 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPWNh-0005JA-Bj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:29 -0400
Received: by mail-lj1-x243.google.com with SMTP id q22so3200624ljg.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eFVwLS4HPN4oqr0mH+SQHWdJFcIbsw3m7YyR83VCRKI=;
 b=gztDRzsG1tIftHUgWi8hworbKaq+Iy/B54cbxUDsHevQabD7CIcYxx08o6qZqvd86o
 mhsA0URcjhKJZG3xmf5mYoqXZ58wl+/h/If6I0UCxzYV9KTq/XQZkZH82JVjhz+m8LPy
 k+3AbPlq5mBeaeiPuvxTAXzrlbRMZlMOi20x+u1cJOaB6mVQ/HW3+prHU5vAjcVyqYrO
 tYcAJrq7RIi197leQPCmWBTdM2M0+obMHHpHF/cAS1Ir5E3kWWzB1EUyjtIxzVRRrWBG
 XI4h6P7HRlIDbPL4kn11QPL+OMvMZ/Tg8DTCintZm9Ixsn3MpvQY8CqItfBeY4RfKfo3
 3m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eFVwLS4HPN4oqr0mH+SQHWdJFcIbsw3m7YyR83VCRKI=;
 b=jKRpSEnkFGYWXv66Vr6GvAvQFXlaI4Jqt13AP9HGy3QVt/EMQS9CgJ3YRjBfoFRnbp
 nILeXRi8aDbx64dBMcIwMdV3C5b0i2yL4LY9yQ6PkY7DtKaT63yOLa3W1MoNOBVvkuV9
 cM/ngS1b6llk3aZ2LjU6+aLV+RqRF2infIzhe23ikLmhDDZqAwOpZFWxURXHgrRz2Dgt
 gMXSKmmJ613Ahjx4wrJyoFe+mbrGxYYNv6owde77W3i9FjfPFBw/XAJXN4NHu78DdA07
 ci40G1Wa6dcwE1EwiZgJMARUr/EolqPv+5tCK9jrEbAIezLJQ+vXEXKR1V/8ERjmbVU+
 41hA==
X-Gm-Message-State: AGi0Pub3g3Nl67A7k2ZSoka2WHjMLOB44U1D1y3BqarhJwug4u3hPDqJ
 W5P20MGqh1oOOL1jIHU+INbD0hdVX8wVDg==
X-Google-Smtp-Source: APiQypKr9oxIrWwX1ClKwiSKo+IkX4EmRA9vvdsZGGHwGVClgQrJKAr+fmlauHglC/+v336hPvIypw==
X-Received: by 2002:a2e:998c:: with SMTP id w12mr3068945lji.57.1587150627577; 
 Fri, 17 Apr 2020 12:10:27 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q19sm1656943ljj.84.2020.04.17.12.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 12:10:27 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/6] target/microblaze: Add the div-zero-exception property
Date: Fri, 17 Apr 2020 21:10:19 +0200
Message-Id: <20200417191022.5247-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417191022.5247-1-edgar.iglesias@gmail.com>
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the div-zero-exception property to control if the core
traps divizions by zero.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 2 ++
 target/microblaze/cpu.h       | 1 +
 target/microblaze/op_helper.c | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 36c20d9724..7a40e2fbad 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -280,6 +280,8 @@ static Property mb_properties[] = {
                      cfg.iopb_bus_exception, false),
     DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
                      cfg.illegal_opcode_exception, false),
+    DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
+                     cfg.div_zero_exception, false),
     DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 71d7317a58..3c07f9b3f7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -305,6 +305,7 @@ struct MicroBlazeCPU {
         bool iopb_bus_exception;
         bool illegal_opcode_exception;
         bool opcode_0_illegal;
+        bool div_zero_exception;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 18677ddfca..f3b17a95b3 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -132,11 +132,12 @@ uint32_t helper_carry(uint32_t a, uint32_t b, uint32_t cf)
 
 static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
 {
+    MicroBlazeCPU *cpu = env_archcpu(env);
+
     if (b == 0) {
         env->sregs[SR_MSR] |= MSR_DZ;
 
-        if ((env->sregs[SR_MSR] & MSR_EE)
-            && !(env->pvr.regs[2] & PVR2_DIV_ZERO_EXC_MASK)) {
+        if ((env->sregs[SR_MSR] & MSR_EE) && cpu->cfg.div_zero_exception) {
             env->sregs[SR_ESR] = ESR_EC_DIVZERO;
             helper_raise_exception(env, EXCP_HW_EXCP);
         }
-- 
2.20.1


