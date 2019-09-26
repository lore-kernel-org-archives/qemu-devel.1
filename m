Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52E4ECE589
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12E021655
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aL6dZLIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12E021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWoD-00071U-Fk
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcE-0002gL-0j
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc9-0004kc-02
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWc8-0004hA-KU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so1527977plp.6
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fGRu+QIbI0OANf3LHBbL23ZhxIBUgo0bhuy8UzPS3No=;
 b=aL6dZLIJntEIKwuU1EJKaOys73DRWM/AzLtL0VP2ZCcZE3yBVr794qvxjNnoaO29tJ
 OnOHwBKrPRdvlm+YFph6s0EhEo/nV5oAC81Jg49g63vLSkuByS0CdYtb0B5b+1FoJ6FO
 XigYen3SSQgZlheFPX7Vi/94qWbP/dpUluO9QDDHUmJQZpF6wmVEy301ktxf1pDbSnAg
 JbRHzr6fOcII06xzUU++TfNffg0yV0ikt9ePEGBHiYRcxez2xzWa3YpYKhV6ppvcv4H5
 m04wjk3d+h5Nml+va0jO1sp+FiR3Fa4oK6osjdx1QgB7ZPv3MkDe3WGjUNE2uQ/Wqdn9
 YwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fGRu+QIbI0OANf3LHBbL23ZhxIBUgo0bhuy8UzPS3No=;
 b=PjF2I5Kt5AcO4vuK1Etcpf8ubWkFDtDy7ZoJn1y3Xe3HikpskTHdj6MklJRRXOb8Vp
 B/ldfrikCNIOOmGvOByKZzvbIf6v/63BwRqkaBIrWX3yPhU8XadQHZ/1HfBWMa5u9GBx
 T1buXjKE/L2R7bMAS+D3BQCVfldN5K58xINKJw3W058jX1h1KGF+a+66AAYgRYZCLq2j
 A4IlEY9r8APSrH8Ca2Eu30/NsJblnF1g352EbOYonVVmfcoWC3B7bUUCpzdWSrmhL0Jv
 b8yaRGwBTkgaG6s7iZ0G8zWZcpsH3l5ddDyQxeiJkOg0T/jcATNzyQuqCr2Ptp9AkDuj
 csUw==
X-Gm-Message-State: APjAAAUo6V+WBXKf8p/Z8MMPBrG2YvfMdbbqDKYaFE3LSK+C5bAFONZI
 /CV0plC8TQjGf3xwbnOqSFKAH/PleW0=
X-Google-Smtp-Source: APXvYqxfqirfUK4MjTH8/fm9qra2M9/GSU4NENBeAJ3QUB7QetxP64LSDLgCrZpV06YgubOb1se4og==
X-Received: by 2002:a17:902:9a81:: with SMTP id
 w1mr5152871plp.124.1569515187948; 
 Thu, 26 Sep 2019 09:26:27 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/18] target/s390x: Handle tec in s390_cpu_tlb_fill
Date: Thu, 26 Sep 2019 09:26:04 -0700
Message-Id: <20190926162615.31168-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
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


