Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C9C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B112073A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBsr7nSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B112073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gxC-00051D-Lq
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvK-00032M-9j
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvJ-0003ao-Cz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:50 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2gvJ-0003Z3-88
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:49 -0500
Received: by mail-pg1-x544.google.com with SMTP id d9so5463593pgu.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yTA4qfOsQYBcYoiqQ1YZpvzyazgjvt/ZI8cUNM+8GpQ=;
 b=SBsr7nSM2LLr4N2M5dlysnfC3xvq1pOz79clPN2umUyjEMNXBO2ufDQY6Yx7lhZoBs
 ZWN1wV7M+A6WWanRrWCkLctVs9MSPE5B75K5370jV5DTzTlHA9GvT7GzLwgg4nI3b4ze
 njnd9IIIJIUgBmSfxGexSbW8myH/YkLTvruzAUcIlnAyPKF+PXildLle84oaDbBZInTX
 MIBN637q9AXpCwQEun6o5rStncWVxlOPfagAhDhaKC6C1+r1Fdd38zFEJ/JrKAcWb2z5
 4j3r60vZgj4KEq8SWHRZCtg1c0e6cZp8C5GICuIq81TKoy5hv4M7X23BBzQgiPo0xKPe
 Fw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yTA4qfOsQYBcYoiqQ1YZpvzyazgjvt/ZI8cUNM+8GpQ=;
 b=UDQJlf8NfeWsQs6h8YxQ1dwpbVo6EzTEN3ah6AeHtRYxx07LqzxgIHIHNkaxfgwohQ
 fcIfSDZAQgX9cFlLvrXKWlZIq/vH/8HNrkTv3RBzihGoixxzNK4LIVL9Tri3899S0z8j
 UXEo7sTJW8POZF2g9vXxE3Uxw23E2ZFmclMQRcpYH7M2Bcn387Pkx+hrSm9OlhAEekoh
 a7XN7xuqAtHpyz3yg9tS9+69s4Wyr7uERNWmf8MlK14Bdqk+RSxquqm3Lc7tTl+Lb3sZ
 ejpfhI8Vcdwr0alyvEsCuWZnoBpCm1yKKf7nKNOJ+tEjftUEuqeQnUy+Bd4PnJN1CfXE
 FhvQ==
X-Gm-Message-State: APjAAAVycBlKCugU1rPqhNyJqqulnF+K91gjTrgZklv3uww1IWjV96QO
 8L2Lcu6dwMUwx6hYUx6X9Y5Ix0timT0=
X-Google-Smtp-Source: APXvYqycJZTYbJDDcpFsyE7CQWXXlKgn7ZWWUkiXIrqmQ/LVL2VrRKcbTqd25QHYYx93HIMawoIktg==
X-Received: by 2002:a63:2842:: with SMTP id o63mr5291335pgo.317.1581709607947; 
 Fri, 14 Feb 2020 11:46:47 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g13sm7558851pfo.169.2020.02.14.11.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 11:46:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/arm: Flush high bits of sve register after AdvSIMD
 TBL/TBX
Date: Fri, 14 Feb 2020 11:46:41 -0800
Message-Id: <20200214194643.23317-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214194643.23317-1-richard.henderson@linaro.org>
References: <20200214194643.23317-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Writes to AdvSIMD registers flush the bits above 128.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 620a429067..096a854aed 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6964,6 +6964,7 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_resl);
     write_vec_element(s, tcg_resh, rd, 1, MO_64);
     tcg_temp_free_i64(tcg_resh);
+    clear_vec_high(s, true, rd);
 }
 
 /* ZIP/UZP/TRN
-- 
2.20.1


