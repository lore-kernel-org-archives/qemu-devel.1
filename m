Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EB6C4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAEE21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8lRq7wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAEE21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j73qU-0003Je-BJ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 16:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j73mn-0006Nu-02
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j73ml-0002B4-Mx
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:00:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j73ml-00029T-If
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582750803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydEUTzYDeS8m3DXDxDiuUpRyMkCwaTisv5HItnAGSLg=;
 b=P8lRq7wSHO7mEEJAY82KQbpmnV9Jas7ElruLXUHqBfcd1asPWVH0/0Es1E7db3cYRTXcAk
 SZkZYyNuNzwGGK6X/sVwU1N0sru9IQHJnGDjX1+XRn7WRUbAmUBtOmFCGZHjyrb2w0yzYI
 AdSuda3d0dQFHpeOH5Oek5mqQTv18OU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-DWI_X6o6N-60FDyp5M2Gbw-1; Wed, 26 Feb 2020 16:00:01 -0500
X-MC-Unique: DWI_X6o6N-60FDyp5M2Gbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10060477;
 Wed, 26 Feb 2020 21:00:00 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E4E95C545;
 Wed, 26 Feb 2020 20:59:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v4 01/10] tpm: rename TPM_TIS into TPM_TIS_ISA
Date: Wed, 26 Feb 2020 21:59:33 +0100
Message-Id: <20200226205942.11424-2-eric.auger@redhat.com>
In-Reply-To: <20200226205942.11424-1-eric.auger@redhat.com>
References: <20200226205942.11424-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we plan to introduce a sysbus TPM_TIS, let's rename
TPM_TIS into TPM_TIS_ISA.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---

RFC v2 -> PATCH:
- added Philippe and Stefan's R-b
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
             /* Scan all PCI buses. Generate tables to support hotplug. */
             build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
=20
-            if (TPM_IS_TIS(tpm)) {
+            if (TPM_IS_TIS_ISA(tpm)) {
                 if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
                     dev =3D aml_device("TPM");
                     aml_append(dev, aml_name_decl("_HID",
@@ -2304,7 +2304,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GA=
rray *tcpalog)
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
@@ -1008,7 +1008,7 @@ static void tpm_tis_class_init(ObjectClass *klass, vo=
id *data)
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
2.20.1


