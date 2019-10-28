Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B87CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6396C21479
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0j6vHdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6396C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6YK-0002iF-Sl
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uh-0007T0-JJ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Ug-000429-23
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Uf-00041k-R9
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id c22so9489272wmd.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5E3h/dy52NEcLnrR3FCotEmib1HNDwVjiquxqJLNR8c=;
 b=V0j6vHdz1BfMFf6G4oHt2pwyscFekHHXpIV699pRmBWlm82pbJK5oqaempcqH5DDIS
 Exb/Hgr3aRJm6UOHIJ+gwgdMJdS86bHeZdjDiac3n3sN+TUu+7gQ2hhl7iwiAc/q8+0D
 SXdyavjpxJ5UBEBsIbFM7OLJg567qpzb20iqHNfVLwllNp18fu3qOJfkDJ8pTfsAL/Mh
 ves/mQ7KqD/XVEIhO6HicyIYEU/FEEHnDGiauaSO8gJBc32Yx6vVbypA0nFx++KiCSuv
 gSw/PSETmIv1QkW0WKihMj/Um+VoW8Xblgxb+ctc16P+edVAy2E+neXCRN2LX1zUSWeq
 gVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5E3h/dy52NEcLnrR3FCotEmib1HNDwVjiquxqJLNR8c=;
 b=DjCb9VgUgGFJo+7QXRDxNUgyylWHbrwe81UMbrhuDW6nAMwrBDqwMq9yUmBeL1a8Xw
 SOhENYS+xpZ91mtO8qHpkjvgJ6QrtvJgiwbK2w9mWxW3nFjaUpEpmfVojU5GHGav5wLH
 jHapUgHQw8eq4MncOpebtgBmMQhZdFlznKSU8wh2uVqrEwV0Y/dZHq70yDZhwE0WuLeg
 SZ4UBga3l/ph1OLpAwSPq76EAuCeqKqLQikUfzW9dBGWN8Yn4UOqkoDgIwH37/VYc3Sr
 RMs4C2+YxnCKCBjj4oPMbiexsF2AZI718YXY5ufAgkBmaRSBVAhDsD4c81h8lj9LuzU0
 MwBg==
X-Gm-Message-State: APjAAAU8SvtJQmtIS5cx1+US8Y2dvEFcUOw4sB9qJaYMLccZkE8kS8qP
 UEsei0XRydaa99vlf6EqVPIvkuwvcX9OKA==
X-Google-Smtp-Source: APXvYqypq0KNKg9NSDXnCCD1AzygQdUwKY3d9Fpb9NWT6cxGkcbqfuTQTbJq/rOq6x5dDyZ73njRqQ==
X-Received: by 2002:a1c:d8:: with SMTP id 207mr347369wma.65.1572274780463;
 Mon, 28 Oct 2019 07:59:40 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/12] cputlb: ensure _cmmu helper functions follow the
 naming standard
Date: Mon, 28 Oct 2019 15:59:27 +0100
Message-Id: <20191028145937.10914-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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


