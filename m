Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9FDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73ECE204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dTTBjGmu";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="johuI7h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73ECE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr0a-0006gP-M7
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpG-0005ww-2C
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:54 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:9769)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpE-0002TR-TT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089152; x=1621625152;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=vIrMvlaJoM8lfUDBifuXkVmNBEggVlJibyTAIaW+5cQ=;
 b=dTTBjGmuvZF81QlTTzjSbi4GjY8FdZdhBLej1CsySLVuJBigIfsGZkrV
 Qrx9M0M27/321sxbWBxGId3LV6vIPiVuSaRu5g3WxgDugbUVZkBG/uhDN
 fY3goMpI7n5qGKikJJqbrFhP3JXvXWN1xjsYhYh0gOlcaWiTcbKDj7/v4 0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:51 -0700
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:51 -0700
Received: from eusanexr01f.eu.qualcomm.com (10.85.0.101) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:51 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 eusanexr01f.eu.qualcomm.com (10.85.0.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=macZSvQL8h9uRbkAfAc7R9X8qoMbtYuCpefJslBhGFxng/wR1roihzTerewwywhmuC9D+hyEzJOTRCkyjWsxGu/oGqGRjTNbjkyWkYNsVbKE17F2Syf2lUFhCGuvvG/9JE9WV4MMVAw+7MT/1cyhOmAcJSrwrlUWSzN5KLmDVlQXQloa8jDSjiga4u2hmJCdqSABphj4FIMiIM9Zks2+japnPQl82H5GaKJYCrW5jbl0weqKZnGBZz+k5cHoeNST6tM12TXM5gIDrykxd4YAg38NtkNWMm/RfFpZu+XJB010kJ95Um9/8qvsyIyPgci9bRMyeTKZxvk6jUPpV8myvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqR4eVu0IdYjhNfZrjQWf92bfbNJ+11GkPlkmE7DEnw=;
 b=naatqZRkJvEoymK/DlM5OxOn8qYsGKzK46j4bmUlnH6gkk4KTIPk3kxkWpdCKXsDCpBcyLFpZryn+G3hlj4bWt9pHiQXt3+GBFtdNZfiTYwDbpirEtItR91bSb76mtdCyov7Ff75tzBYondwSqcBvoRi3CALSzDnt+cxqsWhamu21grjZKC3ppj9ezYA9BP9TTib22FiyiZd7vFnLki3aei3wWammlBx/WfX238HdyODUBkQKglZM/J2857QdFKJijmUdN4ecq0kEbJoFAoiFK8ccEkHQZhtdwdxjJr1BU5XKwufpWQfFLO4hI3VnYBgeAGc3SkUC4i9QqEbVsRpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqR4eVu0IdYjhNfZrjQWf92bfbNJ+11GkPlkmE7DEnw=;
 b=johuI7h9XxCEWzCfUXPBquaiIrlasC8vVKzwx41bcIAhW2xg+LaByewMUDnf/nwvq1UOQmClUbmsKid8AIgLZjDkF/lzjbLH4ikIjQhGfjCOukjiU0p61RUQLJaHD1b8rwS8E0ekqUDxskqeQh+aSGOVJ7vExM01lsv8kNvBANY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:43 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:43 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 15/22] sve2.risu: Add patterns for table lookup insns
Date: Thu, 21 May 2020 12:25:04 -0700
Message-ID: <20200521192511.6623-16-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:42 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9d98c69-18e2-444a-65c3-08d7fdbcc117
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB362711219955909A35F9F9EFC7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dmclAo1e5+EPPCddHK8ZJ4Jqh2ksZ9Wlw42R04FPm5P3cR7MgiWcM8lswoGQe3zmO0dqJiSvGMX0ujtmCmZgZs+i6YQx9WGA7nMGHLYWeuf9ag6/onNiRObIqZbthcodrG2bBcgf9Zd3YZLS2CK8Q5KO8HB70p5UzZ2R1NNjWf0qBqRZP1tz+/CZDkz3CEDKnRtxX36x55E18DcWbUgkVXdUaGYEqsxks7BUuIBTV1b6RZ6Y0vhAANWEZS6q1NQKWoK/lCQMY89uIBlueTO40c4i5mXaJvZ9b2vSB2xpROVvNCOg03A1x2J3mA3a0fG3ANgGp15DEIO5l4f6EXRacgFxpA3jGSva73WmelymJEdv9X3m0mHhdu6K24N7bi6GUZNQGRzaFzj/etx9/5GcBzX0zcRR0yb15IeDw9o2ASQH+HJnSTNpQtaNeWpIJ0o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(4744005)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FoCTwuj7fmKQtxpyMHWyWcgatD+17M5U/fYoGG/50q/vIKIkhDOCm/yey/1YXzPlvgb/1g4MG40WBgVk4o3cdco3w4xUceaBv607BqWdbnbhG0F3JbMmQFFLMyGq5ZL/tCO7/QQ1jI7n1FEdnDAAJYnbZtnNr7aHizSJO3tzCFJY8u9kKCK5wnkhYVPS9wF4ucsV2srLLi4pWFCu1kn2VlslQzlZZhDr0n79egi9FTiP2kb12GJBLF7BdZhhBfaJtZq3PHZXSdgZLVHHJaL8xAqAQc6ic+AbIDl0BhKLWxjeAcjA0cqVzLuO1mNyXRW0hwZFxJMorhJBZMGhpJ14B62x0glGbxf/wv7C22AxUmbMw3vJrSoQEHX4L9Y5vcKDYFtiFGq4ehrVegpQsH8uNVWx24bmJ3Je/u+kOUxDA9DaZJsFcD10RV2M8y7WDxaU9Kpnv+qWIeMDXOofz6189MvcVHuuJtGo/V3i3QUP6hM=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d98c69-18e2-444a-65c3-08d7fdbcc117
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:43.5577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ps/8eCQ8kqSfJ8o97bgfENClQiHXAzzG5BN6rXwd51WX1VkuLw/oDMQZGrTtjeu2SYgatPE4V2h6foJoWIBtg==
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
 sve2.risu | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 48b2957..c48717b 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -333,3 +333,7 @@ FMAXP       A64_V    01100100 size:2 010 110 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
 FMINP       A64_V    01100100 size:2 010 111 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
+
+# Table Lookup
+TBL         A64_V    00000101 size:2 1 zm:5 00101 0 zn:5 zd:5
+TBX         A64_V    00000101 size:2 1 zm:5 00101 1 zn:5 zd:5
-- 
2.25.1


