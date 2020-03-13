Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF619C1975A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF8B206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JvOS4xUE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Sq6w7/lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF8B206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCYct-0002ko-Pd
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCYc3-0007w6-9d
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCYc2-0004vE-9j
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:55:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5350
 helo=mx0a-00082601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=03412eee96=coreyw7@fb.com>)
 id 1jCYbz-0004iq-Ce; Thu, 12 Mar 2020 20:55:39 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02D0nfId011859;
 Thu, 12 Mar 2020 17:55:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=facebook; bh=fsRtuS8klfa5SD3pPfrMomknIQY0F1oVMbRs0q2bW/Q=;
 b=JvOS4xUER1tW54KyvePB0pURFuCGbXvTCuUXTkh6YYrurZVmO0N6kZPBkOlfhRvreMUI
 UeL+3cCNU1baFyzRSkkzcZizg3NxKUeJV3AlGi2gGZd+oTZsyDL2j8E0fTPPofQV2GE+
 jlkPqXtmk2cjxvtgmisVc9BKhJ90q4XUBHg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by m0089730.ppops.net with ESMTP id 2yqt7e9q2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 12 Mar 2020 17:55:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 12 Mar 2020 17:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6MsGlje9iijPZI07bQC1wo0Vzt1l26Vaulz7ZH0IV7OSCZby5dXgdOOY0XPu9qY2ibz+zW8ZirNUbPhWjOxpC8/hoMx2L6vSkSYgiCZyBwJ6T8kFOydq3VyDSgtg7jd4F+1rWqvPZ2tKprM1RffEfKqCS7gtIBl2UbdgMoo78nTnUHuoeY3KGBBGZy5MKs1JKxBrAvRg6BZU+pXzb29neRaj9AHL7ngKx7/G4vntxuClPtDseYMn8TNk2Wotk8ZPLI/m6iv0t+8Qu8gUPXtdiHDmZBDkwxSu17yfq8BQZLe0eGQ9f5w2xxGFO+CuRNsPkER1cAPYUKBJt2STQUr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsRtuS8klfa5SD3pPfrMomknIQY0F1oVMbRs0q2bW/Q=;
 b=DLMy0eQYEx/7i02V/zqsDuZvbHeRYUaChjx1wBo3d8wOZqJfNHc2dSOsiudBu8yKnm/QfvmXHnzXnJb8CxI4FrMsbBYzFIilFmP+zoXv1AsNKtV9pGPYLVQQsLnpumIMogK5FRnjaZvMLw+rWqSb3frfQ5oOqCEHwewHuUpAL+M3pHZKaKXarhGox/K5FzXdPwGxvC8XVSoJLnlhdzUqq62htQI6z9qoUjpYLZcSsYDbM3/VdNhIURmnFyoteS1A4vwEjmPsLGPFBHJ8PcmRZ7A+wtLdoPOjZaX7HaNqkMFwAfUlv5txGaaNlbYyyyaVHFJa2ZoEwhfrqdfjRaaOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsRtuS8klfa5SD3pPfrMomknIQY0F1oVMbRs0q2bW/Q=;
 b=Sq6w7/lV2yHWDlgTZ2pNmHK6UakZaNzNYnhjZyNlXmXChL2RMvQ4xLh9Lk40nBNozM+deovj5LH6NwJwCLRuLJGvEZ2iUZMa/nGX+FBTvFRpcjr5HbFvYb/BmeLprd3f9t4Va/4M7pcOHihOH88TgZ+Ed1Z0ETeGof3Q5wLnGcA=
Received: from BLAPR15MB4035.namprd15.prod.outlook.com (2603:10b6:208:27b::8)
 by BLAPR15MB3796.namprd15.prod.outlook.com (2603:10b6:208:254::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 00:55:26 +0000
Received: from BLAPR15MB4035.namprd15.prod.outlook.com
 ([fe80::1005:cae:8f47:227c]) by BLAPR15MB4035.namprd15.prod.outlook.com
 ([fe80::1005:cae:8f47:227c%7]) with mapi id 15.20.2814.007; Fri, 13 Mar 2020
 00:55:26 +0000
From: Corey Wharton <coreyw7@fb.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH 0/2] Support different CPU types for the sifive_e machine
Date: Thu, 12 Mar 2020 17:55:06 -0700
Message-Id: <20200313005508.1906-1-coreyw7@fb.com>
X-Mailer: git-send-email 2.21.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO1PR15CA0109.namprd15.prod.outlook.com
 (2603:10b6:101:21::29) To BLAPR15MB4035.namprd15.prod.outlook.com
 (2603:10b6:208:27b::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from coreyw7-fedora-MJ09BKJM.thefacebook.com
 (2620:10d:c090:500::5:9b25) by CO1PR15CA0109.namprd15.prod.outlook.com
 (2603:10b6:101:21::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend
 Transport; Fri, 13 Mar 2020 00:55:25 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [2620:10d:c090:500::5:9b25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97591831-79c1-4d44-4567-08d7c6e937ab
X-MS-TrafficTypeDiagnostic: BLAPR15MB3796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR15MB3796EA21EA528BE8CD990BB493FA0@BLAPR15MB3796.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39860400002)(396003)(346002)(366004)(199004)(4326008)(316002)(54906003)(16526019)(186003)(478600001)(36756003)(52116002)(86362001)(2616005)(6512007)(5660300002)(6666004)(8936002)(1076003)(6506007)(2906002)(66476007)(66946007)(6486002)(81166006)(8676002)(81156014)(4744005)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BLAPR15MB3796;
 H:BLAPR15MB4035.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmgC4R0TcU/SPk+UlU20Oa7Fh5+XB+acRFYJcnaWW1Kw/7q2AlnNh9oAiidOS4SLb6PvHsJI3bnWiGE2LqknGy7k/ZUAB7ZO7Sr6Ohc1Jgj6y/mxzJc3Kv/J4p9TGietoBx0jIKCPPRxOZwk/KPpq0MIw5KKbSaoTgOXTw5zPI+MgbvDNTvibGof+qUlBMGHfaU1ORgSQKZpz776k0wcti8UWd+rGwSwYF2AoH2Sh+QjaL7Dy/XWzGZLvYrfxdaKQIaKLXzMJgoMLcsGiyxWH1snN3viXNsYqVSvGaAXQ/bE2XVxhWxss2y56vjtAfqmmVjhXs2hFPZMYGiMtTHTam07ISJ6vXXMDoy951nbFR6HCJlUcQnT/fEp2ZJqG2ilobUIKNu1dQL/2KBZEjWjYUVIqGAkyTngGJdIujQuAk6A1pgfpNS+AhORkI8FYM8E
X-MS-Exchange-AntiSpam-MessageData: gHyKz6i/fFgahzehsxPThSYMP5Yq9PtPQCKDDv95VFHuLphSI6WNV6A1QR5pnj2JN+Ofae9pkJtoUN7nsKKfPP3cpQGgWA0FovPh4tg2pAsJgnx/F8VdGLYOiyfPv1XjL5vpIlGJtJZLbv6AeGZrJ6r0xqeOcrYbmWqWWrhtXBrKtixPWkbJLwxCj+1Fk+Dq
X-MS-Exchange-CrossTenant-Network-Message-Id: 97591831-79c1-4d44-4567-08d7c6e937ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 00:55:26.3170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa862H6jXidIHM2quNA0qs9az03fZwrhSFioX1Vh+vm2oe1SJfZ/xwaJ3kCAAdY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3796
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_19:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1011
 adultscore=0 impostorscore=0 mlxlogscore=545 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130002
X-FB-Internal: deliver
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.153.30
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Corey Wharton <coreyw7@fb.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of this patch set is to allow the sifive_e machine to run
with different CPU targets to enable different ISA entensions. To that
end it also introduces a new sifive-e34 CPU type which provides the
same ISA as sifive-e31, with the addition of the single precision
floating-point extension (f). The default CPU for the sifive_e machine
is unchanged.

A user can change the default CPU type by specifying it with the '-cpu'
option on the command line.

Corey Wharton (2):
  riscv: sifive_e: Support changing CPU type
  target/riscv: Add a sifive-e34 cpu type

 hw/riscv/sifive_e.c |  3 ++-
 target/riscv/cpu.c  | 10 ++++++++++
 target/riscv/cpu.h  |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.21.1


