Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97730C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629F82072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+VxWOUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629F82072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqAc-0006ZI-I6
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7U-0001Vy-43
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7S-00050n-R2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21029)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7S-00050g-Mo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERu4o6ZtMX3qssJlFkElPsXEJtkE7CGsEmZCw3MKIR4=;
 b=L+VxWOUkUOeuw8R8HiWyd94qX9zcqnz6rbFV9k88PJ59c5Q1bZc4tTwwjMy93Uc3q4vY6J
 HZI59+3j9+sricSZAVtN4A+gWDDVmLZ04dYU5I8iQP1gXxcLFFGHHdAyl4LJZm8OKH0xZF
 vetcvnV1dsddKZehr2U67SKRkkQGnZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-t0URfHqHMJeOEFEvVNv_YA-1; Thu, 19 Mar 2020 04:01:32 -0400
X-MC-Unique: t0URfHqHMJeOEFEvVNv_YA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53136107B765;
 Thu, 19 Mar 2020 08:01:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8B701001938;
 Thu, 19 Mar 2020 08:01:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 265AA3EC0A; Thu, 19 Mar 2020 09:01:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] microvm: make virtio irq base runtime configurable
Date: Thu, 19 Mar 2020 09:01:16 +0100
Message-Id: <20200319080117.7725-13-kraxel@redhat.com>
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h |  2 +-
 hw/i386/acpi-build.c      |  6 +++---
 hw/i386/microvm.c         | 11 +++++++----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 53b2457db752..87828325ec32 100644
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
@@ -61,6 +60,7 @@ typedef struct {
     ISADevice *rtc_state;
=20
     /* Machine state */
+    uint32_t virtio_irq_base;
     bool kernel_cmdline_fixed;
     Notifier machine_done;
     AcpiDeviceIf *acpi_dev;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b765c31c80b0..9bddeb77704d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2755,7 +2755,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     return true;
 }
=20
-static void acpi_dsdt_add_virtio(Aml *scope)
+static void acpi_dsdt_add_virtio(Aml *scope, MicrovmMachineState *mms)
 {
     gchar *separator;
     long int index;
@@ -2783,7 +2783,7 @@ static void acpi_dsdt_add_virtio(Aml *scope)
                 continue;
             }
=20
-            uint32_t irq =3D VIRTIO_IRQ_BASE + index;
+            uint32_t irq =3D mms->virtio_irq_base + index;
             hwaddr base =3D VIRTIO_MMIO_BASE + index * 512;
             hwaddr size =3D 512;
=20
@@ -2825,7 +2825,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *li=
nker,
         aml_append(sb_scope, build_com_device_aml(1, false));
     }
     acpi_dsdt_add_fw_cfg(sb_scope, OBJECT(x86ms->fw_cfg));
-    acpi_dsdt_add_virtio(sb_scope);
+    acpi_dsdt_add_virtio(sb_scope, mms);
     aml_append(dsdt, sb_scope);
=20
     scope =3D aml_scope("\\");
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 748f9826fb0e..834b10aee0a2 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -122,10 +122,11 @@ static void microvm_devices_init(MicrovmMachineState =
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
@@ -265,7 +266,7 @@ static void microvm_memory_init(MicrovmMachineState *mm=
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
@@ -285,7 +286,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
     ret =3D g_snprintf(cmdline, VIRTIO_CMDLINE_MAXLEN,
                      " virtio_mmio.device=3D512@0x%lx:%ld",
                      VIRTIO_MMIO_BASE + index * 512,
-                     VIRTIO_IRQ_BASE + index);
+                     virtio_irq_base + index);
     if (ret < 0 || ret >=3D VIRTIO_CMDLINE_MAXLEN) {
         g_free(cmdline);
         return NULL;
@@ -297,6 +298,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
 static void microvm_fix_kernel_cmdline(MachineState *machine)
 {
     X86MachineState *x86ms =3D X86_MACHINE(machine);
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
     BusState *bus;
     BusChild *kid;
     char *cmdline;
@@ -320,7 +322,8 @@ static void microvm_fix_kernel_cmdline(MachineState *ma=
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
2.18.2


