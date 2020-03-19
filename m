Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E98C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C721B2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRTgJFy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C721B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEq8j-0003BK-L1
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7P-0001T2-Va
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7O-0004j7-KC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7O-0004fm-FA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTOl9V1tW+equkBFrFW1bOI3Sc3aPlZ699ReWgCv7Jg=;
 b=cRTgJFy9/nZHbDyxnrs7Z1S4rugvXr6MIk8+wAHzJNm68pIhkTvpIfOe79vtdp8U6uj2/5
 C1ZG03ZyqmbHiWCSYKB23np1Qco8DuIq0WUoPb7mNAJ2f15YTJYTE7XTK8mtj2G2OLX37H
 d/8H/2LiTmLKYMSGYf4sVgppcFzf9hI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-N_2-T-3uPWCOG3V6BrflKQ-1; Thu, 19 Mar 2020 04:01:27 -0400
X-MC-Unique: N_2-T-3uPWCOG3V6BrflKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98EEF18B9FC2;
 Thu, 19 Mar 2020 08:01:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D9A01001B07;
 Thu, 19 Mar 2020 08:01:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A645131EAC; Thu, 19 Mar 2020 09:01:17 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/13] acpi: make build_madt() more generic.
Date: Thu, 19 Mar 2020 09:01:05 +0100
Message-Id: <20200319080117.7725-2-kraxel@redhat.com>
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove PCMachineState dependency from build_madt().
Pass AcpiDeviceIf as separate argument instead of
depending on PCMachineState->acpi_dev.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9a19c14e661b..1b0684c433e3 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -360,14 +360,13 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
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
@@ -2807,7 +2806,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
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
2.18.2


