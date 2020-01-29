Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A1FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1C0205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FodJI5lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1C0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwx9g-0001PT-R3
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6g-00063b-D4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6f-00021Q-D5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:50 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwx6f-0001z1-86
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:49 -0500
Received: by mail-pg1-x541.google.com with SMTP id x8so633211pgk.8
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hzb8NcUQbv45scvKLglQU4SM5eoWvCxZQ9M8gcvvhdo=;
 b=FodJI5lxpDaSXWte5AGYcFjO1ff3+cS1m6o4m/yzDx97xcRvoiSuJkLt1KrWa/vOBK
 RffW80IC6wjZcvufWyVRl7eoDyPj+PMiL5XreA5iNAkaCqeaMXecJo7mHxI66dtAAZdS
 pILP9QWcFtbOs3S+/6/1/LnrCPVwZS31BlADUPuYxZPEiGPp5wVfOT8mBuQS8TYZ3Gdz
 Ah+YZOOB6k9vwCRI1EVSK+XQiTCPbnvQH1NUcasW3j0kVLmTft+bQ/MpMr+QT4PKjiz/
 ZCrB8aSA0wT+rxrL2QQroS+a2CyWCXAAXeRvQMKRMC07QKyLGQYoGdyEIA96s73r1FTD
 xUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hzb8NcUQbv45scvKLglQU4SM5eoWvCxZQ9M8gcvvhdo=;
 b=ldFOHHxNknY3C4V3+rWV7Qv7gnGySKXk8jAkAZd0mFtU0D4C/NFUxPPlRJ3xIMtE6I
 qnT+51yO2wfBmYoARsbGJZNy8bSeolYJE/DAsTsRKq3BYotmFQUilH/aGpxmlF5K3Zr+
 nNlnxuOC84JrIJ4rUYLtP7Tmv49RICLnNqAuViaZNeBjlpiWbNLR56sgwu2Qi6rDGxv+
 ng+d1UYS7+BJkPqCsnTWXFVVoRkDo20wF/5CmSwAi4hF1xAvUzkZTUFIX2csGs7Yb29j
 Ec1f7+FiIY7qT7UBV9qSXyTIL4/EXGfJiqqr5QnFAzKlXWRd5D6/djY5Dz24aWZPjoJ/
 +xNg==
X-Gm-Message-State: APjAAAWYMdO5QQ2tSJbcwCvIyjXF1OwI00BzDUMZqZADLaINC40dz8NP
 6MPY1sef7i7V6n96e381Z5/YDyLE48U=
X-Google-Smtp-Source: APXvYqxu6VCiyCDuzDvriLTQ14jAVp16vKY+pu+d3SQ0b0BUboPos7Bbl/niYwrWJWy++LYEW5NqAw==
X-Received: by 2002:a62:1409:: with SMTP id 9mr2188185pfu.2.1580341848076;
 Wed, 29 Jan 2020 15:50:48 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id 13sm3740195pfi.78.2020.01.29.15.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:50:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/ppc: Use probe_write for DCBZ
Date: Wed, 29 Jan 2020 15:50:40 -0800
Message-Id: <20200129235040.24022-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235040.24022-1-richard.henderson@linaro.org>
References: <20200129235040.24022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: hsp.cat7@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using probe_write instead of tlb_vaddr_to_host means that we
process watchpoints and notdirty pages more efficiently.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 0cb78777e7..98f589552b 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -298,7 +298,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     }
 
     /* Try fast path translate */
-    haddr = tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
+    haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
     if (haddr) {
         memset(haddr, 0, dcbz_size);
     } else {
-- 
2.20.1


