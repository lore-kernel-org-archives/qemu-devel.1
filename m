Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B7CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AB2204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HMEA9g7j";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Hbpgwl8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AB2204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr2A-0001gH-7s
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpF-0005vC-Hg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:53 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18872)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpE-0002P8-Dw
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089152; x=1621625152;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=tsN2qg3EFu25DfMvMYAx/XALgKVMjM1xH7YCJZSpbFo=;
 b=HMEA9g7jIJFylbR97/5/QtrYcX4SaxqaPFWXbbLpMjdvL/lIu78YsLuR
 UPdSH3XqqjTDIkuHaXMZdt6CNdQYLzk975Q8dNnwm2mU8a9z1X/4L6vpJ
 ISggubuXLww9hEvLCy6YKIZenOTJYyJw99tYJ2+QV3aJ1G1glJcx0gj0R k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:51 -0700
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:51 -0700
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:50 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwGsoXvNtyNA3+aRw95BMdqw6LOUoQDvxQYOkwurnQ3K6XQPPIvS7KKlJ5P/VXkg4dQberrGcB48XK7lQr00F95wwlVEf5xSP8va3lWQttMjfpuS3+eF1qvHAp+IgydizBmNZ40z3bVsQtart6GPhbqG5DMPYLXEKm/S4zODkN85XOWHnBPrVNjXIT1uYEkr3ATPhrdzzblJwpr3uOECYQRDokqCdSP51iPoC8jbdOAIAJXi1QcjEdxWw36TqUvY0qLoTAUIJy2ax6e04+TtlEx2rIQLbfY5lD94BtJBCo7xWJSukH4i14bCKkIfAJK5A7jUe8/oeibwaFNnnDUCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc+joUiLwYZ/WIo7daEX45xW7JhEWfRdiKIYIJgVGYg=;
 b=gb40/4s/XMTZBFY3YHYPbKTQb/aQGpPn7xfU94z7X2sAQK4T2WvAxdQ3g7QFd9nt5kzScfbvE4hC+5sdcRKmxswVQCg4hTjicawaYh9z9JCywgGXlD0yvCmsiTkct3G24Af3nX6Yzgqhn/TD4vMEuVAiUUYHTCENMnB8Bx10CyPDPlqHZPu01kxt7Ua/ZJKUvns/Fqjz8MhDl0rc0ET2yzVyzyABwrMd6M95jNqlwDrwa34KKnQXg5ahn2uKGvoEeltAu+uO2UD/hkmdcSS2SZhIu45zhjNtz2PTi3W4q1UGAn4IwdR7O446CkLBQL0Ka0qv06j8SQECwNwjpWRuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc+joUiLwYZ/WIo7daEX45xW7JhEWfRdiKIYIJgVGYg=;
 b=Hbpgwl8UwIY56cFg5VDyGMY50iZMIT6tCguZD2LZc3Vy9YucPQRTh1pXL1Jqn3Cm6j2tPLxCmukR/Rd3/VTW9LOZnzXm66dTKyFcT5YJN6L5QxOG3Du7RftRrHgZ59Ry09BsZ+FIfW/lbZ/urGZ1TCdg1//7CHktx8rULdTOS0Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:47 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:46 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 18/22] sve2.risu: Add patterns for permute vector ops
Date: Thu, 21 May 2020 12:25:07 -0700
Message-ID: <20200521192511.6623-19-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:46 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b0b2f1-f6bc-447f-86ba-08d7fdbcc313
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34843F7E63A8179303F1EC78C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTg/gvi6aMzq/7URCSS98vns3Fu+maTkYKD9L1X4CZSf7Q/PhBYbvobbK38S0tlzuhVA4yof+O5wZukgoSIZ5Uiem7LZjtBRunjqzxkf2QyIVaOsWnd1LuzSBy2XuoUZsqhUWUGAJra/35o6/0WDWLD8mOQR7JOKgpPRkUGS4YQRTjg+PKLQX6bMI6qsOqlziWk1ANvBlvoWcqdcKFx0Zppzv8lmtdU8wASi5mLke2/LJ13/c4i/C/OqQ1hRR3UVNl/m1V2+Xr7RiCdOsGFOVGnOJxoFxcMopu7TJvjjE96O9OVcCLSOiv8r4k1OihRi66ODsSyGLsZ9rY9egxTVtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(4744005)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7g9mfx5eExvTMGwtkV80+2c44+FbslnkF40HgSHsa38J5mI/OmKCEH4DAAtlEROSP79p2fWyz3ttPfd2IIxo8uvbdGuqdKorbpLZHHo9n+Grw/8q/Fd83UDNNdCi1XS6SKX98dCoFgNmBsJX8yU7P16IQjC8ewT1R5kt3jHxP2wHLL6VZT86gyvhOynYpn+heo0smAxQxjmVKbsvr28dzIQpMPPtBZiOPsiVB7ZiGjKxK7Co6qCiViW4I8psa6tnZ46aSeVh4sAYVxGSY5QiKBuXNWDfzfKXeVWffeCVhdmKCIHyo43NfJHzxNbioEHNlFFCmEU81tfAxwDKGYgi2ULLT4IkTOAbloZRs7OJyzNTSuZCu6m0mkh2UAGv36ApSJP7BZpgZKPB9vmMX4OZy3H6gGgQVkUMb3uTpQVSQ4eD3zKbIax+rnJ6oDoS3Z+Tcd6lvJKsrU4GOHRsMRvpHW2X9Pb3Ox4l6v98A4GLzVk=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b0b2f1-f6bc-447f-86ba-08d7fdbcc313
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:46.9527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4Do805uBYFIt4qFmbHkiuVC470fGgC58xAkJqUpYFFGqT3fVhoo75udAhilpwdp1dI56TFNbHhRyKHktt6rQw==
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
index 1bcbd93..7f70bfa 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -1,6 +1,12 @@
 # Input file for risugen defining AArch64 SVE2 instructions
 .mode arm.aarch64
 
+# Permute Vector (Predicated) Constructive
+SLICE       A64_V    00000101 size:2 101101100 pg:3 zn:5 zd:5
+
+# Permute Vector (Extract) Constructive
+EXT         A64_V    00000101011 imm8h:5 000 imm8l:3 zn:5 zd:5
+
 # Bitwise Logical (Unpredicated)
 XAR         A64_V    00000100 tszh:2 1 tszl:2 imm3:3 001101 zm:5 zdn:5 \
 !constraints { !($tszh == 0 && $tszl == 0); }
-- 
2.25.1


