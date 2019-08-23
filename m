Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B45C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9042166E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlQJ7jB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9042166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i127b-0004XQ-6K
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rH-00045C-M7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rF-0002Yv-Kd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11rF-0002YK-F7; Fri, 23 Aug 2019 01:11:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id k3so5072743pgb.10;
 Thu, 22 Aug 2019 22:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=1QsGGydW2bZUHoxiW5W0EtCouM+ZnvHGwY2Nm3XyYGs=;
 b=JlQJ7jB45CUalt8PgtbfqRxTWPg0JwYhadqb8ib3ZFmLTYaVE4ihFS3CTtCpt59UCn
 TiZXJyWAg8upRYFZ9W7a3svDtHxVCwYt+WKgGrnHZ51i6rH2n/AnpgR89bU+2UNzDYAf
 bD7r6CFf3Asej//INAGmoUtvZ7C64/aSoUwPMAtlx2T1MwzVYeEAbsRoVq+i9ktxcNGC
 xI/goLTftH5w1nze6BjhsIEvRlflj8U/eVLV1aiP+1qLPmFIxO5hwMLj3FyYZiyAYdta
 brvSEIckCdKUzzwZszu3BHYGTtb2rikrlrVta45FsST6tkfa2wV4gxtV8rLRHx7VWLv3
 FiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=1QsGGydW2bZUHoxiW5W0EtCouM+ZnvHGwY2Nm3XyYGs=;
 b=J4JeHlB+cWLUAnlnKFE86xXtyizGmsM1banbn8yLzCERb4K2piwDaPN8rPH+Oplkx5
 pn5FaoFVt+pFeEzYRFDm6uHm8OFWN5HxoiEwi2DlQ0R7kec9hEsE5bsAqowK6nJAmtvZ
 +TJczV0jIwFd0EQuUehGToNhe8f7LlBwHNdk9xPXCNpaFsH3UNwyR9pJuRyYZzp5qHxj
 H4hWTamiVj4+RbmnAvmsSYiVLq8pcTBZ1EyA+pQHj9lHNwqkV4XwdRrR3PVzPXMLa06H
 AeV55NEKbbk6i8X1/e9N48P7ErZUUfZMeVp5ud7iKSWb9hYMXjMU9dsf3Ou+mTXoHx67
 p11w==
X-Gm-Message-State: APjAAAUmxW7d8KN9vw3KX8+rHEy/UndDV3ki9Orgfr7xj1hwdQU3Ca9r
 9oKckZ53VehINYN0hl/inEQ=
X-Google-Smtp-Source: APXvYqwfn65qOpB3D9nHMQ4Kqh8gsR+wkZl9u6Tw5StB4SMoUtP27TzSPbBciZugmsn0kcRxQC9iRQ==
X-Received: by 2002:a17:90a:bb01:: with SMTP id
 u1mr3257602pjr.92.1566537088671; 
 Thu, 22 Aug 2019 22:11:28 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.27
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:28 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:10:50 -0700
Message-Id: <1566537069-22741-12-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 11/30] riscv: sifive_e: prci: Update the
 PRCI register block size
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

Currently the PRCI register block size is set to 0x8000, but in fact
0x1000 is enough, which is also what the manual says.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_e_prci.c         | 2 +-
 include/hw/riscv/sifive_e_prci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index 71de089..ad6c624 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -86,7 +86,7 @@ static void sifive_e_prci_init(Object *obj)
     SiFiveEPRCIState *s = SIFIVE_E_PRCI(obj);
 
     memory_region_init_io(&s->mmio, obj, &sifive_e_prci_ops, s,
-                          TYPE_SIFIVE_E_PRCI, 0x8000);
+                          TYPE_SIFIVE_E_PRCI, SIFIVE_E_PRCI_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/riscv/sifive_e_prci.h
index c4b76aa..698b0b4 100644
--- a/include/hw/riscv/sifive_e_prci.h
+++ b/include/hw/riscv/sifive_e_prci.h
@@ -47,6 +47,8 @@ enum {
     SIFIVE_E_PRCI_PLLOUTDIV_DIV1 = (1 << 8)
 };
 
+#define SIFIVE_E_PRCI_REG_SIZE  0x1000
+
 #define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
 
 #define SIFIVE_E_PRCI(obj) \
-- 
2.7.4


