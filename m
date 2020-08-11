Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F6420768
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TfR6sWWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F6420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WIA-0003IJ-DX
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.ibm.com>)
 id 1k5WHK-0002JB-6o; Tue, 11 Aug 2020 11:33:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14920
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.ibm.com>)
 id 1k5WHH-0002ml-Lq; Tue, 11 Aug 2020 11:33:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07BFWc5f152677; Tue, 11 Aug 2020 11:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=PPx92utNEw+9BKUJJHztx9+w7ik/s8LH2Fe2Gp49uoM=;
 b=TfR6sWWOo2aI2bTLC2GPiCXmItW8QQnH2gZW46BukYUxvb39HEV9hozyOQXBkWWd4RV0
 wcWZ05NKlH+eAeG8di6NfRBpZ7vp+7UYP/jgyIQA3dfEFk8cotcqTLnVEoOMpjTzC4rJ
 uzPOGUuVH6uGdH0yNt1Vg9C9XO5fEMKd5s9Q97C7uliba1gGIG2JnRV76MRpImmCgpvM
 C0S8gBFEH/tF3nNmVAAO5Q6fCipQAKC4QzF2wtg4YjfyBYJ95PzXvNlUDYN6ues0KqH5
 SLKfqyZhJzS0v4gaLjT9x1swN4ssm52ETCPD8qFxYWDe1ov5D7A3bKEn2a5fCSXCFH3G 6w== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32usrygq7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2020 11:33:12 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07BFKAVm017862;
 Tue, 11 Aug 2020 15:33:12 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma03wdc.us.ibm.com with ESMTP id 32skp92f6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2020 15:33:12 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07BFXClH54198572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2020 15:33:12 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDC56AC05E;
 Tue, 11 Aug 2020 15:33:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBFCBAC059;
 Tue, 11 Aug 2020 15:33:08 +0000 (GMT)
Received: from pub.ltc.br.ibm.com (unknown [9.80.200.46])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2020 15:33:08 +0000 (GMT)
From: Gustavo Romero <gromero@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2] target/ppc: Integrate icount to purr, vtb, and tbu40
Date: Tue, 11 Aug 2020 12:32:35 -0300
Message-Id: <20200811153235.4527-1-gromero@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-11_14:2020-08-11,
 2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=786 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gromero@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 09:33:21
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, gromero@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently if option '-icount auto' is passed to the QEMU TCG to enable
counting instructions the VM crashes with the following error report when
Linux runs on it:

qemu-system-ppc64: Bad icount read

This happens because read/write access to the SPRs PURR, VTB, and TBU40
is not integrated to the icount framework.

This commit fixes that issue by making the read/write access of these
SPRs aware of icount framework, adding the proper gen_io_start() calls
before calling the helpers to load/store these SPRs in TCG and ensuring
that the associated TBs end immediately after, accordingly to what's in
docs/devel/tcg-icount.rst.

Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
---
 target/ppc/translate_init.inc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 7e66822b5d..ccf9ce3441 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -284,12 +284,24 @@ static void spr_write_atbu(DisasContext *ctx, int sprn, int gprn)
 ATTRIBUTE_UNUSED
 static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 static void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_store_purr(cpu_env, cpu_gpr[gprn]);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 /* HDECR */
@@ -319,17 +331,35 @@ static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 
 static void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_load_vtb(cpu_gpr[gprn], cpu_env);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 static void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 static void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
 {
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_stop_exception(ctx);
+    }
 }
 
 #endif
-- 
2.17.1


