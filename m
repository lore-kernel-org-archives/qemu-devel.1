Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554E8C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2028B22CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdDg5qC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2028B22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SQb-0001w0-CP
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SGF-0003Ae-JE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SGD-0003vU-8S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:55 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SGD-0003uU-2a
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:53 -0400
Received: by mail-pg1-x541.google.com with SMTP id p3so1468523pgb.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZQrSORTexmqUbB8NHgb60CoVdE93miI4HpVhE2CwILU=;
 b=qdDg5qC+2UidtVnmrtTSA7JLoFCFIzwL4lZXpLT/ERgdIizsc7PKJwhQ+DMkTbYpx0
 BfmuoIhbMyNsv98/lgJtHMBR7xadfcpaU/9leXqoS5zQhO2SBq9mr+c4q9XyzfegW9QT
 dC/aKFWw6j9lJTskdxzWAwR1lJIZ+lmTNrc56Gbo8ucTZQsaAPfHDu3PzI7/7O8frtzM
 biGeWKFjEVJgiepa/gM2IlTUPUsQrO9PZTI8Ea9ugsq0yvil+m5z/bInKS1yLq1RJo/f
 qv3Mltvz4sIC347vNQzjm4jG3KJV+hAVJAQ3qOyiFAQSHMC63JcFeSiGai594JtUxnb5
 Edyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZQrSORTexmqUbB8NHgb60CoVdE93miI4HpVhE2CwILU=;
 b=mtuAyQyF5cC92MADb23rEKoXm0/31qfZuPKdivf3m+L5hTYhoadcRMJPpcIEst1Ncb
 hiINRrVmmfqTjNFgO1rp4TpmKQG3lzKO39km135mlCs5N8+6nedhH0iOq18cbrqUdUBj
 n5wQYPIf4UMkTDap9xgDVHDZd2S3VHYZ3ZxVg9CKGpzoQweURS8QMUMOeH/LOlP2EGmn
 OyndlYqs6zvwkA3sOMzbQcLQp4SGvOJ5X0lHEnv6lEOZgA6468p1FmyNNdyDuhNtyOM6
 KOh7obgBgF27MCIExmPldnjO6DEFVBWRUHxZxlxqqBaI85dz1Y47GqosqgKOjGWwmYWv
 buDg==
X-Gm-Message-State: APjAAAVD9ZqPhKXJlO4+cNViWAmwDtDYZ4zPdC1m63ZzRwwZXXvOPUby
 QhIc74zhFgjXDcfKXRiMQftwmOksIfk=
X-Google-Smtp-Source: APXvYqwim9vjeE0uC6ziif6GFzFc40pea3F5oTht47NIZl7drPK+sSClohyoV6pkpuo2iUL6dnLMfg==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr29506910pgk.431.1566400251755; 
 Wed, 21 Aug 2019 08:10:51 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:51 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:15 +1000
Message-Id: <27f915e6ee675b0f88bcd1429bd9f37210d72728.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v8 21/21] target/sparc: sun4u Invert Endian TTE
 bit
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
Cc: Tony Nguyen <tony.nguyen.git@gmail.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bit configures endianness of PCI MMIO devices. It is used by
Solaris and OpenBSD sunhme drivers.

Tested working on OpenBSD.

Unfortunately Solaris 10 had a unrelated keyboard issue blocking
testing... another inch towards Solaris 10 on SPARC64 =)

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
2.23.0


