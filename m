Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB4EC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A82207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FBQElcsW";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="dC4l8Mnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A82207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5kA-0002xa-5s
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jP5jV-0002Pw-Q1
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jP5jT-0001Bn-If
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:43:12 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:29832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jP5jT-0001BU-4y; Thu, 16 Apr 2020 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587048191; x=1618584191;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=aM3fQYAYsmzWQZk45QjumC7ZQT5nOJfHHGWxE85H1WA=;
 b=FBQElcsWnvCcDoZi57Tw/WCaicBPASyxQo2KSBug38/SmoFO9E8pQgtI
 3Y5RCsWC5cQ2JmHpvKIm//NsYMI8GGdSfiAY5pd88DIvAUvOKT7V0c1WV
 +8XiYZoCokPFFB4ELkUCd9rEEEWP9z+c1OcH91mXhPwoCtrKZSXnbkcyF s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Apr 2020 07:43:09 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 16 Apr 2020 07:43:09 -0700
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Apr 2020 07:43:09 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Apr 2020 07:42:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 16 Apr 2020 07:42:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTlhIAfI73hpxHVOxVguV9uTIE6M737uV5WafavE5oChMKOWjbbipEgbWTNcJQP4zBTjtRteiyJzhqLGD89j/Roh8r1ZndoGqqwvYRrrlE0jT3D79CuRRHAKlGGofmkrLeegNJxxKx27GFJ7IHYOhkMBS5fvzZJRS7WSC5Dcja93kY35V63dvdnh7/vTKuguU+K7+eOvdVhf42bDUo9EzRO+Jan87Ig0CIpKH2Wu5kToK+PxC54F6Mzze0t1qXnDvqHNktNUNJxwbN5ko+LeEUeuTCErcNXXLf49fn+Ic39qUJYTAf+t0IiXzdTV5gzgPVefJFyYrIKwZ1xIxK0kgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUIv9krm2w4ZboB2mLI2e/SCqeUie9Q5p1Gdd/K8/F4=;
 b=kQ9wX0IqarwT2w34nw7PaFuZx01ovvMOtA15qx1QbLZ9ILtn+TSeDHgMX54FYQ7iwychhfsG643+oIZbSP/PnQ5Cs/AAldfBcePmFgFBkNNwQdJ7ZD471iouKd+wcKqsU7wyYoTqBfoimlaLRokIQIwRERLzcq6ntxxvktzu7XNY/2doBvFAGQh3jYhZGHE97UYXBil6zzN/2/XdoPY11eq2q5IcgBZGb85rSxB6d9KnaBPV4Dv79DeQ4hIPuhJOkH+moeg/jqEnH+QR/ufkC9PbNEiT+xRMbJKfDtTAawEoPDSxpRwrmcX5aaCWEHN7JVUuNF6Ahp6zy2dhHF2v2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUIv9krm2w4ZboB2mLI2e/SCqeUie9Q5p1Gdd/K8/F4=;
 b=dC4l8MnvF3967UX+4jzcCeUW+J9XSBR0dlZ8BqTwUeVTNvID8tn+WP9kSZiZZu+qrsWzww08mOb6BXw5C2AdrnIBS0Ob+oLsvZWWjQ040isf/Fol2SmO/V6rZGgGoOEodeBzVo0aJvB5LWr+h3xcB0GGzZFFsO0iBwd2uGITtxE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3498.namprd02.prod.outlook.com
 (2603:10b6:301:76::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Thu, 16 Apr
 2020 14:42:26 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 14:42:26 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v4] target/arm: Implement SVE2 HISTCNT, HISTSEG
Date: Thu, 16 Apr 2020 10:42:12 -0400
Message-ID: <20200416144212.4898-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:610:60::18) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR14CA0008.namprd14.prod.outlook.com (2603:10b6:610:60::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Thu, 16 Apr 2020 14:42:25 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b068da-fa0d-498d-696e-08d7e2146193
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3498:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB349890E3CCD09F7339478E39C7D80@MWHPR0201MB3498.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(136003)(39860400002)(396003)(376002)(346002)(2616005)(316002)(6666004)(66556008)(66946007)(36756003)(956004)(8676002)(6512007)(6486002)(1076003)(52116002)(86362001)(186003)(6506007)(2906002)(66476007)(81156014)(4326008)(107886003)(16526019)(8936002)(6916009)(5660300002)(26005)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1ypAFRpzooCc+bWIVEwk1zh+5TPBO/SmNyvUHV0nBaRdeuSJgOynEcJ/HzzBYKvaZ7j1P3r5uEVHewE0KOASa4kr7SVq1CcLpF7+ymmqqvFCwn3LsVkxPN6Fb8M7VQV6v4gGeb8dddHvQX/VMZFChN9e9VytRZ6l/Fqk+T8bP3iUord0YXziD5CFIcBJS4awsVW3blSLktgd06ESbtb1a11fkQuqRi09UeAxbAJhThLWjxZJz8H1aIIA3YlhQQdQn0P/Lq5GA9NcAWvrFiPO4EHpTDoYdBqeAEsNmsz4WWZ7+qfv1FmjCLbuvL6h4/xQso6mNFpqQ6upkH9npBRkOEjdvH0Vl14ihwEPFOVW9W8eV/vpvouX/+tV2far97vdzUV1CRXR2WbhcNz9fM567KDIaZpKaazkvqbiWA4Nz84NNAHVKROaXDFMBXxDty2
X-MS-Exchange-AntiSpam-MessageData: 11KP2Le92ENmYdDqO1eDk433UHGMb45f9sm5HCbdPtPg4V8CQvnWTtbJP47q+sxDMo3WqRegIAffr0l5KKEPeZZxAJknmIdc7qvAjw5QJO9Uu+D+v/xlADycf7K+CJmi98MPt1EzcIA8IrzFzBN8Rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b068da-fa0d-498d-696e-08d7e2146193
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 14:42:26.3866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aHHhNB7vEGtkjhicCR03wJ1049Dj71qWKil+vNLehYRk9JirQCgczi+6bJbdChObUomWTdCwHOZlpXgyP5iiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3498
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
Fix error in the helper function for HISTSEG

 target/arm/helper-sve.h    |  7 +++
 target/arm/sve.decode      |  6 +++
 target/arm/sve_helper.c    | 94 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 ++++++++++++
 4 files changed, 136 insertions(+)

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
index 7c65009bb8..793ce581a8 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7016,3 +7016,97 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
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
+            uint8_t count0 = do_histseg_cnt(n0 >> j, m0, m1);
+            out0 |= count0 << j;
+
+            uint8_t count1 = do_histseg_cnt(n1 >> j, m0, m1);
+            out1 |= count1 << j;
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


