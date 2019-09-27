Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD177C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C657207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVlsN7Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C657207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwRd-0001Hn-Oc
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 16:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5t-0003RY-9O
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5q-0006Yi-Lm
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5q-0006XM-3I
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:54 -0400
Received: by mail-pf1-x444.google.com with SMTP id y72so2118490pfb.12
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8sg4rb5KuIBYRa5veNL+5ohAGWn4FiKab4HtkGWajes=;
 b=lVlsN7IyLeO7dpem0HVwA10RkE/I9azz8CMvlxTsCjCZpiJdPRmS8yfLh4sxtQm7vZ
 UyRE81WvAMq6uwm2ucaG18vHSxUXVgOWSCtNfQPJdusuvDJymdM+QSpB9QkncwHxBwHg
 iaKkpFblXh2OABGcPkA5Zytv2a5lFz69Na0qjWWUD/3nCy3psCoZk8i2mwXL5JYiZ2Jn
 ac/fjUx7Lj4mcRC+Hq1XT0ws9N3CU9nHOEfApeUk67bum9KVbMAt/bEO5Xf3yFWFQklh
 kLuYwByvDGMnYmC3ADDYlNrq0DQ3dw5cSIhXT4HNPSXkTWkeoRj5bcISRrYojFBIvlFA
 yYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8sg4rb5KuIBYRa5veNL+5ohAGWn4FiKab4HtkGWajes=;
 b=b1ysLO2sdg4sBx3oCVYWLcl5oxhm0t6x+ep0teQSS39A/Zk4CdpQxAVHQBKwSZOUQE
 EEZlQXlvltc3Xijjm0fgcLeWFrhBAGvEOtFq0SH1HX2+xI+GGCTY2Mc8dry4teHnw5Of
 Kj/BVjBS+z6mKiWgAAcKxNcfBVjbg0N6x8arFKKbjbQ4jcf68+ANdRWDi6pISHI1IF1u
 u+8uvh6LCIWMgdGSEqjmWthLINgB39Cc8FFNjmV3Hd0zbbT/UkrJw5YiNVHo4ZJ0IohQ
 fZA1Q/ad7rTulvVtyMZQc+BAdBoSN9RPkywK0u/83tJoYMpTMm2bOjyrwxgwxZQeVRFw
 tbGQ==
X-Gm-Message-State: APjAAAVqjMdKoCME31YwP1HaKOg1I/KcqHBCUV+HDCzGvTYD7MCWNXsK
 2/+ovIziIPYNH3Z1OapeIZcM7Bu9V28=
X-Google-Smtp-Source: APXvYqyzg4Oy0TaNjrZSIcFNUnEO+81UD+RB5IKiee9NcOzQMTGYTJ/ZGJIIrOlGIz2ocWIuH9UbtQ==
X-Received: by 2002:a65:6111:: with SMTP id z17mr10959743pgu.415.1569613192341; 
 Fri, 27 Sep 2019 12:39:52 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/18] target/s390x: Rely on unwinding in s390_cpu_tlb_fill
Date: Fri, 27 Sep 2019 12:39:20 -0700
Message-Id: <20190927193925.23567-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

Reviewed-by: David Hildenbrand <david@redhat.com>
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


