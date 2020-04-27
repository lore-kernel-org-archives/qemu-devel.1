Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82625C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430472070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="t43w5G2T";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="RGh33Ghi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430472070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTBWX-0000x7-5l
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 17:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTBV2-0006t2-Lq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTBUz-0003Yj-Gp
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:41:12 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18991)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jTBUy-0003YO-Si; Mon, 27 Apr 2020 17:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588023668; x=1619559668;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=jCmMY3DNt6TGecRkT08nqLfuZytCGQb9zOfQRttBkhY=;
 b=t43w5G2TdbcUx9mwEQdQMUNY9Hthhyj7FSZS+xTwGXVdvlqF68ypWqoS
 spUMypXCiTfN6j5JjUEm7CX4G0aooDVEX+EY5kypHph/ICWOZSoleml5Z
 /hbBXio5jui5QKxNlUsJfe7A0OlL9+dnG6scGDL5S5UEHecQLKX+qymO6 w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2020 14:41:06 -0700
Received: from nasanexm01f.na.qualcomm.com ([10.85.0.32])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 Apr 2020 14:41:06 -0700
Received: from eusanexr01a.eu.qualcomm.com (10.85.0.97) by
 NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 14:41:06 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 eusanexr01a.eu.qualcomm.com (10.85.0.97) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 14:41:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 14:41:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZqqp/B+l5ITlwFI5q1G5la1VgWeSNqmwRutCMJWVHyhT/rnv6Z9LWB9VZgcEqgzseoxqSBTk1iJ+Dl+OSaQuydqMypkvswL5CqhDInT3xrA1nkQJuKU3omPIEA7QdOoxLdf2yXuoIsKPKOoXt0UyYvVllfWLDyFzfz/nZq/cQGqrQYRA/KVMjJjIwkJDbwQQQyQT4jxMgtQj2gfosy0uEIWtaT4hthbffix2hjsUGiHzHqJ6E/vuE1odhYbB1tstXys1sxXo9T16RI/KO5BDEv5EaNje7lbJSu/1rkaJcCK4ioa4zgnUd7+rEU0I0C1rqE0+Ru22ug4fVc5pMPDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMj4Sni8n53+S50wB6ywMbuOmQ2XXZnDuH9edwq07jg=;
 b=OQrjG9JyIMgaeOhNHkc9rWkCLFrvhYGm+8M1N60pAnCK6B3pyrwFS88AG7hdDakzz3bRQgcZJv/x1kh332P3fZ5fs9v9Vicyo+uSYX2HGU9yHSgyBykMO37zRi8NNzoBQt1Vd8mXCau+kNufPcpHwi7fNoJw4Sm39EAu85VMCVwfXy2xKICgjHWsX0xDsPV84VM5vDNqtl+odHan1GSaIzpA9X7CL/9wp5iLstedx9vM18WuOs0ULBox1yo+FYjNbZE1scFFW8LPKxKklczRoeU1YUWg8IlQHpILVOivl0f12M2ICjeQxTPa0H5fr9ljMotlOHLsiI/yfd+kQihj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMj4Sni8n53+S50wB6ywMbuOmQ2XXZnDuH9edwq07jg=;
 b=RGh33GhiP5LsiRkxrQqJ/qKgDvQt6mqC5JtIkuMfHaAJqklzO81qT9QsAquUGjyEvZiJEmGpxQhYNSrRfQq0c7pKQql7o9SMrP+fLuX9ryleH5lURhtSONGouvV/JOVymcQgvLkD8DHq/3k3qSc1UKiWAJY4F65HO/+adD1ftWs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3577.namprd02.prod.outlook.com
 (2603:10b6:301:76::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 21:41:03 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 21:41:03 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v3 0/3] target/arm: Implement SVE2 Crypto Extensions
Date: Mon, 27 Apr 2020 14:40:43 -0700
Message-ID: <20200427214046.31401-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:208:a8::27) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:208:a8::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 21:41:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82accb84-f6cc-4dc9-8d27-08d7eaf3aecb
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35779AEBCCB4A901D00B3646C7AF0@MWHPR0201MB3577.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(6666004)(2616005)(478600001)(36756003)(6512007)(107886003)(66556008)(2906002)(66946007)(6486002)(66476007)(4326008)(316002)(1076003)(86362001)(6506007)(8936002)(81156014)(26005)(8676002)(16526019)(956004)(186003)(4744005)(52116002)(5660300002)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiDQHBMXnr/2QjEo8mmc0w0In8HM1AYoxeHSKaLW7QD7LVB6gbfwHXqGo9i+w0f+yaBNTk/2xlGSGnpiuoMbEzaVyWW2EZ7425CsnEK0fCigq+oTE4I8mfKhohpA0H5XKW6wGNTTwxyzSL8E8i0RvctDOqoYu13UXg5ZzcDBOlo33OIHX2fJmOWTYiNDQ6i7zycWYFp9CzoWtvM3HPqhsyY0gLzoI0IGR8rt1Od+Hj/efmk40NwI2VKdAgIBFKQeWnhn9g/fFcH4VGnskMJzxY7bY9Up0J0VGhp5UrTgv0UvDKSC05+HXGmPKMA8McKygR2exfJt+/hu39mN8LY9wkt4E29Bphggfj4gHySbHYStO5cho0qEl341VXe2tTCtiaNxpe8hqDav/qef8TFuZju5SubHrw/b2EgeEx2oz0vpQc3RcF8zQu42KF7ojmLH
X-MS-Exchange-AntiSpam-MessageData: RlgTdRrmqXGKicE97axuZRTVqxa6+HRKrNqQYK/134xBxfnpwUpzwb4j07/5SpRDqVW7w4eOb8JYY2DXIjsASUiJHl6aLrHoxi/e2L2td3fQobUfmc077ki4mQhHAOTD1IjsNNICIG35FtRej0ZcHPkYv3HbFv4qux1meF3d0KcsBpViCateEJ2uS+CAKtOF7V2WUa7KnzubH4Oi9P/6MbAjOPgVOQzN5QVbWYidRUejbs87wihDyo3W7ndsPX08aTOwhL6x6flAKe0U2cYTcaeCZ+K9kdx5f86OQb8XwKgaSTjBxqM5qlXKvMhfgWCEP9LOmMa6PkXd7JuypIv14/RmoD/brFParpn/WTaHNEqSU94oq+a1gArit8FvRhWXaQWLsHbiCOWJoLQJsVaQ+TRnA4F7JMdlzSNjrkqjFUZyi55PZP8idfrFH+HCR/RDl29JBb/AbLesXji05sqSMf6NYDrbv4TGASbF8zhqa4GOJw2juDnGQaJ2ZPvWC+bRRt1y2vhSwG1QqQw2LGjAlRpEFDHt6lYfOLGeZUUvXuslofe2GM7v5XuW2hhjvqoWGrKalrZuKQ898Wa+/m5dBGqul/rpkkJh64GOvjTl8AMWXQngWGD+ylhll2phI9mOE7DgmiVP8MZ2QOEZnUkFgdC9G2LY23zwtbetfot8bKhy9GTfHCvFkpK/eIridRGLfLdSUF+MTcrzF9k/S1ZU/g/qh4O258N/7idU81fVvSYbkovaAKANHOmeycbj4A1OP1PcVFq+7uZzIzzv4XRC5CedcRYfr69a93HaYUDUETc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82accb84-f6cc-4dc9-8d27-08d7eaf3aecb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 21:41:02.8881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxeT655Zeza2Gpxvcc95SXVU3wD+PtrLSjHHDl7PsWXuqowW7iYDE+quiQP52j+3joHKIahRxKq7oKbchI4+dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3577
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 17:41:06
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

Modified some of the crypto functions in crypto_helper.c to take in a
desc parameter.

Didn't add a desc parameter to SM4E and SM4EKEY since it is used in
translate-a64.c and the functions in there need crypto_sm4e and
crypto_sm4ekey to stay the same type (i.e. take 2 or 3 parameters)

Stephen Long (3):
  target/arm: Implement SVE2 AESMC, AESIMC
  target/arm: Implement SVE2 AESE, AESD, SM4E
  target/arm: Implement SVE2 SM4EKEY, RAX1

 target/arm/cpu.h           |  5 +++
 target/arm/crypto_helper.c | 86 ++++++++++++++++++++++++--------------
 target/arm/helper-sve.h    |  3 ++
 target/arm/helper.h        |  2 +
 target/arm/sve.decode      | 20 +++++++++
 target/arm/sve_helper.c    | 16 +++++++
 target/arm/translate-sve.c | 64 ++++++++++++++++++++++++++++
 7 files changed, 165 insertions(+), 31 deletions(-)

-- 
2.17.1


