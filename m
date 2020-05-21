Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62916C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247D72065F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KFMotXAY";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="fCZzgweO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247D72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr3D-0003nk-4a
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpC-0005p3-It
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:50 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18872)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp8-0002P8-Vq
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089147; x=1621625147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=dU35suH0wkRuHatY4ot0TEbnYn+1Zwqdy+S04GO0aUY=;
 b=KFMotXAYYIAmelVfMw/oZ6HKsGbIJ10++YpPtSkBTDuTddmh8a61pN55
 HqpXDJNBTADT0iamceNsY8zswWLIclx6bcx7hPxIJJPZuEeZqg3VGCKNk
 1crn49MMYP805aP7Jfv08AUtNqxvi5nfYYj7W7Ut8Y4MNM6C1/PbRgrUh Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:45 -0700
Received: from nasanexm03b.na.qualcomm.com ([10.85.0.98])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:45 -0700
Received: from APSANEXR01B.ap.qualcomm.com (10.85.0.37) by
 nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:45 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 APSANEXR01B.ap.qualcomm.com (10.85.0.37) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNV+ET6WkG/9sYYmY9e/M7YijBcGkrtOD8/2GyxH4yyZAS8HCv8ADULkGiGqeRdBXq6XQTPgz4YX4p4iTqIYUIEXx6j2hIHFsjPguIJZCF0+qjBUcGkPCtyEwIT1HAGPpAyGBZfPonyL1R/prBPs15r1gCGgRndIfjo4nf93FGihBZEBC6EhggTaDW6pK798crS2K5szqb+gqMtdyVZSxMz+dr7EaajibKcyOEonE6I5FGxVCqq9Zj4/C9/TDwuYeXhW+niajDrfDuHEk6lKeB+YGan1+FwDjMMqJ52o9TDJFezXmOBATXOcvHR5xOKW+rBMGHndkLImmc6nB4fQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9cqF/6jrcnd6h9exH6gnzCYoTAm8ovIUEHf6ZTcRQw=;
 b=TFEaiDq0r4GNQKtUtak2PZwwMtmq58o/nKu2Fxhtm7ENKUtvRysqZkO2Keo78mwewSV/kFdtKMJbuPKtuc+THflWU8Nu2vRXkr3l5l7xNEbYcnb54kNf9u+nOfP2a+9ZMb6s2up4jeqgXZlVTi2s16GXb2EsrnQ0zhIDP1YcurWlqU6SYePD0k7PIHNwpsu+ZpAjjzkk2KVmu50qbzWKeD+xJoZhLcSKBEPMdzvsG/kG5aXkLEb05JiDwgLBuZcUVnNHE7hO5NAgp16o/TBpdltP9Fba5uoicHc5Yj/M6YDrR7NAXrW8w9gya0a8LL7mofBJQLaLq61AjSfI/Vxokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9cqF/6jrcnd6h9exH6gnzCYoTAm8ovIUEHf6ZTcRQw=;
 b=fCZzgweOzLxwdW9s6SPusWBap930MBquVoq0LgHiuGBLKkxX1ALoKO7bzRBY2gB53EjKKosbe/kn2dvYwBTX3TXxDm0uIDl/J25Opuby0a2lGKBbiZ/gEZXji/4XnCrGI4sZh9F0aBIYXsGXsSgwBacdNsXh0blsooBuFUyzkAI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:40 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:40 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 12/22] sve2.risu: Add patterns for fp convert
 precision odd elems insns
Date: Thu, 21 May 2020 12:25:01 -0700
Message-ID: <20200521192511.6623-13-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b95138f3-16ce-4ad1-f2d2-08d7fdbcbf13
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB36276662851EA32E001B681EC7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZPByPCsGTTbPsFChqofWqTDFjTeWTjqWDqtvPGJ9WECjbzVdss5YDDb/Kn+COwLSzRSJqNkDdlFnYkoCjXygXg/h7M0iXPe/e8/Gu+UhpFOXQhXA+1B2Umh0mgJW1vKC1lKVOMOkADL+Tfs9EHOd35piMezTmiwmBFUiFUJux59JuWaO2S3z26gXDVB0fLaSMmPHb8yQsg4ALFTfkVBVBCpAQoo/dWXL1QhkMKqxLtd2+/Bnc3YUtGD51MZcDNLqweNm0VquMzCvL8Jum3iG3YAXTns/25JN0vETf7BPio2liGHRG82Bzx2Rzj7gVrKDIDcRiUcJnDJTdL37dmFSCiQAV5IqwK2Wv1771EzVvIqjDIx+wv56kFv65RA4VXPiLdolZPtvqdqFlsbpPec2uw/QkvkIeB05wKlSszdhGqLLLRwEE73ROQRfOkM4o9t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(4744005)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SWoW9gwnxAD00Z+qRKloMcK+2jxZg6PVVCXH4ex/VHVdzgdoO9bnj2mtjAz7qtBS1+YsmU2JMs9oK0QEl/VVARzQrA4psxHR1az8qY/83WE3n9n4YJ0FyCwrjv/RZgJAtt4NSE1PVc4ceg7RekRSrOpZ5pxt2vv4ZneEoe+uxDLCIfnX28DAHj7lupXWQXHU7fRo6WSu43ft2c8+BwW4skV3wF6B5wPrDk4NY0gx6CHDuFUqqNFQBFlHK/Dk9um2EbMw6RyvQE4hUnKSsXS5wrI2JR31/WNRA8A4Nchac23DByN0i3w7sGVDHfjTROKOoN+PHgVCx8XhrtLQCplZ7SG5NCk1qPIeW/Hj/h7usVyotwzbnn+EXUcfaNKJa3YBacz2B9xRoGrIQUxOcuKIpqTNNm1ABRBvDdmGIx774sqNYFWKPUxUm1m16E7CPUecTInr2aDY/mYoPCNjnkhhPMoVFdiKxgSUuTbpS1EcG9o=
X-MS-Exchange-CrossTenant-Network-Message-Id: b95138f3-16ce-4ad1-f2d2-08d7fdbcbf13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:40.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5Wg6LXfqbKKT6atcIfTFotBjrgELRAI1mwQllanURZo/aiflcgRgrXWxrMHkYXap2TYlA7mMMMmMX32o1Hikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3627
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
 sve2.risu | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index adc5dd1..4b2a79d 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -297,6 +297,13 @@ SM4E        A64_V    01000101 00 10001 1 11100 0 zm:5 zdn:5
 SM4EKEY     A64_V    01000101 00 1 zm:5 11110 0 zn:5 zd:5
 RAX1        A64_V    01000101 00 1 zm:5 11110 1 zn:5 zd:5
 
+# Floating Point Convert Precision Odd Elements
+FCVTXNT     A64_V    01100100 00 0010 10 101 pg:3 zn:5 zd:5
+FCVTNT_SH   A64_V    01100100 10 0010 00 101 pg:3 zn:5 zd:5
+FCVTLT_HS   A64_V    01100100 10 0010 01 101 pg:3 zn:5 zd:5
+FCVTNT_DS   A64_V    01100100 11 0010 10 101 pg:3 zn:5 zd:5
+FCVTLT_SD   A64_V    01100100 11 0010 11 101 pg:3 zn:5 zd:5
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


