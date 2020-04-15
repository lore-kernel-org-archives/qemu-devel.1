Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D6C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02292076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DxFQJO48";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="kL1QHqtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02292076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjWg-0007GN-Or
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jOjW0-0006nN-PV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jOjVy-0007ZS-88
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:59:47 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:56534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jOjVx-0007YV-RF; Wed, 15 Apr 2020 10:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1586962785; x=1618498785;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=TRFuOfwT4/5jrDtuDj9VMvba8ma9A0UAS+Plx/yRDqk=;
 b=DxFQJO48Kkj+RJhMWuQkH84xnnFVGVbjM/UKMgUlHokqSUMnnv2YeC7e
 usP+avv32Zbd29ZvYpW5Ueege08xcWejGF2C09qyCZUMZKywCTa1DvS9f
 0KhSDjYgRD/aV4vdE56tCq9wohhcPW3b91zp565OgZV/rDcGmwxmLteo2 w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Apr 2020 07:59:44 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 15 Apr 2020 07:59:44 -0700
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 07:59:43 -0700
Received: from NASANEXM01F.na.qualcomm.com (10.85.0.32) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 07:59:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 07:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIUPCYVbJYtLPYganw7T5TGogqsbSMJn4atHZ8+mHH0IlAXi8+uEJ3PoOf+Uz32IeBklNGLi2DCRtrzNqQQAEcFriCrEJWFsS/xtr2HPxM3UI4xC7Anu9lH1TtrlgfIKa4eD5r7l8QLvQO4FEG096SrDertZIuzbwSQltDKVPp+flShljWfB3eNt9FJg76nHeMP+/ZF1JDRSiAKDUbLlMItUYlE03pHKeppXKrq5t2+VNntINsenZMTre1ePB9Jw9HTW0/z0mx9x2oowPgKroW8CF/NLhrFcF6MFlCly22Nop7FSPQs6GS6jmY0ymmcTDDR1XkVR/giD5rB9MO49Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UA34p7hSJoQ2X79xA/nP76zQ20Xgl96Gm0fYrGJj3M=;
 b=Lik4ujNvMOLDEkreMmbG9cRBNV3mLIfkahjglQeerJj0dY9m53k0vsMCL0RYjLBjNwDbc+Fgyk3OeVMp+hvgOqIN21GUUV0S6CW2Np2SFc7KyLu5Tgm8dNNSxm8AczBf6sD3Mw90S6onF8/HJ/zw2xjH1DNxFV3cWo7mY/aYpQwfB1SwQVwKZNSyI4LPfW8H4I15L3LKqRI+EKSyXzuCqbKiIXgpODek1jxtzwRepK6+VXEppSI9Vtnm2fblJHfQQxmAklLFjBlkN9O1kZCTWqRJ+1houlEmYT1NHexyOpT2OOET4GC4Dz7aw9pQeTZk7Ksbh1hooknUfbu2X3oecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UA34p7hSJoQ2X79xA/nP76zQ20Xgl96Gm0fYrGJj3M=;
 b=kL1QHqtc32YMPSmL4QJiOaGf8hLVhAKZ1FpyUkfVGAOejowJ2pjhTbLGX4IQ00Hv+maOPtF/nGIXVXzIe4qQFMqimV4hXFcD+gOK7GEy7CFBqYi6U43s5LQKWlrwl0wL5Fp07vwGGbQ/z38i9yENQThUfLLSJyAFgounZl/zWuA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3595.namprd02.prod.outlook.com
 (2603:10b6:301:7a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 14:59:39 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 14:59:39 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v4] target/arm: Implement SVE2 MATCH, NMATCH
Date: Wed, 15 Apr 2020 10:59:15 -0400
Message-ID: <20200415145915.2859-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0038.namprd14.prod.outlook.com
 (2603:10b6:610:56::18) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR14CA0038.namprd14.prod.outlook.com (2603:10b6:610:56::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 14:59:38 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487a2dfa-b130-423e-c371-08d7e14d9ec4
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35957CC72FF5DB1625B985EAC7DB0@MWHPR0201MB3595.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39860400002)(956004)(6666004)(316002)(66476007)(1076003)(81156014)(66556008)(8676002)(4326008)(6512007)(6506007)(107886003)(8936002)(52116002)(66946007)(5660300002)(36756003)(26005)(86362001)(6916009)(2616005)(186003)(2906002)(16526019)(6486002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yyIRca4JKf9xYMkYsNbmQkaw1/b/Fruv1/9O9NJv0VTtgUCOZmJbBBRFH6CPa0Wd+BGsuViV0HmScWvgMoSJbu75VJ2t6a63rUwdnW+Vm8/8iS+939jX5lYrexIrJzMQ8A+xLN4tEWEmg5R1m1hrA9Lq/YIwg90lpzVbD85BkeQ4ZZcUEecZPtF/TV4eERwxYgjm6e4LAo+FuaH6NrUOa6POPoAF+OVz/jjYhkG0ZdGufZcdyjc9UW40t6Eb73jaRjNFMgybgwiJfdaHlZDPcEnFiNAEpcVD9catZowSiFYR2wf7/oGyNAX+b2bjrtEcEQDGpuJ3bcmqryViTsejHwCAxA1Q43BW5vlJjqeKT7flOiMufI/R2hpT12kffMkZqGeVc95JFYsypdxgWrZYvy1U0n6dGasJnjr/7cs/I8gvcXS82CebXoEO01v5Fb2
X-MS-Exchange-AntiSpam-MessageData: 2qIo8+uxk/5DlpKhPnc0TIkpjDYdGFRb7TIv9yQgy8WW28G3KD9x5Ug2hig8DaBEMI9/CBLFqrzA8x1va/W7C2Bvzkt7h5WqwlV+JMTPZR1TkR6LJgSrTmSy56qoUZf2oCm2JjMH7GnoP9NW3P3Unw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 487a2dfa-b130-423e-c371-08d7e14d9ec4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 14:59:39.0400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvHXEtxwzljlhikwtaIaqanTa+f919nMJAfh6mvQwE2i2rs26Nert5Z1rKp5dzFBaJJSxpgRRKdsIIHSsT2VMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3595
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
Whoops, forgot to complete the comment for do_match2()

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
index b68f62cd7f..7a7f33087b 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6890,3 +6890,62 @@ DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
+
+/* Returns true if m0 or m1 contains the low uint8_t/uint16_t in n */
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


