Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F0CC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6BA20706
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cWqN7xaX";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="dauBTZt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6BA20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIgf-0005Vd-9h
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRIen-0003PK-Eb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRIeh-0000JL-4D
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:55:26 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:50402)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jRIeg-00007B-Bz; Wed, 22 Apr 2020 12:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587574522; x=1619110522;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ut7E/+Apr+4O1H29rXxmLWcsDJSPjBLaRSsEyMwfL34=;
 b=cWqN7xaXvKJrzviK6nbclUMIJxxL/Ohi6PLePT0RsNxjsbHNGF0wUk/h
 Zb0QnxIVrY9yJXLSj83gxfzmVenATwSEBXG0eleZE32DHS53cL8318//S
 R3sMGLLSd9ZVU8v0lWJR4MhHCax4DsxaVPQ6SZPTI5Afj2N1iV9BytJSj U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2020 09:55:20 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 22 Apr 2020 09:55:20 -0700
Received: from eusanexr01b.eu.qualcomm.com (10.85.0.99) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Apr 2020 09:55:19 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 eusanexr01b.eu.qualcomm.com (10.85.0.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Apr 2020 09:55:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 09:55:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+bc9VMabnqdcxSTl4iEGIhC1cnEHhYxAu8k5x+QaZLVTBCpJMxSwir2oczHpQukn/R+46A6MeYaQc4qQHJ/s3LvH93ogiAp2rnBnz/LgcbEv+aFFen5/9QAX03nGgYWXTohZKx/ZjSZPr8OWLDh3WWWuIzoP/1JFwseHxQVADcjKdRK2qpe41jVA8s/qYRy/+770kBB4Dyq/U7LxSP1QXE54mHETo2LD00s35RMLJUkVhaffgqUEoXgSr8pkjDEe2wvatlEC/b4wsKRwl9n0xAUymUpTp8nq7vELXij44Hpu5ixotm6ZxeX9aO2FFpO/XpAP6fMyoZbircFVkGZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px31Y6TUbbGgj1gwTVs1Vphp3QTG3/X5Bjglj+PxVcA=;
 b=gLfawPH3kJ4kshgBLp07OclxgFAnCkLSfh89BwzHK05yX8pgFB6nOmpGX9/Zn8O3Y8ECuDBJDp/DcLj7uV23W1pp2m2MT9eC3G6xiIfS7do6tFmIp9pXTN7SPA16fEDTCDin7kCLEW3Crf4Mtn3tmTZkd+1yF3CeomSl5vfOKdhebQAPpzh7Kf1vtcnlXtCF18BE1t1B8u8sOutiFmdAjMRYOF2cr5GCB/7cx9j4s6TuSLziBu/9dQurM+CD/lvVCNbSEhtoONwL1BKnP8KX8XCk28wJyCOrlJ8KszIU+XGe+ZV8GzV7ERTlz+LlM+OdZy22V7yuxKyINxkmlRW4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px31Y6TUbbGgj1gwTVs1Vphp3QTG3/X5Bjglj+PxVcA=;
 b=dauBTZt3kYp/cmfb70Nez1tsSnk/hPxPrfk7doP4SY/fCMYU/wWsKgw9Fv096AfhDtznVWF9dvVfyKKyIAzrQZd91o95FpORvqU7ZSE3xhf6aChYXUDSUAXtXTbf+5/toccyeWlbEyWM4xEKLNmS7nZfxlZbBREVtq7E/NeW9Ws=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3401.namprd02.prod.outlook.com
 (2603:10b6:301:76::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 16:55:16 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 16:55:16 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3] target/arm: Implement SVE2 FMMLA
Date: Wed, 22 Apr 2020 12:55:03 -0400
Message-ID: <20200422165503.13511-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:610:38::15) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:610:38::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.7 via Frontend Transport; Wed, 22 Apr 2020 16:55:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 299b0f50-5797-4ba8-0f30-08d7e6ddee9c
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34016470AF8524394BB02F40C7D20@MWHPR0201MB3401.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(376002)(366004)(136003)(39860400002)(346002)(396003)(316002)(66556008)(186003)(478600001)(6506007)(6916009)(81156014)(2906002)(86362001)(6666004)(4326008)(6486002)(956004)(8676002)(1076003)(26005)(8936002)(66946007)(5660300002)(16526019)(36756003)(66476007)(2616005)(52116002)(107886003)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QN2s8hD3bE7dmws4CnxL02aURs3ldeuDK9H2e6AYK+4XB4GtqDZ5b5y0DxbH75liEtH0Zcqwk7z8pfKHSUzERZqAaKQ16i6gli/dsiIOrDrKjypvlNaWv6a/JMGagvqlV9Hs7q5r5jl/fK64/JKUXJvD1iraqEgroTnJHdI37z3uUz9jab4ZYcM94DwbJTBaxpWB7bJ0HXQl47rRdyx+q5GXBr/Qxr8nBSdNwcrsfaSslu9d6yPDq9k2xyJoGFJhIJkV9T0+UWcb7YvSFRZF3+Y4U8/0i4mhGyjhzB6JFHUTcdApUCYuboNn5a+ZqceFuJoq+vnaK2eKRLh2VO1EKkBV8lD3E1p0MUyxBewgpAx+xPZkEkB4Ov6WfKpx1+1AMv7KOK40I9yOfcikuj/fUzjKinhlfw/Rot+1Cip6B0+AouBACvzbkxxMmtb4LRgI
X-MS-Exchange-AntiSpam-MessageData: oYut3zY3ctd/hpoSGrCcZjYiR2S/C2JsThctvWTwAgJKTbwIKWtjqWoyBt8ILiV6KhWLVy7YBVi4UPxxP7usB8ugWdVBNWuFDm9EKrX3w9oquRaQkZt6hSjDgcz7Ww2DV8XN9qu7stnjjLFo4TrNKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 299b0f50-5797-4ba8-0f30-08d7e6ddee9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 16:55:16.4818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGfuYKvaeZvNNIJt5RByBUViZpNaayfo/nOccdODgc9lSX4orasFHa5aUuHAZ9f68l++/AKTgps0DrgYkEpnUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3401
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 10:15:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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

Fixed the errors Richard pointed out.
---
 target/arm/cpu.h           | 10 +++++++++
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve.decode      |  4 ++++
 target/arm/sve_helper.c    | 42 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 ++++++++++++++++++++++++++
 5 files changed, 88 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b7c7946771..d41c4a08c0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3870,6 +3870,16 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_f32mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_f64mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ea53750141..8104d23c5f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2683,3 +2683,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 95c73c665a..dd987da648 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1383,3 +1383,7 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
+
+### SVE2 floating point matrix multiply accumulate
+
+FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b392a87aef..9c6709d6df 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7389,3 +7389,45 @@ void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
         *(uint64_t *)(vd + i + 8) = out1;
     }
 }
+
+#define DO_FP_MATRIX_MUL(NAME, TYPE, MUL, ADD, H)                           \
+void HELPER(NAME)(void *vd, void *va, void *vn, void *vm,                   \
+                     void *status, uint32_t desc)                           \
+{                                                                           \
+    intptr_t s;                                                             \
+    intptr_t opr_sz = simd_oprsz(desc) / (sizeof(TYPE) >> 2);               \
+                                                                            \
+    for (s = 0; s < opr_sz; ++s) {                                          \
+        TYPE *n = vn + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *m = vm + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *a = va + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *d = vd + s * (sizeof(TYPE) >> 2);                             \
+                                                                            \
+        TYPE n00 = n[H(0)], n01 = n[H(1)], n10 = n[H(2)], n11 = n[H(3)];    \
+        TYPE m00 = m[H(0)], m01 = m[H(1)], m10 = m[H(2)], m11 = m[H(3)];    \
+        TYPE p0, p1;                                                        \
+                                                                            \
+        /* i = 0, j = 0 */                                                  \
+        p0 = MUL(n00, m00, status);                                         \
+        p1 = MUL(n01, m01, status);                                         \
+        d[H(0)] = ADD(a[H(0)], ADD(p0, p1, status), status);                \
+                                                                            \
+        /* i = 0, j = 1 */                                                  \
+        p0 = MUL(n00, m10, status);                                         \
+        p1 = MUL(n01, m11, status);                                         \
+        d[H(1)] = ADD(a[H(1)], ADD(p0, p1, status), status);                \
+                                                                            \
+        /* i = 1, j = 0 */                                                  \
+        p0 = MUL(n10, m00, status);                                         \
+        p1 = MUL(n11, m01, status);                                         \
+        d[H(2)] = ADD(a[H(2)], ADD(p0, p1, status), status);                \
+                                                                            \
+        /* i = 1, j = 1 */                                                  \
+        p0 = MUL(n10, m10, status);                                         \
+        p1 = MUL(n11, m11, status);                                         \
+        d[H(3)] = ADD(a[H(3)], ADD(p0, p1, status), status);                \
+    }                                                                       \
+}
+
+DO_FP_MATRIX_MUL(fmmla_s, float32, float32_mul, float32_add, H4)
+DO_FP_MATRIX_MUL(fmmla_d, float64, float64_mul, float64_add,   )
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0cbb35c691..29532424c1 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7615,6 +7615,35 @@ static bool do_sve2_zzzz_fn(DisasContext *s, int rd, int rn, int rm, int ra,
     return true;
 }
 
+static bool trans_FMMLA(DisasContext *s, arg_rrrr_esz *a)
+{
+    if (a->esz < MO_32) {
+        return false;
+    }
+
+    if (a->esz == MO_32 && !dc_isar_feature(aa64_sve2_f32mm, s)) {
+        return false;
+    }
+
+    if (a->esz == MO_64 && !dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+
+    static gen_helper_gvec_4_ptr * const fns[2] = {
+        gen_helper_fmmla_s, gen_helper_fmmla_d
+    };
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->ra),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           status, vsz, vsz, 0, fns[a->esz - 2]);
+    }
+    return true;
+}
+
 static bool do_sqdmlal_zzzw(DisasContext *s, arg_rrrr_esz *a,
                             bool sel1, bool sel2)
 {
-- 
2.17.1


