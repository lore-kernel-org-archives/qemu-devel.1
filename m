Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78F8C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 04:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906C82071A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 04:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906C82071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjxfx-0001Zf-Ng
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 00:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxes-0008Ma-Ck; Sat, 13 Jun 2020 00:20:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ljp@linux.ibm.com>)
 id 1jjxeq-0007pZ-7j; Sat, 13 Jun 2020 00:20:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05D48iPJ076010; Sat, 13 Jun 2020 00:20:39 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31mn8bjw26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 00:20:39 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05D4AcPI031644;
 Sat, 13 Jun 2020 04:20:32 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 31mpe80p5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2020 04:20:32 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05D4KTDl31916490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2020 04:20:29 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00094BE056;
 Sat, 13 Jun 2020 04:20:30 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CCE7BE051;
 Sat, 13 Jun 2020 04:20:30 +0000 (GMT)
Received: from pompom.ibm.com (unknown [9.65.217.131])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2020 04:20:30 +0000 (GMT)
From: Lijun Pan <ljp@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/ppc: add byte-reverse br[dwh] instructions
Date: Fri, 12 Jun 2020 23:20:24 -0500
Message-Id: <20200613042029.22321-2-ljp@linux.ibm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200613042029.22321-1-ljp@linux.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-13_01:2020-06-12,
 2020-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=804
 cotscore=-2147483648 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 suspectscore=2 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006130032
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ljp@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 00:20:34
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Lijun Pan <ljp@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

POWER ISA 3.1 introduces following byte-reverse instructions:
brd: Byte-Reverse Doubleword X-form
brw: Byte-Reverse Word X-form
brh: Byte-Reverse Halfword X-form

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
---
 target/ppc/translate.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4ce3d664b5..2d48fbc8db 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6971,7 +6971,69 @@ static void gen_dform3D(DisasContext *ctx)
     return gen_invalid(ctx);
 }
 
+/* brd */
+static void gen_brd(DisasContext *ctx)
+{
+	TCGv_i64 temp = tcg_temp_new_i64();
+
+	tcg_gen_bswap64_i64(temp, cpu_gpr[rS(ctx->opcode)]);
+	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode)]));
+
+	tcg_temp_free_i64(temp);
+}
+
+/* brw */
+static void gen_brw(DisasContext *ctx)
+{
+	TCGv_i64 temp = tcg_temp_new_i64();
+	TCGv_i64 lsb = tcg_temp_new_i64();
+	TCGv_i64 msb = tcg_temp_new_i64();
+
+	tcg_gen_movi_i64(lsb, 0x00000000ffffffffull);
+	tcg_gen_and_i64(temp, lsb, cpu_gpr[rS(ctx->opcode)]);
+	tcg_gen_bswap32_i64(lsb, temp);
+	
+	tcg_gen_shri_i64(msb, cpu_gpr[rS(ctx->opcode)], 32);
+	tcg_gen_bswap32_i64(temp, msb);
+	tcg_gen_shli_i64(msb, temp, 32);
+	
+	tcg_gen_or_i64(temp, lsb, msb);
+
+	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode)]));
+
+	tcg_temp_free_i64(temp);
+	tcg_temp_free_i64(lsb);
+	tcg_temp_free_i64(msb);
+}
+
+/* brh */
+static void gen_brh(DisasContext *ctx)
+{
+	TCGv_i64 temp = tcg_temp_new_i64();
+	TCGv_i64 t0 = tcg_temp_new_i64();
+	TCGv_i64 t1 = tcg_temp_new_i64();
+	TCGv_i64 t2 = tcg_temp_new_i64();
+	TCGv_i64 t3 = tcg_temp_new_i64();
+
+	tcg_gen_movi_i64(t0, 0x00ff00ff00ff00ffull);
+	tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
+	tcg_gen_and_i64(t2, t1, t0);
+	tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], t0);
+	tcg_gen_shli_i64(t1, t1, 8);
+	tcg_gen_or_i64(temp, t1, t2);
+	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode)]));
+
+	tcg_temp_free_i64(temp);
+	tcg_temp_free_i64(t0);
+	tcg_temp_free_i64(t1);
+	tcg_temp_free_i64(t2);
+	tcg_temp_free_i64(t3);
+}
+
 static opcode_t opcodes[] = {
+GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
 GEN_HANDLER(cmp, 0x1F, 0x00, 0x00, 0x00400000, PPC_INTEGER),
 GEN_HANDLER(cmpi, 0x0B, 0xFF, 0xFF, 0x00400000, PPC_INTEGER),
-- 
2.23.0


