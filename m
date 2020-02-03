Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA41C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78A720838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RMGIC3cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78A720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iye4h-0005qR-3M
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iye3n-00050o-Ok
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iye3m-0003hJ-5r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:54:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:22034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iye3l-0003g2-W4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:54:50 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013Fl4Gu015391; Mon, 3 Feb 2020 07:54:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=7VtptBtQOXYW8iaGIk3Fz8IYr+CvyiBq70RtEPpIb7s=;
 b=RMGIC3cdTmVhgSiVqJRkkoPn2D8VwE+l+YhEIck1eu/iOv3j8V6cLA50ZVguZJ+uuHsV
 YaYa9sZ5znjZPEvD/T3KwHj50N0KEd+VE7pLWtS0bnp0YU3Af+mwYEhc5BRhSJETuqnI
 hByoXvqzVRyZkIRkuGLaU2+XxSZxsN8TsO5ktDYaDneDZci09iY32OVtZVbYH4WAyMQn
 0RBFUgKBtpDb7vmwLlYJmOma0cv7dtOJn2wxYQSpvY+F3EX4Xs5tMqRJuL+c/OCGj88U
 tERGi+c7YVH6WGP/0cmoHAc2s22g5WP+HWzFTItVFTC13k9hcdduZVKNuuQNkUl+SwPS Lw== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xw8ar3sy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2020 07:54:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZJBxrpEGcnQzmWSo8MMoPCdyS7y9XFutDH9LZOB7bZR6eRxPaAvXO/LbZuSE7WezUBLZ290h/6X1pjU+8DNN5k/eYbpg9nOcMzlJo53piCM4x1We1Kwh+x5IMPIlhwDTnJXMivVcdrfjC1qlwdFrvItdtXdA41ReqDNbYYuJ4uZzfQGMmhYNF3CxCfUg4LNTai6Gd4kufbjucJB/uj8lRpUrLtyhqhfbt9EBe2O4ecoSPIbpbrbvyxXDWh4qjn4RjOrmoAlVYuYzCsevxJa31/T9yGTLlhDVRG6XJLwO0DXAbaxtjhmoYRGcHLXXrKVvmByx8DC7+9GX2MCTwqCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VtptBtQOXYW8iaGIk3Fz8IYr+CvyiBq70RtEPpIb7s=;
 b=gJNvIube4/fSN0HQsuUgYMwNUOKVvAfdavyPGVy7ouWXYghylKIKsdruj+9EK5S7RdrXl1O/vmKObU4I95udT3jC9vJzJgr/mksF1vZrSso0MtdajDxhJDgsY9Og/4bxTw/Rm17oBFzlpf93AHTRYH1IeEe211sa8xDX4Hoc74IuWBtOmOM1b/FNLYx+XVWBKuJBeqbVrkwGCk6YmH8BQmjnCounxTEAw1DyXRP72WKBQZbdvsvVISfiLLkDnxeTO19fcCyHXRv9Gc8/5sju/neiOU/kd7dwBaR5yIgaJfBbKgLve0QBgGWz2gtss5gx5PkT1Cn4xrR0cJDeKj+jvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2512.namprd02.prod.outlook.com (10.168.204.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Mon, 3 Feb 2020 15:54:45 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 15:54:45 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 0/4] Improve default object property_add uint helpers
Date: Mon,  3 Feb 2020 15:54:08 +0000
Message-Id: <20200203155412.7706-1-felipe@nutanix.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:45::14)
MIME-Version: 1.0
Received: from nutanix.com (62.254.189.133) by
 BY5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:1e0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.30 via Frontend
 Transport; Mon, 3 Feb 2020 15:54:43 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67f59af1-5afe-42ca-c55c-08d7a8c163ec
X-MS-TrafficTypeDiagnostic: MWHPR02MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB2512F4A2E0A6DF75BFB06215D7000@MWHPR02MB2512.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(956004)(107886003)(52116002)(86362001)(26005)(966005)(4326008)(110136005)(186003)(8886007)(8676002)(7696005)(81156014)(81166006)(6666004)(478600001)(8936002)(316002)(16526019)(5660300002)(55016002)(2616005)(2906002)(36756003)(66946007)(1076003)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2512;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKTsJK79a/G9QGqg0nsZi2an6XnbwigeePUsA/VrV2hwFww7DJXt4sGwBe+Rp2Q+kX+CNpQ2X+jiHM8bQGteBGQ6BsiRtkqT8o/1Cc1A+j3dgxxEcb//Jfsp9k2NVRf14BuWf7PibnJA856qwrlyEQjWkAMLl7HBhH/YN4K2ydtdwwP2gHlGbT2fwlHlI2xU9dezLgz7/bRoufh1Vy3xRGvGAuXXqAsLdgReDDhMHkVM7IFakTsafztFC6HCHWW2P51RPdZJRTOlcxNAgNkwEo//btLRoATt3/wJ0ZUow554MgWuRSM0ynBaTG61SFL/QCN+RZQpAbVbkpGCEi6Y5ucT5IU0LMFfMFg7SlBzzFnt7CSfl+vgnXlckcvdzxuSj+Zf1lN2iSqdSDRTfgCiqsmx+yYktxmwdyMZ67NIIIbP6fxZLCX75IwnGXu7BEe4LDXaxaWQhkdMu2GC7JSt/y+zanlF1JVImkuW6I3HKnT2UVVElnGloI9ewgQixgsElDrxcdtwXMYWUjM5OAwcjA==
X-MS-Exchange-AntiSpam-MessageData: PAwnRYrhtQFeTvszo7dzSNjhWCVpl6bFk+g6f3W0HWg5veY707Ww8FL5854UFGqol8Ebxxvr0ZRhs8WfR/T1f3kkP/lBaTF/vKssre5qEljuABXsG1gmc5v/7UrlNTLrX047G0FExa4bvvIhYKD2yA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f59af1-5afe-42ca-c55c-08d7a8c163ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 15:54:45.8918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxLy/azAWKHin7nloNGezY9U3QysrHr6+AZ44v8lbwAJSv+XvlmwpatYODQixDLdFbGgjkqMfT7qXiH774vslRoPX6v3A3lZIzEocDPZMaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2512
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-03_05:2020-02-02,
 2020-02-03 signatures=0
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
 qom/object.c         | 214 ++++++++++++++++++++++++++++++++++++++-----
 target/arm/cpu.c     |  22 +----
 target/i386/sev.c    | 106 ++-------------------
 ui/console.c         |   4 +-
 14 files changed, 283 insertions(+), 319 deletions(-)

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

