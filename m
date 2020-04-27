Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A0C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927B820656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EiixK3+l";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="bN6mNI/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927B820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5mk-0006WN-AG
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jT5hO-0007hj-Ts
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jT5hO-0004hR-DD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:29:34 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:49183)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jT5hK-0004QT-Ht; Mon, 27 Apr 2020 11:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588001370; x=1619537370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=/QGDZc6wsjQsb0uQJjfLNJH7SYwQ6LpmqAKWSATOt+I=;
 b=EiixK3+lnINzeJxDzllVoiN8MuKrnQHkQuDoF2IpbKkCWWXcm8MZDL50
 FQMdV1iH5lbKJ7BrDcB2VUULr8dwScuQCTbiRjANqcr9w+Hsbj+ea9TvY
 UATo4YThhyD865BYeD8TmhjbE1kZsKkfO7OVLV3f+ehEmHs894L1/KKcC M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2020 08:29:21 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 Apr 2020 08:29:21 -0700
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 08:29:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 08:29:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1cbQmTTpj78V67nxf65fNBaiygJ2tltxAFygDKKBTYGVFFNcEpjJWSRlnnu4ytBdG7fPpDwZZYFagr4dktyQ/avB8dTC5id81PF6My7KWBTL18NNIHHSXzwPlcIqYz8FQA5T0CclZd5kwKaEuSF5a1gJynBDY4n+oitJ5TvwdR0Db3877Gn3ARRmkZu65XDnFZAChPLSrOLdbA1JVKfRxfNYX3ZxfQ3KazclFs0avCtdwBdEeV8qLkNkgkuEyBtYq/uY13xFANqZIqkwTnQVYN3fl4poO2hRUOtA9Q95BuE3e+NXfYsxGRKEncEDuu6m55FnKkvXcriGYHTfxc5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIoMq+afIEvOn/f+ZqlnZzN9RP8yjwBZ+DGXhN/SQcA=;
 b=P3aquxz1Hq1y/YruW4X0S1F8HUM8oUYU9vfScwKLUBW3M8CqroLmz4LXpxg3I9HZXAFOkX+pWXGLcobLoTKYg421TgZXUCBeC/13ED+XIWSwqkzhxr2Opbo2KdIhiNnDxV4DQjRuc4opjy3/LMTnUFcEvw2bmLPtQkvspokLMB1LhW1UebxS3v8e5PVRBDtuw0pcIQJplR4ryL9ZRbV3+rMM8b3iWhuA6GFs4dImYUXwF3du7qfuMdIPHpkVOkgfSDa5oRnfOVVFl3oJfAsflS/ZLSfji6fm+nOe0XHhzVNiX7MWYbuzHLUeMpTU8qQO/SbvTF8Q5gAcVpoQt1E3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIoMq+afIEvOn/f+ZqlnZzN9RP8yjwBZ+DGXhN/SQcA=;
 b=bN6mNI/geb6pJLB780wafwitcpbZ8QBa1RntnVTP9KlK1gt3D5Db8gDlSQBXwM1MIN/oepQxElULMx4QeW5EQZRE31DKNRgU948tPvvobBz+8+DkvRLsBy+YyB9/l0BsbAMO5d0dtdvpN0Yoz6JDCrHeogQ3dsrDwv3RQPwsgPA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3465.namprd02.prod.outlook.com
 (2603:10b6:301:76::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 15:29:19 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 15:29:19 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2 1/3] target/arm: Implement SVE2 AESMC, AESIMC
Date: Mon, 27 Apr 2020 08:29:02 -0700
Message-ID: <20200427152904.14768-2-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427152904.14768-1-steplong@quicinc.com>
References: <20200427152904.14768-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:208:fc::38) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:208:fc::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 15:29:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e631edee-d868-40c4-4d06-08d7eabfc0c8
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34659EECD87199E5279E610DC7AF0@MWHPR0201MB3465.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(2906002)(6916009)(107886003)(6666004)(6506007)(66476007)(316002)(66946007)(26005)(8676002)(2616005)(52116002)(81156014)(4326008)(8936002)(6486002)(478600001)(956004)(5660300002)(186003)(1076003)(36756003)(16526019)(66556008)(86362001)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXco0f+fDg9D+3CT4kYujvOQWX1cj1TKlXdYW0aUI1TVqHK2aetZmElAab0HxR/w+gjm9DFzPbjDzSsRfa+bHjGkkYEaymbM0kN/62U0ixFlvvvbLTAzyr+A9JvLj99mxFk9IPg1TwzXwIJfZHxIA2tri4YDOutYX6xz4KeGw+YBlJbf43J/zprmEBZ4D0pmw51u8vTgo3Wra3HOKLVixAfDFkwqIOg37euumwq2EdGHVKyyw7YfN6Nku4sBj+fOUQxakXGv9hRipKefgHomPTObERwusb8+0R7kKKHTXmbfi6y9fWct6dwlvk7R+nYh/QiIxPXWCO/FZaDzOl4QWT0KNUG4+3IKYzoLet1ky11TlNpiV9DqrZCPjU6glvXjnvkByozuXO75W7WXk+RaA92Z2jKbBhlHUvMKM9FulJfZaunYL07MLXctDVFKXO66
X-MS-Exchange-AntiSpam-MessageData: wWuJWUkGalGnzpsrpyMMcft+z1y3aLxP1/Xdfie8h3UKI2ayZQ0PsY4+VieaeDaATFDKMOBxFyK/l6t67CroAl106Katbyj8+ckFmYRMsoRqZsgWc/Yrn/90XrVZ6OW6AiPukHxw48Yh31LEtXFAhS4JCXMgF5m5Drv7OLlIF2EuJDfss7LsK7ITgkOky3ChpzclKX4jBOx7VpTpDb+2n3f2WPYZEdbrSxo/oXyTxvGR4emY+jFgJUj7TJf0LQSAN4B56JlePvXFe8kniEf+3Y+EkgtOp28Ozj+EjcGIVX/PXCnGENL6NrRBQnao1wSxBftbbgRhv/TTsWOAEwSSqJLCgTnnw/5IuM2szuiDDRBKn/LDTXsNUnXS3hCTXIUU9h0MPXCgOQSmBtTnkvmJxDg43O4lesSBq+Z0jVlGW27TOSTqi76nGrTgORkkSNkz7CfBmAo33/JCR0Sz4vKJTGcroEzhgSZy3PZVaogO/5Oxi4rp4221mlu6LcWHHUnWC0GhgFf2WwmXnQKbOf7zzh6nlkRs5eufRCVtxqVSJ0wVgtNIZ4vmL13byLq9Zq/IS6Nh/gXE2Msrb41/YfwUnX+RNluqwmme9eQJeHB7go8mn8T679JWplqkILqt9JskGUhIxoIO+UGjmokSEGwTQpc309jRLTKZ/T4bSTTuLcEi+myjb9RxBw/Q0qqO9+rDSq6o5zvHIvGtcDUBgmPJapwIOijdSaNJzqiQK+y0BDb+KF/KcXV4bKF1EFFBF6kBVvNEDxE8tQO8nZOx0eraU8j4xbJHUBplBHB8C0l+qkE=
X-MS-Exchange-CrossTenant-Network-Message-Id: e631edee-d868-40c4-4d06-08d7eabfc0c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 15:29:19.2258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beS7V3kyK5Y0iBv7ERQcAFHhqqZur06/0r1120uENvZ6feYiDcWFJ7uDLTIV3B12FSa6eFGLDz6FBK1Avyx4RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3465
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 11:29:22
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
---
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve.decode      | 10 ++++++++++
 target/arm/sve_helper.c    | 15 +++++++++++++++
 target/arm/translate-sve.c | 18 ++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 51ad60e5c3..340fe07801 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2690,3 +2690,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index de3768c24a..f58eb04d11 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -92,6 +92,10 @@
 # Named instruction formats.  These are generally used to
 # reduce the amount of duplication between instruction patterns.
 
+# One operand with unused vector element size
+@rdn_e0         ........ .. ........... . ..... rd:5 \
+                &rr_esz rn=%reg_movprfx esz=0
+
 # Two operand with unused vector element size
 @pd_pn_e0       ........ ........ ....... rn:4 . rd:4           &rr_esz esz=0
 
@@ -1419,3 +1423,9 @@ STNT1_zprz      1110010 .. 00 ..... 001 ... ..... ..... \
 # SVE2 32-bit scatter non-temporal store (vector plus scalar)
 STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
                 @rprr_scatter_store xs=0 esz=2 scale=0
+
+#### SVE2 Crypto Extensions
+
+## SVE2 crypto unary operations
+AESMC           01000101 00 10000011100 0 00000 .....   @rdn_e0
+AESIMC          01000101 00 10000011100 1 00000 .....   @rdn_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index cd5c6f7fb0..5c3dee048d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7516,3 +7516,18 @@ void HELPER(fmmla_d)(void *vd, void *va, void *vn, void *vm,
         d[3] = float64_add(a[3], float64_add(p0, p1, status), status);
     }
 }
+
+#define DO_SVE2_AES_CRYPTO(NAME, FN)                            \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)            \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    intptr_t decrypt = simd_data(desc);                         \
+    for (i = 0; i < opr_sz; i += 16) {                          \
+        HELPER(FN)(vd + i, vn + i, decrypt);                    \
+    }                                                           \
+}
+
+DO_SVE2_AES_CRYPTO(sve2_aesmc, crypto_aesmc);
+DO_SVE2_AES_CRYPTO(sve2_aesimc, crypto_aesmc);
+
+#undef DO_SVE2_AES_CRYPTO
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 86c3d0ed11..f70b7f44e3 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7956,3 +7956,21 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
     };
     return do_sve2_zzzz_fn(s, a->rd, a->rn, a->rm, a->ra, fns[a->esz], a->rot);
 }
+
+#define DO_SVE2_AES_CRYPTO(NAME, name, DECRYPT)                         \
+static bool trans_##NAME(DisasContext *s, arg_rr_esz *a)                \
+{                                                                       \
+    if (!dc_isar_feature(aa64_sve2_aes, s)) {                           \
+        return false;                                                   \
+    }                                                                   \
+    if (sve_access_check(s)) {                                          \
+        unsigned vsz = vec_full_reg_size(s);                            \
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),               \
+                           vec_full_reg_offset(s, a->rn),               \
+                           vsz, vsz, DECRYPT, gen_helper_sve2_##name);  \
+    }                                                                   \
+    return true;                                                        \
+}
+
+DO_SVE2_AES_CRYPTO(AESMC, aesmc, 0)
+DO_SVE2_AES_CRYPTO(AESIMC, aesimc, 1)
-- 
2.17.1


