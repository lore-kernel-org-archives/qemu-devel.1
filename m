Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F933C73C59
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498AC21743
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b02Q5tDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498AC21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktD5-000793-Jf
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 12:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38181)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7s-0003Em-8r
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7m-0006v4-Jc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:53 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkt7e-0006jG-Qs
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:44 -0400
Received: by mail-pl1-x642.google.com with SMTP id cl9so10341858plb.10
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wKi63WC2ID0LFZEyokn53XQcJ3+e0eDjytzjfhF4FC4=;
 b=b02Q5tDk/hNubaV3heBz8XfZJYQkPE7gra0q5kGO3lHnG8C/qCszOoV+soTRIKxjaK
 IQe1YpAkuxQM68dXsnco4w13PmK+sfQObYDXYjBwNc7jJ9FBDJS9LUQcxhafoUj9tQEH
 dhUYs2FKqjWoQptIxYsSPArWQOYYlMDTD1AymatlQGy6yr4uSu4ZTKgkIr2R22JMO7G8
 P4UtN7k/k97wd++qOx37+FpvUia1W24ySkPVdfQf8Hv61CEldS8lmlPtUbKBOnC8ALmA
 QlKS3N+ck3uO+K5FVeXx3NtFMgoAS7NE38+d3HYhuz5nXH79HvGN18mHJNAl5aRWhnCC
 z5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wKi63WC2ID0LFZEyokn53XQcJ3+e0eDjytzjfhF4FC4=;
 b=GHAZNLu5ThwqR33+chzpvGsCOhAOegmYl53EFftpWesLEdDP/1UIEf4dDM1VT+KbfI
 hf1jqka2gdWKhpE/tvHA6v0NxtX3NCJ5B6G7PR4fP1KeKGb3WhasfahOWbmR5VpbYN2I
 vrt+j781cSzwXxc4yqJxT3eCBJgEZW+8LSPTzLEdMZSI9wINAU1n6UnCcb0zF5o6VYJJ
 phd/DC7AutV73a/8YyLUA0lmMdKtbJp+8b6UY8r1uoLbA85AT/EMhtHnK0fU5rWVoEZt
 yzKq8evv0hCWqfqTHfDavDbMGVwM7oiMujTGy3z+qlOx2nH8wQAaMeUiF/Jojgi9mXZ0
 FMfw==
X-Gm-Message-State: APjAAAWo7rFmm4mRV/x9ZPpryJAeBMOO87TAAeu+WGikjwCjExOyYHWd
 dNoa+HNTfGaI/6oj4pXDhmUI+7rIjvc=
X-Google-Smtp-Source: APXvYqyXFTeEOggHPiqXg1t+PLDSyRTP8D6y4r6o2oTEoMyCOM5war1Ab6mO5tu8An3DMWHi5jCQ4Q==
X-Received: by 2002:a17:902:2ec5:: with SMTP id
 r63mr32915763plb.21.1562690250940; 
 Tue, 09 Jul 2019 09:37:30 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id v8sm19225231pgs.82.2019.07.09.09.37.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 09:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 18:36:56 +0200
Message-Id: <20190709163656.3100-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709163656.3100-1-richard.henderson@linaro.org>
References: <20190709163656.3100-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 5/5] tcg: Release mmap_lock on translation
 fault
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turn helper_retaddr into a multi-state flag that may now also
indicate when we're performing a read on behalf of the translator.
In this case, release the mmap_lock before the longjmp back to
the main cpu loop, and thereby avoid a failing assert therein.

Fixes: https://bugs.launchpad.net/qemu/+bug/1832353
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_useronly_template.h | 20 +++++--
 accel/tcg/user-exec.c                     | 66 ++++++++++++++++-------
 2 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index d663826ac2..2378f2958c 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -64,12 +64,18 @@
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#if !defined(CODE_ACCESS)
+#ifdef CODE_ACCESS
+    RES_TYPE ret;
+    set_helper_retaddr(1);
+    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+    clear_helper_retaddr();
+    return ret;
+#else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, false));
-#endif
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+#endif
 }
 
 #ifndef CODE_ACCESS
@@ -90,12 +96,18 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#if !defined(CODE_ACCESS)
+#ifdef CODE_ACCESS
+    int ret;
+    set_helper_retaddr(1);
+    ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+    clear_helper_retaddr();
+    return ret;
+#else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, true, MO_TE, false));
-#endif
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+#endif
 }
 
 #ifndef CODE_ACCESS
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 4384b59a4d..897d1571c4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -64,27 +64,56 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     CPUState *cpu = current_cpu;
     CPUClass *cc;
     unsigned long address = (unsigned long)info->si_addr;
-    MMUAccessType access_type;
+    MMUAccessType access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
 
-    /* We must handle PC addresses from two different sources:
-     * a call return address and a signal frame address.
-     *
-     * Within cpu_restore_state_from_tb we assume the former and adjust
-     * the address by -GETPC_ADJ so that the address is within the call
-     * insn so that addr does not accidentally match the beginning of the
-     * next guest insn.
-     *
-     * However, when the PC comes from the signal frame, it points to
-     * the actual faulting host insn and not a call insn.  Subtracting
-     * GETPC_ADJ in that case may accidentally match the previous guest insn.
-     *
-     * So for the later case, adjust forward to compensate for what
-     * will be done later by cpu_restore_state_from_tb.
-     */
-    if (helper_retaddr) {
+    switch (helper_retaddr) {
+    default:
+        /*
+         * Fault during host memory operation within a helper function.
+         * The helper's host return address, saved here, gives us a
+         * pointer into the generated code that will unwind to the
+         * correct guest pc.
+         */
         pc = helper_retaddr;
-    } else {
+        break;
+
+    case 0:
+        /*
+         * Fault during host memory operation within generated code.
+         * (Or, a unrelated bug within qemu, but we can't tell from here).
+         *
+         * We take the host pc from the signal frame.  However, we cannot
+         * use that value directly.  Within cpu_restore_state_from_tb, we
+         * assume PC comes from GETPC(), as used by the helper functions,
+         * so we adjust the address by -GETPC_ADJ to form an address that
+         * is within the call insn, so that the address does not accidentially
+         * match the beginning of the next guest insn.  However, when the
+         * pc comes from the signal frame it points to the actual faulting
+         * host memory insn and not the return from a call insn.
+         *
+         * Therefore, adjust to compensate for what will be done later
+         * by cpu_restore_state_from_tb.
+         */
         pc += GETPC_ADJ;
+        break;
+
+    case 1:
+        /*
+         * Fault during host read for translation, or loosely, "execution".
+         *
+         * The guest pc is already pointing to the start of the TB for which
+         * code is being generated.  If the guest translator manages the
+         * page crossings correctly, this is exactly the correct address
+         * (and if the translator doesn't handle page boundaries correctly
+         * there's little we can do about that here).  Therefore, do not
+         * trigger the unwinder.
+         *
+         * Like tb_gen_code, release the memory lock before cpu_loop_exit.
+         */
+        pc = 0;
+        access_type = MMU_INST_FETCH;
+        mmap_unlock();
+        break;
     }
 
     /* For synchronous signals we expect to be coming from the vCPU
@@ -155,7 +184,6 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     clear_helper_retaddr();
 
     cc = CPU_GET_CLASS(cpu);
-    access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
     cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
     g_assert_not_reached();
 }
-- 
2.17.1


