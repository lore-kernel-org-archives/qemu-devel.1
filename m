Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E40C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D374620CC7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UvAfSluV";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="lEDFZfTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D374620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRkVZ-0006Y6-OE
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 18:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRkTz-00047N-6x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRkTy-0007xd-3P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:38:10 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:4315)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jRkTs-0007Zw-Lm; Thu, 23 Apr 2020 18:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587681484; x=1619217484;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=O5OKuFPYRc9RmKhb1czU30NEAzTtN9YPVEM6Jc1JZ2Q=;
 b=UvAfSluVaeG4+G3dLJf/ROXcfpJtl+tCyXr+Dmo3VQ9/L9EPFafrpj1G
 vkz+awWvgRwB9t7l2pK5hSs/ApA8FQ44gezNmAC//Y42WM9KptOVUwPu8
 +gND5avMCDFdWanYNqZOV3kWmTfcEFkXqE1ZfkxVpOrxLFIGByaByhx3A U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Apr 2020 15:38:01 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 23 Apr 2020 15:38:01 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 15:38:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 23 Apr 2020 15:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN0mkIpukmbMrwNmgLgkWVqvsDGcED/ZknaBpVb+AZDCmKBG5wh28Rc5NO5pqltQkJnDkTUF96NvaFSOpSNPtUuGK5FuHCHBPyLqFE0Xi1/un71ULrLcrL5Sa7CgsjRQ7Gv7i0/fjaMo7bx/Nv48AIpbzdgek7uIcN1YGlpDfUpntRmel5l6XvmpxtWHuM7aajmreWs8IQSWcWxZFKtQVqxys3342wZWGiP9AOXrs1v8Gq37HOqXpyOTuGgx0yfPuic6CyPxSP993jAYme4Dsz2QAOdQS2I0TafSDrezJUZDzxhvjVajK/REe0pBkEl5i28KcWHXSOoWE+rlB+zXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsv7zy8gWHtmXPR9VUT0wP5zPylgDLXuwyzGioVXUSM=;
 b=B3eLY99sCbEcQUHstJTLPOUf75t2gVaYm5jzvjP3gEGCTSfMi5xyoItufb9RB+79Pq+SGECJFpWQTkoVvVb+Y1jBCMs184XNs9xvHkSskEowNP8QSvAmiK1HXem2hFpg9qYyiCt6buhum+WsZWGKDhy0yCySlb7suFFZeZjlYc1kmBSd0PUmK7g6/Kywork3BUpR41iSXyUlOCUTgdxC8INO5YuC9U6nwYRwf67Ym5ikylZJczfV0P5ekjkPnMbEDpJz5I+o861ehl+JovxxpyaQ8CfmVyDSL7KyOO+tWTdK6NRpV7DLbjPootMRwQ1g/KYf8ZqhS2p86p4tQHUshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsv7zy8gWHtmXPR9VUT0wP5zPylgDLXuwyzGioVXUSM=;
 b=lEDFZfTNCT8sfu9p+T76rn2eCV/PIBK5NtsIEtHJcSTO4aYsJGnTKEJdozBHqm/1ynKmYBWp1iukq06GYJJtHPdj8ZASUMxtQPP4jQ7PxUMQFMh1tyky5lWdQaR8v+PZHSbrVi9qh/UXXgbfX5c+yyOLRQoLRjX+KSNGP/JYvEs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3532.namprd02.prod.outlook.com
 (2603:10b6:301:77::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 22:37:57 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.033; Thu, 23 Apr 2020
 22:37:56 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC 3/3] target/arm: Implement SVE2 SM4EKEY, RAX1
Date: Thu, 23 Apr 2020 18:37:39 -0400
Message-ID: <20200423223739.31715-4-steplong@quicinc.com>
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
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 22:37:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f884a55-2702-44fd-32d5-08d7e7d6f806
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3532E66A69AF887A1EC69F9CC7D30@MWHPR0201MB3532.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(6512007)(6666004)(8676002)(2616005)(478600001)(956004)(4326008)(6486002)(66556008)(107886003)(66946007)(86362001)(16526019)(186003)(66476007)(6916009)(8936002)(2906002)(26005)(52116002)(316002)(81156014)(6506007)(36756003)(5660300002)(1076003)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEIo6i7BMYWmcEfw/YeJORkRusKz7tNZPgqO2qLjU7N78Aq1q2HclQ8z7cxIdaWAgNbjrrrzCPypmuq0GtxVB92Fr58Ecm576rMOMmoMzXqhVdtJKMZfJtA5bs3yaCJwO+chJv78PeZolSQ7FCoHIEW1162uC0PZQd2QIvAkYUY69pI2u5iJV197u+vxKmRFX6HD7cMMK9gP+Hh/qlV3ewsHJ3vdPtGIp3uiJUBR6LXCosKuAk6fohWu4B9F2QenCPHIewlCrhV1uW7WmLDFDnFeHIRitC5Glmj3RYN9D/rMUm6ZrhJZYM6NhOUOhD4tLlRd/X5Sthmzn/fyynlRHRic46X2wTLzX9KKJ6Qe54vLKfdqynZfs4RPSR+W7Zbc2ggrhih95abB24V1ik/47Rb/ydFmv4i2kNG7HxGOce42XvVMCNNE1jczZXcYtmXAeAoKL8EUXc3YjVIUv9dUXUVcQtGeuteIt2d9Ldb5RaA=
X-MS-Exchange-AntiSpam-MessageData: O3nE6pTPwVlaqFn2zWo9UljXwM/LFiV9py2xF0G5VnJG6l404ufvyfdaOxwXS+52q86js4/wQf2FJnFGiMB9uPxnX1avcJTkwiyfplcES1uRfrTTXrDeratlOkQOWDSzQRipg+M4+a/39o0p0Mpw8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f884a55-2702-44fd-32d5-08d7e7d6f806
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 22:37:56.7956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGxQG5JjSZ/GmixhCh/tKG1YU/T5wegUzT7e2LvwQ0v6IH1PzobDJHq4xig5PU7quL2Epz9SXe9Ze06F5Y24KQ==
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
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve.decode      |  4 ++++
 target/arm/sve_helper.c    | 21 +++++++++++++++++++++
 target/arm/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 3da9590da5..07681728ba 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2694,3 +2694,6 @@ DEF_HELPER_FLAGS_3(sve2_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_rax1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 4bbf219cb6..1e98c6aa2f 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1403,3 +1403,7 @@ AESIMC          01000101 00 10000011100 1 00000 .....   @rdn_e0
 AESE            01000101 00 10001 0 11100 0 ..... .....  @pd5_pn5_e0
 AESD            01000101 00 10001 0 11100 1 ..... .....  @pd5_pn5_e0
 SM4E            01000101 00 10001 1 11100 0 ..... .....  @pd5_pn5_e0
+
+## SVE2 crypto constructive binary operations
+SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
+RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 0581f33fc7..e8299b33ee 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7466,3 +7466,24 @@ void HELPER(sve2_sm4e)(void *vd, void *vn, uint32_t desc)
         HELPER(crypto_sm4e)(vd + i, vn + i);
     }
 }
+
+void HELPER(sve2_sm4ekey)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    void *d = vd, *n = vn;
+    for (i = 0; i < opr_sz; i += 16) {
+        HELPER(crypto_sm4ekey)(vd + i, vn + i, vm + i);
+    }
+}
+
+void HELPER(sve2_rax1)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        uint64_t nn = n[i];
+        uint64_t mm = m[i];
+        d[i] = nn ^ rol64(mm, 1);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d991dcdb1c..671f09efa7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7916,3 +7916,33 @@ static bool trans_SM4E(DisasContext *s, arg_rr_esz *a)
     }
     return true;
 }
+
+static bool trans_SM4EKEY(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sm4, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, 0, gen_helper_sve2_sm4ekey);
+    }
+    return true;
+}
+
+static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sm4, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, 0, gen_helper_sve2_rax1);
+    }
+    return true;
+}
-- 
2.17.1


