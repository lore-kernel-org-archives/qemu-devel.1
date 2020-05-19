Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03D1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D1820578
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="r6xU0bWE";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="lvH2hH0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D1820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4kX-0003Sf-V2
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j2-0001SK-Vj
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:17 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20816)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jb4j0-00036p-LD
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1589904254; x=1621440254;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=cgfez65Avlhn8gnlEkJDzz8hQH8YmzD24OQqEqheTww=;
 b=r6xU0bWEl7ZQFFhwBQfhDRJVgBcmDRlepk+NhkcVrgdnDb/de8Lr68MW
 5UOUbfABmVQRB2lXJxzm1bjMeo60LJZc3JB4m/6ontxTZy4xHOsPU8pZB
 MrcH6X9E8qrdLiyTHRvL0Oc5el4DQKa7LAiMCe6ql21YhsaW5xBdy8wE+ w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2020 09:04:11 -0700
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 19 May 2020 09:04:11 -0700
Received: from eusanexr01f.eu.qualcomm.com (10.85.0.101) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 09:04:11 -0700
Received: from NASANEXM01G.na.qualcomm.com (10.85.0.33) by
 eusanexr01f.eu.qualcomm.com (10.85.0.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 09:04:09 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 09:04:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyMuepBA5vb9gGuDtD4D6mB7W0x+FX15HZ4fujmwMnkZVTRiCGUdOnhm0t58cUYN3qeatW37EPd6pY3vK5eeYuRs6EC6c10fGFSB35150Zrb0oISiS1Xlwz8ATOdnwzA6SmUo/pU5zeeiqY5CGITjQmj68Lje7l+V4ELeOQwNgj3qs0y7weQA2I70vqA2z8+LVRlOJv4ztkDlp2Io/YuF5g+Hs3aaWs9Ga4hX5KPY5rTRWywNLLd+uHU9mrUkK2vQI0zXMeb2HXUQAMmDp9XVGUzet4LBPbwR4YZGNg0iQFo7Epi3XaniM8qDftEKE3z1HwIJQpoMXjex27DWL68cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUQ1vLAiTfZhjWK34/9jPfM9GnHGg6u7QRneVQ2GFyU=;
 b=cZJ6xlH5GwJwTmvMUtg4K54i/wZaKMeMV45q71tfsMj1m4hXqIQDZxP5P5MB3Exfl+XXy4RCxAH8jfD2v7gNhcloZUH1wPN7CU/j8UO03gtX2q3egT3VkJ6LL8CPjE9QiIZDF7jom2R+H9Z+ixZrD0y/ULKvSn5WqlRVVBSEu0iJX9/KDipLpSjsVNMfeoTe/ilfzWDTDlOB5MlkG+EbBerr19Zg2K2CfiE/ObvKLvtJ7rB7ZjoDTU58fDuOIDM0kn25UDoG1MkChp4B+QXBa3sUNtzvaUPXfV0NF3MVYwpP4aWoQ4QgvA6y5yeneI7iAsfB2MJloKzFx03LModckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUQ1vLAiTfZhjWK34/9jPfM9GnHGg6u7QRneVQ2GFyU=;
 b=lvH2hH0WdbK6OAq2BC0/qtlilIs55yU97d9sYetF0Zh8M1sfimS2Q2wSAEtSYmaDNGhFyRdX7Vp1ZXHOnt77B6k3mhqjgOTmeLZDNgBxSkwg17mF5ISQOma63hs3dTApaPCDs2DJQNzY582a/AZiUQlMTlN8CdduT/sg8C3KWlk=
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
 16:04:07 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RISU 0/4] Add patterns for SVE2
Date: Tue, 19 May 2020 09:03:50 -0700
Message-ID: <20200519160354.4430-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
 15.20.3021.13 via Frontend Transport; Tue, 19 May 2020 16:04:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d890f237-334c-41ac-ef95-08d7fc0e428c
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484907493EFE6E87CF59357C7B90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn5TAn45yzm+weVn7T5K8Y80DvSrYKAt4HSV7FX50GSLAFt6KA8rhPRbKn7nmhxLMAUaf8KOssM7E0HUtQP9cG+yfJvqysHjfrQgkoZvYNFp/2AnpZWaj5JaeCsq4q8A1Fpd/B0hnVFZfHTn4uAtteoc7jRgx0+I/JQswc4MCXdyzzBkw8HB6GV3YlrWYprMxTMI7Sc530St+UP3hOZMyeJyFDAZrrQMdjpm57/Ld7SGp9tnqsX5+etpZzVTifZdmx9S4k0cBd1l3Afug+arzHJQgMyipu+bT5DCX6RkJYaYqjS4MhA1Us3Qh/l8BGzs/D8rTJZnH5dsqNARKwlAWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(4326008)(2616005)(956004)(66476007)(66556008)(66946007)(316002)(6506007)(52116002)(16526019)(186003)(5660300002)(86362001)(2906002)(26005)(8676002)(6486002)(1076003)(8936002)(6916009)(6512007)(6666004)(4744005)(36756003)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ha7mULzTN5mKIa+MgcTN8okf3rwQRUFE4CZg2BWDI6N9efvqOcGH9QbSuFfkeZNQJwqu11iuMxxp4DqjHhucn7qzsI7cpTba8Lgt8wAxlSlxwoufpZySA7s5a+kGMl4OhHn6g2rYHKfVA/hXHNB6x2UiBbsCiUTiu+qfFrNoRciadR1KFZSDVbwZyjB3KNyVkYGpt+4k1BR0RKBq0Wga6cRIWi7E1k1MWw96vPQhnBIwlw+Jivl9UvxVlNFLEx4/PRrelfy076byJlU0qHbpuZvgR35Sd46rxmgnuVs6q3VNv5yyFCpb7hcC8J8vtJNutRK3oNrBx/dnQ7eDSA5mpmVJXl1qTWCrZnMXMEfI9zZaeXUU/TIF9roc4OD/sbZEGbJ+yweqG8zF6jtAlt7dRBhR9SpY26kArVl176IN4IAC/MTl7A+03257znDIHkvy9AnaV/ZYZxD6OSSnVWJT7vSopZcCZrRtSff8uPnrj0sr+oMrOl6RtHqSzbQe04wJ
X-MS-Exchange-CrossTenant-Network-Message-Id: d890f237-334c-41ac-ef95-08d7fc0e428c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 16:04:07.5147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIOYXgTSBbKgKcSVlZEXi1Hu8Zw7zP/hCWtJmtzmfwxpXNa53/Ilz2rfoavT4sByB6XSeeTE/V5QiZwyTGzmvg==
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

I'm working with Richard on SVE2 support for QEMU. I added some patterns
to risu so we can start testing our implementation. I'm not sure I'm
doing it correctly, so it would be great to get some eyes on it.

I sent Peter and Richard v1 of this patch series, but I think I should be
sending these to the mailing list. This version of the patch series
includes one more patch.

Stephen Long (4):
  sve2.risu: Add patterns for floating-point pairwise ops
  sve2.risu: Add patterns for integer multiply (unpredicated)
  sve2.risu: Add patterns for integer (predicated) ops
  sve2.risu: Add patterns for widening integer arithmetic

 sve2.risu | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100755 sve2.risu

-- 
2.25.1


