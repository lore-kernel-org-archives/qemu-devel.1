Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B85FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA15420814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lMYQ+NNP";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="jSoRFBAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA15420814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr4R-0006ZI-Vj
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpL-0006CS-3x
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:59 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25355)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpJ-0002U2-Od
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089157; x=1621625157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ZkDZPmlvX1MYNmZClEgxPbhL0G6of8vtuN/Wmg7RIAw=;
 b=lMYQ+NNPu2JCnBy8Aun4vWwTHsYWtvCNruLrfU5iPr31LnhZqZCR4IfG
 qAG3knfULBdNezKKHfy4pbfXD502BNsquI8q7/ydqJ8bYtU9KCUg6dVG6
 VKQQFHtn8ybCxUChRccy0FdVtvVtt5KfWXIH2ckSqQHkvF9JUxnnEuxmt 4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:53 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:53 -0700
Received: from eusanexr01a.eu.qualcomm.com (10.85.0.97) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:53 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 eusanexr01a.eu.qualcomm.com (10.85.0.97) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noMgt4SJh/h4zVvbDMF0Oq0yNG8O/Wz7sBc4s7rHcy7nb+8kotuANAXMSn/t4fIFGMNxsKmG7C3/yLIIn0ASv7ykrDo0QngAf9PnRMygAQGex7hHbFC/ouSTyJ9GS6IG6GgO9oQawZpKF64TrOa2bM5FJE1lJ9HD7eVAAAJMsZZqw+P4Bx7u8Kmz/KfKsz6T7zaFmNOJFsodSiEFgVEsk5uLNA778N4LIx7C1Lh4kIgTGPsk9SOp7Bg7HKLGGlhVOFarcsSSDg+9Y1pUB/bi0lIySRd/oWxaPu7TRCIOSCRgmj8y/gPQz1c7g0XOTlsHQetqX2/jTyENC40a9t8vmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjhWem7bmw7rsykWd8Fq1AhNF4PokMXwWDzoiBlnOrI=;
 b=j3NDF07ApOk/N6XOF3F4T/F9bfjBHRdM/QW95Zivw3bHGZ8nBJJZ1Ti7qjjvMeHhT7ws1JvtB5af5l+AaCrbtpn3UFKFy0OwUJy5ohkjKoNmlywpu7DoMerwnvlFPTjPRC8xcLJtk2LrjjvhbXk94xQu4tJayrguI0QQat1AIGSm+5cIydfgM0Mw+gKijOCbt7hfeHdiPagV2BqZQs+IpH9B6WZXjY1DuitJikITKToA62DtS/7BQOSsS2xdbe0/tvucjVmD7AAfEXqcCj22sEWXn2Zlh4KVw2rQfcRkpPhPnuToPAN5ICEwxr0yU249itJUoAEiqIoRKAsESiNquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjhWem7bmw7rsykWd8Fq1AhNF4PokMXwWDzoiBlnOrI=;
 b=jSoRFBAjADdvuONZH6K1GAXSJIAjlWyjxAAaC9WB4ZJVYBePXycw6MNXT6NHRGZdlRw/fK9cFkdnZXrqn1seJCOKXKTchvFanHT8AZu8mWpVm2dKtovcSkDqT4+52fgUi9UOiRt4WDEWtZUImkJdwqWPnWup55/RcrIRgVdva5o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:44 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:44 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 16/22] sve2.risu: Add patterns for integer
 multiply-add (unpredicated) ops
Date: Thu, 21 May 2020 12:25:05 -0700
Message-ID: <20200521192511.6623-17-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:43 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b709e37-0919-4cc9-0cb5-08d7fdbcc1b0
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB36275DAA976E21DF1F2A9F23C7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eJ1nUXU6lPMIXxv4CeuiHCbkl0q0s8gi64XmQ0/Kp1amfVdmSTGat/iku305ltpfraetmaE/yP5KATFda8gypqRXuGcug1pgQm6uLER/G+WTRuN6z/n1i+XUTOXCWJ6af82luRLYaOdV3AA4g4krU87g+RztZzbVeKOOPGPAERKAyM7fiooVtb5eG22CRGnP/B7dYV6nzbW/PrdiGne6AYD4kjSYPGOq9VOEv5vYBsk6vRqkJDIQ7FRBEKh+opOHJftK2bMtGX7duDZTO0e/C7mL7kYKTr8NadnhofmPZQErYLEkfwOAWlPyhhLpVvvCuUH4TTsr2v6X3p7sZ2wrH4CBEjgrZjVQQQqmIYoHc7R56cLkIYQ7hicGLzJXOtVORqQ8V+6FIsTFtGNk0BNtHmAGfk7mdZzYJJU9aBeL8NKPNSPrGhGsNCuanyxtIp0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Np1bNOdL8L8PhIlm89ankls+OQfGs43dhWiKeAlMMfDiDxWaBTkKy/GcxJQy7FJ0xKr1O26938NEa4Zezd/9HNEurPEQOOFLypMf66MbIxmr36gwBZSBHVONJiUHjlcEnp4OkhDjk/RlnmB73v/xSuTjfO9JAvhsyF3hX5kV2ga3JfPP5W+ydBAVENj0Gi5cnZazACilFnkxZOHf6nWYMtSh2VhcasvjpOzLy93YdCMryPdHJWiM9EEyfqw8QVt8UjVpcXtuaL0FdvhYsK34a3fe9sZUVeodXfD+ZRKoNn73fOvMcn9vMvr/LzcgzcE3KFl+6sW2c+1nBwz67VJr9dvpE1js2RJjOB7OVnVF2BBFvo77dOy6UNpbpGaYZn0+k+iguTbhG7DZs8kACkS7d+QtUyIS9WgkBfg39ozepviqLnBgVLG1twvIrkyqgiUg1epxU371Mw1xKgagxZkJC7+Q86D03Qns8DtuMWarepA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b709e37-0919-4cc9-0cb5-08d7fdbcc1b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:44.4332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29ByjW4J2hynx+KwElTBdVoP+mZ00GeNnieDmO/tVbXxV4ij25PVGQXFdBiwoHD0/N/mEONilW+CwRZxTPGDzg==
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
 sve2.risu | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index c48717b..8602059 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -25,6 +25,47 @@ URSHR       A64_V    00000100 tszh:2 00 1101 100 pg:3 tszl:2 imm3:3 zdn:5 \
 SQSHLU      A64_V    00000100 tszh:2 00 1111 100 pg:3 tszl:2 imm3:3 zdn:5 \
 !constraints { !($tszh == 0 && $tszl == 0); }
 
+# Integer Multiply-Add (Unpredicated)
+CDOT        A64_V    01000100 size:2 0 zm:5 0001 rot:2 zn:5 zda:5 \
+!constraints { $size > 1; }
+## saturating multiply-add interleaved long
+SQDMLALBT   A64_V    01000100 size:2 0 zm:5 00001 0 zn:5 zda:5 \
+!constraints { $size != 0; }
+SQDMLSLBT   A64_V    01000100 size:2 0 zm:5 00001 1 zn:5 zda:5 \
+!constraints { $size != 0; }
+## complex integer multiply-add
+CMLA        A64_V    01000100 size:2 0 zm:5 001 0 rot:2 zn:5 zda:5
+SQRDCMLAH   A64_V    01000100 size:2 0 zm:5 001 1 rot:2 zn:5 zda:5
+## integer multiply-add long
+SMLALB      A64_V    01000100 size:2 0 zm:5 010 000 zn:5 zda:5 \
+!constraints { $size != 0; }
+SMLALT      A64_V    01000100 size:2 0 zm:5 010 001 zn:5 zda:5 \
+!constraints { $size != 0; }
+UMLALB      A64_V    01000100 size:2 0 zm:5 010 010 zn:5 zda:5 \
+!constraints { $size != 0; }
+UMLALT      A64_V    01000100 size:2 0 zm:5 010 011 zn:5 zda:5 \
+!constraints { $size != 0; }
+SMLSLB      A64_V    01000100 size:2 0 zm:5 010 100 zn:5 zda:5 \
+!constraints { $size != 0; }
+SMLSLT      A64_V    01000100 size:2 0 zm:5 010 101 zn:5 zda:5 \
+!constraints { $size != 0; }
+UMLSLB      A64_V    01000100 size:2 0 zm:5 010 110 zn:5 zda:5 \
+!constraints { $size != 0; }
+UMLSLT      A64_V    01000100 size:2 0 zm:5 010 111 zn:5 zda:5 \
+!constraints { $size != 0; }
+## saturating multiply-add long
+SQDMLALB    A64_V    01000100 size:2 0 zm:5 0110 00 zn:5 zda:5 \
+!constraints { $size != 0; }
+SQDMLALT    A64_V    01000100 size:2 0 zm:5 0110 01 zn:5 zda:5 \
+!constraints { $size != 0; }
+SQDMLSLB    A64_V    01000100 size:2 0 zm:5 0110 10 zn:5 zda:5 \
+!constraints { $size != 0; }
+SQDMLSLT    A64_V    01000100 size:2 0 zm:5 0110 11 zn:5 zda:5 \
+!constraints { $size != 0; }
+## saturating multiply-add high
+SQRDMLAH    A64_V    01000100 size:2 0 zm:5 01110 0 zn:5 zda:5
+SQRDMLSH    A64_V    01000100 size:2 0 zm:5 01110 1 zn:5 zda:5
+
 # Integer Multiply (Unpredicated)
 ## integer multiply vectors (unpredicated)
 MUL         A64_V    00000100 size:2 1 zm:5 0110 00 zn:5 zd:5
-- 
2.25.1


