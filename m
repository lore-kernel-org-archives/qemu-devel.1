Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EDA206B7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EDA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqmVd-0001mk-PL
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 19:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jqmOc-0008UZ-RW; Wed, 01 Jul 2020 19:44:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jqmOV-0002B5-Tj; Wed, 01 Jul 2020 19:44:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 061NWa8M025214; Wed, 1 Jul 2020 19:43:51 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 320wfftsp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2020 19:43:51 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061NdIh2025982;
 Wed, 1 Jul 2020 23:43:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 320wfkbdpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2020 23:43:50 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 061NhlGi11469556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2020 23:43:47 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21BBD6E04E;
 Wed,  1 Jul 2020 23:43:49 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41BDE6E04C;
 Wed,  1 Jul 2020 23:43:48 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.160.126.23])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2020 23:43:48 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 03/11] target/ppc: add byte-reverse br[dwh] instructions
Date: Wed,  1 Jul 2020 18:43:38 -0500
Message-Id: <20200701234344.91843-4-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200701234344.91843-1-ljp@linux.ibm.com>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-01_15:2020-07-01,
 2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 suspectscore=2 impostorscore=0 mlxlogscore=993 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010161
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ljp@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 19:43:54
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Lijun Pan <ljp@linux.ibm.com>, richard.henderson@linaro.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

POWER ISA 3.1 introduces following byte-reverse instructions:
brd: Byte-Reverse Doubleword X-form
brw: Byte-Reverse Word X-form
brh: Byte-Reverse Halfword X-form

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
v4: make it compile on all targets
v3: fix the store issue in br[dwh]
    simplify brw implementation
    add "if defined(TARGET_PPC64)"
v2: fix coding style
    use Power ISA 3.1 flag

 target/ppc/translate.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4ce3d664b5..590c3e3bc7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6971,7 +6971,47 @@ static void gen_dform3D(DisasContext *ctx)
     return gen_invalid(ctx);
 }
 
+#if defined(TARGET_PPC64)
+/* brd */
+static void gen_brd(DisasContext *ctx)
+{
+    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+}
+
+/* brw */
+static void gen_brw(DisasContext *ctx)
+{
+    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+    tcg_gen_rotli_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], 32);
+
+}
+
+/* brh */
+static void gen_brh(DisasContext *ctx)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_movi_i64(t0, 0x00ff00ff00ff00ffull);
+    tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
+    tcg_gen_and_i64(t2, t1, t0);
+    tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], t0);
+    tcg_gen_shli_i64(t1, t1, 8);
+    tcg_gen_or_i64(cpu_gpr[rA(ctx->opcode)], t1, t2);
+
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+#endif
+
 static opcode_t opcodes[] = {
+#if defined(TARGET_PPC64)
+GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
+GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
+GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
+#endif
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
 GEN_HANDLER(cmp, 0x1F, 0x00, 0x00, 0x00400000, PPC_INTEGER),
 GEN_HANDLER(cmpi, 0x0B, 0xFF, 0xFF, 0x00400000, PPC_INTEGER),
-- 
2.23.0


