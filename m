Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA78CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9B5205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D9dZ1F/O";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Cvh7yPr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9B5205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqzY-0004HN-U2
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp5-0005dL-BK
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:43 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46189)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp4-0002N6-35
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089142; x=1621625142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=zBAka/uLK5BhVEfyfUNK8eJOJJKyVQKal7L18Ye78pQ=;
 b=D9dZ1F/OBNTHKWc6ObvdRmdnWE/lYxK2SiJgftf6j4ccBTObmJhHERZV
 6CkARV1JlA+jQEOyV9xGyYGHTez5HnDfRZiserzsBm3pgWV42pt1XpsdW
 o1LTd3pS9FHc7Zx7sJQefsBP9gnuWFncIpVulb8Ml/p9AZjZ61o/v1FL2 U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:39 -0700
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:39 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9UrydyhAps72Xv6aeMXg1wzJWoHTDDUfwlPaByvzN1P2XNGR+YASFm3y4J2+5KB80iITtVyeSyfZjSumTOyGnj9k3MquzhfKQeWHRCeK25ORCK34FaZcu1LlrsZZlkXm0okGZLZxv2n7dukFI5P5L1DZRF67zg4qILCuQNTI5hK8bV/VNs9KfOkBxLyGgF8vQKjA4r6nTq8jOr0w84XGabm+iu9GmQEdzVub04Ar6iTna6L0UcF2xgggzZWzLFZhBTsMRxQpu0pZfqGoOW3o5dlqgkpaH3O7tyGl9rSy78WZdAzS2lhv85a11ULmu5N7YwO1xznY379VvIONT/BtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYyVx087r/XUeMshepgjVIzI/qiSxsI16wzV34MVmL4=;
 b=IWVQ+4nRu/7ACgLgh1EVJLNMXeCdZTE29T98VHAno4p3Q2jimWB917u4qtKBeFupSM4W9Or0R0b323zfTXFlYn1hUn8azFaNf45O8M3Ofei2MvsmUn7DQeO3LL3C4ZrYMKvx2oR0dpBagmwtgOAil2gCjp0OedbwnDxNOxi56zTjswZuUo/WbN4jr7NI3X5f19mA5MaVc2aWRSrD4A4hSQgFR6/N4xJidaojiht15kfv/u1x34t/c0t9aBWWSiw2JTVidxxI6mJME1ULek7dFznhmeY8wxl+PtVLQ+1Q8MmkkaTDov35h7gw3iNcNfMv5eQi3xi+225Z17sUb5gdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYyVx087r/XUeMshepgjVIzI/qiSxsI16wzV34MVmL4=;
 b=Cvh7yPr3AXXElo1CTDK0L8S/EvXhoCn2IGBxzEludda24CGHilo9xLOpaxKMGVTfw39b4pfFICdfeLoAgo6/V2dC3B9bMiDO2iS0o0SlzQfk0988dYagA5ASgypbyzYlsHC/hi9LnG+kKI/tFcXe1NqZykq7XOVQ/5c27oZU1jQ=
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
Subject: [RISU PATCH v2 09/22] sve2.risu: Add patterns for histogram
 computation ops
Date: Thu, 21 May 2020 12:24:58 -0700
Message-ID: <20200521192511.6623-10-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b141fe30-00de-43e9-5fe7-08d7fdbcbd27
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34848D1AB60483D60C2FFDD6C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOzhMnmGWrl/biHxl44j5ev7LEYC/YkdujwPPJxaltnh+qfm7k2DiZvt5Wr1tf2WAJitn/T1Fy+9XpgTiDaOwPbqdymxyqilS9U3fxJ1t/u8bzTsIGp9hNoilx3jil+szKQhYFMdSwyV92nXSOguxF7oPv124c6Ifk5zgTOGlExbHvbzVY4oko8f9JOfhJSNoSUHiKGGN/Y1LccSAHFmpPU5pX1g0thM7cIJH9a7ianKOSPypzumEC6t6HvJyBoreAPOxeXhTzs17b3rsUvRxCCHBiTXelsgpCvJhcMbFhnMCOjNfLg03EZLXTasS9ZO7Zm8Tpf0kWN/UAJ0fq7olw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(4744005)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: e5UUXPrvgiYdm8fY0wrt6gZ8hGn47WjTULUp7LhqDIb0GZGpPtf9nbV2ZiojHAqEDem5432VTsuTZZbc4oORV+RYjcHarxdcHs7x6dT9g+Unqjz3r7F/P9woEOIv7pezKDAQhn+xSZX3fp6P7PVrVHapCJ5+TypVNYpnNiG4g6muKQfGQBUbS26qI8xl7OlMv3tOtKhYZnT+1iOg+9S0E2qCYnspH1E65vfn+4YLwSpCO2bGnv9WogJtSq8MrhQ7VPebjOtRuUdAzSdroFcVKyfmeAKGWCRHB+S+l7NYaPwnsKsOEjT9PVnmF/O51uNr7xmFVljSK95NfyE5oks3mftpd+IadqKJfu6felwhFq2LtxoHSLTwaKDAPBSDkfMYwQzgZSsOa3DsZBvEMszeHFAPaJvJI99Vfreh1E7lTdT1FZEbG1AK7CVA66sMqPmoRuW+pErEV2xNjfLvjvENplnftkNab2XWBaNSl9Z2dV8=
X-MS-Exchange-CrossTenant-Network-Message-Id: b141fe30-00de-43e9-5fe7-08d7fdbcbd27
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:36.8565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrQ9O34AGtp4ywIP9n5N5SKEQOKk9WVFAwkvfUpqFAAPyg1gwrCVuZCtIlPkGXbrjpf35fWvZHQ6XC0wZ/2bJg==
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
index 5bd515c..725bbd2 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -266,6 +266,12 @@ MATCH       A64_V    01000101 size:2 1 zm:5 100 pg:3 zn:5 0 pd:4 \
 NMATCH      A64_V    01000101 size:2 1 zm:5 100 pg:3 zn:5 1 pd:4 \
 !constraints { $size < 2; }
 
+# Histogram Computation
+HISTSEG     A64_V    01000101 size:2 1 zm:5 101000 zn:5 zd:5 \
+!constraints { $size != 0; }
+HISTCNT     A64_V    01000101 size:2 1 zm:5 110 pg:3 zn:5 zd:5 \
+!constraints { $size > 1; }
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


