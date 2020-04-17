Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7B7C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF2E2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QM/kEcao";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="EqpN7q7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF2E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTn3-0003bA-0j
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 12:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jPTlb-00023p-F9
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jPTlX-0007gX-7m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:22:56 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:45089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jPTlW-0007fW-DM; Fri, 17 Apr 2020 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587140574; x=1618676574;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=W6t2EmTFpCfVcBriQ8uR6j5TYOVWPNCFRcm0s9wHxO4=;
 b=QM/kEcaoHDOAVBj8VOd9mXsv5lJTgNxdvWj4M3QtP80azpPZdSHCKrDC
 LqSRgcc00lR2I+ToBGl08cSHljcMu/pVxAKjYtdc/hYQVHp4TuT7zP3nG
 giQRnzaYCVSFBmUpcTgGS0kacXt1/w3FkAnw5DNf1qihRC2py4wsEIP98 0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Apr 2020 09:22:51 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 17 Apr 2020 09:22:51 -0700
Received: from APSANEXR01E.ap.qualcomm.com (10.85.0.38) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 09:22:51 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 APSANEXR01E.ap.qualcomm.com (10.85.0.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 09:22:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 17 Apr 2020 09:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu0HFkCpDK8lNgcMU6qqLm2xJ5yG2FlvuftsmunnL9MxYS2+lMrYEr05YDTY48LAN/VaN0KF+vtKoyz26Bic6ADvi5Svb/Et1MT6I4s9GWo1Pt44h8kRSKkr4t+B2B9e2ZXhJIPzvSUF+NDHatEaDuQMKtE4vOYXFPsnkaUDJdQfV/rzzqClezGXLlqPVmnzPjXSUQ79mzlcy4TgaNv0TBfLWiD19WqzpalA5X2svdK7vu6VstmvLBiT7U/iyjGh0LDSP18jXjXPXuxRt2/7OAbFseWI0LaUwyf7q5Vtm6wczFvr1SmSwPQFxI2aGVBmR07usTe90E9H0PhhYWOtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KnQRcrhrdSGXoTUZjFxucRT7Nr9L/n6sGUaL8SnRa0=;
 b=KrnvsicDRq/l4lgyfUSWGb6HlyPm/F3KQHOUG7y9Qd6zGsGxHXeo8cuGU32bip76+eC5fv/nHwHkHI6tj/wxtNKr9vFNZJW1amTcPdUZGuUbNCKyYM1RKUd3CEao9RWa4OJzDdhHgfzxKobEYpnu5iYdOIF9e9a82zru4LPupIwrFCOCJWas7xXUsVGsIdX8z3jOImL99uO/m8XfHOuMOkbmvhlU2OYLRiRlEEWApx3S90sOFF1iD4YQWMsLET2hZfD1XSCh2cc2HnvYwUjkahsRcYR3aw8t7UhDNXd9/Nu9405e2HO7a2DJZVh+oEvWA86WusQsauWNsnitekbZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KnQRcrhrdSGXoTUZjFxucRT7Nr9L/n6sGUaL8SnRa0=;
 b=EqpN7q7rO1Av2CVD2nWcJyThOOiG76wsIC7y1RRy6tSuurzJUGd16spNdpFPZ1UWMZFVyJDnQATKLOUawjlpzPEQejHuBSXCbeea9LNW6jmog1pk/fIQthWVvUHL2E+zLMH4PT3RVxGGW3JsY9aMZWacLLhuBSf7hyHIELveURc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 16:22:47 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.030; Fri, 17 Apr 2020
 16:22:47 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 0/4] target/arm: Implement last SVE2 narrowing section
Date: Fri, 17 Apr 2020 12:22:27 -0400
Message-ID: <20200417162231.10374-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:610:57::27) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:610:57::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 16:22:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef5113fb-fac5-4ce9-122a-08d7e2eb909b
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB348465933E6085C9D59851EAC7D90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(5660300002)(107886003)(4326008)(66946007)(66476007)(66556008)(6916009)(6486002)(478600001)(6512007)(6666004)(2906002)(36756003)(4744005)(186003)(16526019)(86362001)(956004)(1076003)(2616005)(316002)(8676002)(26005)(6506007)(52116002)(81156014)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZARQjLIbnmPP7e0PJoJaI6xfVApWFGkpJDK8kvrR+IU5/6aLhkv0SSFOZ4W5xC381aCVog0mWrCJcQQg/QBV5Fadw34BEAY0Gpuc01mZtXR/5x1HkifwbqDw0MsR6+oYnkIgASCWlWUM7H2BVWyJsRzglyKVAt76IMBXAr31yppwcyNltwzZzQzhV77p7kRdYw6vPtPAPGJRFOqytOw9UWiul6RR9pnlmJ9+eSmxcuUM74aoVyOOJyXUe97Y8srrLU6mkBM0Lh/Rsbc4zwyTFhb09wb/Ih5byjF9XILEsQjUbrlf2oXNYtkfeJv3/smIfoynWRV6jBxhNjt/OYrKvTxVeDqlBizzCvcpnuorElQlJ8FotfAWAUDDz5DrnG1+lt8KOMjezHOhQ9G80d4OKAlcTlx7y8Y8Pdcv575GYOxdZWlLaQKxo44skTuPZpW9
X-MS-Exchange-AntiSpam-MessageData: VRBviKGSvZjTBbO3+D7bleRt2SVNpJH1pN6bAuceKEJJXo7KmWqTuA4MK6AVuQbUXBZuSm2AhBIyQG3Qq+cGn6DSZxz7hwYJh39igjicxAtz74xunM524PEooH5oGQjihGfc7JBmQtiu7c0as1NFKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5113fb-fac5-4ce9-122a-08d7e2eb909b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:22:47.0426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyH48sYGXlX0DMpncdv8WBHRgq/qS4AwfdK/BpqiDf2QqbdeMgtEIeGR2vlAwi7cLM1PNLwv000Ee2f25ZNwgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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

Submitting patches for the section 'SVE2 integer add/subtract narrow
high part' for early review.

Stephen Long (4):
  target/arm: Implement SVE2 ADDHNB, ADDHNT
  target/arm: Implement SVE2 RADDHNB, RADDHNT
  target/arm: Implement SVE2 SUBHNB, SUBHNT
  target/arm: Implement SVE2 RSUBHNB, RSUBHNT

 target/arm/helper-sve.h    | 32 ++++++++++++++++++
 target/arm/sve.decode      | 11 +++++++
 target/arm/sve_helper.c    | 66 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 20 ++++++++++++
 4 files changed, 129 insertions(+)

-- 
2.17.1


