Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6147C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F82E2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="xSIuDOJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F82E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyy60-0007g6-MJ
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iyy3z-0006R7-82
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iyy3x-0006sc-3w
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:22 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:33460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iyy3w-0006lY-Pv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:21 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 014DBB38020094; Tue, 4 Feb 2020 05:16:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=roGuoDgiThIFo6xjznnDU4Me+vjZavn2QedRlWqaMrg=;
 b=xSIuDOJFQmyGt8KXpYjQ8vZgn+9tHbJRXM8UcWo4rp8JXIbogoZSB9/aDhqAx2yUhf65
 x8OLrlmBRNq+Fk3S5F7RXcdtECwYLwdaQ37HxJ9qdVyMcMFQXkNDBv1f/cZ9LMXCmg+n
 zPmIi/R0dMfHis3A27T68P+Ud1SqR1CCFjO+LYM1/06iV0INxng4QupL/Y8crJo+A5kf
 viRlPJHkI9N/FrcYhDLxg3jGlb6gbs9EWgYqmDQ3K2EkmBuS3vJ1mrzZ17Xawe26OCoz
 V3DRA7J6/vIPipdxbiRk7oupBo7mmFVVcbzhaSCLPAvLx3uoIOfmmQ4RFk8x8/gXD3Jj ZA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xw8ar65c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2020 05:16:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJX3N4oTftmLFGegzr3X96z0iltHh2qzpwGc3XcVSw++2DfRWKrwGJk9Z7H6kKC1cJzc4+hzRlCp3RKrmSH/o1pGVF0qI2N6MySDm9r2kW5iAXDeZ7McgY7ZMDgnX2eAaBcQb6bdwqbASukVBIfKzHtEmpEqrXYFM0VZJ23qjEd1wE/DTGVcBC2qc1uEGX2YasJJ+raGAJTe5s40PgL2ru/FwdUDlP5Ic34Qg5VAZqWzTJBt7w/lIkKRa8/FmYG6+tTOVhUbYNcSJ+4RCMX4onci/g/hPry0Vxm5jtwfm4fV30ayo/38xDz/RcGBRkvbx70sOQnWo0azJz4b8M/RQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roGuoDgiThIFo6xjznnDU4Me+vjZavn2QedRlWqaMrg=;
 b=Khfi1pXu2R3c71SFNo3aclUnB5mMCMOYXJ+++0EBARq11/1yHsGZl9pi5BaViB/LcSHsuaAj8XcJvktIoNHmrBb2Ui8otRdt6b5LQZRUb5vE6k1om1o//75FjoMJ/NenMyFY4/BX6n8dhNXTpHMniNsuXiYqUMkwsgHZTdluBfV94k+ocHg1sOCyT5CQvuztJTW1NvbSYiJSoPKycyync26ugQfgNlPQNrMO0XV70EhP4fgmMDjLqtxla9L3VwqvCK2Nwfi5Obda8PZBatx1RqbqV+JEJAOI4TzHWrO0jJ83gCKG4NTF5F4zBksWLsIfuMpqNGNfjAE3xndIYLu31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2640.namprd02.prod.outlook.com (10.168.207.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 13:16:17 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 13:16:17 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v6 0/4] Improve default object property_add uint helpers
Date: Tue,  4 Feb 2020 13:15:57 +0000
Message-Id: <20200204131601.125677-1-felipe@nutanix.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0108.eurprd02.prod.outlook.com
 (2603:10a6:208:154::49) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
MIME-Version: 1.0
Received: from nutanix.com (62.254.189.133) by
 AM0PR02CA0108.eurprd02.prod.outlook.com (2603:10a6:208:154::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend
 Transport; Tue, 4 Feb 2020 13:16:15 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba6d446-17a9-4f51-6050-08d7a9746ad1
X-MS-TrafficTypeDiagnostic: MWHPR02MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB264097D1B9F7D05CE4A71A15D7030@MWHPR02MB2640.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(316002)(8886007)(107886003)(55016002)(186003)(26005)(16526019)(36756003)(478600001)(966005)(2906002)(2616005)(956004)(4326008)(8676002)(6666004)(5660300002)(86362001)(7696005)(52116002)(81166006)(81156014)(1076003)(110136005)(66946007)(8936002)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2640;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyySe7hAXUQ04eMa3avEcWsP9pDXumVsmJW45D0Zk0unB93/eXqc6TFaXAQtk3xT8D8HtrHxW+dMPFQj3zRPvAhH2iugmLdgjbYP0GT2oHch6qlPgNdWLWTypmTzrpuW9iU/gjiZsrYgfpQcQyKzQCpF64Yue9DQiIcJ+Q16daukb62q7OsIJ7lW68eE3OzJ7fwaOdszz1pOIj2OrvQ7IBZC+kuRypi2BH1j4FY0tMRpmevQEzRO5l3D5ws94LkylS+Rk2hskl9BLJlG8dcR80RSkyPv7K059Wr7BRCi10B2uFGpdbDTusYz3XdNy9CS7TRj4EQvWs6UPCCgn8CqVer4xhH1HFOxFkX5RfqOKqLJu8lQhubajT6iKL13sP1G6xzeoYczTil9V0JX3jJKgt6mvGQsdzMYZdpzfLhriPcPgndWyarxSvGdQccWqPs2Hdj7o5DrEzZPD7LXbWfxSF1Wg5HK3K8W3EUHZFrt3NgtnHhcvYocXQza79HWWTmHJG2HavnXKckUp8SG3p5/DQ==
X-MS-Exchange-AntiSpam-MessageData: kUihM7Mu2w70HScT2yptn0z8ZkuZ62XhMrDe7wNkc+aKhF8NIV/hgg12Is633gX7WeuaQMdNcFLjhVd0XMB5AgvLEynif8wFqO9odTttJJ54ans+H/GySkf2x8Numy2KjhEbP0/MAFn36je12/HJ6A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba6d446-17a9-4f51-6050-08d7a9746ad1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:16:17.2490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1KEVIDW+52r1QhvjfwXp9B/Ou/9n72o/AWrfM6Ei5oeE57M8PBRvXTAT5iEP1MzHmSBenf+yyNFCsXF7N4g9TgivGfy1/jIsUdFEulSOaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-04_04:2020-02-04,
 2020-02-04 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.155.12
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
Cc: qemu-devel@nongnu.org, Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This improves the family of object_property_add_uintXX_ptr helpers by enabling
a default getter/setter only when desired. To prevent an API behavioural change
(from clients that already used these helpers and did not want a setter), we
add a OBJ_PROP_FLAG_READ flag that allow clients to only have a getter. Patch 1
enhances the API and modify current users.

While modifying the clients of the API, a couple of improvement opportunities
were observed in ich9. These were added in separate patches (2 and 3).

Patch 4 cleans up a lot of existing code by moving various objects to the
enhanced API. Previously, those objects had their own getters/setters that only
updated the values without further checks. Some of them actually lacked a check
for setting overflows, which could have resulted in undesired values being set.
The new default setters include a check for that, not updating the values in
case of errors (and propagating them). If they did not provide an error
pointer, then that behaviour was maintained.

Felipe Franciosi (4):
  qom/object: enable setter for uint types
  ich9: fix getter type for sci_int property
  ich9: Simplify ich9_lpc_initfn
  qom/object: Use common get/set uint helpers

 hw/acpi/ich9.c       |  99 ++------------------
 hw/acpi/pcihp.c      |   7 +-
 hw/acpi/piix4.c      |  12 +--
 hw/isa/lpc_ich9.c    |  27 ++----
 hw/misc/edu.c        |  13 +--
 hw/pci-host/q35.c    |  14 +--
 hw/ppc/spapr.c       |  18 +---
 hw/ppc/spapr_drc.c   |   3 +-
 include/qom/object.h |  48 ++++++++--
 memory.c             |  15 +--
 qom/object.c         | 212 ++++++++++++++++++++++++++++++++++++++-----
 target/arm/cpu.c     |  22 +----
 target/i386/sev.c    | 106 ++--------------------
 ui/console.c         |   4 +-
 14 files changed, 282 insertions(+), 318 deletions(-)

-- 
2.20.1

Changelog:
v1->v2:
- Update sci_int directly instead of using stack variable
- Defining an enhanced ObjectPropertyFlags instead of just 'readonly'
- Erroring out directly (instead of using gotos) on default setters
- Retaining lack of errp passing when it wasn't there
v2->v3:
- Rename flags _RD to _READ and _WR to _WRITE
- Add a convenience _READWRITE flag
- Drop the usage of UL in the bit flag definitions
v3->v4:
- Drop changes to hw/vfio/pci-quirks.c
v4->v5:
- Rebase on latest master
- Available here: https://github.com/franciozzy/qemu/tree/autosetters
v5->v6:
- Fix build error introduced in rebase

