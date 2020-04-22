Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D57C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9870A206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Td/lw+3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9870A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR7Cc-0005iZ-Ny
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74f-0000fN-7R
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74c-00058t-AU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:24 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74b-00050d-PX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:21 -0400
Received: by mail-pg1-x541.google.com with SMTP id t11so477438pgg.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TKqQ4LL/EXD07c3oky97BGHTG17Hr8gQbPOCsIsLoeU=;
 b=Td/lw+3RkEwNrEd2m9K1iuxg5+KZd4LmnfLsqyGAmfyPxdKU0Nrg3rvgZ1rVhshQHm
 rFJll/RGyfdDLi9MxKYJcba1hTOuzLlUmshcdSeYX4xMRMrkX92lzSt3j5PncSM0FiiL
 tPzecQOfQv17S5hdHR0meR5rAmhJPLeLQTz6tRxv3Snn9ehzTdnM41CV7uRYcOhxr9fZ
 fp9j75M7W93/ihoxUY7nKlnyOyTc37nAUA8kl5lwxaBeSaSe2Sl8KJ5OwDSYOK/B6K9k
 bf2tirqraYmspatzyiF5eT3wGOHkoQvSPpeK4YWG6T0IzFhWs/rV1a83SE5+eVn/mSa2
 iZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TKqQ4LL/EXD07c3oky97BGHTG17Hr8gQbPOCsIsLoeU=;
 b=tPb6iyIBolOXZHtMc6iS59Bbm6iyIWe4H2+6Z0CnXP+qBiihm75GZeNAiyJp/KYv5W
 nox2z1SNtbLm2fsWjlsXxJdWWInWAMGCO/c3mp+FKtZKujihhTDHby274GTkXOrKmh+H
 Lsv99GAyAtJisCPhaeoBNOIPTXBP8Yknl7d7BUga0rGeeiBix5nIsStxDdCjZjQf+rJ/
 QdaC7saAAVhg+2vOJocv9I+Q63cYAX3YSv87GU8iqBevp4kQT9uAbWZyN2LuXrsD4SB2
 g1q90MKrTKSk+VI83D0tJugct3WGsrG1HOrtvsamx9bM++93o4trjBoshqNS/y910BTQ
 dfeA==
X-Gm-Message-State: AGi0PuaPTpabeXfOeHzIurfO2jdfWCO80awunXEMhCD8ujVdo8vOAnsu
 fcfqrNmYtLXj0rsWL4aYUA5lW+gDnC8=
X-Google-Smtp-Source: APiQypI8D/+9e31ux0nAazbmsfztMtGnWLEfwdjsBXNp6nfHY/sVZBGKZGz8JacRgjoes/2UBNTgHA==
X-Received: by 2002:a63:5907:: with SMTP id n7mr22857778pgb.439.1587529999135; 
 Tue, 21 Apr 2020 21:33:19 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/18] accel/tcg: Add endian-specific cpu_{ld,
 st}* operations
Date: Tue, 21 Apr 2020 21:32:56 -0700
Message-Id: <20200422043309.18430-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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

We currently have target-endian versions of these operations,
but no easy way to force a specific endianness.  This can be
helpful if the target has endian-specific operations, or a mode
that swaps endianness.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/loads-stores.rst |  39 +++--
 include/exec/cpu_ldst.h     | 277 +++++++++++++++++++++++++++---------
 accel/tcg/cputlb.c          | 236 ++++++++++++++++++++++--------
 accel/tcg/user-exec.c       | 211 ++++++++++++++++++++++-----
 4 files changed, 587 insertions(+), 176 deletions(-)

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
index 53de19753a..1ba515bfcc 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -26,12 +26,18 @@
  * The syntax for the accessors is:
  *
  * load:  cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
+ *        cpu_ld{sign}{size}{end}_{mmusuffix}(env, ptr)
  *        cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)
+ *        cpu_ld{sign}{size}{end}_{mmusuffix}_ra(env, ptr, retaddr)
  *        cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
+ *        cpu_ld{sign}{size}{end}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
  *
  * store: cpu_st{size}_{mmusuffix}(env, ptr, val)
+ *        cpu_st{size}{end}_{mmusuffix}(env, ptr, val)
  *        cpu_st{size}_{mmusuffix}_ra(env, ptr, val, retaddr)
+ *        cpu_st{size}{end}_{mmusuffix}_ra(env, ptr, val, retaddr)
  *        cpu_st{size}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
+ *        cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
  *
  * sign is:
  * (empty): for 32 and 64 bit sizes
@@ -44,6 +50,11 @@
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
@@ -95,32 +106,57 @@ typedef target_ulong abi_ptr;
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
 
@@ -157,34 +193,58 @@ static inline uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
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
@@ -193,22 +253,46 @@ static inline void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
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
@@ -243,29 +327,92 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
 
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
index bbe265ce28..ca18543463 100644
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
index 91c2dc46dd..ac45dd118e 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -772,46 +772,90 @@ int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr)
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
@@ -836,42 +880,82 @@ int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
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
@@ -885,30 +969,57 @@ void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
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
 
@@ -920,27 +1031,51 @@ void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
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


