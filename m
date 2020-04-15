Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4FC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172552076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="otZzUcRM";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="LyEdl88y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172552076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjOZ-0001vu-6k
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 10:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jOjNd-0000q4-5m
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jOjNa-0002LP-EK
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:51:07 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:56732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jOjNa-0002J6-0q; Wed, 15 Apr 2020 10:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1586962266; x=1618498266;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=y0zKfs7Uy/uAmAMQfv6u0jZHVRB6I7rSYNAzH56d9SQ=;
 b=otZzUcRMD6jd9/nSBG1p31svoArQRD1tngBqgYQozBKeDqmXAhXtQFF7
 uksb2X7bMDB3UAEIst0E8paCc+x4gSdg2Q8h0DhY2AEQikCEcfDrd05P4
 DSWRQSUSxn2A0a3xTFbtOlv7yW59S6TzHxuB87iBtUa+q8CPwu92Ym38o A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Apr 2020 07:51:02 -0700
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 15 Apr 2020 07:51:02 -0700
Received: from apsanexr02b.ap.qualcomm.com (10.85.0.27) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 07:51:02 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 apsanexr02b.ap.qualcomm.com (10.85.0.27) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 07:50:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 07:50:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIuxkhS3aCMEFknjnhFp32UjVDfr80AvIceQo7QGRKeayuMQqgRSZwC7HMtrO2Scox4PnkzSfhwoUz9LlfsxxBdC100Yg9thMN+kbl10FdMeScQNExjohTyt+julISulAW25AUB21dJ/wDBUzHqL+Kprd199g2tSyuCdI1ACTJgraNqm9BkKmdubRU+ijjdHeegnXH1Z8lBsJda2qkMD8in63cGjVsiWRdHeURtcTSguO1SdRiifz8dSiEVdffK2rTQXp6c1h1ERDXS3698FXQQ0HAbdHdtEJd0F1NMIGMaaYzv8FMfabChU5z/GTd3f2rEVeKCtFKQCZ1+bHxH2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXCK9ezWbmol15biO5EIlD/PssmFE5WDtL0ZpRj0YCc=;
 b=Wv+ndui1Is3l2MuZO87HYhLzNSI2OpZMQIn2gnBJhCrIrheweukgJU8IkjoIYeLpeYfOMAwks/PAliCbZKmePn7DvNTle8WXpfo2D9QXLq2/ECfV+0Tep/35tjE/qCW67QoseqkMsoFK7/XqYnsqbemVWr4vrSOUWcVrJCHs0Xp5goDbYTN5g53mi3USxULnD5AjYnLDUrzPoMluWdSgNrp3nAPIlFYOn45JhS5wDMuP7Ey9Pdw2cwLs+FhLOYCb3zZzsbBYJz0nAaHaey5cL0DNeEv+vYj3D+FsIJuaAHRiyHZY7TS193e6Os7rRRd6Q4DsWpBWwyeCaVogQsnkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXCK9ezWbmol15biO5EIlD/PssmFE5WDtL0ZpRj0YCc=;
 b=LyEdl88ybeIe6PjBTvmc/86yySQN6eJGoqXy9aEShLj7ToQIvrZSl77fAOcWtYQxJJLKr/8ZfDv02EBIOESn8tYTO6zBRB08phq1Q9vvYuZXZQQjOvc7H0D0ilsr1whc4SCp7V+iODmChj+A7gAxduOr91dfhlCrMK7Vt8lIzug=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3578.namprd02.prod.outlook.com
 (2603:10b6:301:77::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Wed, 15 Apr
 2020 14:50:58 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 14:50:58 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v3] target/arm: Implement SVE2 MATCH, NMATCH
Date: Wed, 15 Apr 2020 10:50:32 -0400
Message-ID: <20200415145032.2442-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:610:38::15) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:610:38::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.5 via Frontend Transport; Wed, 15 Apr 2020 14:50:57 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565b3ddb-b593-4cbe-b96a-08d7e14c6878
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3578DE576420EBCF1D83DBA6C7DB0@MWHPR0201MB3578.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39860400002)(66476007)(2906002)(8676002)(5660300002)(2616005)(66946007)(81156014)(8936002)(956004)(1076003)(478600001)(6666004)(4326008)(6486002)(107886003)(66556008)(316002)(6506007)(6512007)(26005)(86362001)(6916009)(186003)(52116002)(36756003)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tljFxBWLRwUpMOKukvFQW+/iZIhX29w8N5/BYygmhCyTLBqGTunUjj/QgaCuaP3Eqm4mDqE6pHXhSkF0IESAmulW/1hDv33ez7pUBgjo88F5HGldn5/ZLwyohJorz4mAJj8O5g666YOwchUVUllfP2TyN2+8TawsFX0mW/3fYI2hDQfHDyqmieIyuKsMqMRCG4eiZ+wSBIy0gBCq9mAr8R1shh6l4Q3ROuP79wYqcXdX1QpApqj2u0rLeHqalwzBBq9/dP8ViNVNpX+4fdrOoIZNTlLbklBv85nchGZh8Apa9VHVJwr2tGpLrQ1hFlQ3fDd5y+UGK0tE7sOmpWLLL53zZ/9bEIh7Qixb33r3B8up25bqkgpwVr8Yhx9EhyYoI2eTniabSbixs+1+s2Pz7Q9W06JjUxmLlDZCioCj3NV2XuATR+XC75MHGvexJxd
X-MS-Exchange-AntiSpam-MessageData: w7h50HTuBEtbGwwML5RgxxqqP4vy5HSsRIG5IELM+1974OdLSICYf5VDzUBhx7Qw5aH9ImDh2Gfp28/ccbGYXQ9+GsVkqeF7v0aOM6HKFvnT7ncaC9Vg1uYtuMw+0KcxfQEMfsXABX82O79LdhqreQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 565b3ddb-b593-4cbe-b96a-08d7e14c6878
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 14:50:58.4769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QnlybB182kROYGcK3AWY3D230MZSCq0jPTUsPlugcPAIDov1/PG+bMmFqmFnY9GzOeaKIznUHqbxqTUcs/KJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3578
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
Fixed the patch with the suggestions Richard made. I'll be working on
the HIST insns next instead of the 'SVE2 integer add/subtract narrow
high part' ones.

 target/arm/helper-sve.h    | 10 +++++++
 target/arm/sve.decode      |  5 ++++
 target/arm/sve_helper.c    | 59 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 22 ++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 5dd880cf6d..bc4a463bc7 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2516,6 +2516,16 @@ DEF_HELPER_FLAGS_3(sve2_uqrshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_match_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_match_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 374e47fb05..652668df02 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1305,6 +1305,11 @@ UQSHRNT         01000101 .. 1 ..... 00 1101 ..... .....  @rd_rn_tszimm_shr
 UQRSHRNB        01000101 .. 1 ..... 00 1110 ..... .....  @rd_rn_tszimm_shr
 UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 
+### SVE2 Character Match
+
+MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
+NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
+
 ## SVE2 floating-point pairwise operations
 
 FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b68f62cd7f..3fbda7ec62 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6890,3 +6890,62 @@ DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
+
+/* Returns true if m0 or m1 */
+static inline bool do_match2(uint64_t n, uint64_t m0, uint64_t m1, int esz)
+{
+    int bits = 8 << esz;
+    uint64_t ones = dup_const(esz, 1);
+    uint64_t signs = ones << (bits - 1);
+    uint64_t cmp0, cmp1;
+
+    cmp1 = dup_const(esz, n);
+    cmp0 = cmp1 ^ m0;
+    cmp1 = cmp1 ^ m1;
+    cmp0 = (cmp0 - ones) & ~cmp0;
+    cmp1 = (cmp1 - ones) & ~cmp1;
+    return (cmp0 | cmp1) & signs;
+}
+
+static inline uint32_t do_match(void *vd, void *vn, void *vm, void *vg,
+                                uint32_t desc, int esz, bool nmatch)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint32_t flags = PREDTEST_INIT;
+    intptr_t i, j, k;
+
+    for (i = 0; i < opr_sz; i += 16) {
+        uint64_t m0 = *(uint64_t *)(vm + i);
+        uint64_t m1 = *(uint64_t *)(vm + i + 8);
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        uint16_t out = 0;
+
+        for (j = 0; j < 16; j += 8) {
+            uint64_t n = *(uint64_t *)(vn + i + j);
+
+            for (k = 0; k < 8; k += 1 << esz) {
+                if (pg & (1 << (j + k))) {
+                    bool o = do_match2(n >> (k * 8), m0, m1, esz);
+                    out |= (o ^ nmatch) << (j + k);
+                }
+            }
+        }
+        *(uint16_t *)(vd + H1_2(i >> 3)) = out;
+        flags = iter_predtest_fwd(out, pg, flags);
+    }
+    return flags;
+}
+
+#define DO_PPZZ_MATCH(NAME, ESZ, INV)                                         \
+uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
+{                                                                             \
+    return do_match(vd, vn, vm, vg, desc, ESZ, INV);                          \
+}
+
+DO_PPZZ_MATCH(sve2_match_ppzz_b, MO_8, false)
+DO_PPZZ_MATCH(sve2_match_ppzz_h, MO_16, false)
+
+DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
+DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)
+
+#undef DO_PPZZ_MATCH
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 07a2040208..c07d39a007 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7246,6 +7246,28 @@ static bool trans_UQRSHRNT(DisasContext *s, arg_rri_esz *a)
     return do_sve2_shr_narrow(s, a, ops);
 }
 
+static bool do_sve2_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
+                               gen_helper_gvec_flags_4 *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_ppzz_flags(s, a, fn);
+}
+
+#define DO_SVE2_PPZZ_MATCH(NAME, name)                                      \
+static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
+{                                                                           \
+    static gen_helper_gvec_flags_4 * const fns[4] = {                       \
+        gen_helper_sve2_##name##_ppzz_b, gen_helper_sve2_##name##_ppzz_h,   \
+        NULL,                            NULL                               \
+    };                                                                      \
+    return do_sve2_ppzz_flags(s, a, fns[a->esz]);                           \
+}
+
+DO_SVE2_PPZZ_MATCH(MATCH, match)
+DO_SVE2_PPZZ_MATCH(NMATCH, nmatch)
+
 static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.17.1


