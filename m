Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E9A207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b1GTuDJ5";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="eOxR/AUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E9A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqwR-0004cV-AB
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp2-0005UQ-Hv
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:40 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46189)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp1-0002N6-AI
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089139; x=1621625139;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=fUDDpifECHpgTV/f27IxUWgCV1J0ZzGhBFz2mTygQyI=;
 b=b1GTuDJ52/oCF3/kJS+CMuFu2xtdIekf3VlcL20AU+YRRYj5CtV3Zt6w
 QVAAxNQGnF+tjfDtQqRNnC3l/QtQ7bMoeD71va67KZYlxNFO1wnyHSaZs
 bH9iwpTOp5pUuvuqeVO7ZJfe6Yn7+OsXpwE3OHeIBf2s3Vk5iBQaFqP2M Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:38 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:38 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeVSD7z/V9LdSFjBhXzKEmwbzaIOhBIqvSy1lpaj6G+JGrCk78nQk+6LqHHabputq/S2+o7I6K6tp2Ll+7jqgGJUyMCYgZASug9LXEBrlzmvrmsz3a3lGz4161oolchXGAe38uoUTVaak3V5I/8Av8frHBeaj543K3ve/HqyhrFIq7hi6w6iYKQTN67MNJpxUTg/xsEDg0/Zkk3JuoIU0RZcPo9/bH0mXYACpanS2/AZ2AWzLRxKR/fVC7ijlMxwtRUMB+UC4u4IvZ76tYpD6tI3+LIy6Jm8JW/f0afIbgdTWQ1yxAYrxilq8Ii0SpWObR7tXo9aoSYtqIUUH+aRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEj+hBi1aLodbsohYWdJShd2WpBmvtMJ+MBfpyWwylE=;
 b=aRrkLEpe89vnOVzDtbvRj/QzGETiHAwvve50bWZl5lEfy+YCJn/hQpndr9dG+f75EdpW0RBRvIpBH0o36SlQMQKvGuRPv/1Hqjzv/nGAZJJvwpsl0oxqOLTssc3qYPKU1IPA6V6JQgCRMIpZhDSstJwMb6leDQxA0izjJWSnMfSbbMMx/7sjuovYoxqo2qVj6QFH0SZ4OR8mGXTFTI8yt3fYvOlg/zsMtB/Lzs9Ng0IZ5Nos4AHUk6eaSfsg48Te3U9Ot4mDl1rsk2ZgMPtCtB9sXbIKeEZDTaPUAMuLDen8bPtydFA0XS3+NTexbZoG+FB1USay5Vc+LWLpAE3Glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEj+hBi1aLodbsohYWdJShd2WpBmvtMJ+MBfpyWwylE=;
 b=eOxR/AUZmKWXcEzimeP4TilhiZtAG89/uAvSS4tknHRMaf506Zwqo9rN7skb9M6HXx05ufcQoLpHfdGDDCzN5bdqg6lvvLDWp9SSoI/cSxeiQuLx/q5OCYm7WFo/zXXLpNYmijcQWMyGO/DK33bSKC9TCik0xVoEymmd35Ta1Us=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:34 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:34 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 06/22] sve2.risu: Add patterns for accumulate ops
Date: Thu, 21 May 2020 12:24:55 -0700
Message-ID: <20200521192511.6623-7-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c294e5f3-ec25-42d3-ccea-08d7fdbcbb77
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484A30EC87D7A33CB283A19C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csC7Wc1wnQ6enVIlwaXrn1PnZ2Uq2zUiT1Zvv3Ui7y2HaKhHnPewHhR5crt7OASvqI+oSZ5VEHB7l1bbs6oVu2zx0QG+zlkXPXVDCan5sbAsiuNSRHuPclb6OYB/VHKH/1ObnShniygqXWcEKjxdbPwM5cQtXm0Ms/ep+hWP5Qbk4VPN0k0Yf7BO4Ry1D53mPGyhPWlb6A8Xm6/pj0IeC3yQ/ICWwtZqjMIRPEPoLlEYTguC8KR91JizRfzDBk3qLxM2CtpHDHzAaLTRuY8GR6jtekXIev1gCTeVtkJat6NPB3g4E/N2U6UdP27bAU1YaGn4hpqqqrsaCGG4Z1hjXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rzAMaME6qtHEOuNyFH+AUvnh8/09m6tsUI2Tuvf+g2lPDFQgCKZQyUpcVN0cPajTY6PievUZdLz6ZMcEGYdnDKfuPyl1ig+vfBnMJ9Xc8VbZYrBbiEYUpBt7F44+PfNS9yHE1FQTyGaPcO5pcyaXdhL9j4S2RQJziHAgSJcaswKNcTRRsyGVuGILHXOJZXRHbCMkf+w8Patyp5cpT2eO75y/t768GdTjYiOO1PdK9QGHmozQF1SHhhA7HTwDuDbiBMAGuQnRs7+DPpquTLgNgnC6t6ZR5MTpggl8Tz9P8zMd3DBCoANbHoXsTX+jcbGY4QZfejseZe0yAxiM2wO2ktY5g/PjQeL9XHYIFGgBXRhK9FdcYWOzBzUCUOCRNp/c4Zkz9cMpSi0nU2S5prxZczb5hIeyip4OXMbXE2wU0zCrie9gc5QyIPeGU8Uc30QGo6/4p0R2Vt1tQ51xEcZJ1LoGaq34uOkNHlSB3uXIeok=
X-MS-Exchange-CrossTenant-Network-Message-Id: c294e5f3-ec25-42d3-ccea-08d7fdbcbb77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:33.9912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E71D3m/GgwdOtJz8ZjndjsXS3eXHAfQEa9US8v/o/JbsW222Wkz66WB/Xq8fWnlF0E+/qWZOQ0DNVS3oN2iMKg==
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
 sve2.risu | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index ca14193..caca5c0 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -148,6 +148,42 @@ BEXT        A64_V    01000101 size:2 0 zm:5 1011 00 zn:5 zd:5
 BDEP        A64_V    01000101 size:2 0 zm:5 1011 01 zn:5 zd:5
 BGRP        A64_V    01000101 size:2 0 zm:5 1011 10 zn:5 zd:5
 
+# Accumulate
+## complex integer add
+CADD        A64_V    01000101 size:2 00000 0 11011 rot:1 zm:5 zdn:5
+SQCADD      A64_V    01000101 size:2 00000 1 11011 rot:1 zm:5 zdn:5
+## integer absolute difference and accumulate long
+SABALB      A64_V    01000101 size:2 0 zm:5 1100 00 zn:5 zda:5 \
+!constraints { $size != 0; }
+SABALT      A64_V    01000101 size:2 0 zm:5 1100 01 zn:5 zda:5 \
+!constraints { $size != 0; }
+UABALB      A64_V    01000101 size:2 0 zm:5 1100 10 zn:5 zda:5 \
+!constraints { $size != 0; }
+UABALT      A64_V    01000101 size:2 0 zm:5 1100 11 zn:5 zda:5 \
+!constraints { $size != 0; }
+## integer add/subtract long with carry
+ADCLB       A64_V    01000101 0 size:1 0 zm:5 11010 0 zn:5 zda:5
+ADCLT       A64_V    01000101 0 size:1 0 zm:5 11010 1 zn:5 zda:5
+SBCLB       A64_V    01000101 1 size:1 0 zm:5 11010 0 zn:5 zda:5
+SBCLT       A64_V    01000101 1 size:1 0 zm:5 11010 1 zn:5 zda:5
+## bitwise shift right and accumulate
+SSRA        A64_V    01000101 tszh:2 0 tszl:2 imm3:3 1110 00 zn:5 zda:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+USRA        A64_V    01000101 tszh:2 0 tszl:2 imm3:3 1110 01 zn:5 zda:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SRSRA       A64_V    01000101 tszh:2 0 tszl:2 imm3:3 1110 10 zn:5 zda:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+URSRA       A64_V    01000101 tszh:2 0 tszl:2 imm3:3 1110 11 zn:5 zda:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+## bitwise shift and insert
+SRI         A64_V    01000101 tszh:2 0 tszl:2 imm3:3 11110 0 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SLI         A64_V    01000101 tszh:2 0 tszl:2 imm3:3 11110 1 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+## integer absolute difference and accumulate
+SABA        A64_V    01000101 size:2 0 zm:5 11111 0 zn:5 zda:5
+UABA        A64_V    01000101 size:2 0 zm:5 11111 1 zn:5 zda:5
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


