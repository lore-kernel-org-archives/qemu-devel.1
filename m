Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45189C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098C320774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="sxhMSrut";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="FRTyY8MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098C320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zIQ-0000ID-8I
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1k5zHd-00085A-DL
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:31:45 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:14358)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1k5zHa-0004ci-EL
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597271502; x=1628807502;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=5vXaj8h4jSfsMCA4uaUM4pwzKoIw8oeRk9VeqAWv1qY=;
 b=sxhMSrutKsDw9fGMV0ndpUEimBnY8PRHinUhxFgOD37l0TG8/exBdHLg
 RHUsuDLoCCxxQezwFJx/q0bKtLZAz4liI7Ww3kwMOE2hK2jTFmEiDpL3c
 olRiJ6wAcd3JO0EyNKa7+Tfmr5RvMQFA0QDhjUMtwBm5XlCl7D2ifHOHm Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Aug 2020 15:31:27 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 12 Aug 2020 15:31:27 -0700
Received: from NASANEXM01F.na.qualcomm.com (10.85.0.32) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Aug 2020 15:31:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 12 Aug 2020 15:31:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGKlWyfPM+jclq4RMaL2sxfovqmfq/jQYaMW2TEzeof9U6anr7jnyEmwkvVm4JuwRMcnqTmWGEOpAybDwtX6dhBcg0dyp6wcovsghVfhQHVcxINIoLvYUAfZbmXxztOTUJIRkWrjDVU2JkdP2dcac1Vx9qj+NVCllk3xtwcf9kZNawTskJsy2yKZOeth3edM80h6b6/kobMEy+T0M4FNta2yQ98JoJg09RnBjIuZZBv4JJq6S104+OaYlTN+59HgstE73+PH3OT/5RxcQJWog7dhhpsyNs9cKLJryz3mLO0fWMQXxaR8WoXTdHiO9Y+e2xkD2c4zCjKKuL25UKk81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f97E6sqCmlg17sL6HSNhlisXn4riXKD+XnyDYVUqf74=;
 b=HVpgfsbrAaZPRngoKgjN3LmJRtICAFXKS9i116lcx83VDvxsbv5xGSUpmNUv1dpxhOkIE3ur7HE/7xHpTykn27EbofoNPusI4G+qQUObZ4ik8AVYB8dAGa3T+yz3F+RwI8xr334qbiSDcegC0djPNmlXmDLTCnhCDaRTBRGeXkgsAG+7BG2fCdKvsP9KRrRKtBQDCo93RJJyhMt9R6JfE/y21WNxc085yowMCWDrLN28FiXvvWy9vJwZBVrOa4FQuMP8IScsVYNweE0JPbKR1KBso6m+qlUjDJPLK12iwoUlnsLsADoWihqYGzDXXRjI+4wPx8VdHIN6jf+w3IJBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f97E6sqCmlg17sL6HSNhlisXn4riXKD+XnyDYVUqf74=;
 b=FRTyY8MJ/1zkH89bh6cW7j+neJoeqtSBFFLs3yS5mnmlpW3mh7Ov6lGqCPyBBf0RFYjRXPsvm/55zXRBt3pFJGmhJBztSMzUYT0K0UozXUkINEEaOOLC/eH0H0MDN2SkMoWU6huIa1vgZwgLpfPjCrhIn/AyA6oqKp3OAABI6Ao=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3481.namprd02.prod.outlook.com
 (2603:10b6:301:7c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Wed, 12 Aug
 2020 22:31:25 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::f80c:adc3:1c7d:e2f2]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::f80c:adc3:1c7d:e2f2%7]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 22:31:25 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] tcg: Fix tcg gen for vectorized absolute value
Date: Wed, 12 Aug 2020 15:31:10 -0700
Message-ID: <20200812223110.229-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (76.167.74.154) by
 BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 22:31:24 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [76.167.74.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1fcab1c-c0f8-4811-5e41-08d83f0f7242
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3481:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34812754FC1C6574F5E18BC3C7420@MWHPR0201MB3481.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2b3C3RZrnwioVFS6dSo/8wEWnYonxv+/YIUq2pMQ6qQfw6a7qyW2ymCGPs/Qqi0yQG/Q7tzOxgF78jaA5Eca7XRkzA8NqtMSnfDEx8HezLNqrrFnNeMt46SdFdBzOQTbr7byTWr/8uloL4+KwVRnyVI4Ua3YTOVBwqW4JCLC/xqO0hx4MRCkF0B0hotcDdP4NN4k0spFB6U9Yob3+qTJeV0Ee0Ccw+GostdqAih4rIZNh6xL7vumJa8rFnX/LIDqfxscyrThG3glCj11YOKlYyhmCQUJXvpKQOiu9Mi7o6lyrVmvRYGSDmHZ21dgZSBp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(396003)(376002)(39860400002)(136003)(6666004)(5660300002)(6506007)(2906002)(6512007)(8676002)(4326008)(508600001)(83380400001)(6916009)(956004)(316002)(2616005)(6486002)(66946007)(36756003)(26005)(1076003)(66556008)(66476007)(86362001)(8936002)(186003)(52116002)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kp8SjDOoDnSvqqUwnF/+uPiVrs+MMJfkvjH6zbFdPIafBqeZWBVFpD2TZT2+EXarn5PNxqfuo2riQJ1JdhaCKlrl23SPrtOJ5gGn+o5kYBtCDtu3tzFgOJxWVM3rf7mPMIwe+HLE9xQYcyN9opjGkqgHc6y8Kx2KJHXG81NcAFBKiIvWirSXf/9q4frqwNjLAUrdmdFfxNyylrkf3xv/3Ce4ALM+W2eiNfrw9rsd6bwqLb430/p9aUYi/331ftpBzWChSXAGosUbZdZMGOKkgWlhUVvUU9a/92V6v7FWDyILTd64sSz+BERhf6FNsnGz57KOBYx526kLMSsZM0v+JBV5yWDfNEmsaTMkb2YTPzknTitDl1+9AAmkvudPgoxFjFFtK0qolOi4w3z53JOTaMK612v68D3+RxJVL+Gq2Bfm8QqTPQ7v701XZgdY5NRRis4EoR8y8sl+oWAPESxGPdxEDKD8LluPUZExEKpVjQOlnskxU1YErY609YNBdj5ec8I7RvowpcWZlAaREVBV250Y6kL3HnR5yH7rN22qLHvr50hQ18/yxZGcH7Jn963+09nugruXcT7gtFDpj+Y7pwMNczaPz7ewjMg3WSfO28UMyCB4m+7so8WgVGYlErf0jFXcllOZ9l1nYHkJSeR0mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fcab1c-c0f8-4811-5e41-08d83f0f7242
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0201MB3547.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 22:31:25.0104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcjz1cmaNxsr4KmYJojL8ovsORn7aqzo3NO/kYqd19zsDOWjaSIzh6Le8pDcLDQ5rWJiKQymkUD4035cFCzZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3481
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:31:39
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

---
 tcg/tcg-op-gvec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

qemu was generating buggy tcg for arm64's vectorized absolute value
insn when the machine didn't support avx insns.

Subtracting a mask of -1 for each negative element doesn't
add 1 to each negative element. For example, subtracting a mask of
0xffff_ffff_ffff_ffff only adds one to the low byte because
~0xffff_ffff_ffff_ffff + 1 is just 1, instead of 0x0101_0101_0101_0101.

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3707c0e..793d4ba 100644
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
1.9.1


