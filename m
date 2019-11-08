Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F229FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE8F2067B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="YVUh2sWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE8F2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTAIj-0004L0-VR
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iTAFE-0000CP-8i
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iTAFD-000654-8Q
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:32 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iTAFD-00064l-38
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:31 -0500
Received: by mail-pf1-x442.google.com with SMTP id 3so5284757pfb.10
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 11:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=tM4Fro2TVwkO5f8g7B2j9ujSbXOxCnayqaeFwddAub0=;
 b=YVUh2sWqTpEsCPUFUfc7lHA6DqDheheDlRXwy4adX+zaiGg5E35gi4DvX317kmuZ3F
 uzd1E0aMootYzW3hWBEz7NPfcPbjHrFUtxVsAYYJ28+wic/rdrbMKGVASUePI4myZzsq
 OceIEvUgvxZQ2B+eJoQpPfqkBksqyVt0UFlk81sOefbOCi9WQa8VzUyEXWD8njikPa0Q
 KSKVlqoMzufrm2EdbdZSrhuzfz6EOslTTAn6DEJpYU4wz0+8Qowxd9CXTojwr6Owscuq
 RqykuOXIoEtGEdlg2caWy62iH+cBBM6wBRrr//hnkQ8wUV7re69agX1oN1y+qGHJPyn9
 N8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=tM4Fro2TVwkO5f8g7B2j9ujSbXOxCnayqaeFwddAub0=;
 b=HldKFTDJi5oVD6ieNRTbTlRWU45m0qW15Ou7fYJOVNjm/G8mrOhVJkGF+mC5Z2cVOv
 r2gVZtx8LH2I9LV11YYYOAQwY/vwTarYE8Pu5wLJvRLl2Df6ab9yT5+1hdavWh7ErnE8
 dyolZASKUlMG6EqzjioNzs2ogwYeAh0m5SajURFUJAjzovQoc3SFVh92AnLpxXQw03cl
 xfWL8dzGF97l7I7eD4dyoUkQ7EBRQsIFDf0WGHupqAJXMhozzyMEF2zvssN6t0tSGnHT
 Jzr8G4CbhF+SVTV5qwDgmAP6J0llXobTbgrW5NhuO433agP44dUV69aGbwwdQr8WrjnK
 +WQg==
X-Gm-Message-State: APjAAAUbE/bzmUW9FwTaIZVa7WBrpUxbWm4HKBV48Df6DILuFB4a9LoP
 OLJ4j6UMbfy+qLLxlCJHqCYHSg==
X-Google-Smtp-Source: APXvYqyrGOnLuRk4FgFZpne9bF6/pVqmwaDHEIfbSixB8zyzH8jvZtKCG8KIWTfttqaah879NKq8uw==
X-Received: by 2002:a63:f513:: with SMTP id w19mr13779501pgh.55.1573242509630; 
 Fri, 08 Nov 2019 11:48:29 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f13sm10128262pfa.57.2019.11.08.11.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 11:48:29 -0800 (PST)
Subject: [PATCH v2 3/3] RISC-V: virt: This is a "sifive,test1" test finisher
Date: Fri,  8 Nov 2019 11:47:58 -0800
Message-Id: <20191108194758.17813-4-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191108194758.17813-1-palmer@dabbelt.com>
References: <20191108194758.17813-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test finisher implements the reset command, which means it's a
"sifive,test1" device.  This is a backwards compatible change, so it's
also a "sifive,test0" device.

Fixes: 9a2551ed6f ("riscv: sifive_test: Add reset functionality")
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 hw/riscv/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 23f340df19..65ad725920 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -359,7 +359,8 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     nodename = g_strdup_printf("/test@%lx",
         (long)memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
+    qemu_fdt_setprop_strings(fdt, nodename, "compatible",
+                             "sifive,test1\0sifive,test0\0");
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_TEST].base,
         0x0, memmap[VIRT_TEST].size);
-- 
2.21.0


