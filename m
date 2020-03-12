Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7429C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857AA205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUjas1Lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857AA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU30-0006Jy-Nj
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjc-0006fv-JK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjb-0002NO-5C
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:12 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:37225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTja-0002Mr-Uq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:11 -0400
Received: by mail-pj1-x1031.google.com with SMTP id ca13so3080661pjb.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gnv7Nm+EiE7Yup2Obmp1aYhEBmLkRamccQdcwDUw4Ic=;
 b=OUjas1Lpm5ElFi3Oe3+IXmX7PzF7P/I8eW0eXP2SdL3grVqNSRT1yDGJWGRHTT7b0W
 1uqI2v+Bbxec0Uww9RPPi3XdM6TxvOwXctChC3fsJFIYUbPcccgUrq7YduSzJTOJfgdq
 N4DLwi4zRobc3pdZiJma0l8c2TayxOtZ83BjfUNvaxvkiOgBLjM+uvZpAirKKhIcW2vr
 C6u1OdaaEtz7J1+N+EbwMVydYXftFK0W5fYpT/0Wp8CaP4fnEJkgROhT8zLw6JpQZJ+j
 fpS0uMxAOY71cUNC0x1Js3DsR18UMImVEXfCxwCT+9IKpNbGVWPfEcU6Tr9PdLXeN24n
 UK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gnv7Nm+EiE7Yup2Obmp1aYhEBmLkRamccQdcwDUw4Ic=;
 b=bRMhdQjwB7da8YS7Y6KuYJykScczyjXG32nlYZgegwIfpxySM8h5zc3wwSxamu82bP
 N96N+8tL5EL5+AEwceVkod76APU3Soyp7iCXgo03+lETSlH5HdOh2cABw7fo61b0naVY
 CtfTJy1JODRTdbjTRm6OsFgnJ4iE02VMKW2np4rqDrgliM7ZScf/NuzhlLg7+HJAtOoH
 mQ26OD/EHOr2lSQwC1/sjdeJ5eOu71FkDdgmzDwK/44Z63pM7Wq1siWXm45rseQmW0U4
 3Fci3K/IoH0hVnm4W49EtMdrMVcWggtPCIHh6og8T3jo73byDaXMo3g7kY3k8/i8eXwQ
 MKaw==
X-Gm-Message-State: ANhLgQ2v6DG95vZ9Ajg/OcPDp2SpnXq5aJidtblKHnqxRyQvJl1qkvIy
 cUbiqgOdoMs9U6KNTLm1VoalXMAvikg=
X-Google-Smtp-Source: ADFU+vvVDQfCs9u6FyL5ll4yBCPcrmV9TDU47yKjZBlap8zIwHf04e13ln6nakD5lDcXT2VsSSpr4A==
X-Received: by 2002:a17:902:728d:: with SMTP id
 d13mr9450869pll.92.1584042189569; 
 Thu, 12 Mar 2020 12:43:09 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 36/42] target/arm: Complete TBI clearing for user-only for
 SVE
Date: Thu, 12 Mar 2020 12:42:13 -0700
Message-Id: <20200312194219.24406-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1031
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are a number of paths by which the TBI is still intact
for user-only in the SVE helpers.

Because we currently always set TBI for user-only, we do not
need to pass down the actual TBI setting from above, and we
can remove the top byte in the inner-most primitives, so that
none are forgotten.  Moreover, this keeps the "dirty" pointer
around at the higher levels, where we need it for any MTE checking.

Since the normal case, especially for user-only, goes through
RAM, this clearing merely adds two insns per page lookup, which
will be completely in the noise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 566a619300..f0afbd0faf 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3985,7 +3985,7 @@ typedef void sve_ldst1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
  *
  * For *_tlb, this uses the cpu_*_data_ra helpers.  There are not
  * endian-specific versions of these, so we must handle endianness
- * locally.
+ * locally.  See sve_probe_page about TBI.
  *
  * For *_host, this is a trivial application of the <qemu/bswap.h>
  * endian-specific access followed by a store into the vector register.
@@ -4009,7 +4009,7 @@ static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    TYPEM val = BSWAP(TLB(env, addr, ra));                                  \
+    TYPEM val = BSWAP(TLB(env, useronly_clean_ptr(addr), ra));              \
     *(TYPEE *)(vd + H(reg_off)) = val;                                      \
 }
 
@@ -4018,7 +4018,7 @@ static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
 {                                                                           \
     TYPEM val = *(TYPEE *)(vd + H(reg_off));                                \
-    TLB(env, addr, BSWAP(val), ra);                                         \
+    TLB(env, useronly_clean_ptr(addr), BSWAP(val), ra);                     \
 }
 
 #define DO_LD_PRIM_1(NAME, H, TE, TM)                   \
@@ -4152,6 +4152,19 @@ static bool sve_probe_page(SVEHostPage *info, bool nofault,
     int flags;
 
     addr += mem_off;
+
+    /*
+     * User-only currently always issues with TBI.  See the comment
+     * above useronly_clean_ptr.  Usually we clean this top byte away
+     * during translation, but we can't do that for e.g. vector + imm
+     * addressing modes.
+     *
+     * We currently always enable TBI for user-only, and do not provide
+     * a way to turn it off.  So clean the pointer unconditionally here,
+     * rather than look it up here, or pass it down from above.
+     */
+    addr = useronly_clean_ptr(addr);
+
     flags = probe_access_flags(env, addr, access_type, mmu_idx, nofault,
                                &info->host, retaddr);
     info->flags = flags;
-- 
2.20.1


