Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B060C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC73206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuufV4Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC73206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR46j-000349-8u
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41i-0002CR-DT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41d-0002jb-I5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:08 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41d-0002gr-2Y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:05 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ms17so163616pjb.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D6SVv03MXxB2K+lEAZ0gVyytKOY11D/Z+5Ub09WGv3Q=;
 b=NuufV4GwkF7z7Dos43Rm7DNpQm9e5cVUBIwc/0zrb3gF/8Qoe4mTByw9HYeN/fmnNC
 +HN0o2HpEQHPYU3ExjQ8zJLW2VSZOuUBxmPaEhcdzzIbHvOdH7thmRhK1J2+5X3/Dcsa
 lPIn+I5T6LDwDzSSsEHV1LJbmNgVXPRydZWSE+pyaHvjf4eUsUp0U3b4RmWzZH3tAHgX
 urPWfSD/WX7LKOQNIavbnvt34RHKUMMMDo4GlzGhvf4fcfBYzUdDrq7wSZBSVqcp/BIH
 d5mnlUJPiMVwKk/K1gKIWWD715ZH5YQhFDdo/y8ryevgbK3ejKsQZnt01l9J4QIATule
 22hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D6SVv03MXxB2K+lEAZ0gVyytKOY11D/Z+5Ub09WGv3Q=;
 b=FgWyrw8JhdG+KW432qUqiPp3rV+am8p2iLDaddj9L6gt/2gk3/jiJRabSdObIo1UQx
 hIhmXrVlLvaaJAev3h+RndeIXgiGlv09hQM85L1o8Gj/kt4bgjngtABiP6d39ogxlPUa
 v0rjKuI6HjkCc8LikYdVnuSrg6ozxGAFjTcdZPLKTvAkzrVLU6EpN8+q/Fcr1DNwdWPb
 zGYZmz2D/LClabhG7Bt739r3umlmeK6vRSBZ0F4KLJ1jf1t3Uese+f+WBg72u56tDcqg
 8Qe3IFnaOwCJupaoKCB+zRyvUvymaPPPjLGqT4jIrbidlWKDscTbmNqlISYUfknUBwE3
 H2yQ==
X-Gm-Message-State: AGi0PuYbVkH1MwnF0pbOX0MqTGEsDyozRgm53ohUx/nBIWUlxz98OWxL
 K3DkrS/z0D3ciZj6i/3KFpa5SogdXmc=
X-Google-Smtp-Source: APiQypIBLvpsXugZmC9gG/mZRiD1+hiGitviktXJo1XUFTYID2ezcxe7slctWBvQeJmA5Y6zcEDJxA==
X-Received: by 2002:a17:90a:25c3:: with SMTP id
 k61mr8981558pje.28.1587518282655; 
 Tue, 21 Apr 2020 18:18:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:18:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 31/36] tcg: Implement gvec support for rotate by scalar
Date: Tue, 21 Apr 2020 18:17:17 -0700
Message-Id: <20200422011722.13287-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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

No host backend support yet, but the interfaces for rotls
are in place.  Only implement left-rotate for now, as the
only known use of vector rotate by scalar is s390x, so any
right-rotate would be unused and untestable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h |  2 ++
 include/tcg/tcg-op.h      |  1 +
 include/tcg/tcg-opc.h     |  1 +
 include/tcg/tcg.h         |  1 +
 tcg/aarch64/tcg-target.h  |  1 +
 tcg/i386/tcg-target.h     |  1 +
 tcg/ppc/tcg-target.h      |  1 +
 tcg/tcg-op-gvec.c         | 22 ++++++++++++++++++++++
 tcg/tcg-op-vec.c          |  5 +++++
 tcg/tcg.c                 |  2 ++
 10 files changed, 37 insertions(+)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index 2d768f1160..c69a7de984 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -345,6 +345,8 @@ void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
 
 /*
  * Perform vector shift by vector element, modulo the element size.
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 0468009713..d0319692ec 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -992,6 +992,7 @@ void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index d80335ba0d..d63c6bcb3d 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -250,6 +250,7 @@ DEF(rotli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_roti_vec))
 DEF(shls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
 DEF(shrs_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
 DEF(sars_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
+DEF(rotls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rots_vec))
 
 DEF(shlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 6bb2e3fe3c..57d6b0216c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -183,6 +183,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index a5477bbc07..9bc2a5ecbe 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -134,6 +134,7 @@ typedef enum {
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 4c806c97db..99ac1e3958 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -184,6 +184,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 7993422526..4a17aebc5a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -162,6 +162,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_neg_vec          have_isa_3_00
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 2b71725883..3707c0effb 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2976,6 +2976,28 @@ void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
     do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
 }
 
+void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2sh g = {
+        .fni4 = tcg_gen_rotl_i32,
+        .fni8 = tcg_gen_rotl_i64,
+        .fniv_s = tcg_gen_rotls_vec,
+        .fniv_v = tcg_gen_rotlv_vec,
+        .fno = {
+            gen_helper_gvec_rotl8i,
+            gen_helper_gvec_rotl16i,
+            gen_helper_gvec_rotl32i,
+            gen_helper_gvec_rotl64i,
+        },
+        .s_list = { INDEX_op_rotls_vec, 0 },
+        .v_list = { INDEX_op_rotlv_vec, 0 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &g);
+}
+
 /*
  * Expand D = A << (B % element bits)
  *
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 52c1b66283..1c12e31fbb 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -821,6 +821,11 @@ void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
     do_shifts(vece, r, a, b, INDEX_op_sars_vec);
 }
 
+void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s)
+{
+    do_shifts(vece, r, a, s, INDEX_op_rotls_vec);
+}
+
 void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
                         TCGv_vec b, TCGv_vec c)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5a82464610..e8d06fe813 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1699,6 +1699,8 @@ bool tcg_op_supported(TCGOpcode op)
         return have_vec && TCG_TARGET_HAS_shv_vec;
     case INDEX_op_rotli_vec:
         return have_vec && TCG_TARGET_HAS_roti_vec;
+    case INDEX_op_rotls_vec:
+        return have_vec && TCG_TARGET_HAS_rots_vec;
     case INDEX_op_rotlv_vec:
     case INDEX_op_rotrv_vec:
         return have_vec && TCG_TARGET_HAS_rotv_vec;
-- 
2.20.1


