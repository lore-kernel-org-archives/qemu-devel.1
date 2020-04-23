Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C58C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902882075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jz7BGEJ/";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="CkeORcAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902882075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfA0-00022G-Bt
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRf87-0006IM-J1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRewE-0001TA-V1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:42:59 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:14249)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jRewD-0001SG-9O; Thu, 23 Apr 2020 12:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587660177; x=1619196177;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=T+vqVb3zLlbr33a3oYvLpeKTS0OODAPwUPHTwMx4zi0=;
 b=jz7BGEJ/02sgXB+ulvjzZK4UMvU2sYpVUxUe35+x71L+MIFUoEfsgkzx
 lOql6T2mawzzj4DnXOyTWclPiWrAZJlZY6d71onRQpviXv1wRVRLn7K/y
 Eb/ve+K4++okk/raukjxeKoT9e1h3bmYQV3pOibirXdGfe9wHmEKc3aFL g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Apr 2020 09:42:53 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 23 Apr 2020 09:42:53 -0700
Received: from NASANEXM01G.na.qualcomm.com (10.85.0.33) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 09:42:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 23 Apr 2020 09:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEXWwkPKsqj4pR7uIYWFG0Dr9l38gBmrKO+dFgsNnlGRnEdmjvMZ/uSPia25RQfbRVYwZRYeioXKxBp4p6bhj9choOSjkcz1zAyWwbp22a2QVIMj64xrUIcV0n4eHFA5LLdGKy1JbdEd+soGHuE6B9CErdqd4/fw7HzfTMvoqDQmNiJQ1Cg2RdywmKKlTOnc/XyuanMj5nQzr+Fczjr1JG1BzS3FWR7iqVMGEHm7XLneNXp+GKm1OA1cAC7Yq48jJL6FiidaikArvdY8eShaVWnwoB60+DPVKOU0rU6JBSeDcRuNKmDc4FBcOxTM7emglJG8rQobthRLmZnnQ7oQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEOx+s2kHA56yX71GmvALRykCSFuIehAPBxeG9g46TM=;
 b=J1OOW5C0IfCxXbdinRq1Ivi4W3FkCyqlDeWAuPelv386gLsy6QkFGBpZVThT0TzlzxIo28N3lRiqTL8PRbru83wMi1J/LT+8NAgRQDFpbzqRBII2TWOLLGlUmnvS5NkrCpiKTtlMdIp5+Z2uaCG1OU3fYFen4fKg1cF35/pqMO3c8g3UopLhzC/QRFC76kka7aoVYju3P9ahRdaCVKzEgLnOMPoQG4vDk6S0WTnLhuOiEG9sQsGjR1wRIlMubZ36PUPvgp+uaUyqIziv4OqyA/TGoXgW8subLdZNzXVc/FkMZDtl2uTdKNBoiVwRaLD0pE1rzg+Radpp5CG0JKI9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEOx+s2kHA56yX71GmvALRykCSFuIehAPBxeG9g46TM=;
 b=CkeORcAh21DNpaIKGj0Ji/ik/9mqdOfwdRPUsKuA83w/xxdAGGyA2AeJPFfty9EXyO/ujHu4+9LhrCJl9HlCdWL8UPFfCPGJZE5ZD4joexO+2ZL+UkM3o4jMhtPFHHQpwCpB/lleJsiGvZC/pbQfw5mc9P2Wx7aMLqtx+1N1WKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3578.namprd02.prod.outlook.com
 (2603:10b6:301:77::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 16:42:52 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.033; Thu, 23 Apr 2020
 16:42:52 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC] target/arm: Implement SVE2 TBL, TBX
Date: Thu, 23 Apr 2020 12:42:36 -0400
Message-ID: <20200423164236.5181-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR14CA0037.namprd14.prod.outlook.com (2603:10b6:610:56::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 16:42:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1155541-214f-457c-f83e-08d7e7a55d61
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3578E1FC7A4CBB7F0ABF9F8FC7D30@MWHPR0201MB3578.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(136003)(39860400002)(366004)(346002)(376002)(6506007)(16526019)(5660300002)(8936002)(66556008)(66476007)(478600001)(1076003)(2616005)(8676002)(81156014)(86362001)(107886003)(66946007)(6916009)(316002)(26005)(6486002)(52116002)(6666004)(186003)(6512007)(956004)(4326008)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQv+yKzZJ4fCggFffbff+0fsep1WHjLFIsF/ZjKllmK+YHCB2L9pydWiyVJANW7QQyGrdcuJV+ZqC1hetlfLWW/iASJTDs/Cn2MzoN6pf1/HbVlygTvaHMJk+oYwUYCRf4GLWYmLdbI6c/apTEGeC0DEYg0BQzbQQyXUMtPAchGqVQqVVpBefY9I7mmzPZb3WPXCLxtrlEVKgVtwGvTp7zcuTA0jvRTXqDlFEmh+3Tbm8messKqVAdorRJfyIKHPQZU1BwyqRq6dSrokxOJCJkIWOZ5avXDhn/EhJNVrKn+YKZ7cCEiO/VJ1CXfKr0rtu2YsSc4nIssm1xX+vWhPaS98lJT61DG7xoJjJO6qeTAbO+4d0JGoEN4H+ipZu6JX74WTBgizvGqUozUbpPmYX6bgXNsQsBfcSC7UbSZWnWupWvjdWDd2j4ome1jxVf4Q
X-MS-Exchange-AntiSpam-MessageData: OpDuTqnDAvLtfrkZ/6Bz1metOCC6L8KR6nl/ar9sSQxmfFG8mJ0t+R8yg4GBiAzxM7AzW/pPYNYVhxMbbW9TS47NtpYies/aTGdVheQqfagIvPw0j38mztNeFDNUhgRaag9Srbr09FAp3hLZlLUvsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1155541-214f-457c-f83e-08d7e7a55d61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 16:42:52.0685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ahsqVE4xuwM4oPQKm6cV5PWVMZ+dkl4mwpCm54QjhT0zOuT7xuqtqvtbGL6mS1Nx5vaysPnvCFgW2EjGlIoDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3578
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 12:42:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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

These insns don't show up under any SVE2 categories in the manual. But
if you lookup each insn, you'll find they have SVE2 variants.
---
 target/arm/helper-sve.h    | 10 +++++++
 target/arm/sve.decode      |  5 ++++
 target/arm/sve_helper.c    | 53 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 20 ++++++++++++++
 4 files changed, 88 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index f6ae814021..54d20575e8 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2687,3 +2687,13 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_tbl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_tbx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3a2a4a7f1c..483fbf0dcc 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1387,3 +1387,8 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
+
+### SVE2 Table Lookup (three sources)
+
+TBL_zzz         00000101 .. 1 ..... 00101 0 ..... .....  @rd_rn_rm
+TBX_zzz         00000101 .. 1 ..... 00101 1 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 55e2c32f03..d1e91da02a 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2968,6 +2968,59 @@ DO_TBL(sve_tbl_d, uint64_t, )
 
 #undef TBL
 
+#define DO_SVE2_TBL(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn1, void *vm, void *vn2, uint32_t desc)  \
+{                                                                           \
+    intptr_t i, opr_sz = simd_oprsz(desc);                                  \
+    uintptr_t elem = opr_sz / sizeof(TYPE);                                 \
+    TYPE *d = vd, *n1 = vn1, *n2 = vn2, *m = vm;                            \
+    ARMVectorReg tmp1, tmp2;                                                \
+    if (unlikely(vd == vn1)) {                                              \
+        n1 = memcpy(&tmp1, vn1, opr_sz);                                    \
+    }                                                                       \
+    if (unlikely(vd == vn2)) {                                              \
+        n2 = memcpy(&tmp2, vn2, opr_sz);                                    \
+    }                                                                       \
+    for (i = 0; i < elem; i++) {                                            \
+        TYPE j = m[H(i)];                                                   \
+        d[H(i)] = j < (elem * 2) ? n1[H(j)] : 0;                            \
+                                                                            \
+        TYPE k = m[H(elem + i)];                                            \
+        d[H(elem + i)] = k < (elem * 2) ? n2[H(k)] : 0;                     \
+    }                                                                       \
+}
+
+DO_SVE2_TBL(sve2_tbl_b, uint8_t, H1)
+DO_SVE2_TBL(sve2_tbl_h, uint16_t, H2)
+DO_SVE2_TBL(sve2_tbl_s, uint32_t, H4)
+DO_SVE2_TBL(sve2_tbl_d, uint64_t, )
+
+#define DO_SVE2_TBX(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    uintptr_t elem = opr_sz / sizeof(TYPE);                     \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+    ARMVectorReg tmp;                                           \
+    if (unlikely(vd == vn)) {                                   \
+        n = memcpy(&tmp, vn, opr_sz);                           \
+    }                                                           \
+    for (i = 0; i < elem; i++) {                                \
+        TYPE j = m[H(i)];                                       \
+        if (j < elem) {                                         \
+            d[H(i)] = n[H(j)];                                  \
+        }                                                       \
+    }                                                           \
+}
+
+DO_SVE2_TBX(sve2_tbx_b, uint8_t, H1)
+DO_SVE2_TBX(sve2_tbx_h, uint16_t, H2)
+DO_SVE2_TBX(sve2_tbx_s, uint32_t, H4)
+DO_SVE2_TBX(sve2_tbx_d, uint64_t, )
+
+#undef DO_SVE2_TBX
+#undef DO_SVE2_TBL
+
 #define DO_UNPK(NAME, TYPED, TYPES, HD, HS) \
 void HELPER(NAME)(void *vd, void *vn, uint32_t desc)           \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 20eb588cb3..c2694d92dd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7882,3 +7882,23 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
     };
     return do_sve2_zzzz_fn(s, a->rd, a->rn, a->rm, a->ra, fns[a->esz], a->rot);
 }
+
+static bool trans_TBL_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_4 * const fns[] = {
+        gen_helper_sve2_tbl_b, gen_helper_sve2_tbl_h,
+        gen_helper_sve2_tbl_s, gen_helper_sve2_tbl_d,
+    };
+    int rn1 = a->rn;
+    int rn2 = (a->rn + 1) % 32;
+    return do_sve2_zzzz_fn(s, a->rd, rn1, a->rm, rn2, fns[a->esz], 0);
+}
+
+static bool trans_TBX_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[] = {
+        gen_helper_sve2_tbx_b, gen_helper_sve2_tbx_h,
+        gen_helper_sve2_tbx_s, gen_helper_sve2_tbx_d,
+    };
+    return do_sve2_zzz_ool(s, a, fns[a->esz]);
+}
-- 
2.17.1


