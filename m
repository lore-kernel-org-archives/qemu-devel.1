Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CABC433ED
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64542075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hUfR4vPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64542075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KxD-00053F-19
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k0KwN-0003iF-UZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:26:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k0KwM-0000ow-Bk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:26:27 -0400
Received: by mail-pg1-x541.google.com with SMTP id l12so380930pgt.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W9alUim2NScoKewf8vVRphcseP9RDIaK8xQN1I3tCFA=;
 b=hUfR4vPbpjqCar2pjDFiPWYhwoLyZhrX23o8xuAdQdTf8S3EWLeEuaJB/0IVzwUSvx
 5lSe7nVURS0GYNjGcvMbPkUnddvpzFBjhtAnxRgsMItH7f+AwOruCq/1Id81Fy8ORDkX
 xx0GlvvWqjhTGF9qrJ0MqdFpsAnashyeu9j6UxbvTUvb9sCiIhNDHisrpU13dE/fKu8U
 k48EmpiI8wesnKRjbxTj51iTGm/LQMRANGiK5TLtA6M1qWRSfc/LaY6oeRkwQOAc7a5Z
 zQK5j9PJKE4IdBATKXwxObDOcyIbM60O8i24EAK5gbCJHUYdl5fw0JsTalhCOct1m8sx
 HYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W9alUim2NScoKewf8vVRphcseP9RDIaK8xQN1I3tCFA=;
 b=DNu1QZeDcSman7a9wtoDGsYwDJAgca6GtyLBNijyU2D4U2ATAkyWVHcrYpSvYdO/Mu
 n6wVMoHxoB9jOVrDVdL8P4z9siGVLJGnEiWnAl2yCPDpwkvdYhSgOOwHM3pXHCOtIMZ4
 5o3GxGO3RJg90/k3INyXcI5IDvCKu1sVFF21YAqpxFKph6/tNNe7XRtTKyZUCv5XnlnF
 pza20kJaea7oqvg8/sE+Y7IXMfTObcf63Mey7VIFrq3kKM+LPwUcmI2SvhYBCLBvfeFf
 mUH/ZcS4FzGY5yF0duC7NXewL14FxRlLsw5T5GOerdW13BAuI7tyNZGGPZG06VyMNizx
 ZgEQ==
X-Gm-Message-State: AOAM533DfdeH+w7mJdgFBradlkISN0DBozLEWS70GLxVQu57FdI5oaJU
 omBinIW7FdouNQGo08lwQsR3Mw==
X-Google-Smtp-Source: ABdhPJy07vtYKaWdDiulAvAS6OM0iYZ8F2eefMKq3oDREVTOtAS7BznEtL6odRJe2CFOFdZ7k4AhJw==
X-Received: by 2002:a62:ce88:: with SMTP id y130mr24024841pfg.37.1595924785077; 
 Tue, 28 Jul 2020 01:26:25 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id h2sm17599747pfk.93.2020.07.28.01.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 01:26:24 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 1/4] target/riscv: Fix the range of pmpcfg of CSR funcion
 table
Date: Tue, 28 Jul 2020 16:26:14 +0800
Message-Id: <ae2d79b898dad67f9be96ce0adb1b9a5984fbec0.1595924470.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595924470.git.zong.li@sifive.com>
References: <cover.1595924470.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=zong.li@sifive.com; helo=mail-pg1-x541.google.com
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


