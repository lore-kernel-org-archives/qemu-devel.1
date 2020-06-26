Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F0B20663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jyj41Jqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F0B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowb3-0002A2-9X
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIU-0003L0-Nk
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIQ-00031d-GD
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208454; x=1624744454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BY7KbCNIGcaRJr1MnlymAYWx1srSO5JuYihLGBeJH+4=;
 b=jyj41JqqINMvydObmjDJsCtbsQCLbR+LsR+CaqbFgE4nyogwBmUUG981
 +BjDvX1ySkPrNr9kPV7tL14bv8XtWvu/kYhUU1+jnJXhpKNq7Ob3XV8iE
 EjeZpLTIZZ0YyOmj4/oKNZFwYJ0gjqwncd6iyAWsZbV1phR5FloJP0qEH
 QKw2AVMajutpssWCOj3J0wS/JJfZKwPGZB9zp5oT3KwfKDAJ/T3FlccjG
 cmTVDwA0FxE2Te7SerKkYs3sIet36U9bP8jFsuwQO+cmfpUPkwt9E3h2h
 1PmD24bUbxL6qgcJMA3kPeeL7/VvoP87wPZuA5VICnmpcARDtgi2cGhkG Q==;
IronPort-SDR: zaucvSnXwpFj3I73r5yFkIXpiUmKn5hoT4yo3lOxL8myl0jRwYBkntRXQzJK4BZ+QOQ7MFeqW9
 WhobbWUEJWEV4cH5bm3Y8LT7KLT1RpC+IRWfFPwboqGIMO2agdPfu8zAGc3xFPHMg4XWvUY+DV
 ffirfHN5Aa60RCc6VXkDfc9Q+advALBFpkXkHiV9a8sEKDpwJTNK3d7G147/cdosvsZAIyKaf6
 kTqdJWeS9XQFS9RFB/b2n+asALPkuTFfBpzC6PI3cuKQll5cxntu9wt90U6LpvR1K6wLVfbahg
 xRE=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048401"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:49 +0800
IronPort-SDR: Dt+qRA8HDZnc1sintAHC5GjiLd8ap04o7LEHf9L6WV++Q4a5Ql+ERCBihrO31GQcIWPwPpwfQ7
 oLbAbAeIdiQLbIqVdvbmNVh3rRcZf4waA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:45 -0700
IronPort-SDR: BKRPUfv9APiCk9hFqWNm3eV+3Av0iQxzgtRzFLhq3cSvxcH9UohaEVor1fDJFCzPC02Ba49wQA
 oObOEiNhFXxQ==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 44/63] target/riscv: vector floating-point/integer type-convert
 instructions
Date: Fri, 26 Jun 2020 14:43:51 -0700
Message-Id: <20200626214410.3613258-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200623215920.2594-43-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 13 ++++++++++
 target/riscv/insn32.decode              |  4 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  6 +++++
 target/riscv/vector_helper.c            | 33 +++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2c3f0a4e0c..d01e739607 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1004,3 +1004,16 @@ DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(vfcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_xu_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_x_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 38e7445a16..913c3b099b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -517,6 +517,10 @@ vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
 vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
 vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
+vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
+vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
+vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
+vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b6872376ce..ed238edfa9 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2222,3 +2222,9 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
     }
     return false;
 }
+
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+GEN_OPFV_TRANS(vfcvt_xu_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_x_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_f_xu_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 51c86a5acf..3e78c5e12a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4218,3 +4218,36 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
 GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
 GEN_VFMERGE_VF(vfmerge_vfm_w, int32_t, H4, clearl)
 GEN_VFMERGE_VF(vfmerge_vfm_d, int64_t, H8, clearq)
+
+/* Single-Width Floating-Point/Integer Type-Convert Instructions */
+/* vfcvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+RVVCALL(OPFVV1, vfcvt_xu_f_v_h, OP_UU_H, H2, H2, float16_to_uint16)
+RVVCALL(OPFVV1, vfcvt_xu_f_v_w, OP_UU_W, H4, H4, float32_to_uint32)
+RVVCALL(OPFVV1, vfcvt_xu_f_v_d, OP_UU_D, H8, H8, float64_to_uint64)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_xu_f_v_d, 8, 8, clearq)
+
+/* vfcvt.x.f.v vd, vs2, vm # Convert float to signed integer. */
+RVVCALL(OPFVV1, vfcvt_x_f_v_h, OP_UU_H, H2, H2, float16_to_int16)
+RVVCALL(OPFVV1, vfcvt_x_f_v_w, OP_UU_W, H4, H4, float32_to_int32)
+RVVCALL(OPFVV1, vfcvt_x_f_v_d, OP_UU_D, H8, H8, float64_to_int64)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_x_f_v_d, 8, 8, clearq)
+
+/* vfcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to float. */
+RVVCALL(OPFVV1, vfcvt_f_xu_v_h, OP_UU_H, H2, H2, uint16_to_float16)
+RVVCALL(OPFVV1, vfcvt_f_xu_v_w, OP_UU_W, H4, H4, uint32_to_float32)
+RVVCALL(OPFVV1, vfcvt_f_xu_v_d, OP_UU_D, H8, H8, uint64_to_float64)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_f_xu_v_d, 8, 8, clearq)
+
+/* vfcvt.f.x.v vd, vs2, vm # Convert integer to float. */
+RVVCALL(OPFVV1, vfcvt_f_x_v_h, OP_UU_H, H2, H2, int16_to_float16)
+RVVCALL(OPFVV1, vfcvt_f_x_v_w, OP_UU_W, H4, H4, int32_to_float32)
+RVVCALL(OPFVV1, vfcvt_f_x_v_d, OP_UU_D, H8, H8, int64_to_float64)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8, 8, clearq)
-- 
2.27.0


