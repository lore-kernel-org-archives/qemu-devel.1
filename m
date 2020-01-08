Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8163C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A977C2146E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7q8O0WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A977C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2kM-00034h-NT
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JP-0005OI-6y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JN-00045h-Vu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:14 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2JN-00045A-QC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:13 -0500
Received: by mail-pf1-x442.google.com with SMTP id 2so892004pfg.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WYN2QItvAay87lkoXnlW2XXwTd6qqngmCswIOi1zNl8=;
 b=V7q8O0WS60WKvKBVV0XINZCjXqnfNV4NJvm1D61JRyccIJXYr4Kg32e7hDpQY1Srcs
 7D6FGM/yXmZM2S/3GV4WFZuJWt+BV/SNNqpmOdLF1t2VpfDA/sVHnZ1cfMEkTs7qyDrH
 5NE93+hdIi6HtqHlSfeNQpB0lUoa4Uxf+baC+KcFzSl1QPhOQu52cCSItXj6G1g1QTnu
 W8csSjxvYXVMIUG9rWlYd1r+CYv8vDhtQFt8IwKh/b0cNyA5B1gZq5ClrfFG0m2eZPSB
 jjdfzat0km4LDq2SniqmuLVHqt7U5yLR1oUX3CSoQP+LpZxPAD9+MX7jBlVY9cKqaTEB
 t5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WYN2QItvAay87lkoXnlW2XXwTd6qqngmCswIOi1zNl8=;
 b=hFvMAAPi67SFofF3V5Rf6R+sbKmJg71DDomzdyCeVfVBOeT8uqiL3qduaJMjfj5ldl
 BJEV1U7cTAPDE4rLgqxxagLwdCIVEU2ceKVKPHNk/TNmCXcpKzleE7E6ef34SWOYTc7p
 nFKwRwlewmTPzDqfz2jAmVnWvziN8IEezpjYf2Bo+4t+OVeAKIPdqqLZtNmNTl314nzg
 SUHxe2012cj7HXSToVsvHGi2EME1KIQ6jByFf+YuyNmjuKCcGr4rGkgcy20q7efcE/Kd
 KkuOkC5ZSxmk0TQEgQ2zoUByP9m2lDyPMhRj27V84PonLPFYtcEAAsOcCMSYwhKdjOpP
 zyYQ==
X-Gm-Message-State: APjAAAVGoYMdXcKVQpM4xZ0p0fN6lHth5RV0PHwC/lQ7imb8EoezplhS
 OZfEQZNhF//SKdjVySugVVshD1v3mAnkEw==
X-Google-Smtp-Source: APXvYqyy3USIgzif9biIYk3l95gdnCGNdX7QPfSrFrPmywsYtMoD+bNSpnIrOgZNY+U3d7+aRf9vGw==
X-Received: by 2002:a62:1883:: with SMTP id 125mr2844812pfy.166.1578455232689; 
 Tue, 07 Jan 2020 19:47:12 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] target/s390x: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Wed,  8 Jan 2020 14:45:15 +1100
Message-Id: <20200108034523.17349-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generated functions aside from *_real are unused.
The *_real functions have a couple of users in mem_helper.c;
use *_mmuidx_ra instead, with MMU_REAL_IDX.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


