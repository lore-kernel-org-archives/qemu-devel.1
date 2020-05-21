Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A04C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AB420814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fisdkMY1";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="fVMKKdbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AB420814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqyV-0001KH-40
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp3-0005Ym-RB
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:41 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46189)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp2-0002N6-P0
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089140; x=1621625140;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=2J/r4tFefwexaSMSiiW+Yoidg+ypFaITfTahdhEWnec=;
 b=fisdkMY13fmHbyEx9crN8SNPZOlEcs1GQ3ecbAjbz3IhCOWVUTI1OIBe
 7jPy01B/yhdGdlrfgB6kmOZjYmffAhstFc+NIb8vF3PvCWyzkOXUzN1YI
 azotUvl7PCNr9GaCpC5f2gbbhfmsbY2ijz9+QzUMEShFq6NHmX0MHo+7C I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:39 -0700
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:39 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3qn8zVOIqh7TvZ//WopPgbtK1OUYZi8fmn/CEqAyzux0uZL+ic7Bq5tDsEbY8g8XSLqlBTZL0cyqRFxc5P/UybhsMqFUTI1P9f0+nddxCt7ZLtUHv7z1qw5sk8qyjj7tMe4+/DzplyBvB0iRNiXhdGE1VzUQDDM1Mw7zhfTEQy29xkg8fjtiCsOZFgyHScCIyQNcqxRcCl1RUVgtDHjih31fjWiHLGjMp210CeE9XSPfluzKMPH8Yq6XdjVeLFXjBb/J+5YRFv3TQG9HYP56Ko4+TcLAfHq0oIr/V8AZi4crbOFSSXTa+vmaaKYg/6KQarS7k/CfudoEvL3ZN/5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QSPt61nARfEQGRktlyUGCZ1OLZhpsTBHVTHmRzpA+Y=;
 b=aQSLt4FrekuUzvHZIzdNTmw4mk1i/ox+8cIBBOupwVMKWhuH8A55hZsTKei4BvjAELd/iP4EOUhUpKZaG21O9drSWkM4QQqV1jM9Y6o9fD01ngpRwrDdp1586mNEalu0z299SWfaDhQVlrwuYzJzeeqI20qL+0m625ebJiN+LVtWHcOTIURCgaZa8JYj5asJ75baPX6p6XqfIu6TtFCFCK974kNtjt70dEI/7sbyWW438e8C78Io8i9RIN0nht1e8JEasyM0Q/c5aGXtZl9TiMtDmpZugEGyKSiydzAs8rTFd9uY4PTknaBeU8sZcg7eYQGmQG5aOQUewxMIz9FD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QSPt61nARfEQGRktlyUGCZ1OLZhpsTBHVTHmRzpA+Y=;
 b=fVMKKdbPrJNMmse3MKZtu+BBzcHgoFZMt3V4XexAAyjYlYm3T/od4XDsDwqtUwSiShwm7J3iaX6h3TN9t+fCFt9k13fVhkV0K3OgBcIz7NDgtmPFsQ8SOBSPXs2zqv+fTF0xyg9Mm1C1BdC4jrO81A+hNFY8pnDs5sp6p57aRtM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:36 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:36 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 08/22] sve2.risu: Add patterns for character match
 insns
Date: Thu, 21 May 2020 12:24:57 -0700
Message-ID: <20200521192511.6623-9-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:35 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5feb6f0-4a9e-40d1-35bc-08d7fdbcbc9d
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34847DFE85396557A2D3CF69C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jt6Gv8P0gfu1Xs1/ho/okIEqI6ZKAhliMJQxYSy1J72NM+vr4inp488BpqvVY616qr1dDCFJUVMnbhSdAgzEKa401SynYPelc/zrc3YVFSG9hMZ0KDQ+SyP3RXuzcqIlAqCGHSEilsvP1lClYqh45BVevg0GZeDQsg25FblwHKGy3EbVkyABoWDTKuu7aPAVV2gQ4CH4IasqhCkKrjIsYG5MqK1WCOeJfemdKF1bIxYjMiTe27TvwtI/VL2pFRkqaKh7fDPbaNFFqg/lvEQiuL1+aRubtqonooNi3qHiSvRiIX9ePn/e+7hpC00Q87RIS1pR55zNM/1CsKPZYUOyPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(4744005)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0BGmBQN7QOGbWeclyUPHZSmaf4uDpD2W8Tf241na4KaigAwvNQzwKOpk/hOsOSI1bzY/LYfn8tBJ7lF08tzvIs84DLrb90nncQEEkFmrGcolCQELFU43Cc29UmrrWsNqbqQ9YYT+mvzOmZO4bN5k5pg0ZWPAsopaMIGbGDLImn5WFJbssqO+dW/CnFhhJXwxN8NhID9jgYi2wmuX3kKlrlI1g37N2RShpcikbFzQviPpSuLcCte27rh+dSRvc/hZS0gYLM4RXIpP1aUzyG1zXJ9eQjDCvWPIbFb6n42OPkyhG7M4wi07zR9rGrx0qgdXq89g4Y8slV7IeWQxHr/0L0NcZKdFFCE/jzTy0OxqHbDBDLcPHNlRvHiLywIOuNgNDteST3paqVlrKU3lM+xOrJb10j8fje+FnjT5GObGzZ7L6OVu3d2PNwEQb2Y8ETvPZeYjzpR09vdvjFdfjiDji9kPVZIz/HGgqm6ptOsos0k=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5feb6f0-4a9e-40d1-35bc-08d7fdbcbc9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:35.9481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILPS4cFov8otRQK5jYe/oM8LQ5lj7FPE0ziFZhilMVNm/F8En9JVd/Du/P4VVUt1JI4FBrUFr8I2XB1JiPmHhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 15:25:32
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
 sve2.risu | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 1ebb08c..5bd515c 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -260,6 +260,12 @@ RSUBHNB     A64_V    01000101 size:2 1 zm:5 011 110 zn:5 zd:5 \
 RSUBHNT     A64_V    01000101 size:2 1 zm:5 011 111 zn:5 zd:5 \
 !constraints { $size != 0; }
 
+# Character Match
+MATCH       A64_V    01000101 size:2 1 zm:5 100 pg:3 zn:5 0 pd:4 \
+!constraints { $size < 2; }
+NMATCH      A64_V    01000101 size:2 1 zm:5 100 pg:3 zn:5 1 pd:4 \
+!constraints { $size < 2; }
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


