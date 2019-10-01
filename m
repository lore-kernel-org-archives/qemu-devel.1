Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F90AC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A0E2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOYp1zg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A0E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFM3v-0003A0-1A
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlM-0001hO-2k
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlK-0005ag-Vh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:35 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlK-0005aB-Qi
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:34 -0400
Received: by mail-pg1-x544.google.com with SMTP id 23so1581006pgk.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8sg4rb5KuIBYRa5veNL+5ohAGWn4FiKab4HtkGWajes=;
 b=AOYp1zg77cPRcPif9SMkLZAwAdK0Aph7iPlFFqUIYy1d3Il+kSG65LK2QSOZVHwSnP
 fgu3aiurBne1CoecJ4aTcK0n5r8FigcpaSpXZRIzKtyZx0O3s1esRbA0EXP7MjEpoCx4
 4L2IftCilatqVELDoAsEo43NlHORU+yXA1A6fOEa4ATjUISkyNYajO6NKaWJsHKcAwrF
 w1iQwjJJFIhC/FZxKdymclCEwscMGfDxmH9Hlb5qBfdUrVNzc7PRc3zkXxNcYoJmv9JZ
 oD/RTN14QtQFKBLdGtUr+LmOgMq1rypQ02skfv4UfXK1WpTjj3mZrG3EvDR6LklJzLzP
 HVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8sg4rb5KuIBYRa5veNL+5ohAGWn4FiKab4HtkGWajes=;
 b=UHThDNoRPpHfQTcOMa32w59gS6MBjp3HjiULofaF+Oxbf3pv5lMYvp/LplQM8tdKRC
 RWWzrTr+KLmoMi8Jo/NszeqRrvbKJRNBs7nuOYa1qEW0USHuNCLIHwOfZEghmh5i7rpU
 cje949wMtUVAOIUlFYXTBu5kCmoMhjQDmU7orLrY5nMIRetzfa57zMAx/o3LtdZy7SHO
 bj58XO2jTxWdFs0xd4dGMRPMuZ0DbQHs2sGNqVa0CavfJ1wTYrSLs+C3G+YlyicE/JTo
 bEGfKE4mlL48KPENf1I6v7Fs3WakiF4YLO3bQrmfBUeZqulMMqodGeQBVsprP0NbPsdw
 g9TA==
X-Gm-Message-State: APjAAAX8eUtgMbfPhPSGW1rve89l5yXfj5iu1I6lpzoiAzdp32H2ud6C
 uA6/l3SommCfQ8oVA8Nj9wRd+8RXvWU=
X-Google-Smtp-Source: APXvYqx0i8UhK0TTTivkzWFNEZNcXdUIF7UROu6QrBAmgZaD4hLZt0vaJ+jROo99ucNHM6fP21Ev4w==
X-Received: by 2002:a63:ed08:: with SMTP id d8mr32188280pgi.239.1569950193356; 
 Tue, 01 Oct 2019 10:16:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/18] target/s390x: Rely on unwinding in s390_cpu_tlb_fill
Date: Tue,  1 Oct 2019 10:16:09 -0700
Message-Id: <20191001171614.8405-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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


