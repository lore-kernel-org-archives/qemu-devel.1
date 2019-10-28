Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89247CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543AA21721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YURNv/wF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543AA21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8Zl-0005tz-3u
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pu-0005sv-9H
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pt-00047l-6j
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:50 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pt-000477-1d
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:49 -0400
Received: by mail-pf1-x441.google.com with SMTP id b128so7174819pfa.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=o43RPnYxBJ6zG1efVp6eoAI+8V+9lXTJj+YBPx9n47c=;
 b=YURNv/wF0HooB/D3oxv2eoYK+Ml+CuSzNM2RBfdsnX0rrsGRkRn0Vz32SDxZeEllXv
 Z2HSCqCkPjkQv6aJY4CaT5LUhhWmXdp0y9vO9AFSxWvWBHfu5ovrHiLK/Uh8DGdme5UM
 i3zej0czQ7Z381cjq6XEGj3zGeV1iwYQCZJn2kMA+TkCKxWUR4meynzV+1N7kLVFwaV0
 FWZ9LPO9ZjaHHD7gj8rIvQrDZcOyHQNJHSVnIxidFJ731HGyVgiBnOL7XwkkxWpPJIKS
 XRED1kR3rsfM+7vDHkuI9ToLK589NLBGiP+5yJQq8Wr5cQx3ht/K8cxTVdZzhKQHoiFJ
 uyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=o43RPnYxBJ6zG1efVp6eoAI+8V+9lXTJj+YBPx9n47c=;
 b=Db+FqIRFNebxQJ3aUV1ftvm3WyPdOa+MPOt2nwJzimskZyi4keR9ikyz51MHZFiZmF
 bAHz96+0HIBuEuRWv8z5L1b3L00wrU6REMDB7AtIqRgPngbV4eBQlGeZqqubXB/bHImt
 IZMqExg+SZEtCO5mDyZFwurQCFbsto2PE9+ceui7gq92J0BcHKh2+ejsNE1DgV+TdXwA
 0pAcM7kjeSH32oVRABFLt6CfPPyxJiGH0IN9YFfgpbh8o95DXi9BFcCRLEk8KuZl6DcX
 ECMin/X8/6vF+L2UuiDVxk/XXFpmHsljoPD2IuZVwGUFMsUQ8U/cFfyUXFlvDmaAqQC0
 U60A==
X-Gm-Message-State: APjAAAWaYEr898Wz8PdIk2aZP5H4RP4X5YduzpCVRMaiKidJtxaZkoj2
 onVN6Z4BmcX9Ti1hhRSFM0MX09Q2kwqfwg==
X-Google-Smtp-Source: APXvYqxDmMHQz8muQRofK2H2gzvTBJSerDtfjffa7I72LYufKlKkxhHCgeB+0zSpFJvgagDLdOau7A==
X-Received: by 2002:a63:5d06:: with SMTP id r6mr21640753pgb.216.1572278327779; 
 Mon, 28 Oct 2019 08:58:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id g17sm10503611pgn.37.2019.10.28.08.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:47 -0700 (PDT)
Subject: [PULL 18/18] target/riscv: PMP violation due to wrong size parameter
Date: Mon, 28 Oct 2019 08:49:02 -0700
Message-Id: <20191028154902.32491-19-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Dayeol Lee <dayeol@berkeley.edu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dayeol Lee <dayeol@berkeley.edu>

riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
using pmp_hart_has_privs().
However, if the size is unknown (=0), the ending address will be
`addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.
This always causes a false PMP violation on the starting address of the
range, as `addr - 1` is not in the range.

In order to fix, we just assume that all bytes from addr to the end of
the page will be accessed if the size is unknown.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/pmp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index d4f1007109..0e6b640fbd 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -223,6 +223,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 {
     int i = 0;
     int ret = -1;
+    int pmp_size = 0;
     target_ulong s = 0;
     target_ulong e = 0;
     pmp_priv_t allowed_privs = 0;
@@ -232,11 +233,21 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         return true;
     }
 
+    /*
+     * if size is unknown (0), assume that all bytes
+     * from addr to the end of the page will be accessed.
+     */
+    if (size == 0) {
+        pmp_size = -(addr | TARGET_PAGE_MASK);
+    } else {
+        pmp_size = size;
+    }
+
     /* 1.10 draft priv spec states there is an implicit order
          from low to high */
     for (i = 0; i < MAX_RISCV_PMPS; i++) {
         s = pmp_is_in_range(env, i, addr);
-        e = pmp_is_in_range(env, i, addr + size - 1);
+        e = pmp_is_in_range(env, i, addr + pmp_size - 1);
 
         /* partially inside */
         if ((s + e) == 1) {
-- 
2.21.0


