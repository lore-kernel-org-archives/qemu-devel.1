Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B39C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012F420776
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012F420776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIy6b-0004mD-55
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIy4b-0003FV-DN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIy4a-0006Fb-A3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:19:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIy4Z-0006Du-RM; Mon, 30 Mar 2020 13:19:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08585605|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0020033-6.25929e-05-0.997934;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03301; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H7lhL-l_1585588774; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H7lhL-l_1585588774)
 by smtp.aliyun-inc.com(10.147.41.120);
 Tue, 31 Mar 2020 01:19:35 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v7 51/61] target/riscv: vmfirst find-first-set mask bit
Date: Mon, 30 Mar 2020 23:36:23 +0800
Message-Id: <20200330153633.15298-52-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  2 ++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 32 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 19 +++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 7ae41ebc2c..e78298e479 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1097,3 +1097,5 @@ DEF_HELPER_6(vmornot_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_4(vmpopc_m, tl, ptr, ptr, env, i32)
+
+DEF_HELPER_4(vmfirst_m, tl, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index decb7f773f..4c7706561a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -554,6 +554,7 @@ vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
 vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
 vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
 vmpopc_m        010100 . ..... ----- 010 ..... 1010111 @r2_vm
+vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c7be939ddf..1c31656e07 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2436,3 +2436,35 @@ static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
     }
     return false;
 }
+
+/* vmfirst find-first-set mask bit */
+static bool trans_vmfirst_m(DisasContext *s, arg_rmr *a)
+{
+    if (vext_check_isa_ill(s)) {
+        TCGv_ptr src2, mask;
+        TCGv dst;
+        TCGv_i32 desc;
+        uint32_t data = 0;
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+
+        mask = tcg_temp_new_ptr();
+        src2 = tcg_temp_new_ptr();
+        dst = tcg_temp_new();
+        desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+        tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
+        tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+        gen_helper_vmfirst_m(dst, mask, src2, cpu_env, desc);
+        gen_set_gpr(a->rd, dst);
+
+        tcg_temp_free_ptr(mask);
+        tcg_temp_free_ptr(src2);
+        tcg_temp_free(dst);
+        tcg_temp_free_i32(desc);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 75627d335d..38ecce1dc7 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4561,3 +4561,22 @@ target_ulong HELPER(vmpopc_m)(void *v0, void *vs2, CPURISCVState *env,
     }
     return cnt;
 }
+
+/* vmfirst find-first-set mask bit*/
+target_ulong HELPER(vmfirst_m)(void *v0, void *vs2, CPURISCVState *env,
+                               uint32_t desc)
+{
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    int i;
+
+    for (i = 0; i < vl; i++) {
+        if (vm || vext_elem_mask(v0, mlen, i)) {
+            if (vext_elem_mask(vs2, mlen, i)) {
+                return i;
+            }
+        }
+    }
+    return -1LL;
+}
-- 
2.23.0


