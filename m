Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31276C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCAF20825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="en8O+2QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCAF20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaTB5-0000yP-Hx
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 19:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaT9p-00082v-N9
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:29:41 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaT9o-0002PY-6q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:29:41 -0500
Received: by mail-pg1-x533.google.com with SMTP id r186so163pgr.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 16:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aZDqheKeViwWkKxhyJVJqBQ0rBfSUmpaFBw1X/OyohA=;
 b=en8O+2QP6gFyD/Dz38r8cv92xaA25UoTh7eVJGFBpCdqwM5scMrduiSGXrJPvWwmnu
 sA5ZiBVkpG0NMJ6V0MDNtT82uEkDzxlJZgsyk9EdtiDMNEpzAZUd5EajdKPe/KndPZfL
 ZCJ2R5vgSjjvvAttCxA+ZxryOcdmj7uig00YKxDxXQiGT73B6yWkKtqa30/s6Cd8IuYh
 uT3T/Jl/Upu3SBUqnVy0a15yB3HTn9zWtZt3PlwkJc1zAhEpYRpOEAIrZt2JVtZbMc10
 MharD+OJeV6LAjO+LG/J0ZKdVJ7CzF4ioXsFsv/Prmy2/sTIkUphuJrHF8kX48AA7Ye3
 velA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aZDqheKeViwWkKxhyJVJqBQ0rBfSUmpaFBw1X/OyohA=;
 b=ITskvZF0DQAUDanuDDfU0WjBQ+oI8Re5fd7mzobXFY2DTge2lovZlWVl3jeUKzjD7W
 AoqLqHl5/0Tj1zCBaUWcwwVUGAJQvPkyGL7QN2lsmXTRzDGukU0+Bf1v2BS3ZIDt2iOr
 BAF4snCgHR+6Wo6uxYEyvcQJRvJ72siZDGFTaOMM9GX+SEY5M+FiopWL92hiBnrEE/Zg
 dlRpG3L9UGHs9Uofl3Xv8WpnkK12oRiOAC2cqK10Gb1i5fZyhnb/uaPRgGfWwWfk0e5F
 OhdvtUk09Di4rkzKWWR5ISZVdjS05FFqTET3AmV8qn8RwU5yHKulCgcAriRrtJNUdNzk
 bX3A==
X-Gm-Message-State: AOAM531MvZNKXNUOutLqeOaoyWPyFbawUHlfvPH3IO8NLeLjUX0St/gN
 Df72gfOx7QzngEhx8i17OvB+m2nMZ1uNOQ==
X-Google-Smtp-Source: ABdhPJxffNFWnupvn3cAMcayRhYrJyT/bMoCqg0gngLB9V4cIJqmRgHpqQbpi4kMJD+nncc8q/Fv3Q==
X-Received: by 2002:a17:90a:4a15:: with SMTP id
 e21mr117456pjh.130.1604536178389; 
 Wed, 04 Nov 2020 16:29:38 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id z17sm3438528pga.85.2020.11.04.16.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 16:29:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.2 1/2] tcg: Remove assert from set_jmp_reset_offset
Date: Wed,  4 Nov 2020 16:29:34 -0800
Message-Id: <20201105002935.680486-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105002935.680486-1-richard.henderson@linaro.org>
References: <20201105002935.680486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
Cc: Sai Pavan Boddu <saipava@xilinx.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 6e6c4efed99, there has been a more appropriate range check
done later at the end of tcg_gen_code.  There, a failing range
check results in a returned error code, which causes the TB to
be restarted at half the size.

Reported-by: Sai Pavan Boddu <saipava@xilinx.com>
Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f49f1a7f35..43c6cf8f52 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -335,10 +335,11 @@ static bool tcg_resolve_relocs(TCGContext *s)
 
 static void set_jmp_reset_offset(TCGContext *s, int which)
 {
-    size_t off = tcg_current_code_size(s);
-    s->tb_jmp_reset_offset[which] = off;
-    /* Make sure that we didn't overflow the stored offset.  */
-    assert(s->tb_jmp_reset_offset[which] == off);
+    /*
+     * We will check for overflow at the end of the opcode loop in
+     * tcg_gen_code, where we bound tcg_current_code_size to UINT16_MAX.
+     */
+    s->tb_jmp_reset_offset[which] = tcg_current_code_size(s);
 }
 
 #include "tcg-target.c.inc"
-- 
2.25.1


