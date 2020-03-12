Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E0BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8998020637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7WAjdqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8998020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTvj-000208-Mt
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjZ-0006VR-Dn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjY-0002Lb-7g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:09 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjY-0002L1-1e
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:08 -0400
Received: by mail-pg1-x543.google.com with SMTP id m15so3556049pgv.12
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6fjfG7LN06yH+pNuquMUhvUVJ8pyrVs4uGZznYaGBxE=;
 b=w7WAjdqm2IUPa54aUDMzrWvOUWnadKKNZ8zE/Wu55e9dow8az+53kEZml1xoogi3aK
 wdIA9mkwxqtHeN891u8Ilqqk2zevxXmKyXYLCTS3jfbPuR73/qcs4D8umBD7IR3jF47t
 tvIoKNiXsK7SWqpAS7RStxJLcYJD8gzCzPZJTd/Mjct9Nchz3FPtjzpquOzwqUNCGnrG
 MHjNE52OjeBKr8LVG3O+VapEURoY99G3PeKTsRtii1qDtEuBrmTJq3UAE9//7HNXNxv9
 PG87InYvMWZreqbISqdex9pTokXRnorqDcbP7UEzukpsgQhX558jUb4C8pmWVMpdFlqj
 1i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6fjfG7LN06yH+pNuquMUhvUVJ8pyrVs4uGZznYaGBxE=;
 b=GEQnCN+2QNjT7CWbcaSaOLInvAVBgIvE01CjWN0d4SEoiIxfEPEzbA7y+AkUv4zE9j
 f/e2KbqDSoc2addNigKe3v50YldpehZNBoqtCQUNRpWQYnGVX1wOn/Jh3GLtpmilwQ7N
 pw/lk02EvMha2CEtzKlK/C3IWdNkJbCOSOOyWmscshtKJM7N9XTrErKb5wCdWrEP7yKP
 lmr81J66VGoqMtd/z2mBXVBKMdDH3iDyHv1GJQIbtcopJ1iM+ZPy5kQGLMBcrK5FCewi
 MA2HQ9k+CQa94NoNaH42MTbzp6S2c+xz5K4VTsR65QrjolU2rAMXPgBoqq1TwwotO5K7
 KUsA==
X-Gm-Message-State: ANhLgQ0R5ArrPl8Vt8nnKSUDDSAydz+7+eQhEIY/Y7ES6q8IXfyAi0/a
 b1srW4OFIRsvUJXciiPtYA4gEKLJeOk=
X-Google-Smtp-Source: ADFU+vsDnHH/9gAegEsN1OI3RsAD0l6lzGLQ8QeM6tbZzGYOllgrqNiUEbLh2NmDXNFE2nRAA/+Fqg==
X-Received: by 2002:a62:7c82:: with SMTP id x124mr1497509pfc.280.1584042186745; 
 Thu, 12 Mar 2020 12:43:06 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 34/42] target/arm: Handle TBI for sve scalar + int memory
 ops
Date: Thu, 12 Mar 2020 12:42:11 -0700
Message-Id: <20200312194219.24406-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We still need to handle tbi for user-only when mte is inactive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h | 1 +
 target/arm/translate-a64.c | 2 +-
 target/arm/translate-sve.c | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 452b4764d0..65c0280498 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -40,6 +40,7 @@ TCGv_ptr get_fpstatus_ptr(bool);
 bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
                             unsigned int imms, unsigned int immr);
 bool sve_access_check(DisasContext *s);
+TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr);
 TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int log2_size);
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d86c13a32d..1314b200e0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -232,7 +232,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
  * of the write-back address.
  */
 
-static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
+TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
 {
     TCGv_i64 clean = new_tmp_a64(s);
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5b399bb005..ce67b79b02 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4554,9 +4554,8 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
      * For e.g. LD4, there are not enough arguments to pass all 4
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
-     * TODO: mte_n check here while callers are updated.
      */
-    if (mte_n && s->mte_active[0]) {
+    if (s->mte_active[0]) {
         int msz = dtype_msz(dtype);
 
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
@@ -4566,7 +4565,10 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
         desc = FIELD_DP32(desc, MTEDESC, TSIZE, mte_n << msz);
         desc <<= SVE_MTEDESC_SHIFT;
+    } else {
+        addr = clean_data_tbi(s, addr);
     }
+
     desc = simd_desc(vsz, vsz, zt | desc);
     t_desc = tcg_const_i32(desc);
     t_pg = tcg_temp_new_ptr();
-- 
2.20.1


