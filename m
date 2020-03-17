Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0EC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1176D20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5cV0sWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1176D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHUA-0000bV-7C
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRt-0007CV-Ta
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRs-0004Jv-7E
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:43237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEHRs-0004Ew-0I
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:20 -0400
Received: by mail-pf1-x42f.google.com with SMTP id f206so1444972pfa.10
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=srAo9cELKNxJLe7H5Kb1ku6pI8RUGetGR66tpA6jg7k=;
 b=g5cV0sWi0pK/kT+vpnX7alQ7WaWedDU9MF5ybT5F1BLgp9O6EpCCfTZKg8i2DknVLv
 EfXhAbSHLFmKmuHU0PXiO+z85Ewat7Khx4PWIDUxTLu6V1uocC7yh1rHBGTKumDBzgnd
 tV2pZNps5g76pLz4VRMHlKr2s50rUjRYh78zSSiaNO2k4xlfVgxnvzYDCE7OXhYXyFUv
 h1Elmwpo1iFKExWhXEtsmeI98ImWGT1Bym7urMrGGHO/E8VqmqWVcusX0hAKd5CnJqq7
 PgxkF48xmwjCevc+okEEo11S+xuaFQ1zDaag4fLaPXYC4WOh4vdD1N9qii9sJblsMk8p
 l5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=srAo9cELKNxJLe7H5Kb1ku6pI8RUGetGR66tpA6jg7k=;
 b=EAcK7dJfwwl0PD7hJyBZ+CnluB7HLeb/+yL4BqM7D78ILqlkJh0y0h7cx+CWpeTWjK
 G+zHAWi0FDvsqp0vcSb1loUlOgmMXa3D6N5qc6uMSLPqlVH7GV73mpXUIrVU8O/xvCYb
 sB+kDfPnt5ZKJPM8J5qsbqAeNkd5ZjfNLhQYX+5j/RtbtxGEOn4o+YziCEIvRybeSetn
 U/owWXSHh6AmNVXR/oWypo+cJ6j/KNG+fcjcc/RSy9EXmLYoF/zdkfnGUXiVRHot2yVd
 CVU6SyOOR4IIeIu/QBol+My8+bXHLCstuHwL7KmaRnu1HxvQ2Pe0IBMUFuesBw3Zi8xg
 2PUg==
X-Gm-Message-State: ANhLgQ0mWtREulZtea/MfZvjatY2H9vfwPwSfcjK1ebCIzXK1lbemKt7
 eQWH3w3gvNz1V0TyWGGf7e8c0ujCoNI=
X-Google-Smtp-Source: ADFU+vvQArjjvwnLv1MKg9zJBc8sCgWO8rw42WfZdM7CVp4CxttBS/DqDYuTj1AOR9ge9aGkXMBOQQ==
X-Received: by 2002:a63:4864:: with SMTP id x36mr607079pgk.398.1584471618053; 
 Tue, 17 Mar 2020 12:00:18 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y13sm3738411pfp.88.2020.03.17.12.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:00:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] tcg: Remove CONFIG_VECTOR16
Date: Tue, 17 Mar 2020 12:00:10 -0700
Message-Id: <20200317190013.25036-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317190013.25036-1-richard.henderson@linaro.org>
References: <20200317190013.25036-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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

The comment in tcg-runtime-gvec.c about CONFIG_VECTOR16 says that
tcg-op-gvec.c has eliminated size 8 vectors, and only passes on
multiples of 16.  This may have been true of the first few operations,
but is not true of all operations.

In particular, multiply, shift by scalar, and compare of 8- and 16-bit
elements are not expanded inline if host vector operations are not
supported.

For an x86_64 host that does not support AVX, this means that we will
fall back to the helper, which will attempt to use SSE instructions,
which will SEGV on an invalid 8-byte aligned memory operation.

This patch simply removes the CONFIG_VECTOR16 code and configuration
without further simplification.

Buglink: https://bugs.launchpad.net/bugs/1863508
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure                    | 56 ------------------------------------
 accel/tcg/tcg-runtime-gvec.c | 35 +---------------------
 2 files changed, 1 insertion(+), 90 deletions(-)

diff --git a/configure b/configure
index eb49bb6680..47b8dea78a 100755
--- a/configure
+++ b/configure
@@ -5711,58 +5711,6 @@ if  test "$plugins" = "yes" &&
       "for this purpose. You can't build with --static."
 fi
 
-########################################
-# See if 16-byte vector operations are supported.
-# Even without a vector unit the compiler may expand these.
-# There is a bug in old GCC for PPC that crashes here.
-# Unfortunately it's the system compiler for Centos 7.
-
-cat > $TMPC << EOF
-typedef unsigned char U1 __attribute__((vector_size(16)));
-typedef unsigned short U2 __attribute__((vector_size(16)));
-typedef unsigned int U4 __attribute__((vector_size(16)));
-typedef unsigned long long U8 __attribute__((vector_size(16)));
-typedef signed char S1 __attribute__((vector_size(16)));
-typedef signed short S2 __attribute__((vector_size(16)));
-typedef signed int S4 __attribute__((vector_size(16)));
-typedef signed long long S8 __attribute__((vector_size(16)));
-static U1 a1, b1;
-static U2 a2, b2;
-static U4 a4, b4;
-static U8 a8, b8;
-static S1 c1;
-static S2 c2;
-static S4 c4;
-static S8 c8;
-static int i;
-void helper(void *d, void *a, int shift, int i);
-void helper(void *d, void *a, int shift, int i)
-{
-  *(U1 *)(d + i) = *(U1 *)(a + i) << shift;
-  *(U2 *)(d + i) = *(U2 *)(a + i) << shift;
-  *(U4 *)(d + i) = *(U4 *)(a + i) << shift;
-  *(U8 *)(d + i) = *(U8 *)(a + i) << shift;
-}
-int main(void)
-{
-  a1 += b1; a2 += b2; a4 += b4; a8 += b8;
-  a1 -= b1; a2 -= b2; a4 -= b4; a8 -= b8;
-  a1 *= b1; a2 *= b2; a4 *= b4; a8 *= b8;
-  a1 &= b1; a2 &= b2; a4 &= b4; a8 &= b8;
-  a1 |= b1; a2 |= b2; a4 |= b4; a8 |= b8;
-  a1 ^= b1; a2 ^= b2; a4 ^= b4; a8 ^= b8;
-  a1 <<= i; a2 <<= i; a4 <<= i; a8 <<= i;
-  a1 >>= i; a2 >>= i; a4 >>= i; a8 >>= i;
-  c1 >>= i; c2 >>= i; c4 >>= i; c8 >>= i;
-  return 0;
-}
-EOF
-
-vector16=no
-if compile_prog "" "" ; then
-  vector16=yes
-fi
-
 ########################################
 # See if __attribute__((alias)) is supported.
 # This false for Xcode 9, but has been remedied for Xcode 10.
@@ -7383,10 +7331,6 @@ if test "$atomic64" = "yes" ; then
   echo "CONFIG_ATOMIC64=y" >> $config_host_mak
 fi
 
-if test "$vector16" = "yes" ; then
-  echo "CONFIG_VECTOR16=y" >> $config_host_mak
-fi
-
 if test "$attralias" = "yes" ; then
   echo "CONFIG_ATTRIBUTE_ALIAS=y" >> $config_host_mak
 fi
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 5b1902d591..00da0938a5 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -24,32 +24,6 @@
 #include "tcg/tcg-gvec-desc.h"
 
 
-/* Virtually all hosts support 16-byte vectors.  Those that don't can emulate
- * them via GCC's generic vector extension.  This turns out to be simpler and
- * more reliable than getting the compiler to autovectorize.
- *
- * In tcg-op-gvec.c, we asserted that both the size and alignment of the data
- * are multiples of 16.
- *
- * When the compiler does not support all of the operations we require, the
- * loops are written so that we can always fall back on the base types.
- */
-#ifdef CONFIG_VECTOR16
-typedef uint8_t vec8 __attribute__((vector_size(16)));
-typedef uint16_t vec16 __attribute__((vector_size(16)));
-typedef uint32_t vec32 __attribute__((vector_size(16)));
-typedef uint64_t vec64 __attribute__((vector_size(16)));
-
-typedef int8_t svec8 __attribute__((vector_size(16)));
-typedef int16_t svec16 __attribute__((vector_size(16)));
-typedef int32_t svec32 __attribute__((vector_size(16)));
-typedef int64_t svec64 __attribute__((vector_size(16)));
-
-#define DUP16(X)  { X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X }
-#define DUP8(X)   { X, X, X, X, X, X, X, X }
-#define DUP4(X)   { X, X, X, X }
-#define DUP2(X)   { X, X }
-#else
 typedef uint8_t vec8;
 typedef uint16_t vec16;
 typedef uint32_t vec32;
@@ -64,7 +38,6 @@ typedef int64_t svec64;
 #define DUP8(X)   X
 #define DUP4(X)   X
 #define DUP2(X)   X
-#endif /* CONFIG_VECTOR16 */
 
 static inline void clear_high(void *d, intptr_t oprsz, uint32_t desc)
 {
@@ -917,13 +890,7 @@ void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
-/* If vectors are enabled, the compiler fills in -1 for true.
-   Otherwise, we must take care of this by hand.  */
-#ifdef CONFIG_VECTOR16
-# define DO_CMP0(X)  X
-#else
-# define DO_CMP0(X)  -(X)
-#endif
+#define DO_CMP0(X)  -(X)
 
 #define DO_CMP1(NAME, TYPE, OP)                                            \
 void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                \
-- 
2.20.1


