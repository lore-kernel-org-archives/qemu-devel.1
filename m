Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41826C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097AF20CC7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j0L+lpRt";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="ijsGFLhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097AF20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRkWw-0000L9-6Z
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 18:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRkTu-000417-S7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRkTs-0007e5-32
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:38:06 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:4303)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jRkTr-0007LL-1X; Thu, 23 Apr 2020 18:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587681483; x=1619217483;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=MZ2gigH55RcNMrvUN8mf9NFYARMICN9HzCOGYX1iFAs=;
 b=j0L+lpRtgzNLvP+kI9ZavwW3hpHp/Qrw0Bspicl6BiH2pOi91+sQ3662
 C616aV0TDVCjCWn/W8ejwARzBNO941Z0D9tSqoVSvtDR0u9EOiptiAZ1b
 86b86P7/JFIFDWLtPukesVhPYFUFWtm4EpIMyEJ0sDwPfxcC49Pv1Goke Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Apr 2020 15:38:01 -0700
Received: from nasanexm01f.na.qualcomm.com ([10.85.0.32])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 23 Apr 2020 15:38:01 -0700
Received: from eusanexr01e.eu.qualcomm.com (10.85.0.100) by
 NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 15:38:01 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 eusanexr01e.eu.qualcomm.com (10.85.0.100) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 15:37:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 23 Apr 2020 15:37:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHUzwnTl4hM5mLbYXRfsQJnMnQahd1+1TKiugpezfQYLgCKhdzU+74xeZBDmH7teHnRWV4E63uMXgjBGuTD4oG5wyx8gwhdV528kZFoy/sGf1VKmkmJSbPoI2llY8TVqEFuRvJ64JB3BWRnhycr2ephNc6jXVeIT0zei5G7pDalNAKv8rBv67d97VAXjYHYQU0ZdFKQWe1KBKNKHuPC9cL0/BBG0QhMKZZmFNFvoawBxD7WVwXU6f6Y7edjUcP7JJyYkNrSkLq0vlUfUAKZnidzRAtcf+InmUGLDb9QuxqfAS355PMUT0lofoEkJWvyfDgkiEHuFL9cVhcHTGW7vPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uH25NMRETFkpCu41BC7H62l9tKOtHbDhMUf0WBGLWE=;
 b=hLVjux2kY5piCJyBDCEiJmRBEjV1O8LU+hypqKKEGWOg5kef8GO2FL6fAcPkP1DjGA27pWv0s0qd1zVtMohy4fRhUShdp5WDadxKd4aCX4BC7Z8GMkpAtEUG0lM6eZ9EQEzwS84ExV8QrmZUw3VwNFfZrFg6NuFiKyUNalDTqHD9/Y7dae+mlp9jydUfhE0mygsZmrVBw2RfG2N0o5Gxj8fgM1nLEP3avIOHpT+hZikox4zRMMDFQDibDLJMUtw+CAqIYxnzsEWPZBa14V0pfhwVVG76Z2aV1rDCztzOKlm6DvAzvbavtiLEWAirMJD3g+KbcOsiXh6g09UY4fCzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uH25NMRETFkpCu41BC7H62l9tKOtHbDhMUf0WBGLWE=;
 b=ijsGFLhJdJTfPzrlmXVJsAKpyKaXB6yx8VaNnQomsrl8IL4gwZe6GFyjRqr4reEw2qzdxitIF3XF++Vn+5mH0wsl6/Nfn/jKXuj2iLjufRdtgSa+rCBk11zeuSVWP5dEzbME4IsvOmD3rpYRYhDBrM0f80VUjNH+xz+jWIQz32k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3532.namprd02.prod.outlook.com
 (2603:10b6:301:77::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 22:37:55 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.033; Thu, 23 Apr 2020
 22:37:55 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC 2/3] target/arm: Implement SVE2 AESE, AESD, SM4E
Date: Thu, 23 Apr 2020 18:37:38 -0400
Message-ID: <20200423223739.31715-3-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423223739.31715-1-steplong@quicinc.com>
References: <20200423223739.31715-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:610:53::35) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 22:37:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498d3043-205b-4b68-94dc-08d7e7d6f77b
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3532809392F9F493191C5C89C7D30@MWHPR0201MB3532.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:32;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(6512007)(6666004)(8676002)(2616005)(478600001)(956004)(4326008)(6486002)(66556008)(107886003)(66946007)(86362001)(16526019)(186003)(66476007)(6916009)(8936002)(2906002)(26005)(52116002)(316002)(81156014)(6506007)(36756003)(5660300002)(1076003)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJPnIxaNkrsxMBdsuoDDpCmwNM8ly2lv+bg82SNY/MRFrkYiAz9sX4jATPTNpdtpLak1BT/Bn/X/s9uSrPx7wULGZRTS6Wfvd/VLtePWjpQWq7Qm3qcDxHqhDLb3Mebqrwp9lm+0bTQFBT1WhNPBgAyjakDygObRrQRM+klql0KwOQiooXDMg6JHzCxHFrosFF8Vlp1F0OJNfDIvFtbq+saoJy+IGIKrkQJph35v3srrbY6jQa/5vXG1JGoWpP+BkbWqzy+ypgz+4DAhFPN3WJb/XrmQQni6PmRKH/hXQfZg0qOCiCzuvGl34inVx1B1UsRkVy5tsTS+gO8sz64SUBPqQcfAKNL+H3lwgfFB/7DXnwe4QjN/N+g+UR1fujVMt6vJ3PDzVeFmJLNIkJk5inYQBqfyO0HNBxP9s6yO63YruEEruJwYaG3HzNMkGLH0dpdlpXDp08BvUJ3FlJhwjiQb8zY9DDtzH8RkG7J/6bM=
X-MS-Exchange-AntiSpam-MessageData: 07JojVdEZ6ka3NFy+gAQC95XbQLacYc62oGlAAF95Rfgetd+uKtI6Msp++dXSFrYDaoPo6dV8wC8P1rDFWXN25wjmMmP3uYjh6pH1Md+3I8iGljpNQDUL1cQcqg7D8opZvw02Ozjy9v0YbIZCMeoBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 498d3043-205b-4b68-94dc-08d7e7d6f77b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 22:37:55.8652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19OoA5+GdqFdgQm+MdIIqlf5+cm4QiYFP8bYc1NW3W9DX6nRb8FWoVdnl3/fQ/22xiEh4Wnw4bFeTrEtvnmOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3532
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 18:37:57
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
 target/arm/cpu.h           |  5 +++++
 target/arm/helper-sve.h    |  4 ++++
 target/arm/sve.decode      |  6 ++++++
 target/arm/sve_helper.c    | 25 +++++++++++++++++++++++++
 target/arm/translate-sve.c | 16 ++++++++++++++++
 5 files changed, 56 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b7c7946771..4dda0cf6c1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3870,6 +3870,11 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SM4) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 6e8421991c..3da9590da5 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2690,3 +2690,7 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_3(sve2_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a83420e690..4bbf219cb6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -98,6 +98,7 @@
 
 # Two operand with unused vector element size
 @pd_pn_e0       ........ ........ ....... rn:4 . rd:4           &rr_esz esz=0
+@pd5_pn5_e0     ........ ........ ...... rn:5 rd:5              &rr_esz esz=0
 
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
@@ -1397,3 +1398,8 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 ## SVE2 crypto unary operations
 AESMC           01000101 00 10000011100 0 00000 .....   @rdn_e0
 AESIMC          01000101 00 10000011100 1 00000 .....   @rdn_e0
+
+## SVE2 crpyto destructive binary operations
+AESE            01000101 00 10001 0 11100 0 ..... .....  @pd5_pn5_e0
+AESD            01000101 00 10001 0 11100 1 ..... .....  @pd5_pn5_e0
+SM4E            01000101 00 10001 1 11100 0 ..... .....  @pd5_pn5_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f25bb5338d..0581f33fc7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7441,3 +7441,28 @@ void HELPER(NAME)(void *vd, void *vn, uint32_t desc)            \
 
 DO_CRYPTO_AESMC(sve2_aesmc, 0);
 DO_CRYPTO_AESMC(sve2_aesimc, 1);
+
+#define DO_CRYPTO_AESE(NAME, DECRYPT)                           \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)            \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    void *d = vd, *n = vn;                                      \
+    for (i = 0; i < opr_sz; i += 16) {                          \
+        HELPER(crypto_aese)(vd + i, vn + i, DECRYPT);           \
+    }
+}
+
+DO_CRYPTO_AESE(sve2_aese, 0);
+DO_CRYPTO_AESE(sve2_aesd, 1);
+
+#undef DO_CRYPTO_AESE
+#undef DO_CRYPTO_AESMC
+
+void HELPER(sve2_sm4e)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    void *d = vd, *n = vn;
+    for (i = 0; i < opr_sz; i += 16) {
+        HELPER(crypto_sm4e)(vd + i, vn + i);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 03463308ca..d991dcdb1c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7900,3 +7900,19 @@ static bool trans_##NAME(DisasContext *s, arg_rr_esz *a)                \
 
 DO_SVE2_AES_CRYPTO(AESMC, aesmc)
 DO_SVE2_AES_CRYPTO(AESIMC, aesimc)
+DO_SVE2_AES_CRYPTO(AESE, aese)
+DO_SVE2_AES_CRYPTO(AESD, aesd)
+
+static bool trans_SM4E(DisasContext *s, arg_rr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sm4, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vsz, vsz, 0, gen_helper_sve2_sm4e);
+    }
+    return true;
+}
-- 
2.17.1


