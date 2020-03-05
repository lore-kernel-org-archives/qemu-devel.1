Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608D1C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390C52073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390C52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wLp-0000eE-Dm
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKj-0007Ot-Ri
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKi-0005Gb-LU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1j9wKi-0005EX-Dc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:00 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025JK12U114223; Thu, 5 Mar 2020 14:38:58 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yk4jp6qn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:58 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 025JK7LO114918;
 Thu, 5 Mar 2020 14:38:58 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yk4jp6qm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:58 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 025JZESI032465;
 Thu, 5 Mar 2020 19:38:57 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01dal.us.ibm.com with ESMTP id 2yffk817dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 19:38:57 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 025JcuMt54198694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 19:38:56 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72B37124052;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5ACDD124055;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/10] tpm: rename TPM_TIS into TPM_TIS_ISA
Date: Thu,  5 Mar 2020 14:38:46 -0500
Message-Id: <20200305193855.278878-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
References: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_06:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=1 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050114
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 025JK12U114223
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 148.163.156.1
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, peter.maydell@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

As we plan to introduce a sysbus TPM_TIS, let's rename
TPM_TIS into TPM_TIS_ISA.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-id: 20200305165149.618-2-eric.auger@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/i386/acpi-build.c | 6 +++---
 hw/tpm/tpm_tis.c     | 4 ++--
 include/sysemu/tpm.h | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c4e46fa74..26777f8828 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2026,7 +2026,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
=20
-    if (TPM_IS_TIS(tpm_find())) {
+    if (TPM_IS_TIS_ISA(tpm_find())) {
         aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
                    TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
     }
@@ -2197,7 +2197,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             /* Scan all PCI buses. Generate tables to support hotplug. *=
/
             build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
);
=20
-            if (TPM_IS_TIS(tpm)) {
+            if (TPM_IS_TIS_ISA(tpm)) {
                 if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
                     dev =3D aml_device("TPM");
                     aml_append(dev, aml_name_decl("_HID",
@@ -2304,7 +2304,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, =
GArray *tcpalog)
         (char *)&tpm2_ptr->log_area_start_address - table_data->data;
=20
     tpm2_ptr->platform_class =3D cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
-    if (TPM_IS_TIS(tpm_find())) {
+    if (TPM_IS_TIS_ISA(tpm_find())) {
         tpm2_ptr->control_area_address =3D cpu_to_le64(0);
         tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
     } else if (TPM_IS_CRB(tpm_find())) {
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 31facb896d..c609737272 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -91,7 +91,7 @@ typedef struct TPMState {
     TPMPPI ppi;
 } TPMState;
=20
-#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
+#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS_ISA)
=20
 #define DEBUG_TIS 0
=20
@@ -1008,7 +1008,7 @@ static void tpm_tis_class_init(ObjectClass *klass, =
void *data)
 }
=20
 static const TypeInfo tpm_tis_info =3D {
-    .name =3D TYPE_TPM_TIS,
+    .name =3D TYPE_TPM_TIS_ISA,
     .parent =3D TYPE_ISA_DEVICE,
     .instance_size =3D sizeof(TPMState),
     .instance_init =3D tpm_tis_initfn,
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 15979a3647..1691b92c28 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -43,12 +43,12 @@ typedef struct TPMIfClass {
     enum TPMVersion (*get_version)(TPMIf *obj);
 } TPMIfClass;
=20
-#define TYPE_TPM_TIS                "tpm-tis"
+#define TYPE_TPM_TIS_ISA            "tpm-tis"
 #define TYPE_TPM_CRB                "tpm-crb"
 #define TYPE_TPM_SPAPR              "tpm-spapr"
=20
-#define TPM_IS_TIS(chr)                             \
-    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
+#define TPM_IS_TIS_ISA(chr)                         \
+    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
 #define TPM_IS_CRB(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
 #define TPM_IS_SPAPR(chr)                           \
--=20
2.24.1


