Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D154C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98E8206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eA4tkyEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98E8206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytjf-00077J-4L
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jytgx-0003Ew-SL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:08:35 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jytgr-0003sG-9A
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:08:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id 1so4730797pfn.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4QaCAi9itYTAEWQbQQ1orCya0omL343c9jLTjKapu5Y=;
 b=eA4tkyEBCbQQuS+oqF1SxXFy+0RTxdJMDioXy0vYLE27UgnFMzbobCwc6IpJROm2VP
 AU8pN/RSysIQG1hajcsx0yxB4MxVpdYi60IgG1wXoKabBnnCsU/5LPxkXfYCb43V3lex
 ZZqZ4xlByEWwtBPq1aF9giXcGlp6WibmtgezP3Jx/AYCYo4/Sj8FhUoxqJSVwwse4B4H
 SIliwF4Pxw+AS2MMjrnXkQhWmg9KGGXJQ+s//BSOAzV7juVdafNhb9oX14mA6vZ0PJcG
 2kAVb8D5BtQ5pn3lmK/tVomUA7StyhJ1mPrDaX3LNjhilKdNXlONXtBmDLrEDfrJHOuD
 JLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4QaCAi9itYTAEWQbQQ1orCya0omL343c9jLTjKapu5Y=;
 b=qoAs7kYDzJmic/KC1tt7J+3E9RFAOV3m5IZ5X2tymkWyDf91hUFvrMc5rwcALQmaLn
 25ubvuJ83eZunNrHO4KlEZ6iWOEDJWD1flrBGEe1Rgg0IlE1DWU4Hl9IZUBdPuuEqRl6
 CRJGJOjMQwNVI3a9dCaB4Arj/Pwu1y+z6vrhyZy2aTNpDB2n7lxj6vBBazX7jmh497Fs
 Fy5h4YoKU7v3Tf1rKcxHdxiI+Lnb+j3qJo/rXzw9fv9fgbmQmiELJg6lDnLAJJPs0yd3
 qKyl82SB62Cc9ETcBMn8qbjizWGtX1AO99P4Mz1T+uaPHBfnIWMyKGVoHFDVbtG9LBDp
 weaw==
X-Gm-Message-State: AOAM532oBCHCLupFZCPP0w2ALrNGFhMbWOfr8aK/mbSKWx0d5GPUjgO/
 CoOSuBzUNQOk7tulVO7yo9lnIVZ/d+U=
X-Google-Smtp-Source: ABdhPJzm3Z2+Z3Mx0Im4J7zoNuXbRnryFhcJQ8Tv6/+a/HEKWtTFogn8wumdprZtnQFfnos6uualTw==
X-Received: by 2002:aa7:91cd:: with SMTP id z13mr8309698pfa.133.1595581708000; 
 Fri, 24 Jul 2020 02:08:28 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id z10sm5751282pfr.90.2020.07.24.02.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 02:08:27 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 3/4] target/riscv: Fix the translation of physical address
Date: Fri, 24 Jul 2020 17:08:16 +0800
Message-Id: <afaa7722419a59f42a7eb804f2902e2313a615ed.1595581140.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595581140.git.zong.li@sifive.com>
References: <cover.1595581140.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=zong.li@sifive.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The real physical address should add the 12 bits page offset. It also
causes the PMP wrong checking due to the minimum granularity of PMP is
4 byte, but we always get the physical address which is 4KB alignment,
that means, we always use the start address of the page to check PMP for
all addresses which in the same page.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 target/riscv/cpu_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 75d2ae3434..08b069f0c9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -543,7 +543,8 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            *physical = ((ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT) |
+                        (addr & ~TARGET_PAGE_MASK);
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
-- 
2.27.0


