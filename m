Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D00C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BF821A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YliPyxt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BF821A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwIU-0007l9-4C
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5k-0003KA-6c
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5i-0006Pz-9y
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:47 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5h-0006PY-Tv
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:46 -0400
Received: by mail-pg1-x543.google.com with SMTP id v27so3989885pgk.10
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ik4J8OMJJMJA7G5grjrKf+gGfUAWSTXqqgidtWRv3bs=;
 b=YliPyxt7NJLKMzxHwiMdJkQKeRxqyOn/ftluoNdVD678Pey9mOggbD2uVZAVdMBGhc
 mNArwFJBnDulRVmsyF+pAp2NCnqOAHb+uZFsavwVzkkubmasfPhrNNe73YSEkEO2CzG+
 5fEUtFAB3dYD2sTmoGfnZVvhtY2RUZsL6c71kMNIkNrB9aYVTznQMfnqKqpkPlDOfU9p
 7GsrxWVGif4qXcMPHqTPAfQkqlseDyDKH1loNWaGYjgLhy3+1uihRpeftZGbwX0EUHSy
 zkL5BWPszLwSERYE7rnHUpgpW0RSygZEeMdUihGcHwxv29KiBXzTEv3invg32NzM+O+1
 bOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ik4J8OMJJMJA7G5grjrKf+gGfUAWSTXqqgidtWRv3bs=;
 b=mlCAU+vNQ7l/r3P6EAhLDZt96DUQcjHUJsDiNHq3t66huvnT5MjpS0oNvAzhhPxDSW
 1JvOoQ9y45ACCGKqXUWcSlbs4+A+Wn4orhgUJG3JQl40PvrC+r6i+XK9y2DftOs2z2QS
 2cdBOvSp0VPF3r02UtyomuNxypZ4xb5ZxLV6IJv+9fow+YSpdQEQlkiZ0rbMUiPrlrF2
 6WVh1zDUjP+kJWd4FXv6cJxEmhQfblLdg0Ewwel5PKH2zB6P5hyg3QrKo5b0cRDZuLh9
 4bwwOAFdh3cCFHU0HnF1tDLN3rzj6x7j8BQfKHXrWfycXKeWfDMPzGRTqrpRRPrR2wO8
 H8JA==
X-Gm-Message-State: APjAAAXw/JPjRLgwctsfITePKXsTDicjpIEhD/N84WasnMx5iGzMxghN
 j14d6tyFxlec9XpCehkijukTtBBgXXA=
X-Google-Smtp-Source: APXvYqzu90Pq6U7Ar5Max1Fm3549ICzazFZ8rVbH10pyjt1OYNSLfihy52J3jlRRUwVbMP0hp8jEgQ==
X-Received: by 2002:a63:6e4c:: with SMTP id j73mr11002096pgc.452.1569613184332; 
 Fri, 27 Sep 2019 12:39:44 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/18] target/s390x: Remove exc argument to
 mmu_translate_asce
Date: Fri, 27 Sep 2019 12:39:15 -0700
Message-Id: <20190927193925.23567-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that mmu_translate_asce returns the exception instead of
raising it, the argument is unused.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 48ebc62497..aa8712221e 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -113,7 +113,7 @@ static inline int read_table_entry(hwaddr gaddr, uint64_t *entry)
 
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
                               uint64_t asc, uint64_t asce, target_ulong *raddr,
-                              int *flags, int rw, bool exc)
+                              int *flags, int rw)
 {
     const bool edat1 = (env->cregs[0] & CR0_EDAT) &&
                        s390_has_feat(S390_FEAT_EDAT);
@@ -424,7 +424,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
     }
 
     /* perform the DAT translation */
-    r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw, exc);
+    r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw);
     if (unlikely(r)) {
         if (exc) {
             trigger_access_exception(env, r, ilen, tec);
-- 
2.17.1


