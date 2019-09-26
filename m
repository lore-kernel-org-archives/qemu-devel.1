Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6281C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FD621A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJk+sjyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FD621A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWzf-0001Lr-1o
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcF-0002hm-4L
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcD-0004o2-9x
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:38 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcD-0004mQ-0p
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:37 -0400
Received: by mail-pf1-f169.google.com with SMTP id a2so2111523pfo.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4k4lvT04oMAR1JlrF0Tsj3jcXJHGRIvEwhrMLXeNKHo=;
 b=jJk+sjyckdNb41zkRDY8tc/T8TxEHGRCkRo+tC/9PPylmD80SbU9XLU2VBAf9M+zFJ
 f1IPgj3urdHXsEyxiG1y44UWcRRbVtFrIWDswtzrfqEdjnJl7FYT3KeoWxKl4KNC+Ef+
 aDSKO70yRiCyX6oyKf7plSNs5Go3KXAIGFW+MqGvQ8L49uRpQ8e10v0ZfR0eg+GEhv/F
 18lAgJAmWhWsBltrkEFrqYZTxqt7j/FBbWBjdc8AgdZ/jJIo9geCHZKYNK+bvZwr8l94
 HAFatT4dHpFRqM6w3/DnwpR08rmQuOm0gK3oGSAt6lA4hBJPUT0mXK3j8u/+zxGICtf5
 k66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4k4lvT04oMAR1JlrF0Tsj3jcXJHGRIvEwhrMLXeNKHo=;
 b=ZCDkSlmTbP4EVws8494Q+SWIhO95D7Eqxv8P98/qFDlWGDgljcfjSnf4C2nV72LkQ0
 7ujo2ZkC+rm8vGhZp5hTNGoGQ6ZjQTNtY+gXprPfD4ZUELRoaHBmJruiZ+J6HeM9QMlg
 Xo7KCbjNiZ02UZPPYzJ6ylYMaKLmeiDBP6aGhW5tCNwom5P/rUj/NYW8ekJhJG4EV98N
 hzghqCdiYfH4DyDe+LrFBa7rLCh5VQkickaBvxsJD4O7AdSgy6/nA/lTaZ/AS1w1x9rG
 HO1Wcop1B0zn3KAJcw+2+RCKUlvs/cNi+HqH9ctXTKm8PGNo6rw4n7ICjoUoPKqaq+to
 m9jQ==
X-Gm-Message-State: APjAAAUtTgiv8olhIfy24vH6D1l7DKXdU0oNksW9ITR88/JM2t1wlrOP
 YkbtzTQ9dCGL3JmM4LPlb+rtjGB527k=
X-Google-Smtp-Source: APXvYqxZhkpO+/zPuBl8Ag5yb0wBKfRADQRdjoIajYs5kBjbYes1/hf9zVUeKQWXhHqXJXshU33amw==
X-Received: by 2002:a17:90a:e290:: with SMTP id
 d16mr4579073pjz.86.1569515194863; 
 Thu, 26 Sep 2019 09:26:34 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/18] target/s390x: Remove fail variable from
 s390_cpu_tlb_fill
Date: Thu, 26 Sep 2019 09:26:09 -0700
Message-Id: <20190926162615.31168-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.169
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


