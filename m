Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD33C4BA06
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 02:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B06C2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 02:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B06C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6mhZ-0008T0-5p
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 21:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j6mgN-0007aX-N0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 21:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j6mgD-0006Ps-Ta
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 21:44:19 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j6mgB-000658-JF; Tue, 25 Feb 2020 21:44:09 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.150071-0.0183897-0.831539;
 DS=SPAM|spam_low_mark|0.913618-0.000574843-0.0858069; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03300; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.GsXBgei_1582685038; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GsXBgei_1582685038)
 by smtp.aliyun-inc.com(10.147.41.121);
 Wed, 26 Feb 2020 10:43:59 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 1/1] target/riscv: add vector integer operations
Date: Wed, 26 Feb 2020 10:43:52 +0800
Message-Id: <20200226024352.7719-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-csky@vger.kernel.org,
 wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  395 +++++++
 target/riscv/insn32.decode              |  127 +++
 target/riscv/insn_trans/trans_rvv.inc.c |  671 +++++++++++-
 target/riscv/vector_helper.c            | 1308 ++++++++++++++++++++++-
 4 files changed, 2462 insertions(+), 39 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index cbe0d107c0..dee21b4128 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -296,3 +296,398 @@ DEF_HELPER_6(vamominw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamomaxw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamominuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamomaxuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vand_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vor_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vxor_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsll_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsll_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsll_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsll_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsrl_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsra_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vminu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vminu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vminu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vminu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmin_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmax_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulh_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulh_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulh_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulh_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdivu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vremu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrem_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vadc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsbc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsbc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsbc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsbc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmadc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmseq_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmseq_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmseq_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmseq_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsne_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsne_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsne_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsne_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsltu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsltu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsltu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsltu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmslt_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmslt_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmslt_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmslt_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsleu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsleu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsleu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsleu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsle_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsle_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsle_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmsle_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vand_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vxor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsll_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsll_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsll_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsll_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsrl_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vminu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vminu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vminu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vminu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmin_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmin_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmin_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmin_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmaxu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmax_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmax_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmax_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmax_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulh_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulh_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulh_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulh_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmulhsu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdivu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vdiv_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vremu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmacc_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsac_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnmsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vadc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmadc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsbc_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmseq_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmseq_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmseq_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmseq_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsne_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsne_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsne_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsne_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsltu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsltu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsltu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsltu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmslt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmslt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmslt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmslt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsleu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsleu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsleu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsleu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsle_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsle_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsle_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsle_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsgtu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsgtu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsgtu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsgtu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsgt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsgt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsgt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmsgt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vwaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vwaddu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmulsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwaddu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsubu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwadd_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vwsub_wx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 077551dd13..467d38c7a3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -43,6 +43,7 @@
 &u    imm rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
+&rmrr      vm rd rs1 rs2
 &rwdvm     vm wd rd rs1 rs2
 &r2nfvm    vm rd rs1 nf
 &rnfvm     vm rd rs1 rs2 nf
@@ -65,6 +66,7 @@
 @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
+@r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... &r2nfvm %rs1 %rd
 @r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... &rnfvm %rs2 %rs1 %rd
@@ -273,5 +275,130 @@ vamominuw_v     11000 . . ..... ..... 110 ..... 0101111 @r_wdvm
 vamomaxuw_v     11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
 
 # *** new major opcode OP-V ***
+vadd_vv         000000 . ..... ..... 000 ..... 1010111 @r_vm
+vadd_vx         000000 . ..... ..... 100 ..... 1010111 @r_vm
+vadd_vi         000000 . ..... ..... 011 ..... 1010111 @r_vm
+vsub_vv         000010 . ..... ..... 000 ..... 1010111 @r_vm
+vsub_vx         000010 . ..... ..... 100 ..... 1010111 @r_vm
+vrsub_vx        000011 . ..... ..... 100 ..... 1010111 @r_vm
+vrsub_vi        000011 . ..... ..... 011 ..... 1010111 @r_vm
+vminu_vv        000100 . ..... ..... 000 ..... 1010111 @r_vm
+vminu_vx        000100 . ..... ..... 100 ..... 1010111 @r_vm
+vmin_vv         000101 . ..... ..... 000 ..... 1010111 @r_vm
+vmin_vx         000101 . ..... ..... 100 ..... 1010111 @r_vm
+vmaxu_vv        000110 . ..... ..... 000 ..... 1010111 @r_vm
+vmaxu_vx        000110 . ..... ..... 100 ..... 1010111 @r_vm
+vmax_vv         000111 . ..... ..... 000 ..... 1010111 @r_vm
+vmax_vx         000111 . ..... ..... 100 ..... 1010111 @r_vm
+vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
+vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
+vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
+vor_vv          001010 . ..... ..... 000 ..... 1010111 @r_vm
+vor_vx          001010 . ..... ..... 100 ..... 1010111 @r_vm
+vor_vi          001010 . ..... ..... 011 ..... 1010111 @r_vm
+vxor_vv         001011 . ..... ..... 000 ..... 1010111 @r_vm
+vxor_vx         001011 . ..... ..... 100 ..... 1010111 @r_vm
+vxor_vi         001011 . ..... ..... 011 ..... 1010111 @r_vm
+vadc_vvm        010000 . ..... ..... 000 ..... 1010111 @r_vm
+vadc_vxm        010000 . ..... ..... 100 ..... 1010111 @r_vm
+vadc_vim        010000 . ..... ..... 011 ..... 1010111 @r_vm
+vmadc_vvm       010001 . ..... ..... 000 ..... 1010111 @r_vm
+vmadc_vxm       010001 . ..... ..... 100 ..... 1010111 @r_vm
+vmadc_vim       010001 . ..... ..... 011 ..... 1010111 @r_vm
+vsbc_vvm        010010 . ..... ..... 000 ..... 1010111 @r_vm
+vsbc_vxm        010010 . ..... ..... 100 ..... 1010111 @r_vm
+vmsbc_vvm       010011 . ..... ..... 000 ..... 1010111 @r_vm
+vmsbc_vxm       010011 . ..... ..... 100 ..... 1010111 @r_vm
+vmerge_vvm      010111 . ..... ..... 000 ..... 1010111 @r_vm
+vmerge_vxm      010111 . ..... ..... 100 ..... 1010111 @r_vm
+vmerge_vim      010111 . ..... ..... 011 ..... 1010111 @r_vm
+vmseq_vv        011000 . ..... ..... 000 ..... 1010111 @r_vm
+vmseq_vx        011000 . ..... ..... 100 ..... 1010111 @r_vm
+vmseq_vi        011000 . ..... ..... 011 ..... 1010111 @r_vm
+vmsne_vv        011001 . ..... ..... 000 ..... 1010111 @r_vm
+vmsne_vx        011001 . ..... ..... 100 ..... 1010111 @r_vm
+vmsne_vi        011001 . ..... ..... 011 ..... 1010111 @r_vm
+vmsltu_vv       011010 . ..... ..... 000 ..... 1010111 @r_vm
+vmsltu_vx       011010 . ..... ..... 100 ..... 1010111 @r_vm
+vmslt_vv        011011 . ..... ..... 000 ..... 1010111 @r_vm
+vmslt_vx        011011 . ..... ..... 100 ..... 1010111 @r_vm
+vmsleu_vv       011100 . ..... ..... 000 ..... 1010111 @r_vm
+vmsleu_vx       011100 . ..... ..... 100 ..... 1010111 @r_vm
+vmsleu_vi       011100 . ..... ..... 011 ..... 1010111 @r_vm
+vmsle_vv        011101 . ..... ..... 000 ..... 1010111 @r_vm
+vmsle_vx        011101 . ..... ..... 100 ..... 1010111 @r_vm
+vmsle_vi        011101 . ..... ..... 011 ..... 1010111 @r_vm
+vmsgtu_vx       011110 . ..... ..... 100 ..... 1010111 @r_vm
+vmsgtu_vi       011110 . ..... ..... 011 ..... 1010111 @r_vm
+vmsgt_vx        011111 . ..... ..... 100 ..... 1010111 @r_vm
+vmsgt_vi        011111 . ..... ..... 011 ..... 1010111 @r_vm
+vdivu_vv        100000 . ..... ..... 010 ..... 1010111 @r_vm
+vdivu_vx        100000 . ..... ..... 110 ..... 1010111 @r_vm
+vdiv_vv         100001 . ..... ..... 010 ..... 1010111 @r_vm
+vdiv_vx         100001 . ..... ..... 110 ..... 1010111 @r_vm
+vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
+vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
+vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
+vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
+vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
+vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
+vsll_vv         100101 . ..... ..... 000 ..... 1010111 @r_vm
+vsll_vx         100101 . ..... ..... 100 ..... 1010111 @r_vm
+vsll_vi         100101 . ..... ..... 011 ..... 1010111 @r_vm
+vmul_vv         100101 . ..... ..... 010 ..... 1010111 @r_vm
+vmul_vx         100101 . ..... ..... 110 ..... 1010111 @r_vm
+vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
+vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
+vmulh_vv        100111 . ..... ..... 010 ..... 1010111 @r_vm
+vmulh_vx        100111 . ..... ..... 110 ..... 1010111 @r_vm
+vsrl_vv         101000 . ..... ..... 000 ..... 1010111 @r_vm
+vsrl_vx         101000 . ..... ..... 100 ..... 1010111 @r_vm
+vsrl_vi         101000 . ..... ..... 011 ..... 1010111 @r_vm
+vsra_vv         101001 . ..... ..... 000 ..... 1010111 @r_vm
+vsra_vx         101001 . ..... ..... 100 ..... 1010111 @r_vm
+vsra_vi         101001 . ..... ..... 011 ..... 1010111 @r_vm
+vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
+vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
+vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
+vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
+vnsrl_vv        101100 . ..... ..... 000 ..... 1010111 @r_vm
+vnsrl_vx        101100 . ..... ..... 100 ..... 1010111 @r_vm
+vnsrl_vi        101100 . ..... ..... 011 ..... 1010111 @r_vm
+vnsra_vv        101101 . ..... ..... 000 ..... 1010111 @r_vm
+vnsra_vx        101101 . ..... ..... 100 ..... 1010111 @r_vm
+vnsra_vi        101101 . ..... ..... 011 ..... 1010111 @r_vm
+vmacc_vv        101101 . ..... ..... 010 ..... 1010111 @r_vm
+vmacc_vx        101101 . ..... ..... 110 ..... 1010111 @r_vm
+vnmsac_vv       101111 . ..... ..... 010 ..... 1010111 @r_vm
+vnmsac_vx       101111 . ..... ..... 110 ..... 1010111 @r_vm
+vwaddu_vv       110000 . ..... ..... 010 ..... 1010111 @r_vm
+vwaddu_vx       110000 . ..... ..... 110 ..... 1010111 @r_vm
+vwadd_vv        110001 . ..... ..... 010 ..... 1010111 @r_vm
+vwadd_vx        110001 . ..... ..... 110 ..... 1010111 @r_vm
+vwsubu_vv       110010 . ..... ..... 010 ..... 1010111 @r_vm
+vwsubu_vx       110010 . ..... ..... 110 ..... 1010111 @r_vm
+vwsub_vv        110011 . ..... ..... 010 ..... 1010111 @r_vm
+vwsub_vx        110011 . ..... ..... 110 ..... 1010111 @r_vm
+vwaddu_wv       110100 . ..... ..... 010 ..... 1010111 @r_vm
+vwaddu_wx       110100 . ..... ..... 110 ..... 1010111 @r_vm
+vwadd_wv        110101 . ..... ..... 010 ..... 1010111 @r_vm
+vwadd_wx        110101 . ..... ..... 110 ..... 1010111 @r_vm
+vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
+vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
+vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
+vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
+vwmulu_vv       111000 . ..... ..... 010 ..... 1010111 @r_vm
+vwmulu_vx       111000 . ..... ..... 110 ..... 1010111 @r_vm
+vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
+vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
+vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
+vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
+vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
+vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index a0e1e496f2..b6f7ff3043 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -89,16 +89,31 @@ static bool vext_check_reg(DisasContext *s, uint32_t reg, bool widen)
     return !((s->lmul == 0x3 && widen) || (reg % legal));
 }
 
-static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm)
+static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
+    bool widen)
 {
-    return !(s->lmul > 1 && vm == 0 && vd == 0);
+    return (vm != 0 || vd != 0) ? true : (!widen && (s->lmul == 0));
 }
 
 static bool vext_check_nf(DisasContext *s, uint32_t nf)
 {
-    return s->lmul * (nf + 1) <= 8;
+    return (1 << s->lmul) * (nf + 1) <= 8;
 }
 
+static inline bool vext_check_overlap_group(int rd, int dlen, int rs, int slen)
+{
+    return ((rd >= rs + slen) || (rs >= rd + dlen));
+}
+
+static inline bool vext_check_overlap_carry(DisasContext *s, int rd)
+{
+    return (s->lmul == 0 ||  rd != 0);
+}
+
+static inline bool vext_check_overlap_cmp(DisasContext *s, int rd, int rs)
+{
+    return (s->lmul == 0 || rd < rs || rd >= rs + (1 << s->lmul));
+}
 /* common translation macro */
 #define GEN_VEXT_TRANS(NAME, SEQ, ARGTYPE, OP, CHECK)      \
 static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE *a)\
@@ -197,7 +212,7 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
 static bool ld_us_check(DisasContext *s, arg_r2nfvm* a)
 {
     return (vext_check_isa_ill(s, RVV) &&
-            vext_check_overlap_mask(s, a->rd, a->vm) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
             vext_check_reg(s, a->rd, false) &&
             vext_check_nf(s, a->nf));
 }
@@ -323,7 +338,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a)
 {
     return (vext_check_isa_ill(s, RVV) &&
-            vext_check_overlap_mask(s, a->rd, a->vm) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
             vext_check_reg(s, a->rd, false) &&
             vext_check_nf(s, a->nf));
 }
@@ -440,7 +455,7 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
 static bool ld_index_check(DisasContext *s, arg_rnfvm* a)
 {
     return (vext_check_isa_ill(s, RVV) &&
-            vext_check_overlap_mask(s, a->rd, a->vm) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
             vext_check_reg(s, a->rd, false) &&
             vext_check_reg(s, a->rs2, false) &&
             vext_check_nf(s, a->nf));
@@ -705,7 +720,7 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
 static bool amo_check(DisasContext *s, arg_rwdvm* a)
 {
     return (vext_check_isa_ill(s, RVV | RVA) &&
-            (a->wd ? vext_check_overlap_mask(s, a->rd, a->vm) : 1) &&
+            (a->wd ? vext_check_overlap_mask(s, a->rd, a->vm, false) : 1) &&
             vext_check_reg(s, a->rd, false) &&
             vext_check_reg(s, a->rs2, false));
 }
@@ -730,3 +745,645 @@ GEN_VEXT_TRANS(vamomaxd_v, 15, rwdvm, amo_op, amo_check)
 GEN_VEXT_TRANS(vamominud_v, 16, rwdvm, amo_op, amo_check)
 GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
 #endif
+
+/*
+ *** Vector Integer Arithmetic Instructions
+ */
+#define MAXSZ(s) (s->vlen >> (3 - s->lmul))
+
+static bool opivv_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false));
+}
+
+/* VOP.VV with GVEC IR */
+#define GEN_OPIVV_GVEC_TRANS(NAME, GVSUF)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (!opivv_check(s, a)) {                                      \
+        return false;                                              \
+    }                                                              \
+                                                                   \
+    if (a->vm && s->vl_eq_vlmax) {                                 \
+        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),      \
+            vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),              \
+            MAXSZ(s), MAXSZ(s));                                   \
+    } else {                                                       \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);   \
+        static gen_helper_gvec_4_ptr * const fns[4] = {            \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,          \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,          \
+        };                                                         \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);           \
+    }                                                              \
+    return true;                                                   \
+}
+
+GEN_OPIVV_GVEC_TRANS(vadd_vv, add)
+GEN_OPIVV_GVEC_TRANS(vsub_vv, sub)
+GEN_OPIVV_GVEC_TRANS(vand_vv, and)
+GEN_OPIVV_GVEC_TRANS(vor_vv,  or)
+GEN_OPIVV_GVEC_TRANS(vxor_vv, xor)
+GEN_OPIVV_GVEC_TRANS(vminu_vv, umin)
+GEN_OPIVV_GVEC_TRANS(vmin_vv,  smin)
+GEN_OPIVV_GVEC_TRANS(vmaxu_vv, umax)
+GEN_OPIVV_GVEC_TRANS(vmax_vv,  smax)
+GEN_OPIVV_GVEC_TRANS(vmul_vv,  mul)
+GEN_OPIVV_GVEC_TRANS(vsll_vv,  shlv)
+GEN_OPIVV_GVEC_TRANS(vsrl_vv,  shrv)
+GEN_OPIVV_GVEC_TRANS(vsra_vv,  sarv)
+
+/* VOP.VV without GVEC IR */
+#define GEN_OPIVV_TRANS(NAME, CHECK)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (CHECK(s, a)) {                                             \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);   \
+        static gen_helper_gvec_4_ptr * const fns[4] = {            \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,          \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,          \
+        };                                                         \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);           \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPIVV_TRANS(vmulh_vv, opivv_check)
+GEN_OPIVV_TRANS(vmulhu_vv, opivv_check)
+GEN_OPIVV_TRANS(vmulhsu_vv, opivv_check)
+GEN_OPIVV_TRANS(vdivu_vv, opivv_check)
+GEN_OPIVV_TRANS(vdiv_vv, opivv_check)
+GEN_OPIVV_TRANS(vremu_vv, opivv_check)
+GEN_OPIVV_TRANS(vrem_vv, opivv_check)
+GEN_OPIVV_TRANS(vmacc_vv, opivv_check)
+GEN_OPIVV_TRANS(vnmsac_vv, opivv_check)
+GEN_OPIVV_TRANS(vmadd_vv, opivv_check)
+GEN_OPIVV_TRANS(vnmsub_vv, opivv_check)
+
+static bool opivv_vmerge_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            ((a->vm == 0) || (a->rs2 == 0)));
+}
+GEN_OPIVV_TRANS(vmerge_vvm, opivv_vmerge_check)
+
+static bool opivv_vadc_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_carry(s, a->rd) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            (a->vm == 1));
+}
+GEN_OPIVV_TRANS(vadc_vvm, opivv_vadc_check)
+GEN_OPIVV_TRANS(vsbc_vvm, opivv_vadc_check)
+
+static bool opivv_vmadc_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_cmp(s, a->rd, a->rs2) &&
+            vext_check_overlap_cmp(s, a->rd, a->rs1) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            (a->vm == 1));
+}
+GEN_OPIVV_TRANS(vmadc_vvm, opivv_vmadc_check)
+GEN_OPIVV_TRANS(vmsbc_vvm, opivv_vmadc_check)
+
+static bool opivv_cmp_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_cmp(s, a->rd, a->rs2) &&
+            vext_check_overlap_cmp(s, a->rd, a->rs1) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false));
+}
+GEN_OPIVV_TRANS(vmseq_vv, opivv_cmp_check)
+GEN_OPIVV_TRANS(vmsne_vv, opivv_cmp_check)
+GEN_OPIVV_TRANS(vmsltu_vv, opivv_cmp_check)
+GEN_OPIVV_TRANS(vmslt_vv, opivv_cmp_check)
+GEN_OPIVV_TRANS(vmsleu_vv, opivv_cmp_check)
+GEN_OPIVV_TRANS(vmsle_vv, opivv_cmp_check)
+
+static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+#define GEN_OPIVV_NARROW_TRANS(NAME)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (opivv_narrow_check(s, a)) {                                \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);   \
+        static gen_helper_gvec_4_ptr * const fns[4] = {            \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,          \
+            gen_helper_##NAME##_w, NULL,                           \
+        };                                                         \
+        if (fns[s->sew] == NULL) {                                 \
+            return false;                                          \
+        }                                                          \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);           \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPIVV_NARROW_TRANS(vnsra_vv)
+GEN_OPIVV_NARROW_TRANS(vnsrl_vv)
+
+static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                1 << s->lmul) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+#define GEN_OPIVV_WIDEN_TRANS(NAME)                              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
+{                                                                \
+    if (opivv_widen_check(s, a)) {                               \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9); \
+        static gen_helper_gvec_4_ptr * const fns[4] = {          \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,        \
+            gen_helper_##NAME##_w, NULL,                         \
+        };                                                       \
+        if (fns[s->sew] == NULL) {                               \
+            return false;                                        \
+        }                                                        \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),            \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);         \
+        return true;                                             \
+    }                                                            \
+    return false;                                                \
+}
+
+GEN_OPIVV_WIDEN_TRANS(vwaddu_vv)
+GEN_OPIVV_WIDEN_TRANS(vwadd_vv)
+GEN_OPIVV_WIDEN_TRANS(vwsubu_vv)
+GEN_OPIVV_WIDEN_TRANS(vwsub_vv)
+GEN_OPIVV_WIDEN_TRANS(vwmul_vv)
+GEN_OPIVV_WIDEN_TRANS(vwmulu_vv)
+GEN_OPIVV_WIDEN_TRANS(vwmulsu_vv)
+GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv)
+GEN_OPIVV_WIDEN_TRANS(vwmacc_vv)
+GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv)
+
+static bool opiwv_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+#define GEN_OPIWV_WIDEN_TRANS(NAME)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (opiwv_widen_check(s, a)) {                                 \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);   \
+        static gen_helper_gvec_4_ptr * const fns[4] = {            \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,          \
+            gen_helper_##NAME##_w, NULL,                           \
+        };                                                         \
+        if (fns[s->sew] == NULL) {                                 \
+            return false;                                          \
+        }                                                          \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);           \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_OPIWV_WIDEN_TRANS(vwaddu_wv)
+GEN_OPIWV_WIDEN_TRANS(vwadd_wv)
+GEN_OPIWV_WIDEN_TRANS(vwsubu_wv)
+GEN_OPIWV_WIDEN_TRANS(vwsub_wv)
+
+typedef void (*gen_helper_opivx)(TCGv_ptr, TCGv_ptr, TCGv, TCGv_ptr,
+        TCGv_env, TCGv_i32);
+
+static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
+        uint32_t data, gen_helper_opivx fn, DisasContext *s)
+{
+    TCGv_ptr dest, src2, mask;
+    TCGv src1;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    src2 = tcg_temp_new_ptr();
+    src1 = tcg_temp_new();
+    gen_get_gpr(src1, rs1);
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, src1, src2, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(src2);
+    tcg_temp_free(src1);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool opivx_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false));
+}
+
+/* VOP.VX with GVEC IR */
+#define GEN_OPIVX_GVEC_TRANS(NAME, GVSUF)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                        \
+{                                                                             \
+    if (!opivx_check(s, a)) {                                                 \
+        return false;                                                         \
+    }                                                                         \
+                                                                              \
+    if (a->vm && s->vl_eq_vlmax) {                                            \
+        TCGv_i64 src1 = tcg_temp_new_i64();                                   \
+        TCGv tmp = tcg_temp_new();                                            \
+        gen_get_gpr(tmp, a->rs1);                                             \
+        tcg_gen_ext_tl_i64(src1, tmp);                                        \
+        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),                 \
+            vreg_ofs(s, a->rs2), src1, MAXSZ(s), MAXSZ(s));                   \
+        tcg_temp_free_i64(src1);                                              \
+        tcg_temp_free(tmp);                                                   \
+        return true;                                                          \
+    } else {                                                                  \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);              \
+        static gen_helper_opivx const fns[4] = {                              \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                     \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                     \
+        };                                                                    \
+        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s);      \
+    }                                                                         \
+    return true;                                                              \
+}
+
+GEN_OPIVX_GVEC_TRANS(vadd_vx, adds)
+GEN_OPIVX_GVEC_TRANS(vsub_vx, subs)
+GEN_OPIVX_GVEC_TRANS(vand_vx, ands)
+GEN_OPIVX_GVEC_TRANS(vor_vx,  ors)
+GEN_OPIVX_GVEC_TRANS(vxor_vx, xors)
+GEN_OPIVX_GVEC_TRANS(vmul_vx,  muls)
+
+#define GEN_OPIVX_GVEC_SHIFT_TRANS(NAME, GVSUF)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                        \
+{                                                                             \
+    if (!opivx_check(s, a)) {                                                 \
+        return false;                                                         \
+    }                                                                         \
+                                                                              \
+    if (a->vm && s->vl_eq_vlmax) {                                            \
+        TCGv_i32 src1 = tcg_temp_new_i32();                                   \
+        TCGv tmp = tcg_temp_new();                                            \
+        gen_get_gpr(tmp, a->rs1);                                             \
+        tcg_gen_trunc_tl_i32(src1, tmp);                                      \
+        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),                 \
+            vreg_ofs(s, a->rs2), src1, MAXSZ(s), MAXSZ(s));                   \
+        tcg_temp_free_i32(src1);                                              \
+        tcg_temp_free(tmp);                                                   \
+        return true;                                                          \
+    } else {                                                                  \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);              \
+        static gen_helper_opivx const fns[4] = {                              \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                     \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                     \
+        };                                                                    \
+        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s);      \
+    }                                                                         \
+    return true;                                                              \
+}
+
+GEN_OPIVX_GVEC_SHIFT_TRANS(vsll_vx,  shls)
+GEN_OPIVX_GVEC_SHIFT_TRANS(vsrl_vx,  shrs)
+GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
+
+/* VOP.VX without GVEC IR */
+#define GEN_OPIVX_TRANS(NAME, CHECK)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (CHECK(s, a)) {                                                   \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);         \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
+            gen_helper_##NAME##_w, gen_helper_##NAME##_d,                \
+        };                                                               \
+        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s); \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVX_TRANS(vrsub_vx, opivx_check)
+GEN_OPIVX_TRANS(vmulh_vx, opivx_check)
+GEN_OPIVX_TRANS(vmulhu_vx, opivx_check)
+GEN_OPIVX_TRANS(vmulhsu_vx, opivx_check)
+GEN_OPIVX_TRANS(vdivu_vx, opivx_check)
+GEN_OPIVX_TRANS(vdiv_vx, opivx_check)
+GEN_OPIVX_TRANS(vremu_vx, opivx_check)
+GEN_OPIVX_TRANS(vrem_vx, opivx_check)
+GEN_OPIVX_TRANS(vmacc_vx, opivx_check)
+GEN_OPIVX_TRANS(vnmsac_vx, opivx_check)
+GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
+GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
+GEN_OPIVX_TRANS(vminu_vx, opivx_check)
+GEN_OPIVX_TRANS(vmin_vx,  opivx_check)
+GEN_OPIVX_TRANS(vmaxu_vx, opivx_check)
+GEN_OPIVX_TRANS(vmax_vx,  opivx_check)
+
+static bool opivx_vmerge_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            ((a->vm == 0) || (a->rs2 == 0)));
+}
+GEN_OPIVX_TRANS(vmerge_vxm, opivx_vmerge_check)
+
+static bool opivx_vadc_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_carry(s, a->rd) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (a->vm == 1));
+}
+GEN_OPIVX_TRANS(vadc_vxm, opivx_vadc_check)
+GEN_OPIVX_TRANS(vsbc_vxm, opivx_vadc_check)
+
+static bool opivx_vmadc_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_cmp(s, a->rd, a->rs2) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (a->vm == 1));
+}
+GEN_OPIVX_TRANS(vmadc_vxm, opivx_vmadc_check)
+GEN_OPIVX_TRANS(vmsbc_vxm, opivx_vmadc_check)
+
+static bool opivx_cmp_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_cmp(s, a->rd, a->rs2) &&
+            vext_check_reg(s, a->rs2, false));
+}
+GEN_OPIVX_TRANS(vmseq_vx, opivx_cmp_check)
+GEN_OPIVX_TRANS(vmsne_vx, opivx_cmp_check)
+GEN_OPIVX_TRANS(vmsltu_vx, opivx_cmp_check)
+GEN_OPIVX_TRANS(vmslt_vx, opivx_cmp_check)
+GEN_OPIVX_TRANS(vmsleu_vx, opivx_cmp_check)
+GEN_OPIVX_TRANS(vmsle_vx, opivx_cmp_check)
+GEN_OPIVX_TRANS(vmsgtu_vx, opivx_cmp_check)
+GEN_OPIVX_TRANS(vmsgt_vx, opivx_cmp_check)
+
+static bool opivx_narrow_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+#define GEN_OPIVX_NARROW_TRANS(NAME)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (opivx_narrow_check(s, a)) {                                      \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);         \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
+            gen_helper_##NAME##_w, NULL,                                 \
+        };                                                               \
+        if (fns[s->sew] == NULL) {                                       \
+            return false;                                                \
+        }                                                                \
+        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s); \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVX_NARROW_TRANS(vnsra_vx)
+GEN_OPIVX_NARROW_TRANS(vnsrl_vx)
+
+static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+#define GEN_OPIVX_WIDEN_TRANS(NAME)                                      \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (opivx_widen_check(s, a)) {                                       \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);         \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
+            gen_helper_##NAME##_w, NULL,                                 \
+        };                                                               \
+        if (fns[s->sew] == NULL) {                                       \
+            return false;                                                \
+        }                                                                \
+        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s); \
+    }                                                                    \
+    return false;                                                        \
+}
+GEN_OPIVX_WIDEN_TRANS(vwaddu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwadd_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsubu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwsub_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmul_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmulu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmulsu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmacc_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
+
+static bool opiwx_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, true) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+#define GEN_OPIWX_WIDEN_TRANS(NAME)                                      \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (opiwx_widen_check(s, a)) {                                       \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);         \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##NAME##_b, gen_helper_##NAME##_h,                \
+            gen_helper_##NAME##_w, NULL,                                 \
+        };                                                               \
+        if (fns[s->sew] == NULL) {                                       \
+            return false;                                                \
+        }                                                                \
+        return opivx_trans(a->rd, a->rs1, a->rs2, data, fns[s->sew], s); \
+    }                                                                    \
+    return false;                                                        \
+}
+GEN_OPIWX_WIDEN_TRANS(vwaddu_wx)
+GEN_OPIWX_WIDEN_TRANS(vwadd_wx)
+GEN_OPIWX_WIDEN_TRANS(vwsubu_wx)
+GEN_OPIWX_WIDEN_TRANS(vwsub_wx)
+
+static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2,
+        uint32_t data, gen_helper_opivx fn, DisasContext *s, int zx)
+{
+    TCGv_ptr dest, src2, mask;
+    TCGv src1;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    src2 = tcg_temp_new_ptr();
+    if (zx) {
+        src1 = tcg_const_tl(imm);
+    } else {
+        src1 = tcg_const_tl(sextract64(imm, 0, 5));
+    }
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, src1, src2, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(src2);
+    tcg_temp_free(src1);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+#define GEN_OPIVI_GVEC_TRANS(NAME, ZX, OPIVX, GVSUF)                 \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)               \
+{                                                                    \
+    if (!opivx_check(s, a)) {                                        \
+        return false;                                                \
+    }                                                                \
+                                                                     \
+    if (a->vm && s->vl_eq_vlmax) {                                   \
+        tcg_gen_gvec_##GVSUF(8 << s->sew, vreg_ofs(s, a->rd),        \
+            vreg_ofs(s, a->rs2), sextract64(a->rs1, 0, 5),           \
+            MAXSZ(s), MAXSZ(s));                                     \
+        return true;                                                 \
+    } else {                                                         \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);     \
+        static gen_helper_opivx const fns[4] = {                     \
+            gen_helper_##OPIVX##_b, gen_helper_##OPIVX##_h,          \
+            gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,          \
+        };                                                           \
+        return opivi_trans(a->rd, a->rs1, a->rs2, data,              \
+                fns[s->sew], s, ZX);                                 \
+    }                                                                \
+    return true;                                                     \
+}
+GEN_OPIVI_GVEC_TRANS(vadd_vi, 0, vadd_vx, addi)
+GEN_OPIVI_GVEC_TRANS(vand_vi, 0, vand_vx, andi)
+GEN_OPIVI_GVEC_TRANS(vor_vi, 0, vor_vx,  ori)
+GEN_OPIVI_GVEC_TRANS(vxor_vi, 0, vxor_vx, xori)
+GEN_OPIVI_GVEC_TRANS(vsll_vi, 1, vsll_vx,  shli)
+GEN_OPIVI_GVEC_TRANS(vsrl_vi, 1, vsrl_vx,  shri)
+GEN_OPIVI_GVEC_TRANS(vsra_vi, 1, vsra_vx,  sari)
+
+/* VOP.VI without GVEC IR */
+#define GEN_OPIVI_TRANS(NAME, ZX, OPIVX, CHECK)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (CHECK(s, a)) {                                                   \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);         \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##OPIVX##_b, gen_helper_##OPIVX##_h,              \
+            gen_helper_##OPIVX##_w, gen_helper_##OPIVX##_d,              \
+        };                                                               \
+        return opivi_trans(a->rd, a->rs1, a->rs2, data,                  \
+                fns[s->sew], s, ZX);                                     \
+    }                                                                    \
+    return false;                                                        \
+}
+GEN_OPIVI_TRANS(vrsub_vi, 0, vrsub_vx, opivx_check)
+GEN_OPIVI_TRANS(vadc_vim, 0, vadc_vxm, opivx_vadc_check)
+GEN_OPIVI_TRANS(vmadc_vim, 0, vmadc_vxm, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmseq_vi, 0, vmseq_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsne_vi, 0, vmsne_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsleu_vi, 1, vmsleu_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsle_vi, 0, vmsle_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsgtu_vi, 1, vmsgtu_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsgt_vi, 0, vmsgt_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmerge_vim, 0, vmerge_vxm, opivx_vmerge_check)
+
+#define GEN_OPIVI_NARROW_TRANS(NAME, ZX, OPIVX)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (opivx_narrow_check(s, a)) {                                      \
+        uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9);         \
+        static gen_helper_opivx const fns[4] = {                         \
+            gen_helper_##OPIVX##_b, gen_helper_##OPIVX##_h,              \
+            gen_helper_##OPIVX##_w, NULL,                                \
+        };                                                               \
+        if (fns[s->sew] == NULL) {                                       \
+            return false;                                                \
+        }                                                                \
+        return opivi_trans(a->rd, a->rs1, a->rs2, data,                  \
+                fns[s->sew], s, ZX);                                     \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVI_NARROW_TRANS(vnsra_vi, 1, vnsra_vx)
+GEN_OPIVI_NARROW_TRANS(vnsrl_vi, 1, vnsrl_vx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe07a29cd2..bc04d9e2af 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -171,19 +171,54 @@ static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
 }
 #endif
 
-static void vext_clearl(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+static void clearb(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int8_t *cur = ((int8_t *)vd + H1(idx));
+    vext_clear(cur, cnt, tot);
+}
+
+static void clearh(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+{
+    int16_t *cur = ((int16_t *)vd + H2(idx));
+    vext_clear(cur, cnt, tot);
+}
+
+static void clearl(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
 {
     int32_t *cur = ((int32_t *)vd + H4(idx));
     vext_clear(cur, cnt, tot);
 }
 
-#ifdef TARGET_RISCV64
-static void vext_clearq(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
+static void clearq(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
 {
     int64_t *cur = (int64_t *)vd + idx;
     vext_clear(cur, cnt, tot);
 }
-#endif
+
+static inline void vext_set_elem_mask(void *v0, int mlen, int index,
+        uint8_t value)
+{
+    int idx = (index * mlen) / 8;
+    int pos = (index * mlen) % 8;
+
+    switch (mlen) {
+    case 8:
+        *((uint8_t *)v0 + H1(index)) = value;
+        break;
+    case 16:
+        *((uint16_t *)v0 + H2(index)) = value;
+        break;
+    case 32:
+        *((uint32_t *)v0 + H4(index)) = value;
+        break;
+    case 64:
+        *((uint64_t *)v0 + index) = value;
+        break;
+    default:
+        *((uint8_t *)v0 + H1(idx)) =
+            deposit32(*((uint8_t *)v0 + H1(idx)), pos, mlen, value);
+    }
+}
 
 static inline int vext_elem_mask(void *v0, int mlen, int index)
 {
@@ -1056,7 +1091,6 @@ static void vext_##NAME##_noatomic_op(void *vs3, target_ulong addr,      \
         *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
     }                                                                    \
 }
-
 GEN_VEXT_AMO_NOATOMIC_OP(vamoswapw_v_w, int32_t,  int32_t, H4, DO_SWAP, l)
 GEN_VEXT_AMO_NOATOMIC_OP(vamoaddw_v_w,  int32_t,  int32_t, H4, DO_ADD,  l)
 GEN_VEXT_AMO_NOATOMIC_OP(vamoxorw_v_w,  int32_t,  int32_t, H4, DO_XOR,  l)
@@ -1226,31 +1260,1241 @@ void HELPER(NAME)(void *vs3, void *v0, target_ulong base,       \
 }
 
 #ifdef TARGET_RISCV64
-GEN_VEXT_AMO(vamoswapw_v_d, int32_t,  int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoswapd_v_d, int64_t, int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoaddw_v_d,  int32_t,  int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoaddd_v_d,  int64_t, int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoxorw_v_d,  int32_t,  int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoxord_v_d,  int64_t, int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoandw_v_d,  int32_t,  int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoandd_v_d,  int64_t, int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoorw_v_d,   int32_t,  int64_t, vext_clearq)
-GEN_VEXT_AMO(vamoord_v_d,   int64_t, int64_t, vext_clearq)
-GEN_VEXT_AMO(vamominw_v_d,  int32_t,  int64_t, vext_clearq)
-GEN_VEXT_AMO(vamomind_v_d,  int64_t, int64_t, vext_clearq)
-GEN_VEXT_AMO(vamomaxw_v_d,  int32_t,  int64_t, vext_clearq)
-GEN_VEXT_AMO(vamomaxd_v_d,  int64_t, int64_t, vext_clearq)
-GEN_VEXT_AMO(vamominuw_v_d, uint32_t,  uint64_t, vext_clearq)
-GEN_VEXT_AMO(vamominud_v_d, uint64_t, uint64_t, vext_clearq)
-GEN_VEXT_AMO(vamomaxuw_v_d, uint32_t, uint64_t, vext_clearq)
-GEN_VEXT_AMO(vamomaxud_v_d, uint64_t, uint64_t, vext_clearq)
+GEN_VEXT_AMO(vamoswapw_v_d, int32_t,  int64_t, clearq)
+GEN_VEXT_AMO(vamoswapd_v_d, int64_t, int64_t, clearq)
+GEN_VEXT_AMO(vamoaddw_v_d,  int32_t,  int64_t, clearq)
+GEN_VEXT_AMO(vamoaddd_v_d,  int64_t, int64_t, clearq)
+GEN_VEXT_AMO(vamoxorw_v_d,  int32_t,  int64_t, clearq)
+GEN_VEXT_AMO(vamoxord_v_d,  int64_t, int64_t, clearq)
+GEN_VEXT_AMO(vamoandw_v_d,  int32_t,  int64_t, clearq)
+GEN_VEXT_AMO(vamoandd_v_d,  int64_t, int64_t, clearq)
+GEN_VEXT_AMO(vamoorw_v_d,   int32_t,  int64_t, clearq)
+GEN_VEXT_AMO(vamoord_v_d,   int64_t, int64_t, clearq)
+GEN_VEXT_AMO(vamominw_v_d,  int32_t,  int64_t, clearq)
+GEN_VEXT_AMO(vamomind_v_d,  int64_t, int64_t, clearq)
+GEN_VEXT_AMO(vamomaxw_v_d,  int32_t,  int64_t, clearq)
+GEN_VEXT_AMO(vamomaxd_v_d,  int64_t, int64_t, clearq)
+GEN_VEXT_AMO(vamominuw_v_d, uint32_t,  uint64_t, clearq)
+GEN_VEXT_AMO(vamominud_v_d, uint64_t, uint64_t, clearq)
+GEN_VEXT_AMO(vamomaxuw_v_d, uint32_t, uint64_t, clearq)
+GEN_VEXT_AMO(vamomaxud_v_d, uint64_t, uint64_t, clearq)
 #endif
-GEN_VEXT_AMO(vamoswapw_v_w, int32_t, int32_t, vext_clearl)
-GEN_VEXT_AMO(vamoaddw_v_w,  int32_t, int32_t, vext_clearl)
-GEN_VEXT_AMO(vamoxorw_v_w,  int32_t, int32_t, vext_clearl)
-GEN_VEXT_AMO(vamoandw_v_w,  int32_t, int32_t, vext_clearl)
-GEN_VEXT_AMO(vamoorw_v_w,   int32_t, int32_t, vext_clearl)
-GEN_VEXT_AMO(vamominw_v_w,  int32_t, int32_t, vext_clearl)
-GEN_VEXT_AMO(vamomaxw_v_w,  int32_t, int32_t, vext_clearl)
-GEN_VEXT_AMO(vamominuw_v_w, uint32_t, uint32_t, vext_clearl)
-GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, vext_clearl)
+GEN_VEXT_AMO(vamoswapw_v_w, int32_t, int32_t, clearl)
+GEN_VEXT_AMO(vamoaddw_v_w,  int32_t, int32_t, clearl)
+GEN_VEXT_AMO(vamoxorw_v_w,  int32_t, int32_t, clearl)
+GEN_VEXT_AMO(vamoandw_v_w,  int32_t, int32_t, clearl)
+GEN_VEXT_AMO(vamoorw_v_w,   int32_t, int32_t, clearl)
+GEN_VEXT_AMO(vamominw_v_w,  int32_t, int32_t, clearl)
+GEN_VEXT_AMO(vamomaxw_v_w,  int32_t, int32_t, clearl)
+GEN_VEXT_AMO(vamominuw_v_w, uint32_t, uint32_t, clearl)
+GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, clearl)
+
+/*
+ *** Vector Integer Arithmetic Instructions
+ */
+
+/* expand macro args before macro */
+#define RVVCALL(macro, ...)  macro(__VA_ARGS__)
+
+/* (TD, T1, T2, TX1, TX2) */
+#define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
+#define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
+#define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
+#define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
+#define OP_SSS_B int8_t, int8_t, int8_t, int8_t, int8_t
+#define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
+#define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
+#define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
+#define OP_SUS_B int8_t, uint8_t, int8_t, uint8_t, int8_t
+#define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
+#define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
+#define OP_SUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
+
+/* operation of two vector elements */
+#define GEN_OP2_VV(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)       \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    *((TD *)vd + HD(i)) = OP(s2, s1);                              \
+}
+
+#define DO_SUB(N, M) (N - M)
+#define DO_RSUB(N, M) (M - N)
+#define DO_MUL(N, M) (N * M)
+
+RVVCALL(GEN_OP2_VV, vadd_vv_b, OP_SSS_B, H1, H1, H1, DO_ADD)
+RVVCALL(GEN_OP2_VV, vadd_vv_h, OP_SSS_H, H2, H2, H2, DO_ADD)
+RVVCALL(GEN_OP2_VV, vadd_vv_w, OP_SSS_W, H4, H4, H4, DO_ADD)
+RVVCALL(GEN_OP2_VV, vadd_vv_d, OP_SSS_D, H8, H8, H8, DO_ADD)
+RVVCALL(GEN_OP2_VV, vsub_vv_b, OP_SSS_B, H1, H1, H1, DO_SUB)
+RVVCALL(GEN_OP2_VV, vsub_vv_h, OP_SSS_H, H2, H2, H2, DO_SUB)
+RVVCALL(GEN_OP2_VV, vsub_vv_w, OP_SSS_W, H4, H4, H4, DO_SUB)
+RVVCALL(GEN_OP2_VV, vsub_vv_d, OP_SSS_D, H8, H8, H8, DO_SUB)
+RVVCALL(GEN_OP2_VV, vand_vv_b, OP_SSS_B, H1, H1, H1, DO_AND)
+RVVCALL(GEN_OP2_VV, vand_vv_h, OP_SSS_H, H2, H2, H2, DO_AND)
+RVVCALL(GEN_OP2_VV, vand_vv_w, OP_SSS_W, H4, H4, H4, DO_AND)
+RVVCALL(GEN_OP2_VV, vand_vv_d, OP_SSS_D, H8, H8, H8, DO_AND)
+RVVCALL(GEN_OP2_VV, vor_vv_b, OP_SSS_B, H1, H1, H1, DO_OR)
+RVVCALL(GEN_OP2_VV, vor_vv_h, OP_SSS_H, H2, H2, H2, DO_OR)
+RVVCALL(GEN_OP2_VV, vor_vv_w, OP_SSS_W, H4, H4, H4, DO_OR)
+RVVCALL(GEN_OP2_VV, vor_vv_d, OP_SSS_D, H8, H8, H8, DO_OR)
+RVVCALL(GEN_OP2_VV, vxor_vv_b, OP_SSS_B, H1, H1, H1, DO_XOR)
+RVVCALL(GEN_OP2_VV, vxor_vv_h, OP_SSS_H, H2, H2, H2, DO_XOR)
+RVVCALL(GEN_OP2_VV, vxor_vv_w, OP_SSS_W, H4, H4, H4, DO_XOR)
+RVVCALL(GEN_OP2_VV, vxor_vv_d, OP_SSS_D, H8, H8, H8, DO_XOR)
+RVVCALL(GEN_OP2_VV, vminu_vv_b, OP_UUU_B, H1, H1, H1, DO_MIN)
+RVVCALL(GEN_OP2_VV, vminu_vv_h, OP_UUU_H, H2, H2, H2, DO_MIN)
+RVVCALL(GEN_OP2_VV, vminu_vv_w, OP_UUU_W, H4, H4, H4, DO_MIN)
+RVVCALL(GEN_OP2_VV, vminu_vv_d, OP_UUU_D, H8, H8, H8, DO_MIN)
+RVVCALL(GEN_OP2_VV, vmin_vv_b, OP_SSS_B, H1, H1, H1, DO_MIN)
+RVVCALL(GEN_OP2_VV, vmin_vv_h, OP_SSS_H, H2, H2, H2, DO_MIN)
+RVVCALL(GEN_OP2_VV, vmin_vv_w, OP_SSS_W, H4, H4, H4, DO_MIN)
+RVVCALL(GEN_OP2_VV, vmin_vv_d, OP_SSS_D, H8, H8, H8, DO_MIN)
+RVVCALL(GEN_OP2_VV, vmaxu_vv_b, OP_UUU_B, H1, H1, H1, DO_MAX)
+RVVCALL(GEN_OP2_VV, vmaxu_vv_h, OP_UUU_H, H2, H2, H2, DO_MAX)
+RVVCALL(GEN_OP2_VV, vmaxu_vv_w, OP_UUU_W, H4, H4, H4, DO_MAX)
+RVVCALL(GEN_OP2_VV, vmaxu_vv_d, OP_UUU_D, H8, H8, H8, DO_MAX)
+RVVCALL(GEN_OP2_VV, vmax_vv_b, OP_SSS_B, H1, H1, H1, DO_MAX)
+RVVCALL(GEN_OP2_VV, vmax_vv_h, OP_SSS_H, H2, H2, H2, DO_MAX)
+RVVCALL(GEN_OP2_VV, vmax_vv_w, OP_SSS_W, H4, H4, H4, DO_MAX)
+RVVCALL(GEN_OP2_VV, vmax_vv_d, OP_SSS_D, H8, H8, H8, DO_MAX)
+RVVCALL(GEN_OP2_VV, vmul_vv_b, OP_SSS_B, H1, H1, H1, DO_MUL)
+RVVCALL(GEN_OP2_VV, vmul_vv_h, OP_SSS_H, H2, H2, H2, DO_MUL)
+RVVCALL(GEN_OP2_VV, vmul_vv_w, OP_SSS_W, H4, H4, H4, DO_MUL)
+RVVCALL(GEN_OP2_VV, vmul_vv_d, OP_SSS_D, H8, H8, H8, DO_MUL)
+
+/* generate the helpers for instructions with two vector operators */
+#define GEN_VEXT_VV(NAME, ESZ, DSZ, CLEAR_FN)             \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vm = vext_vm(desc);                          \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+    for (i = 0; i < vl; i++) {                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+            continue;                                     \
+        }                                                 \
+        do_##NAME(vd, vs1, vs2, i);                       \
+    }                                                     \
+    if (i != 0) {                                         \
+        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
+    }                                                     \
+}
+
+GEN_VEXT_VV(vadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vadd_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vsub_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vsub_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vand_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vand_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vand_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vand_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vor_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vor_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vor_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vor_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vxor_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vxor_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vxor_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vxor_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vminu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vminu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vminu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vminu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmin_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmin_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmin_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmin_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmaxu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmaxu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmaxu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmaxu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmax_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmax_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmax_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmax_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmul_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmul_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmul_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmul_vv_d, 8, 8, clearq)
+
+#define DO_SLL(N, M)  (N << (M))
+#define DO_SRL(N, M)  (N >> (M))
+
+/* generate the helpers for shift instructions with two vector operators */
+#define GEN_VEXT_SHIFT_VV(NAME, TS1, TS2, HS1, HS2, OP, MASK, CLEAR_FN)   \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
+        void *vs2, CPURISCVState *env, uint32_t desc)                     \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t esz = sizeof(TS1);                                           \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                              \
+    uint32_t i;                                                           \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        TS1 s1 = *((TS1 *)vs1 + HS1(i));                                  \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                                  \
+        *((TS1 *)vd + HS1(i)) = OP(s2, s1 & MASK);                        \
+    }                                                                     \
+    if (i != 0) {                                                         \
+        CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                          \
+    }                                                                     \
+}
+
+GEN_VEXT_SHIFT_VV(vsll_vv_b, uint8_t,  uint8_t, H1, H1, DO_SLL, 0x7, clearb)
+GEN_VEXT_SHIFT_VV(vsll_vv_h, uint16_t, uint16_t, H2, H2, DO_SLL, 0xf, clearh)
+GEN_VEXT_SHIFT_VV(vsll_vv_w, uint32_t, uint32_t, H4, H4, DO_SLL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VV(vsll_vv_d, uint64_t, uint64_t, H8, H8, DO_SLL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VV(vsrl_vv_b, uint8_t, uint8_t, H1, H1, DO_SRL, 0x7, clearb)
+GEN_VEXT_SHIFT_VV(vsrl_vv_h, uint16_t, uint16_t, H2, H2, DO_SRL, 0xf, clearh)
+GEN_VEXT_SHIFT_VV(vsrl_vv_w, uint32_t, uint32_t, H4, H4, DO_SRL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VV(vsrl_vv_d, uint64_t, uint64_t, H8, H8, DO_SRL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VV(vsra_vv_b, uint8_t,  int8_t, H1, H1, DO_SRL, 0x7, clearb)
+GEN_VEXT_SHIFT_VV(vsra_vv_h, uint16_t, int16_t, H2, H2, DO_SRL, 0xf, clearh)
+GEN_VEXT_SHIFT_VV(vsra_vv_w, uint32_t, int32_t, H4, H4, DO_SRL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VV(vsra_vv_d, uint64_t, int64_t, H8, H8, DO_SRL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VV(vnsrl_vv_b, uint8_t,  uint16_t, H1, H2, DO_SRL, 0xf, clearb)
+GEN_VEXT_SHIFT_VV(vnsrl_vv_h, uint16_t, uint32_t, H2, H4, DO_SRL, 0x1f, clearh)
+GEN_VEXT_SHIFT_VV(vnsrl_vv_w, uint32_t, uint64_t, H4, H8, DO_SRL, 0x3f, clearl)
+
+GEN_VEXT_SHIFT_VV(vnsra_vv_b, uint8_t,  int16_t, H1, H2, DO_SRL, 0xf, clearb)
+GEN_VEXT_SHIFT_VV(vnsra_vv_h, uint16_t, int32_t, H2, H4, DO_SRL, 0x1f, clearh)
+GEN_VEXT_SHIFT_VV(vnsra_vv_w, uint32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
+
+static int8_t do_mulh_b(int8_t s2, int8_t s1)
+{
+    return (int16_t)s2 * (int16_t)s1 >> 8;
+}
+static int16_t do_mulh_h(int16_t s2, int16_t s1)
+{
+    return (int32_t)s2 * (int32_t)s1 >> 16;
+}
+static int32_t do_mulh_w(int32_t s2, int32_t s1)
+{
+    return (int64_t)s2 * (int64_t)s1 >> 32;
+}
+static int64_t do_mulh_d(int64_t s2, int64_t s1)
+{
+    uint64_t hi_64, lo_64;
+
+    muls64(&lo_64, &hi_64, s1, s2);
+    return hi_64;
+}
+
+static uint8_t do_mulhu_b(uint8_t s2, uint8_t s1)
+{
+    return (uint16_t)s2 * (uint16_t)s1 >> 8;
+}
+static uint16_t do_mulhu_h(uint16_t s2, uint16_t s1)
+{
+    return (uint32_t)s2 * (uint32_t)s1 >> 16;
+}
+static uint32_t do_mulhu_w(uint32_t s2, uint32_t s1)
+{
+    return (uint64_t)s2 * (uint64_t)s1 >> 32;
+}
+static uint64_t do_mulhu_d(uint64_t s2, uint64_t s1)
+{
+    uint64_t hi_64, lo_64;
+
+    mulu64(&lo_64, &hi_64, s2, s1);
+    return hi_64;
+}
+
+static int8_t do_mulhsu_b(int8_t s2, uint8_t s1)
+{
+    return (int16_t)s2 * (uint16_t)s1 >> 8;
+}
+static int16_t do_mulhsu_h(int16_t s2, uint16_t s1)
+{
+    return (int32_t)s2 * (uint32_t)s1 >> 16;
+}
+static int32_t do_mulhsu_w(int32_t s2, uint32_t s1)
+{
+    return (int64_t)s2 * (uint64_t)s1 >> 32;
+}
+static int64_t do_mulhsu_d(int64_t s2, uint64_t s1)
+{
+    uint64_t hi_64, lo_64, abs_s2 = s2;
+
+    if (s2 < 0) {
+        abs_s2 = -s2;
+    }
+    mulu64(&lo_64, &hi_64, abs_s2, s1);
+    if ((int64_t)(s2 ^ s1) < 0) {
+        lo_64 = ~lo_64;
+        hi_64 = ~hi_64;
+        if (lo_64 == UINT64_MAX) {
+            lo_64 = 0;
+            hi_64 += 1;
+        } else {
+            lo_64 += 1;
+        }
+    }
+
+    return hi_64;
+}
+
+RVVCALL(GEN_OP2_VV, vmulh_vv_b, OP_SSS_B, H1, H1, H1, do_mulh_b)
+RVVCALL(GEN_OP2_VV, vmulh_vv_h, OP_SSS_H, H2, H2, H2, do_mulh_h)
+RVVCALL(GEN_OP2_VV, vmulh_vv_w, OP_SSS_W, H4, H4, H4, do_mulh_w)
+RVVCALL(GEN_OP2_VV, vmulh_vv_d, OP_SSS_D, H8, H8, H8, do_mulh_d)
+RVVCALL(GEN_OP2_VV, vmulhu_vv_b, OP_UUU_B, H1, H1, H1, do_mulhu_b)
+RVVCALL(GEN_OP2_VV, vmulhu_vv_h, OP_UUU_H, H2, H2, H2, do_mulhu_h)
+RVVCALL(GEN_OP2_VV, vmulhu_vv_w, OP_UUU_W, H4, H4, H4, do_mulhu_w)
+RVVCALL(GEN_OP2_VV, vmulhu_vv_d, OP_UUU_D, H8, H8, H8, do_mulhu_d)
+RVVCALL(GEN_OP2_VV, vmulhsu_vv_b, OP_SUS_B, H1, H1, H1, do_mulhsu_b)
+RVVCALL(GEN_OP2_VV, vmulhsu_vv_h, OP_SUS_H, H2, H2, H2, do_mulhsu_h)
+RVVCALL(GEN_OP2_VV, vmulhsu_vv_w, OP_SUS_W, H4, H4, H4, do_mulhsu_w)
+RVVCALL(GEN_OP2_VV, vmulhsu_vv_d, OP_SUS_D, H8, H8, H8, do_mulhsu_d)
+
+GEN_VEXT_VV(vmulh_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmulh_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmulh_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmulh_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmulhu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmulhu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmulhu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmulhu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vmulhsu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmulhsu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmulhsu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmulhsu_vv_d, 8, 8, clearq)
+
+#define DO_DIVU(N, M) (unlikely(M == 0) ? (__typeof(N))(-1) : N / M)
+#define DO_REMU(N, M) (unlikely(M == 0) ? N : N % M)
+#define DO_DIV(N, M)  (unlikely(M == 0) ? (__typeof(N))(-1) :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
+#define DO_REM(N, M)  (unlikely(M == 0) ? N :\
+        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
+
+RVVCALL(GEN_OP2_VV, vdivu_vv_b, OP_UUU_B, H1, H1, H1, DO_DIVU)
+RVVCALL(GEN_OP2_VV, vdivu_vv_h, OP_UUU_H, H2, H2, H2, DO_DIVU)
+RVVCALL(GEN_OP2_VV, vdivu_vv_w, OP_UUU_W, H4, H4, H4, DO_DIVU)
+RVVCALL(GEN_OP2_VV, vdivu_vv_d, OP_UUU_D, H8, H8, H8, DO_DIVU)
+RVVCALL(GEN_OP2_VV, vdiv_vv_b, OP_SSS_B, H1, H1, H1, DO_DIV)
+RVVCALL(GEN_OP2_VV, vdiv_vv_h, OP_SSS_H, H2, H2, H2, DO_DIV)
+RVVCALL(GEN_OP2_VV, vdiv_vv_w, OP_SSS_W, H4, H4, H4, DO_DIV)
+RVVCALL(GEN_OP2_VV, vdiv_vv_d, OP_SSS_D, H8, H8, H8, DO_DIV)
+RVVCALL(GEN_OP2_VV, vremu_vv_b, OP_UUU_B, H1, H1, H1, DO_REMU)
+RVVCALL(GEN_OP2_VV, vremu_vv_h, OP_UUU_H, H2, H2, H2, DO_REMU)
+RVVCALL(GEN_OP2_VV, vremu_vv_w, OP_UUU_W, H4, H4, H4, DO_REMU)
+RVVCALL(GEN_OP2_VV, vremu_vv_d, OP_UUU_D, H8, H8, H8, DO_REMU)
+RVVCALL(GEN_OP2_VV, vrem_vv_b, OP_SSS_B, H1, H1, H1, DO_REM)
+RVVCALL(GEN_OP2_VV, vrem_vv_h, OP_SSS_H, H2, H2, H2, DO_REM)
+RVVCALL(GEN_OP2_VV, vrem_vv_w, OP_SSS_W, H4, H4, H4, DO_REM)
+RVVCALL(GEN_OP2_VV, vrem_vv_d, OP_SSS_D, H8, H8, H8, DO_REM)
+
+GEN_VEXT_VV(vdivu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vdivu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vdivu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vdivu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vdiv_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vdiv_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vdiv_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vdiv_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vremu_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vremu_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vremu_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vremu_vv_d, 8, 8, clearq)
+GEN_VEXT_VV(vrem_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vrem_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vrem_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vrem_vv_d, 8, 8, clearq)
+
+#define GEN_OP3_VV(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
+static void do_##NAME(void *vd, void *vs1, void *vs2, int i)       \
+{                                                                  \
+    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(s2, s1, d);                           \
+}
+
+#define DO_MACC(N, M, D) (M * N + D)
+#define DO_NMSAC(N, M, D) (-(M * N) + D)
+#define DO_MADD(N, M, D) (M * D + N)
+#define DO_NMSUB(N, M, D) (-(M * D) + N)
+
+RVVCALL(GEN_OP3_VV, vmacc_vv_b, OP_SSS_B, H1, H1, H1, DO_MACC)
+RVVCALL(GEN_OP3_VV, vmacc_vv_h, OP_SSS_H, H2, H2, H2, DO_MACC)
+RVVCALL(GEN_OP3_VV, vmacc_vv_w, OP_SSS_W, H4, H4, H4, DO_MACC)
+RVVCALL(GEN_OP3_VV, vmacc_vv_d, OP_SSS_D, H8, H8, H8, DO_MACC)
+
+RVVCALL(GEN_OP3_VV, vnmsac_vv_b, OP_SSS_B, H1, H1, H1, DO_NMSAC)
+RVVCALL(GEN_OP3_VV, vnmsac_vv_h, OP_SSS_H, H2, H2, H2, DO_NMSAC)
+RVVCALL(GEN_OP3_VV, vnmsac_vv_w, OP_SSS_W, H4, H4, H4, DO_NMSAC)
+RVVCALL(GEN_OP3_VV, vnmsac_vv_d, OP_SSS_D, H8, H8, H8, DO_NMSAC)
+
+RVVCALL(GEN_OP3_VV, vmadd_vv_b, OP_SSS_B, H1, H1, H1, DO_MADD)
+RVVCALL(GEN_OP3_VV, vmadd_vv_h, OP_SSS_H, H2, H2, H2, DO_MADD)
+RVVCALL(GEN_OP3_VV, vmadd_vv_w, OP_SSS_W, H4, H4, H4, DO_MADD)
+RVVCALL(GEN_OP3_VV, vmadd_vv_d, OP_SSS_D, H8, H8, H8, DO_MADD)
+
+RVVCALL(GEN_OP3_VV, vnmsub_vv_b, OP_SSS_B, H1, H1, H1, DO_NMSUB)
+RVVCALL(GEN_OP3_VV, vnmsub_vv_h, OP_SSS_H, H2, H2, H2, DO_NMSUB)
+RVVCALL(GEN_OP3_VV, vnmsub_vv_w, OP_SSS_W, H4, H4, H4, DO_NMSUB)
+RVVCALL(GEN_OP3_VV, vnmsub_vv_d, OP_SSS_D, H8, H8, H8, DO_NMSUB)
+
+GEN_VEXT_VV(vmacc_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmacc_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmacc_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmacc_vv_d, 8, 8, clearq)
+
+GEN_VEXT_VV(vnmsac_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vnmsac_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vnmsac_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vnmsac_vv_d, 8, 8, clearq)
+
+GEN_VEXT_VV(vmadd_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vmadd_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vmadd_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vmadd_vv_d, 8, 8, clearq)
+
+GEN_VEXT_VV(vnmsub_vv_b, 1, 1, clearb)
+GEN_VEXT_VV(vnmsub_vv_h, 2, 2, clearh)
+GEN_VEXT_VV(vnmsub_vv_w, 4, 4, clearl)
+GEN_VEXT_VV(vnmsub_vv_d, 8, 8, clearq)
+
+#define GEN_VMERGE_VV(NAME, ETYPE, H, CLEAR_FN)                      \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
+        CPURISCVState *env, uint32_t desc)                           \
+{                                                                    \
+    uint32_t mlen = vext_mlen(desc);                                 \
+    uint32_t vm = vext_vm(desc);                                     \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    for (i = 0; i < vl; i++) {                                       \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                   \
+            ETYPE s2 = *((ETYPE *)vs2 + H(i));                       \
+            *((ETYPE *)vd + H1(i)) = s2;                             \
+        } else {                                                     \
+            ETYPE s1 = *((ETYPE *)vs1 + H(i));                       \
+            *((ETYPE *)vd + H(i)) = s1;                              \
+        }                                                            \
+    }                                                                \
+    if (i != 0) {                                                    \
+        CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                     \
+    }                                                                \
+}
+
+GEN_VMERGE_VV(vmerge_vvm_b, int8_t,  H1, clearb)
+GEN_VMERGE_VV(vmerge_vvm_h, int16_t, H2, clearh)
+GEN_VMERGE_VV(vmerge_vvm_w, int32_t, H4, clearl)
+GEN_VMERGE_VV(vmerge_vvm_d, int64_t, H8, clearq)
+
+/*
+ * If XLEN<SEW, the value from the x register is sign-extended to SEW bits.
+ * So (target_long)s1 is need. (T1)(target_long)s1 gives the real operator type.
+ * (TX1)(T1)(target_long)s1 expands the operator type of widen operations
+ * or narrow operations
+ */
+#define GEN_OP2_VX(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)        \
+static void do_##NAME(void *vd, target_ulong s1, void *vs2, int i) \
+{                                                                  \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)(target_long)s1);        \
+}
+
+#define OP_UXUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
+#define OP_UXUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
+#define OP_UXUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
+#define OP_UXUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
+#define OP_SXSS_B int8_t, int8_t, int8_t, int8_t, int8_t
+#define OP_SXSS_H int16_t, int16_t, int16_t, int16_t, int16_t
+#define OP_SXSS_W int32_t, int32_t, int32_t, int32_t, int32_t
+#define OP_SXSS_D int64_t, int64_t, int64_t, int64_t, int64_t
+#define OP_SXUS_B int8_t, uint8_t, int8_t, uint8_t, int8_t
+#define OP_SXUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
+#define OP_SXUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
+#define OP_SXUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
+
+RVVCALL(GEN_OP2_VX, vadd_vx_b, OP_SXSS_B, H1, H1, DO_ADD)
+RVVCALL(GEN_OP2_VX, vadd_vx_h, OP_SXSS_H, H2, H2, DO_ADD)
+RVVCALL(GEN_OP2_VX, vadd_vx_w, OP_SXSS_W, H4, H4, DO_ADD)
+RVVCALL(GEN_OP2_VX, vadd_vx_d, OP_SXSS_D, H8, H8, DO_ADD)
+RVVCALL(GEN_OP2_VX, vsub_vx_b, OP_SXSS_B, H1, H1, DO_SUB)
+RVVCALL(GEN_OP2_VX, vsub_vx_h, OP_SXSS_H, H2, H2, DO_SUB)
+RVVCALL(GEN_OP2_VX, vsub_vx_w, OP_SXSS_W, H4, H4, DO_SUB)
+RVVCALL(GEN_OP2_VX, vsub_vx_d, OP_SXSS_D, H8, H8, DO_SUB)
+RVVCALL(GEN_OP2_VX, vrsub_vx_b, OP_SXSS_B, H1, H1, DO_RSUB)
+RVVCALL(GEN_OP2_VX, vrsub_vx_h, OP_SXSS_H, H2, H2, DO_RSUB)
+RVVCALL(GEN_OP2_VX, vrsub_vx_w, OP_SXSS_W, H4, H4, DO_RSUB)
+RVVCALL(GEN_OP2_VX, vrsub_vx_d, OP_SXSS_D, H8, H8, DO_RSUB)
+RVVCALL(GEN_OP2_VX, vand_vx_b, OP_SXSS_B, H1, H1, DO_AND)
+RVVCALL(GEN_OP2_VX, vand_vx_h, OP_SXSS_H, H2, H2, DO_AND)
+RVVCALL(GEN_OP2_VX, vand_vx_w, OP_SXSS_W, H4, H4, DO_AND)
+RVVCALL(GEN_OP2_VX, vand_vx_d, OP_SXSS_D, H8, H8, DO_AND)
+RVVCALL(GEN_OP2_VX, vor_vx_b, OP_SXSS_B, H1, H1, DO_OR)
+RVVCALL(GEN_OP2_VX, vor_vx_h, OP_SXSS_H, H2, H2, DO_OR)
+RVVCALL(GEN_OP2_VX, vor_vx_w, OP_SXSS_W, H4, H4, DO_OR)
+RVVCALL(GEN_OP2_VX, vor_vx_d, OP_SXSS_D, H8, H8, DO_OR)
+RVVCALL(GEN_OP2_VX, vxor_vx_b, OP_SXSS_B, H1, H1, DO_XOR)
+RVVCALL(GEN_OP2_VX, vxor_vx_h, OP_SXSS_H, H2, H2, DO_XOR)
+RVVCALL(GEN_OP2_VX, vxor_vx_w, OP_SXSS_W, H4, H4, DO_XOR)
+RVVCALL(GEN_OP2_VX, vxor_vx_d, OP_SXSS_D, H8, H8, DO_XOR)
+RVVCALL(GEN_OP2_VX, vminu_vx_b, OP_UXUU_B, H1, H1, DO_MIN)
+RVVCALL(GEN_OP2_VX, vminu_vx_h, OP_UXUU_H, H2, H2, DO_MIN)
+RVVCALL(GEN_OP2_VX, vminu_vx_w, OP_UXUU_W, H4, H4, DO_MIN)
+RVVCALL(GEN_OP2_VX, vminu_vx_d, OP_UXUU_D, H8, H8, DO_MIN)
+RVVCALL(GEN_OP2_VX, vmin_vx_b, OP_SXSS_B, H1, H1, DO_MIN)
+RVVCALL(GEN_OP2_VX, vmin_vx_h, OP_SXSS_H, H2, H2, DO_MIN)
+RVVCALL(GEN_OP2_VX, vmin_vx_w, OP_SXSS_W, H4, H4, DO_MIN)
+RVVCALL(GEN_OP2_VX, vmin_vx_d, OP_SXSS_D, H8, H8, DO_MIN)
+RVVCALL(GEN_OP2_VX, vmaxu_vx_b, OP_UXUU_B, H1, H1, DO_MAX)
+RVVCALL(GEN_OP2_VX, vmaxu_vx_h, OP_UXUU_H, H2, H2, DO_MAX)
+RVVCALL(GEN_OP2_VX, vmaxu_vx_w, OP_UXUU_W, H4, H4, DO_MAX)
+RVVCALL(GEN_OP2_VX, vmaxu_vx_d, OP_UXUU_D, H8, H8, DO_MAX)
+RVVCALL(GEN_OP2_VX, vmax_vx_b, OP_SXSS_B, H1, H1, DO_MAX)
+RVVCALL(GEN_OP2_VX, vmax_vx_h, OP_SXSS_H, H2, H2, DO_MAX)
+RVVCALL(GEN_OP2_VX, vmax_vx_w, OP_SXSS_W, H4, H4, DO_MAX)
+RVVCALL(GEN_OP2_VX, vmax_vx_d, OP_SXSS_D, H8, H8, DO_MAX)
+RVVCALL(GEN_OP2_VX, vmul_vx_b, OP_SXSS_B, H1, H1, DO_MUL)
+RVVCALL(GEN_OP2_VX, vmul_vx_h, OP_SXSS_H, H2, H2, DO_MUL)
+RVVCALL(GEN_OP2_VX, vmul_vx_w, OP_SXSS_W, H4, H4, DO_MUL)
+RVVCALL(GEN_OP2_VX, vmul_vx_d, OP_SXSS_D, H8, H8, DO_MUL)
+RVVCALL(GEN_OP2_VX, vmulh_vx_b, OP_SXSS_B, H1, H1, do_mulh_b)
+RVVCALL(GEN_OP2_VX, vmulh_vx_h, OP_SXSS_H, H2, H2, do_mulh_h)
+RVVCALL(GEN_OP2_VX, vmulh_vx_w, OP_SXSS_W, H4, H4, do_mulh_w)
+RVVCALL(GEN_OP2_VX, vmulh_vx_d, OP_SXSS_D, H8, H8, do_mulh_d)
+RVVCALL(GEN_OP2_VX, vmulhu_vx_b, OP_UXUU_B, H1, H1, do_mulhu_b)
+RVVCALL(GEN_OP2_VX, vmulhu_vx_h, OP_UXUU_H, H2, H2, do_mulhu_h)
+RVVCALL(GEN_OP2_VX, vmulhu_vx_w, OP_UXUU_W, H4, H4, do_mulhu_w)
+RVVCALL(GEN_OP2_VX, vmulhu_vx_d, OP_UXUU_D, H8, H8, do_mulhu_d)
+RVVCALL(GEN_OP2_VX, vmulhsu_vx_b, OP_SXUS_B, H1, H1, do_mulhsu_b)
+RVVCALL(GEN_OP2_VX, vmulhsu_vx_h, OP_SXUS_H, H2, H2, do_mulhsu_h)
+RVVCALL(GEN_OP2_VX, vmulhsu_vx_w, OP_SXUS_W, H4, H4, do_mulhsu_w)
+RVVCALL(GEN_OP2_VX, vmulhsu_vx_d, OP_SXUS_D, H8, H8, do_mulhsu_d)
+RVVCALL(GEN_OP2_VX, vdivu_vx_b, OP_UXUU_B, H1, H1, DO_DIVU)
+RVVCALL(GEN_OP2_VX, vdivu_vx_h, OP_UXUU_H, H2, H2, DO_DIVU)
+RVVCALL(GEN_OP2_VX, vdivu_vx_w, OP_UXUU_W, H4, H4, DO_DIVU)
+RVVCALL(GEN_OP2_VX, vdivu_vx_d, OP_UXUU_D, H8, H8, DO_DIVU)
+RVVCALL(GEN_OP2_VX, vdiv_vx_b, OP_SXSS_B, H1, H1, DO_DIV)
+RVVCALL(GEN_OP2_VX, vdiv_vx_h, OP_SXSS_H, H2, H2, DO_DIV)
+RVVCALL(GEN_OP2_VX, vdiv_vx_w, OP_SXSS_W, H4, H4, DO_DIV)
+RVVCALL(GEN_OP2_VX, vdiv_vx_d, OP_SXSS_D, H8, H8, DO_DIV)
+RVVCALL(GEN_OP2_VX, vremu_vx_b, OP_UXUU_B, H1, H1, DO_REMU)
+RVVCALL(GEN_OP2_VX, vremu_vx_h, OP_UXUU_H, H2, H2, DO_REMU)
+RVVCALL(GEN_OP2_VX, vremu_vx_w, OP_UXUU_W, H4, H4, DO_REMU)
+RVVCALL(GEN_OP2_VX, vremu_vx_d, OP_UXUU_D, H8, H8, DO_REMU)
+RVVCALL(GEN_OP2_VX, vrem_vx_b, OP_SXSS_B, H1, H1, DO_REM)
+RVVCALL(GEN_OP2_VX, vrem_vx_h, OP_SXSS_H, H2, H2, DO_REM)
+RVVCALL(GEN_OP2_VX, vrem_vx_w, OP_SXSS_W, H4, H4, DO_REM)
+RVVCALL(GEN_OP2_VX, vrem_vx_d, OP_SXSS_D, H8, H8, DO_REM)
+
+/* generate the helpers for instructions with one vector and one sclar */
+#define GEN_VEXT_VX(NAME, ESZ, DSZ, CLEAR_FN)             \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
+        void *vs2, CPURISCVState *env, uint32_t desc)     \
+{                                                         \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vm = vext_vm(desc);                          \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+                                                          \
+    for (i = 0; i < vl; i++) {                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+            continue;                                     \
+        }                                                 \
+        do_##NAME(vd, s1, vs2, i);                        \
+    }                                                     \
+    if (i != 0) {                                         \
+        CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);         \
+    }                                                     \
+}
+
+GEN_VEXT_VX(vadd_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vadd_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vadd_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vadd_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vsub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vsub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vsub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vsub_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vrsub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vrsub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vrsub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vrsub_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vand_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vand_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vand_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vand_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vor_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vor_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vor_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vor_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vxor_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vxor_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vxor_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vxor_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vminu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vminu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vminu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vminu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmin_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmin_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmin_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmin_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmaxu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmaxu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmaxu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmaxu_vx_d, 8, 8,  clearq)
+GEN_VEXT_VX(vmax_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmax_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmax_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmax_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmul_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmul_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmul_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmul_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmulh_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmulh_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmulh_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmulh_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmulhu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmulhu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmulhu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmulhu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmulhsu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmulhsu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmulhsu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmulhsu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vdivu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vdivu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vdivu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vdivu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vdiv_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vdiv_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vdiv_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vdiv_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vremu_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vremu_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vremu_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vremu_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vrem_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vrem_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vrem_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vrem_vx_d, 8, 8, clearq)
+
+/* generate the helpers for shift instructions with one vector and one sclar */
+#define GEN_VEXT_SHIFT_VX(NAME, TD, TS2, HD, HS2, OP, MASK, CLEAR_FN) \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
+        void *vs2, CPURISCVState *env, uint32_t desc)                 \
+{                                                                     \
+    uint32_t mlen = vext_mlen(desc);                                  \
+    uint32_t vm = vext_vm(desc);                                      \
+    uint32_t vl = env->vl;                                            \
+    uint32_t esz = sizeof(TD);                                        \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                          \
+    uint32_t i;                                                       \
+                                                                      \
+    for (i = 0; i < vl; i++) {                                        \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                    \
+            continue;                                                 \
+        }                                                             \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                              \
+        *((TD *)vd + HD(i)) = OP(s2, s1 & MASK);                      \
+    }                                                                 \
+    if (i != 0) {                                                     \
+        CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                      \
+    }                                                                 \
+}
+
+GEN_VEXT_SHIFT_VX(vsll_vx_b, uint8_t, int8_t, H1, H1, DO_SLL, 0x7, clearb)
+GEN_VEXT_SHIFT_VX(vsll_vx_h, uint16_t, int16_t, H2, H2, DO_SLL, 0xf, clearh)
+GEN_VEXT_SHIFT_VX(vsll_vx_w, uint32_t, int32_t, H4, H4, DO_SLL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VX(vsll_vx_d, uint64_t, int64_t, H8, H8, DO_SLL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VX(vsrl_vx_b, uint8_t, uint8_t, H1, H1, DO_SRL, 0x7, clearb)
+GEN_VEXT_SHIFT_VX(vsrl_vx_h, uint16_t, uint16_t, H2, H2, DO_SRL, 0xf, clearh)
+GEN_VEXT_SHIFT_VX(vsrl_vx_w, uint32_t, uint32_t, H4, H4, DO_SRL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VX(vsrl_vx_d, uint64_t, uint64_t, H8, H8, DO_SRL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VX(vsra_vx_b, int8_t, int8_t, H1, H1, DO_SRL, 0x7, clearb)
+GEN_VEXT_SHIFT_VX(vsra_vx_h, int16_t, int16_t, H2, H2, DO_SRL, 0xf, clearh)
+GEN_VEXT_SHIFT_VX(vsra_vx_w, int32_t, int32_t, H4, H4, DO_SRL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VX(vsra_vx_d, int64_t, int64_t, H8, H8, DO_SRL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VX(vnsrl_vx_b, uint8_t, uint16_t, H1, H2, DO_SRL, 0xf, clearb)
+GEN_VEXT_SHIFT_VX(vnsrl_vx_h, uint16_t, uint32_t, H2, H4, DO_SRL, 0x1f, clearh)
+GEN_VEXT_SHIFT_VX(vnsrl_vx_w, uint32_t, uint64_t, H4, H8, DO_SRL, 0x3f, clearl)
+
+GEN_VEXT_SHIFT_VX(vnsra_vx_b, int8_t, int16_t, H1, H2, DO_SRL, 0xf, clearb)
+GEN_VEXT_SHIFT_VX(vnsra_vx_h, int16_t, int32_t, H2, H4, DO_SRL, 0x1f, clearh)
+GEN_VEXT_SHIFT_VX(vnsra_vx_w, int32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
+
+#define GEN_OP3_VX(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)        \
+static void do_##NAME(void *vd, target_ulong s1, void *vs2, int i) \
+{                                                                  \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
+    TD d = *((TD *)vd + HD(i));                                    \
+    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)(target_long)s1, d);     \
+}
+
+RVVCALL(GEN_OP3_VX, vmacc_vx_b, OP_SXSS_B, H1, H1, DO_MACC)
+RVVCALL(GEN_OP3_VX, vmacc_vx_h, OP_SXSS_H, H2, H2, DO_MACC)
+RVVCALL(GEN_OP3_VX, vmacc_vx_w, OP_SXSS_W, H4, H4, DO_MACC)
+RVVCALL(GEN_OP3_VX, vmacc_vx_d, OP_SXSS_D, H8, H8, DO_MACC)
+RVVCALL(GEN_OP3_VX, vnmsac_vx_b, OP_SXSS_B, H1, H1, DO_NMSAC)
+RVVCALL(GEN_OP3_VX, vnmsac_vx_h, OP_SXSS_H, H2, H2, DO_NMSAC)
+RVVCALL(GEN_OP3_VX, vnmsac_vx_w, OP_SXSS_W, H4, H4, DO_NMSAC)
+RVVCALL(GEN_OP3_VX, vnmsac_vx_d, OP_SXSS_D, H8, H8, DO_NMSAC)
+RVVCALL(GEN_OP3_VX, vmadd_vx_b, OP_SXSS_B, H1, H1, DO_MADD)
+RVVCALL(GEN_OP3_VX, vmadd_vx_h, OP_SXSS_H, H2, H2, DO_MADD)
+RVVCALL(GEN_OP3_VX, vmadd_vx_w, OP_SXSS_W, H4, H4, DO_MADD)
+RVVCALL(GEN_OP3_VX, vmadd_vx_d, OP_SXSS_D, H8, H8, DO_MADD)
+RVVCALL(GEN_OP3_VX, vnmsub_vx_b, OP_SXSS_B, H1, H1, DO_NMSUB)
+RVVCALL(GEN_OP3_VX, vnmsub_vx_h, OP_SXSS_H, H2, H2, DO_NMSUB)
+RVVCALL(GEN_OP3_VX, vnmsub_vx_w, OP_SXSS_W, H4, H4, DO_NMSUB)
+RVVCALL(GEN_OP3_VX, vnmsub_vx_d, OP_SXSS_D, H8, H8, DO_NMSUB)
+
+GEN_VEXT_VX(vmacc_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmacc_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmacc_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmacc_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vnmsac_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vnmsac_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vnmsac_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vnmsac_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vmadd_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vmadd_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vmadd_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vmadd_vx_d, 8, 8, clearq)
+GEN_VEXT_VX(vnmsub_vx_b, 1, 1, clearb)
+GEN_VEXT_VX(vnmsub_vx_h, 2, 2, clearh)
+GEN_VEXT_VX(vnmsub_vx_w, 4, 4, clearl)
+GEN_VEXT_VX(vnmsub_vx_d, 8, 8, clearq)
+
+#define GEN_VMERGE_VX(NAME, ETYPE, H, CLEAR_FN)                      \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
+        void *vs2, CPURISCVState *env, uint32_t desc)                \
+{                                                                    \
+    uint32_t mlen = vext_mlen(desc);                                 \
+    uint32_t vm = vext_vm(desc);                                     \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    for (i = 0; i < vl; i++) {                                       \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                   \
+            ETYPE s2 = *((ETYPE *)vs2 + H(i));                       \
+            *((ETYPE *)vd + H1(i)) = s2;                             \
+        } else {                                                     \
+            *((ETYPE *)vd + H(i)) = (ETYPE)(target_long)s1;          \
+        }                                                            \
+    }                                                                \
+    if (i != 0) {                                                    \
+        CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                     \
+    }                                                                \
+}
+
+GEN_VMERGE_VX(vmerge_vxm_b, int8_t,  H1, clearb)
+GEN_VMERGE_VX(vmerge_vxm_h, int16_t, H2, clearh)
+GEN_VMERGE_VX(vmerge_vxm_w, int32_t, H4, clearl)
+GEN_VMERGE_VX(vmerge_vxm_d, int64_t, H8, clearq)
+
+#define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
+#define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
+#define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
+#define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
+#define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
+#define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
+#define WOP_SUS_B int16_t, uint8_t, int8_t, uint16_t, int16_t
+#define WOP_SUS_H int32_t, uint16_t, int16_t, uint32_t, int32_t
+#define WOP_SUS_W int64_t, uint32_t, int32_t, uint64_t, int64_t
+#define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
+#define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
+#define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
+#define WOP_WUUU_B  uint16_t, uint8_t, uint16_t, uint16_t, uint16_t
+#define WOP_WUUU_H  uint32_t, uint16_t, uint32_t, uint32_t, uint32_t
+#define WOP_WUUU_W  uint64_t, uint32_t, uint64_t, uint64_t, uint64_t
+#define WOP_WSSS_B  int16_t, int8_t, int16_t, int16_t, int16_t
+#define WOP_WSSS_H  int32_t, int16_t, int32_t, int32_t, int32_t
+#define WOP_WSSS_W  int64_t, int32_t, int64_t, int64_t, int64_t
+
+RVVCALL(GEN_OP2_VV, vwaddu_vv_b, WOP_UUU_B, H2, H1, H1, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwaddu_vv_h, WOP_UUU_H, H4, H2, H2, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwaddu_vv_w, WOP_UUU_W, H8, H4, H4, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwsubu_vv_b, WOP_UUU_B, H2, H1, H1, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwsubu_vv_h, WOP_UUU_H, H4, H2, H2, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwsubu_vv_w, WOP_UUU_W, H8, H4, H4, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwadd_vv_b, WOP_SSS_B, H2, H1, H1, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwadd_vv_h, WOP_SSS_H, H4, H2, H2, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwadd_vv_w, WOP_SSS_W, H8, H4, H4, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwsub_vv_b, WOP_SSS_B, H2, H1, H1, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwsub_vv_h, WOP_SSS_H, H4, H2, H2, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwsub_vv_w, WOP_SSS_W, H8, H4, H4, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwaddu_wv_b, WOP_WUUU_B, H2, H1, H1, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwaddu_wv_h, WOP_WUUU_H, H4, H2, H2, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwaddu_wv_w, WOP_WUUU_W, H8, H4, H4, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwsubu_wv_b, WOP_WUUU_B, H2, H1, H1, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwsubu_wv_h, WOP_WUUU_H, H4, H2, H2, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwsubu_wv_w, WOP_WUUU_W, H8, H4, H4, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwadd_wv_b, WOP_WSSS_B, H2, H1, H1, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwadd_wv_h, WOP_WSSS_H, H4, H2, H2, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwadd_wv_w, WOP_WSSS_W, H8, H4, H4, DO_ADD)
+RVVCALL(GEN_OP2_VV, vwsub_wv_b, WOP_WSSS_B, H2, H1, H1, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwsub_wv_h, WOP_WSSS_H, H4, H2, H2, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwsub_wv_w, WOP_WSSS_W, H8, H4, H4, DO_SUB)
+RVVCALL(GEN_OP2_VV, vwmul_vv_b, WOP_SSS_B, H2, H1, H1, DO_MUL)
+RVVCALL(GEN_OP2_VV, vwmul_vv_h, WOP_SSS_H, H4, H2, H2, DO_MUL)
+RVVCALL(GEN_OP2_VV, vwmul_vv_w, WOP_SSS_W, H8, H4, H4, DO_MUL)
+RVVCALL(GEN_OP2_VV, vwmulu_vv_b, WOP_UUU_B, H2, H1, H1, DO_MUL)
+RVVCALL(GEN_OP2_VV, vwmulu_vv_h, WOP_UUU_H, H4, H2, H2, DO_MUL)
+RVVCALL(GEN_OP2_VV, vwmulu_vv_w, WOP_UUU_W, H8, H4, H4, DO_MUL)
+RVVCALL(GEN_OP2_VV, vwmulsu_vv_b, WOP_SUS_B, H2, H1, H1, DO_MUL)
+RVVCALL(GEN_OP2_VV, vwmulsu_vv_h, WOP_SUS_H, H4, H2, H2, DO_MUL)
+RVVCALL(GEN_OP2_VV, vwmulsu_vv_w, WOP_SUS_W, H8, H4, H4, DO_MUL)
+RVVCALL(GEN_OP3_VV, vwmaccu_vv_b, WOP_UUU_B, H2, H1, H1, DO_MACC)
+RVVCALL(GEN_OP3_VV, vwmaccu_vv_h, WOP_UUU_H, H4, H2, H2, DO_MACC)
+RVVCALL(GEN_OP3_VV, vwmaccu_vv_w, WOP_UUU_W, H8, H4, H4, DO_MACC)
+RVVCALL(GEN_OP3_VV, vwmacc_vv_b, WOP_SSS_B, H2, H1, H1, DO_MACC)
+RVVCALL(GEN_OP3_VV, vwmacc_vv_h, WOP_SSS_H, H4, H2, H2, DO_MACC)
+RVVCALL(GEN_OP3_VV, vwmacc_vv_w, WOP_SSS_W, H8, H4, H4, DO_MACC)
+RVVCALL(GEN_OP3_VV, vwmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, DO_MACC)
+RVVCALL(GEN_OP3_VV, vwmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, DO_MACC)
+RVVCALL(GEN_OP3_VV, vwmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, DO_MACC)
+
+GEN_VEXT_VV(vwaddu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwaddu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwaddu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwsubu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwsubu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwsubu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwadd_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwadd_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwadd_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwsub_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwsub_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwsub_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwaddu_wv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwaddu_wv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwaddu_wv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwsubu_wv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwsubu_wv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwsubu_wv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwadd_wv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwadd_wv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwadd_wv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwsub_wv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwsub_wv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwsub_wv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmul_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmul_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmul_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmulu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmulu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmulu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmulsu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmulsu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmulsu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmaccu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmaccu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmaccu_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmacc_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmacc_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmacc_vv_w, 4, 8, clearq)
+GEN_VEXT_VV(vwmaccsu_vv_b, 1, 2, clearh)
+GEN_VEXT_VV(vwmaccsu_vv_h, 2, 4, clearl)
+GEN_VEXT_VV(vwmaccsu_vv_w, 4, 8, clearq)
+
+#define WOP_UXUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
+#define WOP_UXUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
+#define WOP_UXUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
+#define WOP_SXSS_B int16_t, int8_t, int8_t, int16_t, int16_t
+#define WOP_SXSS_H int32_t, int16_t, int16_t, int32_t, int32_t
+#define WOP_SXSS_W int64_t, int32_t, int32_t, int64_t, int64_t
+#define WOP_SXUS_B int16_t, uint8_t, int8_t, uint16_t, int16_t
+#define WOP_SXUS_H int32_t, uint16_t, int16_t, uint32_t, int32_t
+#define WOP_SXUS_W int64_t, uint32_t, int32_t, uint64_t, int64_t
+#define WOP_SXSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
+#define WOP_SXSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
+#define WOP_SXSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
+#define WOP_WUXUU_B uint16_t, uint8_t, uint16_t, uint16_t, uint16_t
+#define WOP_WUXUU_H uint32_t, uint16_t, uint32_t, uint32_t, uint32_t
+#define WOP_WUXUU_W uint64_t, uint32_t, uint64_t, uint64_t, uint64_t
+#define WOP_WSXSS_B int16_t, int8_t, int16_t, int16_t, int16_t
+#define WOP_WSXSS_H int32_t, int16_t, int32_t, int32_t, int32_t
+#define WOP_WSXSS_W int64_t, int32_t, int64_t, int64_t, int64_t
+
+RVVCALL(GEN_OP2_VX, vwaddu_vx_b, WOP_UXUU_B, H2, H1, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwaddu_vx_h, WOP_UXUU_H, H4, H2, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwaddu_vx_w, WOP_UXUU_W, H8, H4, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwsubu_vx_b, WOP_UXUU_B, H2, H1, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwsubu_vx_h, WOP_UXUU_H, H4, H2, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwsubu_vx_w, WOP_UXUU_W, H8, H4, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwadd_vx_b, WOP_SXSS_B, H2, H1, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwadd_vx_h, WOP_SXSS_H, H4, H2, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwadd_vx_w, WOP_SXSS_W, H8, H4, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwsub_vx_b, WOP_SXSS_B, H2, H1, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwsub_vx_h, WOP_SXSS_H, H4, H2, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwsub_vx_w, WOP_SXSS_W, H8, H4, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwaddu_wx_b, WOP_WUXUU_B, H2, H1, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwaddu_wx_h, WOP_WUXUU_H, H4, H2, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwaddu_wx_w, WOP_WUXUU_W, H8, H4, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwsubu_wx_b, WOP_WUXUU_B, H2, H1, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwsubu_wx_h, WOP_WUXUU_H, H4, H2, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwsubu_wx_w, WOP_WUXUU_W, H8, H4, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwadd_wx_b, WOP_WSXSS_B, H2, H1, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwadd_wx_h, WOP_WSXSS_H, H4, H2, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwadd_wx_w, WOP_WSXSS_W, H8, H4, DO_ADD)
+RVVCALL(GEN_OP2_VX, vwsub_wx_b, WOP_WSXSS_B, H2, H1, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwsub_wx_h, WOP_WSXSS_H, H4, H2, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwsub_wx_w, WOP_WSXSS_W, H8, H4, DO_SUB)
+RVVCALL(GEN_OP2_VX, vwmul_vx_b, WOP_SXSS_B, H2, H1, DO_MUL)
+RVVCALL(GEN_OP2_VX, vwmul_vx_h, WOP_SXSS_H, H4, H2, DO_MUL)
+RVVCALL(GEN_OP2_VX, vwmul_vx_w, WOP_SXSS_W, H8, H4, DO_MUL)
+RVVCALL(GEN_OP2_VX, vwmulu_vx_b, WOP_UXUU_B, H2, H1, DO_MUL)
+RVVCALL(GEN_OP2_VX, vwmulu_vx_h, WOP_UXUU_H, H4, H2, DO_MUL)
+RVVCALL(GEN_OP2_VX, vwmulu_vx_w, WOP_UXUU_W, H8, H4, DO_MUL)
+RVVCALL(GEN_OP2_VX, vwmulsu_vx_b, WOP_SXUS_B, H2, H1, DO_MUL)
+RVVCALL(GEN_OP2_VX, vwmulsu_vx_h, WOP_SXUS_H, H4, H2, DO_MUL)
+RVVCALL(GEN_OP2_VX, vwmulsu_vx_w, WOP_SXUS_W, H8, H4, DO_MUL)
+
+RVVCALL(GEN_OP3_VX, vwmaccu_vx_b, WOP_UXUU_B, H2, H1, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmaccu_vx_h, WOP_UXUU_H, H4, H2, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmaccu_vx_w, WOP_UXUU_W, H8, H4, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmacc_vx_b, WOP_SXSS_B, H2, H1, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmacc_vx_h, WOP_SXSS_H, H4, H2, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmacc_vx_w, WOP_SXSS_W, H8, H4, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmaccsu_vx_b, WOP_SXSU_B, H2, H1, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmaccsu_vx_h, WOP_SXSU_H, H4, H2, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmaccsu_vx_w, WOP_SXSU_W, H8, H4, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmaccus_vx_b, WOP_SXUS_B, H2, H1, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmaccus_vx_h, WOP_SXUS_H, H4, H2, DO_MACC)
+RVVCALL(GEN_OP3_VX, vwmaccus_vx_w, WOP_SXUS_W, H8, H4, DO_MACC)
+
+GEN_VEXT_VX(vwaddu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwaddu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwaddu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwsubu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwsubu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwsubu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwadd_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwadd_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwadd_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwsub_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwsub_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwsub_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwaddu_wx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwaddu_wx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwaddu_wx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwsubu_wx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwsubu_wx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwsubu_wx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwadd_wx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwadd_wx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwadd_wx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwsub_wx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwsub_wx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwsub_wx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmul_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmul_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmul_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmulu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmulu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmulu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmulsu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmulsu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmulsu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmaccu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmacc_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmacc_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmacc_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmaccsu_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccsu_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccsu_vx_w, 4, 8, clearq)
+GEN_VEXT_VX(vwmaccus_vx_b, 1, 2, clearh)
+GEN_VEXT_VX(vwmaccus_vx_h, 2, 4, clearl)
+GEN_VEXT_VX(vwmaccus_vx_w, 4, 8, clearq)
+
+#define DO_VADC(N, M, C) (N + M + C)
+#define DO_VSBC(N, M, C) (N - M - C)
+
+#define GEN_VEXT_OP_VVM(NAME, ETYPE, H, DO_OP, CLEAR_FN)      \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+        CPURISCVState *env, uint32_t desc)                    \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vl = env->vl;                                    \
+    uint32_t esz = sizeof(ETYPE);                             \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t i;                                               \
+                                                              \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        uint8_t carry = vext_elem_mask(v0, mlen, i);          \
+                                                              \
+        *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
+    }                                                         \
+    if (i != 0) {                                             \
+        CLEAR_FN(vd, vl, vl * esz, vlmax * esz);              \
+    }                                                         \
+}
+
+GEN_VEXT_OP_VVM(vadc_vvm_b, uint8_t,  H1, DO_VADC, clearb)
+GEN_VEXT_OP_VVM(vadc_vvm_h, uint16_t, H2, DO_VADC, clearh)
+GEN_VEXT_OP_VVM(vadc_vvm_w, uint32_t, H4, DO_VADC, clearl)
+GEN_VEXT_OP_VVM(vadc_vvm_d, uint64_t, H8, DO_VADC, clearq)
+
+GEN_VEXT_OP_VVM(vsbc_vvm_b, uint8_t,  H1, DO_VSBC, clearb)
+GEN_VEXT_OP_VVM(vsbc_vvm_h, uint16_t, H2, DO_VSBC, clearh)
+GEN_VEXT_OP_VVM(vsbc_vvm_w, uint32_t, H4, DO_VSBC, clearl)
+GEN_VEXT_OP_VVM(vsbc_vvm_d, uint64_t, H8, DO_VSBC, clearq)
+
+#define GEN_VEXT_OP_VXM(NAME, ETYPE, H, DO_OP, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
+        CPURISCVState *env, uint32_t desc)                               \
+{                                                                        \
+    uint32_t mlen = vext_mlen(desc);                                     \
+    uint32_t vl = env->vl;                                               \
+    uint32_t esz = sizeof(ETYPE);                                        \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                             \
+    uint32_t i;                                                          \
+                                                                         \
+    for (i = 0; i < vl; i++) {                                           \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
+        uint8_t carry = vext_elem_mask(v0, mlen, i);                     \
+                                                                         \
+        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
+    }                                                                    \
+    if (i != 0) {                                                        \
+        CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+    }                                                                    \
+}
+
+GEN_VEXT_OP_VXM(vadc_vxm_b, uint8_t,  H1, DO_VADC, clearb)
+GEN_VEXT_OP_VXM(vadc_vxm_h, uint16_t, H2, DO_VADC, clearh)
+GEN_VEXT_OP_VXM(vadc_vxm_w, uint32_t, H4, DO_VADC, clearl)
+GEN_VEXT_OP_VXM(vadc_vxm_d, uint64_t, H8, DO_VADC, clearq)
+
+GEN_VEXT_OP_VXM(vsbc_vxm_b, uint8_t,  H1, DO_VSBC, clearb)
+GEN_VEXT_OP_VXM(vsbc_vxm_h, uint16_t, H2, DO_VSBC, clearh)
+GEN_VEXT_OP_VXM(vsbc_vxm_w, uint32_t, H4, DO_VSBC, clearl)
+GEN_VEXT_OP_VXM(vsbc_vxm_d, uint64_t, H8, DO_VSBC, clearq)
+
+#define DO_MADC(N, M, C) ((__typeof(N))(N + M + C) < N ? 1 : 0)
+#define DO_MSBC(N, M, C) ((__typeof(N))(N - M - C) > N ? 1 : 0)
+
+#define GEN_VEXT_MASK_VVM(NAME, ETYPE, H, DO_OP)              \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+        CPURISCVState *env, uint32_t desc)                    \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vl = env->vl;                                    \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
+    uint32_t i;                                               \
+                                                              \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        uint8_t carry = vext_elem_mask(v0, mlen, i);          \
+                                                              \
+        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, s1, carry));\
+    }                                                         \
+    if (i == 0) {                                             \
+        return;                                               \
+    }                                                         \
+    for (; i < vlmax; i++) {                                  \
+        vext_set_elem_mask(vd, mlen, i, 0);                   \
+    }                                                         \
+}
+
+GEN_VEXT_MASK_VVM(vmadc_vvm_b, uint8_t,  H1, DO_MADC)
+GEN_VEXT_MASK_VVM(vmadc_vvm_h, uint16_t, H2, DO_MADC)
+GEN_VEXT_MASK_VVM(vmadc_vvm_w, uint32_t, H4, DO_MADC)
+GEN_VEXT_MASK_VVM(vmadc_vvm_d, uint64_t, H8, DO_MADC)
+
+GEN_VEXT_MASK_VVM(vmsbc_vvm_b, uint8_t,  H1, DO_MSBC)
+GEN_VEXT_MASK_VVM(vmsbc_vvm_h, uint16_t, H2, DO_MSBC)
+GEN_VEXT_MASK_VVM(vmsbc_vvm_w, uint32_t, H4, DO_MSBC)
+GEN_VEXT_MASK_VVM(vmsbc_vvm_d, uint64_t, H8, DO_MSBC)
+
+#define GEN_VEXT_MASK_VXM(NAME, ETYPE, H, DO_OP)              \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,        \
+        void *vs2, CPURISCVState *env, uint32_t desc)         \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vl = env->vl;                                    \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
+    uint32_t i;                                               \
+                                                              \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        uint8_t carry = vext_elem_mask(v0, mlen, i);          \
+                                                              \
+        vext_set_elem_mask(vd, mlen, i,                       \
+                DO_OP(s2, (ETYPE)(target_long)s1, carry));    \
+    }                                                         \
+    if (i == 0) {                                             \
+        return;                                               \
+    }                                                         \
+    for (; i < vlmax; i++) {                                  \
+        vext_set_elem_mask(vd, mlen, i, 0);                   \
+    }                                                         \
+}
+
+GEN_VEXT_MASK_VXM(vmadc_vxm_b, uint8_t,  H1, DO_MADC)
+GEN_VEXT_MASK_VXM(vmadc_vxm_h, uint16_t, H2, DO_MADC)
+GEN_VEXT_MASK_VXM(vmadc_vxm_w, uint32_t, H4, DO_MADC)
+GEN_VEXT_MASK_VXM(vmadc_vxm_d, uint64_t, H8, DO_MADC)
+
+GEN_VEXT_MASK_VXM(vmsbc_vxm_b, uint8_t,  H1, DO_MSBC)
+GEN_VEXT_MASK_VXM(vmsbc_vxm_h, uint16_t, H2, DO_MSBC)
+GEN_VEXT_MASK_VXM(vmsbc_vxm_w, uint32_t, H4, DO_MSBC)
+GEN_VEXT_MASK_VXM(vmsbc_vxm_d, uint64_t, H8, DO_MSBC)
+
+#define DO_MSEQ(N, M) ((N == M) ? 1 : 0)
+#define DO_MSNE(N, M) ((N != M) ? 1 : 0)
+#define DO_MSLTU(N, M) ((N < M) ? 1 : 0)
+#define DO_MSLT(N, M) ((N < M) ? 1 : 0)
+#define DO_MSLEU(N, M) ((N <= M) ? 1 : 0)
+#define DO_MSLE(N, M) ((N <= M) ? 1 : 0)
+#define DO_MSGTU(N, M) ((N > M) ? 1 : 0)
+#define DO_MSGT(N, M) ((N > M) ? 1 : 0)
+
+#define GEN_VEXT_MASK_VV(NAME, ETYPE, H, DO_OP)               \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+        CPURISCVState *env, uint32_t desc)                    \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vm = vext_vm(desc);                              \
+    uint32_t vl = env->vl;                                    \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
+    uint32_t i;                                               \
+                                                              \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {            \
+            continue;                                         \
+        }                                                     \
+        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, s1));       \
+    }                                                         \
+    if (i == 0) {                                             \
+        return;                                               \
+    }                                                         \
+    for (; i < vlmax; i++) {                                  \
+        vext_set_elem_mask(vd, mlen, i, 0);                   \
+    }                                                         \
+}
+
+GEN_VEXT_MASK_VV(vmseq_vv_b, uint8_t,  H1, DO_MSEQ)
+GEN_VEXT_MASK_VV(vmseq_vv_h, uint16_t, H2, DO_MSEQ)
+GEN_VEXT_MASK_VV(vmseq_vv_w, uint32_t, H4, DO_MSEQ)
+GEN_VEXT_MASK_VV(vmseq_vv_d, uint64_t, H8, DO_MSEQ)
+
+GEN_VEXT_MASK_VV(vmsne_vv_b, uint8_t,  H1, DO_MSNE)
+GEN_VEXT_MASK_VV(vmsne_vv_h, uint16_t, H2, DO_MSNE)
+GEN_VEXT_MASK_VV(vmsne_vv_w, uint32_t, H4, DO_MSNE)
+GEN_VEXT_MASK_VV(vmsne_vv_d, uint64_t, H8, DO_MSNE)
+
+GEN_VEXT_MASK_VV(vmsltu_vv_b, uint8_t,  H1, DO_MSLTU)
+GEN_VEXT_MASK_VV(vmsltu_vv_h, uint16_t, H2, DO_MSLTU)
+GEN_VEXT_MASK_VV(vmsltu_vv_w, uint32_t, H4, DO_MSLTU)
+GEN_VEXT_MASK_VV(vmsltu_vv_d, uint64_t, H8, DO_MSLTU)
+
+GEN_VEXT_MASK_VV(vmslt_vv_b, int8_t,  H1, DO_MSLT)
+GEN_VEXT_MASK_VV(vmslt_vv_h, int16_t, H2, DO_MSLT)
+GEN_VEXT_MASK_VV(vmslt_vv_w, int32_t, H4, DO_MSLT)
+GEN_VEXT_MASK_VV(vmslt_vv_d, int64_t, H8, DO_MSLT)
+
+GEN_VEXT_MASK_VV(vmsleu_vv_b, uint8_t,  H1, DO_MSLEU)
+GEN_VEXT_MASK_VV(vmsleu_vv_h, uint16_t, H2, DO_MSLEU)
+GEN_VEXT_MASK_VV(vmsleu_vv_w, uint32_t, H4, DO_MSLEU)
+GEN_VEXT_MASK_VV(vmsleu_vv_d, uint64_t, H8, DO_MSLEU)
+
+GEN_VEXT_MASK_VV(vmsle_vv_b, int8_t,  H1, DO_MSLE)
+GEN_VEXT_MASK_VV(vmsle_vv_h, int16_t, H2, DO_MSLE)
+GEN_VEXT_MASK_VV(vmsle_vv_w, int32_t, H4, DO_MSLE)
+GEN_VEXT_MASK_VV(vmsle_vv_d, int64_t, H8, DO_MSLE)
+
+#define GEN_VEXT_MASK_VX(NAME, ETYPE, H, DO_OP)                     \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
+        CPURISCVState *env, uint32_t desc)                          \
+{                                                                   \
+    uint32_t mlen = vext_mlen(desc);                                \
+    uint32_t vm = vext_vm(desc);                                    \
+    uint32_t vl = env->vl;                                          \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
+    uint32_t i;                                                     \
+                                                                    \
+    for (i = 0; i < vl; i++) {                                      \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                  \
+            continue;                                               \
+        }                                                           \
+        vext_set_elem_mask(vd, mlen, i,                             \
+                DO_OP(s2, (ETYPE)(target_long)s1));                 \
+    }                                                               \
+    if (i == 0) {                                                   \
+        return;                                                     \
+    }                                                               \
+    for (; i < vlmax; i++) {                                        \
+        vext_set_elem_mask(vd, mlen, i, 0);                         \
+    }                                                               \
+}
+
+GEN_VEXT_MASK_VX(vmseq_vx_b, uint8_t,  H1, DO_MSEQ)
+GEN_VEXT_MASK_VX(vmseq_vx_h, uint16_t, H2, DO_MSEQ)
+GEN_VEXT_MASK_VX(vmseq_vx_w, uint32_t, H4, DO_MSEQ)
+GEN_VEXT_MASK_VX(vmseq_vx_d, uint64_t, H8, DO_MSEQ)
+
+GEN_VEXT_MASK_VX(vmsne_vx_b, uint8_t,  H1, DO_MSNE)
+GEN_VEXT_MASK_VX(vmsne_vx_h, uint16_t, H2, DO_MSNE)
+GEN_VEXT_MASK_VX(vmsne_vx_w, uint32_t, H4, DO_MSNE)
+GEN_VEXT_MASK_VX(vmsne_vx_d, uint64_t, H8, DO_MSNE)
+
+GEN_VEXT_MASK_VX(vmsltu_vx_b, uint8_t,  H1, DO_MSLTU)
+GEN_VEXT_MASK_VX(vmsltu_vx_h, uint16_t, H2, DO_MSLTU)
+GEN_VEXT_MASK_VX(vmsltu_vx_w, uint32_t, H4, DO_MSLTU)
+GEN_VEXT_MASK_VX(vmsltu_vx_d, uint64_t, H8, DO_MSLTU)
+
+GEN_VEXT_MASK_VX(vmslt_vx_b, int8_t,  H1, DO_MSLT)
+GEN_VEXT_MASK_VX(vmslt_vx_h, int16_t, H2, DO_MSLT)
+GEN_VEXT_MASK_VX(vmslt_vx_w, int32_t, H4, DO_MSLT)
+GEN_VEXT_MASK_VX(vmslt_vx_d, int64_t, H8, DO_MSLT)
+
+GEN_VEXT_MASK_VX(vmsleu_vx_b, uint8_t,  H1, DO_MSLEU)
+GEN_VEXT_MASK_VX(vmsleu_vx_h, uint16_t, H2, DO_MSLEU)
+GEN_VEXT_MASK_VX(vmsleu_vx_w, uint32_t, H4, DO_MSLEU)
+GEN_VEXT_MASK_VX(vmsleu_vx_d, uint64_t, H8, DO_MSLEU)
+
+GEN_VEXT_MASK_VX(vmsle_vx_b, int8_t,  H1, DO_MSLE)
+GEN_VEXT_MASK_VX(vmsle_vx_h, int16_t, H2, DO_MSLE)
+GEN_VEXT_MASK_VX(vmsle_vx_w, int32_t, H4, DO_MSLE)
+GEN_VEXT_MASK_VX(vmsle_vx_d, int64_t, H8, DO_MSLE)
+
+GEN_VEXT_MASK_VX(vmsgtu_vx_b, uint8_t,  H1, DO_MSGTU)
+GEN_VEXT_MASK_VX(vmsgtu_vx_h, uint16_t, H2, DO_MSGTU)
+GEN_VEXT_MASK_VX(vmsgtu_vx_w, uint32_t, H4, DO_MSGTU)
+GEN_VEXT_MASK_VX(vmsgtu_vx_d, uint64_t, H8, DO_MSGTU)
+
+GEN_VEXT_MASK_VX(vmsgt_vx_b, int8_t,  H1, DO_MSGT)
+GEN_VEXT_MASK_VX(vmsgt_vx_h, int16_t, H2, DO_MSGT)
+GEN_VEXT_MASK_VX(vmsgt_vx_w, int32_t, H4, DO_MSGT)
+GEN_VEXT_MASK_VX(vmsgt_vx_d, int64_t, H8, DO_MSGT)
-- 
2.23.0


