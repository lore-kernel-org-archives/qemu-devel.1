Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C91C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B742082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hZv/FT4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B742082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyAx-0005jx-1g
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iyy49-0006Vm-2M
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iyy46-0007ST-OA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:52950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iyy46-0007Lw-CJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:30 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 014D7CPp020979; Tue, 4 Feb 2020 05:16:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=XmUgPpPOyI1Y2vd7GFCsr0Iqpy8hnjI3m3nQACu0oj0=;
 b=hZv/FT4BUp+5JXfhwUt+LvAGKs8o7kw8mU2UcghJzij0K03QbWd5bpR8rhhwgZOVTCvn
 Yf1MKtjuifCvlzoW2NYcFF6yOuRdcXOk3vPD97FG5BVsYTYP+6Fn3CzcnveHtire1B41
 L80Vvww/4aZI+JwUqOiRBVSTkP5de94NaKee8A5EcBv2aVZV0JbuzsT42ZTJry90+TQq
 +RvtZjp3IZpZqZVLHkmRRDiyJ11+/AwFYlqqUv650hUU8fQAmHRq1cx9GKHOAyGNJ0td
 ecfDy0qdU1RUKE//F9FnwFxruJvJB6CVLpNvsIqvyW0H/JKhU6r6hvtIKN7xNGlrO+3i 0w== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xw9s4x4mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2020 05:16:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpj3CV1JedN91uPH3o2gWuVef4GHsRh8c6BgLQGe1em1yyax0MUu7zTyyax3rOqC5VBWM6/MDn7Htk3RpGOlcG57oKrwQCF+Bc6xRhEfXe8dXy2H1zkFjtOFWrzskZdgR3yPY8wd9ntgjT9AcpSWKoVm7PMQ1IrycUUrP5dG1ydm9AGPsvj+WtVkPgPo+F2Xc3xysIUSh7y/geaZ3GWSd+iabrHw6hn3lznt5ag8FRgle4PbCO7y12P6Xb3O0PeO87RWX2FyTWATzBkcaQlbl+jESQAbYdH/LgMU/IlIGiQdIMhwlhIPZw50uUyTQP1syqHwXnz00fH8uK+SQ54YeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmUgPpPOyI1Y2vd7GFCsr0Iqpy8hnjI3m3nQACu0oj0=;
 b=daV0djb71QQ21w0T5aIGKiKnata6mOgqpXsxG2D9yLYd0v/sfFfg5Kun8RSJ9jci9bMSEti61B4MXi4H9BqvgPWtPDQpfY8YE4/AYYompJc/L1a+ldbjUmt+uZd56n25V5HXvKu0luUrDAjAUxMb/1OqvHcAeZikadis0zyzi/5Qb4TmZMdFdHgZ95RtOwp8PvMCTERzH+cIjHvCCNbI4jyI5ln3mFeMJ9UtLncbCfUo983WOLbk6VZWHdSS1Nd2FpR87a5j6kNj/NXgr6ImrFt3qidhrvV6+csFE9x3FvBbCH8NB2eYVHniu3Gr4352ZEjAvt+MxQSEZX3gpKFbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2640.namprd02.prod.outlook.com (10.168.207.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 13:16:26 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 13:16:26 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v6 4/4] qom/object: Use common get/set uint helpers
Date: Tue,  4 Feb 2020 13:16:01 +0000
Message-Id: <20200204131601.125677-5-felipe@nutanix.com>
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
 Transport; Tue, 4 Feb 2020 13:16:24 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e196fc-83e0-47e2-8c5f-08d7a9747048
X-MS-TrafficTypeDiagnostic: MWHPR02MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB26407F863B582E0369055924D7030@MWHPR02MB2640.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(316002)(8886007)(107886003)(55016002)(186003)(26005)(16526019)(36756003)(478600001)(2906002)(2616005)(956004)(4326008)(8676002)(6666004)(5660300002)(86362001)(7696005)(52116002)(81166006)(81156014)(1076003)(110136005)(66946007)(8936002)(30864003)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2640;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMqFveQmnYc1cQLIyngnQZGZ/WPL8vjnfcsroe/4ZwmxhbSoNFJny107Q/DR6ukYF6rQQJz5dPfg+AQRSJqQoPA1upkNsk4VuhE2pO2rJgRJjjltps1pVhHLmqU9PJU1jyrfu35Q1oNfttPRSDRPx6fJtQ0jzfJp+8l/EBsUySGvuvB66t6WGW732+HbM4qc8+r+Fnfgb85YrRP6ApbXvViV3ZsJevd1IXmzpdT8Fr3iELB/cb5bKSOiPEdOy/GIB+r1j7FgmwfmlLr3XRYw4hbmnKam66uYaQ+Foh2ihYYpgUkkCbnQz59VF5kyLTCu0O52cxNClNOAVN1gHwz/hSOYfashQrU1oDKy7orb3Cj1pv6fRhNWE36tOFiNu1mENnZ95h5ZF+b0n+LcEv/lsnTUt0os3sonbF7JhxM/xwLAssDEODdsj/JTXYtte6xi
X-MS-Exchange-AntiSpam-MessageData: pcch3DzN+thG9Anj1weTxeSgXKlcPqYBS2IGeHKRJ/HYIN07L/zFOtNILI+3A22KfPO+iLTdfDHklhw23er4LF0WvD0InLSsRpZ4Bt5DV+Y3acJ2BlCSNPuV8yfZSG51Tu+3Yuu7jUhxGipznf4ehA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e196fc-83e0-47e2-8c5f-08d7a9747048
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:16:26.3356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89yugohLx4kozMjWtfdBwDetEWMV1ZYPchs9aE6+vYtml0m2EHlZBv0JOTiuWsMcDwakURPu6GjH0dhYucWFjX8AUajNnxkq+QdJ7gSXi1w=
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

Several objects implemented their own uint property getters and setters,
despite them being straightforward (without any checks/validations on
the values themselves) and identical across objects. This makes use of
an enhanced API for object_property_add_uintXX_ptr() which offers
default setters.

Some of these setters used to update the value even if the type visit
failed (eg. because the value being set overflowed over the given type).
The new setter introduces a check for these errors, not updating the
value if an error occurred. The error is propagated.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 hw/acpi/ich9.c    |  95 ++++-------------------------------------
 hw/isa/lpc_ich9.c |  12 +-----
 hw/misc/edu.c     |  13 ++----
 hw/pci-host/q35.c |  14 ++----
 hw/ppc/spapr.c    |  18 ++------
 memory.c          |  15 +------
 target/arm/cpu.c  |  22 ++--------
 target/i386/sev.c | 106 ++++------------------------------------------
 8 files changed, 34 insertions(+), 261 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 742fb78226..d9305be891 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -357,81 +357,6 @@ static void ich9_pm_set_cpu_hotplug_legacy(Object *obj, bool value,
     s->pm.cpu_hotplug_legacy = value;
 }
 
-static void ich9_pm_get_disable_s3(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm = opaque;
-    uint8_t value = pm->disable_s3;
-
-    visit_type_uint8(v, name, &value, errp);
-}
-
-static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm = opaque;
-    Error *local_err = NULL;
-    uint8_t value;
-
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    pm->disable_s3 = value;
-out:
-    error_propagate(errp, local_err);
-}
-
-static void ich9_pm_get_disable_s4(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm = opaque;
-    uint8_t value = pm->disable_s4;
-
-    visit_type_uint8(v, name, &value, errp);
-}
-
-static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm = opaque;
-    Error *local_err = NULL;
-    uint8_t value;
-
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    pm->disable_s4 = value;
-out:
-    error_propagate(errp, local_err);
-}
-
-static void ich9_pm_get_s4_val(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm = opaque;
-    uint8_t value = pm->s4_val;
-
-    visit_type_uint8(v, name, &value, errp);
-}
-
-static void ich9_pm_set_s4_val(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ICH9LPCPMRegs *pm = opaque;
-    Error *local_err = NULL;
-    uint8_t value;
-
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    pm->s4_val = value;
-out:
-    error_propagate(errp, local_err);
-}
-
 static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
@@ -468,18 +393,14 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
                              ich9_pm_get_cpu_hotplug_legacy,
                              ich9_pm_set_cpu_hotplug_legacy,
                              NULL);
-    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
-                        ich9_pm_get_disable_s3,
-                        ich9_pm_set_disable_s3,
-                        NULL, pm, NULL);
-    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
-                        ich9_pm_get_disable_s4,
-                        ich9_pm_set_disable_s4,
-                        NULL, pm, NULL);
-    object_property_add(obj, ACPI_PM_PROP_S4_VAL, "uint8",
-                        ich9_pm_get_s4_val,
-                        ich9_pm_set_s4_val,
-                        NULL, pm, NULL);
+    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
+                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE,
+                                  NULL);
+    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
+                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE,
+                                  NULL);
+    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
+                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE, NULL);
     object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
                              ich9_pm_get_enable_tco,
                              ich9_pm_set_enable_tco,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 12d99057f4..0ff0936790 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -626,13 +626,6 @@ static const MemoryRegionOps ich9_rst_cnt_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN
 };
 
-static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
-{
-    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
-    visit_type_uint8(v, name, &lpc->sci_gsi, errp);
-}
-
 static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
@@ -640,9 +633,8 @@ static void ich9_lpc_initfn(Object *obj)
     static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
 
-    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
-                        ich9_lpc_get_sci_int,
-                        NULL, NULL, NULL, NULL);
+    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
+                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
                                   &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index d5e2bdbb57..ff10f5b794 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -396,21 +396,14 @@ static void pci_edu_uninit(PCIDevice *pdev)
     msi_uninit(pdev);
 }
 
-static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    uint64_t *val = opaque;
-
-    visit_type_uint64(v, name, val, errp);
-}
-
 static void edu_instance_init(Object *obj)
 {
     EduState *edu = EDU(obj);
 
     edu->dma_mask = (1UL << 28) - 1;
-    object_property_add(obj, "dma_mask", "uint64", edu_obj_uint64,
-                    edu_obj_uint64, NULL, &edu->dma_mask, NULL);
+    object_property_add_uint64_ptr(obj, "dma_mask",
+                                   &edu->dma_mask, OBJ_PROP_FLAG_READWRITE,
+                                   NULL);
 }
 
 static void edu_class_init(ObjectClass *class, void *data)
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a9b9ccc876..32c0d2fcd7 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -165,14 +165,6 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
     visit_type_uint64(v, name, &value, errp);
 }
 
-static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    PCIExpressHost *e = PCIE_HOST_BRIDGE(obj);
-
-    visit_type_uint64(v, name, &e->size, errp);
-}
-
 /*
  * NOTE: setting defaults for the mch.* fields in this table
  * doesn't work, because mch is a separate QOM object that is
@@ -213,6 +205,7 @@ static void q35_host_initfn(Object *obj)
 {
     Q35PCIHost *s = Q35_HOST_DEVICE(obj);
     PCIHostState *phb = PCI_HOST_BRIDGE(obj);
+    PCIExpressHost *pehb = PCIE_HOST_BRIDGE(obj);
 
     memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
                           "pci-conf-idx", 4);
@@ -242,9 +235,8 @@ static void q35_host_initfn(Object *obj)
                         q35_host_get_pci_hole64_end,
                         NULL, NULL, NULL, NULL);
 
-    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
-                        q35_host_get_mmcfg_size,
-                        NULL, NULL, NULL, NULL);
+    object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
+                                   &pehb->size, OBJ_PROP_FLAG_READ, NULL);
 
     object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.ram_memory,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c9b2e0a5e0..2eb29f218d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3203,18 +3203,6 @@ static void spapr_set_resize_hpt(Object *obj, const char *value, Error **errp)
     }
 }
 
-static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
-}
-
-static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
-}
-
 static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
@@ -3312,8 +3300,10 @@ static void spapr_instance_init(Object *obj)
     object_property_set_description(obj, "resize-hpt",
                                     "Resizing of the Hash Page Table (enabled, disabled, required)",
                                     NULL);
-    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
-                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abort);
+    object_property_add_uint32_ptr(obj, "vsmt",
+                                   &spapr->vsmt, OBJ_PROP_FLAG_READWRITE,
+                                   &error_abort);
+
     object_property_set_description(obj, "vsmt",
                                     "Virtual SMT: KVM behaves as if this were"
                                     " the host's SMT mode", &error_abort);
diff --git a/memory.c b/memory.c
index aeaa8dcc9e..172098e09c 100644
--- a/memory.c
+++ b/memory.c
@@ -1158,15 +1158,6 @@ void memory_region_init(MemoryRegion *mr,
     memory_region_do_init(mr, owner, name, size);
 }
 
-static void memory_region_get_addr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    MemoryRegion *mr = MEMORY_REGION(obj);
-    uint64_t value = mr->addr;
-
-    visit_type_uint64(v, name, &value, errp);
-}
-
 static void memory_region_get_container(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
@@ -1230,10 +1221,8 @@ static void memory_region_initfn(Object *obj)
                              NULL, NULL, &error_abort);
     op->resolve = memory_region_resolve_container;
 
-    object_property_add(OBJECT(mr), "addr", "uint64",
-                        memory_region_get_addr,
-                        NULL, /* memory_region_set_addr */
-                        NULL, NULL, &error_abort);
+    object_property_add_uint64_ptr(OBJECT(mr), "addr",
+                                   &mr->addr, OBJ_PROP_FLAG_READ, &error_abort);
     object_property_add(OBJECT(mr), "priority", "uint32",
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f86e71a260..f012bff49c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1043,22 +1043,6 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     cpu->has_pmu = value;
 }
 
-static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    visit_type_uint32(v, name, &cpu->init_svtor, errp);
-}
-
-static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    visit_type_uint32(v, name, &cpu->init_svtor, errp);
-}
-
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
 {
     /*
@@ -1183,9 +1167,9 @@ void arm_cpu_post_init(Object *obj)
          * a simple DEFINE_PROP_UINT32 for this because we want to permit
          * the property to be set after realize.
          */
-        object_property_add(obj, "init-svtor", "uint32",
-                            arm_get_init_svtor, arm_set_init_svtor,
-                            NULL, NULL, &error_abort);
+        object_property_add_uint32_ptr(obj, "init-svtor",
+                                       &cpu->init_svtor,
+                                       OBJ_PROP_FLAG_READWRITE, &error_abort);
     }
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 024bb24e51..846018a12d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -266,94 +266,6 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
             "guest owners session parameters (encoded with base64)", NULL);
 }
 
-static void
-qsev_guest_set_handle(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
-    uint32_t value;
-
-    visit_type_uint32(v, name, &value, errp);
-    sev->handle = value;
-}
-
-static void
-qsev_guest_set_policy(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
-    uint32_t value;
-
-    visit_type_uint32(v, name, &value, errp);
-    sev->policy = value;
-}
-
-static void
-qsev_guest_set_cbitpos(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
-    uint32_t value;
-
-    visit_type_uint32(v, name, &value, errp);
-    sev->cbitpos = value;
-}
-
-static void
-qsev_guest_set_reduced_phys_bits(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
-    uint32_t value;
-
-    visit_type_uint32(v, name, &value, errp);
-    sev->reduced_phys_bits = value;
-}
-
-static void
-qsev_guest_get_policy(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    uint32_t value;
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
-
-    value = sev->policy;
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void
-qsev_guest_get_handle(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    uint32_t value;
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
-
-    value = sev->handle;
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void
-qsev_guest_get_cbitpos(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
-{
-    uint32_t value;
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
-
-    value = sev->cbitpos;
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void
-qsev_guest_get_reduced_phys_bits(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint32_t value;
-    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
-
-    value = sev->reduced_phys_bits;
-    visit_type_uint32(v, name, &value, errp);
-}
-
 static void
 qsev_guest_init(Object *obj)
 {
@@ -361,15 +273,15 @@ qsev_guest_init(Object *obj)
 
     sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
     sev->policy = DEFAULT_GUEST_POLICY;
-    object_property_add(obj, "policy", "uint32", qsev_guest_get_policy,
-                        qsev_guest_set_policy, NULL, NULL, NULL);
-    object_property_add(obj, "handle", "uint32", qsev_guest_get_handle,
-                        qsev_guest_set_handle, NULL, NULL, NULL);
-    object_property_add(obj, "cbitpos", "uint32", qsev_guest_get_cbitpos,
-                        qsev_guest_set_cbitpos, NULL, NULL, NULL);
-    object_property_add(obj, "reduced-phys-bits", "uint32",
-                        qsev_guest_get_reduced_phys_bits,
-                        qsev_guest_set_reduced_phys_bits, NULL, NULL, NULL);
+    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
+                                   OBJ_PROP_FLAG_READWRITE, NULL);
+    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
+                                   OBJ_PROP_FLAG_READWRITE, NULL);
+    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
+                                   OBJ_PROP_FLAG_READWRITE, NULL);
+    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
+                                   &sev->reduced_phys_bits,
+                                   OBJ_PROP_FLAG_READWRITE, NULL);
 }
 
 /* sev guest info */
-- 
2.20.1


