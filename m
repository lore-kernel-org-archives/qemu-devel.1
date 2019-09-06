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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7572CC00307
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45906207FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1cRJYpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45906207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HCH-0003eN-Tx
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gya-0004SD-G0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyZ-0004Ps-1b
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyY-0004PN-Rw; Fri, 06 Sep 2019 12:20:42 -0400
Received: by mail-pl1-x642.google.com with SMTP id x3so3357672plr.12;
 Fri, 06 Sep 2019 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=lRpwhcWpnHHmmdHhCjMjD7tq3s0LJu+m/VkA3K4O7OQ=;
 b=a1cRJYppoo/+CGCCYj2FxHDK1nuQJrO/ZTyrVHen4muXgI4jIjL88VxxddyzUpw0Wj
 MjNqjjUlWdyN0rX9FTBBez5QZC3yAQtn738GEf5CBYovfwJPDuYYrzNJW3pnlWdkujKI
 KCP3x28dgbZ/XC+Vo4roM4IUPsFEigkBH6ehuWCoch57SanbUT3YKXaCaV/OZRbhOu7k
 gYnzJnE+YuCNBUX2+oqjLPuWYX88QbTX3GW29JT7hdrGZIft+X9RKO8LY1KhXFkIW1R4
 Fw9qU9RydN5Ms3jH34WxevQXvRlsEv8UNiK0pc+2wIPm4+FeTfuI3ALzc1La/ouwx7im
 nhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=lRpwhcWpnHHmmdHhCjMjD7tq3s0LJu+m/VkA3K4O7OQ=;
 b=LK2SOjiqTNAejHJDclD+nC6X3hhJphAczUT62GBCYjv+CvksMzRVQGUqBBQbsxj2t8
 jv/5WoTKjewvWGqRDZSHa63JGh/M74vYLNB68OpSnBYRREKxucAr3GQ/TLyxt7cY0FrN
 YFxQIOt17WdQ04OcK6SLWN9IOjcjESXTZI2G2TcrsvVQNw87Axg9qPH6SB/EHuy05xv5
 ulFaFqXiMg49U38l43/CGAIhOjWfQuKH6e7bDTE1i41P0GyosXbxhTH1C3ZTuvmfKx4+
 YMqGPXM3T0BJJ+me8uGK0xMGPCy8B4o+wR1Jg509bPGKu/ZKHpJTCPIJUbPBHGE3beNB
 w/dw==
X-Gm-Message-State: APjAAAWQqaIaFCYBNAK7SpgmfxdMSpyPEFjb03QeTTYPST/hipHxhZQ9
 /oLp8PBM4nt2ElkySIX55puoKHrk
X-Google-Smtp-Source: APXvYqxLVbsV9WIDE0W43Z750ECiqSw4YXqgyIqFeD1SAODUoMUSb9Fb6qKtQMTwcNtnj/tyHv9Ctw==
X-Received: by 2002:a17:902:a714:: with SMTP id
 w20mr9902489plq.135.1567786842049; 
 Fri, 06 Sep 2019 09:20:42 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.41
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:41 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:03 -0700
Message-Id: <1567786819-22142-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v8 16/32] riscv: hart: Extract hart realize to
 a separate routine
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

Currently riscv_harts_realize() creates all harts based on the
same cpu type given in the hart array property. With current
implementation it can only create homogeneous harts. Exact the
hart realize to a separate routine in preparation for supporting
multiple hart arrays.

Note the file header says the RISC-V hart array holds the state
of a heterogeneous array of RISC-V harts, which is not true.
Update the comment to mention homogeneous array of RISC-V harts.

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

 hw/riscv/riscv_hart.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index d0f3199..6620e41 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
- * Holds the state of a heterogenous array of RISC-V harts
+ * Holds the state of a homogeneous array of RISC-V harts
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -39,26 +39,33 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
+static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
+                               char *cpu_type, Error **errp)
+{
+    Error *err = NULL;
+
+    object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
+                            sizeof(RISCVCPU), cpu_type,
+                            &error_abort, NULL);
+    s->harts[idx].env.mhartid = idx;
+    qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
+    object_property_set_bool(OBJECT(&s->harts[idx]), true,
+                             "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+}
+
 static void riscv_harts_realize(DeviceState *dev, Error **errp)
 {
     RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
-    Error *err = NULL;
     int n;
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
     for (n = 0; n < s->num_harts; n++) {
-        object_initialize_child(OBJECT(s), "harts[*]", &s->harts[n],
-                                sizeof(RISCVCPU), s->cpu_type,
-                                &error_abort, NULL);
-        s->harts[n].env.mhartid = n;
-        qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
-        object_property_set_bool(OBJECT(&s->harts[n]), true,
-                                 "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+        riscv_hart_realize(s, n, s->cpu_type, errp);
     }
 }
 
-- 
2.7.4


