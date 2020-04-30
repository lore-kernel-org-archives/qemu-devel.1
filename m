Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42330C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1992070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pX7s1kmF";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="h5HtDFte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1992070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCJD-0005ng-54
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jUC3V-00027c-7W
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jUC3O-00070Q-9v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:55 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:6486)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jUC3M-0006vu-Lm; Thu, 30 Apr 2020 12:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588264128; x=1619800128;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=hVEaomHiqJ4t8Aruh77wpesWDKxrCReVp/RXkKJTFsI=;
 b=pX7s1kmFPVEDR0ffQdRvtTtXcsV3GUFlN3P7HEHzS7SkB44BAFGVbf9Z
 WOPwwLUasTET/bED1yh5PjOHw+6IsUhl4tC1dLcnSjQrR8Rd5HZ0mV2Qi
 ikmMKU2EY3OnvUEknGdS+8bu7AZdS6jlZLgRfGV39r492kf3Kx3bAWuXl Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Apr 2020 09:28:45 -0700
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Apr 2020 09:28:45 -0700
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 09:28:44 -0700
Received: from NASANEXM01D.na.qualcomm.com (10.85.0.84) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 09:28:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 30 Apr 2020 09:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQYEUAe/q8tvYBMcoLQiSIDd4Z++JzdWS+TB8N86QCJQyKaSbIICPv4iBi7x0NXeGD/uyO7JoBeHzmkaXz6c2IuCAujBZTYgEwJ0ibc3iSbaXUQH1u3zMuU8gis/BHRLiQDFEPx2LYAWP+Zl/Wqu5F/T0tqj9uYEsGsGwKOOhgxYo/yRDNA4iqHS3kkzlmYXPzklHnWgj2CY3Wq8Y22ja2ELB8k0+zAoBB+WksXHWYwlPzB971roj/FWCfbdEIKyvPCrm1hLLVeIL2Q2DByxPpINab05ePgmvuK1BDasWsCCF9gOt+6sQbXVbGNW5So8y+ltLmNHTIbfIEEQBFVyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlv2wuCtN0rSCrAPtRnJiOqhTecEh+wZ3cA5hy29fNc=;
 b=cvFIRyUN9Gpt3eAZXnxyqBfk6t0773wYbijTW20byle4jRCxJyO5iXgbJOtF970MIpvhqqyd5bRZRCq1qln4GmQM0HEx3lZhYZOliLFnL2O0xooNTk/5H1ihtZma34W0oyKJ0M7/IeMeQkyAPCTR7Ht/FfgAhiv+ebZcdnEu9dVn7l2CVPyJT5L75SruIIzLKxBcp1Tw5Bn1QwD4QmeaybOTH0vbs9azjptCV4dfPlMuahbYYjTqBMpFT5YmzaEihI7KuSyhiId8WCGXVJhfao6NSiwdriliF7PQKVCb7Zp3fKValPm2iBQnDPovGautNhZbcvWfQBW2TpIMztUTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlv2wuCtN0rSCrAPtRnJiOqhTecEh+wZ3cA5hy29fNc=;
 b=h5HtDFtehPE3e2JnAoS57kJ5QJBWQzusr9LTO7Pn8Ud35XgbzmagQlVyMBoV7nojPJioDRwwCLFfQ2U6SdyARPA81lsrEFanp5WnmxDTAndqYgGnpaLCSVLAU5yAJhQF2YLXPlCox8vxK/5zWqfkElIgiWtWaawY1ii21j81wGg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3561.namprd02.prod.outlook.com
 (2603:10b6:301:79::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 16:28:41 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 16:28:41 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC] target/arm: Implement SVE2 bitwise shift immediate
Date: Thu, 30 Apr 2020 09:28:28 -0700
Message-ID: <20200430162828.13993-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:610:59::34) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.na.qualcomm.com (108.176.222.2) by
 CH2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:59::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 16:28:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efa53a68-4693-453b-5b8f-08d7ed238b0d
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3561C5E5C3307404F9BA3C2CC7AA0@MWHPR0201MB3561.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KR05csTB3T6GMzN0HLrqses+hgxIXv48qlh2ZynrXoky8NrprvSjNAw1encqNdeqzsX9VfKyQl6R3sI8a0HLy8rf2fTa039IMEjf4YwxI+lrab+4rYl9UaBPpy6j+uK66dkF7DgyjYy9nquAsrEg2ksM9+rILkTQj9ufZZQBqoEJ2u3YtRjcLdi19HO51iJO4XAoH/G5/gU/PDBkGzlFYoSssPqREix23lPBPvNIbD57mK6UHs7QMNyCfvFg1H6bPF6kiZAKGi1xmVIQ59ojmQpid9glmPW6Wv8LQnmKAMY9y4Z2htKavQZZKCwz29pBedX1MsFpR2wpsmyrjrspqF7tYV5YHlVzDmJiTsnF94NhNdH/gHrfi40j1Zj40C7vvPN9g1e281LQaMsgKUKDLEvUeS4Am/NixNzGqqXF+BGDQytzodao/r7Xyw7drQX8EAbDnrcdQwWBNvIFkCeRUe/qWJ8oHU3eunN5nH+i0l9bKlDY13wdzhkIhJSgdiR3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(6512007)(36756003)(2616005)(956004)(6506007)(52116002)(186003)(6666004)(16526019)(8936002)(6486002)(86362001)(107886003)(8676002)(4326008)(26005)(66556008)(6916009)(66476007)(498600001)(66946007)(2906002)(1076003)(5660300002)(14773001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kcEk93ZKPBz5MhbfZWFnZWvHCR3L7woa3OBM/s7fWMPW2o3poNMGylPmogAzGAxsCxn22Zkfuel+2ls0WfcQsTqix9m1A0oSAt7DYFFhL4S6Xww/D3mkDlM3il1mvV0N0xSj5xogBSGDNiLtIhqxHOOexi640Tq91Dax3Dm5K/Tn8burSzOvrTFZ6pL2EnA0trfe81iNfbzky3WND8yWwuecHYIhrJNfX3daPusbFia0uORJ8N+tCsohBX2AhYwmMDNsFMb75d5P3B6yG63gdt0cdfqGlHQIe/uvfiIH63MoMFFe3gt4j5MgE7e/Bd2m5JUS3NuV3w4mXW3SjuD8wpRyfwZCN4XisSCZN14s8ywC8F3UfxlSDlj3VNqH+DWHQVsHulWgnB1Derbn+7NIBJhe9Xpx6Ux4l5KiYfFYy4Y1y18K1DkO68WC16VLmOVFeC1E/Gpl1xC9/FSVw1n0GrG9jtjNjKW8oB72iQpnUuDPxoSXo0Vtm9aEOXcJd95OMBEh00q75jGjN9tZC8BFSWgcFwH025j4kYBHq37GshPWQz4Wt6zPX/3AKq41YiyrBlxk8HGzdj44uT1aeUUDDUfZor/YE/MILmUlsDeQIeqbOaED/DXAAFguPIRmWQs9WLdQgeztJ4KFWUPdqcNhHxAINu6JnXENzqytq5uZiaZtCxi+i1VcC5U4I3CONKUaQ49alnTmuvRs5JYJB/bZ9PS8on6BnDuJZ5qykA6iJeOVRf4S7k5dWBcvhiL3xrmQKzcVTV3N9NLsjfdDpP2rlc10bIHt+mhgZX5c6ZfUdao=
X-MS-Exchange-CrossTenant-Network-Message-Id: efa53a68-4693-453b-5b8f-08d7ed238b0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 16:28:41.0250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCBdi1ZmMQNSBA5OFxFu+4XIYewKf5cN1Hrta1rdty/IwdcbncQP4tnGhXAFzfgycjPtm+3W+9TwNBnJyOUO3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3561
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

Implements SQSHL/UQSHL, SRSHR/URSHR, and SQSHLU

Signed-off-by: Stephen Long <steplong@quicinc.com>
---

I'm not too sure about the casting I'm doing willy nilly in the helper
functions, but I think they should be ok. Also, there might be some avenues
for optimization when translating similar to asr_zpzi and lsl_zpzi.

 target/arm/helper-sve.h    | 29 +++++++++++++++++++++++++++++
 target/arm/sve.decode      |  7 +++++++
 target/arm/sve_helper.c    | 30 ++++++++++++++++++++++++++++--
 target/arm/translate-sve.c | 19 +++++++++++++++++++
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0a62eef94e..c71f3e1f39 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2731,3 +2731,32 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_srshr_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_urshr_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqshlu_zpzi_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_zpzi_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_zpzi_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_zpzi_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3cf824bac5..a9cfbc80ab 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1568,3 +1568,10 @@ SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
+
+### SVE2 bitwise shift by immediate (predicated)
+SQSHL_zpzi      00000100 .. 000 110 100 ... .. ... .....  @rdn_pg_tszimm_shl
+UQSHL_zpzi      00000100 .. 000 111 100 ... .. ... .....  @rdn_pg_tszimm_shl
+SRSHR_zpzi      00000100 .. 001 100 100 ... .. ... .....  @rdn_pg_tszimm_shr
+URSHR_zpzi      00000100 .. 001 101 100 ... .. ... .....  @rdn_pg_tszimm_shr
+SQSHLU_zpzi     00000100 .. 001 111 100 ... .. ... .....  @rdn_pg_tszimm_shl
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aa94df302a..1982d29a1e 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2218,6 +2218,34 @@ DO_ZPZI(sve_asrd_h, int16_t, H1_2, DO_ASRD)
 DO_ZPZI(sve_asrd_s, int32_t, H1_4, DO_ASRD)
 DO_ZPZI_D(sve_asrd_d, int64_t, DO_ASRD)
 
+#define DO_RSHR(x, sh) ((x >> sh) + ((x >> (sh - 1)) & 1))
+
+/* SVE2 bitwise shift by immediate */
+DO_ZPZI(sve2_sqshl_zpzi_b, int8_t, H1, do_sqshl_b)
+DO_ZPZI(sve2_sqshl_zpzi_h, int16_t, H1_2, do_sqshl_h)
+DO_ZPZI(sve2_sqshl_zpzi_s, int32_t, H1_4, do_sqshl_s)
+DO_ZPZI_D(sve2_sqshl_zpzi_d, int64_t, do_sqshl_d)
+
+DO_ZPZI(sve2_uqshl_zpzi_b, uint8_t, H1, do_uqshl_b)
+DO_ZPZI(sve2_uqshl_zpzi_h, uint16_t, H1_2, do_uqshl_h)
+DO_ZPZI(sve2_uqshl_zpzi_s, uint32_t, H1_4, do_uqshl_s)
+DO_ZPZI_D(sve2_uqshl_zpzi_d, uint64_t, do_uqshl_d)
+
+DO_ZPZI(sve2_srshr_zpzi_b, int8_t, H1, DO_RSHR)
+DO_ZPZI(sve2_srshr_zpzi_h, int16_t, H1_2, DO_RSHR)
+DO_ZPZI(sve2_srshr_zpzi_s, int32_t, H1_4, DO_RSHR)
+DO_ZPZI_D(sve2_srshr_zpzi_d, int64_t, DO_RSHR)
+
+DO_ZPZI(sve2_urshr_zpzi_b, uint8_t, H1, DO_RSHR)
+DO_ZPZI(sve2_urshr_zpzi_h, uint16_t, H1_2, DO_RSHR)
+DO_ZPZI(sve2_urshr_zpzi_s, uint32_t, H1_4, DO_RSHR)
+DO_ZPZI_D(sve2_urshr_zpzi_d, uint64_t, DO_RSHR)
+
+DO_ZPZI(sve2_sqshlu_zpzi_b, int8_t, H1, do_uqshl_b)
+DO_ZPZI(sve2_sqshlu_zpzi_h, int16_t, H1_2, do_uqshl_h)
+DO_ZPZI(sve2_sqshlu_zpzi_s, int32_t, H1_4, do_uqshl_s)
+DO_ZPZI_D(sve2_sqshlu_zpzi_d, int64_t, do_uqshl_d)
+
 #undef DO_ASRD
 #undef DO_ZPZI
 #undef DO_ZPZI_D
@@ -2252,8 +2280,6 @@ DO_SHRNT(sve2_shrnt_h, uint16_t, uint8_t, H1_2, H1, DO_SHR)
 DO_SHRNT(sve2_shrnt_s, uint32_t, uint16_t, H1_4, H1_2, DO_SHR)
 DO_SHRNT(sve2_shrnt_d, uint64_t, uint32_t,     , H1_4, DO_SHR)
 
-#define DO_RSHR(x, sh) ((x >> sh) + ((x >> (sh - 1)) & 1))
-
 DO_SHRNB(sve2_rshrnb_h, uint16_t, uint8_t, DO_RSHR)
 DO_SHRNB(sve2_rshrnb_s, uint32_t, uint16_t, DO_RSHR)
 DO_SHRNB(sve2_rshrnb_d, uint64_t, uint32_t, DO_RSHR)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a8e57ea5f4..d74fcf4e75 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8253,3 +8253,22 @@ static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
     }
     return true;
 }
+
+#define DO_SVE2_ZPZI(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rpri_esz *a)        \
+{                                                                 \
+    static gen_helper_gvec_3 * const fns[] = {                    \
+        gen_helper_sve2_##name##_b, gen_helper_sve2_##name##_h,   \
+        gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d    \
+    };                                                            \
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {           \
+        return false;                                             \
+    }                                                             \
+    return do_zpzi_ool(s, a, fns[a->esz]);                        \
+}
+
+DO_SVE2_ZPZI(SQSHL_zpzi, sqshl_zpzi)
+DO_SVE2_ZPZI(UQSHL_zpzi, uqshl_zpzi)
+DO_SVE2_ZPZI(SRSHR_zpzi, srshr_zpzi)
+DO_SVE2_ZPZI(URSHR_zpzi, urshr_zpzi)
+DO_SVE2_ZPZI(SQSHLU_zpzi, sqshlu_zpzi)
-- 
2.17.1


