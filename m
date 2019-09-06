Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C349DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F28D2070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR9OP/ND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F28D2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HR0-00042z-Hu
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyf-0004aN-9A
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyd-0004TI-39
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:48 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6Gyc-0004Rg-KP; Fri, 06 Sep 2019 12:20:46 -0400
Received: by mail-pg1-x544.google.com with SMTP id n4so3779073pgv.2;
 Fri, 06 Sep 2019 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=wyf6rpcH+2ZTe3u27lGf64wFEcPx0VRbAwoc/t4MEn0=;
 b=CR9OP/NDzD+72v1VlB/pFX9z5VS6zv39X1Ha5Y5unhyQ24q0gmgFi5ewyyUE8Yecvx
 VWrIHFwi4ASg2vfRDNWxSdMdINqQFNyidKWkjCXoT8MiM0xbx0p9EFN3TXBF8GskBzK1
 6RfLTk03rcpkpU2PbKyJ51pUC8TRTjVrGz+oCyomsBE3VYS1y3zO+V+E3t7+6qIo0hi7
 GsWkEjMhtFCoIhl9UlIuuIGNk9h9XSnkmueH1az1Un6mYGfsBcion9bl80W5T5VsdD97
 P1rfgQCuLbJy1swWgV6NMU/uimUuZMvSxiLLKdLnG2xSHkdSs3urHwk2y/qm3+pP1NZW
 LjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=wyf6rpcH+2ZTe3u27lGf64wFEcPx0VRbAwoc/t4MEn0=;
 b=BBv1WHziCGpJKFQz6BM+UtNNf1bhCYH+wYTPsYg0SHcTAY9/6YBrzyOxaF1a+XDXQX
 WBEnnikOLVlRab6wyCIYA+HfkI6Bjy+2/qD/ohf/DG7IPP2btD0C0sO5F5R3fjT5MjhC
 SpSqdF8cCbj8qPtvrERDnflvz926fbGSOiHLToEIFo3KbdBNYJQsESRsZWJDg6i0f5ly
 6YN6NLc2ee62T7Tmz1z48c+GhnxqvBw8HNXvKlS7Cam9PuE8GCB5haynlEiGZQwffYWF
 pJEpm0kRR4u5pLfBhHE0stZSvpS6oBLCHD0GnqRX0T0yzqcJZk49HcuyL/1O+ty3SJ/w
 yutw==
X-Gm-Message-State: APjAAAWfRdq2uet0oL4KBcGveXcQirVbnZHg79AKZ4xXzeQ0pX6K5U/O
 hGqzZIExFH1+Wifwd/XDL0g=
X-Google-Smtp-Source: APXvYqzalOWNag5Ht1QaTdeYs22L4xH9DrAu7+EQTt2hDMtBJSDj4eEAQqePDuSOOMSx52VmTMW/dw==
X-Received: by 2002:a62:26c4:: with SMTP id m187mr11927695pfm.49.1567786845812; 
 Fri, 06 Sep 2019 09:20:45 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.44
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:45 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:07 -0700
Message-Id: <1567786819-22142-21-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v8 20/32] riscv: sifive_u: Update PLIC hart
 topology configuration string
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With heterogeneous harts config, the PLIC hart topology configuration
string are "M,MS,.." because of the monitor hart #0.

Suggested-by: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6c4634d..713c451 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -424,10 +424,11 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = g_malloc0(plic_hart_config_len);
     for (i = 0; i < ms->smp.cpus; i++) {
         if (i != 0) {
-            strncat(plic_hart_config, ",", plic_hart_config_len);
+            strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
+                    plic_hart_config_len);
+        } else {
+            strncat(plic_hart_config, "M", plic_hart_config_len);
         }
-        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
-                plic_hart_config_len);
         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
     }
 
-- 
2.7.4


