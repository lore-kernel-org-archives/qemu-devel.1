Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1B5C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7738206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrzYRDrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7738206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR44t-0007no-1Q
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41b-00025c-FY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41Z-0002cZ-F3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41X-0002Y5-K8
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:59 -0400
Received: by mail-pf1-x444.google.com with SMTP id x15so234138pfa.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RHqngWpoevmwnP7u6ymNEWWj37NtOSgwRX/BbJgjzrw=;
 b=MrzYRDrB3sP6Z7XgiVgqz0YwnbJGzLNcwL971wDPYGj1OXkID9Xtu4U9Mn55Wt7+Fc
 2JfeeI/eZNWuXzqZPJNTy4075X7AGvUVfA1o5xKRY6665RUQij5u1uzuTaqWsVISs77N
 cu7/aWUY0eqT7xNtnP1YJo07+eim1/GBrWKtpLsJBtjCwdwGmEZp/I0M7DHihQ9f4/wR
 QDWC3cqhkeLMzP6aAd7liBWqpy+LrwI+wKyeuVGu36wUKSH1lGhK5x+dcXiIF2afuvwo
 QjmucEscYeYLTuN6JsLI3UX0BFmj5NT/GOtB4TaMvt4g8/GNn9TpWCs5qOemm/EY9Eml
 6EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RHqngWpoevmwnP7u6ymNEWWj37NtOSgwRX/BbJgjzrw=;
 b=uUt8EVFp0zcxRR2I3N5nk0+pZyWNRVWGgLSA4RMkk7XMDSFFybXsGU9xbDDHaPxUdD
 zSqk96V9TSlhlLwjHfnGYcfdFfnXc3Zxg18OEV0NgDOP5n6HXhNsDnVowKihk7lx2r9I
 hXwFb3klDW7st16hzwvTJC+C0bnYhVc9RX/sc7U3/0rZYw2WhQniKwCiZPkZGjNhimyc
 8ncoA0frkQDF1eUMRjzvAKkmGRt2uVJvf/GrWKbGqpQVB+D6kMMDdZiZEI28ntLVDrqo
 +7HNsQp+YzM2NEnnp2i13CqE9odvZjw/YOr9MtBwO2N04gYnN5yaW9uonzbelfG2RQ/o
 8A7A==
X-Gm-Message-State: AGi0PuYFTQm7Swe3NMkd0V1/eGZsqy/vtZL7kxEyO3ybKqU40CdEncXq
 DD/7bK7qlZ5l4Mfjj1Y5Q43VqSaAysg=
X-Google-Smtp-Source: APiQypKnJSlCIRFwyPTvxTQi6IgffiHwOx9g7miXOZ1ZhQailPCXpUBi2zz2w3BdTkLY951f3Pb5cQ==
X-Received: by 2002:a63:d806:: with SMTP id b6mr8814688pgh.72.1587518277922;
 Tue, 21 Apr 2020 18:17:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/36] tcg: Fix integral argument type to
 tcg_gen_rot[rl]i_i{32, 64}
Date: Tue, 21 Apr 2020 18:17:13 -0700
Message-Id: <20200422011722.13287-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the benefit of compatibility of function pointer types,
we have standardized on int32_t and int64_t as the integral
argument to tcg expanders.

We converted most of them in 474b2e8f0f7, but missed the rotates.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h |  8 ++++----
 tcg/tcg-op.c         | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a39eb13ff0..b07bf7b524 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -298,9 +298,9 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
+void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
+void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -490,9 +490,9 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
+void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
+void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 07eb661a07..202d8057c5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -516,9 +516,9 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
+void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    tcg_debug_assert(arg2 < 32);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
@@ -554,9 +554,9 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
+void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    tcg_debug_assert(arg2 < 32);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
@@ -1949,9 +1949,9 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
+void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    tcg_debug_assert(arg2 < 64);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
@@ -1986,9 +1986,9 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
+void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    tcg_debug_assert(arg2 < 64);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-- 
2.20.1


