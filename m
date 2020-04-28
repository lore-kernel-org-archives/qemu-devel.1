Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C899BC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CED20757
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FcE52T60";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="YdCMr6TF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CED20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTUMA-0001yH-Oh
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTUJV-0006hW-Bw
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTUJR-0007x0-R0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:32 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19618)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jTUGu-0001ro-H5; Tue, 28 Apr 2020 13:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588095832; x=1619631832;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=nXL56GuRDcZsfZPP0aS2rMa7736Ie4plUQpm475LPnE=;
 b=FcE52T60sqm4WCiOy4GLSvMwKJ//NUdpedDExmLm2MQrwsp6F3kICMfX
 qTmbtKQZKPrXXM7s3uy3sagSyBIvA1LgcplEsY0nmyrGZOeNeTlNjq1lF
 QrtpY7rr5Rwzw7DnoWRH8LdM+UuH2QjE5boSPJ6MrOqHyHjEv/65ZYuCl s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Apr 2020 10:43:47 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 28 Apr 2020 10:43:47 -0700
Received: from NASANEXM01B.na.qualcomm.com (10.85.0.82) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Apr 2020 10:43:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 28 Apr 2020 10:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWIkW7Kpe9rPnmXgzpVaLkE1FChsq4yDakrMsuXm2KJZMtZRo+8fQ0eM25Ie2COtRqTOBXi5tyKjZvThPuPoc7HSbgh/LPqMWA/zTmHyQSElahT1vuqHQhyZGtEvYoCPQbjRxa+2Ca0wa0ZLnEqfm8LNL0kWbj/ZckqbP+1qbB32AuD+piCQS00LuxPjnkowIyKocEBDFfvPrtLIVaGmavjq1HGKhOAjEyDrIVbGQd5nVE3hcmgWF48BhFnItcTTb6dwUKAZlERr4lV5zbnLBbvnmoqGM3Ctw8e386doTUhWE8UsXlaO5fG0hEHsMaoFUM/ROsLwidg998DjkuIMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObgxLEfvhKlRrf531l5lRtoI0zoCBmNJk43NCe14UbY=;
 b=WSUenzR+QcmzpFxlywKTYP9rjZ82UzHzghFzswW9WU97VHaCld8HIs4PqMA9ddm5iZLbpnIpTI5ODXPzIv6KuNa6xzc/SD2oW5mFVJxoRAc6yJIpjde3+MJan49OZMIR7DaXjbf2LF0XUiOPT0zOl4eOH4rJx0DnhOTigANkewjq0LumcXYSnAxH50DnxvYqC5iiGGKyGLohnh/uYMOu5bRgMzboeOfDLuXVsNgMMmjId3g8K1CnO2+ZtNl/zg4MuxK+deOBKqJaIOmzuiEJI5Yj4XpZgxez0Jb3QusxbdEkscXE1V/LlkenuxBImhMj5fQ/rIxftMAcm+ft9eaCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObgxLEfvhKlRrf531l5lRtoI0zoCBmNJk43NCe14UbY=;
 b=YdCMr6TFcd2NnhOJXVOKD+GIPbjzYAJRlox9n1LBiLDd3WpnNT9a2JrPhanTWuX6XVtyFkD3cB7wk1Kk7MJ8JdJ6J3Y+MM3W0cHOP58baLF1u63KNYcNtjURVgBbbht5j8tg1vKNnCZil3WyMsegb0EWmgZ+v1b7WX1krmuckgo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3531.namprd02.prod.outlook.com
 (2603:10b6:301:7c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 17:43:46 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.026; Tue, 28 Apr 2020
 17:43:46 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC 0/3] target/arm: Implement SVE2 fp conversion
Date: Tue, 28 Apr 2020 10:43:29 -0700
Message-ID: <20200428174332.17162-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:208:237::12) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 28 Apr 2020 17:43:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb886df5-d4b7-4ac1-4a66-08d7eb9bb347
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35316C431903E63878202C14C7AC0@MWHPR0201MB3531.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(136003)(396003)(376002)(346002)(39860400002)(6512007)(6486002)(8936002)(186003)(16526019)(26005)(4326008)(36756003)(316002)(5660300002)(6916009)(4744005)(86362001)(107886003)(6666004)(52116002)(6506007)(8676002)(956004)(2616005)(2906002)(66946007)(66556008)(1076003)(66476007)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHjQvyS0tUw0vJclFZeyMLyOpGOUiT7+F6kSnXHPSSbiVwcjATI7LgR2utv5mHnBV+y1g82fKThVFBZCIsBaHxlBMdcKnUacBVnJnoG4PcUXOHUu43LzaefC6on/Ls1k1ltUbsQxO8pkkeDlaAbnXa43Gq0MIkKsBJQ67MIq4UtPtciQ8XSnLj1Bs/L+WaNp2HT1vYvkxOS/fqnI5dCIl1gaqiZNG5FiHDDc88Na+nVUoTGKSSIvtwPxQ0lj6ChsRO/JSTbXrlEQow4LdcR704dWwCBdBkVRIo12t+sBk3HJ7jmRLWY/GHB9SDu47wA0ZQs1VWoQ7UputoCfCe1g3Ovuy+Q/co1QTQbROCQ3uOmLXWJ38I48jiVpaBAJSTntcsn62FFJTOH6Uc3lvN0LUDqp2mOZtB6sohl6t6SfPw4a9/ZeRHNUYGKxW8jYhfJm
X-MS-Exchange-AntiSpam-MessageData: CDGrI/win0KkmBkfpTEFhaDaWzJkDHhe/h2CmfvGSQB6B2qeDT5ujjEzsykEKoG/d/Fz/vflBjr0Sqw2O2tTenJi0pWUR20QYKZcOi3wl98hdL6vswwAZYZyOZk4MsSEaJVIrpmcpJHO31r6OSE5zJBEbiKJ/ydsh6ZBmTlLnIPO2UU7KNy3pdGEeR9ENymTcRYhh9I8o4wWruzxliFEgw0aPfmcj2AchsFjYv+IOzcZWU9DT/BZehmt3SFIvBTpLmEg6lYQDax1e7E6jr/ejrHBJnEqP294lVOHhI7D8SLvl9PI4xJsi+NQONra/EFRrcQUMAQVhhozR45F1vL1u9A/ojzc4ihoHG1K1Cv2To2XyDfZOyoQ2bzqmkoRfPrZeL1bE2r7Vn5Dj1f56irYHehSf2ziTfqXiFELvX39HIApc6niWsfIx6JRUseWUpsyYWWCP0mJrXY94b1H/QP2YbtgCRun5iePD4LFX2Uj/zcGhBUXVNZ9Qu/tS1qJH5XTDxGqu1mxA1QhVbUPK/WT43nxYmHeoE6ZLEvq/GZHlAn7HVgCU5RgTjZ7RJcP3zY1Qun4VM9y5CcfOehlopam9HUdYb3lUo1koBgb6RtMdJ0MbOCQAA4tEbS11GXuNFqIGvMaJbfNCSOqSJlTssu6N3flu807qfuHO9IvcY3bIJBmhLn8lDvtoDmCzFWHHkjmaX6gp2SReL8Y4fry52VnaB+49p9ljr8HT01iKrK5PozpJD1sgSi0SkqyFsVCNf6Xpk0E2D7zJEj2OsWGPrmPW71qOJ3fv68OPyW3VV10yEs=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb886df5-d4b7-4ac1-4a66-08d7eb9bb347
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 17:43:46.0534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDIU9SpAEF4g8NE7eeVnSYdGHuDT0Mt1SpZVXXg5mXOYoq45DwzNqaXbkDucgedKJlPxBgYj0mdnFC7BzAQHOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3531
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 13:43:48
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

The only insn left in this category is BFCVTNT. I couldn't find any
helper functions for bfloats so I'm not sure how to approach this insn.

Also, for insn FCVTXNT, I'm not sure if it is ok to set the status rounding
mode to odd like that.

Stephen Long (3):
  target/arm: Implement SVE2 FCVTNT
  target/arm: Implement SVE2 FCVTLT
  target/arm: Implement SVE2 FCVTXNT

 target/arm/helper-sve.h    | 12 +++++++++
 target/arm/sve.decode      |  7 ++++++
 target/arm/sve_helper.c    | 50 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 40 ++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

-- 
2.17.1


