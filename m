Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A720C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD592145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGYUHYqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD592145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnsV-0002Yv-Uw
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnJ-0007kO-Uj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:01 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnH-0002C0-Vr
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id n14so556664pff.6
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gnZVZh1VIOx2Bn7nb5JDBu+SrUOXUk1VIW8AryTGMI0=;
 b=XGYUHYqAUUq/8y4Cz0ZjWF+WnH66TRjbnO1jZNAA915M5s6p3iTE8QiYOpsH7+nz/M
 Jse2yzQo38sh9ppjA2KcJnNgjN8QF6ckYUe0JcTvcvafmpJL6qCyHP8ZqGeaycVCL0VG
 r3tNyiJFqZhieSINao9WmbcmKO/wZv/48xXJ9ZZpzLD+6pglNhRkpWFGjVBFi1/gvh7/
 lBRtJgcRVb1M3QTa8LDm9Z7jmYwkKqlWRAYEChI0sRM2kkR/dvimFVPWYa4bFkAeo6My
 xEwLbPDJnaDDn7QdeEsQrohg3I19/upMbY3TMUQEWCJFv2tsU1bldGCNMWGLRoDDjqLx
 CvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gnZVZh1VIOx2Bn7nb5JDBu+SrUOXUk1VIW8AryTGMI0=;
 b=QYx5hI5u2DfSgl22Qe0NpeK4ieBNwVqMPIA1b+3G+GPG+A6aLLBR7+j3KVE9fLDyZE
 szgH40mdGoFjZwzV5z35TRWuCkMzT+qw0JwheKGQGyO9iBw6BxPxXnJch7WC7bWf8aLk
 QVcI2pM4+KgpIgsXpUAti+aD0eNCh8vzuL6476kQD5g84Cdoak6LZWSGohmnFntRLlff
 YtZEJIpkr8Wy4WGLPRZ71G8hLUqJKJm9MNlDdTwc1i+GsBcFH46C/6Je8KwZTSp85CPi
 snh2USOoaS3A6rPuIwriiQmoD5FMKlQrrhukIStPCDhA5df+7gJWB3ipW27WgpBacGEr
 AYCg==
X-Gm-Message-State: AOAM532Ohreuagge2Bs2TytyYoQGLXF1+1/bOPk7LwkgP/VJn+IRITVM
 GIq5ZeMStfE6+I4jSm/ARPHkmyXNAY6Bkw==
X-Google-Smtp-Source: ABdhPJzsXcnN+Fj6Ya/dV3zDGpYOgGLJJlLKIQXSF00bTTtEgE4Ljey+KobOJyyyZRZ8igjZ0XDtuw==
X-Received: by 2002:a62:3812:0:b029:13e:d13d:a062 with SMTP id
 f18-20020a6238120000b029013ed13da062mr1343542pfa.40.1599610618435; 
 Tue, 08 Sep 2020 17:16:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:16:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/43] tcg/i386: Fix dupi for avx2 32-bit hosts
Date: Tue,  8 Sep 2020 17:16:11 -0700
Message-Id: <20200909001647.532249-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous change wrongly stated that 32-bit avx2 should have
used VPBROADCASTW.  But that's a 16-bit broadcast and we want a
32-bit broadcast.

Fixes: 7b60ef3264e
Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2f696074ab..d8797ed398 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -958,7 +958,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
     } else {
         if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
+            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTD + vex_l, ret);
         } else {
             tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
         }
-- 
2.25.1


