Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042FFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29882075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="uhA7z0ja";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="UnBP0HAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29882075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4oQ-0008Ii-TQ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j6-0001a6-AL
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:20 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20816)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j2-00036p-Sk
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1589904256; x=1621440256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=IgyjJQOC1Ty2gzH90lkg00cKMUG7kVYX0UAtXPFPCVY=;
 b=uhA7z0jaQEEjLNFdMqt+8FRB4jzYtzBy72uRLJHy+ZPrIWb8roPxbmw9
 zFV4wkNG/LSuzOoUswZPUeUf0BGDwks4nwNSqeZcSt4Z5xrf8VkvjEQ+d
 hEv+U/YVq23Pr3H2AVWP9E+2vTIH1ZMnvLa18hJc7KND45W/OMLCjlF2y s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2020 09:04:14 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 19 May 2020 09:04:14 -0700
Received: from NASANEXM01G.na.qualcomm.com (10.85.0.33) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 09:04:13 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 09:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo2NQs5AxZJr5TLe93oQaobSRSKqwAgoHrYrVMqPpn1rSWcrpx0bsWZAL/e9l6jqGHjVR7BJ5lfU51YtgfOIS6T/zBwKelRH/ZmEpcVLeootlxyX+Ks2LPuArTk9tvkp9kjuksJkOo4Y2UK5Pnr44QOY71wYKrjpKvts+58vHotyE5L/Bm72dXQOJtiqkHVdL29s1OQ9qq4lJjArlpaZmXXgJJuaAhW6xu+6zfZMjIz+iQforOaMSr1waV2pjbh2mxOQI5oNmlIaPL1+QUwfvKP11bb0IiCuGJ2n36RsJx3KCr1XKTP5IawJg8svNcEJW+unHZ8eDeuCCjVncgd6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HARe3/4jI/gduMBcEykosA+2ktzHjmQr0oqH3znXy2c=;
 b=ivdIleA2eccruCKoTnR0fkghYmqdQscKvBj0I79yv2Y5UUZEyU/DTrB/ZP9kz9bwjKcV1QjieP6ooX20Vw6am6CunpqTxOB3QFk0M5mVVJkcduI4HpeMIOw8CyROGaKxwF+MvCWRx9f637ZCVw57KERUhowRPAQeV3UGf2bsDM2eejpll/xjw6GmXcMnWJl9CTZHTXwzW73qeSjsIbzxKdrhvyWVJVkmLQiHXiOscWi/vtkm3wmcUjRn3yU8QZ/tvIEsQ6+3QR+7hui8Bhw77mChpw2uNcuenTNTI3bWyFfBrquoI0QNOEDd+q4E5v2g9Kd/G1+RyUKitGfv2S3zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HARe3/4jI/gduMBcEykosA+2ktzHjmQr0oqH3znXy2c=;
 b=UnBP0HAOFGE4lhx1vXFhvwbh1bVlkEJkLguH1nLjwEcPbCmsfAvYT44xFcf35nZ/giPhp773aRFJFiZ7DdDz3pQONCz1f1EiviKXDM6ljKe2JZe+hbh1MlRsxfcPjUDJFHlJ1yo/qdcjvjZxCXiy0Wy0LyzjK3RdNiapPhpP624=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 19 May
 2020 16:04:10 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 16:04:10 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RISU 4/4] sve2.risu: Add patterns for widening integer
 arithmetic
Date: Tue, 19 May 2020 09:03:54 -0700
Message-ID: <20200519160354.4430-5-steplong@quicinc.com>
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
 15.20.3021.13 via Frontend Transport; Tue, 19 May 2020 16:04:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f0deb1b-5a90-49a6-ab40-08d7fc0e448b
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484E5056437A94626D359C0C7B90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWkesqSX/j0UwXMq/6ivQQJdUnhs96Hnpnf51fzREwdNmqoXypR3gyKp5palVd2DoMdC183egtaEZR4fCZepqAo7g35/3oiJLMHMQGvLrm6mRSD15DV4cBAxA4cFWzpFIuNSkRpH27DSaDMm8uGB4Pd9MAqWfIuxFgdpyJmeMvUW/Q/A/8tcttHhvfO5At547ov42Jt3ODIa+0F467UBIfYOZMkeAravUGfu2dMG3SSTDdkUqv9+u2Ox4yQUTNtHWiS2WyQycLp55qEyUiSFOPUH3FF0nskI3u/g8v35S2l4YHlHxzUmaOy+5ua6L3talwOxaqnMxzml7033MBUj3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(4326008)(2616005)(956004)(66476007)(66556008)(66946007)(316002)(6506007)(52116002)(16526019)(186003)(5660300002)(86362001)(2906002)(26005)(8676002)(6486002)(1076003)(8936002)(6916009)(6512007)(6666004)(36756003)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dIn+fX9C/jOpBWufj/nms2EnhglePsLYWGfopxfnxSMJcgWd7AsGq8vIUdQo9BTdQ/pt27CAidzPuhGedtWih81rK6sIz0ZhyqnJPdckyDvBNRkQs5UeFUnIoA82+mJpt29JpqgmubfMoP3Oa40YDEwpV+6oPWry4bs0lWkiCFybkx3Zcq4QnMWl7lLjBjzAxSPfpULkwWn/E2QoV6qzErx3SSqMqkYo0Avr1TkvBsiY27uUJD9yTCpx0NlfhdboeCA0p+Zs0LQHnoOEbUweUzcT9CJ+yS5IvJmNxCnzGxZJqgZDdoU9ny/KvjobCiOOP/gD14OBjcXuZLhXdZGlup8Mq1ZkZvqEuUv3H6tK25QzUrqYFoXGmFSD5U/rTe0Y/MAH1fnWNVWF3JJtIXCqqXuPqskNVyRiwzFDaie97DbhS4UOGetfOxLVamPFX0FIUVyF+o4wudCb1FsbUalzo8cLBTe2pQAYe9UmN5atmvQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0deb1b-5a90-49a6-ab40-08d7fc0e448b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 16:04:10.7759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOTIj4x6rPCBESDx57zxC5bpQ8h7MSVjzM1MEQ2Mdptl9hmoHVD0rX/mKKk9l9wuxz+f74o1qVCZnHbxsKJGdg==
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
 sve2.risu | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 9e48e1e..a4d5312 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -67,6 +67,68 @@ USQADD      A64_V    01000100 size:2 011 101 100 pg:3 zm:5 zdn:5
 SQSUBR      A64_V    01000100 size:2 011 110 100 pg:3 zm:5 zdn:5
 UQSUBR      A64_V    01000100 size:2 011 111 100 pg:3 zm:5 zdn:5
 
+# integer add/subtract long
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
+
+# integer add/subtract wide
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
+
+# integer multiply long
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
 # floating-point pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


