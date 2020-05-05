Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48553C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1130C20735
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEmcVMvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1130C20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxsL-0002vA-63
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxqz-0000Jc-LC
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxqx-0003Oc-Q4
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3S4CcNfxGiDO+YX52LuTWfias0eECPmaL1FBHvD3tvM=;
 b=dEmcVMvS/n5berzGmvfHA+1yAAr3fqcV+T+YpFVJ/iAq1yrjvlLvLx8/lOSW5FR7MbeDL5
 OYjjyh9GmLCdYanOj3P/++ghTXDS5nbiurpoYBMYj+Qs+tHUllZI45MRrnpwOHVQO/IeT1
 68PYjsoO5kXlLL7Wg5JeyYAqG5sQb3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-d0h0Fq2MPnaN9d9IhtRj3g-1; Tue, 05 May 2020 09:43:16 -0400
X-MC-Unique: d0h0Fq2MPnaN9d9IhtRj3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2913A0C0C;
 Tue,  5 May 2020 13:43:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7EBC10013D9;
 Tue,  5 May 2020 13:43:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BEAC917511; Tue,  5 May 2020 15:43:05 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/13] acpi: make build_madt() more generic.
Date: Tue,  5 May 2020 15:42:53 +0200
Message-Id: <20200505134305.22666-2-kraxel@redhat.com>
In-Reply-To: <20200505134305.22666-1-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove PCMachineState dependency from build_madt().
Pass AcpiDeviceIf as separate argument instead of
depending on PCMachineState->acpi_dev.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 765409a90eb6..fe60c10201ad 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -366,14 +366,13 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
 }
=20
 static void
-build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
+build_madt(GArray *table_data, BIOSLinker *linker,
+           X86MachineState *x86ms, AcpiDeviceIf *adev)
 {
-    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms =3D X86_MACHINE(pcms);
-    const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHINE(pc=
ms));
+    MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
+    const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHINE(x8=
6ms));
     int madt_start =3D table_data->len;
-    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
-    AcpiDeviceIf *adev =3D ACPI_DEVICE_IF(pcms->acpi_dev);
+    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(adev);
     bool x2apic_mode =3D false;
=20
     AcpiMultipleApicTable *madt;
@@ -2561,7 +2560,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
 *machine)
     aml_len +=3D tables_blob->len - fadt;
=20
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, pcms);
+    build_madt(tables_blob, tables->linker, x86ms,
+               ACPI_DEVICE_IF(pcms->acpi_dev));
=20
     vmgenid_dev =3D find_vmgenid_dev();
     if (vmgenid_dev) {
--=20
2.18.4


