Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC410C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C331222C7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="drGvDfZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C331222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWuH-0004Jr-32
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcH-0002kQ-S2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcF-0004q3-4X
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcE-0004oq-Tu
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id i30so1868896pgl.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BgDvG9Al3WPKQz7RdZ0r1UKiV65zPVQZj9u9agDKhUI=;
 b=drGvDfZb6YF/SSjGyBem6M9wPyEtLuKKsTfnqEZW829cy7+5yUob548Xe+a7ASM3Rf
 ttTJQcpBtqNrUBFj4KDGXBzTsF+o3ANLHINy49AGl88Gy1W0H3UOuDyIciME6fkCLAv/
 aRQ8/r7wGef2Bv49+bxlfCnwRrRG6GhwIopXx2aMzd/F41jBDV3ap0cvsJbDbqitYRMb
 yGZhuplPQl8h7Z0BNJZ66Pqn0pEuVMuhXzxdzXQmiEdAXII2HkXuCERa+CBbnW/JeWBQ
 Jp1x1B2JA2s7Xq0y4ZeXgKXfgS6UKsuDYdRrac7pfh+xTdFFiTKVg9nS6QlvBKR3M3F0
 yLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BgDvG9Al3WPKQz7RdZ0r1UKiV65zPVQZj9u9agDKhUI=;
 b=enTWbEAV/oIDxdB+usAEibI1qkl092g9wH2nRIBzVeoPeGt3dGZdi2WwN4Pxp4Mnrs
 4AXEsJrd+TOL7TwNQd1d8GkLN/KACKQ3V6XVN37WN/c83ahG76JVnABFS5JzAHghXAmQ
 tD/W1XyYmBX4bHr0/hzcEgHJLQLmqf4OOh8g86RLKgrK1ltVqLZa7qGmeN4PDU9LJy0O
 ckE9fCniDFYRf77YGhzqNgQjGKpP3ZYxMxOJgAaY8LkZ/CO3SMQK/TqQLdhPNSzLJ0f/
 kXRcov42AUrckuH2qmkK+MaQbvL/kEhCm7gn1q8m8HeviBeWgMTuSbvqpnKbsWIX+N7Y
 R3zQ==
X-Gm-Message-State: APjAAAVXJn6Bey9F+fDAxgaIHjMd7LeLT3v+3/PLgRQPYnJ/FLx2DWTT
 lBJ57uSQ57G/L5CidzKCK+HKSRUx8iY=
X-Google-Smtp-Source: APXvYqyJ3PehV41h4PGJtbPAbIOJ5pSNE0wxOYdlSeJSm7xx3rRvtndh67YWksxXAvepMI3jqAZr/Q==
X-Received: by 2002:a62:e917:: with SMTP id j23mr4667444pfh.50.1569515197306; 
 Thu, 26 Sep 2019 09:26:37 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/18] target/s390x: Rely on unwinding in s390_cpu_tlb_fill
Date: Thu, 26 Sep 2019 09:26:11 -0700
Message-Id: <20190926162615.31168-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
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

We currently set ilen to AUTO, then overwrite that during
unwinding, then overwrite that for the code access case.

This can be simplified to setting ilen to our arbitrary
value for the (undefined) code access case, then rely on
unwinding to overwrite that with the correct value for
the data access case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/excp_helper.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 98a1ee8317..8ce992e639 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -96,7 +96,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 {
     S390CPU *cpu = S390_CPU(cs);
 
-    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_AUTO);
+    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_UNWIND);
     /* On real machines this value is dropped into LowMem.  Since this
        is userland, simply put this someplace that cpu_loop can find it.  */
     cpu->env.__excp_addr = address;
@@ -179,24 +179,15 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         stq_phys(env_cpu(env)->as,
                  env->psa + offsetof(LowCore, trans_exc_code), tec);
     }
-    trigger_pgm_exception(env, excp, ILEN_AUTO);
-    cpu_restore_state(cs, retaddr, true);
 
     /*
-     * The ILC value for code accesses is undefined.  The important
-     * thing here is to *not* leave env->int_pgm_ilen set to ILEN_AUTO,
-     * which would cause do_program_interrupt to attempt to read from
-     * env->psw.addr again.  C.f. the condition in trigger_page_fault,
-     * but is not universally applied.
-     *
-     * ??? If we remove ILEN_AUTO, by moving the computation of ILEN
-     * into cpu_restore_state, then we may remove this entirely.
+     * For data accesses, ILEN will be filled in from the unwind info,
+     * within cpu_loop_exit_restore.  For code accesses, retaddr == 0,
+     * and so unwinding will not occur.  However, ILEN is also undefined
+     * for that case -- we choose to set ILEN = 2.
      */
-    if (access_type == MMU_INST_FETCH) {
-        env->int_pgm_ilen = 2;
-    }
-
-    cpu_loop_exit(cs);
+    trigger_pgm_exception(env, excp, 2);
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 static void do_program_interrupt(CPUS390XState *env)
-- 
2.17.1


