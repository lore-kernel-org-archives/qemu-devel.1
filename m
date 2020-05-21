Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288ABC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF26E20814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="um1p4VjU";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Z+Vbd+X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF26E20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrBm-00061K-3V
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpM-0006Hi-LF
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:00 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25355)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpL-0002U2-BD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089159; x=1621625159;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Sdxc5mIymMP+FS3ROwnN4EaTDJ2plV7EdYbKLBS7oHM=;
 b=um1p4VjU+rv+QN/EfHX+YjpSm/NZzRMQYzsiwSETFyKezrl963wxLTyS
 VhqKle4Cl2LH27HSiTi8R/cQMHUD/M54ietPFG6oBQJyNMBkihPps/nzS
 4hc0lHc/cLwKxcochL8gmB4XGs1Togv+UWtxHy0CbrOSaUQKM+hSlYrG0 g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:57 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:56 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqpeN0YaNocQelMvnWDjZlHB8u/Mm6rnJCDuW3KuiO8jJo+jRjFi7JR9isYC2zWn/SQS/pJQLVAyEl9Fv/Ls46Te1lNyDTD1cBgEFxpVo2GENOU2u9G3PRSEwdNkQwCgqIL9+J1HGMMb73b6VT3l/XsI2CY28gmsel6QfAKIYuRUNkLLM6zBM/iyvWckqw5Rnx7Iui0srF8wtXIHVh8Xis3Yw8taKwZqCkn4mdhJ5Wb8ZHoKlWc6AraJLUa0im+sacO4g/2SKUZQQZBDruRjy2HYYxYw3EQ3H9vo2HXb3ti50rshDRRoG2ACLAHo0bD2iaF8zc8GwSooWkBWMq2IXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L59zzOSJUZcjmEVKVM9pV4JGvMPuusWUCL8rcWTFxbM=;
 b=BHB1MFTtLwI1AbttCultlKG1/XCRp0z9QB3sDlkSE4cCcO0TvQ5xWLbLg3PtUvTjNZ3cz2RMoDu0Geqe3wTAAJF0Imgu71QMIytlXMARLvq5o4d8zcMMSKOUJylN7nwVRB+6wZWdGrzL6aQR3aA/G1gBI8x4VWLFTFYpZKH4KPz8TSZpjbqHfD6Se+Cu2kz/pluZ8G2BkxZ3/DJTnJiwQjwN3gpgpVGh4q+QwU07p6VBj63eG1tBhZL3moavLzJWFs7xP1AHWxSXUIk1Il1iq5B0hTfY9BPgJIe2E3qfEobE4WuHbD8b60lSqfdWtagSEObKIaQx7ARdRFS2S+/z9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L59zzOSJUZcjmEVKVM9pV4JGvMPuusWUCL8rcWTFxbM=;
 b=Z+Vbd+X4erJUsJwJvsvunSA0Zhov6RAJHpaIsJU7qdgHpX24HhfNGwIRv9z4J2X6kWQmoiubXn4gfNtQ/fpD7tyzTDF3TwbYN8eGQniw9+Sj0xq0BdRpS8vJKiSJ3tLkSkIFoR+LMiA7MLgIFrr7SNrFBE9zIEZ8cBov8Q1Ikdw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:51 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:51 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 22/22] sve2.risu: Add patterns for scatter store insns
Date: Thu, 21 May 2020 12:25:11 -0700
Message-ID: <20200521192511.6623-23-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec92ba5-1cc1-46dc-f3cc-08d7fdbcc5a4
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484C05456ABBBD3C4DF8EA0C7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kxH5er95XvyZpI1JGVmRfRz4YniPEsaHANFR0OmLhl/DEGVXso5nV0Z7/eNQus7o6z/ObeiKLUCzW9BDnUBep+XrDa85qxw9kD6At1H8wzsMOv/Cq2aUPDn7NaBo89cIX2MtyXBIWA5Nxoqs7s4rxTYBEVDpIAmJMujHXp4hYkhpLYuJO3GiGYeUqRhOuwTOTm7dPANhj5r7SIovnjVecBaE9LZt2ARFXn4ythKBvvBn5c46hTTWCzsgT81k5FLdG1KURcMriitaa7CPMkMtxGeobhrsUiMXWCI4aiaOMO7xuLQJtK4GPJaOxzmQKnm4sqHcvHSqC2+M1a572yIcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(4744005)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: o4MHQZgoejW12Q4+GRFI9Z3ynBqEcNhulVULKWfmQlhQI0zdxmGQhiMFe61IDd5gc0uFBbkQcyDjmP4IcCIQCK13cd8MQCqKlN2IHJ6wA4CV/uRL2u2CO+67CqBz0YjwHzoduTVEoWIUJ5/pm6cbTGbO2b8hLkkXEFYFEqFmzV9Fhd1y1kYNHCYWscn7cheKR0NZUyprm3dC0BiTQIjQ2BXsSTP9xC02DDZkjm0tHgKLN8g6CpL35la7Ip2tdD3Uj6glBXxuUdf4pyFeBDpxap6Ukl5nvwhY56l6cWOpH9m7l3Rfh+HUNJK7JDTm4Mtdc0CSuIfFCfKN7hHsh2yLt9yfFV0XY+VrSMcJKXmzSgqrxTvqAR7umhEiDC/mmPaYtN9kHnO4mAVGBao4EvekkUofyxpJvjtbHOYkrdAu/3KRj1d4EUIObZreYtd+BrouhYi6ymQP/4tRNNLWxwIvM64ioqEhsy8DOhi2xFZIRyg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec92ba5-1cc1-46dc-f3cc-08d7fdbcc5a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:51.0953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uuGlmPjJIqE9nIyI+yNNa6CEKbyCXvh/Kh0gmROvsSRKVkB4GoYu8HJewnvob1rA2M5Q9c2QKron4KTaP2KVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
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
 sve2.risu | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 84ae527..00ac186 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -514,3 +514,11 @@ LDNT1SW_64  A64_V    1100010 10 00 rm:5 100 pg:3 zn:5 zt:5
 LDNT1W_64   A64_V    1100010 10 00 rm:5 110 pg:3 zn:5 zt:5
 LDNT1D_64   A64_V    1100010 11 00 rm:5 110 pg:3 zn:5 zt:5
 
+# 32-Bit Scatter
+## 32-bit scatter non-temporal store (vector, scalar)
+STNT1_32    A64_V    1110010 msz:2 10 rm:5 001 pg:3 zn:5 zt:5 \
+!constraints { $msz != 3; }
+
+# 64-Bit Scatter
+## 64-bit scatter non-temporal store (vector, scalar)
+STNT1_64    A64_V    1110010 msz:2 00 rm:5 001 pg:3 zn:5 zt:5
-- 
2.25.1


