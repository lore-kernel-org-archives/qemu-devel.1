Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F086FC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D1D2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgQKV4me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D1D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCCk-0007Mg-NN
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC33-0001io-6u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2z-0006N4-TV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC2z-0006Mi-E0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:25 -0400
Received: by mail-pg1-x543.google.com with SMTP id s18so2963330pgl.12
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J5zhPuFSG1IvgY/HZM+zfSrn5bmQLwsRBPEuzZHx2Fo=;
 b=IgQKV4mecw4tGcAUyMJID2PhFJS2DG98kdxJATnLHdfdlaci1MEX+1j3WEOcInJb1Y
 8cI4kjvOeRAFETxjDdhg5ShhaQcqCs+9Xb9rU2uIngGeEfa85T6gPHA1ghehIA7Ga9Yi
 xI8PS6pkSNWSRqmlL/guSdxU+myJEnfIuf7n9pGaVvRP+QA389YFD3z3j4rQ4KZa+WLc
 9tQ70ab5A74TS7a18mhRNU0zIgowesyXNQuOZZEJdGjtWl/I8TiIhm3/cwHO/C17tZiu
 i2gZUx1jfhcwpcFNDsQhJu1rw72cM4sikAcok3GLnhAlg0IYvPpuX0TiWqhtZ7XgW6KI
 FY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J5zhPuFSG1IvgY/HZM+zfSrn5bmQLwsRBPEuzZHx2Fo=;
 b=WJafK6D3/fmXo4tamlEAJ+OnbDWQqIE5doK+6dkZCLbpj/ecpWNLkHfTtJ6SYv1Nnw
 YwaKp8AL38+VV0qeA+fbvYi0IW7WVsuQeO/fPNFRJfpGJE4MgoFKQpu117v2YJXlaOxF
 8ePrtnToVK5T4pMaBRDfPMYRCgIjnWuo9H/k1FGujA+MR++ggBUZdx3tTHRFm7jXh9NO
 UgueH1cKkF4ITmUQD+ewd0t1Fqe0TqY3h4pzIgbZvS0gI7/zYz3Pu/W03LB6W2+e7hOo
 olJgrTfPCguYPOKmoby4S2vSHEdEZo4VGpI1wk7rj+wfrs8FxVMTcXCZd16uk8M5MKxM
 Oa5w==
X-Gm-Message-State: AGi0PuZXXu9Oy11jMXVEWZni8w0j3rFxcPvmhXRCicTNSit0YTVl82AA
 Sv4IvbFT9oeJ7LN7WMq6Fc/1rDTdDJA=
X-Google-Smtp-Source: APiQypKSOuUm8BusoxpVjnX4k1q6dsTGpTUQpA9fb+41xneWo9JZReIZWx7ZQR6w/cvPyMC7J4Rkfg==
X-Received: by 2002:a63:575f:: with SMTP id h31mr3513128pgm.200.1588264102439; 
 Thu, 30 Apr 2020 09:28:22 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/18] accel/tcg: Add endian-specific cpu_{ld,
 st}* operations
Date: Thu, 30 Apr 2020 09:28:00 -0700
Message-Id: <20200430162813.17671-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently have target-endian versions of these operations,
but no easy way to force a specific endianness.  This can be
helpful if the target has endian-specific operations, or a mode
that swaps endianness.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/loads-stores.rst |  39 +++--
 include/exec/cpu_ldst.h     | 283 +++++++++++++++++++++++++++---------
 accel/tcg/cputlb.c          | 236 ++++++++++++++++++++++--------
 accel/tcg/user-exec.c       | 211 ++++++++++++++++++++++-----
 4 files changed, 587 insertions(+), 182 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 0d99eb24c1..9a944ef1af 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -97,9 +97,9 @@ function, which is a return address into the generated code.
 
 Function names follow the pattern:
 
-load: ``cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmuidx, retaddr)``
+load: ``cpu_ld{sign}{size}{end}_mmuidx_ra(env, ptr, mmuidx, retaddr)``
 
-store: ``cpu_st{size}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
+store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
 
 ``sign``
  - (empty) : for 32 or 64 bit sizes
@@ -112,9 +112,14 @@ store: ``cpu_st{size}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
+``end``
+ - (empty) : for target endian, or 8 bit sizes
+ - ``_be`` : big endian
+ - ``_le`` : little endian
+
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]_mmuidx_ra\>``
- - ``\<cpu_st[bwlq]_mmuidx_ra\>``
+ - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_mmuidx_ra\>``
+ - ``\<cpu_st[bwlq](_[bl]e)\?_mmuidx_ra\>``
 
 ``cpu_{ld,st}*_data_ra``
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -129,9 +134,9 @@ be performed with a context other than the default.
 
 Function names follow the pattern:
 
-load: ``cpu_ld{sign}{size}_data_ra(env, ptr, ra)``
+load: ``cpu_ld{sign}{size}{end}_data_ra(env, ptr, ra)``
 
-store: ``cpu_st{size}_data_ra(env, ptr, val, ra)``
+store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
 
 ``sign``
  - (empty) : for 32 or 64 bit sizes
@@ -144,9 +149,14 @@ store: ``cpu_st{size}_data_ra(env, ptr, val, ra)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
+``end``
+ - (empty) : for target endian, or 8 bit sizes
+ - ``_be`` : big endian
+ - ``_le`` : little endian
+
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]_data_ra\>``
- - ``\<cpu_st[bwlq]_data_ra\>``
+ - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_data_ra\>``
+ - ``\<cpu_st[bwlq](_[bl]e)\?_data_ra\>``
 
 ``cpu_{ld,st}*_data``
 ~~~~~~~~~~~~~~~~~~~~~
@@ -163,9 +173,9 @@ the CPU state anyway.
 
 Function names follow the pattern:
 
-load: ``cpu_ld{sign}{size}_data(env, ptr)``
+load: ``cpu_ld{sign}{size}{end}_data(env, ptr)``
 
-store: ``cpu_st{size}_data(env, ptr, val)``
+store: ``cpu_st{size}{end}_data(env, ptr, val)``
 
 ``sign``
  - (empty) : for 32 or 64 bit sizes
@@ -178,9 +188,14 @@ store: ``cpu_st{size}_data(env, ptr, val)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
+``end``
+ - (empty) : for target endian, or 8 bit sizes
+ - ``_be`` : big endian
+ - ``_le`` : little endian
+
 Regexes for git grep
- - ``\<cpu_ld[us]\?[bwlq]_data\>``
- - ``\<cpu_st[bwlq]_data\+\>``
+ - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_data\>``
+ - ``\<cpu_st[bwlq](_[bl]e)\?_data\+\>``
 
 ``cpu_ld*_code``
 ~~~~~~~~~~~~~~~~
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 53de19753a..c14a48f65e 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -25,13 +25,13 @@
  *
  * The syntax for the accessors is:
  *
- * load:  cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
- *        cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)
- *        cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
+ * load:  cpu_ld{sign}{size}{end}_{mmusuffix}(env, ptr)
+ *        cpu_ld{sign}{size}{end}_{mmusuffix}_ra(env, ptr, retaddr)
+ *        cpu_ld{sign}{size}{end}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
  *
- * store: cpu_st{size}_{mmusuffix}(env, ptr, val)
- *        cpu_st{size}_{mmusuffix}_ra(env, ptr, val, retaddr)
- *        cpu_st{size}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
+ * store: cpu_st{size}{end}_{mmusuffix}(env, ptr, val)
+ *        cpu_st{size}{end}_{mmusuffix}_ra(env, ptr, val, retaddr)
+ *        cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
  *
  * sign is:
  * (empty): for 32 and 64 bit sizes
@@ -44,6 +44,11 @@
  *   l: 32 bits
  *   q: 64 bits
  *
+ * end is:
+ * (empty): for target native endian, or for 8 bit access
+ *     _be: for forced big endian
+ *     _le: for forced little endian
+ *
  * mmusuffix is one of the generic suffixes "data" or "code", or "mmuidx".
  * The "mmuidx" suffix carries an extra mmu_idx argument that specifies
  * the index to use; the "data" and "code" suffixes take the index from
@@ -95,32 +100,57 @@ typedef target_ulong abi_ptr;
 #endif
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_lduw_data(CPUArchState *env, abi_ptr ptr);
-uint32_t cpu_ldl_data(CPUArchState *env, abi_ptr ptr);
-uint64_t cpu_ldq_data(CPUArchState *env, abi_ptr ptr);
 int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
-int cpu_ldsw_data(CPUArchState *env, abi_ptr ptr);
 
-uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);
-uint32_t cpu_lduw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);
-uint32_t cpu_ldl_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);
-uint64_t cpu_ldq_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);
-int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);
-int cpu_ldsw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);
+uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr ptr);
+int cpu_ldsw_be_data(CPUArchState *env, abi_ptr ptr);
+uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr ptr);
+uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr ptr);
+
+uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr ptr);
+int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
+uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
+uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
+
+uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+
+uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+
+uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
+uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
 
 void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stw_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stl_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
-void cpu_stq_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
+
+void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
+void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
+void cpu_stq_be_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
+
+void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
+void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
+void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
 
 void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint32_t val, uintptr_t retaddr);
-void cpu_stw_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint32_t val, uintptr_t retaddr);
-void cpu_stl_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint32_t val, uintptr_t retaddr);
-void cpu_stq_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint64_t val, uintptr_t retaddr);
+                     uint32_t val, uintptr_t ra);
+
+void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint32_t val, uintptr_t ra);
+void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint32_t val, uintptr_t ra);
+void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint64_t val, uintptr_t ra);
+
+void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint32_t val, uintptr_t ra);
+void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint32_t val, uintptr_t ra);
+void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint64_t val, uintptr_t ra);
 
 #if defined(CONFIG_USER_ONLY)
 
@@ -157,34 +187,58 @@ static inline uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
     return cpu_ldub_data_ra(env, addr, ra);
 }
 
-static inline uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                                          int mmu_idx, uintptr_t ra)
-{
-    return cpu_lduw_data_ra(env, addr, ra);
-}
-
-static inline uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                                         int mmu_idx, uintptr_t ra)
-{
-    return cpu_ldl_data_ra(env, addr, ra);
-}
-
-static inline uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                                         int mmu_idx, uintptr_t ra)
-{
-    return cpu_ldq_data_ra(env, addr, ra);
-}
-
 static inline int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                                      int mmu_idx, uintptr_t ra)
 {
     return cpu_ldsb_data_ra(env, addr, ra);
 }
 
-static inline int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                                     int mmu_idx, uintptr_t ra)
+static inline uint32_t cpu_lduw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                             int mmu_idx, uintptr_t ra)
 {
-    return cpu_ldsw_data_ra(env, addr, ra);
+    return cpu_lduw_be_data_ra(env, addr, ra);
+}
+
+static inline int cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                        int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldsw_be_data_ra(env, addr, ra);
+}
+
+static inline uint32_t cpu_ldl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                            int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldl_be_data_ra(env, addr, ra);
+}
+
+static inline uint64_t cpu_ldq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                            int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldq_be_data_ra(env, addr, ra);
+}
+
+static inline uint32_t cpu_lduw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                             int mmu_idx, uintptr_t ra)
+{
+    return cpu_lduw_le_data_ra(env, addr, ra);
+}
+
+static inline int cpu_ldsw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                        int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldsw_le_data_ra(env, addr, ra);
+}
+
+static inline uint32_t cpu_ldl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                            int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldl_le_data_ra(env, addr, ra);
+}
+
+static inline uint64_t cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                            int mmu_idx, uintptr_t ra)
+{
+    return cpu_ldq_le_data_ra(env, addr, ra);
 }
 
 static inline void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
@@ -193,22 +247,46 @@ static inline void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
     cpu_stb_data_ra(env, addr, val, ra);
 }
 
-static inline void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                                     uint32_t val, int mmu_idx, uintptr_t ra)
+static inline void cpu_stw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                        uint32_t val, int mmu_idx,
+                                        uintptr_t ra)
 {
-    cpu_stw_data_ra(env, addr, val, ra);
+    cpu_stw_be_data_ra(env, addr, val, ra);
 }
 
-static inline void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                                     uint32_t val, int mmu_idx, uintptr_t ra)
+static inline void cpu_stl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                        uint32_t val, int mmu_idx,
+                                        uintptr_t ra)
 {
-    cpu_stl_data_ra(env, addr, val, ra);
+    cpu_stl_be_data_ra(env, addr, val, ra);
 }
 
-static inline void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                                     uint64_t val, int mmu_idx, uintptr_t ra)
+static inline void cpu_stq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                        uint64_t val, int mmu_idx,
+                                        uintptr_t ra)
 {
-    cpu_stq_data_ra(env, addr, val, ra);
+    cpu_stq_be_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                        uint32_t val, int mmu_idx,
+                                        uintptr_t ra)
+{
+    cpu_stw_le_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                        uint32_t val, int mmu_idx,
+                                        uintptr_t ra)
+{
+    cpu_stl_le_data_ra(env, addr, val, ra);
+}
+
+static inline void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                                        uint64_t val, int mmu_idx,
+                                        uintptr_t ra)
+{
+    cpu_stq_le_data_ra(env, addr, val, ra);
 }
 
 #else
@@ -243,29 +321,92 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
 
 uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                             int mmu_idx, uintptr_t ra);
-uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                            int mmu_idx, uintptr_t ra);
-uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                           int mmu_idx, uintptr_t ra);
-uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                           int mmu_idx, uintptr_t ra);
-
 int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                        int mmu_idx, uintptr_t ra);
-int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                       int mmu_idx, uintptr_t ra);
+
+uint32_t cpu_lduw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                               int mmu_idx, uintptr_t ra);
+int cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                          int mmu_idx, uintptr_t ra);
+uint32_t cpu_ldl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                              int mmu_idx, uintptr_t ra);
+uint64_t cpu_ldq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                              int mmu_idx, uintptr_t ra);
+
+uint32_t cpu_lduw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                               int mmu_idx, uintptr_t ra);
+int cpu_ldsw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                          int mmu_idx, uintptr_t ra);
+uint32_t cpu_ldl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                              int mmu_idx, uintptr_t ra);
+uint64_t cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                              int mmu_idx, uintptr_t ra);
 
 void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
                        int mmu_idx, uintptr_t retaddr);
-void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
-                       int mmu_idx, uintptr_t retaddr);
-void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
-                       int mmu_idx, uintptr_t retaddr);
-void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
-                       int mmu_idx, uintptr_t retaddr);
+
+void cpu_stw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                          int mmu_idx, uintptr_t retaddr);
+void cpu_stl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                          int mmu_idx, uintptr_t retaddr);
+void cpu_stq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
+                          int mmu_idx, uintptr_t retaddr);
+
+void cpu_stw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                          int mmu_idx, uintptr_t retaddr);
+void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                          int mmu_idx, uintptr_t retaddr);
+void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
+                          int mmu_idx, uintptr_t retaddr);
 
 #endif /* defined(CONFIG_USER_ONLY) */
 
+#ifdef TARGET_WORDS_BIGENDIAN
+# define cpu_lduw_data        cpu_lduw_be_data
+# define cpu_ldsw_data        cpu_ldsw_be_data
+# define cpu_ldl_data         cpu_ldl_be_data
+# define cpu_ldq_data         cpu_ldq_be_data
+# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
+# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
+# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
+# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
+# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
+# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
+# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
+# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
+# define cpu_stw_data         cpu_stw_be_data
+# define cpu_stl_data         cpu_stl_be_data
+# define cpu_stq_data         cpu_stq_be_data
+# define cpu_stw_data_ra      cpu_stw_be_data_ra
+# define cpu_stl_data_ra      cpu_stl_be_data_ra
+# define cpu_stq_data_ra      cpu_stq_be_data_ra
+# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
+# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
+# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
+#else
+# define cpu_lduw_data        cpu_lduw_le_data
+# define cpu_ldsw_data        cpu_ldsw_le_data
+# define cpu_ldl_data         cpu_ldl_le_data
+# define cpu_ldq_data         cpu_ldq_le_data
+# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
+# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
+# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
+# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
+# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
+# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
+# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
+# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
+# define cpu_stw_data         cpu_stw_le_data
+# define cpu_stl_data         cpu_stl_le_data
+# define cpu_stq_data         cpu_stq_le_data
+# define cpu_stw_data_ra      cpu_stw_le_data_ra
+# define cpu_stl_data_ra      cpu_stl_le_data_ra
+# define cpu_stq_data_ra      cpu_stq_le_data_ra
+# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
+# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
+# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
+#endif
+
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c708e9785f..eb2cf9de5e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1772,36 +1772,54 @@ int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                                    full_ldub_mmu);
 }
 
-uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                            int mmu_idx, uintptr_t ra)
+uint32_t cpu_lduw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                               int mmu_idx, uintptr_t ra)
 {
-    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUW,
-                           MO_TE == MO_LE
-                           ? full_le_lduw_mmu : full_be_lduw_mmu);
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_BEUW, full_be_lduw_mmu);
 }
 
-int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                       int mmu_idx, uintptr_t ra)
+int cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                          int mmu_idx, uintptr_t ra)
 {
-    return (int16_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_TESW,
-                                    MO_TE == MO_LE
-                                    ? full_le_lduw_mmu : full_be_lduw_mmu);
+    return (int16_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_BESW,
+                                    full_be_lduw_mmu);
 }
 
-uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                           int mmu_idx, uintptr_t ra)
+uint32_t cpu_ldl_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                              int mmu_idx, uintptr_t ra)
 {
-    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUL,
-                           MO_TE == MO_LE
-                           ? full_le_ldul_mmu : full_be_ldul_mmu);
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_BEUL, full_be_ldul_mmu);
 }
 
-uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
-                           int mmu_idx, uintptr_t ra)
+uint64_t cpu_ldq_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                              int mmu_idx, uintptr_t ra)
 {
-    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEQ,
-                           MO_TE == MO_LE
-                           ? helper_le_ldq_mmu : helper_be_ldq_mmu);
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_BEQ, helper_be_ldq_mmu);
+}
+
+uint32_t cpu_lduw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                               int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_LEUW, full_le_lduw_mmu);
+}
+
+int cpu_ldsw_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                          int mmu_idx, uintptr_t ra)
+{
+    return (int16_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_LESW,
+                                    full_le_lduw_mmu);
+}
+
+uint32_t cpu_ldl_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                              int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_LEUL, full_le_ldul_mmu);
+}
+
+uint64_t cpu_ldq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                              int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_LEQ, helper_le_ldq_mmu);
 }
 
 uint32_t cpu_ldub_data_ra(CPUArchState *env, target_ulong ptr,
@@ -1815,25 +1833,50 @@ int cpu_ldsb_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
     return cpu_ldsb_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
 }
 
-uint32_t cpu_lduw_data_ra(CPUArchState *env, target_ulong ptr,
-                          uintptr_t retaddr)
+uint32_t cpu_lduw_be_data_ra(CPUArchState *env, target_ulong ptr,
+                             uintptr_t retaddr)
 {
-    return cpu_lduw_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+    return cpu_lduw_be_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
 }
 
-int cpu_ldsw_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+int cpu_ldsw_be_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
 {
-    return cpu_ldsw_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+    return cpu_ldsw_be_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
 }
 
-uint32_t cpu_ldl_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+uint32_t cpu_ldl_be_data_ra(CPUArchState *env, target_ulong ptr,
+                            uintptr_t retaddr)
 {
-    return cpu_ldl_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+    return cpu_ldl_be_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
 }
 
-uint64_t cpu_ldq_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+uint64_t cpu_ldq_be_data_ra(CPUArchState *env, target_ulong ptr,
+                            uintptr_t retaddr)
 {
-    return cpu_ldq_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+    return cpu_ldq_be_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint32_t cpu_lduw_le_data_ra(CPUArchState *env, target_ulong ptr,
+                             uintptr_t retaddr)
+{
+    return cpu_lduw_le_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+int cpu_ldsw_le_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldsw_le_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint32_t cpu_ldl_le_data_ra(CPUArchState *env, target_ulong ptr,
+                            uintptr_t retaddr)
+{
+    return cpu_ldl_le_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint64_t cpu_ldq_le_data_ra(CPUArchState *env, target_ulong ptr,
+                            uintptr_t retaddr)
+{
+    return cpu_ldq_le_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
 }
 
 uint32_t cpu_ldub_data(CPUArchState *env, target_ulong ptr)
@@ -1846,24 +1889,44 @@ int cpu_ldsb_data(CPUArchState *env, target_ulong ptr)
     return cpu_ldsb_data_ra(env, ptr, 0);
 }
 
-uint32_t cpu_lduw_data(CPUArchState *env, target_ulong ptr)
+uint32_t cpu_lduw_be_data(CPUArchState *env, target_ulong ptr)
 {
-    return cpu_lduw_data_ra(env, ptr, 0);
+    return cpu_lduw_be_data_ra(env, ptr, 0);
 }
 
-int cpu_ldsw_data(CPUArchState *env, target_ulong ptr)
+int cpu_ldsw_be_data(CPUArchState *env, target_ulong ptr)
 {
-    return cpu_ldsw_data_ra(env, ptr, 0);
+    return cpu_ldsw_be_data_ra(env, ptr, 0);
 }
 
-uint32_t cpu_ldl_data(CPUArchState *env, target_ulong ptr)
+uint32_t cpu_ldl_be_data(CPUArchState *env, target_ulong ptr)
 {
-    return cpu_ldl_data_ra(env, ptr, 0);
+    return cpu_ldl_be_data_ra(env, ptr, 0);
 }
 
-uint64_t cpu_ldq_data(CPUArchState *env, target_ulong ptr)
+uint64_t cpu_ldq_be_data(CPUArchState *env, target_ulong ptr)
 {
-    return cpu_ldq_data_ra(env, ptr, 0);
+    return cpu_ldq_be_data_ra(env, ptr, 0);
+}
+
+uint32_t cpu_lduw_le_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_lduw_le_data_ra(env, ptr, 0);
+}
+
+int cpu_ldsw_le_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldsw_le_data_ra(env, ptr, 0);
+}
+
+uint32_t cpu_ldl_le_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldl_le_data_ra(env, ptr, 0);
+}
+
+uint64_t cpu_ldq_le_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldq_le_data_ra(env, ptr, 0);
 }
 
 /*
@@ -2121,22 +2184,40 @@ void cpu_stb_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
     cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_UB);
 }
 
-void cpu_stw_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
-                       int mmu_idx, uintptr_t retaddr)
+void cpu_stw_be_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                          int mmu_idx, uintptr_t retaddr)
 {
-    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUW);
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_BEUW);
 }
 
-void cpu_stl_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
-                       int mmu_idx, uintptr_t retaddr)
+void cpu_stl_be_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                          int mmu_idx, uintptr_t retaddr)
 {
-    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUL);
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_BEUL);
 }
 
-void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
-                       int mmu_idx, uintptr_t retaddr)
+void cpu_stq_be_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
+                          int mmu_idx, uintptr_t retaddr)
 {
-    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEQ);
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_BEQ);
+}
+
+void cpu_stw_le_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                          int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_LEUW);
+}
+
+void cpu_stl_le_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                          int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_LEUL);
+}
+
+void cpu_stq_le_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
+                          int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_LEQ);
 }
 
 void cpu_stb_data_ra(CPUArchState *env, target_ulong ptr,
@@ -2145,22 +2226,40 @@ void cpu_stb_data_ra(CPUArchState *env, target_ulong ptr,
     cpu_stb_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
 }
 
-void cpu_stw_data_ra(CPUArchState *env, target_ulong ptr,
-                     uint32_t val, uintptr_t retaddr)
+void cpu_stw_be_data_ra(CPUArchState *env, target_ulong ptr,
+                        uint32_t val, uintptr_t retaddr)
 {
-    cpu_stw_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+    cpu_stw_be_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
 }
 
-void cpu_stl_data_ra(CPUArchState *env, target_ulong ptr,
-                     uint32_t val, uintptr_t retaddr)
+void cpu_stl_be_data_ra(CPUArchState *env, target_ulong ptr,
+                        uint32_t val, uintptr_t retaddr)
 {
-    cpu_stl_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+    cpu_stl_be_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
 }
 
-void cpu_stq_data_ra(CPUArchState *env, target_ulong ptr,
-                     uint64_t val, uintptr_t retaddr)
+void cpu_stq_be_data_ra(CPUArchState *env, target_ulong ptr,
+                        uint64_t val, uintptr_t retaddr)
 {
-    cpu_stq_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+    cpu_stq_be_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stw_le_data_ra(CPUArchState *env, target_ulong ptr,
+                        uint32_t val, uintptr_t retaddr)
+{
+    cpu_stw_le_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stl_le_data_ra(CPUArchState *env, target_ulong ptr,
+                        uint32_t val, uintptr_t retaddr)
+{
+    cpu_stl_le_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stq_le_data_ra(CPUArchState *env, target_ulong ptr,
+                        uint64_t val, uintptr_t retaddr)
+{
+    cpu_stq_le_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
 }
 
 void cpu_stb_data(CPUArchState *env, target_ulong ptr, uint32_t val)
@@ -2168,19 +2267,34 @@ void cpu_stb_data(CPUArchState *env, target_ulong ptr, uint32_t val)
     cpu_stb_data_ra(env, ptr, val, 0);
 }
 
-void cpu_stw_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+void cpu_stw_be_data(CPUArchState *env, target_ulong ptr, uint32_t val)
 {
-    cpu_stw_data_ra(env, ptr, val, 0);
+    cpu_stw_be_data_ra(env, ptr, val, 0);
 }
 
-void cpu_stl_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+void cpu_stl_be_data(CPUArchState *env, target_ulong ptr, uint32_t val)
 {
-    cpu_stl_data_ra(env, ptr, val, 0);
+    cpu_stl_be_data_ra(env, ptr, val, 0);
 }
 
-void cpu_stq_data(CPUArchState *env, target_ulong ptr, uint64_t val)
+void cpu_stq_be_data(CPUArchState *env, target_ulong ptr, uint64_t val)
 {
-    cpu_stq_data_ra(env, ptr, val, 0);
+    cpu_stq_be_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stw_le_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+{
+    cpu_stw_le_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stl_le_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+{
+    cpu_stl_le_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stq_le_data(CPUArchState *env, target_ulong ptr, uint64_t val)
+{
+    cpu_stq_le_data_ra(env, ptr, val, 0);
 }
 
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 987342c50c..52359949df 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -783,46 +783,90 @@ int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr)
     return ret;
 }
 
-uint32_t cpu_lduw_data(CPUArchState *env, abi_ptr ptr)
+uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr ptr)
 {
     uint32_t ret;
-    uint16_t meminfo = trace_mem_get_info(MO_TEUW, MMU_USER_IDX, false);
+    uint16_t meminfo = trace_mem_get_info(MO_BEUW, MMU_USER_IDX, false);
 
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-    ret = lduw_p(g2h(ptr));
+    ret = lduw_be_p(g2h(ptr));
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
     return ret;
 }
 
-int cpu_ldsw_data(CPUArchState *env, abi_ptr ptr)
+int cpu_ldsw_be_data(CPUArchState *env, abi_ptr ptr)
 {
     int ret;
-    uint16_t meminfo = trace_mem_get_info(MO_TESW, MMU_USER_IDX, false);
+    uint16_t meminfo = trace_mem_get_info(MO_BESW, MMU_USER_IDX, false);
 
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-    ret = ldsw_p(g2h(ptr));
+    ret = ldsw_be_p(g2h(ptr));
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
     return ret;
 }
 
-uint32_t cpu_ldl_data(CPUArchState *env, abi_ptr ptr)
+uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr ptr)
 {
     uint32_t ret;
-    uint16_t meminfo = trace_mem_get_info(MO_TEUL, MMU_USER_IDX, false);
+    uint16_t meminfo = trace_mem_get_info(MO_BEUL, MMU_USER_IDX, false);
 
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-    ret = ldl_p(g2h(ptr));
+    ret = ldl_be_p(g2h(ptr));
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
     return ret;
 }
 
-uint64_t cpu_ldq_data(CPUArchState *env, abi_ptr ptr)
+uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr ptr)
 {
     uint64_t ret;
-    uint16_t meminfo = trace_mem_get_info(MO_TEQ, MMU_USER_IDX, false);
+    uint16_t meminfo = trace_mem_get_info(MO_BEQ, MMU_USER_IDX, false);
 
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-    ret = ldq_p(g2h(ptr));
+    ret = ldq_be_p(g2h(ptr));
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+    return ret;
+}
+
+uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr ptr)
+{
+    uint32_t ret;
+    uint16_t meminfo = trace_mem_get_info(MO_LEUW, MMU_USER_IDX, false);
+
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    ret = lduw_le_p(g2h(ptr));
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+    return ret;
+}
+
+int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr)
+{
+    int ret;
+    uint16_t meminfo = trace_mem_get_info(MO_LESW, MMU_USER_IDX, false);
+
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    ret = ldsw_le_p(g2h(ptr));
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+    return ret;
+}
+
+uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr)
+{
+    uint32_t ret;
+    uint16_t meminfo = trace_mem_get_info(MO_LEUL, MMU_USER_IDX, false);
+
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    ret = ldl_le_p(g2h(ptr));
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+    return ret;
+}
+
+uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr)
+{
+    uint64_t ret;
+    uint16_t meminfo = trace_mem_get_info(MO_LEQ, MMU_USER_IDX, false);
+
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    ret = ldq_le_p(g2h(ptr));
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
     return ret;
 }
@@ -847,42 +891,82 @@ int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
     return ret;
 }
 
-uint32_t cpu_lduw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
+uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
 {
     uint32_t ret;
 
     set_helper_retaddr(retaddr);
-    ret = cpu_lduw_data(env, ptr);
+    ret = cpu_lduw_be_data(env, ptr);
     clear_helper_retaddr();
     return ret;
 }
 
-int cpu_ldsw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
+int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
 {
     int ret;
 
     set_helper_retaddr(retaddr);
-    ret = cpu_ldsw_data(env, ptr);
+    ret = cpu_ldsw_be_data(env, ptr);
     clear_helper_retaddr();
     return ret;
 }
 
-uint32_t cpu_ldl_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
+uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
 {
     uint32_t ret;
 
     set_helper_retaddr(retaddr);
-    ret = cpu_ldl_data(env, ptr);
+    ret = cpu_ldl_be_data(env, ptr);
     clear_helper_retaddr();
     return ret;
 }
 
-uint64_t cpu_ldq_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
+uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
 {
     uint64_t ret;
 
     set_helper_retaddr(retaddr);
-    ret = cpu_ldq_data(env, ptr);
+    ret = cpu_ldq_be_data(env, ptr);
+    clear_helper_retaddr();
+    return ret;
+}
+
+uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
+{
+    uint32_t ret;
+
+    set_helper_retaddr(retaddr);
+    ret = cpu_lduw_le_data(env, ptr);
+    clear_helper_retaddr();
+    return ret;
+}
+
+int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
+{
+    int ret;
+
+    set_helper_retaddr(retaddr);
+    ret = cpu_ldsw_le_data(env, ptr);
+    clear_helper_retaddr();
+    return ret;
+}
+
+uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
+{
+    uint32_t ret;
+
+    set_helper_retaddr(retaddr);
+    ret = cpu_ldl_le_data(env, ptr);
+    clear_helper_retaddr();
+    return ret;
+}
+
+uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
+{
+    uint64_t ret;
+
+    set_helper_retaddr(retaddr);
+    ret = cpu_ldq_le_data(env, ptr);
     clear_helper_retaddr();
     return ret;
 }
@@ -896,30 +980,57 @@ void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
 }
 
-void cpu_stw_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
+void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
 {
-    uint16_t meminfo = trace_mem_get_info(MO_TEUW, MMU_USER_IDX, true);
+    uint16_t meminfo = trace_mem_get_info(MO_BEUW, MMU_USER_IDX, true);
 
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-    stw_p(g2h(ptr), val);
+    stw_be_p(g2h(ptr), val);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
 }
 
-void cpu_stl_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
+void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
 {
-    uint16_t meminfo = trace_mem_get_info(MO_TEUL, MMU_USER_IDX, true);
+    uint16_t meminfo = trace_mem_get_info(MO_BEUL, MMU_USER_IDX, true);
 
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-    stl_p(g2h(ptr), val);
+    stl_be_p(g2h(ptr), val);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
 }
 
-void cpu_stq_data(CPUArchState *env, abi_ptr ptr, uint64_t val)
+void cpu_stq_be_data(CPUArchState *env, abi_ptr ptr, uint64_t val)
 {
-    uint16_t meminfo = trace_mem_get_info(MO_TEQ, MMU_USER_IDX, true);
+    uint16_t meminfo = trace_mem_get_info(MO_BEQ, MMU_USER_IDX, true);
 
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-    stq_p(g2h(ptr), val);
+    stq_be_p(g2h(ptr), val);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+}
+
+void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
+{
+    uint16_t meminfo = trace_mem_get_info(MO_LEUW, MMU_USER_IDX, true);
+
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    stw_le_p(g2h(ptr), val);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+}
+
+void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
+{
+    uint16_t meminfo = trace_mem_get_info(MO_LEUL, MMU_USER_IDX, true);
+
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    stl_le_p(g2h(ptr), val);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+}
+
+void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val)
+{
+    uint16_t meminfo = trace_mem_get_info(MO_LEQ, MMU_USER_IDX, true);
+
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    stq_le_p(g2h(ptr), val);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
 }
 
@@ -931,27 +1042,51 @@ void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
     clear_helper_retaddr();
 }
 
-void cpu_stw_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint32_t val, uintptr_t retaddr)
+void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint32_t val, uintptr_t retaddr)
 {
     set_helper_retaddr(retaddr);
-    cpu_stw_data(env, ptr, val);
+    cpu_stw_be_data(env, ptr, val);
     clear_helper_retaddr();
 }
 
-void cpu_stl_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint32_t val, uintptr_t retaddr)
+void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint32_t val, uintptr_t retaddr)
 {
     set_helper_retaddr(retaddr);
-    cpu_stl_data(env, ptr, val);
+    cpu_stl_be_data(env, ptr, val);
     clear_helper_retaddr();
 }
 
-void cpu_stq_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint64_t val, uintptr_t retaddr)
+void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint64_t val, uintptr_t retaddr)
 {
     set_helper_retaddr(retaddr);
-    cpu_stq_data(env, ptr, val);
+    cpu_stq_be_data(env, ptr, val);
+    clear_helper_retaddr();
+}
+
+void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint32_t val, uintptr_t retaddr)
+{
+    set_helper_retaddr(retaddr);
+    cpu_stw_le_data(env, ptr, val);
+    clear_helper_retaddr();
+}
+
+void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint32_t val, uintptr_t retaddr)
+{
+    set_helper_retaddr(retaddr);
+    cpu_stl_le_data(env, ptr, val);
+    clear_helper_retaddr();
+}
+
+void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr ptr,
+                        uint64_t val, uintptr_t retaddr)
+{
+    set_helper_retaddr(retaddr);
+    cpu_stq_le_data(env, ptr, val);
     clear_helper_retaddr();
 }
 
-- 
2.20.1


