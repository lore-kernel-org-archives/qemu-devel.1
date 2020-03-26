Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BDDC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F63120719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtlKayHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F63120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYOr-0006cP-N7
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK3-0006Dw-SL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK2-0001Qp-MY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:47 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:40087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYK2-0001QV-IJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:46 -0400
Received: by mail-qk1-x742.google.com with SMTP id l25so8183547qki.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pu4aLcXEpuJ4ytDOMXC0XbbDo51phtIicVpeJSCDXFU=;
 b=BtlKayHqFQQ55nfGp3i7vRGrV+mifLzZWqU0R+K8tcx3vlsbCbJNG/wCujZlbFe1ov
 jM2NwSXEB/I8w9t0IpTKU+vzmjSMgcddKLcoLaIh5KzJGumF6eUnjuaIGKWgP9UGh3Zb
 zAoG01Et2WqsfcrkVZBqTCsBZCVxJy8fs1TlaoBjPJC0dQvi5QrVAwa0uPAtz/sQbgLR
 nkyLuL328fJYAoXpf0xBc8jwcDELG10X3PuF/yDitk5fiw90ViilX3Vch7DY9nL/0SFz
 OwIQrhofDX0t5BWPuLB7Tlf2do5bsmFTN2vgfPjNn8qIUWWshH4ZpNhSjt60ASfZ0Oi6
 VK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pu4aLcXEpuJ4ytDOMXC0XbbDo51phtIicVpeJSCDXFU=;
 b=dqXdVm7b/NA0Wr2N5pQtCtgpqrnNdn9s9SoHdWbIzOxBwzP6tfAEWU8p0sF8Ndg7nH
 qZnwBHV2n3LE/rs9MU+BJg/GycGl6+lV8u+AaZrfSvOXP71raP1H3etnlvxu6L3UG2zq
 PyLbJyFMtevhL/sHcNoXdJwlmbWgv0htR7aXawno3fM/yB6CLjuJzN/IiKshHTWR1vIT
 mYVoA8NBRcGGc3BykRrBwYGIlk4y0OGJcW2jQjcod/ljOlTFPsg7WDtlRQAKoi0rXKPQ
 jQmpGD2UspKFegk8pIsMzjxJC7e7IsRe6z0eL9KreMp2V/gF8WNkbmx3/J8Usf5/fM7d
 aeUA==
X-Gm-Message-State: ANhLgQ1CinaKlY9/qH6NPE0cTEZ3VoVsScjQ/BVliC2ZIouZvm7edRK0
 m8mMbOvRSCbB4jjfkfn3BwlTO41S0vFGAQ==
X-Google-Smtp-Source: ADFU+vvbrZchqwXVKUb+QkpbEiO9smCovkoDYtLU7OUIU8kvE1oXKDjyUroi2aF65Wknx/Fa0mtKLQ==
X-Received: by 2002:a37:7002:: with SMTP id l2mr10334824qkc.372.1585251465839; 
 Thu, 26 Mar 2020 12:37:45 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:45 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/74] cris: convert to helper_cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:52 -0400
Message-Id: <20200326193156.4322-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

And fix the temp leak along the way.

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/cris/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index aaa46b5bca..6c4f091b7a 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -2823,8 +2823,9 @@ static int dec_rfe_etc(CPUCRISState *env, DisasContext *dc)
     cris_cc_mask(dc, 0);
 
     if (dc->op2 == 15) {
-        tcg_gen_st_i32(tcg_const_i32(1), cpu_env,
-                       -offsetof(CRISCPU, env) + offsetof(CPUState, halted));
+        TCGv_i32 tmp = tcg_const_i32(1);
+        gen_helper_cpu_halted_set(cpu_env, tmp);
+        tcg_temp_free_i32(tmp);
         tcg_gen_movi_tl(env_pc, dc->pc + 2);
         t_gen_raise_exception(EXCP_HLT);
         return 2;
-- 
2.17.1


