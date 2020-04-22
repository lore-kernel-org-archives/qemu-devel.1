Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92882C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6402076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jCi5nGxZ";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Z7m6XpUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6402076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHPQ-0004Ht-IV
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRHEV-0006tR-Ei
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRHES-0004w8-UV
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:24:13 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:14443)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jRHEQ-0004F4-Km; Wed, 22 Apr 2020 11:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587569050; x=1619105050;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=dxNlERbcW/ud9FgA2qYxP8D9bQ+KQ1javPWiXJXY6xc=;
 b=jCi5nGxZII6CI1IlgmydHzyTGJa2gA4EPMH+U0kBS8MfiP1st7Ixb7zM
 1MX1vFP4PMfbt9bM0wia5QpzhHshx3aqbDtyHjKhF+NcU8ui7Qs4EGFCe
 hOtBtH7L2pGwsIfQ0hc9SHtN1EiSr8bqKmn52a1vYE8qQiPeD9ZLHIdc9 4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2020 08:24:06 -0700
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 22 Apr 2020 08:24:04 -0700
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Apr 2020 08:24:03 -0700
Received: from NASANEXM01B.na.qualcomm.com (10.85.0.82) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Apr 2020 08:24:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 08:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1c+VXUo5V8RYf5WiaGGogoWDb20+7VOhAtn7JhyFnW++6K+8VU4l7iFaQCZONq5Rl4S00/AILX5jbKTYqt01njq2Vg3TTNUtNyQDxykBqnfaHpMfnW0iNon2pLc8Ug1Wg8Kce4RRMUnjdulAkSmKj0f0Jjb+PgPBA33I6ZqAUfRhWa6yElvb05kkp+eh090KCjI0kw07AkAFRVlN5zc5Nc6C1RaPa+vLmfqbj+pw6lD/5JeyRPoASclG10wlVJjZGbi3As6ctY4mnPR3LtLPp588llrM1wbvARHLwOae901uYftf2cWarkQHqpycfXqBsodDyxuLmjCRrvo8gSByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jraKluTNVz7+Iid/7KQtf+NHIJI5R3x34JuWy11MGnk=;
 b=MJHmKjfC90q/wPRBFxAXKhZdcNjtYzz+DopUPkIWZEFik8lHiTpBH1j4zHklEN39kmNdLcNwSot31sOpfAJRTrSaIX0Ywj58FCqjXpYiLDG3SWE3L0w35TdEk27Q+IfeI80FmnlBlvFfCk8PgwJAlVNooXZdm58IcwWA+Y/ap5OwBXmjUem3FJPTB3Wv+vYubS+i1Wgtw+/W3Ru2HxJBT0DPueL7d/BOK+ZEvL2djowvhV9Scwei1quizKj4ZyfuhcXlmEt4NKrOMM1jErfWBdJEs7n33cbKEG72DgIISLmA8ZE8FnaZQkxEojtSKlISyBtKJFl50MjwUG1Aw7DqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jraKluTNVz7+Iid/7KQtf+NHIJI5R3x34JuWy11MGnk=;
 b=Z7m6XpUQWJAU/ssjcMNp7NAGFiaGgVsehOY++p9PtcWPudpPRTr4ChSpEdnzTFTOLyUDNQJIMsYE0PSnUTOsVd6GPwEp1v0utyLVyMScMW8ZuD5pLNmlwr2tJufGV7TQa0oaa/MBq1vhSGGVN92t46FHMMVGQYvxGGuwKA4b/MU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3564.namprd02.prod.outlook.com
 (2603:10b6:301:76::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 15:23:59 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 15:23:59 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC] target/arm: Implement SVE2 gather load insns
Date: Wed, 22 Apr 2020 11:23:43 -0400
Message-ID: <20200422152343.12493-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0044.namprd14.prod.outlook.com
 (2603:10b6:610:56::24) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR14CA0044.namprd14.prod.outlook.com (2603:10b6:610:56::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 15:23:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85c693d0-aa97-4c7d-5355-08d7e6d12ddb
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3564A5B503E73890E33A5629C7D20@MWHPR0201MB3564.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:272;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(396003)(346002)(39860400002)(136003)(376002)(8676002)(16526019)(478600001)(2906002)(1076003)(107886003)(956004)(5660300002)(52116002)(6666004)(6486002)(6916009)(6512007)(6506007)(36756003)(186003)(2616005)(4326008)(66946007)(81156014)(66556008)(316002)(86362001)(8936002)(26005)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XW+sKG3CAjYv1f/3UzmYhtjId7rYQjo6UEUaPVkZGDykdJ637ENYH7gQ+VZtOilixDUOYE3Deg75Q1QIw/s5FcnSqWgCQjsafYGtNHnBKQqgUayvxx97PSLKon79kkR0yFbjomDBEXh1SVTBlDO46GPXeFktLqV4q+ip5fJ6mQTNoQueg41XWuYHtzgOtaQDPTfsVdkdeVj16Pl6dtrQ1jE4NDEziUiUB3WnEsPd7tyYMwBAHfwioIQFD+xfT+rVUNojG42z7XKfPimDoGmgLdHc2cawBSfTL0oGXqaBwEBFpSCEuZTHH8PPsBG+yNgiMEP/BbpOsQ1WNtZNbHSPrcai3kkEdZN6kOR05YFwnBuCpv48Az284mi0U8EXSExlkB4it4Z1F8Z+b3SATABPebRYiKEnWkYkHPfO3s9dCOoN8RI0mUFPzn0uJ9uUVFSK
X-MS-Exchange-AntiSpam-MessageData: RxMuP6l0CG1hakrybkRHXW63be4m00i/t0Fooh3V3Mydc3WfHEG/ePVfEnQ8y2kYVbUC8qLc8zSnuU7zqwPEWN8iurI7BFbpb59aJTFvdyZyck5CJ6JF/MoP44zE2Ec9jwzERkA75IQMiJgQO9AgPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c693d0-aa97-4c7d-5355-08d7e6d12ddb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 15:23:59.0375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZBU1IiS8JaBTZyHwkv4kvGMARb54OcPFS4GwkGQdFi2eyRFXZGoVM8DGKT1xod7lzKIVoOnXU5arbgVO/VxQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3564
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 10:15:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add decoding logic for SVE2 64-bit/32-bit gather non-temporal load
insns.

64-bit
* LDNT1SB
* LDNT1B (vector plus scalar)
* LDNT1SH
* LDNT1H (vector plus scalar)
* LDNT1SW
* LDNT1W (vector plus scalar)
* LDNT1D (vector plus scalar)

32-bit
* LDNT1SB
* LDNT1B (vector plus scalar)
* LDNT1SH
* LDNT1H (vector plus scalar)
* LDNT1W (vector plus scalar)

Signed-off-by: Stephen Long <steplong@quicinc.com>

I'm not sure I'm initializing xs correctly. This also goes for the
scatter store insns in the previous patch.
---
 target/arm/sve.decode      | 11 +++++++++++
 target/arm/translate-sve.c |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index ef5dd281a6..d7799746ab 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1388,6 +1388,17 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
 FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
 
+### SVE2 Memory Gather Load Group
+
+# SVE2 64-bit gather non-temporal load
+#   (scalar plus unpacked 32-bit unscaled offsets)
+LDNT1_zprz      1100010 msz:2 00 rm:5 1 u:1 0 pg:3 rn:5 rd:5 \
+                &rprr_gather_load xs=0 esz=3 scale=0 ff=0
+
+# SVE2 32-bit gather non-temporal load (scalar plus 32-bit unscaled offsets)
+LDNT1_zprz      1000010 msz:2 00 rm:5 10 u:1 pg:3 rn:5 rd:5 \
+                &rprr_gather_load xs=0 esz=2 scale=0 ff=0
+
 ### SVE2 Memory Store Group
 
 # SVE2 64-bit scatter non-temporal store (vector plus scalar)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4873e25182..bdabb89e82 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5886,6 +5886,14 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
     return true;
 }
 
+static bool trans_LDNT1_zprz(DisasContext *s, arg_LD1_zprz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return trans_LDNT1_zprz(s, a);
+}
+
 /* Indexed by [mte][be][xs][msz].  */
 static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][2][2][3] = {
     { /* MTE Inactive */
-- 
2.17.1


