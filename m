Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C99206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jkgpenvL";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="YqREbPYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C99206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrCn-0008Lu-DM
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpS-0006bJ-Uv
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:06 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:42758)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpR-0002Tk-Nf
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089165; x=1621625165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=T/BCGGb1LJHDYfouxf/nAKVZZZvPl1wPEtw8r/kzv9w=;
 b=jkgpenvLedDMSxIc3mWQw63lfSkfHHqqxCGGl6Qcbcv0oeDxKzvzuyqk
 HlVlp/O7yQr0DkxRCKStAzAscTGwvLeXHmdN7kFeKxnWzgY0fqxGDy7pe
 T3W2RwYpGpAeY94xhH2SlA5CUK9ALp5tshN55ck4/8cELJYeyAbRSGbty A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:55 -0700
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:55 -0700
Received: from eusanexr01f.eu.qualcomm.com (10.85.0.101) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:54 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 eusanexr01f.eu.qualcomm.com (10.85.0.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQzCdj1+I7Nm14uY/01dOZFWHneao+GGy10HqmYBLJOHGIfvMyUaFCmOCdQX/kL/DEiVHatbdg3BRisU31dibBlXrejKeRg//UwQhL1y3Fe3T0O6a6VA8+VxdiwHtknV67/XO9ncGhVKstB/PJQlUL7mBX02lQ57msvimch2sToJTvAPxYGkfnLm6p2dRLhiX7EvWCkoe6UrZyeiVxALs3jA7TiP6BB4iQFB16687WfljLY6hJIfM3gECmIZFFCrgoXOde0FrNhtvGCuY1V/viICvrVwvVgbk3hGlOC9DzisMfFdJH9FOYC9gDkC1VrMcZmCMWauhoYMUNInjYrqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYzAGP3N+hWsf3cr480VRS+1Q5ys8FhX2vMh84qAbaM=;
 b=bTlFw9dg2TrgbkWW04KRyugjNbdOfdpC6kiROr+MtIooCQVHzrE0vM6JI7yVdIxzAucziTXvV3DlB/9AO0Q/4nafrBxtGmg1+q1K4mTh3S17tftiaxJkWVr12edlmQlzXs7to7JsFqBxu3moEOwV1lvY1uVbQaMUsTf5te31urAbnsBK3fFy5XYxZmaZXW9KYGpqrpe9sHuDhSO19P+yPm73xJ8lZ3gtfzW/qzVN7/IPweQWPOugGFY8xb3rLM2FJJyp0taS6WJV3fvLRtur+2cLmrH+hnj3+ZjWoOGER3GKa9YWSQThtPZNgjYyvRLvFAV6hsZfMMYYWUwooir58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYzAGP3N+hWsf3cr480VRS+1Q5ys8FhX2vMh84qAbaM=;
 b=YqREbPYgDAqvdbwh89eFlrWC2lzfGxqONjYAw83hfDoVKv1PckuhhH6ddCgW8t4pasEqFpSNDs1XKUoohkMd/skOMcTWfLNDs+SWomgV7mhvP+vOBTQNVkW2ghPjS9MclJdbhKYlf97b5TPQ1y6vRvax2mNUWK+lun+L1pElwZY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 19:25:49 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:49 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 20/22] sve2.risu: Add patterns for fp widening
 multiply-add ops
Date: Thu, 21 May 2020 12:25:09 -0700
Message-ID: <20200521192511.6623-21-steplong@quicinc.com>
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
 Transport; Thu, 21 May 2020 19:25:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c226e4-e5af-4d94-50c2-08d7fdbcc499
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484B4C801DA416D8EDE2A2AC7B70@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1Q0rT+Qw12s0P0YfKTrJkF5YKhMg0rve2in5019aou8zHWqQP+fuQkjYWCVHK0QkqLSykwLEO1S+HH0rb8lSIQagG3z9DPDy0LH889L47Dq/QmDEvqB+EUiRBujm+XuGmA55Lt7pz5enytsJcCVPyXUN1zOhujdl6KfgPRLUVxZcT/3O7bIkEY3zXuW/vSgh0eg4d4HJ4Q60MdCcPn60RH8nxEnElQlHVa02YaVbF8GSBNLB0XwxiVPee2Vv47aX5WfLxU6MRRUbPzfWI8664D9F8L+sxng7rg+exLppeA/oJvlNggGVhPgVU07ZT6zpEsf6v92qoMraJZseAD8dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(4326008)(956004)(66476007)(66556008)(66946007)(52116002)(186003)(316002)(16526019)(6506007)(86362001)(2906002)(5660300002)(26005)(6666004)(6486002)(1076003)(8676002)(6916009)(6512007)(8936002)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bf2TJzEk9OhIVAF6q7opXzpe2prwsYfz8ztMJuPrQAhEwqxi2Y6Ykr6sHU0C5bUbdgpkLhYz+RaW62+cHxy+iHi+ylzHG9SSBXxy9G/NzCb7xXL/smF5vD/o7ItBr1ofoqodSN+IiTa9KGCpZDulLLcOdugtUi+pV5pLNk4QlGTNdu00SepjULJTnNlck0Je3SA5ri4UEFlyl4WdCtfGYlkq9mlrXCQM/VsivDPBXkjBux6hhZ2lL0MUrpCyF6NWuCwOlvFr/b3akk9SXykQUtrTgh/HfP9ezPKWvW+hWcxrZBG7FDtmky/cKjr0KHVszuK0gaLfv0idHH9cE+HmA+S4zEJk0D6t2zehKlNt9lz+lKB4ujY8e1yKchLb0GNuq6408vFaIJWi2W8Mp5UpvgSOoiVIw5T6VpCY6Tv15J6LltoWBPb73eumqHzU+yqfA9yfQ2HCp/CKaHIllB9fjU2qvtLNqoaliGJq0Fe+Vu0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c226e4-e5af-4d94-50c2-08d7fdbcc499
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:49.3463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nepkg8dOCDXdCLEHYtCKkY9bI1VjL/TA3Mh61YjNwVMqZBMwAId3Jl+KccWe4i6LSSEBazSqJFyHFK8B55MiFA==
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
 sve2.risu | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 44f227e..d0ad7c9 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -480,3 +480,17 @@ WHILEHS     A64_V    00100101 size:2 1 rm:5 000 sf:1 10 rn:5 0 pd:4
 ## pointer conflict compare
 WHILEWR     A64_V    00100101 size:2 1 rm:5 001100 rn:5 0 pd:4
 WHILERW     A64_V    00100101 size:2 1 rm:5 001100 rn:5 1 pd:4
+
+# Floating Point Widening Multiply-Add (Indexed)
+## floating-point multiply-add long (indexed)
+FMLALB_idx  A64_V    011001001 01 i3h:2 zm:3 0100 i3l:1 0 zn:5 zda:5
+FMLALT_idx  A64_V    011001001 01 i3h:2 zm:3 0100 i3l:1 1 zn:5 zda:5
+FMLSLB_idx  A64_V    011001001 01 i3h:2 zm:3 0110 i3l:1 0 zn:5 zda:5
+FMLSLT_idx  A64_V    011001001 01 i3h:2 zm:3 0110 i3l:1 1 zn:5 zda:5
+
+# Floating Point Widening Multiply-Add
+## floating-point multiply-add long
+FMLALB_vec  A64_V    011001001 01 zm:5 100 000 zn:5 zda:5
+FMLALT_vec  A64_V    011001001 01 zm:5 100 001 zn:5 zda:5
+FMLSLB_vec  A64_V    011001001 01 zm:5 101 000 zn:5 zda:5
+FMLSLT_vec  A64_V    011001001 01 zm:5 101 001 zn:5 zda:5
-- 
2.25.1


