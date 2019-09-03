Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D866EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70D4233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeTCn8CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70D4233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Brj-0002gg-Lb
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN1-0001Kx-4v
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMz-0003qe-S6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMz-0003pp-MQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id w11so8120771plp.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LJRcqdYb3KvBP4qjKS/2RBPcCRmkfX7I427R88Z1k+U=;
 b=OeTCn8CPM3vXPBjvPE1+xu4yY6r0/bx/cms433UMqVJqebzYSoE8HG2ohsG7F5L+ew
 y1NAON3+ur98J99dhvWMBQ6M+g/mIIZD8Tu1bXfe7d4jp0zfdMNhwZPey0IW4py1Pa00
 QRjiPwLgnc7Wc5cZtcXT6drU1gUSMyTLfxDU/iJnvNS7LGqB7t+ccRKRZfW5YnqWQPIt
 9tc6FqckkgpVwSqS1CwHrzvKU2gaEEoV3vzT8AxiTmW6LwUKBpPLNdYiaYMxe4tPWijU
 fpRi87FF5yXvln0tdkbYeq180c6MZECi70KnEyvS/nPm13gKph1KgVVhpFREoiSZ2KAC
 FcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LJRcqdYb3KvBP4qjKS/2RBPcCRmkfX7I427R88Z1k+U=;
 b=CRmOUGzgzmOxglocEtM+kEUgYPk/KYVwSZ9WtM7mrSAG7Aa0EVRV8ytZru9J5ovzY2
 pBfSqHcqy4SIOATX1qiBq+2VhoQcKEAj+5Aduh346bL35W7jMcQQuVsQ9v41v3aJlo1W
 JyMeq7FfDJeyzJzXKOMLdFF1VtG/0G6uH3r5aHhkqAgKKUKi5C0awwHQl2J0lHdWFu13
 0pimYdMRnvab/jhCKkDHFjEo967mpJOijx9+pEkm0wEF/EcxTzMissD3x8pfb8swt590
 TDa7MsQpRKzQPDOwT0aGcRyfVJLS8kgJFjaMOeogm9ZP8GOqRu88BJNViEkmjY7+avpN
 sRGQ==
X-Gm-Message-State: APjAAAXJ9eB4GSwpMiUse2r9n0JJkLk+ehy22hHWuZ4yxfOYTEcxY2ya
 clgE3/BoHxryfWpNcVVx3Qx2B+eGYCQ=
X-Google-Smtp-Source: APXvYqzYBvniDvl7EQtzUGzEKOLiuBTVsvLA5gXsT3Mdu3kVq85DwezRtMj1JU/6bsl6ay6CJ6G5eQ==
X-Received: by 2002:a17:902:441:: with SMTP id
 59mr36800764ple.62.1567526964476; 
 Tue, 03 Sep 2019 09:09:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:41 -0700
Message-Id: <20190903160858.5296-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 19/36] target/sparc: sun4u Invert Endian TTE bit
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

This bit configures endianness of PCI MMIO devices. It is used by
Solaris and OpenBSD sunhme drivers.

Tested working on OpenBSD.

Unfortunately Solaris 10 had a unrelated keyboard issue blocking
testing... another inch towards Solaris 10 on SPARC64 =)

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <3c8d5181a584f1b3712d3d8d66801b13cecb4b88.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h        | 2 ++
 target/sparc/mmu_helper.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 694d7139cf..490e14dfcf 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -275,6 +275,7 @@ enum {
 
 #define TTE_VALID_BIT       (1ULL << 63)
 #define TTE_NFO_BIT         (1ULL << 60)
+#define TTE_IE_BIT          (1ULL << 59)
 #define TTE_USED_BIT        (1ULL << 41)
 #define TTE_LOCKED_BIT      (1ULL <<  6)
 #define TTE_SIDEEFFECT_BIT  (1ULL <<  3)
@@ -291,6 +292,7 @@ enum {
 
 #define TTE_IS_VALID(tte)   ((tte) & TTE_VALID_BIT)
 #define TTE_IS_NFO(tte)     ((tte) & TTE_NFO_BIT)
+#define TTE_IS_IE(tte)      ((tte) & TTE_IE_BIT)
 #define TTE_IS_USED(tte)    ((tte) & TTE_USED_BIT)
 #define TTE_IS_LOCKED(tte)  ((tte) & TTE_LOCKED_BIT)
 #define TTE_IS_SIDEEFFECT(tte) ((tte) & TTE_SIDEEFFECT_BIT)
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 826e14b6f0..77dc86ac5c 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -537,6 +537,10 @@ static int get_physical_address_data(CPUSPARCState *env, hwaddr *physical,
         if (ultrasparc_tag_match(&env->dtlb[i], address, context, physical)) {
             int do_fault = 0;
 
+            if (TTE_IS_IE(env->dtlb[i].tte)) {
+                attrs->byte_swap = true;
+            }
+
             /* access ok? */
             /* multiple bits in SFSR.FT may be set on TT_DFAULT */
             if (TTE_IS_PRIV(env->dtlb[i].tte) && is_user) {
@@ -792,7 +796,7 @@ void dump_mmu(CPUSPARCState *env)
             }
             if (TTE_IS_VALID(env->dtlb[i].tte)) {
                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
-                            ", %s, %s, %s, %s, ctx %" PRId64 " %s\n",
+                            ", %s, %s, %s, %s, ie %s, ctx %" PRId64 " %s\n",
                             i,
                             env->dtlb[i].tag & (uint64_t)~0x1fffULL,
                             TTE_PA(env->dtlb[i].tte),
@@ -801,6 +805,8 @@ void dump_mmu(CPUSPARCState *env)
                             TTE_IS_W_OK(env->dtlb[i].tte) ? "RW" : "RO",
                             TTE_IS_LOCKED(env->dtlb[i].tte) ?
                             "locked" : "unlocked",
+                            TTE_IS_IE(env->dtlb[i].tte) ?
+                            "yes" : "no",
                             env->dtlb[i].tag & (uint64_t)0x1fffULL,
                             TTE_IS_GLOBAL(env->dtlb[i].tte) ?
                             "global" : "local");
-- 
2.17.1


