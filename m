Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D874EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A281E20409
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J49EpfUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A281E20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClcz-0005Nn-SU
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jClcB-000412-3c
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jClc9-0005aR-SF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jClc9-0005Zo-Jm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEmZ34058010;
 Fri, 13 Mar 2020 14:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=7C5rKjlmQj9WYl0aFj4pSQSMZrj5tm6c2o+IErDbLYg=;
 b=J49EpfUuDHt5mUc2wtIVczW9fCrg76j2Ta1/5npr2/HUijk9qsZsz4uJFhsALoeAa4LV
 pdY6uJE/Vgb82DCq4e4RERKvs1AdAZLoU8ZdR03Abdn2ETMQtqpX7Y8SWB0kjw4vWnbn
 /H9GRaN9WkjT5h+Uibk2C9YEZpUstLwwWRJZQhnriHQqIygOIsGwVqiA7aTIIaqzulK9
 3ydw3bDpda1/oQOMKkIPv3p/1dMPfVYOe4yIfd4DeoZ2/56OOlquytCEUeFK7aepVURY
 3ouAW257V/00Z9p49+I8liBhJF/n/Wn05dPWQfubsOYX/hvJaLq+gXqQZgSMP9TGP1qq 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2yqtagc8y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:48:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DElRt2129341;
 Fri, 13 Mar 2020 14:48:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yqtaw2xvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:48:38 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02DEmbDZ020192;
 Fri, 13 Mar 2020 14:48:37 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 07:48:36 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] acpi: Add Windows ACPI Emulated Device Table (WAET)
Date: Fri, 13 Mar 2020 16:50:08 +0200
Message-Id: <20200313145009.144820-3-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313145009.144820-1-liran.alon@oracle.com>
References: <20200313145009.144820-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 suspectscore=1 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 suspectscore=1 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
 pbonzini@redhat.com, Elad Gabay <elad.gabay@oracle.com>, imammedo@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Microsoft introduced this ACPI table to avoid Windows guests performing
various workarounds for device erratas. As the virtual device emulated
by VMM may not have the errata.

Currently, WAET allows hypervisor to inform guest about two
specific behaviors: One for RTC and the other for ACPI PM timer.

Support for WAET have been introduced since Windows Vista. This ACPI
table is also exposed by other common hypervisors by default, including:
VMware, GCP and AWS.

This patch adds WAET ACPI Table to QEMU.

We set "ACPI PM timer good" bit in "Emualted Device Flags" field to
indicate that the ACPI PM timer has been enhanced to not require
multiple reads to obtain a reliable value.
This results in improving the performance of Windows guests that use
ACPI PM timer by avoiding unnecessary VMExits caused by these multiple
reads.

Co-developed-by: Elad Gabay <elad.gabay@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/acpi-build.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c4e46fa7466..1c3a2e8fcb3c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2512,6 +2512,34 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
     build_header(linker, table_data, (void *)(table_data->data + dmar_start),
                  "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
 }
+
+/*
+ * Windows ACPI Emulated Devices Table
+ * (Version 1.0 - April 6, 2009)
+ * Spec: http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx
+ *
+ * Helpful to speedup Windows guests and ignored by others.
+ */
+static void
+build_waet(GArray *table_data, BIOSLinker *linker)
+{
+    int waet_start = table_data->len;
+
+    /* WAET header */
+    acpi_data_push(table_data, sizeof(AcpiTableHeader));
+    /*
+     * Set "ACPI PM timer good" flag.
+     *
+     * Tells Windows guests that our ACPI PM timer is reliable in the
+     * sense that guest can read it only once to obtain a reliable value.
+     * Which avoids costly VMExits caused by guest re-reading it unnecessarily.
+     */
+    build_append_int_noprefix(table_data, 1 << 1 /* ACPI PM timer good */, 4);
+
+    build_header(linker, table_data, (void *)(table_data->data + waet_start),
+                 "WAET", table_data->len - waet_start, 1, NULL, NULL);
+}
+
 /*
  *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
  *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
@@ -2859,6 +2887,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                           machine->nvdimms_state, machine->ram_slots);
     }
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_waet(tables_blob, tables->linker);
+
     /* Add tables supplied by user (if any) */
     for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
         unsigned len = acpi_table_len(u);
-- 
2.20.1


