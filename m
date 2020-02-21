Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E3C35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFF924650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFF924650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54vf-0007vS-3w
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j54sh-0003qu-MZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j54sg-00020A-On
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:45:59 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j54sg-0001hZ-Ck; Fri, 21 Feb 2020 04:45:58 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1012324|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.0847261-0.00699878-0.908275;
 DS=CONTINUE|ham_system_inform|0.0300927-0.000453369-0.969454;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GqUN7u9_1582278331; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GqUN7u9_1582278331)
 by smtp.aliyun-inc.com(10.147.43.95); Fri, 21 Feb 2020 17:45:52 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 1/4] target/riscv: add vector extension field in
 CPURISCVState
Date: Fri, 21 Feb 2020 17:45:28 +0800
Message-Id: <20200221094531.61894-2-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 32 vector registers will be viewed as a continuous memory block.
It avoids the convension between element index and (regno, offset).
Thus elements can be directly accessed by offset from the first vector
base address.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/cpu.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de0a8d893a..2e8d01c155 100644
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
@@ -93,9 +94,20 @@ typedef struct CPURISCVState CPURISCVState;
 
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
-- 
2.23.0


