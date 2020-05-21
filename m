Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F52C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025772065F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IMB3f57G";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="esdWhIXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025772065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr6B-0002ts-44
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpL-0006FY-Vo
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:00 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:35792)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpK-0002Tf-Hd
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089158; x=1621625158;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=FPBRN1WPGE4AqNKQuAaH/3ikw72fAM+cPKkd5k9oFGE=;
 b=IMB3f57GqEJJvtmq9P+dlTYZ0Jc7wTxzmIKLJuo0HV9JCifnKvHXLfsx
 TSS9EjfZnJ0XDd3jf0pY3jgSYlB99eJ3nGTmT+aKu6z88hRbDAidSe8ux
 3p9GdMgwSHcTCV9XZmtMIQ8sijIBD+TJn2aBlCtD39I9XJovYWgyd4/n1 w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:54 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:54 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXcpalUWHWguDAVzRMB0ESPFkqV4zl4IDBMGmJUuQJiYnGD65tV++aP/PFhSjd7zu3cCMU0R/NIN+sswrB8TDTJMNuYScswfnnnA/9FrXyHI7QaNrepeJgxkQSUGjpe1Lt/T9f/PsJhy7DX+uvPAm2XroxBNM26/2LU6Bs83U2wI3kVh0dwuLMAubl44d89wuyF/UGqyWWzb5QdULUs3iOn32mYdyJpbyAIFNORbr6Ik85XRXK4czPCOu+v1yqHC/iM1DccXZ9N75tacoAolQT5xO9BNSvpzjR2rkSE0CGP6oR8zaaL9GazFgPF8cqerg2SlFSMmfqwTeVK8LNcIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62tuODG5xf4+oxw2RUxXti9aRMgn7FsvaRi23uuq3VQ=;
 b=m9/B5bO+zNEkEAfJ1X3iZ4rk2E9v5Zu+acyJTzxrutzAlWkY4ELR0h6eW0s0t4mwIvxZfSE3II6gYiHdbsFjrdvXOx4hvWS9v1g4Ec7YwgqZQhJo2IA/vQSBMQDmz6+4FUV+8VueNzhIHRdkg5bJQz6KSGs+8QhtSoEKI9B8gvPNyyJvdhfgSBkjLJe3v7E2dUG1vd8Nujy5kXw9peNMbnOx02Hpe4kTZ7QepLyh6bJl0VCpZJFj9FImJyfTAYOAzPuAXQFhL7e7mh7b1FJrIwmuxkuqiWCuItBr3F+UQOzJsiVpDKcq2xnuECoPOAKLePaopCnETknIevPB29GGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62tuODG5xf4+oxw2RUxXti9aRMgn7FsvaRi23uuq3VQ=;
 b=esdWhIXH3UHldt53B6UQt1qPH987j0hrlMdKA4UEq3QXyZoC3FUWZMt9nCaUXJb5B0gcPr4P6QKnEvRoQKxCjP434R5r98A4LyJfT0wNljh5PpGogsOlvl0cLs9uyfPyLrC3Ewcepg2IzZoZVY/ypgXT2FRGfDhIaiAvccimGf8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:45 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:45 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 17/22] sve2.risu: Add patterns for multiply (indexed)
 ops
Date: Thu, 21 May 2020 12:25:06 -0700
Message-ID: <20200521192511.6623-18-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e4d892e-a82a-44bf-e303-08d7fdbcc24d
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB36271CDB0C8FE38E06E4911BC7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cy7HY6W+KHIlKG3FjIHz5l90/gqhb15VJfynYGWjqq0xi8IYrCqxGotUlWGtbMGOx84Kj7Kvy0yPQxcQjyMeFUZnBsnyCajfG0MIYPyu5rodXewGkADQshPTfsARAYzfSc/JYBFYDRbz5ISUGs9ZXFHaNh6XmsLutMnEEBy2JeJtrTzFzVUwXRuE3c9B+oBgKEaFdVQHr9Q7/ZMIvjeX2bYwyszHKEZIYTHj8EYhao+mVf7djVy6oUhafkdL2h0NCW4XTssVoygxKizyuFY/QY5pvAWLue63PszLIaUdKdABsLA69lFuDKRxDjTtsYE+Hli9FU8uLfFJbvgUwJcheqEEtP5uhGlUS2ESHvrSli5xKpaCGAWF8l6nBP3tE+oV5gUzP3yTeL5r95kQIyv6DbwoB5ezeCJ94In0ho8tRO90yqykZ/Dwlm/YAOukRx/5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:cs; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CSYoqYwIxOR//5fNxEDm34o9SVVZPpGHhmVLZV6uBWAk+QhLinosdUgFCOm8KQTg+sj/ctV3QSp/IsuRyAD+HLzYwMti4zEzbVa8Bmn3eUiPOYcdmPwf7ZqLOsTQlOzJNWxLLh67SNsdaKmstQfu3ryJnn3+foJgkbZaRXLE5/Au4MAAOcNW0B4zApQlJ0Cb31W+zFKFWWTUbX+SF7qNo+H6f1HzceXYd1mglNGx86AW7FLXwuv2oKkJfBQs/f3/Ok6BEba7ZQEaO3eZ+P7lxag/sBGknRJhMujRD6bBSLOfoRIOn2AqfN+G7bV7BMKHieYbxUxR7xKxSdj8mDmCOeB74wOB9Ny3zFxA5gkBQzJb4Yc8EfsXEouqrw19p6N7khXk62IAe9M85ehxlEThmqngp6MA4OkotEXPafRqlb1bzckMa4U0+3k0ukWDei+Gw7215szFLxGIalejrdcxJk+xvTKNgzS6XpqbORjkW0A=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4d892e-a82a-44bf-e303-08d7fdbcc24d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:45.8743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GETtS2NMP5Sa0KCag1M+11ZNUBsq5rECLM47DCL2Pr/BKCeKshteRgW9QASqBs/7AwZSK40TFqKUucU1sKxlQ==
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
 sve2.risu | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 8602059..1bcbd93 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -66,6 +66,92 @@ SQDMLSLT    A64_V    01000100 size:2 0 zm:5 0110 11 zn:5 zda:5 \
 SQRDMLAH    A64_V    01000100 size:2 0 zm:5 01110 0 zn:5 zda:5
 SQRDMLSH    A64_V    01000100 size:2 0 zm:5 01110 1 zn:5 zda:5
 
+# Multiply (Indexed)
+## integer multiply-add (indexed)
+MLA_H       A64_V    01000100 0 i3h:1 1 i3l:2 zm:3 00001 0 zn:5 zda:5
+MLS_H       A64_V    01000100 0 i3h:1 1 i3l:2 zm:3 00001 1 zn:5 zda:5
+
+MLA_S       A64_V    01000100 1 0 1 i2:2 zm:3 00001 0 zn:5 zda:5
+MLS_S       A64_V    01000100 1 0 1 i2:2 zm:3 00001 1 zn:5 zda:5
+
+MLA_D       A64_V    01000100 1 1 1 i1:1 zm:4 00001 0 zn:5 zda:5
+MLS_D       A64_V    01000100 1 1 1 i1:1 zm:4 00001 1 zn:5 zda:5
+## saturating multiply-add high (indexed)
+SQRDMLAH_H  A64_V    01000100 0 i3h:1 1 i3l:2 zm:3 00010 0 zn:5 zda:5
+SQRDMLSH_H  A64_V    01000100 0 i3h:1 1 i3l:2 zm:3 00010 1 zn:5 zda:5
+
+SQRDMLAH_S  A64_V    01000100 1 0 1 i2:2 zm:3 00010 0 zn:5 zda:5
+SQRDMLSH_S  A64_V    01000100 1 0 1 i2:2 zm:3 00010 1 zn:5 zda:5
+
+SQRDMLAH_D  A64_V    01000100 1 1 1 i1:1 zm:4 00010 0 zn:5 zda:5
+SQRDMLSH_D  A64_V    01000100 1 1 1 i1:1 zm:4 00010 1 zn:5 zda:5
+## saturating multiply-add (indexed)
+SQDMLALB_S  A64_V    01000100 1 0 1 i3h:2 zm:3 001 0 i3l:1 0 zn:5 zda:5
+SQDMLALT_S  A64_V    01000100 1 0 1 i3h:2 zm:3 001 0 i3l:1 1 zn:5 zda:5
+SQDMLSLB_S  A64_V    01000100 1 0 1 i3h:2 zm:3 001 1 i3l:1 0 zn:5 zda:5
+SQDMLSLT_S  A64_V    01000100 1 0 1 i3h:2 zm:3 001 1 i3l:1 1 zn:5 zda:5
+
+SQDMLALB_D  A64_V    01000100 1 1 1 i2h:1 zm:4 001 0 i2l:1 0 zn:5 zda:5
+SQDMLALT_D  A64_V    01000100 1 1 1 i2h:1 zm:4 001 0 i2l:1 1 zn:5 zda:5
+SQDMLSLB_D  A64_V    01000100 1 1 1 i2h:1 zm:4 001 1 i2l:1 0 zn:5 zda:5
+SQDMLSLT_D  A64_V    01000100 1 1 1 i2h:1 zm:4 001 1 i2l:1 1 zn:5 zda:5
+## complex integer dot product (indexed)
+CDOT_S      A64_V    01000100 1 0 1 i2:2 zm:3 0100 rot:2 zn:5 zda:5
+CDOT_D      A64_V    01000100 1 1 1 i1:1 zm:4 0100 rot:2 zn:5 zda:5
+## complex integer multiply-add (indexed)
+CMLA_S      A64_V    01000100 1 0 1 i2:2 zm:3 0110 rot:2 zn:5 zda:5
+CMLA_D      A64_V    01000100 1 1 1 i1:1 zm:4 0110 rot:2 zn:5 zda:5
+## complex saturating multiply-add (indexed)
+SQRDCMLAH_H A64_V    01000100 1 0 1 i2:2 zm:3 0111 rot:2 zn:5 zda:5
+SQRDCMLAH_S A64_V    01000100 1 1 1 i1:1 zm:4 0111 rot:2 zn:5 zda:5
+## integer multiply-add long (indexed)
+SMLALB_S    A64_V    01000100 101 i3h:2 zm:3 1000 i3l:1 0 zn:5 zda:5
+SMLALT_S    A64_V    01000100 101 i3h:2 zm:3 1000 i3l:1 1 zn:5 zda:5
+UMLALB_S    A64_V    01000100 101 i3h:2 zm:3 1001 i3l:1 0 zn:5 zda:5
+UMLALT_S    A64_V    01000100 101 i3h:2 zm:3 1001 i3l:1 1 zn:5 zda:5
+SMLSLB_S    A64_V    01000100 101 i3h:2 zm:3 1010 i3l:1 0 zn:5 zda:5
+SMLSLT_S    A64_V    01000100 101 i3h:2 zm:3 1010 i3l:1 1 zn:5 zda:5
+UMLSLB_S    A64_V    01000100 101 i3h:2 zm:3 1011 i3l:1 0 zn:5 zda:5
+UMLSLT_S    A64_V    01000100 101 i3h:2 zm:3 1011 i3l:1 1 zn:5 zda:5
+
+SMLALB_D    A64_V    01000100 111 i2h:1 zm:4 1000 i2l:1 0 zn:5 zda:5
+SMLALT_D    A64_V    01000100 111 i2h:1 zm:4 1000 i2l:1 1 zn:5 zda:5
+UMLALB_D    A64_V    01000100 111 i2h:1 zm:4 1001 i2l:1 0 zn:5 zda:5
+UMLALT_D    A64_V    01000100 111 i2h:1 zm:4 1001 i2l:1 1 zn:5 zda:5
+SMLSLB_D    A64_V    01000100 111 i2h:1 zm:4 1010 i2l:1 0 zn:5 zda:5
+SMLSLT_D    A64_V    01000100 111 i2h:1 zm:4 1010 i2l:1 1 zn:5 zda:5
+UMLSLB_D    A64_V    01000100 111 i2h:1 zm:4 1011 i2l:1 0 zn:5 zda:5
+UMLSLT_D    A64_V    01000100 111 i2h:1 zm:4 1011 i2l:1 1 zn:5 zda:5
+## integer multiply long (indexed)
+SMULLB_S    A64_V    01000100 101 i3h:2 zm:3 1100 i3l:1 0 zn:5 zd:5
+SMULLT_S    A64_V    01000100 101 i3h:2 zm:3 1100 i3l:1 1 zn:5 zd:5
+UMULLB_S    A64_V    01000100 101 i3h:2 zm:3 1101 i3l:1 0 zn:5 zd:5
+UMULLT_S    A64_V    01000100 101 i3h:2 zm:3 1101 i3l:1 1 zn:5 zd:5
+
+SMULLB_D    A64_V    01000100 111 i2h:1 zm:4 1100 i2l:1 0 zn:5 zd:5
+SMULLT_D    A64_V    01000100 111 i2h:1 zm:4 1100 i2l:1 1 zn:5 zd:5
+UMULLB_D    A64_V    01000100 111 i2h:1 zm:4 1101 i2l:1 0 zn:5 zd:5
+UMULLT_D    A64_V    01000100 111 i2h:1 zm:4 1101 i2l:1 1 zn:5 zd:5
+## saturating multiply (indexed)
+SQDMULLB_S  A64_V    01000100 101 i3h:2 zm:3 1110 i3l:1 0 zn:5 zd:5
+SQDMULLT_S  A64_V    01000100 101 i3h:2 zm:3 1110 i3l:1 1 zn:5 zd:5
+
+SQDMULLB_D  A64_V    01000100 111 i2h:1 zm:4 1110 i2l:1 0 zn:5 zd:5
+SQDMULLT_D  A64_V    01000100 111 i2h:1 zm:4 1110 i2l:1 1 zn:5 zd:5
+## saturating multiply high (indexed)
+SQDMULH_H   A64_V    01000100 0 i3h:1 1 i3l:2 zm:3 11110 0 zn:5 zd:5
+SQRDMULH_H  A64_V    01000100 0 i3h:1 1 i3l:2 zm:3 11110 1 zn:5 zd:5
+
+SQDMULH_S   A64_V    01000100 101 i2:2 zm:3 11110 0 zn:5 zd:5
+SQRDMULH_S  A64_V    01000100 101 i2:2 zm:3 11110 1 zn:5 zd:5
+
+SQDMULH_D   A64_V    01000100 111 i1:1 zm:4 11110 0 zn:5 zd:5
+SQRDMULH_D  A64_V    01000100 111 i1:1 zm:4 11110 1 zn:5 zd:5
+## integer multiply (indexed)
+MUL_H       A64_V    01000100 0 i3h:1 1 i3l:2 zm:3 111110 zn:5 zd:5
+MUL_S       A64_V    01000100 101        i2:2 zm:3 111110 zn:5 zd:5
+MUL_D       A64_V    01000100 111        i1:1 zm:4 111110 zn:5 zd:5
+
 # Integer Multiply (Unpredicated)
 ## integer multiply vectors (unpredicated)
 MUL         A64_V    00000100 size:2 1 zm:5 0110 00 zn:5 zd:5
-- 
2.25.1


