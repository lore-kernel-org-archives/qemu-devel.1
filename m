Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59DEC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9076120CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="FjHajFXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9076120CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iye8G-00023q-QQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iye41-0005H4-NV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iye3z-0003uH-BF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:05 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:17738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iye3z-0003tp-60
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:03 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013Fi4Pj024173; Mon, 3 Feb 2020 07:55:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=XmUgPpPOyI1Y2vd7GFCsr0Iqpy8hnjI3m3nQACu0oj0=;
 b=FjHajFXN7G4nweFrM+ihp/PowT0dWEqovByojYdrsuxluZvDhJTUjQGrJjZvQ1RFCy/o
 MnD+XZUikMtpxTdrVgJzh0570gdmOc5S44vVwykhMmmZsuAhvbnoVLBlXEINVWoMs0As
 PP54RLrxf9BBvUGuMQ/L305P8tqfkbSQb8yZyqEcgYAnM/p/+BzEQU6b8hOmbYmS2GUT
 R0GITsnUCgFFOIl/dgDZmf7mtH0yYG5qWHXbnkyh4ziCpW6o/XcgoROtWN4b77F8zDM5
 VOq9Q8iyoJj3M9oS8/tUIlX9JgvfSE7aJkqwwhhtEZN2Xq7JaPS9U38FyXLEpGQzC381 0g== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xx3ejswru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2020 07:55:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlRwHDnSo8p/LG5UIyNf82I86C0JXXopvlI12lNIqCZddrjjaiGxYiSonuV1a4/C05euMSzU3cIDL/L7YZCsKPsjl7o3rXBr0hegzZENLJnbzSmqhJDtAWsj1+4/WgchajdMzWz99Pgl3hCuPwtKG0FxscHGbccbgQsMjS5UoEOsRD4QWsqas7EGFZquhNft9c7qaPDB9BNoM58UuZvc03GZzU1f/7VpXdC86d/0KKKlhcoLEbpJMeQJdEGJ5SxEvvz8ellpBOtCE/AgXUAS+lihL3RoSNHrGuJpzzzEntNrlsoum18erBWVDcxeLnrmh2bRJL+Nt3dwUoYMLhLiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmUgPpPOyI1Y2vd7GFCsr0Iqpy8hnjI3m3nQACu0oj0=;
 b=TIzzi9yhoGBEei1kVodQ6ykzbR9MAAIfl54pPoSNAxDtxVF/J6q7SeDYDFiAPU+jVLN0Qzqs8uAoHVn7lEW2G4YoXebzdfPYvqjG+tAMeLXv00FLRwq26FSwilxRTa8mtXTgCUJXdkzb2uqbBPZZV2qw3h+lNz2SNIHpmQI7qfDs7AJajxVO+4pz6t4vRYXBrpeDqFzVJwEpw3T0EyCu6AZn6mJkLTYAQZBz+sJKYKYj8EU5YM3UFiXSoy7OKb+GzByX+o+L4uGhq/mIRyWrk0K0P4oKDOvwnf5XFX0YSob1Wtn1/ZY64wqOWJGasyOV6tFgO29otqWbGj1vYdI1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2512.namprd02.prod.outlook.com (10.168.204.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Mon, 3 Feb 2020 15:54:59 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 15:54:59 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 4/4] qom/object: Use common get/set uint helpers
Date: Mon,  3 Feb 2020 15:54:12 +0000
Message-Id: <20200203155412.7706-5-felipe@nutanix.com>
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
 Transport; Mon, 3 Feb 2020 15:54:56 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59cc82a2-0946-4d55-b9aa-08d7a8c16b4a
X-MS-TrafficTypeDiagnostic: MWHPR02MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB25124C64A86F2CDFCFF96733D7000@MWHPR02MB2512.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(956004)(107886003)(52116002)(86362001)(26005)(4326008)(110136005)(186003)(8886007)(8676002)(7696005)(81156014)(81166006)(6666004)(478600001)(8936002)(316002)(16526019)(5660300002)(30864003)(55016002)(2616005)(2906002)(36756003)(66946007)(1076003)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2512;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gAc7p4Wkv18rid5Jdcls3JBlpUr+4BsNP9qZlMtiHuLIGkKP016y2/e3CEhMP6p0wY7mDmba0xIRB+PvGDN19bDSv60nf77tfJsnhQC1vq6unVpvcbjoj3ySbjYVwBb6eNeUePxhl282xeU/n13k/y3l+GeRyeKuHq5uIxL1ze3xzmIgRGmw1W+CcFJFuJ69SwVJUINkzLKQkKFg+L7EfSjzDPhpXKQMcRbppI9LjDCYZYyQQHhgqRRTStStxlIDEf+LoirDlVTIFT4i2JRrRrZxncrKKvwvAjisR4k063clBf2Xn6ebbBFJ0/ftuGjpwMeR0mKROPOZljeeQgeh4vAGYpyQdvKrcDGSq500zck40p1ywgWouY0+Y6wHCUA1y/ranTwNgChjAhJ6T0n040y0YSFP7KJH//nPq3uei62HkiMBOk/yUZHXJUZoPLr
X-MS-Exchange-AntiSpam-MessageData: DkIcikwX+TFrM3rJP9j96hY/oHtnpq33uVMf6ceiRsFkGFf70kSkePVJMgrTXuUIypbVIux7N8+Brx4ZmGJTCsyuCNmjQMFv+2jA1vspT091K6L75YGMH4A3Qrol0Q8lz8/q7F8PiE9+biDw0Cpu2Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cc82a2-0946-4d55-b9aa-08d7a8c16b4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 15:54:59.3900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxdqorZdGO81gpVNWirLICej/3i7e3ngyf8EGvH0uuWc0O1oZzBJpqsdzh65A0qxOWACWwPW+b1ri5e2PIe7cASuz2+SDg53AEO8R4vKBZM=
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


