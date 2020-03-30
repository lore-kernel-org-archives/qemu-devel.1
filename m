Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159BCC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC572072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC572072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwWt-0003dd-0u
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIwVP-0002E8-Nu
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIwVN-00082n-Vw
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:39:15 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIwVN-0007cj-FX; Mon, 30 Mar 2020 11:39:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07854487|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00410776-0.00307122-0.992821;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03267; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=11; RT=11; SR=0; TI=SMTPD_---.H7jiUNJ_1585582735; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H7jiUNJ_1585582735)
 by smtp.aliyun-inc.com(10.147.41.137);
 Mon, 30 Mar 2020 23:38:55 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v7 01/61] target/riscv: add vector extension field in
 CPURISCVState
Date: Mon, 30 Mar 2020 23:35:33 +0800
Message-Id: <20200330153633.15298-2-zhiwei_liu@c-sky.com>
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
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 32 vector registers will be viewed as a continuous memory block.
It avoids the convension between element index and (regno, offset).
Thus elements can be directly accessed by offset from the first vector
base address.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h       | 12 ++++++++++++
 target/riscv/translate.c |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d21addbab..6663ee8b8c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -64,6 +64,7 @@
 #define RVA RV('A')
 #define RVF RV('F')
 #define RVD RV('D')
+#define RVV RV('V')
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
@@ -94,9 +95,20 @@ typedef struct CPURISCVState CPURISCVState;
 
 #include "pmp.h"
 
+#define RV_VLEN_MAX 512
+
 struct CPURISCVState {
     target_ulong gpr[32];
     uint64_t fpr[32]; /* assume both F and D extensions */
+
+    /* vector coprocessor state. */
+    uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
+    target_ulong vxrm;
+    target_ulong vxsat;
+    target_ulong vl;
+    target_ulong vstart;
+    target_ulong vtype;
+
     target_ulong pc;
     target_ulong load_res;
     target_ulong load_val;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 43bf7e39a6..b71b7e4bc2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -32,7 +32,7 @@
 #include "instmap.h"
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_pc;
+static TCGv cpu_gpr[32], cpu_pc, cpu_vl;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
@@ -886,6 +886,7 @@ void riscv_translate_init(void)
     }
 
     cpu_pc = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, pc), "pc");
+    cpu_vl = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, vl), "vl");
     load_res = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(cpu_env, offsetof(CPURISCVState, load_val),
-- 
2.23.0


