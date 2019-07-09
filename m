Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4CC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DA3214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvdT9PAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DA3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkxG-0001B3-Ja
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkku6-0005nV-Th
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkku4-000172-Ml
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkku4-00016I-He
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:08 -0400
Received: by mail-pf1-x443.google.com with SMTP id r1so8855704pfq.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cAdcykhsBr9KRoTt+e4UsNPsrOD05Rn6WRA4P8vaXKM=;
 b=IvdT9PAZy8N2D6zvG5Wihafmu35j7J+nSrR8+Jl77k5MNpvS15ARUiwieBpX7Uopto
 NTZJZOljZejZRiQ0wK8wMT1e69HRcMfh39TwBwKKvHsaQ57xkL/guds7xc465CrWzrq1
 M2NfiLwIVihAAgxDxpnVItPBaZV/OPfiFy71gsDyuaAVUgzF5kTWvIgN1YcysTyE+NcQ
 cvb17H6OYx/RKZ1yPPG9Y7rf74z6b1rAd5lhNCSpbbV57hpMICwGTvw1vRIwk3ORqpjp
 biphoWUtxMLjivOpLhJA/irx3Xb7lyaef7+EXZBB69eN3NZEpO2NyexDIlOsM/mRmGDX
 9DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cAdcykhsBr9KRoTt+e4UsNPsrOD05Rn6WRA4P8vaXKM=;
 b=k6fdO2BjDIrG3Xpkqh1lWNQehYQMx3bPlAqD1+0hBqXLbSzIOuNRgcoAAVdhi11CxM
 B03egwnchVs9oTLWksdihg9bAImlNa0NEQMRmjlUWfC6VOJ8FrDOewBT1FTTP0xRFXGw
 KjpxNMl/dFGeUGjLQV55uW8XEFunnWcLu3BfzGCYOf6rnT0hWLVMrKM4/umaO62Vv/rw
 bfFW9nd7KM5AcG4KMz1TnnnsfUerup4u/2PvS8q8RrfSg5expONTDI28PDtE/u9r70rq
 5CEv1wb/3uhoW4VgnF4Wu611h1AeB9+WRb8VqpmGCXZuCS95UaLhgIX9MCM9jS4QhTEF
 z2MA==
X-Gm-Message-State: APjAAAXHO7nk6N8c3vuGkRl4I1Zeo356n/BEv1b/1SrCDdfJBB75JxRr
 jie4racod96y6KSRXrDrXj3En+125ZuHow==
X-Google-Smtp-Source: APXvYqzUn9sx8c9h6cFMCFolcBfT3FbxCNh+DxUM2b072A53jkMGbtfuFir0IPOKO5YwJpG+l52UyQ==
X-Received: by 2002:a63:5048:: with SMTP id q8mr28651020pgl.446.1562658667243; 
 Tue, 09 Jul 2019 00:51:07 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id y22sm28237375pfo.39.2019.07.09.00.51.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 00:51:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 09:50:41 +0200
Message-Id: <20190709075042.13941-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709075042.13941-1-richard.henderson@linaro.org>
References: <20190709075042.13941-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PULL 2/3] tcg/riscv: Fix RISC-VH host build failure
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Commit 269bd5d8 "cpu: Move the softmmu tlb to CPUNegativeOffsetState'
broke the RISC-V host build as there are two variables that are used but
not defined.

This patch renames the undefined variables mask_off and table_off to the
existing (but unused) mask_ofs and table_ofs variables.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <79729cc88ca509e08b5c4aa0aa8a52847af70c0f.1561039316.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 1f0ae64aae..3e76bf5738 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -980,8 +980,8 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
     int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
     TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
 
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, mask_base, mask_off);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, table_base, table_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, mask_base, mask_ofs);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, table_base, table_ofs);
 
     tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP2, addrl,
                     TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
-- 
2.17.1


