Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60D0C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7AD208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h74GJ9/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7AD208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0v0-0007Fw-Ko
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sm-0003Cr-CP
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0si-0004Z9-Uu
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:16 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0si-0004Wb-FK
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:12 -0400
Received: by mail-pl1-x643.google.com with SMTP id x6so498029plv.8
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T6CcolLGmewGB263Dq5JcXqXdOTfepA8BlCHSWd+1xw=;
 b=h74GJ9/MpsCpfBTQpBDLff4tMognUlFC4b0ivMZSZTwssgq6FJEWdd+KzUwU4N4mVC
 t39XPNtINTGIs922woQCgZk/FXyqgy2u3ktjD1Jzzof7FQ1SvdQvcJtTjAdqYtEFpXpd
 ZlP85XdQw+Bi0Q0DVVVURyEFeWCcisgG0X2KsWddu8mer5xrh8xjzYWWtBcJGLOsJ/Hy
 yg1raanr09QUWTMZsiYdsglVKlOvBSqJ1FoySUjzmCdMWckDJDXaj1fqwqQ0/ZtYuKV0
 okJAw6NjWUUUYz0RrDMnu+sI3TPh1UjOXXIXIO/HZ417C203gHO6YCB9pMB/hC62lNFl
 Exvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T6CcolLGmewGB263Dq5JcXqXdOTfepA8BlCHSWd+1xw=;
 b=ZgbCBqowg91zGjqHjN2X450hTs5+VyzmQ6UnrcMSMBwBlG/dipp0POv/bTbZpOlkEv
 MwBM5aKb8o2o9mSnmybiAs+L7AWezQjrBVDQWbLN2hcVaRNSdkg+kyrhDvLeuSNdtGGH
 rVQdkqqoELVIt7bPEk/5aDMKLoRBGpJWyZJ5Fh2EjrAQGbWfvCLdYpV6qBKIPl5yKtjb
 KG+BVZjFuq5j06838wvNFRkCvXrwJsZTk8nxR/KKNxKEccJFhiWdO212+n3ufWXZ1XNi
 YtFJyUhFRsKQqjK6saNbDXiIiU6H293v+lhGKpurp5ng/HC/ZcXypcmN73pFLcbpTpp5
 CaeA==
X-Gm-Message-State: AGi0PuYeVtoar0K34WjunTk2XcF86SsF9fG7qbNnFbQ9Oxefg0CnXtxb
 nbNwt5pDjP7flCz+Mv9MorxjyCzM00k=
X-Google-Smtp-Source: APiQypLb/7L9/peXvklDJW6dkHDasXgL//FhJvxK4RBiroPfRttrpOCSc/5gF7+w4QahbgjzdST0ig==
X-Received: by 2002:a17:90a:80c2:: with SMTP id k2mr8262344pjw.6.1588459510888; 
 Sat, 02 May 2020 15:45:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/15] target/arm: Remove unnecessary range check for VSHL
Date: Sat,  2 May 2020 15:44:52 -0700
Message-Id: <20200502224503.2282-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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


