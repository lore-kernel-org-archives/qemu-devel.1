Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C9C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7019B206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N7GD0piI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7019B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNUd-0004vl-6E
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNS5-0002y8-Do
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRy-0006EA-KG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRy-0006Cd-9k; Thu, 15 Aug 2019 17:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1565905107; x=1597441107;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B5+pkTekbS4sZgZb2fbvUF9PuHTWwgChjNdnoZ8/yKY=;
 b=N7GD0piIFihWr2C/RLSeyDYMMh1txf0jEx6k5mTYSKwvPKt6RCFrdw/4
 JXaXrRyWciAK5juOyE812bXjyzXzYbiovaNzkUr/dPSLkaOkv8tO7USCD
 BrZbyysL9MqWw0z8xZM/fHRHZ4N0oiWrhuOQijpLcRVSa2KOR8711QkNz
 TKJyWqvxKi7fj9UVEXLc0pwGvyRCiEbJDP6wOvn9ihKWzTUHRrkWaV/Bc
 SApvjEpzEMXqOEJGNCfQeHns9i48cnS5CALMmRDTGvhiiPu9R4T2QIJGD
 JafDUpAD0oOlm6IMiSPrDRAzRaEUIW4G8so2G/2fyKYg0i0z8uqXne4EV A==;
IronPort-SDR: s8SXx819O2wsaTWvVyi4rBucUvpOqwxx1imihL+o0sWXinRbcG2wfOjXTXe1XWKwdKd0mlYrFZ
 wyKX79EZBMeHBL7nN07ilrja5kY3U80qLwuBFGeBnz04KANIDfxJQFCL27RdnwALxEep2ruD3f
 N3Ie7aUqVlkc8I4tZHPOeqCvoAyCTmZhYbysV/FVn7KfnZep2V3epzeNFxJy6QTpvqZeOiZSDO
 kRR9csTnnmwLIOeaK8egwPy7y6wF+kq0ki3kme8UJXOmxzt3nYgoC2zU4mZQ/v8V+g0nUsFBCY
 6xg=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; d="scan'208";a="116881532"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 05:38:24 +0800
IronPort-SDR: g1C7n/ZUIzoifQyFfrqgNy4/AP9uPfwMxq8mpZ3udurxoIdm8mo1Mgdbp2uD4pOcXJUkk+sf6E
 MWP4lihurj/tXYq5ZsN7Toqjq7+GVPL6b5Io69KHJYOzCOcrBu5iC+M6Jm0IR/uvrtunmLJ9E7
 4QBZ8QICq1hbR9x9w5MP0Zpkh0XKlFHkkiz6gOV4TcsIfhsLnopSX6HulGOR9GZu7C2MTBjB5W
 3j524YEYCAquo2c8UTA8PHrXeYKszXzEtlOuedZkNxZ9OKgSPrt8XqVETYyPtPUWTmdQdrVK2Y
 exoce7dkf3N6Noq6ILb7n/HM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 14:35:55 -0700
IronPort-SDR: O6zMu+gEITSx3YQ4MqSfRVaio/mRWu///LIrcCA1oxofnH9bvaKBUI/tIJFertnAw7Fwq8ogkt
 UmX5yYhKacAhiBb2pJche9rYgN9ztw0oHPM/qIV94pZ7tpDtu5Gt8ltYbW0KRQR0aqhhgysR+i
 96jW2TYI8zXT4NDOgYT2kXRGD5e99XIW+pc9TPDwafZwIOOHk/lGPh0W2yoM+U963CVjuhDOz4
 eKtDB7CzRRC8fqOydfY1lt1mhPrIF3HDi5UKuKtvNS1mPenXZP8o5VkzhAZQcHUCrWBvzp8lEH
 +LM=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 15 Aug 2019 14:38:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 15 Aug 2019 14:34:55 -0700
Message-Id: <59bed3d7342ef7513a60285e2711c162be5559fc.1565904855.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565904855.git.alistair.francis@wdc.com>
References: <cover.1565904855.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v3 4/7] target/riscv: Update the Hypervisor
 CSRs to v0.4
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the Hypervisor CSR addresses to match the v0.4 spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
---
 target/riscv/cpu_bits.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 11f971ad5d..e99834856c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -173,6 +173,24 @@
 #define CSR_SPTBR           0x180
 #define CSR_SATP            0x180
 
+/* Hpervisor CSRs */
+#define CSR_HSTATUS         0x600
+#define CSR_HEDELEG         0x602
+#define CSR_HIDELEG         0x603
+#define CSR_HCOUNTERNEN     0x606
+#define CSR_HGATP           0x680
+
+#if defined(TARGET_RISCV32)
+#define HGATP_MODE           SATP32_MODE
+#define HGATP_VMID           SATP32_ASID
+#define HGATP_PPN            SATP32_PPN
+#endif
+#if defined(TARGET_RISCV64)
+#define HGATP_MODE           SATP64_MODE
+#define HGATP_VMID           SATP64_ASID
+#define HGATP_PPN            SATP64_PPN
+#endif
+
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
@@ -206,23 +224,6 @@
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
 
-/* Hpervisor CSRs */
-#define CSR_HSTATUS         0xa00
-#define CSR_HEDELEG         0xa02
-#define CSR_HIDELEG         0xa03
-#define CSR_HGATP           0xa80
-
-#if defined(TARGET_RISCV32)
-#define HGATP_MODE           SATP32_MODE
-#define HGATP_ASID           SATP32_ASID
-#define HGATP_PPN            SATP32_PPN
-#endif
-#if defined(TARGET_RISCV64)
-#define HGATP_MODE           SATP64_MODE
-#define HGATP_ASID           SATP64_ASID
-#define HGATP_PPN            SATP64_PPN
-#endif
-
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
-- 
2.22.0


