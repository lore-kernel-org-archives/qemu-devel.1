Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB8EC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 17:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B22520787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 17:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="xubuCtWA";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="UEllvYfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B22520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCwr-0001ck-8q
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 13:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jUCtr-0000V2-5G
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jUCra-00044g-I1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:23:01 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:33033)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jUCrZ-00044K-Ph; Thu, 30 Apr 2020 13:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588267241; x=1619803241;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=qJ0GeMmzwM/vss84ujr6XTDfPkq1AClSikuCcLAWEqU=;
 b=xubuCtWAdJ6zltbO9qQiluAwaPgKxY87KeNY633rOVQD1m1FQDEUnqrA
 QXqBP+k6tDPiLo27clz0c8eglHTjBv/SnUaftXXFqAE99TbH7XzTDHYdU
 THMwqvykBXruf6jwEXWMUNRYu96DYhyhJBJkE5tQSQ6Xmu+TTEZD5Od9o 0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Apr 2020 10:20:39 -0700
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Apr 2020 10:20:40 -0700
Received: from APSANEXR01E.ap.qualcomm.com (10.85.0.38) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 10:20:38 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 APSANEXR01E.ap.qualcomm.com (10.85.0.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 10:20:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 30 Apr 2020 10:20:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAqmvqh9ocM7GzojzloGfjq4SMzDAlz5b8uF/aDM2pseleZxYnjdAQbxuo42Quc64AZNPGUdRxnFR9VpMZIZvXhf8DidovtV4PUGQw6JA9ks+lr3cEruQ9/Twhc2/41oKRa6FtMG3bi4DPctRFEX/OmlioaAlLvy+yS1OVqwrsBM94YUArsztwisxIJp4Rc2XNt2WzDLyg4mSAL2WH9IVIzR1jzNROYlU11W/ys4k2VxV92IYo+kA8guF+MYa58XfFipBJgJxEYpPZq4ZyxgOiiFpQb4LCs8JZyCmPozlRC8aXM2Eajeywqu7QEqAiH6qrONcaZc5WJXwFmtwkoCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFnUtkfFOBhzKsn03X8+Qx955CJDyM5Gu7K35ojpcvQ=;
 b=L9MWjAQrm8hROiJ58rqB55Z2WrTcDKzWb+ZhADdJcdGCpI1LLR/9If7n3YwqpMolcjaBqhf2OAWPrRA+CQYUl7B0JBPCOn4panDJ05+7Hji9Rmxbt7eL2z9fGlZHrw35tBNyUpFRnrOGpzBd49y5glo50WoZCicaV1ewnt3uDZWh6njb0ucsVdwiRZqmMb+xKtZ/VhhGZ+cExodOs832BZfJrIhnH26vgQZMvwVDuRLjuvlaqiF5G0QdaLt30uFXHoSOoCZ0ZSeMBZNsd0nn7cYe7kcw80BaUqIKXH4moiyAjeMtbyGVhvQrMqaqrA3VxCMO4rBV+aozqVeqJOsQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFnUtkfFOBhzKsn03X8+Qx955CJDyM5Gu7K35ojpcvQ=;
 b=UEllvYfGlk2tLdxap7gJkcWVHnFV+0eBgK1Vl0Cc8vnhqh3AMdLlwdWkan49+3phvIDAxG/HbkKNqCJqz7JMZAAbZQWBJaIRGYrQCeNZ2HWo9rvHnuZFInUTTCkLAElIHio1UjuM/geGnfs/cgsXxag7wompGhqz33sAQDuztz4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3482.namprd02.prod.outlook.com
 (2603:10b6:301:76::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 17:20:34 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 17:20:34 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC] target/arm: Implement SVE2 FLOGB
Date: Thu, 30 Apr 2020 10:20:22 -0700
Message-ID: <20200430172022.14886-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:610:20::31) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.na.qualcomm.com (108.176.222.2) by
 CH2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:20::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 17:20:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 686606f6-cb5e-4939-0a95-08d7ed2aca94
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB348216DDCDD580BE007ED0F5C7AA0@MWHPR0201MB3482.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:89;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(396003)(366004)(376002)(136003)(39860400002)(86362001)(107886003)(6512007)(2906002)(6666004)(26005)(478600001)(66946007)(2616005)(52116002)(4326008)(66556008)(8936002)(16526019)(66476007)(8676002)(956004)(6506007)(316002)(6486002)(36756003)(6916009)(186003)(1076003)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V875X01MMVXfNGY99FfaVAtG4q+uhuloKU4QSNKq2U5GBYDfTMzrohlsGDv//QylVxGjYg0A9lL3tybHt/HVtpkM35R92hvKjqEeWAdKTDVfSxvj9mkp9uXiVMPWq6Qwv94xi+OE+h9UAOgCTkOof82fzwEK52ngT71X01H46S0xG2E6f9oDWJyoIhEOpLgSMzi2fm2CxNHos/FBXbr3EMC+0BaakpjrIx7OPiDixrJAGsnKW43NB/IPapfdxLOnb+dwBF1E4OntJ3K1vUe0uVdqQLKs5aOWM4gI0C/f3paI6IRnk2z6STX3OOpWYXGcXAvsCvlHOa55CZDXFYYKPSkSyobxO7Ger1E3Qwo0+vlfVB7ppA/3zFDS/iGuwiH3Vyu5L1RDdQRYYx6+RfV+HBUpWa0WByMjkRIkl6r25iJndIX9ovOAd0UZhJdoBcUr
X-MS-Exchange-AntiSpam-MessageData: QknRsZDtnfW+Fgoy7RD2CdoI3HLKy7sPR14fnfW9B2hIjOLF+q/tN14A5PhZYU+D9XRlWkaY8ZTssLvSS7F/fC9+i5FwxivIdVw3wTwvxKiH2+gl8YetCnLyRJ/ZBxM+Dv0371MXZb/pHULBtUNChp2z7R0WTYfKCqgp8lqydV9SMeghnBADzi5Z1QzRwX5EJz9nclQMZSIEutNnaXIu+z8LLFwl09E2ebe6qUJuNDFz3xlaunm7b9/HqtpjQhi6WSCQVGXmVkz3TzhU+mUhqX/83Qe5ki6SXN6NHyQHQZTbscRlu44S6cRvVnb6eCL2HJgxfW9+cC42pmwwtgcoGj9DON93bZmHBawffIAVLRpvj6Senb6Kevi85rd5YtaFC9RfP0WJmy0reVsN2fj+a0l7dNWoYrJwVvmbAI3w3YQ5KlC2BoZgH7dYnma/mJLCBryHNtkRmyJpkx1x7msCzr7Ap9ntzzXPktc5Yc3C6tcViePSVlbhgZKuTi8PLLuQhbm0doreNgLPvXYZoZPi7Q8oIpupCfML6TocM9A4sJdDLKMNGNsH3RNkVjO5YEl0PzNG7EjlSI0QXH86x0rHjoSzE4F6YF1tBza4vuLuxauNiQyGBXXe/DPTHbGnIXsUuCwQvgibu9lpXGF5tyCCAzNhs2dXlvD+WKprBOrE32tjH4F3sBxSdbv1uOVctx0xG8gDZXh7GUnHCry2bOVtY0XUaB/VHxsZTR2NeRLUDQMrpxsTlPEjLB7tv/MzzdPVsB+oTaGPt7jRF3SWzuMBTjI3AVUnOYa6s7Os8+iMEGQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 686606f6-cb5e-4939-0a95-08d7ed2aca94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 17:20:34.1472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YK8Ye+DXFWmsx9zMMNWUtx9Xjq3VasMsm5o0+jHQ7nt8JaI7mEJ9CDHN58s1slHJ2fj23e/kEPuVavGyMzlXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3482
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 12:28:45
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
---

Right now, there is no log2 function for half precision floats, so I'm
not sure how to proceed. Currently, I just added a TODO comment.

 target/arm/helper-sve.h    |  3 +++
 target/arm/sve.decode      |  4 ++++
 target/arm/sve_helper.c    |  3 +++
 target/arm/translate-sve.c | 17 +++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0a62eef94e..aaa5fc33f9 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2731,3 +2731,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(flogb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(flogb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3cf824bac5..dcb095bb5d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1568,3 +1568,7 @@ SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
+
+### SVE2 floating-point convert to integer
+
+FLOGB           01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aa94df302a..aba9c064fb 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4624,6 +4624,9 @@ DO_ZPZ_FP(sve_ucvt_dh, uint64_t,     , uint64_to_float16)
 DO_ZPZ_FP(sve_ucvt_ds, uint64_t,     , uint64_to_float32)
 DO_ZPZ_FP(sve_ucvt_dd, uint64_t,     , uint64_to_float64)
 
+DO_ZPZ_FP(flogb_s, float32, H1_4, float32_log2)
+DO_ZPZ_FP(flogb_d, float64,     , float64_log2)
+
 #undef DO_ZPZ_FP
 
 static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a8e57ea5f4..9176b18bc9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8253,3 +8253,20 @@ static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
     }
     return true;
 }
+
+static bool trans_FLOGB(DisasContext *s, arg_rpr_esz *a)
+{
+    /* TODO: There is no support for log base 2 for half-precision floats */
+    static gen_helper_gvec_3_ptr * const fns[] = {
+        NULL,
+        gen_helper_flogb_s,
+        gen_helper_flogb_d,
+    };
+    if (a->esz == 0 || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        do_ppz_fp(s, a, fns[a->esz - 1]);
+    }
+    return true;
+}
-- 
2.17.1


