Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB152C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD4620814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="qLGunIXr";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="EOCVoTfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD4620814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr9g-0002NU-TP
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpK-00069o-AD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:58 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:35792)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpJ-0002Tf-4C
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089157; x=1621625157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=XGnSRR4vmR22jB2GXpHsJCJzvW18rgALPw2f2DSavXY=;
 b=qLGunIXrxR3EjJgr8t6saQSqXsIP12tsA+56Jh0yk5ijeeK8oPJeuj/S
 jqa14jQZDcjPgQOlg3OQzA41I37KINDQDrlcXpt//N6bHDZ3I2B1sbuTL
 nQ2uI8uRgo3AUyB35LXjotWoyYuEOBIngO3pKtiupGz8c/htsjtyPpQpa o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:49 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:49 -0700
Received: from apsanexr02f.ap.qualcomm.com (10.85.0.29) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:49 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 apsanexr02f.ap.qualcomm.com (10.85.0.29) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwDINlJweBu0Gt44/tNzFp0RFIaWIZ9mKPqsBmAZlAkI1qaVt2RucuLsQQtxZZhaulgoV3WCyuwr3hKyK/b0NlrfqqvnaqmSIv3rTZiW5CzBUuFwQWdEOlpbNmNUtI9uIqPy2SldKlfwI9X6Ouy3HBfIj8rtobg6eFPTUCuixPCG9cNZCAL8onZYEqnll5dh9W8Oh24gwgugdnyfNqBWWpUxZQaq3udIjxoCT2FJA/VGJT1AdiOpuUVp2YmV4LuaeqILpxBUR3NEpy1LRXF7yfAoFfEe9/6uVlIxb95Su11AKk1Ragz/J8ekhpSXdg4x/8EiBdBPrdix5Wr1ZkUXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouHvgIuUI5dmd3UsJg6E5NVDAiU42BccCwSAhL4zDT8=;
 b=WdMEpPqBe7hdgwgArN/YIk9Zfn1RLUj5TYSYqKMdjteNdtr4jPM8UuF8ZXVoHsm1ZmBwCaVbfNxHX2dcf9u1qc025b9GduusOUelErPfLemviCdlG1Lp0WdrErCN3ZdNwCVGsRBzS76cTuFzYobkmptE0TkByHz+Fjo25PsDxlDVLNdCS9LJOQ7HMTK/yRaW7DYW8oVkZ2K6ApGQvE45KFRd9VyhD8sdJnCYvbyPkncvgiImPAoJsqHvhEmbDU2lLxHhZOoM6GI0Kbyj0SJEFoenWRM5/Tab9X5U88S/8zWVLBGfpfuNaouSro6hw3fqIvt+nAaqw7vgap6DgiLKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouHvgIuUI5dmd3UsJg6E5NVDAiU42BccCwSAhL4zDT8=;
 b=EOCVoTfbwncVDpMTWrGlCj59dMAU3yUtma33JNZcLawtb0/9dRdB1giZMhz9udFwdgLjdUCUHAvyE62rmFSvyDGxlw7RJIdSGlpPdZHf8UCYorg8iRSAm3cV3oeZ1ntebMLpQ8Y8XM702g6yogEdiYcWla98uUTG4eTNj3HuUrc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:42 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:42 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 14/22] sve2.risu: Add patterns for fp unary ops
 (predicated)
Date: Thu, 21 May 2020 12:25:03 -0700
Message-ID: <20200521192511.6623-15-steplong@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521192511.6623-1-steplong@quicinc.com>
References: <20200521192511.6623-1-steplong@quicinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (24.102.122.190) by
 MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Thu, 21 May 2020 19:25:41 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35cd1141-f997-41ac-1010-08d7fdbcc08f
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB36278D8B19BFBDE5FE7AC004C7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9S4WfEAzQRQygrjc7gl/AQTBAC3cytVfBnb/FfdBtqHIUra2kwMu83vbQwMJxlxjSQBV5MVtXeLaRwNsCxOpK+2unriG64eRKlf6l+xZTRHx/LFCnLdLBch/M6ZBbJqOORCIujmCrkQ3JhKOIt47N2EXMX2aaxb7z0BBblRDbeX7QJ/41uE2hBCiGbW3sjMyTKnQX3XmMH8nHtwtzfrSyNdw5vIogyDosllFmWc9azVqz0RrcYaWcrZ6QQeLBIUKYOHggVZ140/jkF+/YaN603Ry5bPduQ4zAU7e+wNMg57U9RzoRPZctL4VoJTcgqQleoarRxwPMH59ZvZr/01nxxEOMzvczLR9td3okQgUIqMS09y2ckluS9B10nN9i/GGO3fVQA1uowrU5pOzhkynYLNNBiUpLEB2cNlquSG37vINk7D3zWvnRCKr8sLL844m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(4744005)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eeExYpghdWC0nKe3jgo0oZo551Hg5mi+O6EKHuLDjbr/igcyvSf/of91dfTrUOiMJC1KXabluYJGjmjdImgNVZ93uI/1oQtb6OBLVgJpwq3sOq54k6ze6BwzFZ155EC0V365k9K2NMNy0oadGv10j+tgJWc1dB1oI83zykU5F38s0cS5Zh+2wCObN+KqjB79e3SIRj8d45Ilqdr2ZZEXHJFgTEjXmTfZk+fxWmzE2BM11N0RWPFHoc9JzUNAhfpDsPYNHN/AOmmYNDQMWQIoqavMFGEyK+knos6ht/LC9u7wB+0qbHGOO8OR35Ac5kODOabHCsqqYBQqm3qabcIVkXPjeOZssbWoh620OnQMEgID+1K6/8dO4OT/6FvAfiBoIeCSnTiFCJ07rxwxTW2yq8l1P4LME7ii0UIyWxdTIPyYBz8oYUTZnQ2Q9/m16VRvAZcgwHPJHntqLkuxRDu0dy2tJ60DkBC31C+iXKdJs5g=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cd1141-f997-41ac-1010-08d7fdbcc08f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:42.5762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RntbkREgPHvTpN+TKxvwQvBojSg+YjCUqXlieAoEVvS5892xapXRE8n0R7bpqVTKSB35rPZ2S/aMmGSB+UHTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3627
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 15:25:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 sve2.risu | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 313c5ac..48b2957 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -315,6 +315,13 @@ FCVTLT_HS   A64_V    01100100 10 0010 01 101 pg:3 zn:5 zd:5
 FCVTNT_DS   A64_V    01100100 11 0010 10 101 pg:3 zn:5 zd:5
 FCVTLT_SD   A64_V    01100100 11 0010 11 101 pg:3 zn:5 zd:5
 
+# Floating Point Unary Operations (Predicated)
+## floating-point convert precision
+FCVTX       A64_V    01100101 00 0010 10 101 pg:3 zn:5 zd:5
+## floating-point convert to integer
+FLOGB       A64_V    01100101 00 011 size:2 0101 p:3 zn:5 zd:5 \
+!constraints { $size != 0; }
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


