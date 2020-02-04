Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB5C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7A82084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TDdhSU4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7A82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyy8B-0002KH-2G
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iyy46-0006SC-He
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iyy45-0007Na-86
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:30 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:12080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iyy44-0007KP-TS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:29 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 014DA6uT017086; Tue, 4 Feb 2020 05:16:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=tcdToV3FRpNht+neXGIq7Qpc35FgUQ12sEkluI+Vm2U=;
 b=TDdhSU4nlL3h4zuZuFWnY2SfdhO8gPoTWwz5UtGNf0amdN1C3+lUZoQvI9z3VgyBlzpl
 5zsRvjzUmceuGu6EW56u+wVn0pATHtT38iSozwDa6Xon6eRi6YONjhaHF4BtXuMXck1i
 pFQ/sRDFN4JygwTSR/ol5GK87T5TgcekO4t+FdOHHZRz4x9O6gIxIt/bGLAfIbcel3vq
 3GCR1gu1bB1wtwdLiAh7MVzvWmgJXalCZyjmkb6hYtEBgMKlZsraKNr4t6vuMuM5xLZf
 Bvrc/V7/0gXEgrF0/ktIkf5U2LWtqf+O6uBLAsYxNTqvf8wJ2v9rhtW3FlUt8nq628c4 lg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xw99px74p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2020 05:16:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0U4jKvXcFXFKtjcrcQKdXHl0qyKNWpPp5KmwrFmvY1NKJkZQNrnf9dJBp/vg2U/ybKATnhCsLfO9c7pPg35phj9AlYZ869AAEKRPZBXiqP7R4dfDyw1FQDivdOOMRxCQWmDDatMbBm9wqrYsOZz3MnpIo6Nh3FW4FgMWrDTBcbAvahbkgWSPzCqe2FSJ3mUqD/D/daD/Xsl6XgV7rtZ8n2GEUJOszCicydADQJFkLvBya6RQGMG9zRWye2IptsRdck32/1Q5NpgDTT+nihz6AJeGufdLJKcgQoY7HIl1gt/G6UF4+JaSfxlPEqGuaA65/bE1UX00RQs3fIiwmdG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcdToV3FRpNht+neXGIq7Qpc35FgUQ12sEkluI+Vm2U=;
 b=B+lXgoTt2ZZaDVHtu/yCV/dgZ5IyWERDItdq8CK9bFls3s5b2yCheHhKt36pTZFV/7GWZoLsHRDzcsjCgmfeU3xkaNzN//2OARTKvnGoBY0WcyRbr/nRBfx+achmNp6yhsQx9s42qck0UX55iK7TFOIZmoVYGZvgI+tOWcUIDvNw3BAh8Unke501Un7QRUs3s0nMKYStrBr/axr5xt5U6Finftx4jW629X/P0pA6eVYZDXqEX3kjt9Winn94gOi8F2B+GLg6+xCJOE8hmNIp6I8+aQnPv/TDxQ5YI6HdQkkSDF3bTFN2w/Yk1OT43u6dJZZ9A7zNv13rkE+m69IxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2640.namprd02.prod.outlook.com (10.168.207.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 13:16:24 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 13:16:24 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v6 3/4] ich9: Simplify ich9_lpc_initfn
Date: Tue,  4 Feb 2020 13:16:00 +0000
Message-Id: <20200204131601.125677-4-felipe@nutanix.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204131601.125677-1-felipe@nutanix.com>
References: <20200204131601.125677-1-felipe@nutanix.com>
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
 Transport; Tue, 4 Feb 2020 13:16:22 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39fdea67-feea-4d02-63be-08d7a9746ef1
X-MS-TrafficTypeDiagnostic: MWHPR02MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB2640D7EA8024E2A0DF63D55ED7030@MWHPR02MB2640.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(316002)(8886007)(107886003)(55016002)(186003)(26005)(16526019)(36756003)(478600001)(2906002)(2616005)(956004)(4326008)(8676002)(6666004)(5660300002)(86362001)(7696005)(52116002)(81166006)(81156014)(1076003)(110136005)(66946007)(8936002)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2640;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5nd/2u68tX9WXsWF4qmI8x8P7B+kJfeWwhYPxLr1hC8JaGWiIZ8tGbahTPLSppECQS1kT1jDHpeqJE6MrAt/6xntAPCnUXdOqHFb4K6GOTmNaQICJ5h0VhVHJ2mEDXY0MffXIYUWbwZv77XaCLobrjjkH9iSAsEmiYwRyqU5bF+zlBDZXS2IpC+Hf6ZHwa4u7QrZs5eUOQ7+IMfMyzRx737Va7H2Omos7f30hJ1ARqGqOu9NC8uoORTtjtR7KYpArbin6mx4PqZPscQALwC2Tt03FuNFpj6AWZdbKbeqXBnOxfr4MKxaiSqMxejtjmufV8fDqsDDWUEfeNVKMRXAFFfvqkD2Y1wiLSEUNBf/SwX9vuYFZNng22BvKZs1UpOz9Wjgqq2eag6Wj03Lvzc9nPaHMeYvrBJh1I5ZbabC+cA9OqafxrGZWe+o3OS5q6Y
X-MS-Exchange-AntiSpam-MessageData: u6WsUrtuKiTzkr2AZMcamn44sd4SVJzcBotHGuw79QpkRWb9vnCtNGj8SyGHbojgh763qrjfpfWzjPKR1xMT5cYALKd2NTFmTNBK6nvTq2NdYLmvQV1UyVhlut+PP34lYh8YDzFobp5R1PfTZbVGJA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fdea67-feea-4d02-63be-08d7a9746ef1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:16:24.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q67SI3NDMuzrVKHbOlJadjprA4ayXTQYSeKF2sDjWQqEjJVGZD2IxJHZahsPsiwoyoHUrx1JYFhsD1cPBbel0I5MNG9VZJTaPj0KcbBCHvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-04_04:2020-02-04,
 2020-02-04 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
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

Currently, ich9_lpc_initfn simply serves as a caller to
ich9_lpc_add_properties. This simplifies the code a bit by eliminating
ich9_lpc_add_properties altogether and executing its logic in the parent
object initialiser function.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 hw/isa/lpc_ich9.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 71de9cf1ad..12d99057f4 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -633,12 +633,14 @@ static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *name,
     visit_type_uint8(v, name, &lpc->sci_gsi, errp);
 }
 
-static void ich9_lpc_add_properties(ICH9LPCState *lpc)
+static void ich9_lpc_initfn(Object *obj)
 {
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
+
     static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
 
-    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint8",
+    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
                         ich9_lpc_get_sci_int,
                         NULL, NULL, NULL, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
@@ -646,14 +648,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc)
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                   &acpi_disable_cmd, OBJ_PROP_FLAG_READ, NULL);
 
-    ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
-}
-
-static void ich9_lpc_initfn(Object *obj)
-{
-    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
-
-    ich9_lpc_add_properties(lpc);
+    ich9_pm_add_properties(obj, &lpc->pm, NULL);
 }
 
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
-- 
2.20.1


