Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56CFC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F5120678
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZM58eP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F5120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW2z-0007X2-MK
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLVqz-0001rG-U5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLVqx-0002Pj-Kl
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:09 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLVqx-0002F1-Cx
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:07 -0400
Received: by mail-pf1-x443.google.com with SMTP id a13so7917904pfa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lYwzIICsJM0RRUf23L+5+nyADTk3rCmJe96y8g1THFk=;
 b=KZM58eP+wzBOJW7tN6bxD0x0yH5YoRkJq5+Fgh+c7gHu0e6lV6Y7wip9MZTMAmFoYH
 oR8QVOi550ZQnLsWnB1+6a6rmvWt7oEUoeQdP4D/+x8Il2nnltLoTkct019+coHaFuTM
 6yd2Zn8EErtRTzvGHKuH4nHUk95eNpth8p9NmRRXz2YKwmOqIqrPorF22i2rrqP6fiun
 ZyG3laEQyqX/Lku/+3xTv5Wh5SU/5kDcnG6UbwPingxrACD+GiREX5ZwmFxs7bpePa+J
 qJzo6tjN+tNtQDrNbK3cqp81rTyA95wUTcmgsFpj417LzeNPLyHnup9OQ691s7+VovA7
 UAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lYwzIICsJM0RRUf23L+5+nyADTk3rCmJe96y8g1THFk=;
 b=NrihiS0iut5EvjS8rFCubumW1LUYZgZLV8Nz/t8EN0RJ/Va1kDrnVAuOU2Kcs7uq5a
 9Pq4NTW8q3KygY83Tc7T4Ep2E00EaA6OsB54J08pUKPz3sON/ino+M2rInDI1LgBRXcg
 r2tC3RqLxpdscOuaMJopxsOJqZvfdS6iCA2zMJacjwr3NZAOG31RKiInV/Ie619Cq9G9
 AgwFdyTrXOU5l0rBO6JbQ/2ad0EKO0bLTaYPqiWTgL70VeE7uVgeusVUL+aZxQvgHgOZ
 KlocByqVyMit4YPLn+bBkSpUeN1MSWJs9kEF2NN0EkrCSroMsO3rQsL7OOprNII5NOIp
 Qb7Q==
X-Gm-Message-State: AGi0PuYgbc8Ky7ls681kKvFjxvWlz0UWADPXmx5B1QrD+X2CbjUsGubr
 kWAd/iqSZIbrdGZT07ilcyZoY7r6U2Y=
X-Google-Smtp-Source: APiQypJDIVef3t4yb/R1zpk7VJEr6pzhsUCBo6w+/xPDO6x7WdxHaUZvWui25lAw0EBvEqLWgMHDaA==
X-Received: by 2002:a62:e415:: with SMTP id r21mr581530pfh.169.1586195285354; 
 Mon, 06 Apr 2020 10:48:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id ep21sm137054pjb.10.2020.04.06.10.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] tcg/i386: Fix %r12 guest_base initialization
Date: Mon,  6 Apr 2020 10:48:03 -0700
Message-Id: <20200406174803.8192-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When %gs cannot be used, we use register offset addressing.
This path is almost never used, so it was clearly not tested.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 7f61eeedd0..ec083bddcf 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3737,7 +3737,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
         } else {
             /* Choose R12 because, as a base, it requires a SIB byte. */
             x86_guest_base_index = TCG_REG_R12;
-            tcg_out_mov(s, TCG_TYPE_PTR, x86_guest_base_index, guest_base);
+            tcg_out_movi(s, TCG_TYPE_PTR, x86_guest_base_index, guest_base);
             tcg_regset_set_reg(s->reserved_regs, x86_guest_base_index);
         }
     }
-- 
2.20.1


