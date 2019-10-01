Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F2AECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625E92133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9aSuzgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625E92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLvj-0003jf-I7
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlF-0001ZN-0H
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlD-0005WL-R1
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlD-0005Vm-J1
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id y5so8478467pfo.4
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bw1EswX2q2VGPW65WyDJY/ECQ0OS5tcrpjiTXgyT1jE=;
 b=L9aSuzgqgi9Rij6MUGGu7Wo98EJkVze7m2y0DrsatJw3xN1N468ZhLZtNOS6uIBm5g
 NkRSgYvM8rrPNgUsmYstch5aGQ2ME483EdqDqgkJtP0e1uYE/9HLU5DrrdX3vwEuzbd7
 ywo4hpbkMPlMSAfseHRyGa2zMRycr3j2cA+mgoC4YjUeUxBzv+uhlOpt4dcyDAejuCsH
 Efj5dvSuiDXFTNH39PV4FPBFg0xEKUut+Tpr/McebRlRBC6V9XyE7tDBnd1YczraLYk0
 6Pt4uYLsUeTsTDZ/JpFvolh7TZZpEW7sDMV09nPRw/Fv1WeMvymtHeVxR5VmGnaiffrd
 aYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bw1EswX2q2VGPW65WyDJY/ECQ0OS5tcrpjiTXgyT1jE=;
 b=U8MzEOwh+aToFIOrgOmU+fOF0hqYtjilFye/9GghQKucFnb2HPwcJcYAg5VrOIfKgw
 WMR4dfRs5GxeE0ryq0MSGvZ0bWEKh+eszrEX0x89vq2M2IditqNUQ1+EPsXztFWbhM8F
 A66IV0cV+BFWFrHZIDTVqYYHGZnBg8eGHa1RanXkmHltePISZpNSgLaQWmmTaK5ReK49
 /AQK9EC5Jksr/El4k0OOZNSgPfmJWhFq8GWcdDogxEAQ4Y7oQ7poVISTX4Ie0cYHpvUy
 N2E6onNBPRi2/s4O0fbTmE1XGxe8oE7SXiL0QjTNOCJ5MFskyNt0WuTP7M5bxtUD32ce
 W2Bg==
X-Gm-Message-State: APjAAAWYUaFyi3vCtxeWIfDOhzlFoiNfO+hjpXUc0IuG+lq3jUJBDOvO
 P8VM3y9zBCgcp97+CUrCPbDZoRrCe+w=
X-Google-Smtp-Source: APXvYqwKQ7GH8fFNbk0JjpgX01kouNCDNubrTc+K7CAtSkV1wsrZ0yKRLBeACVUJZbhpUTDOXaJUAQ==
X-Received: by 2002:a17:90a:cb16:: with SMTP id
 z22mr6976210pjt.70.1569950185539; 
 Tue, 01 Oct 2019 10:16:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/18] target/s390x: Return exception from
 mmu_translate_real
Date: Tue,  1 Oct 2019 10:16:03 -0700
Message-Id: <20191001171614.8405-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: david@redhat.com
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
 target/s390x/mmu_helper.c  | 14 ++++++--------
 3 files changed, 9 insertions(+), 11 deletions(-)

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
index 4a794dadcf..e8281d4413 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -554,14 +554,11 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
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
-    uint64_t tec = (raddr & TARGET_PAGE_MASK) |
-                   (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ);
     const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
 
     *flags = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -570,9 +567,10 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
         *flags |= PAGE_WRITE_INV;
         if (is_low_address(raddr) && rw == MMU_DATA_STORE) {
             /* LAP sets bit 56 */
-            tec |= 0x80;
-            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, tec);
-            return -EACCES;
+            *tec = (raddr & TARGET_PAGE_MASK)
+                 | (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ)
+                 | 0x80;
+            return PGM_PROTECTION;
         }
     }
 
-- 
2.17.1


