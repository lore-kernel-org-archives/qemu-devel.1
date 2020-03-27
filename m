Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52062C2D0E8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209D1207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh9KyqT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209D1207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHns5-00014L-EJ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jHnpc-0005He-Rm
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jHnpb-0002Ex-LP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37769)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jHnpb-0002EZ-HK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585311083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4LbFLFNfhoCRPregA0NOj+Xtp8e0pU8PyiFRkAwvEY=;
 b=Xh9KyqT+tFrgjz+VSMKelNqG365pLctsGivCPSSHjS460O5Sjuo7upghYLbNUWoZADPE1S
 U845DeM63484qFt0PwuN74Z1CPIf+gFaY01cZWb6Uc84AZdJ76Cx+AruqfEWkCujES7D5X
 g/s5a86uNkLSGPTFEGsJNfnF7JEntRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-sQoixQBsPq2OD09VpBi-MQ-1; Fri, 27 Mar 2020 08:11:19 -0400
X-MC-Unique: sQoixQBsPq2OD09VpBi-MQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3967DBA6;
 Fri, 27 Mar 2020 12:11:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC7705DA75;
 Fri, 27 Mar 2020 12:11:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D17232049E; Fri, 27 Mar 2020 13:11:11 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] acpi: make build_madt() more generic.
Date: Fri, 27 Mar 2020 13:11:07 +0100
Message-Id: <20200327121111.1530-3-kraxel@redhat.com>
In-Reply-To: <20200327121111.1530-1-kraxel@redhat.com>
References: <20200327121111.1530-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove PCMachineState dependency from build_madt().
Pass AcpiDeviceIf as separate argument instead of
depending on PCMachineState->acpi_dev.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/acpi-build-pc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build-pc.c b/hw/i386/acpi-build-pc.c
index cad44160ff3a..a9dbf080566b 100644
--- a/hw/i386/acpi-build-pc.c
+++ b/hw/i386/acpi-build-pc.c
@@ -347,14 +347,13 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
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
@@ -2782,7 +2781,8 @@ void acpi_build_pc(AcpiBuildTables *tables, MachineSt=
ate *machine)
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
2.18.2


