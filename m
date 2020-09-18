Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9EFC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD2221D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHg0ouE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD2221D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLg1-0001DD-QJ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGt-0007lb-Ki
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:11 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGq-00073a-0J
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:11 -0400
Received: by mail-pj1-x1044.google.com with SMTP id u3so3458668pjr.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Qg5d/yrEd3aWZXQd/oZNgkhFNliYUk831GSUJKGHps=;
 b=vHg0ouE4gKbtjbIQVRpCq8GJZ7FCPau58sVZf4appTIdoaNB5xjudWSUl8LCW7CPOa
 PhXUhO30aVJrBZOj855gPsghCLbtZ2bxdqmebouVtFOUyAqxl7iHi3OV/YReXlSKv+HL
 +YiBY8UJkRWjQl6HJIxCBbO/CDdDhsK7ooLko7Jke4h5pEo+S0iYSmV5H2oBNzTi2nPB
 0zo/HgFKxnhtSRiilmEJvdv3xZewII8kuTtekwnYRJYw0t9bMX3fE1amBydABSIph4og
 +UrR21BLKymQn70/UZfDE39z/tMsnsptZ8QnQgMK+OCGR0ccNpPWvjkVmfw6sl7bNvrK
 wJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Qg5d/yrEd3aWZXQd/oZNgkhFNliYUk831GSUJKGHps=;
 b=ioHauAooMsnBr12u+x++97wVAj7u2sMkEss6MlJMRQHKvShPZC5MKMBNAlQvXXyDlm
 zkMTj9MERqmFKzNZQQr7i+rQxwbAO3IaRM+yvwk78dtXtKOio7yw3N5O6G6hfwY3nISQ
 Nd/Qs5Y96xn2+B8rNyj0XvbmGANWn49sOPQBoipmG0JZv6hqbsRYnPobCYvnF8pPphLc
 1jMQw8vEGs8BS4xorwabMls+Upo6DOvi1PDcBcaXQ+AOWXLWdiKFEhtNtMGwmsDS9NcI
 iS1rC9Zn7tDFn6bvHTxs9ZrEhEa4ktwJ3q9vO+BJ8r16pHx1GsrLNmhREMGvO4VyTwzZ
 z/iQ==
X-Gm-Message-State: AOAM533l49BZTpUpSxVnGZomFSVlTVGDff4Oa85Jd3F30B+AW9naBpok
 hbIHvsg5cjOv0NSBteGBm7KcpOw5YJKejw==
X-Google-Smtp-Source: ABdhPJya2C6irxMJcYevyZ4vEnTXKer6MhZo7ClOXb1Yu0BSfTUbfs11zX/a9MTbD2trywoq0a3dEA==
X-Received: by 2002:a17:902:aa85:b029:d0:cbe1:e70d with SMTP id
 d5-20020a170902aa85b02900d0cbe1e70dmr34657616plr.27.1600454285901; 
 Fri, 18 Sep 2020 11:38:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/81] target/arm: Implement SVE2 saturating/rounding
 bitwise shift left (predicated)
Date: Fri, 18 Sep 2020 11:36:39 -0700
Message-Id: <20200918183751.2787647-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Shift values are always signed (laurent desnogues).
---
 target/arm/helper-sve.h    | 54 ++++++++++++++++++++++++++
 target/arm/sve.decode      | 17 +++++++++
 target/arm/sve_helper.c    | 78 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 18 +++++++++
 4 files changed, 167 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 938c50f2c9..3c87b1ce29 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -172,6 +172,60 @@ DEF_HELPER_FLAGS_5(sve2_uadalp_zpzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_uadalp_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_srshl_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_srshl_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_srshl_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_srshl_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_urshl_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_urshl_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_urshl_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_urshl_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sqshl_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqshl_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqshl_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqshl_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_uqshl_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uqshl_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uqshl_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uqshl_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sqrshl_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrshl_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrshl_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrshl_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_uqrshl_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uqrshl_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uqrshl_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uqrshl_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_sdiv_zpzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_sdiv_zpzz_d, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 2ab463c722..7c940e45c6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1112,3 +1112,20 @@ URECPE          01000100 .. 000 000 101 ... ..... .....  @rd_pg_rn
 URSQRTE         01000100 .. 000 001 101 ... ..... .....  @rd_pg_rn
 SQABS           01000100 .. 001 000 101 ... ..... .....  @rd_pg_rn
 SQNEG           01000100 .. 001 001 101 ... ..... .....  @rd_pg_rn
+
+### SVE2 saturating/rounding bitwise shift left (predicated)
+
+SRSHL           01000100 .. 000 010 100 ... ..... .....  @rdn_pg_rm
+URSHL           01000100 .. 000 011 100 ... ..... .....  @rdn_pg_rm
+SRSHL           01000100 .. 000 110 100 ... ..... .....  @rdm_pg_rn # SRSHLR
+URSHL           01000100 .. 000 111 100 ... ..... .....  @rdm_pg_rn # URSHLR
+
+SQSHL           01000100 .. 001 000 100 ... ..... .....  @rdn_pg_rm
+UQSHL           01000100 .. 001 001 100 ... ..... .....  @rdn_pg_rm
+SQSHL           01000100 .. 001 100 100 ... ..... .....  @rdm_pg_rn # SQSHLR
+UQSHL           01000100 .. 001 101 100 ... ..... .....  @rdm_pg_rn # UQSHLR
+
+SQRSHL          01000100 .. 001 010 100 ... ..... .....  @rdn_pg_rm
+UQRSHL          01000100 .. 001 011 100 ... ..... .....  @rdn_pg_rm
+SQRSHL          01000100 .. 001 110 100 ... ..... .....  @rdm_pg_rn # SQRSHLR
+UQRSHL          01000100 .. 001 111 100 ... ..... .....  @rdm_pg_rn # UQRSHLR
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b1c89f77d4..40e1b5df30 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -26,6 +26,7 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
+#include "vec_internal.h"
 
 
 /* Note that vector data is stored in host-endian 64-bit chunks,
@@ -561,6 +562,83 @@ DO_ZPZZ(sve2_uadalp_zpzz_h, uint16_t, H1_2, do_uadalp_h)
 DO_ZPZZ(sve2_uadalp_zpzz_s, uint32_t, H1_4, do_uadalp_s)
 DO_ZPZZ_D(sve2_uadalp_zpzz_d, uint64_t, do_uadalp_d)
 
+#define do_srshl_b(n, m)  do_sqrshl_bhs(n, m, 8, true, NULL)
+#define do_srshl_h(n, m)  do_sqrshl_bhs(n, m, 16, true, NULL)
+#define do_srshl_s(n, m)  do_sqrshl_bhs(n, m, 32, true, NULL)
+#define do_srshl_d(n, m)  do_sqrshl_d(n, m, true, NULL)
+
+DO_ZPZZ(sve2_srshl_zpzz_b, int8_t, H1_2, do_srshl_b)
+DO_ZPZZ(sve2_srshl_zpzz_h, int16_t, H1_2, do_srshl_h)
+DO_ZPZZ(sve2_srshl_zpzz_s, int32_t, H1_4, do_srshl_s)
+DO_ZPZZ_D(sve2_srshl_zpzz_d, int64_t, do_srshl_d)
+
+#define do_urshl_b(n, m)  do_uqrshl_bhs(n, (int8_t)m, 8, true, NULL)
+#define do_urshl_h(n, m)  do_uqrshl_bhs(n, (int16_t)m, 16, true, NULL)
+#define do_urshl_s(n, m)  do_uqrshl_bhs(n, m, 32, true, NULL)
+#define do_urshl_d(n, m)  do_uqrshl_d(n, m, true, NULL)
+
+DO_ZPZZ(sve2_urshl_zpzz_b, uint8_t, H1_2, do_urshl_b)
+DO_ZPZZ(sve2_urshl_zpzz_h, uint16_t, H1_2, do_urshl_h)
+DO_ZPZZ(sve2_urshl_zpzz_s, uint32_t, H1_4, do_urshl_s)
+DO_ZPZZ_D(sve2_urshl_zpzz_d, uint64_t, do_urshl_d)
+
+/* Unlike the NEON and AdvSIMD versions, there is no QC bit to set. */
+#define do_sqshl_b(n, m) \
+   ({ uint32_t discard; do_sqrshl_bhs(n, m, 8, false, &discard); })
+#define do_sqshl_h(n, m) \
+   ({ uint32_t discard; do_sqrshl_bhs(n, m, 16, false, &discard); })
+#define do_sqshl_s(n, m) \
+   ({ uint32_t discard; do_sqrshl_bhs(n, m, 32, false, &discard); })
+#define do_sqshl_d(n, m) \
+   ({ uint32_t discard; do_sqrshl_d(n, m, false, &discard); })
+
+DO_ZPZZ(sve2_sqshl_zpzz_b, int8_t, H1_2, do_sqshl_b)
+DO_ZPZZ(sve2_sqshl_zpzz_h, int16_t, H1_2, do_sqshl_h)
+DO_ZPZZ(sve2_sqshl_zpzz_s, int32_t, H1_4, do_sqshl_s)
+DO_ZPZZ_D(sve2_sqshl_zpzz_d, int64_t, do_sqshl_d)
+
+#define do_uqshl_b(n, m) \
+   ({ uint32_t discard; do_uqrshl_bhs(n, (int8_t)m, 8, false, &discard); })
+#define do_uqshl_h(n, m) \
+   ({ uint32_t discard; do_uqrshl_bhs(n, (int16_t)m, 16, false, &discard); })
+#define do_uqshl_s(n, m) \
+   ({ uint32_t discard; do_uqrshl_bhs(n, m, 32, false, &discard); })
+#define do_uqshl_d(n, m) \
+   ({ uint32_t discard; do_uqrshl_d(n, m, false, &discard); })
+
+DO_ZPZZ(sve2_uqshl_zpzz_b, uint8_t, H1_2, do_uqshl_b)
+DO_ZPZZ(sve2_uqshl_zpzz_h, uint16_t, H1_2, do_uqshl_h)
+DO_ZPZZ(sve2_uqshl_zpzz_s, uint32_t, H1_4, do_uqshl_s)
+DO_ZPZZ_D(sve2_uqshl_zpzz_d, uint64_t, do_uqshl_d)
+
+#define do_sqrshl_b(n, m) \
+   ({ uint32_t discard; do_sqrshl_bhs(n, m, 8, true, &discard); })
+#define do_sqrshl_h(n, m) \
+   ({ uint32_t discard; do_sqrshl_bhs(n, m, 16, true, &discard); })
+#define do_sqrshl_s(n, m) \
+   ({ uint32_t discard; do_sqrshl_bhs(n, m, 32, true, &discard); })
+#define do_sqrshl_d(n, m) \
+   ({ uint32_t discard; do_sqrshl_d(n, m, true, &discard); })
+
+DO_ZPZZ(sve2_sqrshl_zpzz_b, int8_t, H1_2, do_sqrshl_b)
+DO_ZPZZ(sve2_sqrshl_zpzz_h, int16_t, H1_2, do_sqrshl_h)
+DO_ZPZZ(sve2_sqrshl_zpzz_s, int32_t, H1_4, do_sqrshl_s)
+DO_ZPZZ_D(sve2_sqrshl_zpzz_d, int64_t, do_sqrshl_d)
+
+#define do_uqrshl_b(n, m) \
+   ({ uint32_t discard; do_uqrshl_bhs(n, (int8_t)m, 8, true, &discard); })
+#define do_uqrshl_h(n, m) \
+   ({ uint32_t discard; do_uqrshl_bhs(n, (int16_t)m, 16, true, &discard); })
+#define do_uqrshl_s(n, m) \
+   ({ uint32_t discard; do_uqrshl_bhs(n, m, 32, true, &discard); })
+#define do_uqrshl_d(n, m) \
+   ({ uint32_t discard; do_uqrshl_d(n, m, true, &discard); })
+
+DO_ZPZZ(sve2_uqrshl_zpzz_b, uint8_t, H1_2, do_uqrshl_b)
+DO_ZPZZ(sve2_uqrshl_zpzz_h, uint16_t, H1_2, do_uqrshl_h)
+DO_ZPZZ(sve2_uqrshl_zpzz_s, uint32_t, H1_4, do_uqrshl_s)
+DO_ZPZZ_D(sve2_uqrshl_zpzz_d, uint64_t, do_uqrshl_d)
+
 #undef DO_ZPZZ
 #undef DO_ZPZZ_D
 
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 1dacb3fbc4..1aa8db673f 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5941,3 +5941,21 @@ static bool trans_SQNEG(DisasContext *s, arg_rpr_esz *a)
     };
     return do_sve2_zpz_ool(s, a, fns[a->esz]);
 }
+
+#define DO_SVE2_ZPZZ(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                \
+{                                                                         \
+    static gen_helper_gvec_4 * const fns[4] = {                           \
+        gen_helper_sve2_##name##_zpzz_b, gen_helper_sve2_##name##_zpzz_h, \
+        gen_helper_sve2_##name##_zpzz_s, gen_helper_sve2_##name##_zpzz_d, \
+    };                                                                    \
+    return do_sve2_zpzz_ool(s, a, fns[a->esz]);                           \
+}
+
+DO_SVE2_ZPZZ(SQSHL, sqshl)
+DO_SVE2_ZPZZ(SQRSHL, sqrshl)
+DO_SVE2_ZPZZ(SRSHL, srshl)
+
+DO_SVE2_ZPZZ(UQSHL, uqshl)
+DO_SVE2_ZPZZ(UQRSHL, uqrshl)
+DO_SVE2_ZPZZ(URSHL, urshl)
-- 
2.25.1


