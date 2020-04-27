Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3004C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871C020656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PgBWZPre";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="AbSv/OZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871C020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5jW-00023k-Kz
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jT5hO-0007gu-MQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jT5hI-0004Rp-NT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:29:33 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:49183)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jT5hH-0004QT-HR; Mon, 27 Apr 2020 11:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588001367; x=1619537367;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ukVOBhRuoyuJdxJJZaT28IUT9HZ+mtnFzCtlL4lL88w=;
 b=PgBWZPreroc9o/f0qqWQEzAeFAsRoJJvDK1A1rbDTTot4wLdGS0ppON2
 VdlPMIuNrSS//PCLsy/Ub4niR+X+Xrwd68fel6/8JtseHcPwDywezh7ff
 8ZQUVrDJvLanc98Jw9NaqqVcLmSQqVuCQDViyfeWXCayOj4eFaUfPBZ+g 0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2020 08:29:21 -0700
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 Apr 2020 08:29:21 -0700
Received: from apsanexr02a.ap.qualcomm.com (10.85.0.26) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 08:29:21 -0700
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 apsanexr02a.ap.qualcomm.com (10.85.0.26) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 08:29:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 08:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9EboTcsqKM7RwI0jTpHNgBzwo6sW/QfPEzPD0ZndjOCifY/41f0LttxwIY83TMbQzGBlfrh7QYc8mqA2v5rNtMqr+fIXxl4lCyID2z2DuicX6fpwKhd8+mHKl6rxXkEdekFAuBCiME7wNhzXnTXIvGst8Ks+2fqnXfFhUz6UG6JThE1b3D4SQSWyG8QBq7qnN5X3Kwbtv8BdsDtDp3+WyNg8Zs+JuhKN7OmfI2BPvH3/jiSgFgY5+xa4uIbhNXsrOMXOOtiR/3ZeyapuH8hLoBkVBpK4jC5UWtducCTxqYy561J7jOeSIINIsHIUs633f1h46THg2cEnEr+GnNNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03LS1Ff55y/QZyCSr8zNOLrdlDMgX6lLrnr35BoL6+g=;
 b=j2fiK03sYYWSIOXbnBZT76GQOVxBGwkMgCv5gBhuJ3/1yncNp7Fq0g8SkrcUDZ82wCSmslM3C7WpiwJvH5tBeCfEcUqTssp2MdOJygrDIHoCSkEsVHlOUjdtHjH5qFP1neaNWC2h/Ep9jDquSS38EayzCPDrFmCrxTAFt5be2Ju958av/zbmMmFujxQTHZEYcC0rVmc5ds31qRtAXz5liuurT2aZyq/DEFyGN3kZpm25nVtq0lbiulToBjRck4fiJD3bqy7LnVdZhkHLoEVlO8u5hlEz3nkH+b7gnmedF8UGm/9Qc+Ck2tBV0LBkjs8hZ3XkFEoZmsRAbXynwfnWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03LS1Ff55y/QZyCSr8zNOLrdlDMgX6lLrnr35BoL6+g=;
 b=AbSv/OZuRiC8JibhzzRbMqMxMtfDvmKpbDlpeYlWpC/UnJjnjIo+LZM0hfV4L5guSeKRUVLrwLt6p1n4/UjgYKQoLhWSq5erEGZ5XY1zYBfqTyJjHAwYSKEd8FU1DfTFTAaNaXYfh19Fz50mea6l1PW6xljaJqJz8hpU8jC7Rns=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3465.namprd02.prod.outlook.com
 (2603:10b6:301:76::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 15:29:18 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 15:29:18 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2 0/3] target/arm: Implement SVE2 Crypto Extensions
Date: Mon, 27 Apr 2020 08:29:01 -0700
Message-ID: <20200427152904.14768-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:208:fc::38) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:208:fc::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 15:29:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dc623b4-fd00-4610-3e6a-08d7eabfc029
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3465A1FF511AEE5F0CD9FFC8C7AF0@MWHPR0201MB3465.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(2906002)(6916009)(107886003)(6666004)(6506007)(66476007)(316002)(66946007)(26005)(8676002)(2616005)(52116002)(81156014)(4326008)(4744005)(8936002)(6486002)(478600001)(956004)(5660300002)(186003)(1076003)(36756003)(16526019)(66556008)(86362001)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMUqDOtrpw9kje8a7Od4mpBRG2i8erT3ikM3r/ivdw6fpxxJiyTfZJb5MerUkCs7PdAxsKyDysvsMX4mT+JMlilFoRUjD/TXSO7m93yCjWl9MSmY8FelA/sxLwxPU7RdF3hK5r7vbrFCo8QFJlPHmqZHEgzngFOYRZQeWYwMxHfAOuMhT0/CFTLodi3blEW4fA/kN1C4EQBhSnpzRtuuto9v03IcVWR9NNqSTQey98JvtBtE/ICy9V8I3FFWKFUHeyw6KDc6ZUY/M78uMitqdtUZ4T0PO3J5Y9+xK+RW27HHy2oJhN4xtJCjTR7OOmOO9gTiYNyL35VLO4QA0nQ2xt0u8QolVdfHapWIprn27dR9Ui8Qsyn7IrZBUd/N1GHTrB10iiN8O9xIlLbMOnZVeWDV2TCZqZlhA1iH7u+j7LIh6qj+nJwwL9AZCil0ZOQS
X-MS-Exchange-AntiSpam-MessageData: GJAhHFslPlHpU7OmbJXJXGKcHzms/HBpfUlkWqD2e7mJCZyCiw29JRLmJn7xL4s5vcirQuGkcV22vfEsQhbgZ1cbM4232n3o/XmYmbflFrU+LkJbJ371nq+jXrqpjmE7b6XfzExSklRDvjOxGa9MGxMhHazf3LwtrvFeyUB13Z9Mn2S2Cw3UcajBcwbNzN57ijYCOyI++vHtw1JvV7XLcpgZef5+D9nLdYedOICU4A/BRWL4jSYQ6onKUEXQcTh20jOrPLr1StdQB3ycQQ7Jsm3AcVLfbb49me4nsYXbR1rf+b3uUW1KizgMzpATiWP/JoZlBR5FDb/PUPajiZzaYxRdHRqtyX3YuKhaWWLUQfHA0Q5zrESjtHUB5ijmjtiLXQDW+i2ptJwl9OqYqqpn4XxTjE+gyteTjzAM/MT7rtcvoWEwFkZ2PmwPeUzwBRAapAKTRcGXu9tOCMo7l2rNEPX3kZJOBWf5KEwiPC5BHTekGlNYk3MKok/C+KjKwjtHtne3kTXBfGTrXm6SqiPZm7ENwbituUdwSf29yRTNdQbHmSAXgEJMrZpmnygn8rQniHCo+os5lzo91vYftDPS6Lsi9vNV3pkAh6EjKpJLmieufrapkq8cB9MohxTA/PJqooCZuY7MV/VEifWPdm2uSeOpiOCn26Ns9aWB7TBsF8sqXFnTdyRL7qFogBt6BJhX8ATYpdC3EtpUC1KjSTI2mZaGSwBPB/v//UtudhuyP6xiPPx+IAUIiUFAq5DzNpgYjgjt3dGTW9PIG6vletVOAlJwnR1phkvXkgf3rILbgtQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc623b4-fd00-4610-3e6a-08d7eabfc029
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 15:29:18.2204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQQxUT5XQrx5CqN+HtQd98YEb6e2WCI/u7Hod70w0Oqmog5brFnTWMueKrnYLOhamJJq+AeVgkkcinlm+NoRyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3465
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 11:29:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 199.106.114.39
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

Used one macro to cover the helper functions for
SVE2 AESC, AESIMC, AESE, AESD.

No macro was used to implement the helper functions for
SM4E, SM4EKEY, RAX1.

Stephen Long (3):
  target/arm: Implement SVE2 AESMC, AESIMC
  target/arm: Implement SVE2 AESE, AESD, SM4E
  target/arm: Implement SVE2 SM4EKEY, RAX1

 target/arm/cpu.h           |  5 +++
 target/arm/helper-sve.h    | 10 ++++++
 target/arm/sve.decode      | 20 ++++++++++++
 target/arm/sve_helper.c    | 46 +++++++++++++++++++++++++++
 target/arm/translate-sve.c | 64 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 145 insertions(+)

-- 
2.17.1


