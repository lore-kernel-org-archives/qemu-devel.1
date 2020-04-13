Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F965C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 01:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D788F206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 01:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jkFUZz9c";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="DlJRNJIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D788F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOAfs-0003TE-2f
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 21:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jO8j4-0004Qu-49
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 19:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jO8j1-0002HW-FO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 19:42:48 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:5754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jO8j1-0002HE-0i; Mon, 13 Apr 2020 19:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1586821367; x=1618357367;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=zoAQle0OQNxd8a9btzyc7t7iEJafwg/QH5hhL10ocQg=;
 b=jkFUZz9cgtIO9VmS7UP6V0JkKGnyGJ6GrDL+Au4VgNsJIBZQoeXEOQlz
 ECmno49GhVxB2WUIYsFLrqHRROTOjTiVaRNul736soja/Ae0QUmQ9Ki93
 vzPPmcdfO6/XUBUIC+iygaib5FU/Y4bZfRPk46O0W2t4WAuB9m39wIamB s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Apr 2020 16:42:44 -0700
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 13 Apr 2020 16:42:44 -0700
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Apr 2020 16:42:43 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Apr 2020 16:42:40 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 13 Apr 2020 16:42:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfhbbTEjbh6oUbWR5kqebra3WhPWQ677VOz1V8+b9poN5Uzs+YG7mZ7regLuiu5m/TKmxaPYV4k9p+9ZXBchCrcLhf9m//2n9BnUub8kwZSgTvuT32LkMBd089lmwx+q/uyOezvwiGMC5drPJOn21BDsiC2o1C1w9fbIstBT2yB2VH8KDTS6aalQ6ykr39kirqRTiefshSJXi/vPhrINCYITkZ5C9EudAnRAgoekuxa07yGAE7fGBLjJQy0jei/0nz3d9l/F5NMHA95wJDpmG3pOxAvJ5BAOsNHPUgUih5M+GHtSW1H9REzRfV4XXNUuInMBqsJ1D2PeyEJOpOc62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AujULiLCuy1Y4FFraRpaCnyofTOmUPXKml1UznKfbhU=;
 b=LYkQHhKCFCS0Tr9C8Qpz/0NyEHzJ6JzWdpIDB2rgrrzyeF/385ofJM04lPHvJKsXJzC8tGhaOGx2AZxxU0jSIPuIuOw8quTmpsYbJZiy6QvOS1bzo4l6QsbcxHWG7jlRnI+vN3bdM+o8y9o/wLjdJORd+Ba4GsgjpOzQJOsLWkOtyB6PelwLaB47WN2mg00T6MH2PnT727MdyvhF6vQWYq8WdTW2BjsYxgYS6os2cXAniPXBoBqGLhaWhUrsDhaEZGFOtgLj8LfmMtZFGIX76D/SRmiLzR3YbZ/HvHJw5UVAxk7ugpGcaY0yovQSKRNVV0coaCKMunKmXuT6067cvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AujULiLCuy1Y4FFraRpaCnyofTOmUPXKml1UznKfbhU=;
 b=DlJRNJIteNKUZjgpXhZFMlCbGur00b3hncaaO8hbDp4pP6Wac04faVKhnnNSFcoQ2g/xlGRxM3TTPmEecIZA5vF/aRRDVxljIZZgGBujWfy96Dtdd66bWCkBqdFLsdhIcude7ojgiqlG+Piwd4Vg8Nrq1SxyhcJOpnS/2Vt4IRQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3401.namprd02.prod.outlook.com
 (2603:10b6:301:76::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Mon, 13 Apr
 2020 23:42:37 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 23:42:37 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC] target/arm: Implement SVE2 MATCH, NMATCH
Date: Mon, 13 Apr 2020 19:42:24 -0400
Message-ID: <20200413234224.12005-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0059.prod.exchangelabs.com
 (2603:10b6:208:25::36) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 BL0PR0102CA0059.prod.exchangelabs.com (2603:10b6:208:25::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 23:42:37 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd90d01-9b4d-4aab-fab0-08d7e004592e
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3401:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34013B081055C318FA4FE4E0C7DD0@MWHPR0201MB3401.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39860400002)(66476007)(478600001)(2616005)(66556008)(8676002)(966005)(66946007)(8936002)(81156014)(956004)(5660300002)(6666004)(1076003)(6506007)(4326008)(6512007)(316002)(2906002)(26005)(186003)(86362001)(6916009)(16526019)(52116002)(36756003)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3il58ynNJEM01poONz1KQrd8513WnJwSZr3C9IuhDyVrOXl345bJA2jUYQNqqTJshvDXcAj7Qe5n8jrAxB1GZh5yzUqrQz3dHqYbPi3Y6AmZmiqZ2aPWsVLPyXtAa1p9ZYXbwjT0L6qop0phtYtyvXUZzRpzWjjlUxcHx7Kzmm8GuKYhjBhbl0f2ETh0c+4oaekpkYpSdhjUiavO3odUjs2fAihyhRVDbTJq9EsaCOyBKmBaE5tICAjVj9VUhm/9pAOB4fz2UT4dtzLWxKbLM0g6sTPxmTu9pk4/RtQ3AEculnrZE3bKMPXjbI9P8jwV5tvSHvvdm2uc6swy7hwnsRgR7KhFWs5xUVoRFh7k2vlf85ZsSceAu2cpcYeZd6Td3uJFIVgWNZV+TJPbPvi+J2CmYETfRFlIqqi15rwf9svnWs3gTfaDLc1YPZLBjHAnV8NR6Tniwe08rln3Q7U8iA9MtoC/VJCys1yXBOA5H4tMUyZZpFoxliZGN0nTzU2TXve/VgRLar+n7+hZyPPUEQ==
X-MS-Exchange-AntiSpam-MessageData: F1YULWYBO4ANlKul/kLtlqyAk++GJeZ9y4J9hmVue28ut0rrPvtvENFnMshXzBU3lAY/MXBiVUzoE00fGxyrrTtEA7q981yik4njVaDWqW0WdipchVBph4lziK5gxxPhHDSsvxbpQ6cexfbhRJJFoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd90d01-9b4d-4aab-fab0-08d7e004592e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 23:42:37.8835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UmOOoB2j/oCnE5dpWRKVfcH3o8KgwoOluyJBrPRamrsc+1RecSBfEt9jElUozr79bnJKlo3Jv2hW7J6cDGt+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3401
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
X-Mailman-Approved-At: Mon, 13 Apr 2020 21:41:11 -0400
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
Cc: apazos@quicinc.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
Submitting this for early review. I'm working with Richard on SVE2 support for
qemu. I'll be attempting to tackle the insns in the 'SVE2 integer add/subtract
narrow high part' category next [1].

[1] ISA manual: https://static.docs.arm.com/ddi0602/d/ISA_A64_xml_futureA-2019-12_OPT.pdf (page 2950)

 target/arm/helper-sve.h    | 10 +++++++++
 target/arm/sve.decode      |  5 +++++
 target/arm/sve_helper.c    | 29 +++++++++++++++++++++++++
 target/arm/translate-sve.c | 43 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 5dd880cf6d..2077df9a95 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2516,6 +2516,16 @@ DEF_HELPER_FLAGS_3(sve2_uqrshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_match_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_match_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_nmatch_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_nmatch_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
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
index b68f62cd7f..c75258b56d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6890,3 +6890,32 @@ DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
+
+#define DO_ZPZZ_CHAR_MATCH(NAME, TYPE, H, EQUALS)                            \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)     \
+{                                                                            \
+    intptr_t i, opr_sz = simd_oprsz(desc);                                   \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {                             \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                      \
+        uint16_t *pd = (uint16_t *)(vd + H1_2(i >> 3));                      \
+        *pd = (*pd & ~1) | ((0 & EQUALS) | (1 & !EQUALS));                   \
+        if (pg & 1) {                                                        \
+            TYPE nn = *(TYPE *)(vn + H(i));                                  \
+            for (intptr_t j = 0; j < 16; j += sizeof(TYPE)) {                \
+                TYPE mm = *(TYPE *)(vm + H(i * 16 + j));                     \
+                bool eq = nn == mm;                                          \
+                if ((eq && EQUALS) || (!eq && !EQUALS)) {                    \
+                    *pd = (*pd & ~1) | ((1 & EQUALS) | (0 & !EQUALS));       \
+                }                                                            \
+            }                                                                \
+        }                                                                    \
+    }                                                                        \
+}
+
+DO_ZPZZ_CHAR_MATCH(sve2_match_zpzz_b, uint8_t, H1, true)
+DO_ZPZZ_CHAR_MATCH(sve2_match_zpzz_h, uint16_t, H1_2, true)
+
+DO_ZPZZ_CHAR_MATCH(sve2_nmatch_zpzz_b, uint8_t, H1, false)
+DO_ZPZZ_CHAR_MATCH(sve2_nmatch_zpzz_h, uint16_t, H1_2, false)
+
+#undef DO_ZPZZ_CHAR_MATCH
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 07a2040208..7175148bfd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7246,6 +7246,49 @@ static bool trans_UQRSHRNT(DisasContext *s, arg_rri_esz *a)
     return do_sve2_shr_narrow(s, a, ops);
 }
 
+static bool do_sve2_zpzz_char_match(DisasContext *s, arg_rprr_esz *a,
+                                    gen_helper_gvec_4 *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (fn == NULL) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        unsigned psz = pred_full_reg_size(s);
+        int dofs = pred_full_reg_offset(s, a->rd);
+        int nofs = vec_full_reg_offset(s, a->rn);
+        int mofs = vec_full_reg_offset(s, a->rm);
+        int gofs = pred_full_reg_offset(s, a->pg);
+
+        /* Save a copy if the destination overwrites the guarding predicate */
+        int tofs = gofs;
+        if (a->rd == a->pg) {
+            tofs = offsetof(CPUARMState, vfp.preg_tmp);
+            tcg_gen_gvec_mov(0, tofs, gofs, psz, psz);
+        }
+
+        tcg_gen_gvec_4_ool(dofs, nofs, mofs, gofs, vsz, vsz, 0, fn);
+        do_predtest(s, dofs, tofs, psz / 8);
+    }
+    return true;
+}
+
+#define DO_SVE2_ZPZZ_CHAR_MATCH(NAME, name)                                 \
+static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
+{                                                                           \
+    static gen_helper_gvec_4 * const fns[4] = {                             \
+        gen_helper_sve2_##name##_zpzz_b, gen_helper_sve2_##name##_zpzz_h,   \
+        NULL,                           NULL                                \
+    };                                                                      \
+    return do_sve2_zpzz_char_match(s, a, fns[a->esz]);                      \
+}
+
+DO_SVE2_ZPZZ_CHAR_MATCH(MATCH, match)
+DO_SVE2_ZPZZ_CHAR_MATCH(NMATCH, nmatch)
+
 static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.17.1


