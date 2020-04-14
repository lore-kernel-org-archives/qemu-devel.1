Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D64C352BE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 23:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF712072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 23:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YeKjtJiD";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="lb3BpkA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF712072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOUon-0006Be-RR
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 19:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jOUnF-0005Em-Of
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 19:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jOUnD-0008D1-AK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 19:16:37 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:15207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jOUn8-00089o-Ry; Tue, 14 Apr 2020 19:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1586906190; x=1618442190;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=c+cvB6KQoxXwY55s9UvgZq0i+DQyMQVJNjY6CAAWGUE=;
 b=YeKjtJiD0puWPRJLk5vfRCJZZPJ50Zt0Gzzx2NFJIOEnedprxy3uyEFX
 RzBomvoAodQqASIuwS4JYTZwcxQPqAiPf+viJfBb0NHnJ5CX31z8VVe8g
 a0vG85dmFy7itt3YPm6/r3Zvo25ghx1lURj2+8oqSQCLW9O0bWLZ1SVv+ w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Apr 2020 16:16:29 -0700
Received: from nasanexm03b.na.qualcomm.com ([10.85.0.98])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 14 Apr 2020 16:16:29 -0700
Received: from NASANEXM01H.na.qualcomm.com (10.85.0.34) by
 nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Apr 2020 16:16:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 14 Apr 2020 16:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFgPWT3jICUe9is5NM9/VuULoEBipxnSe2WzRGdmXpNTteYdJT6RdDrK9g3IJPKRBW6lDtK3lrk6wtfXxpOKgZR0SSO09aoatxnsNc64uvrT53hINHN2gqk8GGRlYIAWI2tHcVI54lVdlBCaTtLvlmJHOYZ9RY3eJ1sqMUyxIJ1FRE3ynQHv++AoDV46jBYr0SvRh/Gdo36AE+gaBaM1ebYFcWrVTp/aitVsHIihZImNteuQe7KtQEB9Lkn8sIy8FXmlJPNE5W57N2MhkBDlbJZMjalUjx6QmpCyQMzGneB86xzGqPng+tVcpIpW4bMZlolVlXSGGWe4VrdWfQEAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpxH6l9JQaJE/mMsulXPKm1uHKkx91IXbEQ7HC/2jDc=;
 b=mhMtKRptdH9BifTqQCXw0b2Y55GbOgIs4sGB1XNXgnU0JkOzCWmFYakyR66p2w8FODAoDmuAprdaYhuk+FfLktmhq/nFsxVfU7g4OYMvY+l4FbemTJoH1bzdOV5/fkcHDWEelnL5fvo6gkdj8/Xwmle2WKiKvJEgSkr764fLItkT9xdmZeY8XEDmKpkGpH9N8ZAjunhfWcf69gYuWWVQSllIgQYnHunILTieo3GBmZ1s8DdvFZHm5oCKYr9QU+QCVhRxeGvOdC9SDPGNguRsf4MPwTKWih/fGgev9tmstJztjNRPlOJ+ND5rWUfbAn41u6A7Ac+VNMFryU9P0k+iUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpxH6l9JQaJE/mMsulXPKm1uHKkx91IXbEQ7HC/2jDc=;
 b=lb3BpkA8JTFt4asH83lCjMsLRUBtKYvyOvCp+M2XuSNWOhQpPBV1O3j4a5vbQrT2Y4vNbB52+75SzQG00FgzARirmc2cd0B7K9RGRQ82QDIl3Of/OVxZRsPcFO4/xunwH0WoGnEeEb+lEnNRElrIugyM7InkQNyIGJjRsaOh/l8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3465.namprd02.prod.outlook.com
 (2603:10b6:301:76::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Tue, 14 Apr
 2020 23:16:26 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 23:16:26 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2] target/arm: Implement SVE2 MATCH, NMATCH
Date: Tue, 14 Apr 2020 19:16:10 -0400
Message-ID: <20200414231610.8387-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 23:16:25 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0b1ca4-04b5-4111-ae1e-08d7e0c9daa4
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB346566C489975217E6B8333AC7DA0@MWHPR0201MB3465.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(2616005)(2906002)(6916009)(8936002)(5660300002)(6506007)(316002)(86362001)(6512007)(478600001)(107886003)(81156014)(4326008)(8676002)(6486002)(186003)(66946007)(6666004)(956004)(1076003)(16526019)(66476007)(66556008)(26005)(36756003)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qUVclR6GoxHtkOTyPHxaCOYVRcp3eTMlTla/Q0l7PEN+5pHqIP2C7D3AeF/gPosX4WfEgx5dXAFf6WLwwdKJB7yaSCMRZmXLPgzbJmBTF6BusU+SdcSsSauJZvM2Q5U/78rR+Q8Km3h2F6OKyV4T9BnbIdmTAI8Wpk5uKK71V0VqGNuTau2sY32j4XMITWmQc1kPsQYD5s3EUOpzmqeBNs+5jl8OFneicvJRKlSz40YnWK0pzOADNgGmj3qW8yIBHgBcqXxbkvHZ9QYisSe9vBolYo7rvteXAqPdpYwK8N/WlKsasf+wAj7yMh0ZDUq+8xYQfVQI7iUIvLgOi4RN8C4woJxXoMI4svivsRIS6B8riHGhJeVUJimS2eW0YGNgUza3Geo99Z7t7+ijV4jG1+azdOroPoty69GzNbDiEAs6TX1CoWjOkEk6y21W2HL
X-MS-Exchange-AntiSpam-MessageData: un6RG8eiKLGBvbsApI/2MZ9iaXmN/1P45adkGi4k/g4CJSv/16Jj+YeXWlYXLH2CI3UrnhSW6/Dv8ziGsYaIL2AVA5841ARvMezV7g3pITQH7vL1nLvVhFfGLJG1ZVwUOks0h1/ENfcCuX0emS3VvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0b1ca4-04b5-4111-ae1e-08d7e0c9daa4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 23:16:26.0066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNtSLSbPAH8lu5z/zl5fk3dB/DFaOSD6y5k7d32Es9Qmqf3EIihJU421dXP1J47wfNsPO0Mkt1jQtIu3mQO7nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3465
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
 target/arm/helper-sve.h    | 10 ++++++++
 target/arm/sve.decode      |  5 ++++
 target/arm/sve_helper.c    | 51 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 22 ++++++++++++++++
 4 files changed, 88 insertions(+)

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
index b68f62cd7f..78abd8b62a 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6890,3 +6890,54 @@ DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
+
+#define DO_PPZZ_CHAR_MATCH(NAME, TYPE, OP, H, MASK, DEFAULT_VAL)              \
+static inline bool NAME##_inner_loop(TYPE nn, void *segmentbase)              \
+{                                                                             \
+    intptr_t i = 128;                                                         \
+    do {                                                                      \
+        do {                                                                  \
+            i -= sizeof(TYPE) * 8;                                            \
+            TYPE mm = *(TYPE *)(segmentbase + H1(i));                         \
+            if (nn OP mm) {                                                   \
+                return !DEFAULT_VAL;                                          \
+            }                                                                 \
+        } while (i & 63);                                                     \
+    } while (i > 0);                                                          \
+    return DEFAULT_VAL;                                                       \
+}                                                                             \
+                                                                              \
+uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
+{                                                                             \
+    intptr_t opr_sz = simd_oprsz(desc);                                       \
+    uint32_t flags = PREDTEST_INIT;                                           \
+    intptr_t i = opr_sz;                                                      \
+    do {                                                                      \
+        uint64_t out = 0;                                                     \
+        uint64_t pg;                                                          \
+        do {                                                                  \
+            i -= sizeof(TYPE), out <<= sizeof(TYPE);                          \
+            TYPE nn = *(TYPE *)(vn + H(i));                                   \
+            out = (out & ~1ull) | DEFAULT_VAL;                                \
+            out |= NAME##_inner_loop(nn, vm + (i & -16));                     \
+        } while (i & 63);                                                     \
+        pg = *(uint64_t *)(vg + (i >> 3)) & MASK;                             \
+        out &= pg;                                                            \
+        *(uint64_t *)(vd + (i >> 3)) = out;                                   \
+        flags = iter_predtest_bwd(out, pg, flags);                            \
+    } while (i > 0);                                                          \
+    return 0;                                                                 \
+}
+
+#define DO_PPZZ_CHAR_MATCH_B(NAME, TYPE, OP, DEFAULT_VAL) \
+    DO_PPZZ_CHAR_MATCH(NAME, TYPE, OP, H1, 0xffffffffffffffffull, DEFAULT_VAL)
+#define DO_PPZZ_CHAR_MATCH_H(NAME, TYPE, OP, DEFAULT_VAL) \
+    DO_PPZZ_CHAR_MATCH(NAME, TYPE, OP, H1_2, 0x5555555555555555ull, DEFAULT_VAL)
+
+DO_PPZZ_CHAR_MATCH_B(sve2_match_ppzz_b, uint8_t, ==, 0)
+DO_PPZZ_CHAR_MATCH_H(sve2_match_ppzz_h, uint16_t, ==, 0)
+
+DO_PPZZ_CHAR_MATCH_B(sve2_nmatch_ppzz_b, uint8_t, !=, 1)
+DO_PPZZ_CHAR_MATCH_H(sve2_nmatch_ppzz_h, uint16_t, !=, 1)
+
+#undef DO_PPZZ_CHAR_MATCH
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 07a2040208..29c799501d 100644
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
+#define DO_SVE2_PPZZ_CHAR_MATCH(NAME, name)                                 \
+static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
+{                                                                           \
+    static gen_helper_gvec_flags_4 * const fns[4] = {                       \
+        gen_helper_sve2_##name##_ppzz_b, gen_helper_sve2_##name##_ppzz_h,   \
+        NULL,                            NULL                               \
+    };                                                                      \
+    return do_sve2_ppzz_flags(s, a, fns[a->esz]);                           \
+}
+
+DO_SVE2_PPZZ_CHAR_MATCH(MATCH, match)
+DO_SVE2_PPZZ_CHAR_MATCH(NMATCH, nmatch)
+
 static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.17.1


