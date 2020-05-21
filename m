Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A30CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E6220814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DjfFF2US";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="eqs8YP38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E6220814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr9K-0001le-Bb
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpR-0006Wl-Jy
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:05 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:9769)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpQ-0002TR-Hn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089164; x=1621625164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=F589UIiMpTM9QgNqWl+Cf9Up9osvVO/VSBKhR36NdR4=;
 b=DjfFF2US/ZMvoIf0uPp/V3GKwj8sKwrxQEW3GDBkHQDKxhu3rr6THMYj
 fqhn+0YsujNECJ/uBrICf4LhBxZaWmVw/hOdScfNGYN40Wz76ROJfihwA
 f7hKEKLUCx72P0lYXwWaDBcuKgxeTkdy//il7WLgnTwsvxhzR/uCMrqk7 M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:53 -0700
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:53 -0700
Received: from apsanexr02b.ap.qualcomm.com (10.85.0.27) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:52 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 apsanexr02b.ap.qualcomm.com (10.85.0.27) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho7sdPZobZAuh+RVh8Ovk8R+4POiaxqzsO+WuwDZSm5P8kDa/2plw3MFt3wauo87/57oVaeVXFCSXB2HjpaDm8w+ceThjt/ohTvRyg/9PYgdzxMLY/5grwKbouIiMflg+LTq67r4g9GTTfMtsEcBsGBwar4eG1XLW1okJ5Lkx7wmJ2aBSznrMpObpT0HfhE1cS/UmhdjT8C8BVAserimK9F8QVe8fkvA/cW3ftc+1uM+7BxTLxGb3cdOhIDnH5u5eV/VrbqNGzs9IY5zq4aVUakJVeai360NrF5cRPp/z7KwpTFyoXWPBERtq856RyagErV082LNJcclFDrnYkqwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3R0OnHVMDPKKU8AA0TskJMfDUSbSLoIaiRNBhXd1KE=;
 b=eCILtvp23LjlrIJP9x9cdI1ZuGRWwhWGpeUs+4YSjeQBFprXlXgBcX3S5tW9TCVmSNslkjG3HrK5eTcM4KrQZ0kQXAXS4lt3z4OYkxsyU7d2c1LbBmjhQjg25mSVMJH2Uo5B0q2M468KaOEeqb77X4qeEazlAkRh9gRVnFksibAJeYJTheJXWo0C4J4yH3lSDmCwQ+SYn6w750s2yBkPEtx/fkGSieg6BW4vZwGko4qoQkY/yDd6WokOZzX5Gukcf3gfCOOVPKbvvC/FcGkFYy1GnMTx1GXYSaj4omqxAmf01NI//KgQZANIAiklHJ7c0n9c33/Op2sXzVVvFU1mbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3R0OnHVMDPKKU8AA0TskJMfDUSbSLoIaiRNBhXd1KE=;
 b=eqs8YP38x/rVan9mJT0zLzHNucJwiK2YLu9cdTQZfA+FP6wBkKdxbMJHWArouLe+jjky5aaq+EUT5hx+50yOAZEje3Z83KFWFB0EFFiLQydTriPjlZhwIChCIyKxagF/z8DKTKYIMr/1Wqgy5BVKsw5S0YFDG0zQzq92zXpOaZ8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:48 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:48 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 19/22] sve2.risu: Add patterns for integer compare ops
Date: Thu, 21 May 2020 12:25:08 -0700
Message-ID: <20200521192511.6623-20-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:47 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61f6913-d2ae-48ed-3561-08d7fdbcc3ba
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB348491987AD9B68D8D5362B8C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3HIpY5voXL44B9Jnj2I2kYUfM5RHVidDZROjUas0FdfQjB5nTGhTU0LWNn+NkTvBf2HMIDfDsV5AOuEQQAyGIk1WiTvUchLFOBDqyORb9AKV/xkWWULA1Izk7nYdj6ABepmJjYMfsIUlwIInCCvlBEAQdaI06sG79R8DSjPl9UQdscFi0aO5PgMZR9Y1juLtVOfNbioeKaq4aNJWcGVemrxbcRmhd/mKnldEg58f0Hd8w95npthidQWd0igB+T48vuuG5FJv4BPlItb1VeW9JDltPCaLCoDgk2RK7CIzQaxXnseOodbH+GRTPl34RAWAdeh28FRuJtLH6tU9xUABQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(4744005)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P/otqb63NAYXWu75my7s7RRgtWxQeYXw6R6MekRB3kse5S0c5ouOXvovbyHrpa6EbwNP9AVjx0UOAAF/AGW/kr/UWW9ZFx1eQ5V/ruYi4oX/XUm4BEL4JixM/uvGA9eFb7xxC3V9vcqIyVC752fm15ZKItdA4hr3OqwZs6wcT7mpbnr75uDobvSC4FKI6fydhrDmhA/lu8djZaJHY+6Qxl8ZjSXMZO+oI9GMFSLB3HOoFzGSq79z3RUkcrEMhu5BVCjwAr+eU8B9/nFA96K7U7NLUwXSsX5VdfQXPsRZtNKq0yxnJCSkE4C42X/A7sGNicSJSaLKLLIgyuZ9cGOPg5S3VBgUs7UH3eCu4nSj/Vcp7Hfudb3R3DPYbsSpIRv8QtvWrsvdUP7cFDmhoZXPYLYTS5ALVnTa49g2TDkKtDXDxAeyDPjxM+gSM0pq/u3Phd5yHkXZWb7cUlfh66ydfjkNuL8lcBReohJcc+HWuNE=
X-MS-Exchange-CrossTenant-Network-Message-Id: d61f6913-d2ae-48ed-3561-08d7fdbcc3ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:48.4448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaaT5lc7HX3DZrDDxO8QqfxybeJFc6nNKS6japhxOjoDgjQUoe29cCg93I3VwEyRNg6nrNiSJ5cvmEBGC2UQag==
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
 sve2.risu | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 7f70bfa..44f227e 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -470,3 +470,13 @@ FMINP       A64_V    01100100 size:2 010 111 100 pg:3 zm:5 zdn:5 \
 # Table Lookup
 TBL         A64_V    00000101 size:2 1 zm:5 00101 0 zn:5 zd:5
 TBX         A64_V    00000101 size:2 1 zm:5 00101 1 zn:5 zd:5
+
+# Integer Compare (Scalars)
+## integer compare scalar count and limit
+WHILEGE     A64_V    00100101 size:2 1 rm:5 000 sf:1 00 rn:5 0 pd:4
+WHILEGT     A64_V    00100101 size:2 1 rm:5 000 sf:1 00 rn:5 1 pd:4
+WHILEHI     A64_V    00100101 size:2 1 rm:5 000 sf:1 10 rn:5 1 pd:4
+WHILEHS     A64_V    00100101 size:2 1 rm:5 000 sf:1 10 rn:5 0 pd:4
+## pointer conflict compare
+WHILEWR     A64_V    00100101 size:2 1 rm:5 001100 rn:5 0 pd:4
+WHILERW     A64_V    00100101 size:2 1 rm:5 001100 rn:5 1 pd:4
-- 
2.25.1


