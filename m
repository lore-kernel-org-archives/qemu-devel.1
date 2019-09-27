Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B76C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002BB20863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VACet4xW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002BB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwBO-0000lq-6R
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5j-0003Jz-Uo
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5h-0006P9-2N
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:47 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5g-0006Mj-K0
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:44 -0400
Received: by mail-pl1-x643.google.com with SMTP id q24so1462443plr.13
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=S7TwNfUbxZvOxX36TdLooJsySBiwUy20PbV1xw5QyNY=;
 b=VACet4xWLPtmVsJUjLes8xV7QrVTQ7KilCF+gMzuGu0ReWcOty3yE6f+eCfqSgYlP9
 8pktspZcdYSk+F5a2EKrtaQVIOYmfwA0i+kU3JjIi2ibyBQRM590vWCpx4iPU1zKTFTK
 EAHMb93wA+cFVyTk+Vhxkc2Dn7FVo8eaMGuWE93XUtayjGGT/BqEdKQVG/qWc3wOUMTI
 0eJRDsU29LhlFu+GOYH59Q5kTv6m/+Yv66OGHKl2TyO+LY9o/rJT3bG/CcMk357ACBMA
 EJ+vF6mS6kQs029Vljz6iHJnlinEIZyB3k3ICjN0qG88kMoLKyiHcO1vr5ID844x1J4Y
 VUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=S7TwNfUbxZvOxX36TdLooJsySBiwUy20PbV1xw5QyNY=;
 b=JqdzqVGQKE8ru6Rq049RNG1G/8n1G2PS12hnX1pzD6g4goa/xv0zPn3mV0MZv5qrmB
 Ge16kBofSRSGEK4oygo191TQ/XL5hPAI1Lls5gJP0CKrJh6XGSdYwHPvRM5StLLLZb7P
 ZsTv6hTGVY/pvkN/Nm4deFpUS0Hjwgf1dx/oXBP5RghGPMUd+lE+7mKYIUmqiatPRUd9
 IobMpHFiaV+qoTlSIAQkt8qrISwAX2qbcGlxi5Op6XYSLdTjJ9CVePGi8KgoQh3XdSaS
 P4Ahb1yasLZYFPzuC76ILhcDj+/fxevOh/X2A/hd7gNPLUT/8pT+sjakfrFiW7qdySxh
 qsjA==
X-Gm-Message-State: APjAAAVue1DMnUm2rjd/eIcXPNQEG58zkyJGOaQyIzGEpI314oW3KVNQ
 QEBOUkK1+FwGY5S91x4jcr4LXO62GuU=
X-Google-Smtp-Source: APXvYqwiyPgIjLsRTMLHuQ3ObZ6aP8HWsLE8+lUMcEnz9A9FsJAD1+mLZnXwyOs9vkxGaPcUswmflQ==
X-Received: by 2002:a17:902:9a0b:: with SMTP id
 v11mr6491744plp.202.1569613182765; 
 Fri, 27 Sep 2019 12:39:42 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/18] target/s390x: Return exception from
 mmu_translate_real
Date: Fri, 27 Sep 2019 12:39:14 -0700
Message-Id: <20190927193925.23567-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

Do not raise the exception directly within mmu_translate_real,
but pass it back so that caller may do so.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |  2 +-
 target/s390x/excp_helper.c |  4 ++--
 target/s390x/mmu_helper.c  | 15 ++++++---------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c243fa725b..c4388aaf23 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -362,7 +362,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, bool exc);
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags);
+                       target_ulong *addr, int *flags, uint64_t *tec);
 
 
 /* misc_helper.c */
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index ab2ed47fef..906b87c071 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -147,8 +147,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
-        fail = mmu_translate_real(env, vaddr, access_type, &raddr, &prot);
-        excp = 0; /* exception already raised */
+        excp = mmu_translate_real(env, vaddr, access_type, &raddr, &prot, &tec);
+        fail = excp;
     } else {
         g_assert_not_reached();
     }
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index a142663b0f..48ebc62497 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -555,15 +555,11 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
  * @param rw     0 = read, 1 = write, 2 = code fetch
  * @param addr   the translated address is stored to this pointer
  * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
- * @return       0 if the translation was successful, < 0 if a fault occurred
+ * @return       0 = success, != 0, the exception to raise
  */
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags)
+                       target_ulong *addr, int *flags, uint64_t *tec)
 {
-    /* Code accesses have an undefined ilc, let's use 2 bytes. */
-    const int ilen = (rw == MMU_INST_FETCH) ? 2 : ILEN_AUTO;
-    uint64_t tec = (raddr & TARGET_PAGE_MASK) |
-                   (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ);
     const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
 
     *flags = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -572,9 +568,10 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
         *flags |= PAGE_WRITE_INV;
         if (is_low_address(raddr) && rw == MMU_DATA_STORE) {
             /* LAP sets bit 56 */
-            tec |= 0x80;
-            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
-            return -EACCES;
+            *tec = (raddr & TARGET_PAGE_MASK)
+                 | (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ)
+                 | 0x80;
+            return PGM_PROTECTION;
         }
     }
 
-- 
2.17.1


