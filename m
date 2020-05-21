Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90070C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C9E207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E6uExVSj";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="P9eq8LyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C9E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqua-0000lj-GZ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqp0-0005Nm-Cr
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:38 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:24324)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqoz-0002Me-3f
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089137; x=1621625137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=IWt8yzl4iCwTpULMohrZ8+1skiZeQkMOXD+uaFvKudk=;
 b=E6uExVSjiYLynn5sx+Cr/w/QNfGr98T1X33Kr5zNKazwN+GPEsAayKjo
 fUkPeqfZAA6bKpn1Xa9Mq7dytXUZ3lD6IVl4PgrxJXlkmDoDNUefAPMD8
 OnDFmjeXHR9hbhMxy4vZ5ogpr5mGGYevJ+/VukCqVl18Wjp8BmIO6ZutN 8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:36 -0700
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:36 -0700
Received: from apsanexr02a.ap.qualcomm.com (10.85.0.26) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:35 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 apsanexr02a.ap.qualcomm.com (10.85.0.26) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9jQ8ZIB4SbDBAFt1u6xcw+vFOpYLnrbj5PjwFrGWHqDPPZQyN5RiMUWba35JaovAFmKv0AHCK4ZitXW79TnEhNrA/nimpzHifSpooYLZCB7HNmi9rmcunDnGpk6IBONky0xgbjeegsK7tmoKMlIaDBicJbMUau7Kl4e1p7eGrFwspOjuomuS69aBUTkbF1TzFXLFyPKQSvzFgN5nq9m7OPKnq1ANiEpl+GvEVwI3H/x/Q+GBAlVjilkyz9XWggGjzEq6jvW2mn9nLYUSIgbjE7qoYILic3CbNCKuz0/rJTEWZwrMG/A8Xz3vI1zN6cjquJu2UDd9iVj13qfcuCcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yUHYf5WCpeFOrd5ca4yOCLKgujzFM80/cVkz6BignM=;
 b=RNYP9/HL4X9CeG6XUxE0BobIlKVFSHNsJ5tEYdbwYgCRdh/2gMFAOzeIwizYaUsHqCgJ0+TFRkqEqEGm20FghxvekQ6/LeT6sTrXwk2eP3J5l4pXLeD3Z7/XgRRI1/dAvPlToJpAU1f9cUiL+e6Nj1J6Q3cVIoJCVbuEiBEWaE8RvjjGqhZ4DKDxuTPi3ykFGYe2wLJ09pqf/CtBYUdeG0+jYWkoHqcvRAcfC5kQxt1HnR9QvZysrCvGjiJAIj7SLXYjMUo2NKmEkIqfrsQuPGHk4CiH04LvBrw03Fgo1QRuCTPKFUuYymt/BUxfdgMZszu49TOK+m4Q3P2/i3jOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yUHYf5WCpeFOrd5ca4yOCLKgujzFM80/cVkz6BignM=;
 b=P9eq8LyQKe+obEtUVrxkz5uvEMo8vuOxSfxIZZBQQJ3uNYFhkdUv9YjGhWAVqv642RWPZFaEGBerIZNT6ZUfzU/4BBvuwF72eGv6NyqKDazvXvSdSM9lnyqAz0YuCO36H44o8tFgqgdfpF0uyLQaaO/dbiq+OlgZX0n4GiSnEKo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:32 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:32 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 04/22] sve2.risu: Add patterns for widening integer
 arithmetic ops
Date: Thu, 21 May 2020 12:24:53 -0700
Message-ID: <20200521192511.6623-5-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:31 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9511d89d-8f53-4d2e-023e-08d7fdbcba38
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34844402D66BF740A98ADB31C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YL98MnD22nmuHZPhv1NW4qz+PtNVpK1WnielfO8qiRdia1nXSbiJfTEnjzyBsNgUAUC6DJj1JI/iyrRVSGJzl8V+Ebt8feBeKPnLfW98ehcHBSl46xYXTa3iSaVFeOlnPWgTT5ADsD7IbHJJ4fgqX/VkmdyjhQSMy17GTZJq8CRR5SKk2KAntyJVvwnF+NsZOXwtmgCZOlz+fioJ9p9dQtLD91FovyegwG6iFI/H5w/CMGQcLfcJmHk1aUJrTapRvvQhVQsdSlVayckWg4vCjHADMEvVaybXd7BWTNeVX7XJZuywvcfOidtRDSip5WmHT4ru6O/g4y/mrPmwchH04A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gsTFdCAefdipXbQS74kzqqH0+XkMZgW+9uRWLNO09lZ8zH5ymwToH8JSjBlJ8/Vg7v+tCZosB2SMx/vANp1k5LuhhvXPTjo9rPoIr1mFqfSHxzGxy7Xdgei+e5jsvZKsWtSiT18MEYTED2DfcjBrhm/qkyYwTSXqhThx+2liRMm/MB/u425UGgpWQuKRCnMQfuC3PljV6Lofj/Th5m70zKBAyE4zyYmE22tUPFFwiI4Yf4OUR0DyAFGeiDaTZP+mL8NwJEzr1DnCILqHa4kjACNlH77YmAhPNwCY/QqakFhD0iHZWcc6rqIbXpDreYsJfJuCkSKmJCTHbPVFgrphS8q3AMHQS5FLXMFRHWP2ixSPP6fjPn/JN/zxz5aDa8EN3WFFyE0zjQ567NJtuQqpCpKHVeDQqh/JVsnC08bWW40820s6JIhZp+8IWfsTpX4jAkGTPezsxmDIbzKbO6sLIqSoW55D8dHSfV/hCgDfg5k=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9511d89d-8f53-4d2e-023e-08d7fdbcba38
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:32.2632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeJ/66uUZbM2X8lDS5OvSDpbONXwApF30k2pShzs9DwdMxDzUjwBXJINPrRRSapTYMLxdH6scsFkibvad8j4KQ==
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
 sve2.risu | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index f2e4dba..50ff756 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -62,6 +62,67 @@ USQADD      A64_V    01000100 size:2 011 101 100 pg:3 zm:5 zdn:5
 SQSUBR      A64_V    01000100 size:2 011 110 100 pg:3 zm:5 zdn:5
 UQSUBR      A64_V    01000100 size:2 011 111 100 pg:3 zm:5 zdn:5
 
+# Widening Integer Arithmetic
+## integer add/subtract long
+SADDLB      A64_V    01000101 size:2 0 zm:5 00 0000 zn:5 zd:5 \
+!constraints { $size != 0; }
+SADDLT      A64_V    01000101 size:2 0 zm:5 00 0001 zn:5 zd:5 \
+!constraints { $size != 0; }
+UADDLB      A64_V    01000101 size:2 0 zm:5 00 0010 zn:5 zd:5 \
+!constraints { $size != 0; }
+UADDLT      A64_V    01000101 size:2 0 zm:5 00 0011 zn:5 zd:5 \
+!constraints { $size != 0; }
+SSUBLB      A64_V    01000101 size:2 0 zm:5 00 0100 zn:5 zd:5 \
+!constraints { $size != 0; }
+SSUBLT      A64_V    01000101 size:2 0 zm:5 00 0101 zn:5 zd:5 \
+!constraints { $size != 0; }
+USUBLB      A64_V    01000101 size:2 0 zm:5 00 0110 zn:5 zd:5 \
+!constraints { $size != 0; }
+USUBLT      A64_V    01000101 size:2 0 zm:5 00 0111 zn:5 zd:5 \
+!constraints { $size != 0; }
+SABDLB      A64_V    01000101 size:2 0 zm:5 00 1100 zn:5 zd:5 \
+!constraints { $size != 0; }
+SABDLT      A64_V    01000101 size:2 0 zm:5 00 1101 zn:5 zd:5 \
+!constraints { $size != 0; }
+UABDLB      A64_V    01000101 size:2 0 zm:5 00 1110 zn:5 zd:5 \
+!constraints { $size != 0; }
+UABDLT      A64_V    01000101 size:2 0 zm:5 00 1111 zn:5 zd:5 \
+!constraints { $size != 0; }
+## integer add/subtract wide
+SADDWB      A64_V    01000101 size:2 0 zm:5 010 000 zn:5 zd:5 \
+!constraints { $size != 0; }
+SADDWT      A64_V    01000101 size:2 0 zm:5 010 001 zn:5 zd:5 \
+!constraints { $size != 0; }
+UADDWB      A64_V    01000101 size:2 0 zm:5 010 010 zn:5 zd:5 \
+!constraints { $size != 0; }
+UADDWT      A64_V    01000101 size:2 0 zm:5 010 011 zn:5 zd:5 \
+!constraints { $size != 0; }
+SSUBWB      A64_V    01000101 size:2 0 zm:5 010 100 zn:5 zd:5 \
+!constraints { $size != 0; }
+SSUBWT      A64_V    01000101 size:2 0 zm:5 010 101 zn:5 zd:5 \
+!constraints { $size != 0; }
+USUBWB      A64_V    01000101 size:2 0 zm:5 010 110 zn:5 zd:5 \
+!constraints { $size != 0; }
+USUBWT      A64_V    01000101 size:2 0 zm:5 010 111 zn:5 zd:5 \
+!constraints { $size != 0; }
+## integer multiply long
+SQDMULLB    A64_V    01000101 size:2 0 zm:5 011 000 zn:5 zd:5 \
+!constraints { $size != 0; }
+SQDMULLT    A64_V    01000101 size:2 0 zm:5 011 001 zn:5 zd:5 \
+!constraints { $size != 0; }
+PMULLB      A64_V    01000101 size:2 0 zm:5 011 010 zn:5 zd:5 \
+!constraints { $size != 0; }
+PMULLT      A64_V    01000101 size:2 0 zm:5 011 011 zn:5 zd:5 \
+!constraints { $size != 0; }
+SMULLB      A64_V    01000101 size:2 0 zm:5 011 100 zn:5 zd:5 \
+!constraints { $size != 0; }
+SMULLT      A64_V    01000101 size:2 0 zm:5 011 101 zn:5 zd:5 \
+!constraints { $size != 0; }
+UMULLB      A64_V    01000101 size:2 0 zm:5 011 110 zn:5 zd:5 \
+!constraints { $size != 0; }
+UMULLT      A64_V    01000101 size:2 0 zm:5 011 111 zn:5 zd:5 \
+!constraints { $size != 0; }
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


