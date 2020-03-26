Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F9C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F09620714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1OGeqdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F09620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYc6-00071x-Ck
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKQ-000736-B6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKP-0001db-6U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:10 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:32889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKP-0001dS-2Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:09 -0400
Received: by mail-qv1-xf44.google.com with SMTP id p19so3716859qve.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vs48eZedUxWQlFVv5+3u2EpkTD6vBEvp+vgNyVuojZE=;
 b=G1OGeqdwAoyTcOcVZHtjVJvwM+S2EhBldzEufL9tc5GL0FWo72epLg1aLV9WXH52na
 argT5URRB8/pkbkAlvFuX+V7XEwvzP6C48U0uvqS/iFKg0s9JN8S7gJH6VFvoX1HF4Zw
 rw2M+mnvEYXX3lvIHUkR4pD1Zf5xGrMW+AOVJZPAZF3uUkpTGQhvuaEKuS5H1jk8mcDv
 P1yCHdrKe6jRMrnxDHOXJTPoDj1xg6YHSlLODwnXqEjJQE4Q6dseoN2fAWRRiXUFJCoy
 YEqiKfLlW1c+usR/80NYRT1w3Blu6zfp+gYs46Dac8+xrGR8IkenlKApX7br2KsfpkcD
 IY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vs48eZedUxWQlFVv5+3u2EpkTD6vBEvp+vgNyVuojZE=;
 b=VXq37/TzM0zbVAB3ydsQpm17Zzb9KCHDJM/bvg/L99XbTy/8nnmCNuYL8QYO70zy5H
 /jl/SDxe15rHuq8gaJ7FDxHrTGhJ5OXaNjHYb1U3udrSVNmmSrYnrTVQ5XnYXeWQKfGx
 SoMsctx27iW9GzanOZfUDQKVSPhr+684/QvvM+pNZyqVK4+W6A8tCvMApvyYaAF8UnAo
 yNuP4gMyzO0cFIO4b+Nn64ieyfprvLTLZgxwQHw4WgOXlm1dr1ZqU4hV7OtC6gr0SowH
 Qk+yCMsaEUHzCzXOjPrBrrrBpTwKn2zm2JNSyGWgF7JetP2+Li3p9uuoPoWeLzYEHYlD
 G5Tg==
X-Gm-Message-State: ANhLgQ0awSoI/aaG2xgUg0ITg/2zr13qCAEOvvZqIRlUCP2V1B8ObQ80
 J5i+hU1sfOB7GWIjwmFXRPJzQnMdqHrFug==
X-Google-Smtp-Source: ADFU+vvcgJNQUEQ5MUIQok67MNK921vlisN2sByPMhI4XTnz9X9nHHme19GleLQQ+rpm1dy80fpVpA==
X-Received: by 2002:a05:6214:12f1:: with SMTP id
 w17mr9696480qvv.132.1585251487334; 
 Thu, 26 Mar 2020 12:38:07 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:06 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 25/74] riscv: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:07 -0400
Message-Id: <20200326193156.4322-26-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: robert.foley@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair23@gmail.com>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <alistair23@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/riscv/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c6412f680c..91f8833c2e 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -182,7 +182,7 @@ void helper_wfi(CPURISCVState *env)
         riscv_cpu_virt_enabled(env)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
         cpu_loop_exit(cs);
     }
-- 
2.17.1


