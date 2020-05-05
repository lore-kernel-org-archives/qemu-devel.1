Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7C2C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1358206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1358206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW2Tv-0006EN-Ve
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 14:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jW2Sn-0005PA-3P; Tue, 05 May 2020 14:38:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jW2Sl-00008e-4i; Tue, 05 May 2020 14:38:40 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 045IX4si105623; Tue, 5 May 2020 14:38:35 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30s4gv80t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 14:38:34 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045IbQVu013760;
 Tue, 5 May 2020 18:38:33 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma01wdc.us.ibm.com with ESMTP id 30s0g6aw2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 18:38:33 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 045IcW0w26542490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2020 18:38:32 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D36F46A054;
 Tue,  5 May 2020 18:38:32 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40B7D6A047;
 Tue,  5 May 2020 18:38:32 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.160.119.241])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2020 18:38:32 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] target-ppc: fix rlwimi, rlwinm, rlwnm for Clang-9
Date: Tue,  5 May 2020 14:38:17 -0400
Message-Id: <20200505183818.32688-2-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505183818.32688-1-dbuono@linux.vnet.ibm.com>
References: <20200505183818.32688-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-05_09:2020-05-04,
 2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050138
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 14:38:37
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Daniele Buono <dbuono@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Starting with Clang v9, -Wtype-limits is implemented and triggers a
few "result of comparison is always true" errors when compiling PPC32
targets.

The comparisons seem to be necessary only on PPC64, since the
else branch in PPC32 only has a "g_assert_not_reached();" in all cases.

This patch restructures the code so that the actual if/else is done on a
local flag variable, that is set accordingly for PPC64, and always
true for PPC32.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 807d14faaa..338529879f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1882,6 +1882,7 @@ static void gen_rlwimi(DisasContext *ctx)
         tcg_gen_deposit_tl(t_ra, t_ra, t_rs, sh, me - mb + 1);
     } else {
         target_ulong mask;
+        bool mask_in_32b = true;
         TCGv t1;
 
 #if defined(TARGET_PPC64)
@@ -1890,8 +1891,13 @@ static void gen_rlwimi(DisasContext *ctx)
 #endif
         mask = MASK(mb, me);
 
+#if defined(TARGET_PPC64)
+        if (mask > 0xffffffffu) {
+            mask_in_32b = false;
+        }
+#endif
         t1 = tcg_temp_new();
-        if (mask <= 0xffffffffu) {
+        if (mask_in_32b) {
             TCGv_i32 t0 = tcg_temp_new_i32();
             tcg_gen_trunc_tl_i32(t0, t_rs);
             tcg_gen_rotli_i32(t0, t0, sh);
@@ -1933,12 +1939,18 @@ static void gen_rlwinm(DisasContext *ctx)
         tcg_gen_extract_tl(t_ra, t_rs, rsh, len);
     } else {
         target_ulong mask;
+        bool mask_in_32b = true;
 #if defined(TARGET_PPC64)
         mb += 32;
         me += 32;
 #endif
         mask = MASK(mb, me);
-        if (mask <= 0xffffffffu) {
+#if defined(TARGET_PPC64)
+        if (mask > 0xffffffffu) {
+            mask_in_32b = false;
+        }
+#endif
+        if (mask_in_32b) {
             if (sh == 0) {
                 tcg_gen_andi_tl(t_ra, t_rs, mask);
             } else {
@@ -1973,6 +1985,7 @@ static void gen_rlwnm(DisasContext *ctx)
     uint32_t mb = MB(ctx->opcode);
     uint32_t me = ME(ctx->opcode);
     target_ulong mask;
+    bool mask_in_32b = true;
 
 #if defined(TARGET_PPC64)
     mb += 32;
@@ -1980,7 +1993,12 @@ static void gen_rlwnm(DisasContext *ctx)
 #endif
     mask = MASK(mb, me);
 
-    if (mask <= 0xffffffffu) {
+#if defined(TARGET_PPC64)
+    if (mask > 0xffffffffu) {
+        mask_in_32b = false;
+    }
+#endif
+    if (mask_in_32b) {
         TCGv_i32 t0 = tcg_temp_new_i32();
         TCGv_i32 t1 = tcg_temp_new_i32();
         tcg_gen_trunc_tl_i32(t0, t_rb);
-- 
2.26.2


