Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C48C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D030208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="vt8cxgwV";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="fD5ni1ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D030208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP4eY-0004M2-3r
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jP4dh-0003v6-Ri
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jP4df-00028w-50
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:33:08 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jP4de-00028M-OJ; Thu, 16 Apr 2020 09:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587043986; x=1618579986;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=sgWju7cM6GNlsVHDWe+mknG9wnCU8PN77cR0sM4gdeo=;
 b=vt8cxgwVz2vUqmJDaJUqyCQuWizqr0y5+wL263JYVmRiRGfPzxN4w9hF
 luAfnnuJBamKylOTXPNQoeVWHWcWgRjDC1xyT7FW4ojFHAPRnCRasSDHB
 bWx4CQC0LpAhLeDDhHCjK1sx8PDtRHCQqgWlC87tOk3NFtKYtB0MckEFG o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Apr 2020 06:33:04 -0700
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 16 Apr 2020 06:33:04 -0700
Received: from APSANEXR01B.ap.qualcomm.com (10.85.0.37) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Apr 2020 06:33:04 -0700
Received: from NASANEXM01B.na.qualcomm.com (10.85.0.82) by
 APSANEXR01B.ap.qualcomm.com (10.85.0.37) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Apr 2020 06:33:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 16 Apr 2020 06:33:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx+BL1kY71Q8JwdqY7Y8rM4d2k31PfibJIsd2AOYMlPsuWk69CNM3rQYmpdGkEmaXw02DKcPVLP34W01litexCcnctgcI5OE2HhkC6s/QTmn7eVIo0LaoTBv3ajuLq7plDncWdAq3MroiEIN6AcyUjGrL3uP4otIYuYByNA276WwesQRHJhsnA0EDPjFPBx4f5onZ0iW5Z9nMYVLQVZUGAfoQjbiLKiZnt8Sgms4F/Z6AidMOLTcc7kGPoMOFJAqNg5H5UXh/AyyNwVd3/M+8yjVwL8Lm2shhJVe1Gw6KokVbPwCZxGzxgnuIm/tSXDxHRXsHSyts7v6c+1NO45CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfBubG30lJp2UPqL8fDCxEKNU+b5Iju1aRSKYn3zebw=;
 b=YFuUxF86DvnrxmkX8krj2g32DQ8EkIQWegRCIAs8CKrrt1FaacNzEbiHHTTly39a4dtTdwZLEXdYPPFAKiUXpsuGDy7bX2ZMaTBkS3l1QPOKSO8BDUsPFqN/Z+0phRvUpRZwU/keZyND7rOYnYfYe5WQ1wQI/ZSWIp8UdHp95UQqicS0s4SnGmd1yf2uK6Q3ZkRJ/+5cb/zSdFGUBWu2hNyuLctrERXPwPop/Busy5Li5ZyY6ovmP5zDfPA0/VLUcSxPgQLUJ71rgn9F47+HIv8s+GkGsDzR2qISspPZAEUXtEy1tYzrYpvXEmFh9lYI/y5WqZO1D1u2QOkU2ltvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfBubG30lJp2UPqL8fDCxEKNU+b5Iju1aRSKYn3zebw=;
 b=fD5ni1ia0cEhlibql015wwAEkC2mm8EKzlYE0z+5Ogye1Vij3QNcbjjKGYmQv9hbUeScoPojCA7/GriZglEKcxQfiPx6Sd4+JILZ4tNr1UoN+Sya0pgAbGFnf0+JUG0pVL7Kx8FxH7OGBwy5aZI4GpUpfl+3WkUf8Yoo2f+/lUo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3497.namprd02.prod.outlook.com
 (2603:10b6:301:7e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Thu, 16 Apr
 2020 13:33:00 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 13:33:00 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2] target/arm: Implement SVE2 HISTCNT, HISTSEG
Date: Thu, 16 Apr 2020 09:32:44 -0400
Message-ID: <20200416133244.3418-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:59::19) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:59::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 13:32:58 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ab80a3-3999-4ee9-c07d-08d7e20aae24
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3497F33FCE030191A4ABC058C7D80@MWHPR0201MB3497.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(346002)(136003)(366004)(39860400002)(376002)(396003)(16526019)(956004)(6916009)(186003)(66556008)(81156014)(6666004)(5660300002)(66946007)(6506007)(66476007)(1076003)(52116002)(36756003)(478600001)(26005)(2616005)(6512007)(8936002)(4326008)(107886003)(8676002)(2906002)(316002)(6486002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuzR0qZMW6Vh61eDZT9bo7OesgQ0SGxb5O2KN5tVyhJ7EWc3UG269xDkyESn2eLrCVOFAb1IaUdBs8FmoyXy5O74O8DZJINA7VlqbZ4Xtoiuhgg9+LB9VXw8kndxj2vpSJf4IzbrfVc7ekH/7jqTH1vDG2FSxBp6ANyNlkACvDkww4Rfvyql02/qSVxGe3S+4vTt1OJSiZZJIswvtWoSrBNEpGg2ndr7oEDpf+7y5yfOW6md3LkMxETiV53cdsSsGtgocYG25jUs8JMSfW0DhE1jrxpV16Zb19iB+QDNTBiFMHgwe8qJOhP8MgUlL3G1cFEWUyFCf8hsQpVHwykee5uDjvzuEtqZRNSLPuYFpsJuRlzmLoH/iPLfyf5AtUtKnCTO4ZfszWpaxZ931AwXy2ku935cby5jDpISK05sV1U0EToNBD3NCY4IwsTJRPDd
X-MS-Exchange-AntiSpam-MessageData: sSMQbj8ZVWY2XFsMMefmf1OwFHFdq+C6U0ABEfZx9Jxn/dEvkMNzsqZex+9gG/zzPvMPcxoON0tgYw3TYpRmZXJZCWoB8P6K/JXYicAcXCzdaFMW1OMOXYD53c9Y5yQdPmdmMnnLG/v4YvvhYUnRhw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ab80a3-3999-4ee9-c07d-08d7e20aae24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 13:32:59.9256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kvqr4dNpVobvyWEpi07aJv0Z0qUd3k6WAcJYmXwsMTPyYp/ZrWhnr2TpqJj4IXwbYNjtRtvLNBxnbKUtsnL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3497
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
Whoops, I was mistaken on what HISTSEG was doing.

 target/arm/helper-sve.h    |  7 +++
 target/arm/sve.decode      |  6 +++
 target/arm/sve_helper.c    | 90 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 ++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4733614614..958ad623f6 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2526,6 +2526,13 @@ DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_b, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_h, TCG_CALL_NO_RWG,
                    i32, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_histcnt_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_histcnt_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_histseg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 26690d4208..9dd20eb6ec 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -147,6 +147,7 @@
                 &rprrr_esz rn=%reg_movprfx
 @rdn_pg_rm_ra   ........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
                 &rprrr_esz rn=%reg_movprfx
+@rd_pg_rn_rm   ........ esz:2 . rm:5 ... pg:3 rn:5 rd:5       &rprr_esz
 
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
@@ -1325,6 +1326,11 @@ UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
 NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
 
+### SVE2 Histogram Computation
+
+HISTCNT         01000101 .. 1 ..... 110 ... ..... .....  @rd_pg_rn_rm
+HISTSEG         01000101 .. 1 ..... 101 000 ..... .....  @rd_rn_rm
+
 ## SVE2 floating-point pairwise operations
 
 FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 7c65009bb8..1489141792 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7016,3 +7016,93 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
 DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)
 
 #undef DO_PPZZ_MATCH
+
+void HELPER(sve2_histcnt_s)(void *vd, void *vn, void *vm, void *vg,
+                            uint32_t desc)
+{
+    intptr_t i, j;
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn, *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i += 4) {
+        uint64_t count = 0;
+        uint8_t pred = pg[H1(i >> 3)] >> (i & 7);
+        if (pred & 1) {
+            uint32_t nn = n[H4(i >> 2)];
+            for (j = 0; j <= i; j += 4) {
+                uint8_t pred = pg[H1(j >> 3)] >> (j & 7);
+                if (pred & 1 && nn == m[H4(j >> 2)]) {
+                    ++count;
+                }
+            }
+        }
+        d[H4(i >> 2)] = count;
+    }
+}
+
+void HELPER(sve2_histcnt_d)(void *vd, void *vn, void *vm, void *vg,
+                            uint32_t desc)
+{
+    intptr_t i, j;
+    intptr_t opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; ++i) {
+        uint64_t count = 0;
+        if (pg[H1(i)] & 1) {
+            uint64_t nn = n[i];
+            for (j = 0; j <= i; ++j) {
+                if (pg[H1(j)] & 1 && nn == m[j]) {
+                    ++count;
+                }
+            }
+        }
+        d[i] = count;
+    }
+}
+
+/*
+ * Returns the number of bytes in m0 and m1 that match n.
+ * See comment for do_match2().
+ * */
+static inline uint8_t do_histseg_cnt(uint8_t n, uint64_t m0, uint64_t m1)
+{
+    int esz = 0;
+    int bits = 8 << esz;
+    uint64_t ones = dup_const(esz, 1);
+    uint64_t signs = ones << (bits - 1);
+    uint64_t cmp0, cmp1;
+
+    cmp1 = dup_const(1, n);
+    cmp0 = cmp1 ^ m0;
+    cmp1 = cmp1 ^ m1;
+    cmp0 = (cmp0 - ones) & ~cmp0;
+    cmp1 = (cmp1 - ones) & ~cmp1;
+    return ctpop64((cmp0 | cmp1) & signs);
+}
+
+void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j;
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t m0, m1;
+
+    for (i = 0; i < opr_sz; i += 8) {
+        uint64_t n = *(uint64_t *)(vn + i);
+        uint64_t out = 0;
+
+        if ((i & 1) == 0) {
+            m0 = *(uint64_t *)(vm + i);
+            m1 = *(uint64_t *)(vm + i + 8);
+        }
+
+        for (j = 0; j < 64; j += 8) {
+            uint8_t count = do_histseg_cnt(n >> j, m0, m1);
+            out |= count << j;
+        }
+
+        *(uint64_t *)(vd + i) = out;
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5403ceb1d1..b2b6456a1c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7526,6 +7526,35 @@ static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
 DO_SVE2_PPZZ_MATCH(MATCH, match)
 DO_SVE2_PPZZ_MATCH(NMATCH, nmatch)
 
+static bool trans_HISTCNT(DisasContext *s, arg_rprr_esz *a)
+{
+    if (a->esz < 1) {
+        return false;
+    }
+    static gen_helper_gvec_4 * const fns[2] = {
+        gen_helper_sve2_histcnt_s, gen_helper_sve2_histcnt_d
+    };
+    return do_sve2_zpzz_ool(s, a, fns[a->esz - 1]);
+}
+
+static bool trans_HISTSEG(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (a->esz != 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, 0, gen_helper_sve2_histseg);
+    }
+    return true;
+}
+
 static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.17.1


