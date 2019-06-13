Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52305C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A2720B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldLozEVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A2720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUqU-0006JJ-CF
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlK-00048u-6N
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlG-0003Od-Ld
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSlF-00031l-U9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id v14so21495718wrr.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aWvmCLU0tYg1jkOyEItQlK/WmLZzoOV611s9Hk2h2Ds=;
 b=ldLozEVS5RPki2P5jzmSLxEoh2wYQ/TwkL2qq6FdwlzjiRBBxTRDfR9BnO8nTjD5PW
 S/5WaRq/Tf+wZfTgf5MWTqyI4Vx8pkXNZdibyZe2PRtXgYJSqp5+ZHilgC3x5RIk7I5d
 vVzTluaEqnNoS5b2d12rQF0627bcVCbpcBM6u9skzvOAjemRBpLnvyAO02zF7Rv9RsDw
 WWuD0tvLilz0KgRRN9/gswUaXGbFg96TzUzo9/NXU37WHVV8RDmcqVafOSdhr14SUTY+
 s4vF2Z08eG0SUmxb71/rc0JZXDtZeFUkr/PAqpKXfJQsMns/oqf44dvvZcFi1NTcyrtC
 yMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aWvmCLU0tYg1jkOyEItQlK/WmLZzoOV611s9Hk2h2Ds=;
 b=T/fegTrQ6zAo5WjEUNMEWAkHc41QWGEZbA7IdMuwjD1/jlTFfdszMZvSWrJwSIC491
 7xsS5XjbOOBWYmCQzG8e2xeMW6pmerPJ1KujpBDBRqdYYS3ZEMYIwbhQjQjX2232KvYu
 kQ5+xo+z0FE5ZxDAiuilNGNVuwUIJK+4HENHLZbXokw9Aqa9RvYAVjFFE11j1VrvuhEn
 zkAqTeqbvoGM/WosQVP+BtaD3IWPO1bL+VsRYpMR7i9GwZcC/bGNqb1rkS9VKL1NepKJ
 TnvTfj4jPjXbX97TpQ4K2wJHZPGOI/NFxlFsnI62qeIjGaCOxPbtOUiQP1uiktdd0K6e
 2DyQ==
X-Gm-Message-State: APjAAAVAiptS2C7lMvnM/t4cTuC1unk0hw/fLLP+2EVpvDHxuaWlTnpf
 bY8l+bz6FoPXxe7oyezaZv8p5Q==
X-Google-Smtp-Source: APXvYqze4Dv5bhuqYJA0zHEi8Th9YavrGxcIBLII9gt3+bh+1JBugjEWwszGRMZJSBRn2T4dd2uMKQ==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr13593451wrw.81.1560443972149; 
 Thu, 13 Jun 2019 09:39:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:17 +0100
Message-Id: <20190613163917.28589-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
References: <20190613163917.28589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 12/12] target/arm: Remove unused cpu_F0s,
 cpu_F0d, cpu_F1s, cpu_F1d
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the now unused TCG globals cpu_F0s, cpu_F0d, cpu_F1s, cpu_F1d.

cpu_M0 is still used by the iwmmxt code, and cpu_V0 and
cpu_V1 are used by both iwmmxt and Neon.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8f124a953b6..4750b9fa1bb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -67,10 +67,6 @@ TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
 
-/* FIXME:  These should be removed.  */
-static TCGv_i32 cpu_F0s, cpu_F1s;
-static TCGv_i64 cpu_F0d, cpu_F1d;
-
 #include "exec/gen-icount.h"
 
 static const char * const regnames[] =
@@ -11911,12 +11907,8 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->base.max_insns = MIN(dc->base.max_insns, bound);
     }
 
-    cpu_F0s = tcg_temp_new_i32();
-    cpu_F1s = tcg_temp_new_i32();
-    cpu_F0d = tcg_temp_new_i64();
-    cpu_F1d = tcg_temp_new_i64();
-    cpu_V0 = cpu_F0d;
-    cpu_V1 = cpu_F1d;
+    cpu_V0 = tcg_temp_new_i64();
+    cpu_V1 = tcg_temp_new_i64();
     /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 = tcg_temp_new_i64();
 }
-- 
2.20.1


