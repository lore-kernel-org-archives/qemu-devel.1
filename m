Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF302C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CDB2081E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hv0nYjjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CDB2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2UE-0004Kw-0W
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Ih-0004Q8-Iy
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2If-0003Ko-BW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:31 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2If-0003Ji-2Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:29 -0500
Received: by mail-pf1-x442.google.com with SMTP id x185so908595pfc.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cfMFnwoQZRNo8oRtznSSFsbjPoKtkh7p2L2908Wm83U=;
 b=hv0nYjjHLqrrysVHT8OZ/nWAN4PS6DGDBdM+s3wdw51T+AgpahLf+0TeRpt8gq5xah
 bMPHWUs3egelTLOonB/d3Apv+dFOfAdJh4+UwsTc6aVc76KCcmTNfyJ75Bgjk002yc02
 kj0dWOwEblVU49B9x02CWF7/Dag+2RTwP6qVk3hTv8zQ2tY2IYJc6OtCwWtEzdpmtGgp
 fGE4QpN36IE0SnLTrh9elVg/AAS8TW0rsyTcLuZHI2acFBBqLHoplWablURVXUHQnOck
 umzdLI0SK4JGqvfXxJ+zhZRlE80KPoculuy8o6HhLtEW+fO34hd2I1v/Axn3XzKabDGw
 vYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cfMFnwoQZRNo8oRtznSSFsbjPoKtkh7p2L2908Wm83U=;
 b=UYtAOsKvlZVO+UfUpk008hl/DpACILL5SB/wcsdeqbsvAat8rgol6BYqtv72l9Uz0t
 HnRAlAuaTWdIJbvQ5yDrE9z6KGxbN2z9vRZiloX7q38jLfjqr6IO/3PqJuX6YIum1n2w
 yvYiEtOOS3ee5KoY25cYFYrdqn8CwX2hbq52+s13FYMooG8fhCoz1ZIPTy1RqPu+cLtk
 H9TTI1WNWzibm+lv/1s6Cau2HvgDmHgDDbNApRw3U01MqFjEYH8OHzEu7DzFaHcqozZI
 oP4a1KOQ74EC/mraZiPM0WLPRp3qCbyAkJeGrSsJUmUfA77t4Gp4nfSgWAUk/lmTMLlf
 bKNg==
X-Gm-Message-State: APjAAAVNg2YTWXJcyM0O6qjaaXYo6fgpYZaytaIlsUoQjqlsltaMjh39
 3LAYaTBU9ApXuiyuhlNBurHhOctRg2HYoQ==
X-Google-Smtp-Source: APXvYqyqDjm5p+pfCxzIW3e/lvnLSM9BI7l8MTUE/0HbZM4DtQJ0fK7mzpbd6RxHjFhfq1/ZILTYwA==
X-Received: by 2002:a63:5211:: with SMTP id g17mr3223062pgb.426.1578455187152; 
 Tue, 07 Jan 2020 19:46:27 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
Date: Wed,  8 Jan 2020 14:45:01 +1100
Message-Id: <20200108034523.17349-20-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are no uses of the *_cmmu names other than the bare wrapping
within the *_code inlines.  Therefore rename the functions so we
can drop the inlines.

Use abi_ptr instead of target_ulong in preparation for user-only;
the two types are identical for softmmu.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h          | 29 ++++------
 include/exec/cpu_ldst_template.h | 21 -------
 tcg/tcg.h                        | 29 ----------
 accel/tcg/cputlb.c               | 94 ++++++++------------------------
 docs/devel/loads-stores.rst      |  4 +-
 5 files changed, 36 insertions(+), 141 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 399ff6c3da..ef59ed61e4 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -450,25 +450,20 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
 #undef CPU_MMU_INDEX
 #undef MEMSUFFIX
 
-#define CPU_MMU_INDEX (cpu_mmu_index(env, true))
-#define MEMSUFFIX _code
-#define SOFTMMU_CODE_ACCESS
+uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
+uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
+uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
+uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
 
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
+static inline int cpu_ldsb_code(CPUArchState *env, abi_ptr addr)
+{
+    return (int8_t)cpu_ldub_code(env, addr);
+}
 
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#undef SOFTMMU_CODE_ACCESS
+static inline int cpu_ldsw_code(CPUArchState *env, abi_ptr addr)
+{
+    return (int16_t)cpu_lduw_code(env, addr);
+}
 
 #endif /* defined(CONFIG_USER_ONLY) */
 
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index ea39e29c19..e400979f23 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -58,25 +58,6 @@
 
 /* generic load/store macros */
 
-#ifdef SOFTMMU_CODE_ACCESS
-
-static inline RES_TYPE
-glue(glue(cpu_ld, USUFFIX), _code)(CPUArchState *env, target_ulong ptr)
-{
-    TCGMemOpIdx oi = make_memop_idx(MO_TE | SHIFT, CPU_MMU_INDEX);
-    return glue(glue(helper_ret_ld, USUFFIX), _cmmu)(env, ptr, oi, 0);
-}
-
-#if DATA_SIZE <= 2
-static inline int
-glue(glue(cpu_lds, SUFFIX), _code)(CPUArchState *env, target_ulong ptr)
-{
-    return (DATA_STYPE)glue(glue(cpu_ld, USUFFIX), _code)(env, ptr);
-}
-#endif
-
-#else
-
 static inline RES_TYPE
 glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
@@ -127,8 +108,6 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
     glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX, 0);
 }
 
-#endif /* !SOFTMMU_CODE_ACCESS */
-
 #undef RES_TYPE
 #undef DATA_TYPE
 #undef DATA_STYPE
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 92ca10dffc..3b4f79301c 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1290,27 +1290,6 @@ void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
 void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr);
 
-uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-int8_t helper_ret_ldsb_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr);
-int16_t helper_le_ldsw_cmmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr);
-uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr);
-int16_t helper_be_ldsw_cmmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr);
-uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-
 /* Temporary aliases until backends are converted.  */
 #ifdef TARGET_WORDS_BIGENDIAN
 # define helper_ret_ldsw_mmu  helper_be_ldsw_mmu
@@ -1322,10 +1301,6 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_be_stw_mmu
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
-# define helper_ret_lduw_cmmu  helper_be_lduw_cmmu
-# define helper_ret_ldsw_cmmu  helper_be_ldsw_cmmu
-# define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
-# define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
 # define helper_ret_ldsw_mmu  helper_le_ldsw_mmu
 # define helper_ret_lduw_mmu  helper_le_lduw_mmu
@@ -1336,10 +1311,6 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_le_stw_mmu
 # define helper_ret_stl_mmu   helper_le_stl_mmu
 # define helper_ret_stq_mmu   helper_le_stq_mmu
-# define helper_ret_lduw_cmmu  helper_le_lduw_cmmu
-# define helper_ret_ldsw_cmmu  helper_le_ldsw_cmmu
-# define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
-# define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
 #endif
 
 uint32_t helper_atomic_cmpxchgb_mmu(CPUArchState *env, target_ulong addr,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ddd19718bf..f0e4b0aee4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2028,98 +2028,50 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
 
 /* Code access functions.  */
 
-static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
+static uint64_t full_ldub_code(CPUArchState *env, target_ulong addr,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
+    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_code);
 }
 
-uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
-    return full_ldub_cmmu(env, addr, oi, retaddr);
+    TCGMemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(env, true));
+    return full_ldub_code(env, addr, oi, 0);
 }
 
-int8_t helper_ret_ldsb_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+static uint64_t full_lduw_code(CPUArchState *env, target_ulong addr,
+                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return (int8_t) full_ldub_cmmu(env, addr, oi, retaddr);
+    return load_helper(env, addr, oi, retaddr, MO_TEUW, true, full_lduw_code);
 }
 
-static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                                  TCGMemOpIdx oi, uintptr_t retaddr)
+uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
-                       full_le_lduw_cmmu);
+    TCGMemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(env, true));
+    return full_lduw_code(env, addr, oi, 0);
 }
 
-uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+static uint64_t full_ldl_code(CPUArchState *env, target_ulong addr,
+                              TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return full_le_lduw_cmmu(env, addr, oi, retaddr);
+    return load_helper(env, addr, oi, retaddr, MO_TEUL, true, full_ldl_code);
 }
 
-int16_t helper_le_ldsw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
 {
-    return (int16_t) full_le_lduw_cmmu(env, addr, oi, retaddr);
+    TCGMemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(env, true));
+    return full_ldl_code(env, addr, oi, 0);
 }
 
-static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                                  TCGMemOpIdx oi, uintptr_t retaddr)
+static uint64_t full_ldq_code(CPUArchState *env, target_ulong addr,
+                              TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
-                       full_be_lduw_cmmu);
+    return load_helper(env, addr, oi, retaddr, MO_TEQ, true, full_ldq_code);
 }
 
-uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
 {
-    return full_be_lduw_cmmu(env, addr, oi, retaddr);
-}
-
-int16_t helper_be_ldsw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return (int16_t) full_be_lduw_cmmu(env, addr, oi, retaddr);
-}
-
-static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
-                                  TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
-                       full_le_ldul_cmmu);
-}
-
-uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return full_le_ldul_cmmu(env, addr, oi, retaddr);
-}
-
-static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
-                                  TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
-                       full_be_ldul_cmmu);
-}
-
-uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return full_be_ldul_cmmu(env, addr, oi, retaddr);
-}
-
-uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return load_helper(env, addr, oi, retaddr, MO_LEQ, true,
-                       helper_le_ldq_cmmu);
-}
-
-uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return load_helper(env, addr, oi, retaddr, MO_BEQ, true,
-                       helper_be_ldq_cmmu);
+    TCGMemOpIdx oi = make_memop_idx(MO_TEQ, cpu_mmu_index(env, true));
+    return full_ldq_code(env, addr, oi, 0);
 }
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index c74cd090e6..8a5bc912a5 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -171,8 +171,6 @@ more in line with the other memory access functions.
 
 load: ``helper_{endian}_ld{sign}{size}_mmu(env, addr, opindex, retaddr)``
 
-load (code): ``helper_{endian}_ld{sign}{size}_cmmu(env, addr, opindex, retaddr)``
-
 store: ``helper_{endian}_st{size}_mmu(env, addr, val, opindex, retaddr)``
 
 ``sign``
@@ -192,7 +190,7 @@ store: ``helper_{endian}_st{size}_mmu(env, addr, val, opindex, retaddr)``
  - ``ret`` : target endianness
 
 Regexes for git grep
- - ``\<helper_\(le\|be\|ret\)_ld[us]\?[bwlq]_c\?mmu\>``
+ - ``\<helper_\(le\|be\|ret\)_ld[us]\?[bwlq]_mmu\>``
  - ``\<helper_\(le\|be\|ret\)_st[bwlq]_mmu\>``
 
 ``address_space_*``
-- 
2.20.1


