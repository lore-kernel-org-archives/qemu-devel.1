Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8AC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D3A2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZveiFXnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D3A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxlO9-0002N6-7J
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxlNK-00015Z-3P
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:03:38 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxlNI-000071-JH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:03:37 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mn17so1039233pjb.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W9alUim2NScoKewf8vVRphcseP9RDIaK8xQN1I3tCFA=;
 b=ZveiFXnGGfwuMEqze683QWrrihD7hap5N9cQArXmZnu5RKnzCPKDYEM1qoJBRO03qh
 sCBJ8bYCl+Gc+nD3FG4pU865eWThsCQMNI+GcFasCxy/UWraGn1l2wp/N0zALvfaDGqp
 lGxDAUZQFs7O9B+tIPaJiEPNeTyB+Hgz9POjt7gHwPZMMgRlnuRoBEdKnu83lR8bUWbN
 LKQcjRiPsZpmxfxScAsbRM/uZvgD4YR5VsIH8qjUL+82WBnpZSCklmI7dxuKxPsk/3hq
 xZoU0knI+a4AaNNloxBfeUxUkClGoaWT+QXz93PKmTG0P9b0xmXX+FwJjXsLZgTprMQc
 9jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W9alUim2NScoKewf8vVRphcseP9RDIaK8xQN1I3tCFA=;
 b=kgFwqXEEPh3YOhufXogJyWmt0cgUpNlcalxXxru+YaDHYDH5leofzMU6y6Jd7zYFXo
 Y0ZOyC36GBTxsvpNU9WjT9nWD1PvNoahosZwBwKIrCEfT2Mx/XXli4kNczhMUb0MDewg
 qIKYy1OXMjJ2J1oGo0LvHm+aqBI6/z1YTOLqGU6RbIvuffkGy3tpbvD5v8jrcavjZRxh
 MGsJOL7RH6zYn93Bzfrr762Z8ugC9LXwlOHBHRYF0/Oy1n/VVCuyC3qPWCB4MErnait8
 0t6x3wNZRn+YlHdnCWQzTM9qXb47XUVafsuwgfaiK4giKW9SQRkEl5SJA14iiVl6Ynyz
 aINw==
X-Gm-Message-State: AOAM532Em1n3U2CzRjAcFE37ZloEnGQbVIhTK2EUaEbvuZIxiW/uDCSe
 TFVgUBXp6QouQS2x+zuec4N15g==
X-Google-Smtp-Source: ABdhPJw5b8KePeOgoztRJSbqNf7UTTR4gFONFHE23ja3RIQgIEiu1nwzZHMEDrpNdmCzXbXtRITchA==
X-Received: by 2002:a17:902:eb52:: with SMTP id
 i18mr19900852pli.298.1595311415401; 
 Mon, 20 Jul 2020 23:03:35 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id 66sm19724068pfa.92.2020.07.20.23.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 23:03:35 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/riscv: Fix the range of pmpcfg of CSR funcion
 table
Date: Tue, 21 Jul 2020 14:03:27 +0800
Message-Id: <eae49e9252c9596e4f3bdb471772f79235141a87.1595311277.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595311277.git.zong.li@sifive.com>
References: <cover.1595311277.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=zong.li@sifive.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>, Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The range of Physical Memory Protection should be from CSR_PMPCFG0
to CSR_PMPCFG3, not to CSR_PMPADDR9.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ac01c835e1..6a96a01b1c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1353,7 +1353,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
 
     /* Physical Memory Protection */
-    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
+    [CSR_PMPCFG0  ... CSR_PMPCFG3]   = { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
     /* Performance Counters */
-- 
2.27.0


