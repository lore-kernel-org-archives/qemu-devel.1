Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C709C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63182208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63182208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHDJ-0007Kv-JT
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBHCa-0006Js-2u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBHCY-00077V-Vz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:08:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57277)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBHCY-00074D-Lm; Mon, 09 Mar 2020 08:08:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1404215|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.455919-9.98774e-05-0.543981;
 FP=10011476299132503670|1|1|7|0|-1|-1|-1; HT=e02c03307;
 MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.Gyaaf3X_1583755609; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Gyaaf3X_1583755609)
 by smtp.aliyun-inc.com(10.147.41.178);
 Mon, 09 Mar 2020 20:07:56 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 45/60] target/riscv: vector wideing integer reduction
 instructions
Date: Mon,  9 Mar 2020 20:05:29 +0800
Message-Id: <20200309120544.13503-46-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200309120544.13503-17-zhiwei_liu@c-sky.com>
References: <20200309120544.13503-17-zhiwei_liu@c-sky.com>
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
---
 target/riscv/helper.h                   |  7 +++++++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  4 ++++
 target/riscv/vector_helper.c            | 11 +++++++++++
 4 files changed, 24 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index cc1eb55404..76435f90a9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1054,3 +1054,10 @@ DEF_HELPER_6(vredxor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vredxor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vredxor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vredxor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vwredsumu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsumu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsumu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 2419ef97e7..e6a354c134 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -531,6 +531,8 @@ vredminu_vs     000100 . ..... ..... 010 ..... 1010111 @r_vm
 vredmin_vs      000101 . ..... ..... 010 ..... 1010111 @r_vm
 vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
 vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
+vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
+vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 3f6951abd5..195c460cb8 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2040,3 +2040,7 @@ GEN_OPIVV_TRANS(vredmin_vs, reduction_check)
 GEN_OPIVV_TRANS(vredand_vs, reduction_check)
 GEN_OPIVV_TRANS(vredor_vs, reduction_check)
 GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
+
+/* Vector Widening Integer Reduction Instructions */
+GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_check)
+GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 789be79b5a..f2ded5adc6 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4138,3 +4138,14 @@ GEN_VEXT_RED(vredxor_vs_b, int8_t, int8_t, H1, H1, DO_XOR, clearb)
 GEN_VEXT_RED(vredxor_vs_h, int16_t, int16_t, H2, H2, DO_XOR, clearh)
 GEN_VEXT_RED(vredxor_vs_w, int32_t, int32_t, H4, H4, DO_XOR, clearl)
 GEN_VEXT_RED(vredxor_vs_d, int64_t, int64_t, H8, H8, DO_XOR, clearq)
+
+/* Vector Widening Integer Reduction Instructions */
+/* signed sum reduction into double-width accumulator */
+GEN_VEXT_RED(vwredsum_vs_b, int16_t, int8_t, H2, H1, DO_ADD, clearh)
+GEN_VEXT_RED(vwredsum_vs_h, int32_t, int16_t, H4, H2, DO_ADD, clearl)
+GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD, clearq)
+
+/* Unsigned sum reduction into double-width accumulator */
+GEN_VEXT_RED(vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, DO_ADD, clearh)
+GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD, clearl)
+GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD, clearq)
-- 
2.23.0


