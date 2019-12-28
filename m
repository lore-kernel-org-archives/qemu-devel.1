Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E59C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4312920838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBqcKKCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4312920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLS8-000476-WD
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGM-0005xw-PS
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGL-0001Ma-JU
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:50 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLGL-0001J1-CG
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:49 -0500
Received: by mail-pg1-x541.google.com with SMTP id k25so16252482pgt.7
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YGX16RdW2itYDRX1lminhJhJxtzn0dioVEW1Yirv0gs=;
 b=TBqcKKCcaHD8bof+7XxtpikGQ9wx5h5ki1LyQRHJ3p36w+zWjnfZnEGp3HThdUmVF8
 dGGl6XatM9eDfd30Sa5NC+xMUtDDAtWtl87woqwAXi0fTn3ZUHZtHKSMHxCmzEFDffGl
 0NQwO66omS8Nd7oBme7njgMLFn6V3254qiDa+IDALjwx3bgGksBgUkShmOKMkVdiv3KD
 oFNasLNlFHR3LiNaNMXciYA+SSH95S8WppbC4PZr+hRwS5d4+dN8b4eriKTsX1R3OkJP
 v4ldG76OD+lGMj65O3q9RdFWK2PpAV16Ynoyen98tzTbtR7mWSGqgdLu8YM9T++zn1oz
 J7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YGX16RdW2itYDRX1lminhJhJxtzn0dioVEW1Yirv0gs=;
 b=I0ZaOz6KVOLfz6kysFZCyfq7SPpu0TPNo6gGAdLELm0gbkjkk7CyBK6OHFOmwCAtys
 e6krqmhxpJ4k/z7mhwX3g+xD2SKCc4Zfy+sLaQrnb3Tf7qOUdFTDRLTsRcIACULEpFJm
 X6kFylKblC+jp3qV3aD/fShPtjoghWxtSBzP2KYaWpE6cILBSK/1kVzoEsX53rWd6+sB
 uIC6s1pN0JN5xnBMIf8uarwj6I3cqFhrChEy9DW2PduOYGi1KM8w6GUJpvJGq9PacSfD
 tSWMXm2HvF7JG5hIci5162pWIKqSKDCOmPVTK5I+GL9G54WOOsont15DyijZ5q+1SdFQ
 WJzw==
X-Gm-Message-State: APjAAAWJ8NW6TYvNYZS+4zPipawh7CpZLfpACVcsBz5dvMBQSAM1h4ZR
 cMV0l9ykOevHDq+jbetGcwDB1dWTE7o=
X-Google-Smtp-Source: APXvYqzkDgpNo5YcCcM4j50lNseo4h4ERXhN89z+Wh3wzg6wy4xPh8kvCwrbhgm1QawkjdyLo4tdvQ==
X-Received: by 2002:a62:1613:: with SMTP id 19mr64371582pfw.7.1577574768260;
 Sat, 28 Dec 2019 15:12:48 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 26/29] target/s390x: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Sun, 29 Dec 2019 10:11:21 +1100
Message-Id: <20191228231124.18307-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generated functions aside from *_real are unused.
The *_real functions have a couple of users in mem_helper.c;
use *_mmuidx_ra instead, with MMU_REAL_IDX.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use *_mmuidx_ra directly, without intermediate macros.
---
 target/s390x/cpu.h        |  5 -----
 target/s390x/mem_helper.c | 10 +++++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index e195e5c7c8..8a557fd8d1 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -36,11 +36,6 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-#define MMU_MODE0_SUFFIX _primary
-#define MMU_MODE1_SUFFIX _secondary
-#define MMU_MODE2_SUFFIX _home
-#define MMU_MODE3_SUFFIX _real
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 20a84b3912..428bde4c54 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2026,7 +2026,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     real_addr = wrap_address(env, real_addr) & TARGET_PAGE_MASK;
 
     for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
-        cpu_stq_real_ra(env, real_addr + i, 0, ra);
+        cpu_stq_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
     }
 
     return 0;
@@ -2260,11 +2260,11 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
         for (i = 0; i < entries; i++) {
             /* addresses are not wrapped in 24/31bit mode but table index is */
             raddr = table + ((index + i) & 0x7ff) * sizeof(entry);
-            entry = cpu_ldq_real_ra(env, raddr, ra);
+            entry = cpu_ldq_mmuidx_ra(env, raddr, MMU_REAL_IDX, ra);
             if (!(entry & REGION_ENTRY_I)) {
                 /* we are allowed to not store if already invalid */
                 entry |= REGION_ENTRY_I;
-                cpu_stq_real_ra(env, raddr, entry, ra);
+                cpu_stq_mmuidx_ra(env, raddr, entry, MMU_REAL_IDX, ra);
             }
         }
     }
@@ -2291,9 +2291,9 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
     pte_addr += VADDR_PAGE_TX(vaddr) * 8;
 
     /* Mark the page table entry as invalid */
-    pte = cpu_ldq_real_ra(env, pte_addr, ra);
+    pte = cpu_ldq_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
     pte |= PAGE_ENTRY_I;
-    cpu_stq_real_ra(env, pte_addr, pte, ra);
+    cpu_stq_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
-- 
2.20.1


