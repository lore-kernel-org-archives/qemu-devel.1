Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C6C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E722E20738
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtqShFO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E722E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLa8-0002Vt-Ug
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVv-0003nY-Lm
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:11 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:52209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVu-0002Nq-1N
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:11 -0400
Received: by mail-pj1-x1034.google.com with SMTP id a9so3823783pjg.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u9Y0vjaPuoAkxScaNqtUASpr1pIzL6DgrA0aESQcv0g=;
 b=YtqShFO1A4ZndEV+x+M8Y+VYv9PJxOAW5+QvLHcKwailjNcGvs+K+Yc6fZCichoghj
 5dRP4EmpaM4TI5NPJYWWk7joVN3WVIP0ATVjL6BzcTWhSpV49YQ5fLFznW2tKzQpCScf
 rQz2JpVWp3/nfbLCO7K01yz2ozD3nVz5r2IgAnotPg0i/9CBj6pUpYMo5XKuuXJ8QDkH
 x76One/cStZ1yVUQJyJZKq8DJQYYcVIanGm2mecXW39hCXrYJzIEb7P3IgkTM+JoOE7L
 OP/2Km4uM8NdmvXsYbNOfVmG3I+eqb1EMVk/2/FoA88NZt6ibJkH6d4AhnbKC2dtIKzq
 mImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u9Y0vjaPuoAkxScaNqtUASpr1pIzL6DgrA0aESQcv0g=;
 b=rDvwUtdcs8lQ6rQQikeujPpE0SpQMQ/lsDW9xFVLEHu+69Ug3q7DvkoQ5IKiZF/vuj
 w1mgU9qbianOYzlJjL2oEhhcsBH6shOPnlEACJcwut3UE1+BsuHyayyFD/RyaN50qgPt
 +DI5Fmggl92G6ZRj01P/SXawHFYLSP7znxMex2XU1mpQKW4MdGcs3XPI7gDnJjXXRCEJ
 2EkyKtkgZ23bTL6exZRbFz53uTw6RVftoB4dzW3WfJuCR+uf6I/6UC17A4JZJqXXepKG
 DsC4Q0+EO/OHo4uwQ3HvHKSHy2HTrdNDnyuWni/CUMqdFcs8/m/CeNXTwAZAdJykiIFW
 iajw==
X-Gm-Message-State: AOAM531rWsQyUMBRPPFjDTuURU128R+rlpxwNZrMSW80tBtMdzknBazb
 FVZy63jzrBnkTOIy924s1G/LbarpN1ppog==
X-Google-Smtp-Source: ABdhPJxH+TGVFumt327dwAHc8q4lncjFoYP03pAbvRK9p8YZNQwZwjIwznif3R+QicWrL/qTuJXoXg==
X-Received: by 2002:a17:90b:3355:: with SMTP id
 lm21mr415925pjb.125.1599501907643; 
 Mon, 07 Sep 2020 11:05:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm11367768pfi.38.2020.09.07.11.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:05:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] target/microblaze: Treat pvr_regs as constant
Date: Mon,  7 Sep 2020 11:04:55 -0700
Message-Id: <20200907180459.29025-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907180459.29025-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
 <20200907180459.29025-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Do not allow gdb to set the values, and don't bother dumping
unchanging values with -d cpu.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/gdbstub.c   | 4 ----
 target/microblaze/translate.c | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 9e3b9ac824..be39fd4540 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -132,10 +132,6 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     case GDB_BTR:
         env->btr = tmp;
         break;
-    case GDB_PVR0 ... GDB_PVR11:
-        /* PVR12 is intentionally skipped */
-        cpu->cfg.pvr_regs[n - GDB_PVR0] = tmp;
-        break;
     case GDB_EDR:
         env->edr = tmp;
         break;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9e4551d99b..eca422b3db 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1919,11 +1919,6 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  env->esr, env->fsr, env->btr, env->edr,
                  env->ear, env->slr, env->shr);
 
-    for (i = 0; i < 12; i++) {
-        qemu_fprintf(f, "rpvr%-2d=%08x%c",
-                     i, env->pvr.regs[i], i % 4 == 3 ? '\n' : ' ');
-    }
-
     for (i = 0; i < 32; i++) {
         qemu_fprintf(f, "r%2.2d=%08x%c",
                      i, env->regs[i], i % 4 == 3 ? '\n' : ' ');
-- 
2.25.1


