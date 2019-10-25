Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D956CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84D72053B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+NwdlmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84D72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0ht-0000US-UO
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Te-0004yQ-By
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tc-0001as-Te
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:06 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:33134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tc-0001ae-PB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:04 -0400
Received: by mail-qk1-x72e.google.com with SMTP id 71so1928290qkl.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5E3h/dy52NEcLnrR3FCotEmib1HNDwVjiquxqJLNR8c=;
 b=s+NwdlmQOCSVFqOtb5F/TNOhh2w1vt097/7urr/kyXpD3J6cYIqMa6VPrVaqJjE3v2
 trSTMosHIkr0kA2fS+ogsIdeT5nd8+5kzuBfgUt6D0zTWOaMvqt8SAO40nLREgQYiw92
 g/D9hQNsDFBKU02CXLZvSZbiCLjhE4Hej5LZSxnzVtwmiQP6yGBHlMbhnB0p46yUS9Mg
 FYDLxqp8l2dVaFG7joM9DU8usJ1H6cCFNIXeUqxHa00noIMH6jLV4+RarzFXlpO6wLzs
 Z2bKn61sZjdimICIeKOr3SoeHtxWjeucQeye3Scl/4QueTnm5h1N2QO7AAwwYf5M5deb
 Z/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5E3h/dy52NEcLnrR3FCotEmib1HNDwVjiquxqJLNR8c=;
 b=FGM/TYLgNV/Fizm7eJHLenXxzbJRaOjWNe/Dz32+JjnVkrxDowNlAJ9nQFEPwXrD50
 FRk44Pp+s/eSHQwjJZAGhX+xyZkXzWtpz5xvDzlM7yyIAR6VO8fU1h0j+SfhwNBplYgQ
 3MF58bHoRNS+Qyc7htMfH6C1jC0nOHYHSPxGAX792OBYHQqxYA9DxLBsfm9cPyrxTXvo
 eiL0a7SLnsfC0REVl/Tmh5boz/A5qf8aXzYnNoW8w4+wm5g8tk0REwCcXQTiu3WCo7l4
 4i3e6/BLSaCVhP0zEU9dSeuCSnhf48aAEUPLRr7/StdBuxayI0LtnUyEHbPW+H1nHB0t
 4Czg==
X-Gm-Message-State: APjAAAXoZ3ZZPj96+lDanBwVcRgo27FspREo17JuXV369XnMrpYItUXp
 qOeTBue/PLXl6qpc+e8Od3lTlZZzvbA=
X-Google-Smtp-Source: APXvYqxhwL2bHqMk/YUTKlrJYRsujY7ilyyrnEve+QvDx928uWGe7co5k50vgybufizAS3EFParqiQ==
X-Received: by 2002:ae9:ed43:: with SMTP id c64mr145538qkg.274.1572013323748; 
 Fri, 25 Oct 2019 07:22:03 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] cputlb: ensure _cmmu helper functions follow the naming
 standard
Date: Fri, 25 Oct 2019 10:21:49 -0400
Message-Id: <20191025142159.12459-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72e
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

We document this in docs/devel/load-stores.rst so lets follow it. The
32 bit and 64 bit access functions have historically not included the
sign so we leave those as is. We also introduce some signed helpers
which are used for loading immediate values in the translator.

Fixes: 282dffc8
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191021150910.23216-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_template.h |  4 ++--
 tcg/tcg.h                        | 20 ++++++++++++++------
 accel/tcg/cputlb.c               | 24 +++++++++++++++++++++---
 target/cris/translate_v10.inc.c  |  3 +--
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index af7e0b49f2..3d24ed9bd0 100644
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
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a37181c899..2792f65d04 100644
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
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index defc8d5929..6f4194df96 100644
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
diff --git a/target/cris/translate_v10.inc.c b/target/cris/translate_v10.inc.c
index a87b8bb281..ae34a0d1a3 100644
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
-- 
2.17.1


