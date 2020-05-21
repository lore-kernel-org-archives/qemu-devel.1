Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D07C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7F920814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AKhXTo5Z";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="jxANxaS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7F920814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr1C-0008Aq-1W
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp7-0005h3-F4
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:45 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:9569)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp5-0002NA-Gn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089143; x=1621625143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=IWFwfpIoAao4jDfNWuiM3Pv4IGU6alL9Ti8VPi+ePzk=;
 b=AKhXTo5Zf31GSb+gtuJmz6AcSoyu13q5jwvPcAQCtWYTwBG5VNym/tL3
 J7kZlHEhc5foRhnroZm92x8MYMlHYiYx2zjY81hl1NBiix2rcilIBv4gP
 OHzXbgDjWB1uI/8iejhd2SbYqX2dY+i6RfRRNa/vsevM4TfKdJhnLhhHm E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:42 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:42 -0700
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:42 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBOqO3Vj/LyHJD/DAQWAuxu2W8CukfHNn1+Oate+9qIT0PhSLCJoqL+zqaX+KxBQk/VnFh0dZdM0CrnqGTcMkFksb64JcaCQyFYOmNqtV0sXiI3QsvTcIW2oYh5yt4NMQeewAP6iURiydl1ACD8KvZ0sp5EB21GQNgzcxN/KmONWfS0IsMEZYpxIh4etmFdIAXP2ErapPyhTo8/1QrgsGQqMW0ed7yahK5qdV1X24mzzf9fQfhzkOi5G+JlWtJuyhXwzxpJ2WYR3P1Jt5gSCP6QdE6NG2UX8WBSt3oAWw375hhka/wz3v8Y6EQk4ns8Qq0HlpWah3KFjycaH7irVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhUlpTqKrwPN4HgFztA2qUe3kAmLFvfLHE5Fn9MUsDs=;
 b=FQYC9MLRaQ7mAeJE6RNs5BV9ZK5P4QxPrx7BgpZQwXUm2Q26Wp0DQIT62Tfoivmxe+nHEHlCtZJmDI17Wpawosado8iiZkQbkCZt3b0+kIKX145xqkfx7Cb5iOGIubJ3rghsPYwajA9xOHfIXXjpQNweGYtkla7kXgubaiUnspVSnzhXKeag4u6STtFM97gfBaLBkZRd56pTwc3hc1du2Z4ZDXA/K1ol25g2tLflqlzPboP9NfJAkI+EaicgF0nzxrYBlhVIIbR2+QMu3Ok/CfS6SsFUzGx9icA4uV2MyosbaBYSEID+UNx1nlvgdlf63OymXer+Px3BsQ2EvHFTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhUlpTqKrwPN4HgFztA2qUe3kAmLFvfLHE5Fn9MUsDs=;
 b=jxANxaS4+b21ywVri0J8ERS4jnWdzKpGtbkZ/hgfDpQcJWAUvBZGgEb4/AsSI6WABnFDjzHf3y85vTRauIzWXcSCT9ltHWMeMksBIVYi6a/FiWRTD4VZExz9yDZLA8893gyrrPk33Gz1BwZ/4b33uv7ERtWG8V2E/uGD8DH+n5g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:38 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:38 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 11/22] sve2.risu: Add patterns for bitwise shift
 (unpredicated) ops
Date: Thu, 21 May 2020 12:25:00 -0700
Message-ID: <20200521192511.6623-12-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791dc7b3-0ac4-4703-6103-08d7fdbcbe46
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3627F208F7DB4C192DE9E751C7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvG5wmwyC6zZWIn718WL5k4Zwx0ZluXp4qm9CVaTnnSSZ2p6SL54GvCoEC2HmR2qmxaMRkEMQkkX8vd5qNabcR01G+YZw7klJ95uITxwxz6rX1/tUjOgkey9v22vmsq1CM4EI/Em4Ku1C81pDZ9iAPzFR2YuoL64eLdnv4vnorAt5W84nyzF0QsEutXTHqjww2Wq4olZrDX1T9zfOIb5Nm0PZcC9agxwYDwKc6AMSGSgQlgyb/IG/2+OBjHEekeASjIdAAxpboszZRZQFDXpt1jEGIendHiSqSlL++id85BdDwhg9VQSAFQgv/vYRLUVmgrdgG7ApeYHiaw4Ceu/acBLlfDHlNzIA2/VkwMo65u7Rnal6MUelwcJUzNzYsEDKk78wgiZcZuDQ/0IehD2IrTaXT+nsMCw8U7jYgPvi9TEATA4PRudFR4cJGbNvRQH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gl4Qf72p+t0HQjT5a3e9ZV2YPuupIVoFay2hi0ps6Z19vcpEQlxBXRB8OkrK9knxYzaUNurGr1KijLGUt4s6YDXe5q4lWWs0iIxgvflVByqFJf8fuTzqayu6zNg0wKx6OjBFY2z2qaJib4jAouJ5vBz+e+SbMy1ILfMmafJlcuwJUZOMEm4ZfsWSPlksEj5/WFSwOIWcUjbujbvD4DWNbnEjsg3ysa/CwE7WvSMGsOFk0+r1eKS0VCyyM98qgI1dyIfZdQo8a3V6woQ12OKAxollFT1lbFokBamjiQy2POL1OWdc+4sHUul0wiNuX03FldiFzvZqw45agM/2CXXtUXGCEK9/vJlwgBzXpS0lKt+7B1JTCsNi3TywQHxo5nx5XOQZlwHto/iUnI3+hAeKYzLxtMxD4MqLIpa9j2Q8KFvhZWRzca07wJ4YjNxnWRkZcTf24udB+cp61IAsR7ZEThF9K40OBFJ4BbX7S4sP7Js=
X-MS-Exchange-CrossTenant-Network-Message-Id: 791dc7b3-0ac4-4703-6103-08d7fdbcbe46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:38.7974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpbiz8Djs40VsMlk7rf4nnwPKu6hXeLX/hVJ1W0JC4cg1aCKAcJC1KNmtpXflS0xUpcwcVfMAhWfp1utPviWNw==
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
 sve2.risu | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 6177848..adc5dd1 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -1,6 +1,19 @@
 # Input file for risugen defining AArch64 SVE2 instructions
 .mode arm.aarch64
 
+# Bitwise Shift (Unpredicated)
+## bitwise shift by immediate (predicated)
+SQSHL_imm   A64_V    00000100 tszh:2 00 0110 100 pg:3 tszl:2 imm3:3 zdn:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+UQSHL_imm   A64_V    00000100 tszh:2 00 0111 100 pg:3 tszl:2 imm3:3 zdn:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SRSHR       A64_V    00000100 tszh:2 00 1100 100 pg:3 tszl:2 imm3:3 zdn:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+URSHR       A64_V    00000100 tszh:2 00 1101 100 pg:3 tszl:2 imm3:3 zdn:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SQSHLU      A64_V    00000100 tszh:2 00 1111 100 pg:3 tszl:2 imm3:3 zdn:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+
 # Integer Multiply (Unpredicated)
 ## integer multiply vectors (unpredicated)
 MUL         A64_V    00000100 size:2 1 zm:5 0110 00 zn:5 zd:5
-- 
2.25.1


