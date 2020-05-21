Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C93C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73530204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZrupsA/m";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="I6mlBLwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73530204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr2m-0002jn-MN
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpJ-00067Z-Gr
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:57 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25355)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpI-0002U2-5l
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089156; x=1621625156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=hQ+fheug3GsTsQ9/d6NDhWwqJsLS5GBaq2ESKA8MHo0=;
 b=ZrupsA/mQ9OCJq3Bh5jmQ47Tc63tinltKP42z+ZVFf3hIP4n8U2O9exb
 KpuIR1+fZFGFFKj3XxW0+lBCM6mK+GTG+H5QJHcGxEzjUj45XjzndX8bh
 CQk6/k6dbOsVEtmgmax8zc0poGuziXGwgWuzn6EMbeNQy2egYF0ecgvfy Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:38 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:37 -0700
Received: from eusanexr01f.eu.qualcomm.com (10.85.0.101) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:37 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 eusanexr01f.eu.qualcomm.com (10.85.0.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h47tvlI7HrO3tOGZZ3rjVRgAT1J7BLwj/+lxWuMtCJo7aOfOY4AU+H1cKxPir6ByB4BISnJ1FnXpMZxLKHQaUVgCF9mm31RVvVHIAuQB6B3o9HpnYcO0vfDTLSg5hkVxApk+pT9WVQUufjN+rOKZMQ3G6D1pc2FEEwS1HrGVMQ4AL1GtE1CcF/B50LaGwthek/BoH2SFGF6YTn7AdEk52r+7l9Wv6FvZE46xyr6Xm4MXqYpwIAgMhrTWGjOi5BwqSizHBbu1id2GP+U06WY0/fbLXoBuaXocaA8u0h2xhrvCT+j1yUSfT8xSMjAi5Rf5PloBDt0RVm1Bxx5CRv4z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nAyxR7XClGlY9h50NgMMk6SmXhWkd3o4RIj5ixGhyM=;
 b=d/PYsF/R5C111cFRkSOzjFDGcN/zWNz5bwb6bSRSkzLpW3FEUHj4f3g0dt3W7weyV5WwYtF4kRCexOyiuedr2p7MTZvA03uvQZgvqR6ffhMPOydI62bXjbPGQ6frxs48F7nM6938qqnRaDG/mUSbViV2cv2MmEtaW0Ux58a5L9Ze2xudtooELC5Js5LiZ7WFCofXApecMY5RR1TfGOOxk6RcW3gHXmixq08cP6A+0Npro/zLc86aAfg2Ez8yEPAiAaPReD0pp4aljOohUOCNFQ0b0/UNGxZoeehXohQm7wrZZGqcfCthsIY9Ll5teeF1XDFyujc0zpW/UNkKGN8Efw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nAyxR7XClGlY9h50NgMMk6SmXhWkd3o4RIj5ixGhyM=;
 b=I6mlBLwi1+YHXy7/9zgvHBQ8nYWU2IdtKU8wgnK6QPL8UgGJRX//hpODaOEK4h8/cZT1RQIYl4qOxPIvc8gZz71sWhNg6CtfypEHoxj2XpDsVEpM3ZKjZa/E1VXv9OPxFpRd8EH7eCiz6yQvL+3c37TywTiEAynekpZbOxmTdl0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:33 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:33 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 05/22] sve2.risu: Add patterns for misc ops
Date: Thu, 21 May 2020 12:24:54 -0700
Message-ID: <20200521192511.6623-6-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:32 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 032db59b-a928-4378-f030-08d7fdbcbaf6
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB348495DE50431209F312ED18C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqmEs7u49EbOYcImSOM7iAE/0l+FaSvGO3jHxQuNzGaySHl7JJaR5QkDpfADrEvA+VtA4Z+0mL2neny0sr9HXgTXdf88FScAWvugKp7D0NX6qfwzhyBSccOcDdlS3+7R378HCzgcJbUupyJPvUDa84UkNM+AeCrg9ee4KMDlRbJ5JebmIahQqBdJ9Pd5SaQr/mOrY/Qd+CU6UtYcqaZj3vrojItPjO2D6iqwew+EmAQ6QtJgqGSphV6SJy7oFI8kg8L0XpAw4bNjBvx6DZ2ixBIEb/uJM66G3jkRfZMDbpfwyyKdns+si3L0YGB1oFcD+cL47edB/obMUvWCy+tQQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5lKUEZ48xX4kR+tTj4X1HLjAo1BQneSeC/mahORUeb1NuxydPbf5EVnEjR8ZKDLiAFGG80+vbYybYBepbYiv1U3a6rhKfikL7pMwScYiT6hZ+mHIBNUiKF26rPdXn0TlZ+vBZvow3/FJiNI2tR/GGNZB5cNjYy+x3qo09N9pFYx9nEniOWEg6V9dLUbHDgF+zMH3YoWX0ZkOkyCileJzsOsJ8H7gyqlGYxuoK3BWC0BcP4Bv+vcyZP2Hi6G1oaDdla9sAgji1rtVbtHLOtVHEGBJbMSEeYtK6nFIaDoYgbrIjcYKjHPt9W1WQREXl4+QPgLwvvki0Lk8AuYlgoqodYUV5rDXBPtS/Ewe4FdpJZ6JSB4hZZMTdJlqRfHWOe0vSLq9Ktc0cCwaKFCikv2oBGuoA6e1SDm/aZkMfoAGlHd8xtC2yjJlUeWhXbUxxEXxlE9qEB/TXkcoLgnix8uTRJDIDvnWIGjnV0yYYheKQ84=
X-MS-Exchange-CrossTenant-Network-Message-Id: 032db59b-a928-4378-f030-08d7fdbcbaf6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:33.1417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR7OIGFlO+j1cCXvk3xy2IjcLfSXDh73R6gm2AcqW0NazhwT2TfyZKCfYwHF5MPHpDfcB7KtvRNyiFSbsVeq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
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
 sve2.risu | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 50ff756..ca14193 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -123,6 +123,31 @@ UMULLB      A64_V    01000101 size:2 0 zm:5 011 110 zn:5 zd:5 \
 UMULLT      A64_V    01000101 size:2 0 zm:5 011 111 zn:5 zd:5 \
 !constraints { $size != 0; }
 
+# Misc
+## bitwise shift left long
+SSHLLB      A64_V    010001010 tszh:1 0 tszl:2 imm3:3 1010 00 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SSHLLT      A64_V    010001010 tszh:1 0 tszl:2 imm3:3 1010 01 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+USHLLB      A64_V    010001010 tszh:1 0 tszl:2 imm3:3 1010 10 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+USHLLT      A64_V    010001010 tszh:1 0 tszl:2 imm3:3 1010 11 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+## integer add/subtract interleaved long
+SADDLBT     A64_V    01000101 size:2 0 zm:5 1000 00 zn:5 zd:5 \
+!constraints { $size != 0; }
+SSUBLBT     A64_V    01000101 size:2 0 zm:5 1000 10 zn:5 zd:5 \
+!constraints { $size != 0; }
+SSUBLTB     A64_V    01000101 size:2 0 zm:5 1000 11 zn:5 zd:5 \
+!constraints { $size != 0; }
+## bitwise exclusive-or interleaved
+EORBT       A64_V    01000101 size:2 0 zm:5 10010 0 zn:5 zd:5
+EORTB       A64_V    01000101 size:2 0 zm:5 10010 1 zn:5 zd:5
+## bitwise permute
+BEXT        A64_V    01000101 size:2 0 zm:5 1011 00 zn:5 zd:5
+BDEP        A64_V    01000101 size:2 0 zm:5 1011 01 zn:5 zd:5
+BGRP        A64_V    01000101 size:2 0 zm:5 1011 10 zn:5 zd:5
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


