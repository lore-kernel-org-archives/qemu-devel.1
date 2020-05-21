Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B77BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE03F204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="r3mRlXys";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="TLB3PbPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE03F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr0G-0005se-2B
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpE-0005rv-Ms
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:52 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:41705)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpC-0002QN-66
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089150; x=1621625150;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Z+2rNQEVG5ywU5b0YyA7J0Vdf2PCR61vVKmQ43ivbLE=;
 b=r3mRlXys/toko1IOspF0FVVIyGE06xQ2PqgeNBiBEGmu6qBv1+ZRd99P
 9Do9iW1F3nDwF3IJufkGqAAEPxIAdZq/g8l4kz/nb2oK3IlsEp45lu0bW
 T9g7g6kTN1u2ydvaxQ/RK3UNwKEOMuEbeBRspH2XFfBagDEX7I7DoqiO2 o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:48 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:48 -0700
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:47 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQIfENnwfrqLzjZShM+h8fWqB2r1Cgb/L+Az0PCsyLC3ofSTwx3jD+Zq5iia2WcnuwVxarKh2L/qlz72JQRZrvqSBWXa9eAizyWDP/dXSlke0KxHQf/BYPeSjn11v00G2bMEH6DXDcfJRUpmtR+1skNun22G4uC+z8GakufgCOF05BenDAbuAbBQLpzg9s+sAqK285visvRl1dCAiuH8L8PaOSFeTXRttvtK7XLxfFKBZxoa8XsRAopzoMPu/sfSbEe7rLBgYWvHRiykE2GQF1Rgwl5eo88hQ48Nk6pC0u4v6pwtY7pN0LAKOHu+K+TNfywnE4IpUofXSfkacJEaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlthpLqKFQ/bLp5ulYM3Y6YPyYHX1br/4WCaKB9wzco=;
 b=KkW+y+PacevNyXPXAScXZdbWcYmz22+YPvFvAm28uDaW91v4pq0KC6W3P9wRXTs9oe0gtnk39hHf59uFy9SbgjYE0TGmx7C75SBc0X86EWbe0sg+A1UuUPOlI75CCoMYNNxsd6HQjh1PHYbYIrPM3ME6V6cqUhM4g9y8IYcOwGO/tNqssFlvs8sXe3kquYbburvfxPe4gw4nJsqIq5oSpKPYJv08WCJLsd+saR/zc7IcmvcReC40SKJQS+oR3s4oDm6IaNbY5bxGe6YJhAnv7NDWLius2EH+etT8AgI1ajYvoSucFIZ2osQ8vn0GK9hpCaw+zXlSG3CoywRtk+83Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlthpLqKFQ/bLp5ulYM3Y6YPyYHX1br/4WCaKB9wzco=;
 b=TLB3PbPf1adBdgW1RahIr2bMT9aiTYlyzDJzt+J/bQbt6hAIVD021wdqUSK+i538XV5l5BwlTfwZS46umiq6WpuD5bKm63FZ9vwCiexuR2wgJKaDEI5YXMmLpJ2so6HXRaIQcWUjS0N1pLa7r4QyepIYLskofvaU7+iV/M8TiLY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:41 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:41 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 13/22] sve2.risu: Add patterns for bitwise logical
 (unpredicated) ops
Date: Thu, 21 May 2020 12:25:02 -0700
Message-ID: <20200521192511.6623-14-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:40 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ed1a45-9147-4b60-ab03-08d7fdbcbfea
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB36279486B68B3B43D6E9F806C7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLVMY1z5Iu8zFJbeMxc7xSneKQFwNPShRqfi8bUhoWQORXwfFrXRfe6rzbLWHXb2qnCMwlo4sfF9jfUbVq2JVQ/bRp5MmrAHaOt5I+0koEiWWpBrsU7lSRzam0aB73TLh2FhrCl/RtZt9Fj5K7ipll4DWpUwXzBYfcxQErH9NNq9QSIrBqIrI2/m8b1hx4nycTMt45zcpwdRW7wSQSNoxUPdkFI6fSMaK02zzTTKdg9/3Kp6u+xmCZAyJNCRlgDI0s9sh20RcWff5wCnxtXfUEGZHCeZlG2bQm4IsGz6Uif63DiHy5CW5JlloiJTo2WZCZDqh+AsUlLXThDU4zderUS9Bei85Ji03+jhmpPZxYZ+LCA16YaLVrgd4Nej4ZPybj9/uo5G1PMpzNzG53/oOv6+zCZnLEa3x/9jHoqqdZ6OInh7aGOw9EDk6WYJGMmS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(4744005)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3SZ/nNQKSKpFTR42I3IS7H++2IFdEB2WMvQrNTRZgcMNhcp8++BEk2Nxnw9ovGWK3Wdlo0t+0VeoG9mmrBL5IwC1PHSqs+xUFjm/HVn+N8XSANdLg+wEJSOptTg/OyNRE6oZ6WdpAAMuY6qo2xmNxdB3LsVtP2G2NbuflACsPn/Qjy6WfyEtRg3XFJGtUaVVxyThMWye5iN2ewvWlHXdSCx0X3UMtuME75mH8k1tAb+CaanwBhO1pAP/1MFBXl2GVa34vZZn6PUbS/xCXNzhmgxJSGpIFZb8w4LmYCTXMK8NNyW5WOTIK8Mjydnl440SlA7tJKBf+yrVgPBzKbPbzACp9z3IvCnwo8ZK/3HBfNgSlXBkyDNdOXsO/NZqgcrYaUF6S5XEJ6f9VTSZYaC3ghMwLF90+ZAqK7m97j8RUi0on+vfdf5rJQLLSnNlMfhmaOY7mxNqJ+wkTnpiB8zEmPKfIiGyoTjxxqW6mPvKi+w=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ed1a45-9147-4b60-ab03-08d7fdbcbfea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:41.6298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmV9ujy6sLzLoEwSx7yJBiDSvPNzo3crSez6aKKAu5LrVTnUh08l+VFY35pPLrzc33Qs/BLK2exELrti/6KcAA==
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
 sve2.risu | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 4b2a79d..313c5ac 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -1,6 +1,17 @@
 # Input file for risugen defining AArch64 SVE2 instructions
 .mode arm.aarch64
 
+# Bitwise Logical (Unpredicated)
+XAR         A64_V    00000100 tszh:2 1 tszl:2 imm3:3 001101 zm:5 zdn:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+## bitwise ternary operations
+EOR3        A64_V    00000100 00 1 zm:5 00111 0 zk:5 zdn:5
+BSL         A64_V    00000100 00 1 zm:5 00111 1 zk:5 zdn:5
+BCAX        A64_V    00000100 01 1 zm:5 00111 0 zk:5 zdn:5
+BSL1N       A64_V    00000100 01 1 zm:5 00111 1 zk:5 zdn:5
+BSL2N       A64_V    00000100 10 1 zm:5 00111 1 zk:5 zdn:5
+NBSL        A64_V    00000100 11 1 zm:5 00111 1 zk:5 zdn:5
+
 # Bitwise Shift (Unpredicated)
 ## bitwise shift by immediate (predicated)
 SQSHL_imm   A64_V    00000100 tszh:2 00 0110 100 pg:3 tszl:2 imm3:3 zdn:5 \
-- 
2.25.1


