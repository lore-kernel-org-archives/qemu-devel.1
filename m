Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266A9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08402070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08402070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jovWR-0002pX-63
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovVa-0002Md-83; Fri, 26 Jun 2020 17:03:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jovVW-0003p7-Ct; Fri, 26 Jun 2020 17:03:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.123083-0.000330356-0.876587;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07381; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.Ht2835v_1593205407; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Ht2835v_1593205407)
 by smtp.aliyun-inc.com(10.147.42.16); Sat, 27 Jun 2020 05:03:27 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 2/6] target/riscv: NaN-boxing compute,
 sign-injection and convert instructions.
Date: Sat, 27 Jun 2020 04:59:13 +0800
Message-Id: <20200626205917.4545-3-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 16:59:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>, ianjiang.ict@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An n-bit foating-point result is written to the n least-significant bits
of the destination f register, with all 1s written to the uppermost
FLEN - n bits to yield a legal NaN-boxed value

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/insn_trans/trans_rvd.inc.c |  1 +
 target/riscv/insn_trans/trans_rvf.inc.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index ea1044f13b..cd73a326f4 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -230,6 +230,7 @@ static bool trans_fcvt_s_d(DisasContext *ctx, arg_fcvt_s_d *a)
 
     gen_set_rm(ctx, a->rm);
     gen_helper_fcvt_s_d(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+    gen_nanbox_fpr(ctx, a->rd);
 
     mark_fs_dirty(ctx);
     return true;
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 0d5ce373cb..a3d74dd83d 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -61,6 +61,7 @@ static bool trans_fmadd_s(DisasContext *ctx, arg_fmadd_s *a)
     gen_set_rm(ctx, a->rm);
     gen_helper_fmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -72,6 +73,7 @@ static bool trans_fmsub_s(DisasContext *ctx, arg_fmsub_s *a)
     gen_set_rm(ctx, a->rm);
     gen_helper_fmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
                        cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -83,6 +85,7 @@ static bool trans_fnmsub_s(DisasContext *ctx, arg_fnmsub_s *a)
     gen_set_rm(ctx, a->rm);
     gen_helper_fnmsub_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
                         cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -95,6 +98,7 @@ static bool trans_fnmadd_s(DisasContext *ctx, arg_fnmadd_s *a)
     gen_helper_fnmadd_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
                         cpu_fpr[a->rs2], cpu_fpr[a->rs3]);
     mark_fs_dirty(ctx);
+    gen_nanbox_fpr(ctx, a->rd);
     return true;
 }
 
@@ -106,6 +110,7 @@ static bool trans_fadd_s(DisasContext *ctx, arg_fadd_s *a)
     gen_set_rm(ctx, a->rm);
     gen_helper_fadd_s(cpu_fpr[a->rd], cpu_env,
                       cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -118,6 +123,7 @@ static bool trans_fsub_s(DisasContext *ctx, arg_fsub_s *a)
     gen_set_rm(ctx, a->rm);
     gen_helper_fsub_s(cpu_fpr[a->rd], cpu_env,
                       cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -130,6 +136,7 @@ static bool trans_fmul_s(DisasContext *ctx, arg_fmul_s *a)
     gen_set_rm(ctx, a->rm);
     gen_helper_fmul_s(cpu_fpr[a->rd], cpu_env,
                       cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -142,6 +149,7 @@ static bool trans_fdiv_s(DisasContext *ctx, arg_fdiv_s *a)
     gen_set_rm(ctx, a->rm);
     gen_helper_fdiv_s(cpu_fpr[a->rd], cpu_env,
                       cpu_fpr[a->rs1], cpu_fpr[a->rs2]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -153,6 +161,7 @@ static bool trans_fsqrt_s(DisasContext *ctx, arg_fsqrt_s *a)
 
     gen_set_rm(ctx, a->rm);
     gen_helper_fsqrt_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -167,6 +176,7 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
         tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
                             0, 31);
     }
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -183,6 +193,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
         tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
         tcg_temp_free_i64(t0);
     }
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -199,6 +210,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
         tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
         tcg_temp_free_i64(t0);
     }
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -210,6 +222,7 @@ static bool trans_fmin_s(DisasContext *ctx, arg_fmin_s *a)
 
     gen_helper_fmin_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
                       cpu_fpr[a->rs2]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -221,6 +234,7 @@ static bool trans_fmax_s(DisasContext *ctx, arg_fmax_s *a)
 
     gen_helper_fmax_s(cpu_fpr[a->rd], cpu_env, cpu_fpr[a->rs1],
                       cpu_fpr[a->rs2]);
+    gen_nanbox_fpr(ctx, a->rd);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -331,6 +345,7 @@ static bool trans_fcvt_s_w(DisasContext *ctx, arg_fcvt_s_w *a)
 
     gen_set_rm(ctx, a->rm);
     gen_helper_fcvt_s_w(cpu_fpr[a->rd], cpu_env, t0);
+    gen_nanbox_fpr(ctx, a->rd);
 
     mark_fs_dirty(ctx);
     tcg_temp_free(t0);
@@ -348,6 +363,7 @@ static bool trans_fcvt_s_wu(DisasContext *ctx, arg_fcvt_s_wu *a)
 
     gen_set_rm(ctx, a->rm);
     gen_helper_fcvt_s_wu(cpu_fpr[a->rd], cpu_env, t0);
+    gen_nanbox_fpr(ctx, a->rd);
 
     mark_fs_dirty(ctx);
     tcg_temp_free(t0);
@@ -369,6 +385,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 #else
     tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
 #endif
+    gen_nanbox_fpr(ctx, a->rd);
 
     mark_fs_dirty(ctx);
     tcg_temp_free(t0);
@@ -413,6 +430,7 @@ static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a)
 
     gen_set_rm(ctx, a->rm);
     gen_helper_fcvt_s_l(cpu_fpr[a->rd], cpu_env, t0);
+    gen_nanbox_fpr(ctx, a->rd);
 
     mark_fs_dirty(ctx);
     tcg_temp_free(t0);
@@ -429,6 +447,7 @@ static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a)
 
     gen_set_rm(ctx, a->rm);
     gen_helper_fcvt_s_lu(cpu_fpr[a->rd], cpu_env, t0);
+    gen_nanbox_fpr(ctx, a->rd);
 
     mark_fs_dirty(ctx);
     tcg_temp_free(t0);
-- 
2.23.0


