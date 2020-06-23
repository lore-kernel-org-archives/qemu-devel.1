Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD9CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 00:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A882098B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 00:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A882098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnst9-0001uZ-HG
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 20:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnssL-0000yT-MM; Tue, 23 Jun 2020 20:02:49 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jnssJ-0006xI-55; Tue, 23 Jun 2020 20:02:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07437543|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0270799-9.17707e-05-0.972828;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07381; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=8; SR=0; TI=SMTPD_---.HrTpO7n_1592956957; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HrTpO7n_1592956957)
 by smtp.aliyun-inc.com(10.147.44.129);
 Wed, 24 Jun 2020 08:02:37 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v11 61/61] target/riscv: configure and turn on vector
 extension from command line
Date: Wed, 24 Jun 2020 05:59:20 +0800
Message-Id: <20200623215920.2594-62-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
References: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 17:32:41
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

Vector extension is default off. The only way to use vector extension is
1. use cpu rv32 or rv64
2. turn on it by command line
   "-cpu rv64,x-v=true,vlen=128,elen=64,vext_spec=v0.7.1".

vlen is the vector register length, default value is 128 bit.
elen is the max operator size in bits, default value is 64 bit.
vext_spec is the vector specification version, default value is v0.7.1.
These properties can be specified with other values.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h |  4 +++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d525cfb687..228b9bdb5d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -430,6 +430,45 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         if (cpu->cfg.ext_h) {
             target_misa |= RVH;
         }
+        if (cpu->cfg.ext_v) {
+            target_misa |= RVV;
+            if (!is_power_of_2(cpu->cfg.vlen)) {
+                error_setg(errp,
+                        "Vector extension VLEN must be power of 2");
+                return;
+            }
+            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
+                error_setg(errp,
+                        "Vector extension implementation only supports VLEN "
+                        "in the range [128, %d]", RV_VLEN_MAX);
+                return;
+            }
+            if (!is_power_of_2(cpu->cfg.elen)) {
+                error_setg(errp,
+                        "Vector extension ELEN must be power of 2");
+                return;
+            }
+            if (cpu->cfg.elen > 64 || cpu->cfg.vlen < 8) {
+                error_setg(errp,
+                        "Vector extension implementation only supports ELEN "
+                        "in the range [8, 64]");
+                return;
+            }
+            if (cpu->cfg.vext_spec) {
+                if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
+                    vext_version = VEXT_VERSION_0_07_1;
+                } else {
+                    error_setg(errp,
+                           "Unsupported vector spec version '%s'",
+                           cpu->cfg.vext_spec);
+                    return;
+                }
+            } else {
+                qemu_log("vector verison is not specified, "
+                        "use the default value v0.7.1\n");
+            }
+            set_vext_version(env, vext_version);
+        }
 
         set_misa(env, RVXLEN | target_misa);
     }
@@ -469,10 +508,14 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     /* This is experimental so mark with 'x-' */
     DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
+    DEFINE_PROP_BOOL("x-v", RISCVCPU, cfg.ext_v, false),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
+    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
+    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
+    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0ad51c6580..eef20ca6e5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -92,7 +92,7 @@ typedef struct CPURISCVState CPURISCVState;
 
 #include "pmp.h"
 
-#define RV_VLEN_MAX 512
+#define RV_VLEN_MAX 256
 
 FIELD(VTYPE, VLMUL, 0, 2)
 FIELD(VTYPE, VSEW, 2, 3)
@@ -279,12 +279,14 @@ typedef struct RISCVCPU {
         bool ext_s;
         bool ext_u;
         bool ext_h;
+        bool ext_v;
         bool ext_counters;
         bool ext_ifencei;
         bool ext_icsr;
 
         char *priv_spec;
         char *user_spec;
+        char *vext_spec;
         uint16_t vlen;
         uint16_t elen;
         bool mmu;
-- 
2.23.0


