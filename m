Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB1ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1FB2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufd5x4g0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1FB2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvMH-0000Kc-4T
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvIT-0004Zn-3h
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvIR-0003aX-RC
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:49:32 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:40339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvIR-0003aI-NY
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:49:31 -0400
Received: by mail-yb1-xb42.google.com with SMTP id s7so3115739ybq.7
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DBn82VDoTIkQHKrcIDGuEVCWKjWKbpPGI9lxXV47UXY=;
 b=ufd5x4g0OMzc1f3gjfMgUaDLvB0xHGQQCNgDp3kUD2jk2SX0CGKxt/5v3IoIZqX9Ys
 0TELz48Ia74rWxI3baTtHWmnvDuZ+tFGPi5hNVYSWm266T01VZmxQLGawL20d5HBIYmZ
 Jqxaxag80kZBCQnSl5fAgcApqr3cegWNUEnJUCTJ104M1bJQoF2b0YUVeMTbcgABEfD0
 Ufy7F4NWzpIVcDjLYRNYZrYo37Gxq4J7LnGbKUp8Ke1tmJZKarB0xwvUo+0CL2mdtEnI
 xYkKWk7n4TwsHIDVQffror+eaujZuxeULCMQPRYMHUgpsrFMADafRdkdAnv8417PmOPa
 7vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DBn82VDoTIkQHKrcIDGuEVCWKjWKbpPGI9lxXV47UXY=;
 b=sZKHYRGcq4ytAvOJ6V02dwikbuDb7I8MCLmnD8s9Zq9FSqxfxRLDSuglRza0UA2S4b
 ZaIM1DFLVSIw28KVBuQB+kfBZ/aBa/1NxdRINDBQ8ytaCa8xpZEoAnkiSAndJm1/CsmU
 jMYOmu64ftnS0oGgIr3BXU9ucSXVzAqwqEUvvLTj+6QwWj8F1T+qsV+/a2YFSQRoAXaO
 ikte+gGPU2n2ZIYkvsmcM8zp0jm65lW4I4sUvZtCf3q5Cdy3Q+Y0A37ARWSlIxmaYUzN
 cWwZX0UTEDEghptqqiZejar7/90oPZPGB4To9cHwqSItnT8I6lrLnJ+hqmB9+M48W/Tx
 YY6w==
X-Gm-Message-State: APjAAAVyCvUYWNp/a2kfneB2Y0hyNdy2A3C9CiTAsS/Gmkly8Q/HN6kX
 mHbu4aXHYFYbrWJM1IdscSCNLM+zujI=
X-Google-Smtp-Source: APXvYqxBdn4dOjYy7OFjPx8jM3NqRsFQKlvwibJRqHIb2I2PYUpUo5RehkTDeW3itcAdNFoHsGexDQ==
X-Received: by 2002:a25:cbce:: with SMTP id
 b197mr10024381ybg.355.1570801770705; 
 Fri, 11 Oct 2019 06:49:30 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:49:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/22] target/arm: Implement the IRG instruction
Date: Fri, 11 Oct 2019 09:47:28 -0400
Message-Id: <20191011134744.2477-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Update to 00eac5.
    Merge choose_random_nonexcluded_tag into helper_irg since
    that pseudo function no longer exists separately.
---
 target/arm/helper-a64.h    |  1 +
 target/arm/mte_helper.c    | 57 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  7 +++++
 3 files changed, 65 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a82e21f15a..6ff7f5b756 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -106,3 +106,4 @@ DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(mte_check1, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(mte_check2, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(mte_check3, TCG_CALL_NO_WG, i64, env, i64, i32)
+DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index bbb90cbe86..9848849a91 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -37,6 +37,31 @@ static int allocation_tag_from_addr(uint64_t ptr)
     return extract64(ptr, 56, 4);
 }
 
+static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
+{
+    if (exclude == 0xffff) {
+        return 0;
+    }
+    if (offset == 0) {
+        while (exclude & (1 << tag)) {
+            tag = (tag + 1) & 15;
+        }
+    } else {
+        do {
+            do {
+                tag = (tag + 1) & 15;
+            } while (exclude & (1 << tag));
+        } while (--offset > 0);
+    }
+    return tag;
+}
+
+static uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
+{
+    rtag -= extract64(ptr, 55, 1);
+    return deposit64(ptr, 56, 4, rtag);
+}
+
 /*
  * Perform a checked access for MTE.
  * On arrival, TBI is known to enabled, as is allocation_tag_access_enabled.
@@ -165,3 +190,35 @@ uint64_t HELPER(mte_check3)(CPUARMState *env, uint64_t dirty_ptr, uint32_t tbi)
         return dirty_ptr;
     }
 }
+
+uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag = 0;
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        /*
+         * Our IMPDEF choice for GCR_EL1.RRND==1 is to behave as if
+         * GCR_EL1.RRND==0, always producing deterministic results.
+         */
+        uint16_t exclude = extract32(rm | env->cp15.gcr_el1, 0, 16);
+        int start = extract32(env->cp15.rgsr_el1, 0, 4);
+        int seed = extract32(env->cp15.rgsr_el1, 8, 16);
+        int offset, i;
+
+        /* RandomTag */
+        for (i = offset = 0; i < 4; ++i) {
+            /* NextRandomTagBit */
+            int top = (extract32(seed, 5, 1) ^ extract32(seed, 3, 1) ^
+                       extract32(seed, 2, 1) ^ extract32(seed, 0, 1));
+            seed = (top << 15) | (seed >> 1);
+            offset |= top << i;
+        }
+        rtag = choose_nonexcluded_tag(start, offset, exclude);
+
+        env->cp15.rgsr_el1 = rtag | (seed << 8);
+    }
+
+    return address_with_allocation_tag(rn, rtag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 18d45fba87..83d253d67f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5156,6 +5156,13 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     case 3: /* SDIV */
         handle_div(s, true, sf, rm, rn, rd);
         break;
+    case 4: /* IRG */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        gen_helper_irg(cpu_reg_sp(s, rd), cpu_env,
+                       cpu_reg_sp(s, rn), cpu_reg(s, rm));
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
-- 
2.17.1


