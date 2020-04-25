Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52736C54FCB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 18:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B79020704
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx1hwDWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B79020704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSPRB-0004Oh-4l
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 14:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <oliveriandrea@gmail.com>) id 1jSPPQ-0003eN-KD
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 14:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <oliveriandrea@gmail.com>) id 1jSPPQ-0006o3-0W
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 14:20:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oliveriandrea@gmail.com>)
 id 1jSPPP-0006jT-Gg
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 14:20:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id s10so15552828wrr.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=fDst9R49aK4UvnJE0vWPX/u8ufo6Of/qyQooMj2kTMQ=;
 b=Rx1hwDWQyhhA+jY8/JAUI783HBVk4b56TYGhJV/+iNNOcVMOMPxXSFVNTRn4trrxLM
 AuNaFzCo5Qx95g4aKmbBrZ9NNfY8/dSq2w1KK2l04gOb4fvhnypLP7nx1h8g4h4ztvlH
 o2rjewNCps4fZApCSMmRwEsGqa9AVouYeeKGtTfFsAiQJC7oJd6FfcOGDsCArti0huiQ
 Vt/3/KsJml43+67EqGPytJTNzC+xsHhAfliak3DSt2gxomnCXFkkDGNOsCILwSWtMVtx
 sT4Zovm1cMDw7PoCg6Ih1Qij0OCqfQlxlLWu+Wcq+aRwkx57tb4cvYwhjQB/rMX2fNvy
 XjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=fDst9R49aK4UvnJE0vWPX/u8ufo6Of/qyQooMj2kTMQ=;
 b=eGgH/8NneBEXUVlb9ssXmWVqbVJQbkTiki940EZEJ3XJ+a8TlPSIbOzuqrjLSn+Ow/
 laebmer0sfaWYZPGr4emsq0vy11KF/cwuegel+9FhNgN09vLqOqwDu/6Y1CfmkqJKx69
 MMGS3FwOzKDkgnwCVsNvt9gDGpnjgPRlUbluO6IJkeBpAi+pByeJpoYgw7bJ5GgBnERZ
 HqmAFUYr4QnlgAG2wGUZzZ9Q1w1NsMNPO72MVY4gjAu3YLHeIE5oY98vFSnETnwsBMwD
 y8zH8myN480BLvjSB7TscC8oj5zeusJ8rmek3XKIzkhd8JcdiBqN18LCgBEnbkR6ojJ1
 eWdw==
X-Gm-Message-State: AGi0PuZRn8n7LPu94UoT9umwTRyZOx2AGG5WdlEzAQKv4Z2wqvSefTd0
 85mwyfVxEhPolnqlE5GkvODvY/THg3D2Pg==
X-Google-Smtp-Source: APiQypIDd+sA0ZnR+HoIS0WaaFzHWYNfmnGTruMUcfx/9gk+FZRyUyiBDU/4N/5Yf6C5Mteh71Gdhg==
X-Received: by 2002:adf:f004:: with SMTP id j4mr17842031wro.123.1587838805702; 
 Sat, 25 Apr 2020 11:20:05 -0700 (PDT)
Received: from rio ([2a01:cb1c:69f:1600:f6d1:8ff:fe88:d632])
 by smtp.gmail.com with ESMTPSA id f7sm13403524wrt.10.2020.04.25.11.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2020 11:20:05 -0700 (PDT)
Message-ID: <de5adcb9fd0dd607b98026f4bfb34205432b6002.camel@gmail.com>
Subject: target/mips: Enable Hardware page table walker and CMGCR features
 for P5600
From: oliveriandrea@gmail.com
To: qemu-devel@nongnu.org
Date: Sat, 25 Apr 2020 20:20:04 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=oliveriandrea@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: aleksandar.qemu.devel@gmail.com, aleksandar.rikalo@rt-rk.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
I have discovered that MIPS hardware page table walker is not enabled
for any CPU currently available. In this patch I have enable it (and
also CMGCR feature) for P5600 which supports both but they are not
enabled.

This is my first patch to QEMU, I hope it is well formatted and correct.

Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index 6d145a905a..482cfe2123 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -366,7 +366,7 @@ const mips_def_t mips_defs[] =
     },
     {
         /* FIXME:
-         * Config3: CMGCR, PW, VZ, CTXTC, CDMM, TL
+         * Config3: VZ, CTXTC, CDMM, TL
          * Config4: MMUExtDef
          * Config5: MRP
          * FIR(FCR0): Has2008
@@ -380,10 +380,11 @@ const mips_def_t mips_defs[] =
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_FP),
         .CP0_Config2 = MIPS_CONFIG2,
-        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
+                       (1 << CP0C3_CMGCR) | (1 << CP0C3_MSAP) |
                        (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_SC) |
-                       (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) | (1 << CP0C3_LPA) |
-                       (1 << CP0C3_VInt),
+                       (1 << CP0C3_PW) | (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) |
+                       (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
                        (0x1c << CP0C4_KScrExist),
         .CP0_Config4_rw_bitmask = 0,


