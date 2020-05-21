Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E78C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE91207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y6NthZfT";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="DYDvPfTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE91207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqx1-0006GS-Ri
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqoz-0005IN-Uv
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:37 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:24324)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqow-0002Me-TZ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089134; x=1621625134;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=pYHPPxy2D3W6t1qkdlNplopppeZaZl3uIpv4wkwD3/c=;
 b=Y6NthZfTixy4SwiGCFP+hwwFH8Ia5MLzTJi/Mm4q6jFK8+iIblc7g5Nl
 pLjh+FZQH1IM5qZMj/wahipeuVEDIBAXFm+IkAsdoLfsMcVNZiTVzfAMs
 qbwZyz0LbRAHtW/vcgGDa+XZooDwocebKvXszwqcH3MA3vY0Fq2ZLlc/l s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 May 2020 12:25:32 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:31 -0700
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:31 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koyvKlKvXUSumVEkPfGJEHU1P3xQiMuCBLxyICQbhXoYLtdPprm+tLmg+p3JAP3+9lZvi12FG3Ab3gH3lpWQ0aIsuq84z/eJeH8O7W1Lz8Lx/t9edA3EGcXRheEQpvfYjR0r4EAbndKpCDgS/+1cXQHfC2d+4YnR6gqC4LTzzuHF+3m3A5k1GQpTUYEV8cvQujT0TUOc1Xdg/PXqKYj/THU6jTBIy+pjrbQvXsnvysuayLAXAmCDkYs4kC+lmCzn8jfwmwyqpood+7tdMPZeT9GXUkTjTFhdsb6IabgCMNXdV/kTNLFU+nMtw7EXCjmu4I3QpxhmYfhmht8hMVwVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDMFJwXb9IiOEqAHO2IvS4PJlOHTpv4GZ+dFEtBKK78=;
 b=PbE9BDH0J1Ik827YHTFXVFE4sMr9N0YTdlTKUsXXS6907/yz8JDSN+FPdoHMcVOdgiq5L2iXjG1TqpJaAbv6swcffQMdKVaTerAYsDAcOzHW+kbmP49GpPfCv2gqLn+bwlFYWaxuusQTJW59wB1ndkf6Lehi8HKQpbVwMPlsJIvJRvaoWFSWz98GRvNY9vG0MwwEAZJwUig0YXqyPp86Lyas/RmDxyb8L7ya3nFlYvUek5jbSAJiTin+k2zb+9rQT+Ry7sGigUh9ThTcZNAwcXdTEWHhpe127otG3XoWFefPIjdk1iQv27jjqo52R00zr+JhEb0c9L6ASN5/ZuCwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDMFJwXb9IiOEqAHO2IvS4PJlOHTpv4GZ+dFEtBKK78=;
 b=DYDvPfTC3waytHqNXingJHKERqep1wjBowCIoUG9yzqKx2entWxRkcTgHAFbeAimosRhkA15sy/jheyBnJ+BibIy51eNI4raIi9q1ZFlPQoPvCRai67kXqOXpAMKeH5tplKUANHQvr5hTYt7yDlakoZcu5JNVMXWDVxtE8O/mz8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:27 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:26 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 00/22] Add risu patterns for SVE2 instructions
Date: Thu, 21 May 2020 12:24:49 -0700
Message-ID: <20200521192511.6623-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
 Transport; Thu, 21 May 2020 19:25:25 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9d6b0ae-56a0-4f69-ae29-08d7fdbcb6fe
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3627558AC7FA161087DF28A1C7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8j2u6nUBaVD7ZJB+HJO48fXivXJyFYD1tFchltp09YOQTQIe3z2C9s6rjbQLPv34p2mFjNWkoftwmntRspmOFbPZxYiW/lGlAPrIL9ebCxJBPCnFSDiIXY3I7VbwQZx03ETkbAoIS6PvWNBj8RdP51qcoWAgeH0PJ8z/+K4ssMxplU8KDbDwOTXwHO+FyqomEiExEQlnVfCcSRmmDIrfAyEXVe/I7OdEHlbjcNSntihsE4p/zLwZwtU+638nASw7UkQIgMLdQj2AyhsRxLaeI7xiMpoPe/cZeECs6EWxFR8kmCpHFFpk8TqKg8SSC3s7OWrIwznj426b9HfA3k3v6B/o8/7yHuBwnzKrVXMIktXlUe8he7yz2tqM77LtVbUs1r3/3+KIiCikbCult4qBtZbTTT7T9W4w7Jyd9b7a9L69wJv2vLGQM56M2n1UQT82
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ClcfrTzJRM96wX8SWyWbPF2uqAk3rT5W+V4dizQ7HPpXTs5YxWJyFfCDLYGb0WScGN09onczHFoAsvCMaiHtqAJ2GkAL2ybYePYnhrRGdi6UKUH58xBAbMyh7TqYh4SfOo76yGYoX3l2GXEyXXTwYFRmhlk15L9/QP4/1Q83ClMmF7h+i/u/tARhfxp09EsH3xEq3ymqdHk1wZKLS4JZPZolVAJQzv+b40uIXYDAHvylnX8ybWPJnciYsWXC+z0T4T0mE30datbpldpqPhJ3W9vshnwUg9+I+e4qvMaA5ErGLuhUm+YLkSiEAxlbaL7AaPe2fEvTW7hCcVYcnDqcVC2+T7SEAX3Hf6Ao/Kd+5RDYhrZ1wRG1RK0GfOks972ihMO5kpVPaCqkcknrAykobjqqEdA1gq3VwvG9Bubebu58WU3fd110dOvI2uOd6NxIL5LoLlCSJK/L7CDKbGbTq1P3SfE4YTb/jm4iRZW39T4=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d6b0ae-56a0-4f69-ae29-08d7fdbcb6fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:26.8273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtrWgSCxGxNeBZ7KRCeY505rHGVXAPcJ60LkOmOL7PQl2HNQobd5w6pQyFQnx4vzCIaMs29JPPdgSdt62CXyiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3627
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

Added risu patterns for all the sve2 instructions. Please point all any
glaring mistakes.

Stephen Long (22):
  sve2.risu: Add patterns for floating-point pairwise ops
  sve2.risu: Add patterns for integer multiply (unpredicated) ops
  sve2.risu: Add patterns for integer (predicated) ops
  sve2.risu: Add patterns for widening integer arithmetic ops
  sve2.risu: Add patterns for misc ops
  sve2.risu: Add patterns for accumulate ops
  sve2.risu: Add patterns for narrowing ops
  sve2.risu: Add patterns for character match insns
  sve2.risu: Add patterns for histogram computation ops
  sve2.risu: Add patterns for crypto operations
  sve2.risu: Add patterns for bitwise shift (unpredicated) ops
  sve2.risu: Add patterns for fp convert precision odd elems insns
  sve2.risu: Add patterns for bitwise logical (unpredicated) ops
  sve2.risu: Add patterns for fp unary ops (predicated)
  sve2.risu: Add patterns for table lookup insns
  sve2.risu: Add patterns for integer multiply-add (unpredicated) ops
  sve2.risu: Add patterns for multiply (indexed) ops
  sve2.risu: Add patterns for permute vector ops
  sve2.risu: Add patterns for integer compare ops
  sve2.risu: Add patterns for fp widening multiply-add ops
  sve2.risu: Add patterns for gather load insns
  sve2.risu: Add patterns for scatter store insns

 sve2.risu | 524 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 524 insertions(+)
 create mode 100755 sve2.risu

-- 
2.25.1


