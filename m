Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92968C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5F520863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNX6fbR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5F520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwBI-0000fN-D5
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5i-0003JW-PB
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5f-0006Le-2k
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:45 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5e-0006K5-K3
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id h195so2133390pfe.5
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=H3DBi0mNjNbESSisGeli3T+KiEWE4J/mD2CVZfFgXJw=;
 b=KNX6fbR8apO+g8LVDSzEEfiqlm1PbknhpJtagRAUlwitBE/EqjnrOibnDMhzOpuDjZ
 iHzRylMJzzq/fbpVoh2+FseNSoikft2QddbFT/sfZ9niUQycGM2ow55/AMAdrceZC0SJ
 WcYUZBTGvKxqBA8qhw2xZ698qe049xyBfVhNo5M9OCIH5t1QVQNXcTUFsGCxg8gShsh4
 NaraKIDDdQAUw92+PVCPxqt0mbC0LmZqu7fcVV4w1WT0oeK0bkuzwd9Lx3nEjuXZHL4y
 lKggtvdaswB4kzHXa16ZaGkreYahE9YUJQfhTkxoEgcb11XIUv6z1TS7Z6xurFAzlW12
 F5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=H3DBi0mNjNbESSisGeli3T+KiEWE4J/mD2CVZfFgXJw=;
 b=c0HRmma1hJpbR8g74Pkp8tdsMYJs4MxfuiQJ9yw5jpUyPToUJkzX2dVeyoXAHQpQzF
 45gcxY9KnSGaqgZMV6zetwxxJuTChrC8EuL7H7dvUe/UzfNm+AfIom6T4s0Ocu6dI0w4
 YbeldD3Fxl15opkw+nfAU+m+lsUb0eOI1JxU+gd1wCQ7WLGcQBhMQqfaXXwNrLuMgzkj
 Y5Ve+kVZE9fF5pLg9cytXEX6CZFy9jOcjIDr9K3gataG1tI43mszM0b1xmsTCx2FQ8oD
 PwS//o9qpIAUQLzzMBdUOOj1ROma9xyPoGJsFmHkJXsNlizXhFR20EKFD6BrOzCWrgbg
 0Geg==
X-Gm-Message-State: APjAAAVsyyqla90eRv+GD7Urq+Tcenn3Ps3FS5k0FYe7SYHqMWyKCSUc
 T3BN/VC7qgbJK5L/rILvJAK0HKpKlY4=
X-Google-Smtp-Source: APXvYqyCIWYAY6NYRnUqV0ossQkp61f1dZbxhOiAYiaypmaNqpARdR9TURFY68TgfFNAnPlrYz6eqw==
X-Received: by 2002:a63:b102:: with SMTP id r2mr10894222pgf.370.1569613180880; 
 Fri, 27 Sep 2019 12:39:40 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/18] target/s390x: Handle tec in s390_cpu_tlb_fill
Date: Fri, 27 Sep 2019 12:39:13 -0700
Message-Id: <20190927193925.23567-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

As a step toward moving all excption handling out of mmu_translate,
copy handling of the LowCore tec value from trigger_access_exception
into s390_cpu_tlb_fill.  So far this new plumbing isn't used.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/excp_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 552098be5f..ab2ed47fef 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -126,7 +126,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     target_ulong vaddr, raddr;
-    uint64_t asc;
+    uint64_t asc, tec;
     int prot, fail, excp;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
@@ -162,6 +162,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
                       __func__, (uint64_t)raddr, (uint64_t)ram_size);
         excp = PGM_ADDRESSING;
+        tec = 0; /* unused */
         fail = 1;
     }
 
@@ -178,6 +179,10 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     if (excp) {
+        if (excp != PGM_ADDRESSING) {
+            stq_phys(env_cpu(env)->as,
+                     env->psa + offsetof(LowCore, trans_exc_code), tec);
+        }
         trigger_pgm_exception(env, excp, ILEN_AUTO);
     }
     cpu_restore_state(cs, retaddr, true);
-- 
2.17.1


