Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAEAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBD020814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MR4RVdXh";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="IDHoc8uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBD020814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr4t-0007mR-FB
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpH-00060l-76
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:55 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:35792)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpG-0002Tf-0e
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089154; x=1621625154;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=zndyWHhGYysFoKBK7Ak4QwQtyngTbAM1RBTiylF2EUI=;
 b=MR4RVdXhlRML+bGB/pDLfv0xBVL0SkPx49lsJ9gRMR5dYIbIMl8LKKCJ
 OUm04mOxcSSGFpBog2WUFPyYiC3D71GXtdfM6sRJfBF14IeHEK3Ma3/8H
 7ah/yh6n2o+R8JH0Xw9rAZahYTQ7JiXANAZ7t29uVgOpvdX798/rNnqvK o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:34 -0700
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:33 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aews/Vd3xeYKAZAH/A9cqFthoFrfePFQtZTFsv/kYUind5QgcklWUxB+ii+3eWYXT4NK37uC3U4Hw8eor/r/kcHdsqzoYziEkm8IV82r+1umjQOd8JjVZ8oRVwHoQ5QarUFOli5Wm+twrxCqFUrzRXNtQ0ZbgF+zQ8rvpzmvgP+GPf/vNI8nAx8SFJKo9WFUxLwi7vAh7wKd2lpSjyuZwyhdfbJBAxsoT1E8bwX1KYQLv51J6a7Fy2O0lrtQ5+qx8N9xPJC6ayYVMMBocNc/joL2VviRFOdWN4gRuLtu653MgctH3Q+2nThsA4uD6+Pb6eOARDxpD4qDOtCrdLi6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsoLuWeJcHHp4yZOimUWkfA7JHLOx+gYv1q+9XKRsU8=;
 b=G2WZifpNxzaducGzbR55VWZ/8CJnjmyE1LLRBxDhQGRUCToBAZu3W25GHCOLr/GdnCXEwBjtPoUZUIqu/JlQRsMBK4yAnDs3FfRXJycLEXE6wUuJd1AhGaDtAMgFxPjrRSm5Y0JqSkTX/KmAAvqO55t7w775vJoH0I0ZYTeyQEk35eKX7m+Zy0Ufdiw+xzPMHDXwdpB0ZwwJAwHPliDmgNORT4Ruu93WZyTlTXzD8z/1WTLrTalCLgjdqZwWVYlPcU6iuMuCrzi56yP5e7K780hi5NqKX8AcsEv0b46NLYq9eu1sRSVm7ty3RawVsqvLIwN/mVHVYVe9YxCJOIkHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsoLuWeJcHHp4yZOimUWkfA7JHLOx+gYv1q+9XKRsU8=;
 b=IDHoc8uufgGCp7rNoEOVBq4HycRkBwtN6gfcZrzPKdVKxM+JqipUxPfu0N8YVgxg6JNYWph5/c3FlwluyZMtVuf5KciZqnOokxUHRzyPxvnF1j2Gjmo3Dpf4ARsjQEF3CaGJtdFe4NwunuH99pqoyV/vqF7so0lKy7k5xH/FP10=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:30 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:30 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 02/22] sve2.risu: Add patterns for integer multiply
 (unpredicated) ops
Date: Thu, 21 May 2020 12:24:51 -0700
Message-ID: <20200521192511.6623-3-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:29 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd532379-76c7-4f92-d1ba-08d7fdbcb913
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3627918B1508ADBB0062F5BDC7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxczljQBCb4Q2+OkYU7j1TcMwBRiDSAdCai2nycsjdfNGwobUmwU1ShSWsicxzJnhskFL9RFfWAs3HNlhYLRPT5vitG7/knjOs6en2HQZYqKwpZm5HfLmx6JPfTp+8ABg/gMY94sCUbuSvWg6UlpxB/V4RJt+tP07Robj35/he9WzLlEWJwu39NE7QAqmBCtOTgUNf+mZwFsqaJCgTvpxtHuTSQKX2IL5X1lQOeQEDCi1EkLLTcKuQQr9pDRBzlj1e+OCM8weXeJ4DzmhQVXsj++oETU31hYC82M9TpUu6a9u4nznU7pskASHoro9uZPmfiJwIvR2Sumx/loCLHGCozwc+GrykR72nNYVG+4xfewBTEo/RiafDXmeLeD1eQBC8j/TFk6GgsVHh+LwDajPemP3XnAAN7P/PmsbQUJ1WFGFfvbG6QB3PKu+Rb5QWBY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(4744005)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rl3uuBluvQnmWTMarWZ3Oqtg1yWWPiFVo6LsgxlFvfdOV7uQ8kazwJ0r6rcfzIPLZjxP0d5ejQ8zVIkPVmUwgUOy6IHe0Tg01/hL6TfM2w9H+7bYqtOOV2KzVmZVVhWKqxesr1YR5AeHgZnt43cd22ZW9lEB7Q6R4YJ4VmyIm+1Em/chApxT9OizkOwrEwmQ5IBc3wgg344YKWa45tmmZjTdSvNVA8QVPz635mH86ob1TadDoaJubXf5EXy1nX7F12KC69i8hJVrfX1yKtkX50UFqoB0dDOpZCiLP4WZgNGsL74hJyWp83cS9qTp/i0mlo9o07u3KeCAmav2ChEl+MVO8VNjQ41wZGzBDh1ssC4vccaauitLrPbNo/4EYF6ezz7Gxxh5hmG0E/pl0QXUtoAkH1C1aLscQE2owhMg+bg8IqCvPza2nXNeN+8CiKt1ARv7yyUzmddOq6FfjUKYcZvAe/bWHoRmYCgSxBg+NTA=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd532379-76c7-4f92-d1ba-08d7fdbcb913
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:30.1114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZmLJqSu/ktoLC1FzDu0AzJFtL8aScJGx7+1q/NalFiFnerb6DrYRbIFzKRxrFDMGHbn6XuL1bo9gLcXTlRC1Q==
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
 sve2.risu | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 78debd9..346b812 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -1,6 +1,16 @@
 # Input file for risugen defining AArch64 SVE2 instructions
 .mode arm.aarch64
 
+# Integer Multiply (Unpredicated)
+## integer multiply vectors (unpredicated)
+MUL         A64_V    00000100 size:2 1 zm:5 0110 00 zn:5 zd:5
+SMULH       A64_V    00000100 size:2 1 zm:5 0110 10 zn:5 zd:5
+UMULH       A64_V    00000100 size:2 1 zm:5 0110 11 zn:5 zd:5
+PMUL        A64_V    00000100 00 1 zm:5 0110 01 zn:5 zd:5
+## signed saturating doubling multiply high (unpredicated)
+SQDMULH     A64_V    00000100 size:2 1 zm:5 01110 0 zn:5 zd:5
+SQRDMULH    A64_V    00000100 size:2 1 zm:5 01110 1 zn:5 zd:5
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


