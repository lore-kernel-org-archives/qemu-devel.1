Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB62C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C9A2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NIfEPfKY";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="o0E/JVeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C9A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTn1-0003YQ-B6
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 12:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jPTlc-00023v-1f
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jPTla-0007hj-5w
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:22:59 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:65335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jPTlZ-0007gr-Sv; Fri, 17 Apr 2020 12:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587140577; x=1618676577;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=In/sUItQxKfs+UcnkF80DxAYvHJRSh5bMyQ1Ffm4UqU=;
 b=NIfEPfKYxeOrprpQWEcW20Vt5Tk7rArI418ZxR016r3QAS3ucqSHsF3N
 0z1ejU59+cTOobeeBlawztXYmrQkbpEtXCsaOUNI7zU/IO7hA2GjDz+Os
 ejjNUpM0mkCb/P+XuUDDivMci0MvlCQsxRCnhVosFI/K0sKHa6yunPB1e A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Apr 2020 09:22:55 -0700
Received: from nasanexm03f.na.qualcomm.com ([10.85.0.47])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 17 Apr 2020 09:22:55 -0700
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 09:22:54 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 09:22:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 17 Apr 2020 09:22:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EboE1FPJvID7BBjGz7HVQXILJ3ydwzK7EVDegwupPQb42M2/ATiREN3rxYEbj3LtVwaRGSNuWmUUgyiTGJdTaHevjHB2c3n7G7goTy9WkhWMSPruzp25Zo+XqmS3eSgN3fsyBUeK3AabcMazJ+L5QCwidcTrzJAotC4d8ZlzcHmCfit4qlJiK0xl2TQXvLpcQKcQi5u6fSLIEezfiMk0qgZ298KaTQMXIC13Ku/luiC9IhhiE8KZdsJ2DKro86wAIrY6s+5Q8Y8AyPr0TOPgBUIWUOUcexv6s6ilgoA848DlH/ZUsA3V4BfWlMFY5uECvs+VCykJlPjIFZiewW+1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lebn2h77f1WG5tY6olTfi/TbDNxf0oln09ELIOCl4w=;
 b=hyTWcagY7SjxcqUOjkWzusw5U0HN0sfbxWuTjWqQDK2EfBH6k9KR8yaTnbMp/pRpIzMcJmcpYV947vsLsxcP4OC6cuhXoIelp0lL/YWw697DzQW5DlyGAG6IxQHBEN54xy++LIXHigRr0NR0JNfCCyOsvgmvFVj9AxlxvRBeQN0ChoP0QkzEPJxX31dprm3ZDezvdlm10RpFfW+t1bXW/0PnIBZCYvR5vOQ+CynaLSfGO4LZp92Se1sSucd9ALaGMZWnvyRe2dIdRNzcJjSGrC/9ajR2tsSVrwbwubNVs0/TJLv5kwZ7PivX0r1doy8OZlrEt5+dy5l5mC+IpUceew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lebn2h77f1WG5tY6olTfi/TbDNxf0oln09ELIOCl4w=;
 b=o0E/JVeFkH9BOHQtpEAL0OE3o1Y61rTYW5hK1d4p+6Equn6r0VMs+HN3P5ph0BInjtp14Mm1bqrYmwFjkRLQtOJokaCRENfzTu1eDjGspEcLaVnZ+fYWNXg9u1hB2h9qytB3zEjl7700ebpMgpf3H7bEWCxVz6vsHYSxNA1lCdY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 16:22:48 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.030; Fri, 17 Apr 2020
 16:22:48 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/4] target/arm: Implement SVE2 ADDHNB, ADDHNT
Date: Fri, 17 Apr 2020 12:22:28 -0400
Message-ID: <20200417162231.10374-2-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417162231.10374-1-steplong@quicinc.com>
References: <20200417162231.10374-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:610:57::27) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:610:57::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 16:22:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f117e1-a1d6-4817-9e73-08d7e2eb913f
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34844C93E2DB171379561BDEC7D90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(5660300002)(107886003)(4326008)(66946007)(66476007)(66556008)(6916009)(6486002)(478600001)(6512007)(6666004)(2906002)(36756003)(186003)(16526019)(86362001)(956004)(1076003)(2616005)(316002)(8676002)(26005)(6506007)(52116002)(81156014)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VD3kXcjKJreUKLLFPUOuav2PEMvA7xKN7aG44vt+CxYOF/H33QTaQWy6fj0w/zz0ylUJORqhqGMCW/DjKzuVjN5yD2+54SsL1touKfrVL8JmmWBO1BX0LWq03cdMOuChMCjjty9KwFmoY0O63OA7Ox9zF+DjKkH30sia865E0VaTLQzbYYsQEItIKQLRnHFL9c9q9hmlIoQx5gh7pc2ZT+QMJh0vfD6d+96DndtskA3ptjEqjiZgEQigOn/BOyPf3PZtmDkwVFDRVtXglqNqqNuG4LNYLh4wbhHqM4Bocw4DN+Tx4LLTMlyLUrRUKiw1v1wa4pkVqm7VLSi2/cZm8wUrdZg5Yr+Af2wlUilRumhSuSbbfG39sSvTYjiwVHu7K41KQ8KwTytvk17imXpNrxuK8sinAwIjl/fdJXgYEJPTvKv/ZlFBKkHXF5WoCYH
X-MS-Exchange-AntiSpam-MessageData: J7enQA7GHVOxueSqTQVH5XutW3r7Nju3fbwTY363wFWOXQJ3TSnG6fI58qirLbDgLXMLzX6gaWXOFlA32iHYWxhOfdY69avWvpBnHOnEfwC28/Unt3oKcjYe0CW9Ke2halSLw/oreZuLQUQgFmO0+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f117e1-a1d6-4817-9e73-08d7e2eb913f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:22:48.1050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUwrnHeb1c603qLHuzrI1R0mDaOtQLXvxyVc+/T6U0GyGnpSw8hHPG2wkV10bYIq/9Ewen0Ok4ylZ/34aJizgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
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
 target/arm/helper-sve.h    |  8 ++++++++
 target/arm/sve.decode      |  5 +++++
 target/arm/sve_helper.c    | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 13 +++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 958ad623f6..5b8a8b0656 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2516,6 +2516,14 @@ DEF_HELPER_FLAGS_3(sve2_uqrshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_uqrshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_addhnb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_addhnb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_addhnb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_addhnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_addhnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_addhnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve2_match_ppzz_b, TCG_CALL_NO_RWG,
                    i32, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_match_ppzz_h, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 9dd20eb6ec..e6a12f4e66 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1321,6 +1321,11 @@ UQSHRNT         01000101 .. 1 ..... 00 1101 ..... .....  @rd_rn_tszimm_shr
 UQRSHRNB        01000101 .. 1 ..... 00 1110 ..... .....  @rd_rn_tszimm_shr
 UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 
+## SVE2 integer add/subtract narrow high part
+
+ADDHNB          01000101 .. 1 ..... 011 000 ..... .....  @rd_rn_rm
+ADDHNT          01000101 .. 1 ..... 011 001 ..... .....  @rd_rn_rm
+
 ### SVE2 Character Match
 
 MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 65857e27b4..743240aa80 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2025,6 +2025,42 @@ DO_SHRNT(sve2_uqrshrnt_d, uint64_t, uint32_t,     , H1_4, DO_UQRSHRN_D)
 #undef DO_SHRNB
 #undef DO_SHRNT
 
+#define DO_BINOPNB(NAME, TYPEW, TYPEN, SHIFT, OP)                           \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)              \
+{                                                                           \
+    intptr_t i, opr_sz = simd_oprsz(desc);                                  \
+    for (i = 0; i < opr_sz; i += sizeof(TYPEW)) {                           \
+        TYPEW nn = *(TYPEW *)(vn + i);                                      \
+        TYPEW mm = *(TYPEW *)(vm + i);                                      \
+        *(TYPEW *)(vd + i) = (TYPEN)OP(nn, mm, SHIFT);                      \
+    }                                                                       \
+}
+
+#define DO_BINOPNT(NAME, TYPEW, TYPEN, SHIFT, HW, HN, OP)                   \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)              \
+{                                                                           \
+    intptr_t i, opr_sz = simd_oprsz(desc);                                  \
+    for (i = 0; i < opr_sz; i += sizeof(TYPEW)) {                           \
+        TYPEW nn = *(TYPEW *)(vn + HW(i));                                  \
+        TYPEW mm = *(TYPEW *)(vm + HW(i));                                  \
+        *(TYPEN *)(vd + HN(i + sizeof(TYPEN))) = OP(nn, mm, SHIFT);         \
+    }                                                                       \
+}
+
+#define DO_ADDHN(N, M, SH)  ((N + M) >> SH)
+
+DO_BINOPNB(sve2_addhnb_h, uint16_t, uint8_t, 8, DO_ADDHN)
+DO_BINOPNB(sve2_addhnb_s, uint32_t, uint16_t, 16, DO_ADDHN)
+DO_BINOPNB(sve2_addhnb_d, uint64_t, uint32_t, 32, DO_ADDHN)
+
+DO_BINOPNT(sve2_addhnt_h, uint16_t, uint8_t, 8, H1_2, H1, DO_ADDHN)
+DO_BINOPNT(sve2_addhnt_s, uint32_t, uint16_t, 16, H1_4, H1_2, DO_ADDHN)
+DO_BINOPNT(sve2_addhnt_d, uint64_t, uint32_t, 32,     , H1_4, DO_ADDHN)
+
+#undef DO_ADDHN
+
+#undef DO_BINOPNB
+
 /* Fully general four-operand expander, controlled by a predicate.
  */
 #define DO_ZPZZZ(NAME, TYPE, H, OP)                           \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 6c237343ef..0d1a9cd8a5 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7504,6 +7504,19 @@ static bool trans_UQRSHRNT(DisasContext *s, arg_rri_esz *a)
     return do_sve2_shr_narrow(s, a, ops);
 }
 
+#define DO_SVE2_ZZZ_NARROW(NAME, name)                                    \
+static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)                 \
+{                                                                         \
+    static gen_helper_gvec_3 * const fns[4] = {                           \
+        NULL,                       gen_helper_sve2_##name##_h,           \
+        gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d,           \
+    };                                                                    \
+    return do_sve2_zzz_ool(s, a, fns[a->esz]);                            \
+}
+
+DO_SVE2_ZZZ_NARROW(ADDHNB, addhnb)
+DO_SVE2_ZZZ_NARROW(ADDHNT, addhnt)
+
 static bool do_sve2_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
                                gen_helper_gvec_flags_4 *fn)
 {
-- 
2.17.1


