Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9ECC606D7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C348214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2Xf7bB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C348214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkxH-0001EB-Tf
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkktx-0005jg-PK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkktw-0000ze-5H
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:34030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkktv-0000wr-Ue
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:51:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id b13so4279538pfo.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PqJ1ISuGV2u+IdiY8ngyBhS17daHeZo+xRM6Jaz465M=;
 b=R2Xf7bB9WfosM0jErAXQugyS5r4ryza934b8npGVReYjwEUT7ULGB6tOBeETgl17dR
 HwxmfSHSawfR3T9RuvpwOeR4VTTgj3ulT7Opoq0/TRAgPapKRbaneT5N0Xfpv5JVmrJi
 MxwFjP1lWoL2B54rlwWIkTLSYfQj9ReJdFq4ls7OnIB8CoVdB3yWYkTJSDreyazQKl6v
 Adn7x93E9BWhjgc1cx4cEVV2uZtG4jPABkyOqw2wPuRy0lccD6Vdhjx765tpBWAtJ+Dv
 LckpdR4f9BjJFwe2XYn1d9GKAbFH66tKtChV1PpgAj50WSFplqKKG53hSaL2RXIwkb+n
 OJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PqJ1ISuGV2u+IdiY8ngyBhS17daHeZo+xRM6Jaz465M=;
 b=rez0O7vgMIq/FuyFXbegIZbrkBGW2QtRHFZKmabDgf3dTZMAqTps1zSp0hcFGk0Xlb
 Mbo+S+R3uQ0BWdWBVqtfgBMmXgO4wkNeikHCuEYFgpcOuJlwgoOWjtoIr1zBhK78PWyo
 ggyV2L9beuawEHIXvZokW8aBiQH9j5drhuopACah14FnwLAfWlJgBSf730GykNfOwFTW
 /9cCOijXhi6ZpW5eIkbxJ87OyMzl7ua2I35fADdmSMvSOnAcAjHgZRxYr5K2XyszWSGQ
 k6Sz8mIAB3LIVRthpRhQ5UCRryTjEDl7vzfgBcrwU4JTHNNYw45RJF7Kl0SQWQC+6Emv
 hvSw==
X-Gm-Message-State: APjAAAXzqKAhXYz4n5N+8/YSGIDgRyRzOHg8qVTN9Y2sW99mPageikWe
 AdXhdq+QSJlwyDosFr0wT8C8aOFGiUJuCQ==
X-Google-Smtp-Source: APXvYqzbCKG4j+0d8cYHHRah6Gwn4NDsm5AEXpAWvUJ/8Z0mJ4lOK6bf9cMIZKLSTgDr5DtXM5gsmQ==
X-Received: by 2002:a63:6eca:: with SMTP id j193mr28399881pgc.74.1562658656595; 
 Tue, 09 Jul 2019 00:50:56 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id y22sm28237375pfo.39.2019.07.09.00.50.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 00:50:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 09:50:38 +0200
Message-Id: <20190709075042.13941-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709075042.13941-1-richard.henderson@linaro.org>
References: <20190709075042.13941-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PULL 1/3] tcg: Fix mmap lock assert on translation
 failure
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check page flags before letting an invalid pc cause a SIGSEGV.

Prepare for eventially validating PROT_EXEC.  The current wrinkle being
that we have a problem with our implementation of signals.  We should
be using a vdso like the kernel, but we instead put the trampoline on
the stack.  In the meantime, let PROT_READ match PROT_EXEC.

Fixes: https://bugs.launchpad.net/qemu/+bug/1832353
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h                    |  1 +
 include/exec/cpu_ldst_useronly_template.h |  8 +++++--
 accel/tcg/translate-all.c                 | 29 +++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 536ea58f81..58b8915617 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -259,6 +259,7 @@ int walk_memory_regions(void *, walk_memory_regions_fn);
 int page_get_flags(target_ulong address);
 void page_set_flags(target_ulong start, target_ulong end, int flags);
 int page_check_range(target_ulong start, target_ulong len, int flags);
+void validate_exec_access(CPUArchState *env, target_ulong s, target_ulong l);
 #endif
 
 CPUArchState *cpu_copy(CPUArchState *env);
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index bc45e2b8d4..f095415149 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -64,7 +64,9 @@
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#if !defined(CODE_ACCESS)
+#ifdef CODE_ACCESS
+    validate_exec_access(env, ptr, DATA_SIZE);
+#else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, false));
@@ -88,7 +90,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#if !defined(CODE_ACCESS)
+#ifdef CODE_ACCESS
+    validate_exec_access(env, ptr, DATA_SIZE);
+#else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, true, MO_TE, false));
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..1d4a8a260f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2600,10 +2600,39 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
                 }
             }
         }
+        /*
+         * FIXME: We place the signal trampoline on the stack,
+         * even when the guest expects that to be in the vdso.
+         * Until we fix that, allow execute on any readable page.
+         */
+        if ((flags & PAGE_EXEC) && !(p->flags & (PAGE_EXEC | PAGE_READ))) {
+            return -1;
+        }
     }
     return 0;
 }
 
+/*
+ * Called for each code read, longjmp out to issue SIGSEGV if the page(s)
+ * do not have execute access.
+ */
+void validate_exec_access(CPUArchState *env,
+                          target_ulong ptr, target_ulong len)
+{
+    if (page_check_range(ptr, len, PAGE_EXEC) < 0) {
+        CPUState *cs = env_cpu(env);
+        CPUClass *cc = CPU_GET_CLASS(cs);
+
+        /* Like tb_gen_code, release the memory lock before cpu_loop_exit.  */
+        assert_memory_lock();
+        mmap_unlock();
+
+        /* This is user-only.  The target must raise an exception.  */
+        cc->tlb_fill(cs, ptr, 0, MMU_INST_FETCH, MMU_USER_IDX, false, 0);
+        g_assert_not_reached();
+    }
+}
+
 /* called from signal handler: invalidate the code and unprotect the
  * page. Return 0 if the fault was not handled, 1 if it was handled,
  * and 2 if it was handled but the caller must cause the TB to be
-- 
2.17.1


