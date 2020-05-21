Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D341B20814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gVqA7j+x";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="HtC94oYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D341B20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr6l-0004Gr-2a
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpI-00063w-7S
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:56 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25353)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpH-0002Tt-2W
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089155; x=1621625155;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=b6We2hnkey+QZ7ys9HA4oUpEP2xppHtjiqaHxLRbWro=;
 b=gVqA7j+x4kHOZVCwUhVfy2ZQ3Mu0p+Ghkrj7uvH0Io7oi2AMTfUw5Fj+
 Vh5TAketCDsb+1JUA/Vb4POL9j5g68jecMLVUSVTz9212Qttadh/e0kDa
 fhAFLkOx7u95e+R4DeVf3t5dSd5Zb6nQWeW4+76KecTkGiQQiLP6IHUIY E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:33 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:33 -0700
Received: from eusanexr01b.eu.qualcomm.com (10.85.0.99) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:33 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 eusanexr01b.eu.qualcomm.com (10.85.0.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/iOzYayexGeVydKRTbUqfdMmuqmbuKRVUSi99yu5ofBn/UcsXH1nNx4zdObE6LlTS6+yS9EueNY+slfik1XXYiol/rvW4dzzrJPPZsbSsxj48awCSJmLP6sC/DMFARxDYWfax/cjfzRXREpsFfqBAVR5eRGjFPl2Vjon7jxRmA0o8olDbgfHpK8udzAHAuxESr24gt7Yppqr6vwObnfmBmP3MljX4aNe5bwgp7tY01YClC96CulTy88C67+KeXABPLMQQSAHQt0R9NSywmJ1s/yfE6zDXurvBBQgYW+qfSNShSAVrvSvSKgb1Wbba4nLPD3esNPbtxS5S8f+0COzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LsoJkk7M7JF3hMOS/CJjv/4ra3LeeOL5hQjHFPXC7A=;
 b=klchdF+6lWPQEg1x5W60rOXfRwOh8qKAHckty6b2WQ7YYnh2rUHu09+D7Q8CrmR5hLbOeN49HWNQCOs0e2WWvXpIIBTpmGe6lhvssH3sQ7uy8klUJBfmNvqCFzcbM1r67NG7jO9/FiqhqA2mFNAyY2d6TudT58M3q6g1rRYSxkQvdVls8etd+sRfcnLLeL1lxqoJUGddFWs6QL4adW7xWODUgyHHYUZHZYC+CssmqsA2/ERefdoi3nY0rHvBdFNRsfWHiwsS6hYxVffqXKftBXue+MCEnD2xXQuphhTDnb+jxer48gJlA7aKHhmNFYwJ65/tYw4vLjHqbSKLnXLAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LsoJkk7M7JF3hMOS/CJjv/4ra3LeeOL5hQjHFPXC7A=;
 b=HtC94oYYqTaewLiSzHXtUKFpHdhcJwFd5hJvdn5u3TobPC8/P1m3TEmOMQkUvAUU778uFBLKVYkO9JeKovkr57psaZhHqcdho+Yu3SRBx0/LG/g4MyYg55cmf0l/HeIpSWWzA86LrzwRrze8eXZoqEuKVWuaItLJ5YE9kGiwJDk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:29 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:29 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 01/22] sve2.risu: Add patterns for floating-point
 pairwise ops
Date: Thu, 21 May 2020 12:24:50 -0700
Message-ID: <20200521192511.6623-2-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:27 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f14a96e-3917-4ba2-d3cd-08d7fdbcb7c7
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3627692926C43D3047313D43C7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exPnz0bF8SrkS82nHKGhKUK6EsL4bkTQJst5U4ql+sr26RvhLacdBFKovlH8N0o2SwwmTvIptzbYVwJKF2B1HYPbMVrzVMNSjt6zy4c7hmpBNc1lArApXTyt/HFf6Yyp4OgWNGlZgKNEViEfYV/AwEKbY+RfzcxD0wjZALisYi5PTN647/4wK8SOFBtUAMyvrT25sJqbYghQHa/R7IIcfX6Us7aQw9owPfvQqI9bJLB19vtiI3OzbnJvxeMM1pguqjvUpmODhqfh1oB0rUzcfm+NVFSNPanzsQ4h1ulZ5RHsmNp9PrJsPh/e+QD1Y2QcGo3M35KxJwWqwM9uIb1gRseXTpgag1tzjZQvIafLhtZYBlNLGh11oyypNQhe+476si411N5JQTLAzb8b/0EVwLgwYfCMf4YeDZgKc2f1BHj9oYS9skxdXAjlqrn5L9+w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(4744005)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XxSeZystA9i4IO3Gjz1Y9R9jBjnOVE32ZqLcL1ZXcbaLQ/4oZX84CvbxaABcobVRAa6km8q64yk1XPJAxJ9MKeL2sVX8odmMN4PUo+vYvDOpfVGjBFeiD3qTmG+vUmmRanm6p2PLWJeXv5roNh7pEtV/8oer05Qc4+j1gjf+8IkYCq8DRfd68VNMSQ2XtJNyM65FCJgrI+FXHOneTuNlsZJTRO1kwHyRdZa2t+0EW97kyomE9zCE5LiD3Q+AQaqkyeuaofZ4SWmowJeUdvPjGJCDD1bL1tgrhFwrXOiC2u0Ey42R8xQzhFTv48tsu/m4Worf3uY8DCqISQEitt+ErMf4n6QkwXWHOAgxOoLnH1HNc+Wht0GH1hPyhGnMK8iU3Zbk40EoJ1ErDwE4Y2Vg6e1vc/Htg0/22WN/zc8mF/NXmtOTBYFD5g6jcDhTOqvS5QFgVXF9rNJc0fNe5DS2ypHLh4Ef10Y6ibxz/IHBcQs=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f14a96e-3917-4ba2-d3cd-08d7fdbcb7c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:28.2995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJgPMEN+o9OvouXsmWpeOJtx3ZKjbQmWaeVQpz2jv1EcL3iTg9lYmybOIy0/AgTb28s0RhSJ2PxPVHnW75iWSw==
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
 sve2.risu | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100755 sve2.risu

diff --git a/sve2.risu b/sve2.risu
new file mode 100755
index 0000000..78debd9
--- /dev/null
+++ b/sve2.risu
@@ -0,0 +1,14 @@
+# Input file for risugen defining AArch64 SVE2 instructions
+.mode arm.aarch64
+
+# Floating Point Pairwise
+FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
+FMAXNMP     A64_V    01100100 size:2 010 100 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
+FMINNMP     A64_V    01100100 size:2 010 101 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
+FMAXP       A64_V    01100100 size:2 010 110 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
+FMINP       A64_V    01100100 size:2 010 111 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
-- 
2.25.1


