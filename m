Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A07C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61A021582
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="dsjcJaQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61A021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iye69-0007p4-0c
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iye3v-00056D-Fy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iye3u-0003pF-GE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:54:59 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:23188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iye3u-0003oX-8Q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:54:58 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013FhBos015879; Mon, 3 Feb 2020 07:54:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=/hbbfHJQNlJoycWifIkAtwB1rjoN6gwRKvvuQhDIrfQ=;
 b=dsjcJaQ9aQMkYb+NslBdUq+bYvEjW0sckbd3/5eEPKtC8TUq2KPRgLyNHLiucXkx62pm
 HJG1KJrf1T5/9+hPOw8m5b5pw9KWqPoNF85zYW+Lx5Ow0ViiFiJDc5YGc7c1ef+jHFwz
 +0GvJAbcEbPuqV6feVO8S1qFovPPg3TTpt1hGeGmtxqKfjKWZqFDbbzLNenBUa7LZeYw
 KFYsH1h2ocQImdqGKZ3vddJf3L66bPqDCXQbLP+tBD2cdRAQ1mAiSfgWMFtmiZ0Nzofr
 VKTc+BWyRzE70fEsDLm6SnWOddzceiYBzsT6z8yXH00FAH7SrM539cvtkpsc87Tr8JRI bQ== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xw9s4usnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2020 07:54:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPNMMd5i6ha2Xk/JUnkHo+o9M6PNoO5+BAo/oBAPKBkYARgZDn+GEF9WJ3+0EIOqcV0YRcGV5zHBKUv8tXLwByK281s//tuQZNiSMaFniTGfkjqDBacK9t49qNHXlpknCTPq/6AkY0H+R2VGm4voGd6Vh5yTex9u1kCzGjaGdtms0PPoQV1CgKcBn4fcCsSYTvROiqjAcr3PLxoqtM4xbipMkAI4pgQ29ylSAGJxBI/5ku898804Ms0aeJpK+Jcy1PC/+/d8G8eVbItFWQxSqtjNjGb+TLI2QW7g3PzlLmvEJv7gc/BVUsXd5jjudQJp64wViS2WA567mB8oIDCSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hbbfHJQNlJoycWifIkAtwB1rjoN6gwRKvvuQhDIrfQ=;
 b=RyLs68rMisMSK05thZaHjykrssJVreHK3tjs3qNsLYRBUmU4/sxR8G/zbYaTeInyJ4QrbbgP5Z8ny5X/gdX9I2KzCSlCTlIECDx45XgL4eskraBbU9NBsGsg88n7a8oH4wo5+8pp78e8dZkJdzo3QZe9keFVqFpwx0CyOWcgP3kYwL4etW63KCxMALDpgTreCiu6xlWulwwZTiV/LwiCESjgn8KW+yVZwgrcYU/70UkfXQb+vRidgu6LzEv/ZhNSadQ49ihSzBugk0Hc10Py6ZlO2vqkroiirUyddTa1P73KReh5dUv2XUvyYaNYcvCByoykKZm2uVPYoInTQ05pyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2512.namprd02.prod.outlook.com (10.168.204.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Mon, 3 Feb 2020 15:54:53 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 15:54:53 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 2/4] ich9: fix getter type for sci_int property
Date: Mon,  3 Feb 2020 15:54:10 +0000
Message-Id: <20200203155412.7706-3-felipe@nutanix.com>
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
 Transport; Mon, 3 Feb 2020 15:54:50 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adddeb56-35df-4826-8f39-08d7a8c167f7
X-MS-TrafficTypeDiagnostic: MWHPR02MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB25120E8A7AF383240EF9CB25D7000@MWHPR02MB2512.namprd02.prod.outlook.com>
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
X-Microsoft-Antispam-Message-Info: 9+f22oRPfm5uSGP5NcfpNpuHrVWkG01f6p9tK3mebmAFvb/MoEZsXCz2pZbHlLobqyWC0UzCQvFA3kyy5Rn/iL00Dy6QTSwMrzURn/aBlWIbnsUzf9RIosff8Wn9DKp2FILo1sjsou4wHICK76TO30LmdY9ALVbuedDue8atsJMrqTaeyAPtV7aQeiJe8A5ZVWyleWhy8WgeHc8sjOL4tVIxH2UYq/Pn/n4yZsvI4bgrwUlXlLi8X2asklElOiTZ7AA9VroDO+DePLRxX61+nAF6kd9vtJxTUYmHjhT/W9PxGDyoyrvB4pMSKmPWXRpnBgB349fQ1hURlyQ143y1z1+yqdJcMRG2zmR4vrd18ovfhBxEFLAm5du0kBYoE/lO1CXf4hW4kc0UM4RBUBRGlpJquJ7P5ZigMBJF3bnSd81MyowOsC/JmEXmxvxx9KBD
X-MS-Exchange-AntiSpam-MessageData: 6gMOGzl3ylk116cfqxSSz8fSCusM9hzLGc8cDtGLO/5zi+DmNjm1P+07j6MHVwn4+tH9/VemkwCyeynhabGVKByg9HPjpDLfBgWQSZSlDXCSQDelsXV7/nWmTxl2pEAzn+yFbHVl7UjTveRl/lkNsQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adddeb56-35df-4826-8f39-08d7a8c167f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 15:54:52.6894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZIP5jGhCLn1BIjgGkSfWxsrnH+6s4Ln3KIed9DK9Q8Pn4z43TlFgYN3wqxaCak+fHDsxDobmzaz0SLXYMF+mdftaqrQih03u2eIa9mjBic=
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

When QOM APIs were added to ich9 in 6f1426ab, the getter for sci_int was
written using uint32_t. However, the object property is uint8_t. This
fixes the getter for correctness.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 hw/isa/lpc_ich9.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 0b6cf6f0dd..71de9cf1ad 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -630,9 +630,7 @@ static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
-    uint32_t value = lpc->sci_gsi;
-
-    visit_type_uint32(v, name, &value, errp);
+    visit_type_uint8(v, name, &lpc->sci_gsi, errp);
 }
 
 static void ich9_lpc_add_properties(ICH9LPCState *lpc)
@@ -640,7 +638,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc)
     static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
 
-    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint32",
+    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint8",
                         ich9_lpc_get_sci_int,
                         NULL, NULL, NULL, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-- 
2.20.1


