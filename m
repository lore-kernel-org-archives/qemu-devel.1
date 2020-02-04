Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD4AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64BF2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="DWzlpG3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64BF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyy62-0007lx-Qk
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iyy45-0006RI-7Q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iyy40-0007DC-5v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:28 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:64108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iyy3z-0007Ak-Uf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:24 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 014D9B1W025555; Tue, 4 Feb 2020 05:16:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=/hbbfHJQNlJoycWifIkAtwB1rjoN6gwRKvvuQhDIrfQ=;
 b=DWzlpG3/RqFM0L01MvlYVYmp88oKOf2EbPiiQ4yQWzwipRMuBdvnm22RX/9bhMshbUSf
 GdH6SBqfUHosth7EhD6w7yxtXHWQEX+0Mol3hfgUjTcP6HkAurSc/+n7OZx9ChkGJ2Pl
 Puz3GFQk9bhL9cFYfesyzepZa6ssY98XlE4V2250OvUIJiTneY5ePC0Tv1Nr3v+eNLno
 A7zlyR8+vv2SZTNMwnE0x6KO3TnIIJsHkJ+hAFFqiTo/F/pBSB04M33xjQ2ttYmhP4NS
 PPOPnbAJPKERPNKGlnfawzND48I8/JC5+svbVyMtoRSz8rVHBc03ozTFTwM/Jq2vIDjY HA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xw9r761au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2020 05:16:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnFgxaIyP/Z+YH5uIUPP3aSEXi1KzQDwcC92j6clCPH+60BenbWyLuE+u2oZYfm75kChmbIEz2ydnwhF/4uwvNtc4Wn4iEYMUAxQRD0S5gcNFUKWb20cZs3nhiem3AYwt56+QUTML9HXVXFy3MAo7F6rPx/2gSV8GwCBVtTVWNfBWXphgxakzMVLHCc17alzmRVbeyO/kL9cJTblh2SxkS7gAcda4KtCRAVCeN6l1RpppmtnUoZfVwfQVFuVMEKo2ZYIrXERba6QBnS+B0m4z6hSe9fQqjBopXSFUUSgd9K/TYUihKbODTlgdiJT2PsbDLHJVa0t62W1ihsQskH3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hbbfHJQNlJoycWifIkAtwB1rjoN6gwRKvvuQhDIrfQ=;
 b=Ou5IUC80IMSdDvScC3IQnVxDSW0NWkzMPtjoS8SoRUMlDvc3fMJEIFCvrqlwdktkK/5YSwUdZRCnBld9SRtft31mi50M3mDpBsdC+IVTyLUZt19CQ/HCHDfwL/ron5TjlldbZg7QfGvsE3ez+YikXY+1PscMkbV3ggfjOQnyU46XMBgRCNg416FyvYPFLqkQp7pXJnHUKyTxwziy9/1gl0S+6CjHQlEBj38peVnXJIbkJGtITByw+cEHF7r3d2lo/nXuRwf0/tN6sMCyw1mEiA5fJUHtpqxdfRkHaMNuxvU4zVrZ6KEijivTuyAGr1Y1IcWXnFbVNyORqd/or6hTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2640.namprd02.prod.outlook.com (10.168.207.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 13:16:21 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 13:16:21 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v6 2/4] ich9: fix getter type for sci_int property
Date: Tue,  4 Feb 2020 13:15:59 +0000
Message-Id: <20200204131601.125677-3-felipe@nutanix.com>
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
 Transport; Tue, 4 Feb 2020 13:16:20 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6973981-9f6d-4132-ec35-08d7a9746dab
X-MS-TrafficTypeDiagnostic: MWHPR02MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB264004FC027259304EF0FE9ED7030@MWHPR02MB2640.namprd02.prod.outlook.com>
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
X-Microsoft-Antispam-Message-Info: DSBb3L9AVMBeQpq3L3UJ502BKDQabkzg2ALrVEGrWQIaDZkCFzRVtW+YtAl16R3wlHE1LFG7feBe6x+0NJ1Ekw9Z38bGhqhUUZVu0S8WG6UTYkZSdBchOfgIAWXkGDTLXfSa2tYvFoh0+ZO8IDa5ez7V8O3HOlPtucKA653Uw90uhPTXSHbDgmFEFANZLcLUEB7e1+mEg8uB0f4JR+2pp9EMBxSFuGMj4BdjXiZEf+FhQcavMvNTGXD+VNzrfEySotfovPLzSkGIfcz0uVFu6O+mobWE5jc55f+DwSxb9hIxAk1t56XbrOtQZcczlKtzyTd4sIWF4xI2fFzbL5oVLQMcZyuKTjMbDyeuNyNKkubhI11XofJelVBZi1TaSTewziD37gtWEUUS7uja+Ctxe4fNahATGpEvCcA/WiofjfCi5i08BO6rWUTW5n/QoQt5
X-MS-Exchange-AntiSpam-MessageData: pH9M92DcpXm8ForQfzU+4fxTjXr92AZXJSYWxAF76mRG0ed3ppkcpxJZLZWzubA78KDkm2qE3VimgZmzkBDNbnWE6WDsbna3KntC9Q+p0bUi2cXLIpK9V35WH7oOt2utBT2VoPF8gbkZyfW22CHVug==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6973981-9f6d-4132-ec35-08d7a9746dab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:16:21.8838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTDhq3NQHZjS6ee+cPilhL6oUgRlHF5TgGtCat8o1rgE4CHNfibAzYbQSEZn93gTepeyap/hfvwdbyqo5T3DjinGwTLGLYvy7LMJnqh0lDo=
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


