Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A5AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1912173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMa5i/Yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1912173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pM9-0000BC-FD
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKz-0006hp-3R
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKx-0007aG-5Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:41 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:33145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pKw-0007Zj-Uk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:39 -0500
Received: by mail-pl1-x629.google.com with SMTP id ay11so91993plb.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5BCED//Us3kOSOmLoxSaLt6O1uc8TXSY7MgfQybd348=;
 b=wMa5i/Yv9UWUc+cBeGmGNKZh1pqOw0RdCwHbnktUaDVFZNxdZ/KbkhoGAP1W1EHrMX
 eihl1TWAA95NZ2x/JcE8iOW23suf+topfgIlcBv1vMRPpjp9m7WwOfHJewhfv3A9l3tz
 IOX6ij5muBNgFquvvr550fkq8Ff2YugnYmB7hR7+nLGpzVpZco++7QbSPs5herCpjbSA
 pA19AQ0lzvPIrlG5KR3MWrsmempDdRODq9vOKGx2SbFTglog/wOlZOG53W3mZqAHveSn
 +flbPbqfJ2957wDxVZxi/YR55NJp48cscNP26/BKE6VMYxmbpzVf/pR8pr5ZC5t3WuGn
 hHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5BCED//Us3kOSOmLoxSaLt6O1uc8TXSY7MgfQybd348=;
 b=Mhd7R5vJ7MYE2Q2uEXm9mvjs9AnP+EQexcLiDRrfmkjHC7q3QfbSQxyMkuS685xYj0
 UsghyMWwnrAlpnVdV5cuRJSUmlmtHnM87Bl9FIxr94cr2def38KVKYeP6JtA0L5DDe3+
 FYVKR6RUDUInS/SzPK6MMKKbf6+ym7oLqrIYUiFVkhV7WDlyEQPM7lkG4ZHyVJP4HFyp
 iW4Ko3erU20wOdNoL5Feh29swdOZx3MIhfT+lG15mEwCN5jKOMJj6k/7os7MLkVKx7j7
 Z962rEcFR3yV6uAczV+tECVaIjFxNg+g2w1jo+7h/bFjlIRY1JSbN/CvIuAIz374mMm6
 mcFA==
X-Gm-Message-State: ANhLgQ1MHvGecjUtgO9VSnjOpi+fO9q5dNNCbbxEoUx58q62JDujUu3t
 F0p3SgX8rjrHjoP7DRDstRUA7VfSAaM=
X-Google-Smtp-Source: ADFU+vtUR9vJXt4nc18l9blVB51Tr6N+6KtZf8ezxjpRUUSd/ghZDLdxoByo7UiaVi7r6NTCGEpAeg==
X-Received: by 2002:a17:902:aa96:: with SMTP id
 d22mr361520plr.204.1583171917401; 
 Mon, 02 Mar 2020 09:58:37 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] target/arm: Move helper_dc_zva to helper-a64.c
Date: Mon,  2 Mar 2020 09:58:25 -0800
Message-Id: <20200302175829.2183-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
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

This is an aarch64-only function.  Move it out of the shared file.
This patch is code movement only.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h |  1 +
 target/arm/helper.h     |  1 -
 target/arm/helper-a64.c | 91 ++++++++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c  | 93 -----------------------------------------
 4 files changed, 92 insertions(+), 94 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a915c1247f..b1a5935f61 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -90,6 +90,7 @@ DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
 DEF_HELPER_2(exception_return, void, env, i64)
+DEF_HELPER_2(dc_zva, void, env, i64)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index fcbf504121..72eb9e6a1a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -559,7 +559,6 @@ DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
-DEF_HELPER_2(dc_zva, void, env, i64)
 
 DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 123ce50e7a..bc0649a44a 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
@@ -1109,4 +1110,94 @@ uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
     return float16_sqrt(a, s);
 }
 
+void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
+{
+    /*
+     * Implement DC ZVA, which zeroes a fixed-length block of memory.
+     * Note that we do not implement the (architecturally mandated)
+     * alignment fault for attempts to use this on Device memory
+     * (which matches the usual QEMU behaviour of not implementing either
+     * alignment faults or any memory attribute handling).
+     */
 
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t blocklen = 4 << cpu->dcz_blocksize;
+    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
+
+#ifndef CONFIG_USER_ONLY
+    {
+        /*
+         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
+         * the block size so we might have to do more than one TLB lookup.
+         * We know that in fact for any v8 CPU the page size is at least 4K
+         * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
+         * 1K as an artefact of legacy v5 subpage support being present in the
+         * same QEMU executable. So in practice the hostaddr[] array has
+         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
+         */
+        int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
+        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
+        int try, i;
+        unsigned mmu_idx = cpu_mmu_index(env, false);
+        TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
+
+        assert(maxidx <= ARRAY_SIZE(hostaddr));
+
+        for (try = 0; try < 2; try++) {
+
+            for (i = 0; i < maxidx; i++) {
+                hostaddr[i] = tlb_vaddr_to_host(env,
+                                                vaddr + TARGET_PAGE_SIZE * i,
+                                                1, mmu_idx);
+                if (!hostaddr[i]) {
+                    break;
+                }
+            }
+            if (i == maxidx) {
+                /*
+                 * If it's all in the TLB it's fair game for just writing to;
+                 * we know we don't need to update dirty status, etc.
+                 */
+                for (i = 0; i < maxidx - 1; i++) {
+                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
+                }
+                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE));
+                return;
+            }
+            /*
+             * OK, try a store and see if we can populate the tlb. This
+             * might cause an exception if the memory isn't writable,
+             * in which case we will longjmp out of here. We must for
+             * this purpose use the actual register value passed to us
+             * so that we get the fault address right.
+             */
+            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
+            /* Now we can populate the other TLB entries, if any */
+            for (i = 0; i < maxidx; i++) {
+                uint64_t va = vaddr + TARGET_PAGE_SIZE * i;
+                if (va != (vaddr_in & TARGET_PAGE_MASK)) {
+                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
+                }
+            }
+        }
+
+        /*
+         * Slow path (probably attempt to do this to an I/O device or
+         * similar, or clearing of a block of code we have translations
+         * cached for). Just do a series of byte writes as the architecture
+         * demands. It's not worth trying to use a cpu_physical_memory_map(),
+         * memset(), unmap() sequence here because:
+         *  + we'd need to account for the blocksize being larger than a page
+         *  + the direct-RAM access case is almost always going to be dealt
+         *    with in the fastpath code above, so there's no speed benefit
+         *  + we would have to deal with the map returning NULL because the
+         *    bounce buffer was in use
+         */
+        for (i = 0; i < blocklen; i++) {
+            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
+        }
+    }
+#else
+    memset(g2h(vaddr), 0, blocklen);
+#endif
+}
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index af3020b78f..eb0de080f1 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu/units.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
@@ -936,95 +935,3 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
-
-void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
-{
-    /*
-     * Implement DC ZVA, which zeroes a fixed-length block of memory.
-     * Note that we do not implement the (architecturally mandated)
-     * alignment fault for attempts to use this on Device memory
-     * (which matches the usual QEMU behaviour of not implementing either
-     * alignment faults or any memory attribute handling).
-     */
-
-    ARMCPU *cpu = env_archcpu(env);
-    uint64_t blocklen = 4 << cpu->dcz_blocksize;
-    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
-
-#ifndef CONFIG_USER_ONLY
-    {
-        /*
-         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
-         * the block size so we might have to do more than one TLB lookup.
-         * We know that in fact for any v8 CPU the page size is at least 4K
-         * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
-         * 1K as an artefact of legacy v5 subpage support being present in the
-         * same QEMU executable. So in practice the hostaddr[] array has
-         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
-         */
-        int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
-        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
-        int try, i;
-        unsigned mmu_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
-
-        assert(maxidx <= ARRAY_SIZE(hostaddr));
-
-        for (try = 0; try < 2; try++) {
-
-            for (i = 0; i < maxidx; i++) {
-                hostaddr[i] = tlb_vaddr_to_host(env,
-                                                vaddr + TARGET_PAGE_SIZE * i,
-                                                1, mmu_idx);
-                if (!hostaddr[i]) {
-                    break;
-                }
-            }
-            if (i == maxidx) {
-                /*
-                 * If it's all in the TLB it's fair game for just writing to;
-                 * we know we don't need to update dirty status, etc.
-                 */
-                for (i = 0; i < maxidx - 1; i++) {
-                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
-                }
-                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE));
-                return;
-            }
-            /*
-             * OK, try a store and see if we can populate the tlb. This
-             * might cause an exception if the memory isn't writable,
-             * in which case we will longjmp out of here. We must for
-             * this purpose use the actual register value passed to us
-             * so that we get the fault address right.
-             */
-            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
-            /* Now we can populate the other TLB entries, if any */
-            for (i = 0; i < maxidx; i++) {
-                uint64_t va = vaddr + TARGET_PAGE_SIZE * i;
-                if (va != (vaddr_in & TARGET_PAGE_MASK)) {
-                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
-                }
-            }
-        }
-
-        /*
-         * Slow path (probably attempt to do this to an I/O device or
-         * similar, or clearing of a block of code we have translations
-         * cached for). Just do a series of byte writes as the architecture
-         * demands. It's not worth trying to use a cpu_physical_memory_map(),
-         * memset(), unmap() sequence here because:
-         *  + we'd need to account for the blocksize being larger than a page
-         *  + the direct-RAM access case is almost always going to be dealt
-         *    with in the fastpath code above, so there's no speed benefit
-         *  + we would have to deal with the map returning NULL because the
-         *    bounce buffer was in use
-         */
-        for (i = 0; i < blocklen; i++) {
-            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
-        }
-    }
-#else
-    memset(g2h(vaddr), 0, blocklen);
-#endif
-}
-- 
2.20.1


