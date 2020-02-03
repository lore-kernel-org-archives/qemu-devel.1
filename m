Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89AAC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43752087E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="N06n0yoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43752087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iye77-0000un-T4
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iye3w-00057D-BH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iye3v-0003q5-8q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:00 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:23266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iye3v-0003p9-1S
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:54:59 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013FhBot015879; Mon, 3 Feb 2020 07:54:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=tcdToV3FRpNht+neXGIq7Qpc35FgUQ12sEkluI+Vm2U=;
 b=N06n0yoEgRX4rMIrr/dB5LSVFspKehK4XbOaVjRwWlp3WPNUJig8GGNNYgqEYH0sldMn
 IpKulH8/3rdV37Wgp3mdllV+B2rwCnroUodVISI56+5CrO4DuwxxXSJLPSB2lwytL0w7
 3rJR+KdosZ3ZDh2F+gFgOSTQX3qpFQ+qANTSmdEIHW3e5jcp7dRwlfwrmUiNP9QZfJbS
 7tbY0VQUr8Dz2RtT6p7kqrdjneAfJZOgKL+TwLrXVvXtoF8EKJZIFemClxmbu1FLUOJg
 r+suuYVw1Zcq4YjJQxyBoH2TiIQvgBjrhVl1zF3+mUTLkuNegpFCoa79APzThoFx9hCr NQ== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xw9s4usnv-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2020 07:54:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwbp7PJwK8iGI5y8pgZ6bnkrmh7HQUvEM7bI4Gf80T+Yw79JZbVNEeTlBGzJ/krlknvVQonGP4hN87togntlS1KNzohIVGITQIrW5F+kVsRg/xCiYWaW4cKjusWNl0YIQkiFV+DB8aKxTv4ZSDQmhn73DxxGXpFp4cyjPbgEKEPSm///80HJtKG1uXtQuT2DTiVUptpWabaGBU+5ZOhWNLCDLirh5XlIHmHxWOiGBsovIRx2i8mbtQI5q2CUvJ4jvvqQcwCSveBtCLz/L0VUEs+J7kCt9TJNCC6ju2NToO+67rVPbjzrYkwCTOw4D/96OIwzxD8Jo78DytiLB2vWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcdToV3FRpNht+neXGIq7Qpc35FgUQ12sEkluI+Vm2U=;
 b=ZodboEpjW1efHIDIr3psjbnaM3+9vGZnzq2SgAaZERiTFxRBP85EtrwqFQrpCCtal/OU4qxu4x2kGELnno1W0vLLOlMoDOP7FdDd4lZWx5xe/ZFKbElcyBjON8AU6X6mm+7kGKvbSYzgb6cGaNT4/ZB7GfnoCSzfXKfHgm4zDmG6QMkxzT/Zf3hgAqDxiIYRBKoxfj0qyJAoPlpMOzxDIvxCY6fdiHTBwtp3l8ShpGetOiWFQhQ7pDthaddw3H2S9Fh33V+0HQuA1K/e369Azap1HOqUYKLkWcPskQ5aJiTFrTbpk7+BhEMg/snZouf7QKRNjdFyeDdY99bJnxbEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2512.namprd02.prod.outlook.com (10.168.204.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Mon, 3 Feb 2020 15:54:56 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 15:54:55 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 3/4] ich9: Simplify ich9_lpc_initfn
Date: Mon,  3 Feb 2020 15:54:11 +0000
Message-Id: <20200203155412.7706-4-felipe@nutanix.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203155412.7706-1-felipe@nutanix.com>
References: <20200203155412.7706-1-felipe@nutanix.com>
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
 Transport; Mon, 3 Feb 2020 15:54:53 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8880717-5271-44ab-ebf2-08d7a8c169cb
X-MS-TrafficTypeDiagnostic: MWHPR02MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB2512F8B6AC2153214418A2DBD7000@MWHPR02MB2512.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(956004)(107886003)(52116002)(86362001)(26005)(4326008)(110136005)(186003)(8886007)(8676002)(7696005)(81156014)(81166006)(6666004)(478600001)(8936002)(316002)(16526019)(5660300002)(55016002)(2616005)(2906002)(36756003)(66946007)(1076003)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2512;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ciDZGe12j02va0J8NtqYtsjnWCdai0QA7hfAra6rtO8hP2w9ewAug0xwBaavu4l9rItj+34I1Hfe7w4W+US6tmuCcDH59Ec08zo3//l5GWUpdlApl/SfWXF4g2Sdnl87EiQAehHZ6rt0+Mp0mtVhOQAN3tZE91uSrKy5NjeRqMy55VIXwmtbf3LfQZXQnmF/6JokDfV+jxeGjPptnkuii18QPXljYEe2ExcKgXb5WpNmfl7NAMXwH3vOMoAefE8LqlK1Ud+eGlMsyVUz/I893tQPedUYdD9KIhYTTq+G2oBBk/em9W0+kSHrKbjPMaCpoaHcXrypszOxHK6s4HthJQvaSIpnC1+JoL8V3lNzaT2D2to/VA8+RgfIbPqvrc/MPQovxbSXdh7HUbY3iggF3LXu69lanbJxvtZ9A0+H1T9YIyelaDnUBrukkeeLlHi
X-MS-Exchange-AntiSpam-MessageData: oPMJ4oyayAGDebKUQ6svl8NdekUprmOLywZkkwfuCClFqSDuIKa+zRxnO2vi99qlId/8nwzqJ9lK9hmEfEBIOiWOtCEy2ROlSXj3R6ZNnF9f2tFSgaJNNXrkXZOL1wBRL3VSspBzxL9dEAsawFZRXw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8880717-5271-44ab-ebf2-08d7a8c169cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 15:54:55.7638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM2fkijUgXy8ypI1B+MH5QDn7uRqTKFuUjlWNyW3hZqLQZ4Ad5JoAgrlN9SLbJ7dj8zBUZU/mK4zmNGTh5PS67rwj06/7JoHCH024uP7WxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2512
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-03_05:2020-02-02,
 2020-02-03 signatures=0
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


