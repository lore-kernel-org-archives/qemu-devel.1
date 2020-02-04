Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E15CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1162084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="t/OrHNB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1162084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyy67-0007x6-SF
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iyy45-0006RH-70
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iyy3z-000760-33
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:29 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:2614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iyy3y-00070I-PZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:16:23 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 014D9Bkj025561; Tue, 4 Feb 2020 05:16:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=YQz1EO5ZIRApCyygnppwwnOt/XNJf1QphQ/wWKkn5kc=;
 b=t/OrHNB9EP2rBb2fIfIEIynyScCKW2lDmbNImdqutAD8X/whUxPX6/tchZSz8mmmPIAm
 moIDGevS5uHqrZBIBtgQLPt6mk1pykn+FG8wQe/9XdtTyikYhQOCKRiaHzs25Q04hy+0
 KsFgI3w2bDeyuD7OEL8CNYRtjEi4jMz8RUG3X0IhAumUfpfLKydDtM3haBZPUBpXu1Lf
 jQ/4PRlJu7exmx9KZ2PfjeObR0NLMQHNdf3HShWY9BuGvPHr+cZhiP0h5TnbAzMmuzpr
 qf9letvctAdYOY7/gu7/bWPvBk34Ss228K5Z0wPzjLulE4I0tYl4RK05MNzhVmM1Fdew GA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xw9r761as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2020 05:16:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXDHDB1AvMdy+y/HhMlV267XGTu9zIx+vyCHGS5PNzwnBAEqYUDoEr8w0CfkJuX4ueRbWsA9IVA+lDaVekqv6uzMfZIbnMkH18tPT9BDlghOA9XXX9rnCRilNinh/oxDvjvEqocaVxRXPv0XZVMDDEG+uKMtmRgBqjhC1u2sJT85SpJNbWjE9xCsBOVWDIMoWVfvQ/alRM9veiERdHkByy2GSeBJ+3xzgX5hO604AoxLqWE4ucG4SLSd+nltAEMrlDM2ffBD3rtaPBEWqgVxRE06TohB93TvfREm1p405+u9RpcA5KIk60d46NnZQy92TAwHZpb2xjkGgZjPcJIvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQz1EO5ZIRApCyygnppwwnOt/XNJf1QphQ/wWKkn5kc=;
 b=RNy+cRlLWz8XK9APwI3GQRUhCn3x8MCFRBxLMwYMOQfC6TEoK2V10tWi78S7r/0INpuC7UHZF9EHke3hbBVGaRuNb3sKerto4lxQmX3V7eWnoEg3sZRqC/S4I+PqHOCjPOzsURLqClaa9WPRdzoOAMU6jR1+A5zCURE3AsAGyG3XNvdXo5TIh5bHh0JCYUO+U+x9NQjICiMqLtmkX904+zBto3dBNDFg5QJrfQIJ8jWoMsUQa8ID4XwOUs4gQR/gVTHf/gYd57Dm+MkKcz822zAK4UvwfVFIoZe9fNqzhLql83sD96kkDbE2UU6Znop+XkjV8wREbiNwfJrbB8dLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2640.namprd02.prod.outlook.com (10.168.207.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 13:16:19 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 13:16:19 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v6 1/4] qom/object: enable setter for uint types
Date: Tue,  4 Feb 2020 13:15:58 +0000
Message-Id: <20200204131601.125677-2-felipe@nutanix.com>
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
 Transport; Tue, 4 Feb 2020 13:16:17 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [62.254.189.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db4316b-9722-4f64-833f-08d7a9746c45
X-MS-TrafficTypeDiagnostic: MWHPR02MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR02MB264010C3408E0CE533091E5CD7030@MWHPR02MB2640.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:287;
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
X-Microsoft-Antispam-Message-Info: W1AB7sksUXTPNNTpV83PKNSSZ9oN6kpPlbwQ/ZoXWwisv+2ugVrp6uSFIfHPUdHDJxvXclp0e3WQEilPqj0cHRFzSCKpf1ZNkrQ4ChYJLSCg9h0wSAipE7bcBNXipKUvrZn722da0NNZvuNbGT0bNHE0F4Uxmp/JBCsBFQ4mVSPnp3HtMKuZn46zLUCAYO06eL4PIGHi1uWRrhTp+yLHcTZ2zrxQqci3DrHF+aajJVQjL/eeLBYnE5aPgqaErA16zzcRx7si7STis8LlAgaWsIsDAk7xaRcayhR31wgb6RHjEQFXO17imJrZaOHZDRd/lqohb5ubXUeag8aMU+PogOHRJScrQjRgRH1OBckKg+OSmA5cEENS10Fbu+5x1L1IeHrsZT0/SJ5KgfvhEvjj2PsRn1vaa3dKTMyQPiXIH+eVTCo/B4Xav3DKiiZotbSz
X-MS-Exchange-AntiSpam-MessageData: KWDHkRFcp1WzsTgdHY23IozbNv/6r6np1+cm0XDGWygDXz+g6dZSqRLoJ7kX3SyZ7jKTxVrZQZyGANW+OdTGg6k8NY0q9hjzU1nY4EvJ5VNrhQ0giWe8cL7yezTa4lxPHzOAmrMiYFOX3KPy4QBlkA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db4316b-9722-4f64-833f-08d7a9746c45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:16:19.7328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zs3/jr4Sd6HoUq1Yj5t+py9gATN30Cs/xDii6vIpdPtslBz+60T0JMFBm3tEB4cmzSwYTjY5QJYeePqUEzlLkIMTbASU5xDqVILIOshT9s=
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

Traditionally, the uint-specific property helpers only offer getters.
When adding object (or class) uint types, one must therefore use the
generic property helper if a setter is needed (and probably duplicate
some code writing their own getters/setters).

This enhances the uint-specific property helper APIs by adding a
bitwise-or'd 'flags' field and modifying all clients of that API to set
this paramater to OBJ_PROP_FLAG_READ. This maintains the current
behaviour whilst allowing others to also set OBJ_PROP_FLAG_WRITE (or use
the more convenient OBJ_PROP_FLAG_READWRITE) in the future (which will
automatically install a setter). Other flags may be added later.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 hw/acpi/ich9.c       |   4 +-
 hw/acpi/pcihp.c      |   7 +-
 hw/acpi/piix4.c      |  12 +--
 hw/isa/lpc_ich9.c    |   4 +-
 hw/ppc/spapr_drc.c   |   3 +-
 include/qom/object.h |  48 ++++++++--
 qom/object.c         | 212 ++++++++++++++++++++++++++++++++++++++-----
 ui/console.c         |   4 +-
 8 files changed, 246 insertions(+), 48 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2034dd749e..742fb78226 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -454,12 +454,12 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
     pm->s4_val = 2;
 
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, errp);
+                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ, errp);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, pm, NULL);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, errp);
+                                   &gpe0_len, OBJ_PROP_FLAG_READ, errp);
     object_property_add_bool(obj, "memory-hotplug-support",
                              ich9_pm_get_memory_hotplug_support,
                              ich9_pm_set_memory_hotplug_support,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 8413348a33..4dcef372bf 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -80,7 +80,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 
         *bus_bsel = (*bsel_alloc)++;
         object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                       bus_bsel, &error_abort);
+                                       bus_bsel, OBJ_PROP_FLAG_READ,
+                                       &error_abort);
     }
 
     return bsel_alloc;
@@ -373,9 +374,9 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
     memory_region_add_subregion(address_space_io, s->io_base, &s->io);
 
     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
-                                   &error_abort);
+                                   OBJ_PROP_FLAG_READ, &error_abort);
     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_len,
-                                   &error_abort);
+                                   OBJ_PROP_FLAG_READ, &error_abort);
 }
 
 const VMStateDescription vmstate_acpi_pcihp_pci_status = {
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6d621c31e7..c37749cb96 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -443,17 +443,17 @@ static void piix4_pm_add_propeties(PIIX4PMState *s)
     static const uint16_t sci_int = 9;
 
     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, NULL);
+                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, NULL);
+                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, NULL);
+                                  &gpe0_blk, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, NULL);
+                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, NULL);
+                                  &sci_int, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, NULL);
+                                  &s->io_base, OBJ_PROP_FLAG_READ, NULL);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index f85b484eac..0b6cf6f0dd 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -644,9 +644,9 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc)
                         ich9_lpc_get_sci_int,
                         NULL, NULL, NULL, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, NULL);
+                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, NULL);
+                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ, NULL);
 
     ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
 }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 17aeac3801..4d7f9fd765 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -553,7 +553,8 @@ static void spapr_dr_connector_instance_init(Object *obj)
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(obj);
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
+    object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ,
+                                   NULL);
     object_property_add(obj, "index", "uint32", prop_get_index,
                         NULL, NULL, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
diff --git a/include/qom/object.h b/include/qom/object.h
index 29546496c1..784c97c0e1 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1664,69 +1664,101 @@ ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
                                   void (*get)(Object *, struct tm *, Error **),
                                   Error **errp);
 
+typedef enum {
+    /* Automatically add a getter to the property */
+    OBJ_PROP_FLAG_READ = 1 << 0,
+    /* Automatically add a setter to the property */
+    OBJ_PROP_FLAG_WRITE = 1 << 1,
+    /* Automatically add a getter and a setter to the property */
+    OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
+} ObjectPropertyFlags;
+
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint8'.
  */
 void object_property_add_uint8_ptr(Object *obj, const char *name,
-                                   const uint8_t *v, Error **errp);
+                                   const uint8_t *v, ObjectPropertyFlags flags,
+                                   Error **errp);
+
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
-                                         const uint8_t *v, Error **errp);
+                                         const uint8_t *v,
+                                         ObjectPropertyFlags flags,
+                                         Error **errp);
 
 /**
  * object_property_add_uint16_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint16'.
  */
 void object_property_add_uint16_ptr(Object *obj, const char *name,
-                                    const uint16_t *v, Error **errp);
+                                    const uint16_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp);
+
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
-                                          const uint16_t *v, Error **errp);
+                                          const uint16_t *v,
+                                          ObjectPropertyFlags flags,
+                                          Error **errp);
 
 /**
  * object_property_add_uint32_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint32'.
  */
 void object_property_add_uint32_ptr(Object *obj, const char *name,
-                                    const uint32_t *v, Error **errp);
+                                    const uint32_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp);
+
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
-                                          const uint32_t *v, Error **errp);
+                                          const uint32_t *v,
+                                          ObjectPropertyFlags flags,
+                                          Error **errp);
 
 /**
  * object_property_add_uint64_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint64'.
  */
 void object_property_add_uint64_ptr(Object *obj, const char *name,
-                                    const uint64_t *v, Error **errp);
+                                    const uint64_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **Errp);
+
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
-                                          const uint64_t *v, Error **errp);
+                                          const uint64_t *v,
+                                          ObjectPropertyFlags flags,
+                                          Error **Errp);
 
 /**
  * object_property_add_alias:
diff --git a/qom/object.c b/qom/object.c
index 555c8b9d07..1812f79224 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2498,6 +2498,22 @@ static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
     visit_type_uint8(v, name, &value, errp);
 }
 
+static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    uint8_t *field = opaque;
+    uint8_t value;
+    Error *local_err = NULL;
+
+    visit_type_uint8(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    *field = value;
+}
+
 static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2505,6 +2521,22 @@ static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
     visit_type_uint16(v, name, &value, errp);
 }
 
+static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint16_t *field = opaque;
+    uint16_t value;
+    Error *local_err = NULL;
+
+    visit_type_uint16(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    *field = value;
+}
+
 static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2512,6 +2544,22 @@ static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
+static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint32_t *field = opaque;
+    uint32_t value;
+    Error *local_err = NULL;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    *field = value;
+}
+
 static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2519,68 +2567,184 @@ static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
+static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    uint64_t *field = opaque;
+    uint64_t value;
+    Error *local_err = NULL;
+
+    visit_type_uint64(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    *field = value;
+}
+
 void object_property_add_uint8_ptr(Object *obj, const char *name,
-                                   const uint8_t *v, Error **errp)
+                                   const uint8_t *v,
+                                   ObjectPropertyFlags flags,
+                                   Error **errp)
 {
-    object_property_add(obj, name, "uint8", property_get_uint8_ptr,
-                        NULL, NULL, (void *)v, errp);
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint8_ptr;
+    }
+
+    object_property_add(obj, name, "uint8",
+                        getter, setter, NULL, (void *)v, errp);
 }
 
 ObjectProperty *
 object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
-                                         const uint8_t *v, Error **errp)
+                                    const uint8_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp)
 {
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint8_ptr;
+    }
+
     return object_class_property_add(klass, name, "uint8",
-                                     property_get_uint8_ptr,
-                                     NULL, NULL, (void *)v, errp);
+                                     getter, setter, NULL, (void *)v, errp);
 }
 
 void object_property_add_uint16_ptr(Object *obj, const char *name,
-                                    const uint16_t *v, Error **errp)
+                                    const uint16_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp)
 {
-    object_property_add(obj, name, "uint16", property_get_uint16_ptr,
-                        NULL, NULL, (void *)v, errp);
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint16_ptr;
+    }
+
+    object_property_add(obj, name, "uint16",
+                        getter, setter, NULL, (void *)v, errp);
 }
 
 ObjectProperty *
 object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
-                                          const uint16_t *v, Error **errp)
+                                     const uint16_t *v,
+                                     ObjectPropertyFlags flags,
+                                     Error **errp)
 {
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint16_ptr;
+    }
+
     return object_class_property_add(klass, name, "uint16",
-                                     property_get_uint16_ptr,
-                                     NULL, NULL, (void *)v, errp);
+                                     getter, setter, NULL, (void *)v, errp);
 }
 
 void object_property_add_uint32_ptr(Object *obj, const char *name,
-                                    const uint32_t *v, Error **errp)
+                                    const uint32_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp)
 {
-    object_property_add(obj, name, "uint32", property_get_uint32_ptr,
-                        NULL, NULL, (void *)v, errp);
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint32_ptr;
+    }
+
+    object_property_add(obj, name, "uint32",
+                        getter, setter, NULL, (void *)v, errp);
 }
 
 ObjectProperty *
 object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
-                                          const uint32_t *v, Error **errp)
+                                     const uint32_t *v,
+                                     ObjectPropertyFlags flags,
+                                     Error **errp)
 {
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint32_ptr;
+    }
+
     return object_class_property_add(klass, name, "uint32",
-                                     property_get_uint32_ptr,
-                                     NULL, NULL, (void *)v, errp);
+                                     getter, setter, NULL, (void *)v, errp);
 }
 
 void object_property_add_uint64_ptr(Object *obj, const char *name,
-                                    const uint64_t *v, Error **errp)
+                                    const uint64_t *v,
+                                    ObjectPropertyFlags flags,
+                                    Error **errp)
 {
-    object_property_add(obj, name, "uint64", property_get_uint64_ptr,
-                        NULL, NULL, (void *)v, errp);
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint64_ptr;
+    }
+
+    object_property_add(obj, name, "uint64",
+                        getter, setter, NULL, (void *)v, errp);
 }
 
 ObjectProperty *
 object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
-                                          const uint64_t *v, Error **errp)
+                                     const uint64_t *v,
+                                     ObjectPropertyFlags flags,
+                                     Error **errp)
 {
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_uint64_ptr;
+    }
+
     return object_class_property_add(klass, name, "uint64",
-                                     property_get_uint64_ptr,
-                                     NULL, NULL, (void *)v, errp);
+                                     getter, setter, NULL, (void *)v, errp);
 }
 
 typedef struct {
diff --git a/ui/console.c b/ui/console.c
index 179901c35e..184e173687 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1299,8 +1299,8 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
                              &error_abort);
-    object_property_add_uint32_ptr(obj, "head",
-                                   &s->head, &error_abort);
+    object_property_add_uint32_ptr(obj, "head", &s->head,
+                                   OBJ_PROP_FLAG_READ, &error_abort);
 
     if (!active_console || ((active_console->console_type != GRAPHIC_CONSOLE) &&
         (console_type == GRAPHIC_CONSOLE))) {
-- 
2.20.1


