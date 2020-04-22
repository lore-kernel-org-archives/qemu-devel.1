Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC73C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A8020747
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6NUJdc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A8020747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR7IF-0005MA-Ls
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74u-0001AO-MF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74q-0006FF-Bc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:40 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74p-00068K-S0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:35 -0400
Received: by mail-pl1-x643.google.com with SMTP id g2so443090plo.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AuL6vKFq5L1zc6YYFULSpnJ4zpW3ZJD/n4vMjhxr+d8=;
 b=t6NUJdc/ggm0HNO1q2NuaF+pD6OV7JMnVZ4edXz9/kODDBDl57af6tnaEr5svX3RxP
 K5sEXiK2S84wx9O2Y4BNJK7Ix/AImjZZ+YdqdzXRHZnX/+Xz1comzZQIsEH4aETENn3b
 T7fLS2XhXo0RApffAH+XpsRzSfdTDXaYm2T9WfwLDNczsCxrVwVpr58MH81/qTQ1ZwSx
 g0Af76Tv/9Fz/4LqS9PpG3lIj7GZTZN/QFNs/kklq1INX/A0It/wrXCUTVsz/YD2j8dO
 k0SfHSYUF+WedjtqAl8VXuMm1U7Tb5FMJRKtqEsmfFjKVuOzJjnGIm6KNj7yVnALEpW7
 pbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AuL6vKFq5L1zc6YYFULSpnJ4zpW3ZJD/n4vMjhxr+d8=;
 b=mZs4Die50L3xSFxRgtsOwUK2Vz1wgrV+TaE2G+crb7KvnAgGZDpeEknSNG19Zy2HLK
 5zsQuFNeTfDlSSIL+ZGWN8FUl18zEfyYaO+xvRiFhhnI/3m9iSSxQHumDqlg77g98KdU
 5b2BUuWMg+kpKbSui/eIWosovcaeE1bZULl+Z5fnjR61fv9rCKFBuwnmJxaaroYB9tkS
 LyAmTmhY3++LhPzFktDI4jpgDHmN1sjXyD8Zr1fXgqWtWZWuEGCdGZ+aIhq2wdLgTNuZ
 b1V1HiHEZja20QtKCDiAZf9T2chsdrIWehVvff5QBK3iYyn2W4W1mSyTEqn9Q9t3ajMZ
 oNbQ==
X-Gm-Message-State: AGi0PubKYpIE/iv4uXkpWV8O9apepOPhFLxv8WY3gdG2edsmVKgdAMhD
 ZKuJE5u0VlHLoHDHaPDk2mZLuyj+qQ0=
X-Google-Smtp-Source: APiQypKxuPU8AMuSLzd/ULI3n8stAt1ri36dS4FNDyUYhFHBt9rQB5jQc1b4oEeYucp19WjM0JCKuw==
X-Received: by 2002:a17:90a:8d0f:: with SMTP id
 c15mr9915901pjo.100.1587530013993; 
 Tue, 21 Apr 2020 21:33:33 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/18] target/arm: Reuse sve_probe_page for gather loads
Date: Tue, 21 Apr 2020 21:33:08 -0700
Message-Id: <20200422043309.18430-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 208 +++++++++++++++++++++-------------------
 1 file changed, 109 insertions(+), 99 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f4cdeecdcb..fffde4b6ec 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5120,130 +5120,140 @@ static target_ulong off_zd_d(void *reg, intptr_t reg_ofs)
     return *(uint64_t *)(reg + reg_ofs);
 }
 
-static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
-                       target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
+static inline QEMU_ALWAYS_INLINE
+void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
+               target_ulong base, uint32_t desc, uintptr_t retaddr,
+               int esize, int msize, zreg_off_fn *off_fn,
+               sve_ldst1_host_fn *host_fn,
+               sve_ldst1_tlb_fn *tlb_fn)
 {
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    ARMVectorReg scratch = { };
+    const int mmu_idx = cpu_mmu_index(env, false);
+    const intptr_t reg_max = simd_oprsz(desc);
+    ARMVectorReg scratch;
+    intptr_t reg_off;
+    SVEHostPage info, info2;
 
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+    memset(&scratch, 0, reg_max);
+    reg_off = 0;
+    do {
+        uint64_t pg = vg[reg_off >> 6];
         do {
             if (likely(pg & 1)) {
-                target_ulong off = off_fn(vm, i);
-                tlb_fn(env, &scratch, i, base + (off << scale), ra);
+                target_ulong addr = base + (off_fn(vm, reg_off) << scale);
+                target_ulong in_page = -(addr | TARGET_PAGE_MASK);
+
+                sve_probe_page(&info, false, env, addr, 0, MMU_DATA_LOAD,
+                               mmu_idx, retaddr);
+
+                if (likely(in_page >= msize)) {
+                    if (unlikely(info.flags & TLB_WATCHPOINT)) {
+                        cpu_check_watchpoint(env_cpu(env), addr, msize,
+                                             info.attrs, BP_MEM_READ, retaddr);
+                    }
+                    /* TODO: MTE check */
+                    host_fn(&scratch, reg_off, info.host);
+                } else {
+                    /* Element crosses the page boundary. */
+                    sve_probe_page(&info2, false, env, addr + in_page, 0,
+                                   MMU_DATA_LOAD, mmu_idx, retaddr);
+                    if (unlikely((info.flags | info2.flags) & TLB_WATCHPOINT)) {
+                        cpu_check_watchpoint(env_cpu(env), addr,
+                                             msize, info.attrs,
+                                             BP_MEM_READ, retaddr);
+                    }
+                    /* TODO: MTE check */
+                    tlb_fn(env, &scratch, reg_off, addr, retaddr);
+                }
             }
-            i += 4, pg >>= 4;
-        } while (i & 15);
-    }
+            reg_off += esize;
+            pg >>= esize;
+        } while (reg_off & 63);
+    } while (reg_off < reg_max);
 
     /* Wait until all exceptions have been raised to write back.  */
-    memcpy(vd, &scratch, oprsz);
+    memcpy(vd, &scratch, reg_max);
 }
 
-static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
-                       target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
-{
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;
-    ARMVectorReg scratch = { };
-
-    for (i = 0; i < oprsz; i++) {
-        uint8_t pg = *(uint8_t *)(vg + H1(i));
-        if (likely(pg & 1)) {
-            target_ulong off = off_fn(vm, i * 8);
-            tlb_fn(env, &scratch, i * 8, base + (off << scale), ra);
-        }
-    }
-
-    /* Wait until all exceptions have been raised to write back.  */
-    memcpy(vd, &scratch, oprsz * 8);
+#define DO_LD1_ZPZ_S(MEM, OFS, MSZ) \
+void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                            \
+    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,             \
+              off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }
 
-#define DO_LD1_ZPZ_S(MEM, OFS) \
-void QEMU_FLATTEN HELPER(sve_ld##MEM##_##OFS) \
-    (CPUARMState *env, void *vd, void *vg, void *vm,         \
-     target_ulong base, uint32_t desc)                       \
-{                                                            \
-    sve_ld1_zs(env, vd, vg, vm, base, desc, GETPC(),         \
-              off_##OFS##_s, sve_ld1##MEM##_tlb);            \
+#define DO_LD1_ZPZ_D(MEM, OFS, MSZ) \
+void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                            \
+    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,             \
+              off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }
 
-#define DO_LD1_ZPZ_D(MEM, OFS) \
-void QEMU_FLATTEN HELPER(sve_ld##MEM##_##OFS) \
-    (CPUARMState *env, void *vd, void *vg, void *vm,         \
-     target_ulong base, uint32_t desc)                       \
-{                                                            \
-    sve_ld1_zd(env, vd, vg, vm, base, desc, GETPC(),         \
-               off_##OFS##_d, sve_ld1##MEM##_tlb);           \
-}
+DO_LD1_ZPZ_S(bsu, zsu, MO_8)
+DO_LD1_ZPZ_S(bsu, zss, MO_8)
+DO_LD1_ZPZ_D(bdu, zsu, MO_8)
+DO_LD1_ZPZ_D(bdu, zss, MO_8)
+DO_LD1_ZPZ_D(bdu, zd, MO_8)
 
-DO_LD1_ZPZ_S(bsu, zsu)
-DO_LD1_ZPZ_S(bsu, zss)
-DO_LD1_ZPZ_D(bdu, zsu)
-DO_LD1_ZPZ_D(bdu, zss)
-DO_LD1_ZPZ_D(bdu, zd)
+DO_LD1_ZPZ_S(bss, zsu, MO_8)
+DO_LD1_ZPZ_S(bss, zss, MO_8)
+DO_LD1_ZPZ_D(bds, zsu, MO_8)
+DO_LD1_ZPZ_D(bds, zss, MO_8)
+DO_LD1_ZPZ_D(bds, zd, MO_8)
 
-DO_LD1_ZPZ_S(bss, zsu)
-DO_LD1_ZPZ_S(bss, zss)
-DO_LD1_ZPZ_D(bds, zsu)
-DO_LD1_ZPZ_D(bds, zss)
-DO_LD1_ZPZ_D(bds, zd)
+DO_LD1_ZPZ_S(hsu_le, zsu, MO_16)
+DO_LD1_ZPZ_S(hsu_le, zss, MO_16)
+DO_LD1_ZPZ_D(hdu_le, zsu, MO_16)
+DO_LD1_ZPZ_D(hdu_le, zss, MO_16)
+DO_LD1_ZPZ_D(hdu_le, zd, MO_16)
 
-DO_LD1_ZPZ_S(hsu_le, zsu)
-DO_LD1_ZPZ_S(hsu_le, zss)
-DO_LD1_ZPZ_D(hdu_le, zsu)
-DO_LD1_ZPZ_D(hdu_le, zss)
-DO_LD1_ZPZ_D(hdu_le, zd)
+DO_LD1_ZPZ_S(hsu_be, zsu, MO_16)
+DO_LD1_ZPZ_S(hsu_be, zss, MO_16)
+DO_LD1_ZPZ_D(hdu_be, zsu, MO_16)
+DO_LD1_ZPZ_D(hdu_be, zss, MO_16)
+DO_LD1_ZPZ_D(hdu_be, zd, MO_16)
 
-DO_LD1_ZPZ_S(hsu_be, zsu)
-DO_LD1_ZPZ_S(hsu_be, zss)
-DO_LD1_ZPZ_D(hdu_be, zsu)
-DO_LD1_ZPZ_D(hdu_be, zss)
-DO_LD1_ZPZ_D(hdu_be, zd)
+DO_LD1_ZPZ_S(hss_le, zsu, MO_16)
+DO_LD1_ZPZ_S(hss_le, zss, MO_16)
+DO_LD1_ZPZ_D(hds_le, zsu, MO_16)
+DO_LD1_ZPZ_D(hds_le, zss, MO_16)
+DO_LD1_ZPZ_D(hds_le, zd, MO_16)
 
-DO_LD1_ZPZ_S(hss_le, zsu)
-DO_LD1_ZPZ_S(hss_le, zss)
-DO_LD1_ZPZ_D(hds_le, zsu)
-DO_LD1_ZPZ_D(hds_le, zss)
-DO_LD1_ZPZ_D(hds_le, zd)
+DO_LD1_ZPZ_S(hss_be, zsu, MO_16)
+DO_LD1_ZPZ_S(hss_be, zss, MO_16)
+DO_LD1_ZPZ_D(hds_be, zsu, MO_16)
+DO_LD1_ZPZ_D(hds_be, zss, MO_16)
+DO_LD1_ZPZ_D(hds_be, zd, MO_16)
 
-DO_LD1_ZPZ_S(hss_be, zsu)
-DO_LD1_ZPZ_S(hss_be, zss)
-DO_LD1_ZPZ_D(hds_be, zsu)
-DO_LD1_ZPZ_D(hds_be, zss)
-DO_LD1_ZPZ_D(hds_be, zd)
+DO_LD1_ZPZ_S(ss_le, zsu, MO_32)
+DO_LD1_ZPZ_S(ss_le, zss, MO_32)
+DO_LD1_ZPZ_D(sdu_le, zsu, MO_32)
+DO_LD1_ZPZ_D(sdu_le, zss, MO_32)
+DO_LD1_ZPZ_D(sdu_le, zd, MO_32)
 
-DO_LD1_ZPZ_S(ss_le, zsu)
-DO_LD1_ZPZ_S(ss_le, zss)
-DO_LD1_ZPZ_D(sdu_le, zsu)
-DO_LD1_ZPZ_D(sdu_le, zss)
-DO_LD1_ZPZ_D(sdu_le, zd)
+DO_LD1_ZPZ_S(ss_be, zsu, MO_32)
+DO_LD1_ZPZ_S(ss_be, zss, MO_32)
+DO_LD1_ZPZ_D(sdu_be, zsu, MO_32)
+DO_LD1_ZPZ_D(sdu_be, zss, MO_32)
+DO_LD1_ZPZ_D(sdu_be, zd, MO_32)
 
-DO_LD1_ZPZ_S(ss_be, zsu)
-DO_LD1_ZPZ_S(ss_be, zss)
-DO_LD1_ZPZ_D(sdu_be, zsu)
-DO_LD1_ZPZ_D(sdu_be, zss)
-DO_LD1_ZPZ_D(sdu_be, zd)
+DO_LD1_ZPZ_D(sds_le, zsu, MO_32)
+DO_LD1_ZPZ_D(sds_le, zss, MO_32)
+DO_LD1_ZPZ_D(sds_le, zd, MO_32)
 
-DO_LD1_ZPZ_D(sds_le, zsu)
-DO_LD1_ZPZ_D(sds_le, zss)
-DO_LD1_ZPZ_D(sds_le, zd)
+DO_LD1_ZPZ_D(sds_be, zsu, MO_32)
+DO_LD1_ZPZ_D(sds_be, zss, MO_32)
+DO_LD1_ZPZ_D(sds_be, zd, MO_32)
 
-DO_LD1_ZPZ_D(sds_be, zsu)
-DO_LD1_ZPZ_D(sds_be, zss)
-DO_LD1_ZPZ_D(sds_be, zd)
+DO_LD1_ZPZ_D(dd_le, zsu, MO_64)
+DO_LD1_ZPZ_D(dd_le, zss, MO_64)
+DO_LD1_ZPZ_D(dd_le, zd, MO_64)
 
-DO_LD1_ZPZ_D(dd_le, zsu)
-DO_LD1_ZPZ_D(dd_le, zss)
-DO_LD1_ZPZ_D(dd_le, zd)
-
-DO_LD1_ZPZ_D(dd_be, zsu)
-DO_LD1_ZPZ_D(dd_be, zss)
-DO_LD1_ZPZ_D(dd_be, zd)
+DO_LD1_ZPZ_D(dd_be, zsu, MO_64)
+DO_LD1_ZPZ_D(dd_be, zss, MO_64)
+DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_LD1_ZPZ_S
 #undef DO_LD1_ZPZ_D
-- 
2.20.1


