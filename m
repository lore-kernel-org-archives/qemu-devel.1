Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A09C47E49
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0379620659
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXTzBAEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0379620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZJt-00023R-7U
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMZJA-0001bU-MZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMZJ9-0001TM-9g
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:09:20 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMZJ9-0001Rm-39
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:09:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so13744205wmd.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W6ns/RNFm4lpQPsxZlERGZePuAnYEpgJeue/Le9e7Xk=;
 b=IXTzBAEJQwqM3pPhlTYT212hyw2guS3sa2ThrF+kEk2tRKaLHvWlffbjOWV7wE4Q+0
 x10pzOnA/SUxBsFKJtDAbS7d9WleBv7NycV4U4e4o0IF+QxBH1Y5hl+5sfKVvYO7Xmih
 wG3g2A/ecSOrR+ShWtF5aP2TG1aspmj2GUARClIuntObW539JAGSczrZu71ihHR9yvEc
 UgpTixtioR/YXZnM0REwq0JaQEy5/g9Q2VBUfuVisiXt/qY78y+C+4j7WHgTFrlgeqp6
 rtOMMp+dJFLG5HWeJDOhAq8Qs6BVfwSEnNzo8watlLtCaApA1nu2+u+kxGvuwaUiRc9L
 eiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W6ns/RNFm4lpQPsxZlERGZePuAnYEpgJeue/Le9e7Xk=;
 b=Fe5J3MXsicZ6MPDi/wRedhqeKNv33FIM1n3Y+34/wRRbHgYhHmHZquZkgtMm1A0e0o
 +pvB+P/zypcjiHsUJQeW1zm15tFxJEl+b9iAZ/Wh31R82FoVyKUQMR8vJ/Q05imUle1k
 gaEXDDrpY5HP+aL4S9bRLtLnq6mgxHwNXzcyJYymkWihbDCvBxRbgRqf4RDr5t0kp1GD
 Ffoq6bkDOO7N49DytH+aBvaFJmK1wlLOQ6Vy9A+V+e5Lve9mpovvC0hUw9vWBorfU7t6
 WiJzKbH7C/4acOh8l2gS/P0Fv/wDUzgzZLuvvyuga8rq5Z5BF5zQcK/1o5H6yMk9qkHp
 e+7w==
X-Gm-Message-State: APjAAAW1f51hlwteC5xYY3y1uP4KySPolaC4RGS2Cm6OVohaoWfoSmg1
 hjQXSz1uKU3zAoiF/lrSTbT7Lg==
X-Google-Smtp-Source: APXvYqyseuVx+57D8tvlBUyEUZPKqbiHudQpncSDZTX8Bcq70oeknHkkRZsCw+vA1NDZ7o15Spdxxw==
X-Received: by 2002:a05:600c:114f:: with SMTP id
 z15mr2653120wmz.4.1571670557268; 
 Mon, 21 Oct 2019 08:09:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n17sm3154335wrt.25.2019.10.21.08.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 08:09:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D81EF1FF87;
 Mon, 21 Oct 2019 16:09:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] cputlb: ensure _cmmu helper functions follow the naming
 standard
Date: Mon, 21 Oct 2019 16:09:10 +0100
Message-Id: <20191021150910.23216-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
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

---
v2
  - add signed ldsb and ldsw
---
 accel/tcg/cputlb.c               | 24 +++++++++++++++++++++---
 include/exec/cpu_ldst_template.h |  4 ++--
 target/cris/translate_v10.inc.c  |  3 +--
 tcg/tcg.h                        | 20 ++++++++++++++------
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index defc8d59292..6f4194df96f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1862,12 +1862,18 @@ static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
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
@@ -1875,12 +1881,18 @@ static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
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
@@ -1888,12 +1900,18 @@ static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
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
index af7e0b49f2d..3d24ed9bd0c 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -65,8 +65,8 @@
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
index a37181c8998..2792f65d040 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1269,16 +1269,22 @@ void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
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
@@ -1295,7 +1301,8 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_be_stw_mmu
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
-# define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
+# define helper_ret_lduw_cmmu  helper_be_lduw_cmmu
+# define helper_ret_ldsw_cmmu  helper_be_ldsw_cmmu
 # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
@@ -1308,7 +1315,8 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
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


