Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96769C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2722075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="rPawz9Rd";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="riWC1vy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2722075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4mY-0006Er-Gz
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j3-0001Tv-MY
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:17 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20822)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j2-000377-Bt
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1589904256; x=1621440256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Lu3lov8MwqWG2B6tJgWqxQ/OtzujIicCacG3GxZ3a6c=;
 b=rPawz9RdEPtXKDO6rhPL9kl5DdA1P7SVxgvfcfIKADDdXZ6s42fKrtra
 Dodq9FUHSW+I2mtOW0QWY6LlCwAeezJx+sQFu7bU0TxI1eVZX4xvpUl6A
 oJTNAwA/dLjrW8ULMO1QAjf918zOXSVDgTeuR0MW1YlQXYGrfoJ/d8Y7e o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2020 09:04:14 -0700
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 19 May 2020 09:04:13 -0700
Received: from NASANEXM01G.na.qualcomm.com (10.85.0.33) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 09:04:13 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 09:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWBcs5GJmDghavLveSspLCwUa5fL5f4w+sAUaNifgo843azqUY4KlBm+px6/GE2OQrpFfWHO7b2rvvL1ZkALd3gHeuIC0HNXmWQ6KS8CPtGj3+Z/dZuD5K7G0XM/A12wVD0947P9HapQBug2nzcUkoS1BaJxUMswQ19vRoLPyFO2nefjZ2DDv38A5Jc94wLAMRkLa4CrfTpqaWXH88DRvlPUy5lNEPs+ftKCkEFJUapKDNodOLbN8QBw8oratXxsXsZPqC5XttT+KNRJSJEEmNOd6B/QQiO9YNzef8Ny9mhEClhIKvxW6I4ngqrWZ5GoL5bUFwEwhqdgU+GUP1qeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgEHNQz0dXmHICjO7Qi7Pn3u2lXXhymCCbYcNLeXZAA=;
 b=V98sh9t8wN9ZqHg2BCZ5unSzamkhgRORJdjQJ7y14RoveaNtr/AOHow2UT9i/jRZvlQpPVufWZIc0Rd/8b5tp0/8M4Ac1696PRQCdhtqI1fwRwBf5tsxd7R/ATJP1VDCX1rMLphYzJKkTTjIEyHRgwatNO5pR88sdtCIj4c/IsHg626EIo0hd8RSsS0F01reSJJQ6EPSO1i1noGPGGFn3YgcNJC9bkeonaPAp+7EyFWIQF0VwiK26s82jyVQ5i4O/99pJAWl69hvsOD8Wy6+AXQ4T4lVehY8/GSo6ABEZwyGTWo26OM69aMtGW75CkejL9VyGURwhDTk6nxOsDIkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgEHNQz0dXmHICjO7Qi7Pn3u2lXXhymCCbYcNLeXZAA=;
 b=riWC1vy/bmCOZoakRY8AT1ljmO1uGOAuhf9npGJaJ69QfGDv7vFxo8oEYwnovAV3xMPx32tsXCV0FNRaxyB8Yj1g1u0R3uuRc+JY4mgNgvvTrTrNIG+VHOPMigJRM1paaEZLrIN7I8vxcwr+FC5y1SpG5JHMM1PUDddQ17nuBgs=
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
Subject: [PATCH RISU 3/4] sve2.risu: Add patterns for integer (predicated) ops
Date: Tue, 19 May 2020 09:03:53 -0700
Message-ID: <20200519160354.4430-4-steplong@quicinc.com>
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
 15.20.3021.13 via Frontend Transport; Tue, 19 May 2020 16:04:09 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ae00620-94df-4d17-64e3-08d7fc0e4416
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484A08BDB477EE1D40E2CB6C7B90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 006Whez2q8iOOpSunSIOmKl5bs3YE++hWoRZqr6TQw8y047p1dWbVz42E9VlizZMn9Uw3CDGRbmWZY5fGYzLtRsKjFad9MrOWk6hL4E8+V0aduVENdmq0CH36V07B0qkNlz4/Mrhh3iPShAAnWLQuIvYrUjg7FtbBT9PXaNqgFeqKntnx5i60H+UpgxRwQNTEUvGVbmxonQf8gbBl6eD/pcqOZfm6FYlOz9c9eV3nTRlZIsQ8bYw1nHRSSTyTwxzgNytvJHl4+Y3QkRh5q1q7gWXrAN0fSwrYfobwuvoGGjeSRdFz87gf94aZRC//qG87umnWW9st3I3nCC230r7Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(4326008)(2616005)(956004)(66476007)(66556008)(66946007)(316002)(6506007)(52116002)(16526019)(186003)(5660300002)(86362001)(2906002)(26005)(8676002)(6486002)(1076003)(8936002)(6916009)(6512007)(6666004)(36756003)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +r7eR4lWaWvOuqRTloDD/kqEFmLoSANQyeHPTrqYxyLkjIWTcIFuswoDY82ZcdniWrhIJ/PIx5KCvUNXe6IRlBQIS+v2Us/rXsUlklsr64pjznU67gWiT8vuefPxhWPYtR52kj6no6gyKCqyXSxWh99grFGV06nBVX3KmJNAng5kTTA8FZ7mJMf31GeU1i3MF31i6eWAWnTIxBBXhJoUmjzOdJhbRGemwlnJRQVf2C78Sanr6ZBY0GVHD2b4OE71dHPpEElTokCx4ZRdqhbAkDcN1ba3g5PIu62lreuX/oe8lv018O4sEU0MnB0q4FWGGHjiq460mHmUj/odqlHax4u1IMqASk/02+/pu7F36npfCd9tI0F8UAezZwTN7IfaXhWO0on5Bp4bHFTUq2v6yeiMVVso+rvAvwAGf8DybEbu1ZeCXFuAb1eKZ0gbAAJIj6+6bjpLNxuRpAV8CEq4Ec2Rkp9u1UOnqmo9CVaAlcc3ikagU96+Ycw4tokV/tak
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae00620-94df-4d17-64e3-08d7fc0e4416
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 16:04:10.0383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvgSMj945ZqGc6cKoIBsda8HnodsOWUIy4WHE1/4ZKl4CLPoK/c8gln4UvQJAP+/3q3xinJ0BP30/I32gkCIZA==
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
 sve2.risu | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index ccdb19f..9e48e1e 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -12,6 +12,61 @@ PMUL        A64_V    00000100 size:2 1 zm:5 0110 01 zn:5 zd:5 \
 SQDMULH     A64_V    00000100 size:2 1 zm:5 01110 0 zn:5 zd:5
 SQRDMULH    A64_V    00000100 size:2 1 zm:5 01110 1 zn:5 zd:5
 
+# integer pairwise add and accumulate long
+SADALP      A64_V    01000100 size:2 00010 0 101 pg:3 zn:5 zda:5 \
+!constraints { $size != 0; }
+UADALP      A64_V    01000100 size:2 00010 1 101 pg:3 zn:5 zda:5 \
+!constraints { $size != 0; }
+
+# integer unary (predicated)
+URECPE      A64_V    01000100 size:2 00 0 0 00 101 pg:3 zn:5 zda:5 \
+!constraints { $size == 2; }
+URSQRTE     A64_V    01000100 size:2 00 0 0 01 101 pg:3 zn:5 zda:5 \
+!constraints { $size == 2; }
+SQABS       A64_V    01000100 size:2 00 1 0 00 101 pg:3 zn:5 zda:5
+SQNEG       A64_V    01000100 size:2 00 1 0 01 101 pg:3 zn:5 zda:5
+
+# saturating/rounding bitwise shift left (predicated)
+SRSHL       A64_V    01000100 size:2 00 0010 100 pg:3 zm:5 zdn:5
+URSHL       A64_V    01000100 size:2 00 0011 100 pg:3 zm:5 zdn:5
+SRSHLR      A64_V    01000100 size:2 00 0110 100 pg:3 zm:5 zdn:5
+URSHLR      A64_V    01000100 size:2 00 0111 100 pg:3 zm:5 zdn:5
+SQSHL       A64_V    01000100 size:2 00 1000 100 pg:3 zm:5 zdn:5
+UQSHL       A64_V    01000100 size:2 00 1001 100 pg:3 zm:5 zdn:5
+SQRSHL      A64_V    01000100 size:2 00 1010 100 pg:3 zm:5 zdn:5
+UQRSHL      A64_V    01000100 size:2 00 1011 100 pg:3 zm:5 zdn:5
+SQSHLR      A64_V    01000100 size:2 00 1100 100 pg:3 zm:5 zdn:5
+UQSHLR      A64_V    01000100 size:2 00 1101 100 pg:3 zm:5 zdn:5
+SQRSHLR     A64_V    01000100 size:2 00 1110 100 pg:3 zm:5 zdn:5
+UQRSHLR     A64_V    01000100 size:2 00 1111 100 pg:3 zm:5 zdn:5
+
+# integer halving add/subtract (predicated)
+SHADD       A64_V    01000100 size:2 010 000 100 pg:3 zm:5 zdn:5
+UHADD       A64_V    01000100 size:2 010 001 100 pg:3 zm:5 zdn:5
+SHSUB       A64_V    01000100 size:2 010 010 100 pg:3 zm:5 zdn:5
+UHSUB       A64_V    01000100 size:2 010 011 100 pg:3 zm:5 zdn:5
+SRHADD      A64_V    01000100 size:2 010 100 100 pg:3 zm:5 zdn:5
+URHADD      A64_V    01000100 size:2 010 101 100 pg:3 zm:5 zdn:5
+SHSUBR      A64_V    01000100 size:2 010 110 100 pg:3 zm:5 zdn:5
+UHSUBR      A64_V    01000100 size:2 010 111 100 pg:3 zm:5 zdn:5
+
+# integer pairwise arithmetic
+ADDP        A64_V    01000100 size:2 010 001 101 pg:3 zm:5 zdn:5
+SMAXP       A64_V    01000100 size:2 010 100 101 pg:3 zm:5 zdn:5
+UMAXP       A64_V    01000100 size:2 010 101 101 pg:3 zm:5 zdn:5
+SMINP       A64_V    01000100 size:2 010 110 101 pg:3 zm:5 zdn:5
+UMINP       A64_V    01000100 size:2 010 111 101 pg:3 zm:5 zdn:5
+
+# saturating add/subtract
+SQADD       A64_V    01000100 size:2 011 000 100 pg:3 zm:5 zdn:5
+UQADD       A64_V    01000100 size:2 011 001 100 pg:3 zm:5 zdn:5
+SQSUB       A64_V    01000100 size:2 011 010 100 pg:3 zm:5 zdn:5
+UQSUB       A64_V    01000100 size:2 011 011 100 pg:3 zm:5 zdn:5
+SUQADD      A64_V    01000100 size:2 011 100 100 pg:3 zm:5 zdn:5
+USQADD      A64_V    01000100 size:2 011 101 100 pg:3 zm:5 zdn:5
+SQSUBR      A64_V    01000100 size:2 011 110 100 pg:3 zm:5 zdn:5
+UQSUBR      A64_V    01000100 size:2 011 111 100 pg:3 zm:5 zdn:5
+
 # floating-point pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


