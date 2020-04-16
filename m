Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF72C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9432063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="vztR7D+C";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="S0dxPiId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9432063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP8NY-0004Ly-6J
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 13:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jP8MS-0003sa-Lj
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jP8MP-0001N4-1f
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:31:35 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:42050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jP8MN-0001M9-GK; Thu, 16 Apr 2020 13:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587058291; x=1618594291;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=YamiiQ90Yk6mVyCWYTrfdAXRVps/J6Kq0wv5GuNLaTM=;
 b=vztR7D+CilLi/0k7cumayYApYy3WL/3tADFFs66WfLqYaZuPavVCw+3e
 FVrLlxsWSYWzIdh2DjSY9Dn/u+JvLM+XwBJeZJDlcNRgfSAHkQPLA2dV5
 vNyT3gDt7kGn3+71OPbCatvK6RBy5KBX6eE7emfi4rpmexhFQ0xBcL3vi I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Apr 2020 10:31:29 -0700
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 16 Apr 2020 10:31:29 -0700
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Apr 2020 10:31:28 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Apr 2020 10:31:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 16 Apr 2020 10:31:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYrxPoL24L+QRQNVCuSwcBw9IuGcbyyrL4AtU2WkVJpblk4pyFuYXK7mg5zuDKr+TtIhKbMT3FBvK3nIbrcVlbkekXGSluk0KLqUKHCUK399pYj5+SchoRZ3PkWG/lgCStrhy8pgQyh8phc/iW6edX7GXEGIRB6k69OZ/uurP+tMVYlbxPHTky2pDPrD8xRPPO5dOc9KNNkitnsmaxryYEoMoZCKFKL2lYOuXapYSDIkcZxNSXRtJSZblcZB8HdGerQ/uZFwadaSNOxAWR0U43kDw61apnkzttU6JzEsSK98JuE2L3zVi5GbYkAOP/bv4edZ5qkGHAVq0iiWmkVmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXtpbRL1cBpyIqKXv2v59uqgJyqy4c6EqdeOzR+QXoc=;
 b=WhIdoA898HCaMUZjXisbfIJGAm/Ku2DhobaU/bFyaHu4zBO6qaHqP35QArI8o6Qlm57Ud0jgpdKu16BSqonc3SnUK9APyGxJjXmqEvni9zVFT9WqV6MjthnUclUKLdD9FBilr+tke+E6hult3Kd6VdGCLNn6nNvW0bymjcs3QRFNZ5RiheMS3Zpbg91sOfljVcL3nhCnPG5L6KjYX1wbL8gDs2lVZaR/NpaKBPAsrKO5Q5o+pnGAGiBuluI0sGPVNydSdIPPPPwMTmlOpvhY39Fpzo4/5L2Wfn+Ci/rpjUxkoK7P0leR19x/7jPr3TE78h25NZrHDtepEa/mwat+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXtpbRL1cBpyIqKXv2v59uqgJyqy4c6EqdeOzR+QXoc=;
 b=S0dxPiIdZziZ4qlYXlazfAx8306g84ToOgpGSin6yNoEH2hW4ixHZMsPbmkoxEJPcFwqOUjUd8nnNzLyQV9QOwAOh0uAWKupkLqIX+aiReHAw0DRR0Fjhpj7hZ7k23NRv5xXK9oRttBlm6sQwkOAg3AFND/NV9jo6rXcLI6CvHo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3593.namprd02.prod.outlook.com
 (2603:10b6:301:77::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 17:31:24 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 17:31:24 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v5] target/arm: Implement SVE2 HISTCNT, HISTSEG
Date: Thu, 16 Apr 2020 13:31:09 -0400
Message-ID: <20200416173109.8856-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:610:51::35) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:610:51::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 17:31:23 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 421600e4-15fa-4bff-6fc3-08d7e22bfc4d
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3593:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3593FA78F01A1190D8953418C7D80@MWHPR0201MB3593.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(346002)(39860400002)(136003)(376002)(396003)(366004)(66556008)(6916009)(66476007)(66946007)(107886003)(5660300002)(16526019)(6486002)(2906002)(956004)(186003)(4326008)(8676002)(2616005)(86362001)(8936002)(1076003)(6506007)(36756003)(6512007)(316002)(81156014)(26005)(52116002)(6666004)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPxKvM1jx5vw5FxwAZe4Qkb84VudJ6W1PkR5/Y1Wl9EH3M0t+uL2xE2lw/j/WmLSgn/m0pL7TMFxTYfX+w0CrYwsoBBWtjjhhqLmm4nXH3/QfSZ946NIr3tjTrNfMrVNdNkb656MaQQPyy/cb79A4kBAoYwB+41pvHrZ/LiVwFVauY0NHAXN5l7D3V5DVP1sgJYrcwKWOh8awzlz24ZAlDnv5gNxRuucPZaQ17K9Ek0PQXKkIKUv5zStGNuryisKXvY/P8QHHgZifvJbRDgd1i+KV5OTQ55VJXyPQH0sdUVN3wWCGl4VVVSHmbTJHvEId38lxPxE2XVXxJ/LDlJ4fQntM8vCBZ71QZ99gsMpJdkUM+yzGALG/k7qmBuGPDKta57Gte/Alryps0zR61bwlrT/jW9mrwhXHRrXV0cyXcS5ssjzVZ6KxrslE0rClJTJ
X-MS-Exchange-AntiSpam-MessageData: xlMTbH/6viknmowz1t0nM7kRP6gtkcXUgwsOWJ6D50T0PV+PRRwPyyEWRqAHFE4QlYdb7F07xGoqGkr25nv0oyHHcX5ShYtWWwurVgRtNvL6pSsnPOUcm96jfj8Q16UmlpNeyMUhbLRMPleJin1yYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 421600e4-15fa-4bff-6fc3-08d7e22bfc4d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 17:31:24.3527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaiDuwEbqqIcskylVzVlI/pwK1mfAcQ0A+m6UFsIwWQFtRKXbW4DIxDkoVMbM8iZNJmAwdvQdXIO1RntjbEaWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3593
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Made the fixes Richard noted.

 target/arm/helper-sve.h    |   7 +++
 target/arm/sve.decode      |   6 +++
 target/arm/sve_helper.c    | 104 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  29 +++++++++++
 4 files changed, 146 insertions(+)

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
index 7c65009bb8..65857e27b4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7016,3 +7016,107 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
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
+static inline uint64_t do_histseg_cnt(uint8_t n, uint64_t m0, uint64_t m1)
+{
+    int esz = MO_8;
+    int bits = 8 << esz;
+    uint64_t ones = dup_const(esz, 1);
+    uint64_t signs = ones << (bits - 1);
+    uint64_t cmp0, cmp1;
+
+    cmp1 = dup_const(esz, n);
+    cmp0 = cmp1 ^ m0;
+    cmp1 = cmp1 ^ m1;
+    cmp0 = (cmp0 - ones) & ~cmp0 & signs;
+    cmp1 = (cmp1 - ones) & ~cmp1 & signs;
+
+    /*
+     * Combine the two compares in a way that the bits do
+     * not overlap, and so preserves the count of set bits.
+     * If the host has a efficient instruction for ctpop,
+     * then ctpop(x) + ctpop(y) has the same number of
+     * operations as ctpop(x | (y >> 1)).  If the host does
+     * not have an efficient ctpop, then we only want to
+     * use it once.
+     */
+    return ctpop64(cmp0 | (cmp1 >> 1));
+}
+
+void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j;
+    intptr_t opr_sz = simd_oprsz(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        uint64_t n0 = *(uint64_t *)(vn + i);
+        uint64_t n1 = *(uint64_t *)(vn + i + 8);
+
+        uint64_t m0 = *(uint64_t *)(vm + i);
+        uint64_t m1 = *(uint64_t *)(vm + i + 8);
+
+        uint64_t out0 = 0;
+        uint64_t out1 = 0;
+
+        for (j = 0; j < 64; j += 8) {
+            uint64_t cnt0 = do_histseg_cnt(n0 >> j, m0, m1);
+            out0 |= cnt0 << j;
+
+            uint64_t cnt1 = do_histseg_cnt(n1 >> j, m0, m1);
+            out1 |= cnt1 << j;
+        }
+
+        *(uint64_t *)(vd + i) = out0;
+        *(uint64_t *)(vd + i + 8) = out1;
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5403ceb1d1..6c237343ef 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7526,6 +7526,35 @@ static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
 DO_SVE2_PPZZ_MATCH(MATCH, match)
 DO_SVE2_PPZZ_MATCH(NMATCH, nmatch)
 
+static bool trans_HISTCNT(DisasContext *s, arg_rprr_esz *a)
+{
+    if (a->esz < 2) {
+        return false;
+    }
+    static gen_helper_gvec_4 * const fns[2] = {
+        gen_helper_sve2_histcnt_s, gen_helper_sve2_histcnt_d
+    };
+    return do_sve2_zpzz_ool(s, a, fns[a->esz - 2]);
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


