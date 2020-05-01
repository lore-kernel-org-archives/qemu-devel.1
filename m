Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C425C47256
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248D22073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xA4F/zyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248D22073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUczj-00016k-7T
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 17:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcyp-0008A4-2x
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUcyo-0005m7-4w
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:54 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUcyn-0005cq-Mv
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:13:53 -0400
Received: by mail-pj1-x1042.google.com with SMTP id fu13so392029pjb.5
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T6CcolLGmewGB263Dq5JcXqXdOTfepA8BlCHSWd+1xw=;
 b=xA4F/zyUkQCJ7p3ju3pTIo97fWtVPQbnO6MYUzxklkpnkv3f8FvIPcmKNEVVj/2cUe
 j95+XYWtl8+3+XYp4DUY6xxjFMRD9KLEgZpdiEeJoiXibyHK4mBlJ0k2NHTVR0csqnAO
 OJVBOzj/5Li+JZiunFM8GXtebv7Y74rytvljIOOcW3B/I7UnpCx8cVjM729YCrz6XQhx
 IEtblyyY9N50cPbAgJfrq5lxmg8opzQ8rKODNquhcCLCg+QoF/4msXv8+sCSNkYiGDVY
 EKW66vqxBpJI2cOjhdQDvPCei5pbYzy45EvwRN3UpmBPWI3oZwk02fuW6v/lgtet1Tin
 yywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T6CcolLGmewGB263Dq5JcXqXdOTfepA8BlCHSWd+1xw=;
 b=HVxnfgrNRPXMk1JEUdrESadWYoozGaqRSMRwyRPIqHT3a0fulWo4ef+FpPY4caaDyH
 wyEzFDfjDUvNoyShSdgtTftenz6Cd6qDq35/SXpEhJqDD4SH464JgfDd1+pptNJgW3d8
 LQOZTpD+BqZyGD+7iP+sl/7vmKW+vJ6RBQd/C80j1LEGljav3SCNrIqdWF5ewbC+9b1f
 NhlJ+E+E8uqCSICDDshV4qImEENJKeO39NId90o4WUn7/VEI0py/yabu+5ViWoHa6OQZ
 Lox5Myf7d25C0bOXlwBk8Wj2JZfyzdOUTHjLQVeoS7nB2UPay3JdSOoHwBojkIMcxKYU
 qVWQ==
X-Gm-Message-State: AGi0PuZKZJW07vO5IZUNpfhb7f3zFVwyGblJRRblb0z3voaB4+2c4NWv
 JBsOFE4YQSerb3yviGAd+klelartbRk=
X-Google-Smtp-Source: APiQypJq6+kYz4zO1NOM2DISz8rNpdjDjCjG24dNBfTwtZAGKDpqwVWJk/ztIm7wMhzyGHD/sE6FQA==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr1877086pji.36.1588367631967; 
 Fri, 01 May 2020 14:13:51 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g22sm514552pju.21.2020.05.01.14.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 14:13:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/arm: Remove unnecessary range check for VSHL
Date: Fri,  1 May 2020 14:13:43 -0700
Message-Id: <20200501211345.30410-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501211345.30410-1-richard.henderson@linaro.org>
References: <20200501211345.30410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In 1dc8425e551, while converting to gvec, I added an extra range check
against the shift count.  This was unnecessary because the encoding of
the shift count produces 0 to the element size - 1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f730eb5b75..f082384117 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6126,16 +6126,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         gen_gvec_sli(size, rd_ofs, rm_ofs, shift,
                                      vec_size, vec_size);
                     } else { /* VSHL */
-                        /* Shifts larger than the element size are
-                         * architecturally valid and results in zero.
-                         */
-                        if (shift >= 8 << size) {
-                            tcg_gen_gvec_dup_imm(size, rd_ofs,
-                                                 vec_size, vec_size, 0);
-                        } else {
-                            tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
-                                              vec_size, vec_size);
-                        }
+                        tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
+                                          vec_size, vec_size);
                     }
                     return 0;
                 }
-- 
2.20.1


