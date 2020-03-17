Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4627C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64EC206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tA0acGAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64EC206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHWJ-0003hb-Q8
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRy-0007HP-2X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRu-0004Zk-Hk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:25 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:45887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEHRu-0004Sc-7Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:22 -0400
Received: by mail-pg1-x52e.google.com with SMTP id m15so12221673pgv.12
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h/76PH06t0mXHUL5htC0/3FgylJQLrJdEWB57W9ivFQ=;
 b=tA0acGAHHErT2qhRMsgi3Ht5NqP2N/p5BkNjbqDBLWeBElmWhT0XyNJZq9U+EgaKkl
 fDEMHselZ3Dx4CrOJAtjW43T9fdX8ytIuTz4OlJ2CxxAVKEtq8xcKnPDisQtmlaHk7xL
 VNbo1NxAbziwfFaA+SeyuZeZYtn0dLuwu3q3vCNo4C6jy8SqAOCA6CFtoh0opF3dL94h
 HLI9GShox9JT/Xzbou96BCFRXnprsvQAmi8W06VvOzHb3nhuztA//pxpyNrpqy2oazB9
 BAFS5NNSTE4vCS0pZXmzXjx4jdPFAq/mM5gobBfRyucPK9W8OkTdjISA9u6XXvqHB2nA
 xPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h/76PH06t0mXHUL5htC0/3FgylJQLrJdEWB57W9ivFQ=;
 b=ML33p1YIo/BaVIsIGFTFbUROI2V42FB0YexDFoct5NrK9Axm+OvNHG0OHLQ38s1sdz
 V63ZeFPO/HKWoa2AQpdG/JUqzu9DZXYCj/PyhfhQImDJnl5NiohXdWCj/K3JUsomjBme
 /2mp4HROMfHaP4EWRld6EVD9Ir8R0dIE1AiLrOoRKUOCk10mTH5IT0fcyHvaYNO9Dgcy
 SlGryFgD5opeeAoEIBhc7q2DEYzU371OrREP13sS6uLSLlnun9Q23smYayx4MF/4xJLE
 9D37dA8GPftmpf2wvPtQRv7RptJG9J+9WUKWWOzGrRB3nrbzXfdlQjiT0kYVhXBJOuGI
 2Scw==
X-Gm-Message-State: ANhLgQ1lFA8ZlpcW4PKkMUaH6yV2pDVIKZ+rAvFX43dg81ydaAdyoQrq
 8VQd8pXx+j9H3a+BMrjRzQJ2S5c0TDo=
X-Google-Smtp-Source: ADFU+vspFdKBeTP6G2R6Y6/MYuDtz2bR0OJnVMQGf+H3y6ULqbIGm2PaXuKCkxveFMotE7CbUNSILw==
X-Received: by 2002:aa7:9471:: with SMTP id t17mr201818pfq.272.1584471619806; 
 Tue, 17 Mar 2020 12:00:19 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y13sm3738411pfp.88.2020.03.17.12.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:00:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] tcg: Tidy tcg-runtime-gvec.c types
Date: Tue, 17 Mar 2020 12:00:11 -0700
Message-Id: <20200317190013.25036-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317190013.25036-1-richard.henderson@linaro.org>
References: <20200317190013.25036-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Partial cleanup from the CONFIG_VECTOR16 removal.
Replace the vec* types with their scalar expansions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 270 +++++++++++++++++------------------
 1 file changed, 130 insertions(+), 140 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 00da0938a5..97852b515b 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -24,16 +24,6 @@
 #include "tcg/tcg-gvec-desc.h"
 
 
-typedef uint8_t vec8;
-typedef uint16_t vec16;
-typedef uint32_t vec32;
-typedef uint64_t vec64;
-
-typedef int8_t svec8;
-typedef int16_t svec16;
-typedef int32_t svec32;
-typedef int64_t svec64;
-
 #define DUP16(X)  X
 #define DUP8(X)   X
 #define DUP4(X)   X
@@ -56,8 +46,8 @@ void HELPER(gvec_add8)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) + *(vec8 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) + *(uint8_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -67,8 +57,8 @@ void HELPER(gvec_add16)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) + *(vec16 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) + *(uint16_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -78,8 +68,8 @@ void HELPER(gvec_add32)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) + *(vec32 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) + *(uint32_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -89,8 +79,8 @@ void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) + *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) + *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -98,11 +88,11 @@ void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_adds8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec8 vecb = (vec8)DUP16(b);
+    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) + vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) + vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -110,11 +100,11 @@ void HELPER(gvec_adds8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec16 vecb = (vec16)DUP8(b);
+    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) + vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) + vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -122,11 +112,11 @@ void HELPER(gvec_adds16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec32 vecb = (vec32)DUP4(b);
+    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) + vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) + vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -134,11 +124,11 @@ void HELPER(gvec_adds32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_adds64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) + vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) + vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -148,8 +138,8 @@ void HELPER(gvec_sub8)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) - *(vec8 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) - *(uint8_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -159,8 +149,8 @@ void HELPER(gvec_sub16)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) - *(vec16 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) - *(uint16_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -170,8 +160,8 @@ void HELPER(gvec_sub32)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) - *(vec32 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) - *(uint32_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -181,8 +171,8 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) - *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) - *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -190,11 +180,11 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec8 vecb = (vec8)DUP16(b);
+    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) - vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) - vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -202,11 +192,11 @@ void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec16 vecb = (vec16)DUP8(b);
+    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) - vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) - vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -214,11 +204,11 @@ void HELPER(gvec_subs16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec32 vecb = (vec32)DUP4(b);
+    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) - vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) - vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -226,11 +216,11 @@ void HELPER(gvec_subs32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_subs64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) - vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) - vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -240,8 +230,8 @@ void HELPER(gvec_mul8)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) * *(vec8 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) * *(uint8_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -251,8 +241,8 @@ void HELPER(gvec_mul16)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) * *(vec16 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) * *(uint16_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -262,8 +252,8 @@ void HELPER(gvec_mul32)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) * *(vec32 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) * *(uint32_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -273,8 +263,8 @@ void HELPER(gvec_mul64)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) * *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) * *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -282,11 +272,11 @@ void HELPER(gvec_mul64)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_muls8)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec8 vecb = (vec8)DUP16(b);
+    uint8_t vecb = (uint8_t)DUP16(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) * vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) * vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -294,11 +284,11 @@ void HELPER(gvec_muls8)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls16)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec16 vecb = (vec16)DUP8(b);
+    uint16_t vecb = (uint16_t)DUP8(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) * vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) * vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -306,11 +296,11 @@ void HELPER(gvec_muls16)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls32)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec32 vecb = (vec32)DUP4(b);
+    uint32_t vecb = (uint32_t)DUP4(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) * vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) * vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -318,11 +308,11 @@ void HELPER(gvec_muls32)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_muls64)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) * vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) * vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -332,8 +322,8 @@ void HELPER(gvec_neg8)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = -*(vec8 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = -*(uint8_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -343,8 +333,8 @@ void HELPER(gvec_neg16)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = -*(vec16 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = -*(uint16_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -354,8 +344,8 @@ void HELPER(gvec_neg32)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = -*(vec32 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = -*(uint32_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -365,8 +355,8 @@ void HELPER(gvec_neg64)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = -*(vec64 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = -*(uint64_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -472,8 +462,8 @@ void HELPER(gvec_not)(void *d, void *a, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = ~*(vec64 *)(a + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = ~*(uint64_t *)(a + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -483,8 +473,8 @@ void HELPER(gvec_and)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) & *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) & *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -494,8 +484,8 @@ void HELPER(gvec_or)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) | *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) | *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -505,8 +495,8 @@ void HELPER(gvec_xor)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) ^ *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) ^ *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -516,8 +506,8 @@ void HELPER(gvec_andc)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) &~ *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) &~ *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -527,8 +517,8 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) |~ *(vec64 *)(b + i);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) |~ *(uint64_t *)(b + i);
     }
     clear_high(d, oprsz, desc);
 }
@@ -538,8 +528,8 @@ void HELPER(gvec_nand)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) & *(vec64 *)(b + i));
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = ~(*(uint64_t *)(a + i) & *(uint64_t *)(b + i));
     }
     clear_high(d, oprsz, desc);
 }
@@ -549,8 +539,8 @@ void HELPER(gvec_nor)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) | *(vec64 *)(b + i));
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = ~(*(uint64_t *)(a + i) | *(uint64_t *)(b + i));
     }
     clear_high(d, oprsz, desc);
 }
@@ -560,8 +550,8 @@ void HELPER(gvec_eqv)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = ~(*(vec64 *)(a + i) ^ *(vec64 *)(b + i));
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = ~(*(uint64_t *)(a + i) ^ *(uint64_t *)(b + i));
     }
     clear_high(d, oprsz, desc);
 }
@@ -569,11 +559,11 @@ void HELPER(gvec_eqv)(void *d, void *a, void *b, uint32_t desc)
 void HELPER(gvec_ands)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) & vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) & vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -581,11 +571,11 @@ void HELPER(gvec_ands)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_xors)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) ^ vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) ^ vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -593,11 +583,11 @@ void HELPER(gvec_xors)(void *d, void *a, uint64_t b, uint32_t desc)
 void HELPER(gvec_ors)(void *d, void *a, uint64_t b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
-    vec64 vecb = (vec64)DUP2(b);
+    uint64_t vecb = (uint64_t)DUP2(b);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) | vecb;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) | vecb;
     }
     clear_high(d, oprsz, desc);
 }
@@ -608,8 +598,8 @@ void HELPER(gvec_shl8i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) << shift;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) << shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -620,8 +610,8 @@ void HELPER(gvec_shl16i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) << shift;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) << shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -632,8 +622,8 @@ void HELPER(gvec_shl32i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) << shift;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) << shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -644,8 +634,8 @@ void HELPER(gvec_shl64i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) << shift;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) << shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -656,8 +646,8 @@ void HELPER(gvec_shr8i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(vec8 *)(d + i) = *(vec8 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -668,8 +658,8 @@ void HELPER(gvec_shr16i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(vec16 *)(d + i) = *(vec16 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -680,8 +670,8 @@ void HELPER(gvec_shr32i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(vec32 *)(d + i) = *(vec32 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -692,8 +682,8 @@ void HELPER(gvec_shr64i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(vec64 *)(d + i) = *(vec64 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -704,8 +694,8 @@ void HELPER(gvec_sar8i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
-        *(svec8 *)(d + i) = *(svec8 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(int8_t *)(d + i) = *(int8_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -716,8 +706,8 @@ void HELPER(gvec_sar16i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec16)) {
-        *(svec16 *)(d + i) = *(svec16 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(int16_t *)(d + i) = *(int16_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -728,8 +718,8 @@ void HELPER(gvec_sar32i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
-        *(svec32 *)(d + i) = *(svec32 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(int32_t *)(d + i) = *(int32_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -740,8 +730,8 @@ void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
     int shift = simd_data(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        *(svec64 *)(d + i) = *(svec64 *)(a + i) >> shift;
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(int64_t *)(d + i) = *(int64_t *)(a + i) >> shift;
     }
     clear_high(d, oprsz, desc);
 }
@@ -904,12 +894,12 @@ void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                \
 }
 
 #define DO_CMP2(SZ) \
-    DO_CMP1(gvec_eq##SZ, vec##SZ, ==)    \
-    DO_CMP1(gvec_ne##SZ, vec##SZ, !=)    \
-    DO_CMP1(gvec_lt##SZ, svec##SZ, <)    \
-    DO_CMP1(gvec_le##SZ, svec##SZ, <=)   \
-    DO_CMP1(gvec_ltu##SZ, vec##SZ, <)    \
-    DO_CMP1(gvec_leu##SZ, vec##SZ, <=)
+    DO_CMP1(gvec_eq##SZ, uint##SZ##_t, ==)    \
+    DO_CMP1(gvec_ne##SZ, uint##SZ##_t, !=)    \
+    DO_CMP1(gvec_lt##SZ, int##SZ##_t, <)      \
+    DO_CMP1(gvec_le##SZ, int##SZ##_t, <=)     \
+    DO_CMP1(gvec_ltu##SZ, uint##SZ##_t, <)    \
+    DO_CMP1(gvec_leu##SZ, uint##SZ##_t, <=)
 
 DO_CMP2(8)
 DO_CMP2(16)
@@ -1417,11 +1407,11 @@ void HELPER(gvec_bitsel)(void *d, void *a, void *b, void *c, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
-        vec64 aa = *(vec64 *)(a + i);
-        vec64 bb = *(vec64 *)(b + i);
-        vec64 cc = *(vec64 *)(c + i);
-        *(vec64 *)(d + i) = (bb & aa) | (cc & ~aa);
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint64_t aa = *(uint64_t *)(a + i);
+        uint64_t bb = *(uint64_t *)(b + i);
+        uint64_t cc = *(uint64_t *)(c + i);
+        *(uint64_t *)(d + i) = (bb & aa) | (cc & ~aa);
     }
     clear_high(d, oprsz, desc);
 }
-- 
2.20.1


