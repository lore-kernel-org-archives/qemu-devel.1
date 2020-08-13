Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797A8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0E420855
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PCkIRhky";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="bjCyt86h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0E420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Fwj-0005UW-Gq
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1k6Fw8-00054P-Nh
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:18:40 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:58281)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1k6Fw6-0008HG-5F
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597335518; x=1628871518;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=C7+oUL5XORfdseFC4A/a345Jv5SSfehyOF3aR1FVe5I=;
 b=PCkIRhkyX4UlSCioXwQbIMbg6NNP/LMpqr4ZTPU4627upaQsraOBYgJE
 gOEcd/tOQL0uBu1U3t2CwTBooUlbyTAQSOHipLfpmdI0muzRJa4u+yA8J
 r12J0BTCrrkleZUIqLs9PRTHxAJ42Kh0GHjUl9GRXPPVoByGlzoTZgu7S 4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Aug 2020 09:18:36 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 13 Aug 2020 09:18:36 -0700
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 09:18:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 13 Aug 2020 09:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJmmAXeoRlMTxeA605OCvukHxuXJ4oELgllCTzTLfOi2kItNWCMo5YYAEDmX4DVYTmwknzkID5HJhq2c2jp0CEDWwbcz7v8FWkSLGYTysW4Ex2BFtkEMdK0KoXKHMOUpqgpvzsQP5COF7QWM6DYUIO5OADTD6XqTLhm3z4xpyKk17/7gR/9IrcFtw7iH0KsX+tHgKvXXD3ZrHHrs0NaFsMTR0cUmntOEWuoOp9XRkm8DR75UTA91SK+8DetMqp24+kbDH+eCsdiXCkJPJIM8+FOkh8arpcSEkYc0oW4GjJtZukLVqKOuK+ET7pGSAgE6ySU1OMQnDrzo7uZN7jj+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmTeyN201LcvLWd4DZKv2wYDyA12poTKkC5RDJntMcs=;
 b=ko7u70DXaguUf2HuYuNyTJ/tSIfF8u9anjsGvJQSGMOYpRSlCsDfObsVGBA7gWE8k2JMG9pDcIFkZFZ59+J4R5RDlCRXd33w6xyDoMuNqfW6V3sMUXwsBKJJkwOkVl8CD3UabkouLDYYt8RHCLy+kMlX1kRqQdxEyI9yTDAMHBHzWlwpKycvEYHRZ5L7vj2bvj9YNzry01O3eQjyEY4NkVSvcrgINoFFRo0ejzpByU/ZytLZIEgaU18vh9R19kteYFjyJtHnZk3VsXZtbocOW5xKcXgH44l82IBPCtU996KOTXYDx856Psm1vqnr3o0EglHNsUI2LqKGOSf5FCqemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmTeyN201LcvLWd4DZKv2wYDyA12poTKkC5RDJntMcs=;
 b=bjCyt86hcAR5Npfg+Q20TqcJNHToRWIVKBOzCx2kX39rjRUU9WLqZjM61JhvwqDFx69a3+4PSSDDxni8REh5J4GFghxlWrX9Wo6mbhRJqDYWchAlgqNt/EBLxQWKh7bS7/dQxKjbrOnnXZ91TiXfLBNli9FGwmPSc6A+ZdWuJ0Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR02MB2510.namprd02.prod.outlook.com
 (2603:10b6:300:43::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 16:18:34 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::f80c:adc3:1c7d:e2f2]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::f80c:adc3:1c7d:e2f2%7]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 16:18:34 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2] tcg: Fix tcg gen for vectorized absolute value
Date: Thu, 13 Aug 2020 09:18:18 -0700
Message-ID: <20200813161818.190-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::35) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (2605:e000:1c0d:7ef:d872:b153:fb2c:1455)
 by BYAPR06CA0058.namprd06.prod.outlook.com (2603:10b6:a03:14b::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Thu, 13 Aug 2020 16:18:34 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2605:e000:1c0d:7ef:d872:b153:fb2c:1455]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de493ad7-80cb-432e-7b6c-08d83fa486e8
X-MS-TrafficTypeDiagnostic: MWHPR02MB2510:
X-Microsoft-Antispam-PRVS: <MWHPR02MB251087BA5C98BF21E1F643F2C7430@MWHPR02MB2510.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(52116002)(8936002)(36756003)(16526019)(6486002)(83380400001)(5660300002)(86362001)(6512007)(478600001)(8676002)(6506007)(186003)(4744005)(1076003)(6916009)(6666004)(316002)(2616005)(66946007)(66476007)(66556008)(2906002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-CrossTenant-Network-Message-Id: de493ad7-80cb-432e-7b6c-08d83fa486e8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0201MB3547.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 16:18:34.6242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8DNP7XXmysN4DQRdkXks8ZlI57E9mbKZKDmCfl6todyqZWEbKSFRhhe0SEiUIxLBLWUAvTBJ6f8vlzIuRBYGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2510
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:18:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 tcg/tcg-op-gvec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Whoops, I forgot to add the signed off line.

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3707c0effb..793d4ba64c 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2264,12 +2264,13 @@ static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, unsigned vece)
     tcg_gen_muli_i64(t, t, (1 << nbit) - 1);
 
     /*
-     * Invert (via xor -1) and add one (via sub -1).
+     * Invert (via xor -1) and add one.
      * Because of the ordering the msb is cleared,
      * so we never have carry into the next element.
      */
     tcg_gen_xor_i64(d, b, t);
-    tcg_gen_sub_i64(d, d, t);
+    tcg_gen_andi_i64(t, t, dup_const(vece, 1));
+    tcg_gen_add_i64(d, d, t);
 
     tcg_temp_free_i64(t);
 }
-- 
2.25.1


