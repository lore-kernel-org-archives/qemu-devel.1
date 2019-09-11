Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA5C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 01:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67CD21928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 01:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F63EEwzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67CD21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7riR-0002vr-9v
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 21:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i7rfr-0001gQ-6O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i7rfq-0000a5-5V
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:43:59 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:42272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i7rfq-0000a1-1w
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 21:43:58 -0400
Received: by mail-qt1-x841.google.com with SMTP id c17so3922050qtv.9
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v4itJ8e/ejo0YBL9s61Q35bPcHrTTy3X5DE6Cxbfjzc=;
 b=F63EEwzd/KNZhyEFNFQi/9f3Oa5pV2Q1a+Encvx19d5Dw4IxbcIObKJdryto7d9nMX
 jLlx5gkK452Evir4XS3AT3a+lX+/Izf+HW7nvodE/BtJNaifNhg0fo4aNMEVJ3HuRcYH
 Xvh3kxDTT+9otZc3mhYLmBlvevGQb/1HMHPMiVm9vasbqRhuE67GqrixiWoX2vrTgsRt
 +Xw6GM2zMFVq++Eejuu9vTTxvsPokCxnzABvsLVfMhdlfPpLDNqBVDIynVrJ1Ynqo32T
 xjxFAyJgR5hux8cT0MGSYYPv81AEBKLKxECBnC/POra6h0iYyc7n/mxxFfoTW/saEkrw
 GX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v4itJ8e/ejo0YBL9s61Q35bPcHrTTy3X5DE6Cxbfjzc=;
 b=YunNDTf0MuCQiVnBADBqaT24A6nPB8RnlGKDOM11dsOucHT22nU7C9m0S4wuA/LSl0
 PSWUEowUMzccWQf+3NA8aEHHmN5S+ZgF1nnHZkn6hGseq3gSWmTwNuRyeEgk8tTkdutL
 JsYrWwjq3BifDX8fgdNDlkZf2V8KMvo4ximCL5+KROSU781D2A15wkTCdMZfHiY0QsJo
 aVfMUBeyudMspDmSX5VYsCaE3LWuXjqDoVVudSGeRrdTcUysjPNrwc0wB0ZbbDAmUUIb
 8MfiM1XbV7+9ndkIGbWbkGEi9sCTv6Hl3pabZsvNDsCXcpM8opyharhAZrtRYeaBkm2r
 /iMA==
X-Gm-Message-State: APjAAAXUvbqbzfLT2j7SwYWc4kBNSrf1SCb1vhofpWl0vB62A/AQH4+W
 +H/MNjoNKNVsrv17y6zBo0+mZ6X5Zbem3A==
X-Google-Smtp-Source: APXvYqx4d0FBPXakZ3mJD+T2vNArsY0pwZpMHtvB/STCaeiGilyI0fGZ0ecNqJp6/zYOAal54sWD8Q==
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr32519611qta.335.1568166237205; 
 Tue, 10 Sep 2019 18:43:57 -0700 (PDT)
Received: from localhost.localdomain
 (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca. [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id a14sm10074676qkg.59.2019.09.10.18.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 18:43:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 21:43:51 -0400
Message-Id: <20190911014353.5926-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911014353.5926-1-richard.henderson@linaro.org>
References: <20190911014353.5926-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH 1/3] cputlb: Disable __always_inline__ without
 optimization
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, tony.nguyen@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This forced inlining can result in missing symbols,
which makes a debugging build harder to follow.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index abae79650c..909f01ebcc 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1269,6 +1269,18 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     cpu_loop_exit_atomic(env_cpu(env), retaddr);
 }
 
+/*
+ * In order for the expected constant folding to happen,
+ * we require that some functions be inlined.
+ * However, this inlining can make debugging harder for a
+ * non-optimizing build.
+ */
+#ifdef __OPTIMIZE__
+#define ALWAYS_INLINE  __attribute__((always_inline))
+#else
+#define ALWAYS_INLINE
+#endif
+
 /*
  * Load Helpers
  *
@@ -1281,7 +1293,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
 
-static inline uint64_t __attribute__((always_inline))
+static inline uint64_t ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
@@ -1530,7 +1542,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
-static inline void __attribute__((always_inline))
+static inline void ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
-- 
2.17.1


