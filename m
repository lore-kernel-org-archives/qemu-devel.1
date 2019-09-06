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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E992C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487E1206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8yvPL+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487E1206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6H3O-0001df-K3
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyX-0004N0-6P
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyW-0004Lq-1M
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyV-0004L1-RT; Fri, 06 Sep 2019 12:20:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id y1so3350169plp.9;
 Fri, 06 Sep 2019 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=YFM+6j/2FFIb27mlXvjAOgLQE6g6LtNeuy0yp6r54YE=;
 b=m8yvPL+RdE6Ya/TAiWflcYw2+hb0LRzWHFUGPlCVbppd5Bxq8yCEuNPuTrucc16EwC
 5NRynCEcGX/75bgDzTRn8pEoYfqifIWezupT47YtDREA71sTH7DBX4utrUNR9DlpEd/+
 N1efxtGKox9oY6s1RbQJRwVKo/eVhAOc9OlkqDwhyR0gVfNjHe6ynL5nJZVtsS5E5CDX
 eirn/B+Swb2lqsopGT3rjgkA344CzSG0M7cB6LYNVacLLbI8WNbmtAARHjAwdNwZRNhB
 +z+fIn/3BO79TugzLyEj3i0Y9eron9fd25n8xBLQsXW2FyoU1hFs2PNl7LL06NWn+xYM
 kH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=YFM+6j/2FFIb27mlXvjAOgLQE6g6LtNeuy0yp6r54YE=;
 b=oUuesQmUx3zGWBLPfvxcoLVStL1O1yh2sXiZfJpO0plsXWl99aT2Ki25epe3klpYBQ
 pqEyGyphE6Yo/VxV21ETYHkgqgUvX2KlJ+PEyEORFAcRdwIbsLXju6CW0flOGFALyIEX
 kWQUU3371lkJWb8sCLX3PtyB3s7zKw2O4PbtX2DeH7ZW5iXJ01QDOowPrTVEahO+419k
 uWkpOYCHKOI7V+dr8tmTW6w7m/rp3xE/LxLOxwoHhQdFSNaVt/AX5YuGBncZgWv7DF4V
 F3dBFS6v+zbHsJyQ/D83+HQE7AadQybxAfExMqfk1hLLtBuvFe3oTdaaCdvh0/EUNwa/
 mosw==
X-Gm-Message-State: APjAAAVuPpoEt1MpMVZziKJ+kie3umszQ0yzciEE+/3Wsq65GdjZzWQu
 QV4EvM8xfyjBuwjlJv+ipfA=
X-Google-Smtp-Source: APXvYqyPiSgekzywX2wnAPmd3lg0LcZEanMGUGsoc5p6Secc0eSpaOpqUHAcsTXWvfGQhmQcl7YLFg==
X-Received: by 2002:a17:902:ba16:: with SMTP id
 j22mr9355190pls.253.1567786838959; 
 Fri, 06 Sep 2019 09:20:38 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.38
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:38 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:00 -0700
Message-Id: <1567786819-22142-14-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v8 13/32] riscv: sifive_e: prci: Update the
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

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_e_prci.c         | 2 +-
 include/hw/riscv/sifive_e_prci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index bfe9b13..a1c0d44 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -87,7 +87,7 @@ static void sifive_e_prci_init(Object *obj)
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


