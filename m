Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76942C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F87206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORfr1+Kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F87206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxwO-0001Rb-Dh
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr9-0000XS-8Q
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr6-0003be-RL
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgSpJqdMPIXS+SyyuipeEjYSEQ5SaPyedMVSrXiUrTQ=;
 b=ORfr1+Kr9rPGQRY/MUhZUQ7Ox+9azxDFHO5w9U9E013cKZ8ONciy09NnOmHGtlwPg1y/Lb
 qI3uUexgfoADIpKMLTI5hgpQN3KgbME9fumfAE+4kmqJemQbO4QIhg8U98IU81PjiLwART
 B4WQAmylxBqM6o140ztXmMqO9hwoAHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-z3zmkZ_MMIiZuBuTN7E5cg-1; Tue, 05 May 2020 09:43:26 -0400
X-MC-Unique: z3zmkZ_MMIiZuBuTN7E5cg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B594100A629;
 Tue,  5 May 2020 13:43:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B04285F7EA;
 Tue,  5 May 2020 13:43:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4D1F29D57; Tue,  5 May 2020 15:43:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/13] microvm: make virtio irq base runtime configurable
Date: Tue,  5 May 2020 15:43:04 +0200
Message-Id: <20200505134305.22666-13-kraxel@redhat.com>
In-Reply-To: <20200505134305.22666-1-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h |  2 +-
 hw/i386/acpi-microvm.c    |  6 +++---
 hw/i386/microvm.c         | 11 +++++++----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 55f5984cfaa1..878d2a8011f4 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -28,7 +28,6 @@
=20
 /* Platform virtio definitions */
 #define VIRTIO_MMIO_BASE      0xc0000000
-#define VIRTIO_IRQ_BASE       5
 #define VIRTIO_NUM_TRANSPORTS 8
 #define VIRTIO_CMDLINE_MAXLEN 64
=20
@@ -63,6 +62,7 @@ typedef struct {
     bool auto_kernel_cmdline;
=20
     /* Machine state */
+    uint32_t virtio_irq_base;
     bool kernel_cmdline_fixed;
     Notifier machine_done;
     AcpiDeviceIf *acpi_dev;
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 4d91ac9360ce..1230080c45cd 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -47,7 +47,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
     aml_append(scope, dev);
 }
=20
-static void acpi_dsdt_add_virtio(Aml *scope)
+static void acpi_dsdt_add_virtio(Aml *scope, MicrovmMachineState *mms)
 {
     gchar *separator;
     long int index;
@@ -75,7 +75,7 @@ static void acpi_dsdt_add_virtio(Aml *scope)
                 continue;
             }
=20
-            uint32_t irq =3D VIRTIO_IRQ_BASE + index;
+            uint32_t irq =3D mms->virtio_irq_base + index;
             hwaddr base =3D VIRTIO_MMIO_BASE + index * 512;
             hwaddr size =3D 512;
=20
@@ -119,7 +119,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *link=
er,
     build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
-    acpi_dsdt_add_virtio(sb_scope);
+    acpi_dsdt_add_virtio(sb_scope, mms);
     aml_append(dsdt, sb_scope);
=20
     scope =3D aml_scope("\\");
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a3708fdf1e39..2aa2804e4ca0 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -124,10 +124,11 @@ static void microvm_devices_init(MicrovmMachineState =
*mms)
=20
     kvmclock_create();
=20
+    mms->virtio_irq_base =3D 8;
     for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
         sysbus_create_simple("virtio-mmio",
                              VIRTIO_MMIO_BASE + i * 512,
-                             x86ms->gsi[VIRTIO_IRQ_BASE + i]);
+                             x86ms->gsi[mms->virtio_irq_base + i]);
     }
=20
     /* Optional and legacy devices */
@@ -274,7 +275,7 @@ static void microvm_memory_init(MicrovmMachineState *mm=
s)
     x86ms->ioapic_as =3D &address_space_memory;
 }
=20
-static gchar *microvm_get_mmio_cmdline(gchar *name)
+static gchar *microvm_get_mmio_cmdline(gchar *name, uint32_t virtio_irq_ba=
se)
 {
     gchar *cmdline;
     gchar *separator;
@@ -294,7 +295,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
     ret =3D g_snprintf(cmdline, VIRTIO_CMDLINE_MAXLEN,
                      " virtio_mmio.device=3D512@0x%lx:%ld",
                      VIRTIO_MMIO_BASE + index * 512,
-                     VIRTIO_IRQ_BASE + index);
+                     virtio_irq_base + index);
     if (ret < 0 || ret >=3D VIRTIO_CMDLINE_MAXLEN) {
         g_free(cmdline);
         return NULL;
@@ -306,6 +307,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
 static void microvm_fix_kernel_cmdline(MachineState *machine)
 {
     X86MachineState *x86ms =3D X86_MACHINE(machine);
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
     BusState *bus;
     BusChild *kid;
     char *cmdline;
@@ -329,7 +331,8 @@ static void microvm_fix_kernel_cmdline(MachineState *ma=
chine)
             BusState *mmio_bus =3D &mmio_virtio_bus->parent_obj;
=20
             if (!QTAILQ_EMPTY(&mmio_bus->children)) {
-                gchar *mmio_cmdline =3D microvm_get_mmio_cmdline(mmio_bus-=
>name);
+                gchar *mmio_cmdline =3D microvm_get_mmio_cmdline
+                    (mmio_bus->name, mms->virtio_irq_base);
                 if (mmio_cmdline) {
                     char *newcmd =3D g_strjoin(NULL, cmdline, mmio_cmdline=
, NULL);
                     g_free(mmio_cmdline);
--=20
2.18.4


