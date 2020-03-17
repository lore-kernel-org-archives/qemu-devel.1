Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C097DC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B9820724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B9820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFS5-00025F-Pu
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFHr-0008I9-6i
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFHp-0004MY-IM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:41:50 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEFHp-0002xl-0k; Tue, 17 Mar 2020 12:41:49 -0400
X-Alimail-AntiSpam: AC=PASS; BC=0.07460144|-1; BR=01201311R551ee; CH=green;
 DM=||false|; DS=SPAM|spam_blackmail|0.88147-0.0001108-0.118419;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03308; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1.3hv4_1584463299; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.3hv4_1584463299)
 by smtp.aliyun-inc.com(10.147.42.16); Wed, 18 Mar 2020 00:41:39 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 47/61] target/riscv: vector single-width floating-point
 reduction instructions
Date: Tue, 17 Mar 2020 23:06:39 +0800
Message-Id: <20200317150653.9008-48-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   | 10 +++++++
 target/riscv/insn32.decode              |  4 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  5 ++++
 target/riscv/vector_helper.c            | 40 +++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6bd7965a23..319c534ceb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1069,3 +1069,13 @@ DEF_HELPER_6(vwredsumu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vwredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredsum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmax_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmax_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b69d804fda..0592075167 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -539,6 +539,10 @@ vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
 vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
 vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
 vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
+# Vector ordered and unordered reduction sum
+vfredsum_vs     0000-1 . ..... ..... 001 ..... 1010111 @r_vm
+vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
+vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 90c7cb2d63..d541c78474 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2181,3 +2181,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 /* Vector Widening Integer Reduction Instructions */
 GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_check)
 GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
+
+/* Vector Single-Width Floating-Point Reduction Instructions */
+GEN_OPFVV_TRANS(vfredsum_vs, reduction_check)
+GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
+GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 678ede3c02..c0ba661522 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4378,3 +4378,43 @@ GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD, clearq)
 GEN_VEXT_RED(vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, DO_ADD, clearh)
 GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD, clearl)
 GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD, clearq)
+
+/* Vector Single-Width Floating-Point Reduction Instructions */
+#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)\
+void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
+        void *vs2, CPURISCVState *env, uint32_t desc)      \
+{                                                          \
+    uint32_t mlen = vext_mlen(desc);                       \
+    uint32_t vm = vext_vm(desc);                           \
+    uint32_t vl = env->vl;                                 \
+    uint32_t i;                                            \
+    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;         \
+    TD s1 =  *((TD *)vs1 + HD(0));                         \
+                                                           \
+    if (vl == 0) {                                         \
+        return;                                            \
+    }                                                      \
+    for (i = 0; i < vl; i++) {                             \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {         \
+            continue;                                      \
+        }                                                  \
+        s1 = OP(s1, (TD)s2, &env->fp_status);              \
+    }                                                      \
+    *((TD *)vd + HD(0)) = s1;                              \
+    CLEAR_FN(vd, 1, sizeof(TD), tot);                      \
+}
+/* Unordered sum */
+GEN_VEXT_FRED(vfredsum_vs_h, uint16_t, uint16_t, H2, H2, float16_add, clearh)
+GEN_VEXT_FRED(vfredsum_vs_w, uint32_t, uint32_t, H4, H4, float32_add, clearl)
+GEN_VEXT_FRED(vfredsum_vs_d, uint64_t, uint64_t, H8, H8, float64_add, clearq)
+
+/* Maximum value */
+GEN_VEXT_FRED(vfredmax_vs_h, uint16_t, uint16_t, H2, H2, float16_maxnum, clearh)
+GEN_VEXT_FRED(vfredmax_vs_w, uint32_t, uint32_t, H4, H4, float32_maxnum, clearl)
+GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, float64_maxnum, clearq)
+
+/* Minimum value */
+GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, float16_minnum, clearh)
+GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, float32_minnum, clearl)
+GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum, clearq)
-- 
2.23.0


