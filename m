Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2167AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EE120578
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iWebmUU5";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="BIniMiDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EE120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4lK-0004Fj-4m
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j2-0001Sf-WF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:17 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:14343)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j0-000379-UC
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1589904254; x=1621440254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=gEDb7QVfcrI3Aw/PoZfSO5X9iQGRgJE4nD0EsadtKIQ=;
 b=iWebmUU5jqs9GZmdDUerwu3bVLIF5BETNASR0C+LHNGwaCm9Q6j8U6rT
 KmgPdeJ8qLwII5Td3FLUq86YNbujDkqDUF2zECfCGXSEMZb8c/AEZhU3t
 J0qgIipQZxmjP5mlXJrs+bpJbau95YZgJCajLwRyLXLzQm/lcqqpWs9l5 s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 19 May 2020 09:04:13 -0700
Received: from nasanexm03b.na.qualcomm.com ([10.85.0.98])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 19 May 2020 09:04:13 -0700
Received: from eusanexr01a.eu.qualcomm.com (10.85.0.97) by
 nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 09:04:12 -0700
Received: from NASANEXM01G.na.qualcomm.com (10.85.0.33) by
 eusanexr01a.eu.qualcomm.com (10.85.0.97) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 09:04:11 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 09:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzJoib1fzclxC3KVQL67aLmhxVBa+2z+66ceBKnzBbZcN2I+XAUl2HcJV5c9yZiah9tURSjOwSuiCUSz1Unk5nKH6vdsWJ+bXStHQkEYmmXvlzOgG+PTuK918424KbH6wVqthfLt2QHUooUbqy8LBYQEhikw04HceDRaESbbPSLDoG0EFG4HdD4Z0cuQVZt8n7wF4Bn3iXXDgB9/xU9nVPSvOwMfb7KoLK+9LeUyJpY3HH/pacTYe7uAKU0PvJX2pIGmLEY17Lcs4uPQBIwOacYtc72+eoYjawXiYqisfj5hJNTz37H9OVfaySrLQq26ASqMZV00ppoio1X3qaxahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSIt2ClPqlYfnDC0XpK6foKlathBo40EvcdRWKR/yN8=;
 b=fMUEMWPfJBnt0D46qtKTtBy5bnwkvNsQYlYl2oT7pb5diiyd3iVI6tclGCv61Vczw7v+DLdEXjSBSaEmZzpfNx3ODEFDGhPs+G1Z37UR9jpuluLafeqwfA6x+M0ietiExrBbAUC/K9kIssli3kwxwjpgI1PnfYiBqqa9zffPA3ZT6tVKPHhcpPZSwCJxtZHHS7sGfoRnxPKMlD+0joGWGpD/OcqqR7yMDrgxxj8ceOz8bvxlBAHwQrpBsltQRckMjKpeZ1/ffm81qMmFMcBTN9Q4IdCZmFEiJuPb6IOwN2wuQIdvKMIS4Sq4qxgS+3mEG6Zl14Er0k8P0YjQf8WVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSIt2ClPqlYfnDC0XpK6foKlathBo40EvcdRWKR/yN8=;
 b=BIniMiDg2KVWfVNHkXeChZCVSQ8uGFInbAhfAKxlykaht93uRJg/+TwqikqD1g7yMyjO0Ha+/4PMAui4kSg/h8WlbWbrst0DiQjRT3oGti/0jjrqSH9hbcaE+iK9FDwjFv8Jy9FQfekTu4CHpdTTyKjAKqgRcEZBX5+z6ccM2ZI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 19 May
 2020 16:04:08 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 16:04:08 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RISU 1/4] sve2.risu: Add patterns for floating-point pairwise
 ops
Date: Tue, 19 May 2020 09:03:51 -0700
Message-ID: <20200519160354.4430-2-steplong@quicinc.com>
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
 15.20.3021.13 via Frontend Transport; Tue, 19 May 2020 16:04:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6283460b-494a-4577-bbc7-08d7fc0e430c
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484BAAC6F014E7C4840B5D1C7B90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/qimAVUidqLmO5x8gstLiWbK/iE+7Qyt8UoaTSWRd8hkXBgUP2stEQZlzQZbq+or28UytrAj65Dp+oQbGFJCBz8G7RFtEIrTAZMRZWEoOaJYfmS0emXjhk+VFF9bJgs2I7cdz1vSFKvUagBW3nayL3srCqY4Ysu26FPH4p23XBPJB53nAr53PSnzYV2r5RCqlIlxpdwNrhypLIYaZd8UH3wL2CXzEd7prdWt/AUWFOOjvgJO0P5EW1XiDPzgoYz/vjcVgIUStru4fH7ZWGuaUtZNKzLhZtl0HaFhQ0qL/4xMEzCBlLkALrPxryNnA/1UCtrtx0GcH0+eVKFkw7l/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(4326008)(2616005)(956004)(66476007)(66556008)(66946007)(316002)(6506007)(52116002)(16526019)(186003)(5660300002)(86362001)(2906002)(26005)(8676002)(6486002)(1076003)(8936002)(6916009)(6512007)(6666004)(4744005)(36756003)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ++JwkVAWxnIf6XWy2+Fp7TiNeTVZ9UrIYdf6geALDNdFBMEd0OEyiDY3HTzwnbSMfSWIdZ3HH0kiVe8kh7asE+i65H5Z1V/VYTgRUuAMGCwbk22V1e18aAoBOhoFIG9rVG+vPtfDicP6Rgz4Luu4b2xH/WZ2pNXUR7JjgFZwNv8zzJxMf+LK+G164tLgqPZzXu/VkpPtFdUht58SCi/slBFxlbQyC2pkxLDceCGei5eoIjRU59fVTPI1YERyvtrGdLRYB/0DZDhvseRMG+s3DEvQ1nRTylhMSpapztIXTDkbm7ytys5IALSjB09SN9ehSgifIYvjLXby2epXakrTeViJjFJiQZFhWW+4EUZ1a+4C1t55VJrPAlbCebq0bhEhJl+H2Xw4rVyZ2gX25uOtAtZimlUhkgwIknEYYdz+m8SHX6E9wl03TgEkJPzWQrc8D12JuuCJhrx59etYhQogiMWiBPvZUie8Bin5rESZSaI=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6283460b-494a-4577-bbc7-08d7fc0e430c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 16:04:08.3422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Omh2w8IxlmDWbueWrsnpbykJrhokaGrDY4Y3LX97kIte9/mz2HKsLFupV++p5zzONgHX0szRz+hPDf8T4SeBDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 12:04:13
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
 sve2.risu | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100755 sve2.risu

diff --git a/sve2.risu b/sve2.risu
new file mode 100755
index 0000000..eb1d75a
--- /dev/null
+++ b/sve2.risu
@@ -0,0 +1,14 @@
+# Input file for risugen defining AArch64 SVE2 instructions
+.mode arm.aarch64
+
+# floating-point pairwise
+FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
+FMAXNMP     A64_V    01100100 size:2 010 100 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
+FMINNMP     A64_V    01100100 size:2 010 101 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
+FMAXP       A64_V    01100100 size:2 010 110 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
+FMINP       A64_V    01100100 size:2 010 111 100 pg:3 zm:5 zdn:5 \
+!constraints { $size != 0; }
-- 
2.25.1


