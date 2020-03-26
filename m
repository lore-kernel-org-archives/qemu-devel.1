Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E743C2D0E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78AB20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wN1R3Hy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78AB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYPF-0007aQ-3Q
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK6-0006LA-Iq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK5-0001SQ-F5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:50 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:39013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYK5-0001SG-BD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:49 -0400
Received: by mail-qk1-x741.google.com with SMTP id b62so8192558qkf.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=97xhNcyTh5DcJuk00OWjjs6901pDVYNbXDltjgblU0Y=;
 b=wN1R3Hy5doDWbp6cKhMKpQbu0ZhsSBmsMoRR82mCRbLSOvkBZYhKhzKJhFwshMJKku
 LZzS1e+L5/73whb1nwanySG7EH/OQW5dVdP6relBHIBdvO6jQEt4HjMgxRgrBFzWrFIw
 i0pGLNUC91HgWy4wa3bCjCbmguNXZJGY/3hJ+bAcLw3Mgd/RxByir55MvFvHAUekvjvC
 OXOL5b8V5VXxoudm5rp0QkQVwqzTJvYS6C5vubSvMLj0TQCVyL7fzQK9Avg8+TbE/G9N
 ZQOmstWUDKT2xoT5y9zS9W32O8k5YMufH4IySxm+CryfHoekCAYkfYcTuK9QKXwnrIXH
 ivPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=97xhNcyTh5DcJuk00OWjjs6901pDVYNbXDltjgblU0Y=;
 b=QiK9R3cUEMJnKcRPSBR4GUKU7FK6mxB5j1c46qLpQbpOsTID5KpYiPdiyNDmJeeKfE
 ARrK2L7XEHP6wI9p3Pra7wAl3GOVHS4NS16Tb5KajgvlxVLMWoVKuIxq2qJIsGOeq0F/
 w+z7TPNF0nfBENGo+6BbYVE0PPGD6mRVOoR3vw6wPllE+zz1v75pgOFbQlSfJ5DS1ulC
 YrwyyqA+3Zot0sWzFK2DY9DewUrMACvUy5WUikFu4AQhQrhcoJ+RCRm0ECKxkVMFdr9m
 GiqPQxUdBHGkal94SrpSIb5YZB9DZH9EMT+S3n29IpBuGgkehM+0I1lzijs/wWRyG1eA
 EcDw==
X-Gm-Message-State: ANhLgQ2Nx/WH7/Z94wy0w1XRNtuyvSGw8fkBom3NQ38uA8YkNJLfiJFq
 qfGLFkieBWOkEczibkeqmjoPDzGJL4c+1w==
X-Google-Smtp-Source: ADFU+vuprn4nP0hxCHIjbcu7vDz2qxmsuES/t9oU2Rjuf5ry4d6XR4Zbb9xJNWMHuemPKr+qI8PBEg==
X-Received: by 2002:a37:b002:: with SMTP id z2mr9876197qke.289.1585251468535; 
 Thu, 26 Mar 2020 12:37:48 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:47 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 12/74] m68k: convert to helper_cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:54 -0400
Message-Id: <20200326193156.4322-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/m68k/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0f80888203..16a64e4776 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -44,7 +44,6 @@
 #undef DEFO32
 #undef DEFO64
 
-static TCGv_i32 cpu_halted;
 static TCGv_i32 cpu_exception_index;
 
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
@@ -80,9 +79,6 @@ void m68k_tcg_init(void)
 #undef DEFO32
 #undef DEFO64
 
-    cpu_halted = tcg_global_mem_new_i32(cpu_env,
-                                        -offsetof(M68kCPU, env) +
-                                        offsetof(CPUState, halted), "HALTED");
     cpu_exception_index = tcg_global_mem_new_i32(cpu_env,
                                                  -offsetof(M68kCPU, env) +
                                                  offsetof(CPUState, exception_index),
@@ -4698,6 +4694,7 @@ DISAS_INSN(halt)
 DISAS_INSN(stop)
 {
     uint16_t ext;
+    TCGv_i32 tmp;
 
     if (IS_USER(s)) {
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
@@ -4707,7 +4704,9 @@ DISAS_INSN(stop)
     ext = read_im16(env, s);
 
     gen_set_sr_im(s, ext, 0);
-    tcg_gen_movi_i32(cpu_halted, 1);
+    tmp = tcg_const_i32(1);
+    gen_helper_cpu_halted_set(cpu_env, tmp);
+    tcg_temp_free_i32(tmp);
     gen_exception(s, s->pc, EXCP_HLT);
 }
 
-- 
2.17.1


