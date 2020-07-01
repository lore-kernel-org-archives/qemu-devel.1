Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DA5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D4E20760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D4E20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeji-0005Fz-7v
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqegn-00033c-Kg; Wed, 01 Jul 2020 11:30:21 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqegl-0005qR-Ig; Wed, 01 Jul 2020 11:30:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07496532|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0136442-0.000305345-0.98605;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=8; SR=0; TI=SMTPD_---.HvuwpBL_1593617410; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HvuwpBL_1593617410)
 by smtp.aliyun-inc.com(10.147.42.22); Wed, 01 Jul 2020 23:30:10 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v12 02/61] target/riscv: implementation-defined constant
 parameters
Date: Wed,  1 Jul 2020 23:24:50 +0800
Message-Id: <20200701152549.1218-3-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200701152549.1218-1-zhiwei_liu@c-sky.com>
References: <20200701152549.1218-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 11:22:02
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
 wenmeng_zhang@c-sky.com, Alistair Francis <alistair.francis@wdc.com>,
 palmer@dabbelt.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vlen is the vector register length in bits.
elen is the max element size in bits.
vext_spec is the vector specification version, default value is v0.7.1.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 7 +++++++
 target/riscv/cpu.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 391a0b9eec..d525cfb687 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,6 +106,11 @@ static void set_priv_version(CPURISCVState *env, int priv_ver)
     env->priv_ver = priv_ver;
 }
 
+static void set_vext_version(CPURISCVState *env, int vext_ver)
+{
+    env->vext_ver = vext_ver;
+}
+
 static void set_feature(CPURISCVState *env, int feature)
 {
     env->features |= (1ULL << feature);
@@ -334,6 +339,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
+    int vext_version = VEXT_VERSION_0_07_1;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
 
@@ -357,6 +363,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     set_priv_version(env, priv_version);
+    set_vext_version(env, vext_version);
 
     if (cpu->cfg.mmu) {
         set_feature(env, RISCV_FEATURE_MMU);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0018a79fa3..302e0859a0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -78,6 +78,8 @@ enum {
 #define PRIV_VERSION_1_10_0 0x00011000
 #define PRIV_VERSION_1_11_0 0x00011100
 
+#define VEXT_VERSION_0_07_1 0x00000701
+
 #define TRANSLATE_PMP_FAIL 2
 #define TRANSLATE_FAIL 1
 #define TRANSLATE_SUCCESS 0
@@ -113,6 +115,7 @@ struct CPURISCVState {
     target_ulong guest_phys_fault_addr;
 
     target_ulong priv_ver;
+    target_ulong vext_ver;
     target_ulong misa;
     target_ulong misa_mask;
 
@@ -275,6 +278,8 @@ typedef struct RISCVCPU {
 
         char *priv_spec;
         char *user_spec;
+        uint16_t vlen;
+        uint16_t elen;
         bool mmu;
         bool pmp;
     } cfg;
-- 
2.23.0


