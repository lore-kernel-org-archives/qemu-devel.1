Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E99C2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fDLW96W2";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="dtBrHF13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E99C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr7k-0005v2-Ow
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpN-0006LT-UO
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:01 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25353)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpK-0002Tt-PL
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089158; x=1621625158;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ubuTJ9ZhslIl65t5hdeVzfd17W5Mt0XxJPunSmmefXc=;
 b=fDLW96W2hi5B1MC/3fkCDK4C8qyuzWyo7KPE0svMlgidGIrOORt0FRHQ
 IZZ6mpiLjKdIgBcCecu3ps75xBYx570RfxPBefihBLgORDpkDb4NKNQPB
 gcNvH2/hbuwlmeq+mnnGegXrR8Tn5Qa754WftJM7S3IS8cy2Xg4p425K2 s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:56 -0700
Received: from nasanexm01f.na.qualcomm.com ([10.85.0.32])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:56 -0700
Received: from eusanexr01a.eu.qualcomm.com (10.85.0.97) by
 NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:56 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 eusanexr01a.eu.qualcomm.com (10.85.0.97) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyG1DOLLEEeIvfBgnHI26xCRVGZ7gYLB7upjm3odxqfDLyMyc0KKTSogaMbEe4pCqS5u6MS5dH4QYqrZkydE6kqM6HCw431fwO02oHLpY9TG+7FlqYcIys7hIDIWoEDQIq902FeMGQ5BiLIbsetZKDQspDjJPtFHK6RCgLs5NXpS/7s1UXGkgGoYN4zuCfMgrHbDoqXy742NYC0emtr6M3MO4r9wZiaKVEOJxHyLKV7Jnd0VcpJvx7LutNf7PeGQDmAvmanNa76LI1dCKpo+w+MaJfwF3/A5pnhjIaLKelC7bZIog9Go+RQpV6ni5k9Z7s4fCDWLLRoq3vOapcEYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTyW3da51uemAwVKTB+lGy1iIOoGpbXRxoxoLshkAs8=;
 b=VQOAqO5Zf96/L56n6+wQqpJAnZbZcMENx6bvgE+/1GQrMCiTjVvOT+4g0zlUR12JefRQ1rGgOSEx6QIudKEjsHSiPHa/BT0r+G02UKY5WTO36dBoMQgHYqmU0WLGoQ604Nwmcmmtrpq2Uq6/LnWg5d4wVmF96dKWhVo4cxDpECagVp/XPBIcJvtXIwV8b8pzBa6sli39Qh5aq6oQd1mXn3ZKewidnA3NzHvlbHiGYb/SxXApQ8U1jtbcH7p+Eq2ZiqJcOMsXtCIGYs10H52rW+a6bbrIsQ7a6TryYWFflnsW4LomlQxTH1iHMrj5D4m9F1pP6p8s44RzLWibrbo2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTyW3da51uemAwVKTB+lGy1iIOoGpbXRxoxoLshkAs8=;
 b=dtBrHF13HnUNAX32fi2QUfGgFGNGSd6f4cY8Au87coulUTgyTKPv65fdH74WHUA2u7zyqQEij3qcESY/W/NY48xZl8m9CFy1PEovYqR3C1s9Qvmg8hZo3q1i2glglW8pPxTRIKdtCgVg80o6ZsOjoJvk9YvOYosKuM40DFu7+nI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:50 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:50 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 21/22] sve2.risu: Add patterns for gather load insns
Date: Thu, 21 May 2020 12:25:10 -0700
Message-ID: <20200521192511.6623-22-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 989632d1-06c8-4853-90b2-08d7fdbcc522
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484D25D25DE72196C98FCECC7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ACD2HxFtlxrJRFOEvk8GdJtbmg5SKe3XZExiNRLud60kYmn4VWMB1wDarx1clrLwptg+wroZw1ggqq5U20DKsNEkbVW4I763bEcAEyOqvHBebFG3LkLd6XMCiBFn+afMg8V7Wb9ZbI0ccqwA0GsZHnWGFFYaKJr1EB0b6K2GGGo43/4weLtQwXHh4aJ416oRkCLvm4zjgat8UtNnpa49rxh4b6m1FuEVwnxM4/cj8ON4Ou1RPjjyKng14AzrfonL2BR+q9+f+I8trV0VaJXE6UDDgDihWkJBrRYLZfkptY78Hx8FhSuFCdsj3PKqwGQUAwf08KkNu94zTKkL7fcAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BxVp4HtEMonMfHXV95sYiOkWfDnBaPFfc8QDuaWRAYXhu2r16rhLJJ1gvNVSiukftfcaThS+vEAWpq/VSUCM5FBiE3yCEb2hPz1F3PRwml+YP/pcB0r9gtc7HTFdDwWhhWiYN4/tg+tyzU3KqHL4atLwFUbL0yWq19WaYI1PtFulYZxZ68ZhXRCKpo1gutBGtJbgMSdJ4wncByHJi4GpC5Qe+Jx5z9q/QvOWAgaynidrSgbWMAIn/UaUjdGHIP7MxxI4hGMXMhIAlRAYe/rEc4w5aHesLZOI1pQMitrNB1PEABO6LY4b3dr+31686DXRf6xJohAG+cwEr/dpxLTIJZ3FWSSQ6rymasuyujBKdyYS5m52j7qjLY1/l1CM8ANTOTWHgeUg1FgCuntyWNwlVCPhRX6wkxDnQcx570yo1E+WrfjWmyZNEgrl0zKv85/zjnsLIFCQiBl9QrBAARNJXfmSRu6vLsEXCW125V223lw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 989632d1-06c8-4853-90b2-08d7fdbcc522
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:50.1549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMprFfuvsbVQavs4hUVAK1n3xIYQ09pPa8PXiz26XyLSI5dWGg6d8EoNInCVdNPpYfHg+NlIf8WQE0mpXLtW9g==
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
 sve2.risu | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index d0ad7c9..84ae527 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -494,3 +494,23 @@ FMLALB_vec  A64_V    011001001 01 zm:5 100 000 zn:5 zda:5
 FMLALT_vec  A64_V    011001001 01 zm:5 100 001 zn:5 zda:5
 FMLSLB_vec  A64_V    011001001 01 zm:5 101 000 zn:5 zda:5
 FMLSLT_vec  A64_V    011001001 01 zm:5 101 001 zn:5 zda:5
+
+# 32-Bit Gather
+## 32-bit gather non-temporal load (scalar plus 32-bit unscaled offsets)
+LDNT1SB_32  A64_V    1000010 00 00 rm:5 100 pg:3 zn:5 zt:5
+LDNT1B_32   A64_V    1000010 00 00 rm:5 101 pg:3 zn:5 zt:5
+LDNT1SH_32  A64_V    1000010 01 00 rm:5 100 pg:3 zn:5 zt:5
+LDNT1H_32   A64_V    1000010 01 00 rm:5 101 pg:3 zn:5 zt:5
+LDNT1W_32   A64_V    1000010 10 00 rm:5 101 pg:3 zn:5 zt:5
+
+# 64-Bit Gather
+## 64-bit gather non-temporal load
+##  (scalar plus unpacked 32-bit unscaled offsets)
+LDNT1SB_64  A64_V    1100010 00 00 rm:5 100 pg:3 zn:5 zt:5
+LDNT1B_64   A64_V    1100010 00 00 rm:5 110 pg:3 zn:5 zt:5
+LDNT1SH_64  A64_V    1100010 01 00 rm:5 100 pg:3 zn:5 zt:5
+LDNT1H_64   A64_V    1100010 01 00 rm:5 110 pg:3 zn:5 zt:5
+LDNT1SW_64  A64_V    1100010 10 00 rm:5 100 pg:3 zn:5 zt:5
+LDNT1W_64   A64_V    1100010 10 00 rm:5 110 pg:3 zn:5 zt:5
+LDNT1D_64   A64_V    1100010 11 00 rm:5 110 pg:3 zn:5 zt:5
+
-- 
2.25.1


