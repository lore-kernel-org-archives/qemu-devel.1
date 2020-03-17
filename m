Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9C2C3F2CE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37D720724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37D720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFQ9-0007HF-QM
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFJu-0005Ap-Pr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFJt-0001jX-E9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:43:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEFJs-0000Rt-TZ; Tue, 17 Mar 2020 12:43:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07455269|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.00473821-2.38134e-05-0.995238;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03309; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1.A5dQ_1584463420; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.A5dQ_1584463420)
 by smtp.aliyun-inc.com(10.147.40.200);
 Wed, 18 Mar 2020 00:43:40 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 48/61] target/riscv: vector widening floating-point
 reduction instructions
Date: Tue, 17 Mar 2020 23:06:40 +0800
Message-Id: <20200317150653.9008-49-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  3 ++
 target/riscv/insn32.decode              |  2 +
 target/riscv/insn_trans/trans_rvv.inc.c |  3 ++
 target/riscv/vector_helper.c            | 52 +++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 319c534ceb..15569223cb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1079,3 +1079,6 @@ DEF_HELPER_6(vfredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0592075167..526a964d28 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -543,6 +543,8 @@ vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
 vfredsum_vs     0000-1 . ..... ..... 001 ..... 1010111 @r_vm
 vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
 vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
+# Vector widening ordered and unordered float reduction sum
+vfwredsum_vs    1100-1 . ..... ..... 001 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index d541c78474..fd927f0959 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2186,3 +2186,6 @@ GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
 GEN_OPFVV_TRANS(vfredsum_vs, reduction_check)
 GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
 GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
+
+/* Vector Widening Floating-Point Reduction Instructions */
+GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c0ba661522..57532959fb 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4418,3 +4418,55 @@ GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, float64_maxnum, clearq)
 GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, float16_minnum, clearh)
 GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, float32_minnum, clearl)
 GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum, clearq)
+
+/* Vector Widening Floating-Point Reduction Instructions */
+/* Unordered reduce 2*SEW = 2*SEW + sum(promote(SEW)) */
+void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
+        void *vs2, CPURISCVState *env, uint32_t desc)
+{
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    uint32_t i;
+    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
+    uint32_t s1 =  *((uint32_t *)vs1 + H4(0));
+
+    if (vl == 0) {
+        return;
+    }
+    for (i = 0; i < vl; i++) {
+        uint16_t s2 = *((uint16_t *)vs2 + H2(i));
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        s1 = float32_add(s1, float16_to_float32(s2, true, &env->fp_status),
+                &env->fp_status);
+    }
+    *((uint32_t *)vd + H4(0)) = s1;
+    clearl(vd, 1, sizeof(uint32_t), tot);
+}
+
+void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
+        void *vs2, CPURISCVState *env, uint32_t desc)
+{
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    uint32_t i;
+    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
+    uint64_t s1 =  *((uint64_t *)vs1);
+
+    if (vl == 0) {
+        return;
+    }
+    for (i = 0; i < vl; i++) {
+        uint32_t s2 = *((uint32_t *)vs2 + H4(i));
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        s1 = float64_add(s1, float32_to_float64(s2, &env->fp_status),
+                &env->fp_status);
+    }
+    *((uint64_t *)vd) = s1;
+    clearq(vd, 1, sizeof(uint64_t), tot);
+}
-- 
2.23.0


