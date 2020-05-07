Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE8C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BF7208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V0cUb08E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BF7208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWmEH-0004qW-VN
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5a-0000Jl-I5; Thu, 07 May 2020 15:21:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5Z-0005H9-0a; Thu, 07 May 2020 15:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588879306; x=1620415306;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WVW5qKls1AcUBxryIO3izvqEFKIi2NetWmCN95eWQFA=;
 b=V0cUb08ES4PanZ8FAttrW1XtWV/n+aklg+On7CXXtChd0EvHaCMvKG00
 b3AKz9rjtMpMCAyUmkt27jnExpNm9FttYlDdxRVcPUlUP4pfvb+5Z/JO9
 siLmw9qTtfNM/wPfKv4HCsff/NwugPkxh3mGz/wYdhxIyRqUey2alKN6r
 sZ68gQxFvWmeknBCeIFHC6KRNZp7KWq5fcH3rrCCfjXCt2V2ttV/Rob4m
 sv9NwKYqElTjkNrYwxY5juwG1DeZVsm4wpn53tfZCNGzvIpS8fI/U+0rk
 RqasFeLctunOrUFONG1K1lb5kBv44AWKc+9efzBw2aO3R6v7PF8Z2/L+9 g==;
IronPort-SDR: qHNwN+2dFrqpYGiZxrgVDDR7OCutj+S7HgfqHq+kIzvt0Db/gKoLhW/E7NpoJpuuQsCKQZetKT
 RLH7Y7gS9fUvX7KsdByw356whjtpVqBmpr/zFdvkIUdRba+fswId/QL9PkWjddsPoiyr7qveYp
 n3zX81AOR2lb+Kxjd4u/nfUE9UA51r4Bbg1EZ0cfAG0ad/7ae4+D6VkBVS56J7W80fDUn4ZkdN
 93bYmPCSGMtt7WDsYPDMGxTZUYKS85Xjl1BnKgwgBgZH8+0AAu1XEb9rGkOf8+1AlV/JsDaF00
 VHs=
X-IronPort-AV: E=Sophos;i="5.73,364,1583164800"; d="scan'208";a="239807170"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 03:21:44 +0800
IronPort-SDR: 28W281f3lniDJwutWpWBKiZ9UaUtLXGVxezNjjB2ncHJsCl8bnckMIouFiSC3eTZTHnQqIK8pV
 lDHosMNSxMy7anvFDMGB28kqvjBmouRPE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 12:11:34 -0700
IronPort-SDR: cdgeCk4H5jYgFQELPP6wr1fVlzVWZ9CR0P702UOLmEcGF2dKFLor/ZzfP0V5bkEss5BY6TALCX
 B+lMBNvkRLYg==
WDCIronportException: Internal
Received: from uscxm6l72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.6])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 May 2020 12:21:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 9/9] target/riscv: Use a smaller guess size for no-MMU PMP
Date: Thu,  7 May 2020 12:13:23 -0700
Message-Id: <246b1d1fa8d1ad334152ace0cad21e8f40d53e7f.1588878756.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588878756.git.alistair.francis@wdc.com>
References: <cover.1588878756.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=38990af3b=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:19:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 0e6b640fbd..5aba4d13ea 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -233,12 +233,21 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         return true;
     }
 
-    /*
-     * if size is unknown (0), assume that all bytes
-     * from addr to the end of the page will be accessed.
-     */
     if (size == 0) {
-        pmp_size = -(addr | TARGET_PAGE_MASK);
+        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
+            /*
+             * if size is unknown (0), assume that all bytes
+             * from addr to the end of the page will be accessed.
+             */
+            pmp_size = -(addr | TARGET_PAGE_MASK);
+        } else {
+            /*
+             * If size is unknown (0) and we don't have an MMU,
+             * just guess the size as the xlen as we don't want to
+             * access an entire page worth.
+             */
+            pmp_size = sizeof(target_ulong);
+        }
     } else {
         pmp_size = size;
     }
-- 
2.26.2


