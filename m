Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A05BCA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699B721929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDvByOEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699B721929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtoF-0000m5-Bf
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN8-00088U-EZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-0003Hi-TN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN4-0003BK-OC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id l10so956757wrb.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BlVPTXUE+8KwJhfzqDWAcBn9rcfGn0EwpwkN7L2kZ/g=;
 b=uDvByOEMTl6kPqlyoTri2+TmxebnUuDxLWSWe9MnIAD9cB+JwOIrirHuFRLso4i4MX
 507f9CSE7D8Sueue4ZmRslr+dPgZlQlsxjzM3dKbMxAH3Eq+Bj8g8NbzH8EzqRvS4ckf
 VYN0xLrGDNUsRr/zeXKereJn2c8HIDiAzjIbyMxmEFc0MefxqdXcixSV3Moxa8HjXWHj
 cPJYif3huJpOW4+Sc2989dGzD0tcVkCkSzehnXKp1pUeTyPuEYgnNR0Dn1m2IRKjMs13
 rNPAq992j9qUDp339OVfo74dN0j0yQf/bWwT5+k6X6xddK6l4s9xATBvWZ/e/g+wNnHD
 +lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BlVPTXUE+8KwJhfzqDWAcBn9rcfGn0EwpwkN7L2kZ/g=;
 b=DCu8v5kqrEpf17No2bjddvystQju/hcr6XvfBsGtXYjAWAXQ1t/lYVTlJQVjrrEtan
 NMkzJgEQctDwe9Mif/+y8a4S1GQVFq/kCJbDr3nFfNJVdvlxjWJ1KS9fVVGkBxl9DnQi
 0Ha5ffyWjJe7bNTsQR2aFoI/HRRQ63w1fruha4ZIIY/qMhrQop/QXoV1KzPVga9c0O0h
 VkB19A5Aa+gy4dPbxGCXsfnQaSyDzRtDyPZE0MpZEQeQ9jFFAniuBD985P+QQev2MFOk
 nLTc37oRwShXgE4LGH+aPEi/5PqJh8WagTqDkA3rak2xQK3dO4CaFLh9lQ6LN1lvAaHM
 3G8w==
X-Gm-Message-State: APjAAAWSNpdvF9vdHpyfbTBBul84/hK6aRVq8AaFO5Sq+6kxqeyvDWNy
 Oz2j41COIn1axjTxur+cjB5TIA==
X-Google-Smtp-Source: APXvYqyQ6dQfpwWbDXtjGSwpMfKy2FWLqOl0yPNE3bA6lO7yGHCLGJCkAA24JGAi1slOHpQnuAZBCg==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr1308685wrv.5.1571986001590;
 Thu, 24 Oct 2019 23:46:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c189sm1241767wme.24.2019.10.24.23.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 671411FF87;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 38/73] cputlb: ensure _cmmu helper functions follow the
 naming standard
Date: Fri, 25 Oct 2019 07:36:38 +0100
Message-Id: <20191025063713.23374-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We document this in docs/devel/load-stores.rst so lets follow it. The
32 bit and 64 bit access functions have historically not included the
sign so we leave those as is. We also introduce some signed helpers
which are used for loading immediate values in the translator.

Fixes: 282dffc8
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191021150910.23216-1-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2c06b57272e..c7a986d7cb2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1920,12 +1920,18 @@ static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
     return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
 }
 
-uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
+uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return full_ldub_cmmu(env, addr, oi, retaddr);
 }
 
+int8_t helper_ret_ldsb_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int8_t) full_ldub_cmmu(env, addr, oi, retaddr);
+}
+
 static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
@@ -1933,12 +1939,18 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                        full_le_lduw_cmmu);
 }
 
-uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
+uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return full_le_lduw_cmmu(env, addr, oi, retaddr);
 }
 
+int16_t helper_le_ldsw_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int16_t) full_le_lduw_cmmu(env, addr, oi, retaddr);
+}
+
 static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
@@ -1946,12 +1958,18 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                        full_be_lduw_cmmu);
 }
 
-uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
+uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return full_be_lduw_cmmu(env, addr, oi, retaddr);
 }
 
+int16_t helper_be_ldsw_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int16_t) full_be_lduw_cmmu(env, addr, oi, retaddr);
+}
+
 static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 6f0d3407979..54b5e858cee 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -66,8 +66,8 @@
 #ifdef SOFTMMU_CODE_ACCESS
 #define ADDR_READ addr_code
 #define MMUSUFFIX _cmmu
-#define URETSUFFIX SUFFIX
-#define SRETSUFFIX SUFFIX
+#define URETSUFFIX USUFFIX
+#define SRETSUFFIX glue(s, SUFFIX)
 #else
 #define ADDR_READ addr_read
 #define MMUSUFFIX _mmu
diff --git a/target/cris/translate_v10.inc.c b/target/cris/translate_v10.inc.c
index a87b8bb2813..ae34a0d1a3d 100644
--- a/target/cris/translate_v10.inc.c
+++ b/target/cris/translate_v10.inc.c
@@ -1202,8 +1202,7 @@ static unsigned int dec10_ind(CPUCRISState *env, DisasContext *dc)
         case CRISV10_IND_BCC_M:
 
             cris_cc_mask(dc, 0);
-            imm = cpu_ldsw_code(env, dc->pc + 2);
-            simm = (int16_t)imm;
+            simm = cpu_ldsw_code(env, dc->pc + 2);
             simm += 4;
 
             LOG_DIS("bcc_m: b%s %x\n", cc_name(dc->cond), dc->pc + simm);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a38659ea5b3..92ca10dffc1 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1290,16 +1290,22 @@ void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
 void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr);
 
-uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
+uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
-uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
+int8_t helper_ret_ldsb_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
+uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr);
+int16_t helper_le_ldsw_cmmu(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr);
 uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
 uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
-uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
+uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr);
+int16_t helper_be_ldsw_cmmu(CPUArchState *env, target_ulong addr,
+                             TCGMemOpIdx oi, uintptr_t retaddr);
 uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr);
 uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
@@ -1316,7 +1322,8 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_be_stw_mmu
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
-# define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
+# define helper_ret_lduw_cmmu  helper_be_lduw_cmmu
+# define helper_ret_ldsw_cmmu  helper_be_ldsw_cmmu
 # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
@@ -1329,7 +1336,8 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_le_stw_mmu
 # define helper_ret_stl_mmu   helper_le_stl_mmu
 # define helper_ret_stq_mmu   helper_le_stq_mmu
-# define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
+# define helper_ret_lduw_cmmu  helper_le_lduw_cmmu
+# define helper_ret_ldsw_cmmu  helper_le_ldsw_cmmu
 # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
 #endif
-- 
2.20.1


