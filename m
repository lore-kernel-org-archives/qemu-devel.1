Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8E9C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B33B206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jVv2URNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B33B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4qM-0004dN-5I
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jC4oQ-0000uD-PE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jC4oO-0004Ke-Ao
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jC4oN-0004Eu-0r
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BH3QhM041427;
 Wed, 11 Mar 2020 17:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=Vz/pl1Zkp+4knPizK0hQXYh6+R014IfZOCbOYxO3V4s=;
 b=jVv2URNhRnp/A4oN6iZVVAvu9gV7em2OiIOXFyym0mYJvA/CWe80N9CduhogKj+Lgbjq
 tF/8jRshJHZ+zzOH8bgDF/Y1JTZKWhGOn8cq7fofyNAdyD9LnxDImWtRB3RP7jvfE3cF
 BSnW9C6q+3OwPHXMYfbFIxdf/9bban0asFYsz89CztgJz+mF1z0CZ5tgvodrKxOMIXC5
 ehmL0/Tg4yMuX8G8IUm7D0glqPMfzAuoAP5l6ksoWkisGHhueISZyBmmqVkgijKH86FT
 OgC6SY353+4dAkfPon8eSVExpe+BqWoiu2BYqrkmp/2kTfj8uzkDbCCKux3sEpVhRvd4 Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yp7hm9bva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 17:06:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BH2EKj079170;
 Wed, 11 Mar 2020 17:06:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yp8q0wqkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 17:06:21 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02BH6K2k000421;
 Wed, 11 Mar 2020 17:06:20 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 11 Mar 2020 10:06:19 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Date: Wed, 11 Mar 2020 19:08:26 +0200
Message-Id: <20200311170826.79419-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=1 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110101
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: ehabkost@redhat.com, mst@redhat.com, Liran Alon <liran.alon@oracle.com>,
 imammedo@redhat.com, Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elad Gabay <elad.gabay@oracle.com>

Microsoft introduced this ACPI table to avoid Windows guests performing
various workarounds for device erratas. As the virtual device emulated
by VMM may not have the errata.

Currently, WAET allows hypervisor to inform guest about two
specific behaviors: One for RTC and the other for ACPI PM Timer.

Support for WAET have been introduced since Windows Vista. This ACPI
table is also exposed by other hypervisors, such as VMware, by default.

This patch adds WAET ACPI Table to QEMU. It also makes sure to introduce
the new ACPI table only for new machine-types.

Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
Co-developed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/acpi-build.c        | 18 ++++++++++++++++++
 hw/i386/pc_piix.c           |  2 ++
 hw/i386/pc_q35.c            |  2 ++
 include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
 include/hw/i386/pc.h        |  1 +
 5 files changed, 48 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c4e46fa7466..29f70741cd96 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
     build_header(linker, table_data, (void *)(table_data->data + dmar_start),
                  "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
 }
+
+static void
+build_waet(GArray *table_data, BIOSLinker *linker)
+{
+    AcpiTableWaet *waet;
+
+    waet = acpi_data_push(table_data, sizeof(*waet));
+    waet->emulated_device_flags = cpu_to_le32(ACPI_WAET_PM_TIMER_GOOD);
+
+    build_header(linker, table_data,
+                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL);
+}
+
 /*
  *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
  *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
@@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                           machine->nvdimms_state, machine->ram_slots);
     }
 
+    if (!pcmc->do_not_add_waet_acpi) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_waet(tables_blob, tables->linker);
+    }
+
     /* Add tables supplied by user (if any) */
     for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
         unsigned len = acpi_table_len(u);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9088db8fb601..2d11a8b50a9c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
 
 static void pc_i440fx_4_2_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_5_0_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
+    pcmc->do_not_add_waet_acpi = true;
     compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 84cf925cf43a..1e0a726b27a7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
 
 static void pc_q35_4_2_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_5_0_machine_options(m);
     m->alias = NULL;
+    pcmc->do_not_add_waet_acpi = true;
     compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 57a3f58b0c9a..803c904471d5 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -634,4 +634,29 @@ struct AcpiIortRC {
 } QEMU_PACKED;
 typedef struct AcpiIortRC AcpiIortRC;
 
+/*
+ * Windows ACPI Emulated Devices Table.
+ * Specification:
+ * http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx
+ */
+
+/*
+ * Indicates whether the RTC has been enhanced not to require acknowledgment
+ * after it asserts an interrupt. With this bit set, an interrupt handler can
+ * bypass reading the RTC register C to unlatch the pending interrupt.
+ */
+#define ACPI_WAET_RTC_GOOD      (1 << 0)
+/*
+ * Indicates whether the ACPI PM timer has been enhanced not to require
+ * multiple reads. With this bit set, only one read of the ACPI PM timer is
+ * necessary to obtain a reliable value.
+ */
+#define ACPI_WAET_PM_TIMER_GOOD (1 << 1)
+
+struct AcpiTableWaet {
+    ACPI_TABLE_HEADER_DEF
+    uint32_t emulated_device_flags;
+} QEMU_PACKED;
+typedef struct AcpiTableWaet AcpiTableWaet;
+
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 60c988c4a5aa..f1f64e8f45c8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -100,6 +100,7 @@ typedef struct PCMachineClass {
     int legacy_acpi_table_size;
     unsigned acpi_data_size;
     bool do_not_add_smb_acpi;
+    bool do_not_add_waet_acpi;
 
     /* SMBIOS compat: */
     bool smbios_defaults;
-- 
2.20.1


