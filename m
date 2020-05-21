Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8EFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61C22067B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YvWgPmTI";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="JcfVR2yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61C22067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr8O-0006zZ-4G
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpI-000661-QP
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:56 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:35792)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpH-0002Tf-JE
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089155; x=1621625155;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=s3wFLwXopHojrHO/S6v44Vl1QwLG/Q2fkjhmCC0OPT8=;
 b=YvWgPmTIC0iYTyiUKJuueHIwRJmBvWLqbsjlTlp/TtximFHZWlKblCp9
 zIQ0hw1nMJbBL6rHm2dpDSeXwo26c+95j21IMnXmKsG+See6va5RvEV3f
 S1YTd9/RVMf3D+BFZucfkwn9fgbMdhPq1jwaaKymRGUAFtCbfFEEG+7oC I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:34 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:34 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjwXvfZ27snGCepVf48f4mU8RUcbd6CR6V763eNTs6DDZOrES8xwRPI7/wmALKoWO18KyxKtx+imdNPDFf3YbpzTJiGfK8Fav68Lv0r19DUeV8hJYDKIBGy/jFTFNmpAoGJBRxtgpC9ocEYF/fsm611SFH4/GtwBSyOfKgLVepQjHINbksyWSzbr8Lug85Kmj1OXXdeFdfW8bVF9C+0rhXAtk9JDRajlRVQkMx/UsrwP8JG4OSX8zXPNXmpPOqa+5ZnF5iVi1vWnK//ThuPUbtcdX9CS5AxnrfpvOUXwCYCmbB67CjZAO3tsywRVLxd2frMDFIww4f0x2C3ITRI7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sct/s5rINI8CddPNoGaUZRLxdX1iOTzy4m11jsDcwkU=;
 b=kWRtAZ4Cmo6Qw5XSWVuG6WPUAGjAPcN4B8i8FnSxm7H9/vBl5lV/n1cQ6bt/CpJSnBHj370bZC7O/WhcI/XRwIurdDtBL7tFqUsYCk2U6BSgNIG+8M5ynEieYY/z4m4MRgjnxMjUaHNqf85eg8J/jDB+tOV+/RlplBOgmuNvq2IVzyx5fawxVo+c3luAIGubiULongQ/B9McTTawUXoOM3CjGsYhah+jtLCk3BQESa4eW08/oqvYj21ZJSKiy+NBVeGsy2JRkpLCkpuK1k6wO+AzbnR4msj5VuvrsLF+BfMlC55t77v3xK/mVbzUgyFND3ZyjQ0f8Bkp2C8vLLW3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sct/s5rINI8CddPNoGaUZRLxdX1iOTzy4m11jsDcwkU=;
 b=JcfVR2yLTh3uAjDODHg332n8fS/eJzkjOMdhFBg5RBK07DpKvZVwd48JQ9u/QKDUyRaaw05zaSfcbW0FM326hZoOnP8vi4LKIuH5D/SyDQbq2GDbMP1cqAqTMVCkisRXxPIPFss2WXgRE/somvH7szzmAzvzQXUIrPqmk+Pi+Xc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:31 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:31 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 03/22] sve2.risu: Add patterns for integer
 (predicated) ops
Date: Thu, 21 May 2020 12:24:52 -0700
Message-ID: <20200521192511.6623-4-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:30 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74dee379-4445-416b-78ac-08d7fdbcb9ac
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3627DA400930C026C9E2A316C7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6s2Sr0JHVOwdSSE0Ntw9iacjLWyBnxICKibJyD6cd52Nr0narQxEM55xgqHhxe3K2GeAEiyMzhbKxr4smqC3oZGcSAep26uChQhIQ0SLuRPH/3OLvIHDqywR0tQZ/Gwy/jPg3PGRI0/wxkdWLRmDNK2IW43f+rhkb2W3oHoDuQArDAhdkq/6CNSY3jUU7X2PxzR/2BG/7d49bO0ixgSE9yeEc+buVTHwSb5TXxwPcqfg4T7MwaXEiuY4oJXsWT7Cz5XwHlTbUnUUhtDeaKbW8kbzzhp1TYUS+iZ237kdK062YxbUrScsnqHVduPFMA0nYcpUfDVcUxAtEfwgDpF/tJKyodAFndsji1Ek+aYTrsHgyY1g4gJGTV3POXYfzxgtMtWgvKX02usY+0moOYEP+gid4OtfmvhQoBs8U34/OdkOWvD6zI3Ars3tlVk7kWG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oaTOclO6PEQ+Fc9L60ESSfIoxztyVNMMRX2/0u+6EfPnAxrAmATevn/fL59nG61VP3p0JYDz5WYhs75zGQbiS03hZHkg6X8XoVaUC19LKqWqXGm9Xe9Tr+/l5dGzk6+/6DEpBIuyhbHRs10pWsJZs8pJRX0F77WGWxzwy+uO86P43k+P5Ts/8ab1mRNcRczGYxwxiZGm7f/jjwLDE3XaKIDRX/HTPnifZehZngs/zrrMoUNUmsDnHKQ4+3ZaPQr8pzj3nQtUCDc6FzFYEXxjlWKem4ibzGGUkTL5ICTGjPnUlHI2Fhs6hQvlkwDITZ4BtogxDIf7km6BOGznWWt3rPrOVaOqTdUgl4ocVsgAFLFrug2EpTReMZsiM/mX8UfBxgcF5KUhJYnqmADicCnPskTBfJqSoiX0rAfBwfPLx/K5BbEcQ6jnPVCZo505WDM80uQXH5c6nXNX7xrIiADwzSf1odS/u9vDH4mi+A1koCk=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dee379-4445-416b-78ac-08d7fdbcb9ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:31.0079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VNc5Pw9XIqSsJZTEl3iGelpxIYvaPmMDaRiuJEMhWJaXJbge+0S1JD9N6lIshKlZa01eg+WqXJVrkuSW9ZUMw==
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
 sve2.risu | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 346b812..f2e4dba 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -11,6 +11,57 @@ PMUL        A64_V    00000100 00 1 zm:5 0110 01 zn:5 zd:5
 SQDMULH     A64_V    00000100 size:2 1 zm:5 01110 0 zn:5 zd:5
 SQRDMULH    A64_V    00000100 size:2 1 zm:5 01110 1 zn:5 zd:5
 
+# Integer Predicated
+## integer pairwise add and accumulate long
+SADALP      A64_V    01000100 size:2 00010 0 101 pg:3 zn:5 zda:5 \
+!constraints { $size != 0; }
+UADALP      A64_V    01000100 size:2 00010 1 101 pg:3 zn:5 zda:5 \
+!constraints { $size != 0; }
+## integer unary (predicated)
+URECPE      A64_V    01000100 size:2 00 0 0 00 101 pg:3 zn:5 zda:5 \
+!constraints { $size == 2; }
+URSQRTE     A64_V    01000100 size:2 00 0 0 01 101 pg:3 zn:5 zda:5 \
+!constraints { $size == 2; }
+SQABS       A64_V    01000100 size:2 00 1 0 00 101 pg:3 zn:5 zda:5
+SQNEG       A64_V    01000100 size:2 00 1 0 01 101 pg:3 zn:5 zda:5
+## saturating/rounding bitwise shift left (predicated)
+SRSHL       A64_V    01000100 size:2 00 0010 100 pg:3 zm:5 zdn:5
+URSHL       A64_V    01000100 size:2 00 0011 100 pg:3 zm:5 zdn:5
+SRSHLR      A64_V    01000100 size:2 00 0110 100 pg:3 zm:5 zdn:5
+URSHLR      A64_V    01000100 size:2 00 0111 100 pg:3 zm:5 zdn:5
+SQSHL_vec   A64_V    01000100 size:2 00 1000 100 pg:3 zm:5 zdn:5
+UQSHL_vec   A64_V    01000100 size:2 00 1001 100 pg:3 zm:5 zdn:5
+SQRSHL      A64_V    01000100 size:2 00 1010 100 pg:3 zm:5 zdn:5
+UQRSHL      A64_V    01000100 size:2 00 1011 100 pg:3 zm:5 zdn:5
+SQSHLR      A64_V    01000100 size:2 00 1100 100 pg:3 zm:5 zdn:5
+UQSHLR      A64_V    01000100 size:2 00 1101 100 pg:3 zm:5 zdn:5
+SQRSHLR     A64_V    01000100 size:2 00 1110 100 pg:3 zm:5 zdn:5
+UQRSHLR     A64_V    01000100 size:2 00 1111 100 pg:3 zm:5 zdn:5
+## integer halving add/subtract (predicated)
+SHADD       A64_V    01000100 size:2 010 000 100 pg:3 zm:5 zdn:5
+UHADD       A64_V    01000100 size:2 010 001 100 pg:3 zm:5 zdn:5
+SHSUB       A64_V    01000100 size:2 010 010 100 pg:3 zm:5 zdn:5
+UHSUB       A64_V    01000100 size:2 010 011 100 pg:3 zm:5 zdn:5
+SRHADD      A64_V    01000100 size:2 010 100 100 pg:3 zm:5 zdn:5
+URHADD      A64_V    01000100 size:2 010 101 100 pg:3 zm:5 zdn:5
+SHSUBR      A64_V    01000100 size:2 010 110 100 pg:3 zm:5 zdn:5
+UHSUBR      A64_V    01000100 size:2 010 111 100 pg:3 zm:5 zdn:5
+## integer pairwise arithmetic
+ADDP        A64_V    01000100 size:2 010 001 101 pg:3 zm:5 zdn:5
+SMAXP       A64_V    01000100 size:2 010 100 101 pg:3 zm:5 zdn:5
+UMAXP       A64_V    01000100 size:2 010 101 101 pg:3 zm:5 zdn:5
+SMINP       A64_V    01000100 size:2 010 110 101 pg:3 zm:5 zdn:5
+UMINP       A64_V    01000100 size:2 010 111 101 pg:3 zm:5 zdn:5
+## saturating add/subtract
+SQADD       A64_V    01000100 size:2 011 000 100 pg:3 zm:5 zdn:5
+UQADD       A64_V    01000100 size:2 011 001 100 pg:3 zm:5 zdn:5
+SQSUB       A64_V    01000100 size:2 011 010 100 pg:3 zm:5 zdn:5
+UQSUB       A64_V    01000100 size:2 011 011 100 pg:3 zm:5 zdn:5
+SUQADD      A64_V    01000100 size:2 011 100 100 pg:3 zm:5 zdn:5
+USQADD      A64_V    01000100 size:2 011 101 100 pg:3 zm:5 zdn:5
+SQSUBR      A64_V    01000100 size:2 011 110 100 pg:3 zm:5 zdn:5
+UQSUBR      A64_V    01000100 size:2 011 111 100 pg:3 zm:5 zdn:5
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


