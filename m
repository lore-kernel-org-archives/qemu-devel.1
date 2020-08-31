Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37597C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB736206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2lRUWSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB736206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmR8-00026c-31
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmK5-0003ih-Sm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:21 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmK3-0005wO-V1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:21 -0400
Received: by mail-pl1-x643.google.com with SMTP id t11so3245408plr.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2lk+ZBWQv/ZXsPrb8oTjpivGovxY9zx2pXrc7J4dxPM=;
 b=X2lRUWSfLxP75aJVqWsUnA87fqiUroI4bDp2dCk9ctGSgd7fwNJ0nrQSXDDQhicmLM
 DN8qq9+nAZmNOlHOBNQROdqwUnyVGfD9P8IHPk2aacLpZ3AmnBVbfKCDV8wmnnmFIXeG
 mW9GcR35z6BmQnrEX7VAJn1hNn/Y3nR/hS4YjkxmcR35npPmJuCI6wi0AnJW9qzBS0AK
 /jcHlQTNeffUf7tBFz0++7f5F53D7jb+VTLNk1vwsUUJOelXX6ZUxCgXBXSmw7hc5qii
 M7Em6nvUAnQkhEYA8EadPs6TntAJ7J8kWTs4ANubbw3Dn9seG9/+efRmw4No8yxSrDIB
 4xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2lk+ZBWQv/ZXsPrb8oTjpivGovxY9zx2pXrc7J4dxPM=;
 b=hBiRE3w4t4ERTNFqiEMaOyMPnTXvNFPbZhavTmbrJ9ve/bkQIrSo20WIiHSNfmPJGB
 d6YaE/XsV9tuBDm9lRTbTKKIaP0fNcDDdBtWYxKd3T/vuK1+b6lBNhRbs249J4W3jcwk
 DpdaxiC8IamUEbneAbT5gVACgetTK8+HRgXmG76yaB7JX8TpAsKdCCYpGIlOh/2kmpEV
 ZJYLUpNKXDYqcIWxdQhLz5qNbXfNSMpK+bz3MdMIxE8aX1jr7IKDXkA6AfgJENnfr9Bs
 T2vqDB3dqluzeCngIp3BMhbujHoU1pCrhV9yiFt/L//N6QyZuF1ggDDxI6bMJEUWVeLG
 plkw==
X-Gm-Message-State: AOAM530s2W2Hzrbes+Zx4tVhiY8uj7DMpi0ymHs50N66v6UDo5387cI3
 JPX3llMF07P/ec59uKzAtaPjP3VIumvUZQ==
X-Google-Smtp-Source: ABdhPJwBKVnswPYj4NMtd55sGUZzce2fHd5YUjdo/JvDPeBVP/GXgi4iHIWspH7RsbbPhpYmnrxKTQ==
X-Received: by 2002:a17:902:708b:: with SMTP id
 z11mr1577952plk.326.1598889978061; 
 Mon, 31 Aug 2020 09:06:18 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/76] target/microblaze: Split out BTR from env->sregs
Date: Mon, 31 Aug 2020 09:04:55 -0700
Message-Id: <20200831160601.833692-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue eliminating the sregs array in favor of individual members.
Does not correct the width of BTR, yet.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 1 +
 target/microblaze/gdbstub.c   | 4 ++--
 target/microblaze/helper.c    | 4 ++--
 target/microblaze/translate.c | 6 ++++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index bcafef99b0..deddb47abb 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -241,6 +241,7 @@ struct CPUMBState {
     uint64_t ear;
     uint64_t esr;
     uint64_t fsr;
+    uint64_t btr;
     uint64_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 2634ce49fc..cde8c169bf 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -74,7 +74,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->fsr;
         break;
     case GDB_BTR:
-        val = env->sregs[SR_BTR];
+        val = env->btr;
         break;
     case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
@@ -130,7 +130,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->fsr = tmp;
         break;
     case GDB_BTR:
-        env->sregs[SR_BTR] = tmp;
+        env->btr = tmp;
         break;
     case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index ea290be780..b240dc76f6 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -132,7 +132,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             /* Exception breaks branch + dslot sequence?  */
             if (env->iflags & D_FLAG) {
                 env->esr |= 1 << 12 ;
-                env->sregs[SR_BTR] = env->btarget;
+                env->btr = env->btarget;
             }
 
             /* Disable the MMU.  */
@@ -160,7 +160,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             if (env->iflags & D_FLAG) {
                 D(qemu_log("D_FLAG set at exception bimm=%d\n", env->bimm));
                 env->esr |= 1 << 12 ;
-                env->sregs[SR_BTR] = env->btarget;
+                env->btr = env->btarget;
 
                 /* Reexecute the branch.  */
                 env->regs[17] -= 4;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c58c49ea8f..469e1f103a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1811,7 +1811,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  "rbtr=%" PRIx64 "\n",
                  env->msr, env->esr, env->ear,
                  env->debug, env->imm, env->iflags, env->fsr,
-                 env->sregs[SR_BTR]);
+                 env->btr);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
                  "eip=%d ie=%d\n",
                  env->btaken, env->btarget,
@@ -1879,8 +1879,10 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, esr), "resr");
     cpu_SR[SR_FSR] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
+    cpu_SR[SR_BTR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr), "rbtr");
 
-    for (i = SR_FSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
+    for (i = SR_BTR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
         cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
-- 
2.25.1


