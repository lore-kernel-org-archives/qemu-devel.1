Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF2FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75E52075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gmBkA0c8";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="XBjM7ZPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75E52075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4mt-0006sq-Tl
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j2-0001Rf-WB
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:17 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20822)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j0-000377-Ng
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1589904254; x=1621440254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=/zapMgPQIJOacWtHaFINo2jv04ovlnrTU/ngn20oz1Y=;
 b=gmBkA0c8Waupq2SINnq9DYHk9RRnUphin4KQUmcPW4vIrh1duXTm/LRQ
 W9BdzuckKxpDKAMsY1saVtbX919BAC3rEXxo/B9596mihxZIi/5p8VeAE
 10PHmRqpSnjnJh0L8rs+RsVKd2OF2ObnCic/1OEUZEQoW5sF26fiM92FJ c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2020 09:04:13 -0700
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 19 May 2020 09:04:13 -0700
Received: from NASANEXM01G.na.qualcomm.com (10.85.0.33) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 09:04:12 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 09:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFN1x522gXMWaRIg3/mza4l/Rb8PK1wIM60WCnV1RKKQpontlNDcyl0DHpQUa2BlhzKlWQNOGHHck2vgCZ9VxEP/g1/Dbx0XLbGiSPjfz3MrTs0RvyvJJNglv/9DQgF2rxI1smfDPb3R3FJReLThdWqpqh5dwITpNdETrzKp+jX+cKnhomcz/JvBO4qgtv/+Qyg67t2Byedj4wNu2KWDo4DGt0X/7ZhNJC7O3bcnMQJRFry0abkqjZKrTTvbDwVJ+FF5fiCj9ogoS94mJ/9cMrSo6QEDtIiHxyid7spBK87VPJuXbO0UNUo2c+AHnKHV6JkmBXrTmRIGakXdLQTblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1ARZQyVJzVa8pyKtVi0zOCElDq/ZFvJRoOtQaqdbB4=;
 b=RNEToC3BpJfGEYVn9QYHUMtMk8JJmhGhFVYxl/TWOpqx8tG99dewJz2Cag+lGXLNcOXFYreP2rHVpgi49pfYALcdJsQyFbsfh8M3TtrBU0R82c/U/VWiM9oO66/eMAhL3SCg0RzrlycWcrS/TleHGyAgLEB0MowMhEfL+sZw6XVcksfW/iReNdialcc4c4zmP6YSfQ9Lsu3yQFJzx8Gm4uLPwp1Yqd9zdWsOpgkNhHAd/akriOtU8xBxl/WgDTZpnmQ72zN+xQVC/dLl9xHoX3fHVKPsoXpnyZD2AuWwS3IWvFc+Q/t2206UCqhdwXFK+uSR6yILcRsndcwM0mdaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1ARZQyVJzVa8pyKtVi0zOCElDq/ZFvJRoOtQaqdbB4=;
 b=XBjM7ZPHYP4aA9OSjlT5cdzTk/HbiayZV1BU5i6h2Y9eYJSVVtbBhHuA4WXTDGNskmH5TR+GKTKjhaMcsN8b1cinb0REKOQtzORunRbRtD6yS5D9l9PMPa9WegqazT8pvUKxMncnEUKvYntYjEwqmcfTLcwIoKUmth44H6A0zqw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 19 May
 2020 16:04:09 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 16:04:09 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RISU 2/4] sve2.risu: Add patterns for integer multiply
 (unpredicated)
Date: Tue, 19 May 2020 09:03:52 -0700
Message-ID: <20200519160354.4430-3-steplong@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200519160354.4430-1-steplong@quicinc.com>
References: <20200519160354.4430-1-steplong@quicinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:c0::39) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (24.102.122.190) by
 MN2PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:c0::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.13 via Frontend Transport; Tue, 19 May 2020 16:04:08 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 535c7ab7-4641-4e3b-09ea-08d7fc0e4390
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB348491117E36D917435C7F35C7B90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v54aAYgqTug8bFhBxgazVfdV1s0B3WnlYarlJeCIRiTFHUr/EupmyNypWoNGAMs2FVOMGviRHuHzYKKVAb4vJ0smy2CMKkl6Tga7OJpYUv6uyOY2QTMydYSfPtyyyvmDMdkjyIcGZP1Sh2e5kez6BvfvxKCeexHgAHrdEoea8txvcdTiqsOAglf+FZ6Hs5EFHe5zmPjs3lgm45PGdl2ubhj2Npf5yeVig55cId/Vr2pvvRpqvRMvOyhejcKg8gROKIV1NeGWNayOBh1BmhX1iBuC/W0Db7tWZ/I+AOds4Q7aTDHv1t3N6spiw1W4kbe/wYxZf9nYqDhS5g6Pqhufpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(4326008)(2616005)(956004)(66476007)(66556008)(66946007)(316002)(6506007)(52116002)(16526019)(186003)(5660300002)(86362001)(2906002)(26005)(8676002)(6486002)(1076003)(8936002)(6916009)(6512007)(6666004)(4744005)(36756003)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rQY7AhEwL9k7tGAwEIgs+jBUmbyQcM+4QmgKxIdgB2Iy78xCTiVkLAYfGn9LpdADo2amnM/ZWoUh9jgxkBd7x3jesM32qUYELuGbAHAAyXwFqSRV7FYSQVPS9j2NH5K5M9aT82VFbPQn28JzQ1sNJyh+9AhtebKi/Nb67mxxwT/ReWZoDWihi3JY9ZIbiAoilDAj8xFTpBXRS/XvSUSBPYp/vFE1iNZWAjQ/J4RHQmQZ6x+7EfBLClher2SRSJwdyxXO0hUZwckctn4VcTf3c8cDzXi5fMlWIhkgu/VPJyrO59Yw6U84Ed8lTTTgSQhyLZugtm06sRY+qcCRRcxrQu+RD716Pb9/c2dvs43geOyFc/N1Cs3lVQeAOs0oAd6X8j852838uwGy2aTs0+HRaUC6YXuFxmY+mqflWNSFez8jDveAE+1S53jnEokRXVOnXucHQcoyuUjpt5ewm9knhI2CYyKd8xwkFgD7XAL0aZQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 535c7ab7-4641-4e3b-09ea-08d7fc0e4390
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 16:04:09.2217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1wmlv/S+FnDLDDyWYE70RSnR/4/U1hrflhkdsMkoPWmQMOeMhh8UsqkmKGUZqfKRo2GLqVsKu8TNZF9vLBIiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 12:04:11
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
 sve2.risu | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index eb1d75a..ccdb19f 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -1,6 +1,17 @@
 # Input file for risugen defining AArch64 SVE2 instructions
 .mode arm.aarch64
 
+# integer multiply vectors (unpredicated)
+MUL         A64_V    00000100 size:2 1 zm:5 0110 00 zn:5 zd:5
+SMULH       A64_V    00000100 size:2 1 zm:5 0110 10 zn:5 zd:5
+UMULH       A64_V    00000100 size:2 1 zm:5 0110 11 zn:5 zd:5
+PMUL        A64_V    00000100 size:2 1 zm:5 0110 01 zn:5 zd:5 \
+!constraints { $size == 0; }
+
+# signed saturating doubling multiply high (unpredicated)
+SQDMULH     A64_V    00000100 size:2 1 zm:5 01110 0 zn:5 zd:5
+SQRDMULH    A64_V    00000100 size:2 1 zm:5 01110 1 zn:5 zd:5
+
 # floating-point pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


