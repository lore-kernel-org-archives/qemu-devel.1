Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A8BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A95207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jMDiX8lJ";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="jzgLQVAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A95207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqxs-0008LS-5r
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp4-0005Ze-5o
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:42 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:9569)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp2-0002NA-Pt
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089140; x=1621625140;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=zu5umXLra3ndpju4jmgD01nxylZIq/RmhVMuVzwKWRg=;
 b=jMDiX8lJvKFTcqT8thJ5ov20HjCtSPOf3QO54MQjPYy6Tol/fRJxDwg+
 eAuom2fDKRRJ2qYRIAv5GaO5z2t+kpfcDqJglzDybPD54wRD+x834pzA2
 qfTurXz/I4gGQfdmlYJEnc3ocNa1JoG62XysyFK5iWkrxALfSfXfI7bPG Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:38 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:38 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrwY155Ejms+oHjKaqA7PjBpB30Mn4FcNosV1dpqDI4oGi0xLwe/EErU9wAuYntjj6+vKdDjravHlIHfrgl2ZZFHuxXDbdQIlkORlWdSS0MYaBM3VInfTlmqG/dlQ5AaCzuLvlAcSlzQePq2zdaKE+K2e5JK+APu5BJhTx7pbB4Dcpk4pasrp+xW8nBfgd1NJc7CNcI1HV8ay/vFmOsJ3v689jg5vVLqzqwym9DR3/GOT+l5LhwyFQrqE5jYsdmSnjnBYwXX3W6UK7yiRUK8aapodePAKtik0a+VzwbXV2lg8H9ADL4OCjzOyfhCdJOQK1WISdDknKxI39tmnwtmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkASLzOakw7jVpwY7j/W6xiPjwUQ9D8cD7bVX2GUdKg=;
 b=XdHVq0i2N64v+94AL9JqYmcSWqy5JspkPTRnaAwazgpJFtAvDXjb+Ians2RHO9hZFiI3462dFrJLjU4xcMolaE7IAsz9l83U2LaOgyZS/Zf94b1VheSsJGRE3TdBZvZc47PTfUOr4PPDmKa49rtYAnfkXTYeNahIkIuTBdtTYDPFA86hZyRJcjvS5h1JBU9DstVRk0rT7JPPX3DgfEfEcUeNohzQIhmNlkk9oEe8hVeKIVgwW25ccgRYOyeSJr45FNuESYK1lL8dQe5lqaQZN+UmSTCBbw9UfVXSLhmHSS0jYxh5K86+0geOpID736SHA0BcuNX6nNuUwNdF+eAZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkASLzOakw7jVpwY7j/W6xiPjwUQ9D8cD7bVX2GUdKg=;
 b=jzgLQVARKcbWm58JlE2qspNNStRpAemImHf2009nAZPm0yGTVoETOaeHS8CTHF7p/BJ2lZrVIMVyBLsye9WFDKEiYiYGpih9DOqbKn22boLCrivHWMNHPpsDyi9RggPXEuORfG3fwNNAHir3JJjeafRsNWPM6NwgbWZVScKfQus=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:35 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:35 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 07/22] sve2.risu: Add patterns for narrowing ops
Date: Thu, 21 May 2020 12:24:56 -0700
Message-ID: <20200521192511.6623-8-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:34 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 767cb075-37fe-4258-a3e8-08d7fdbcbc0c
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB348439BCC1454BB15B910518C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7DLRPOZOxbXPgIsDSq9+Ht/0J/xXYAmrP1peW/7pLkideCVoyckZo6YavWdAAQ5hh6iXKiS2UhyBa7L5foZvPInSsfFWKxW72R6SQJ3W2HU0m3JU3dhY5GJAyEMiHn/wcIlPFOS3f1KceYicYjLSbl1w7G/1juhfijJXXp9AhgrN9km54cRh78BCnO0OekA7v5gM3tlFKL6v6VSwMJIxz860UqDeF81B5IJR0r+ACv/ODFZr1n0lbhVgAsTaE9A8VRrHX5T8xWCMtC2baJOub2Sqp/QFPfBq1TQ3xz01k0Yao7xuXcaifQqPjTjJuAQYbLzilZ9eYbZ2YN1bCd/Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7NJf3Kw/MitpSoMVv/Qf/vtFFEDMjeuBj+EzMyGZn1ciWFW53RNV/+KaF8w9NVu/rooKtTCLSUQQCMt/bhh+wQ/i2WbEaXQJ3557CX2I+RsBcm4bbURCXM+E/VFfW2hdMTRlZ1kPJLgZ5cfoC3pa58DDFEYeQNFnzGd2lTK+Zu2e37axolY369ucRucoxtR6fEN+y4E8rpHgAbsOE2bofppQ1hAIVnk0lZ2Jhv9JSvU5XJsoiuimpaibaVA5eKxpU+z+Ha2vD0R8FNwfjGRjRgvIzx4T25XSQUJa0dqa9AFfztz8qFT/6DCkrVInvsJQCw4S5v1mqQg0s/G3IvCTfVfLWy0wsJl0bz85tTCFoiltAdyA3NfBZqrztFIPKOMMyaIAh1JVmLian5JIi3WbaxSG/k/Pez5KfKpNP60wgyH5Yclgk/Oum2KWgIp5IQ+89FOrL/Z4zZZLHhdAxBkdymGk7R+RKU5pLMlS+eteunc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 767cb075-37fe-4258-a3e8-08d7fdbcbc0c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:34.9746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0rseMFYebeI8bf5rwUcIM3Y+KpkTuECdvBwH1ayjM3ljvAzVDJ5eC4W2PMTQa9QYtmKlOwEwgX/iiMyXFx8yA==
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
 sve2.risu | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index caca5c0..1ebb08c 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -184,6 +184,82 @@ SLI         A64_V    01000101 tszh:2 0 tszl:2 imm3:3 11110 1 zn:5 zd:5 \
 SABA        A64_V    01000101 size:2 0 zm:5 11111 0 zn:5 zda:5
 UABA        A64_V    01000101 size:2 0 zm:5 11111 1 zn:5 zda:5
 
+# Narrowing
+## saturating extract narrow
+SQXTNB_H    A64_V    010001010 0101 000010 000 zn:5 zd:5
+SQXTNB_S    A64_V    010001010 0110 000010 000 zn:5 zd:5
+SQXTNB_D    A64_V    010001010 1100 000010 000 zn:5 zd:5
+
+SQXTNT_H    A64_V    010001010 0101 000010 001 zn:5 zd:5
+SQXTNT_S    A64_V    010001010 0110 000010 001 zn:5 zd:5
+SQXTNT_D    A64_V    010001010 1100 000010 001 zn:5 zd:5
+
+UQXTNB_H    A64_V    010001010 0101 000010 010 zn:5 zd:5
+UQXTNB_S    A64_V    010001010 0110 000010 010 zn:5 zd:5
+UQXTNB_D    A64_V    010001010 1100 000010 010 zn:5 zd:5
+
+UQXTNT_H    A64_V    010001010 0101 000010 011 zn:5 zd:5
+UQXTNT_S    A64_V    010001010 0110 000010 011 zn:5 zd:5
+UQXTNT_D    A64_V    010001010 1100 000010 011 zn:5 zd:5
+
+SQXTUNB_H   A64_V    010001010 0101 000010 100 zn:5 zd:5
+SQXTUNB_S   A64_V    010001010 0110 000010 100 zn:5 zd:5
+SQXTUNB_D   A64_V    010001010 1100 000010 100 zn:5 zd:5
+
+SQXTUNT_H   A64_V    010001010 0101 000010 101 zn:5 zd:5
+SQXTUNT_S   A64_V    010001010 0110 000010 101 zn:5 zd:5
+SQXTUNT_D   A64_V    010001010 1100 000010 101 zn:5 zd:5
+## bitwise shift right narrow
+SQSHRUNB    A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 0000 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SQSHRUNT    A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 0001 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SQRSHRUNB   A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 0010 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SQRSHRUNT   A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 0011 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SHRNB       A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 0100 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SHRNT       A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 0101 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+RSHRNB      A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 0110 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+RSHRNT      A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 0111 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SQSHRNB     A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 1000 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SQSHRNT     A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 1001 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SQRSHRNB    A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 1010 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+SQRSHRNT    A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 1011 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+UQSHRNB     A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 1100 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+UQSHRNT     A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 1101 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+UQRSHRNB    A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 1110 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+UQRSHRNT    A64_V    010001010 tszh:1 1 tszl:2 imm3:3 00 1111 zn:5 zd:5 \
+!constraints { !($tszh == 0 && $tszl == 0); }
+## integer add/subtract narrow high part
+ADDHNB      A64_V    01000101 size:2 1 zm:5 011 000 zn:5 zd:5 \
+!constraints { $size != 0; }
+ADDHNT      A64_V    01000101 size:2 1 zm:5 011 001 zn:5 zd:5 \
+!constraints { $size != 0; }
+RADDHNB     A64_V    01000101 size:2 1 zm:5 011 010 zn:5 zd:5 \
+!constraints { $size != 0; }
+RADDHNT     A64_V    01000101 size:2 1 zm:5 011 011 zn:5 zd:5 \
+!constraints { $size != 0; }
+SUBHNB      A64_V    01000101 size:2 1 zm:5 011 100 zn:5 zd:5 \
+!constraints { $size != 0; }
+SUBHNT      A64_V    01000101 size:2 1 zm:5 011 101 zn:5 zd:5 \
+!constraints { $size != 0; }
+RSUBHNB     A64_V    01000101 size:2 1 zm:5 011 110 zn:5 zd:5 \
+!constraints { $size != 0; }
+RSUBHNT     A64_V    01000101 size:2 1 zm:5 011 111 zn:5 zd:5 \
+!constraints { $size != 0; }
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


