Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E80CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E2F20863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHG7gKZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E2F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDw8k-0005Pl-Sv
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5r-0003QA-SG
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5o-0006VO-4i
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:55 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:37601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5n-0006TV-4E
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:51 -0400
Received: by mail-pg1-x530.google.com with SMTP id c17so4018794pgg.4
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kOQn8fqkcBbOOtc4Nsvslx7elS0LZpOm6Sn3ku0T4zo=;
 b=AHG7gKZVLFXKWAsW6M1b7gJlGnmm+IvtxGokLYxlv+9dun69blIUp6XEnDN4Im72Iy
 tEo202NQCCJtZ3BQapjZvjIYfHRxbBgjeS3cGje4nVWGLutLxKMeLBGrQ126qL1hx7JN
 QQqpwsjthQGxSv190zbM82yZDjCMdcf3Dci+7uG7bgsXZb0i/tNFZiw5UylOimeEaKaZ
 36GOoCmOwok6li8iC615rvQtgd/VpklgFISyory2Q0NMSje+jBE/sr+RxdVKC5Qbjv2f
 tnJQysS8gsrdlx9qzMLG49cZ4OBx+IFsLLrqrU0nLfVKuxW3LS24XEprlqFEM8vDsGiN
 plIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kOQn8fqkcBbOOtc4Nsvslx7elS0LZpOm6Sn3ku0T4zo=;
 b=Wr1TEkqQh9Al0c5kZtwAzirYUUgBEvoY7b8n5LtxrZgLyd4NqabwWyVvU5hSvCF1Vz
 KvVbWp0Ni+istCVqq22wN8xEMDE9vz3btYel1ARocX3/xE+g5kvPai95NunXY/QJhxzh
 +/IEs3K16OlhODfGbBJQNP+0ATstxJypc9s6I+5JFNx5gv6B6G/Pr8/izwCoIwWHHVdc
 ph+8cdJzSBxVFaYLGjemGKqfpRQG2hmiSI57kbtMXj4sLnKe+awX4IK5ST8KEqk8hQu+
 8QJoXFUoz5W3MD/PWX/1X7XS8T81vh0aq9VSWjqMQ+EvjaQod8e9WgEUr0mFJ+xpCY84
 SODg==
X-Gm-Message-State: APjAAAXstxVKnJcXbbkNiScTg+9q2OFJEjAPlEvDOKO/R/fPf9lTilv0
 Tap+De6MVb/kZ1G1fDfgLZdF2T2zHhw=
X-Google-Smtp-Source: APXvYqzAlc7bFHue5cSmhqH32wIIlB0o1cmx03MuWcZ9BvTgYul39ig453r5UfQpHDKl9FqDGGe9sg==
X-Received: by 2002:a63:f5f:: with SMTP id 31mr10859655pgp.265.1569613189080; 
 Fri, 27 Sep 2019 12:39:49 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/18] target/s390x: Remove fail variable from
 s390_cpu_tlb_fill
Date: Fri, 27 Sep 2019 12:39:18 -0700
Message-Id: <20190927193925.23567-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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

Now that excp always contains a real exception number, we can
use that instead of a separate fail variable.  This allows a
redundant test to be removed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/excp_helper.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 6a0728b65f..98a1ee8317 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -127,7 +127,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPUS390XState *env = &cpu->env;
     target_ulong vaddr, raddr;
     uint64_t asc, tec;
-    int prot, fail, excp;
+    int prot, excp;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
@@ -141,20 +141,18 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             vaddr &= 0x7fffffff;
         }
         excp = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, &tec);
-        fail = excp;
     } else if (mmu_idx == MMU_REAL_IDX) {
         /* 31-Bit mode */
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
         excp = mmu_translate_real(env, vaddr, access_type, &raddr, &prot, &tec);
-        fail = excp;
     } else {
         g_assert_not_reached();
     }
 
     /* check out of RAM access */
-    if (!fail &&
+    if (!excp &&
         !address_space_access_valid(&address_space_memory, raddr,
                                     TARGET_PAGE_SIZE, access_type,
                                     MEMTXATTRS_UNSPECIFIED)) {
@@ -163,10 +161,9 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, (uint64_t)raddr, (uint64_t)ram_size);
         excp = PGM_ADDRESSING;
         tec = 0; /* unused */
-        fail = 1;
     }
 
-    if (!fail) {
+    if (!excp) {
         qemu_log_mask(CPU_LOG_MMU,
                       "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
                       __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
@@ -178,13 +175,11 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         return false;
     }
 
-    if (excp) {
-        if (excp != PGM_ADDRESSING) {
-            stq_phys(env_cpu(env)->as,
-                     env->psa + offsetof(LowCore, trans_exc_code), tec);
-        }
-        trigger_pgm_exception(env, excp, ILEN_AUTO);
+    if (excp != PGM_ADDRESSING) {
+        stq_phys(env_cpu(env)->as,
+                 env->psa + offsetof(LowCore, trans_exc_code), tec);
     }
+    trigger_pgm_exception(env, excp, ILEN_AUTO);
     cpu_restore_state(cs, retaddr, true);
 
     /*
-- 
2.17.1


