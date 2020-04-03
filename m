Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55580C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA4220721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6DmSnt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA4220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHTa-00013R-6S
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKHKT-0001Fo-EU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKHKR-00089T-AD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41653
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKHKR-00087w-59
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585901126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkzGWNEAAwQqNeR3QTDBBeP0R1nXVnjTzKSxJNL7k7s=;
 b=i6DmSnt2mku9oHW2w55x5YmhhT52DXPMmATNwlfItPMr3zDEUl6YUq8FergA6wERd0lhgm
 iTqdOMyGMIVrtIq9TIcRyg74OViNF7FGhl1by24qOdweWiweojWV0UBwXG8/1t1tU8toMi
 xzLA50Jr/YElfHTUu7Az0wLP5oIs7PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-Mt-gAv8ONg2xXPgtZ5QqpQ-1; Fri, 03 Apr 2020 04:05:23 -0400
X-MC-Unique: Mt-gAv8ONg2xXPgtZ5QqpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50E818A5522;
 Fri,  3 Apr 2020 08:05:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B560A5D9CA;
 Fri,  3 Apr 2020 08:05:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4E1D017522; Fri,  3 Apr 2020 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] acpi: move aml builder code for floppy device
Date: Fri,  3 Apr 2020 10:05:00 +0200
Message-Id: <20200403080502.8154-11-kraxel@redhat.com>
In-Reply-To: <20200403080502.8154-1-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/block/fdc.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c | 83 --------------------------------------------
 stubs/cmos.c         |  7 ++++
 stubs/Makefile.objs  |  1 +
 4 files changed, 91 insertions(+), 83 deletions(-)
 create mode 100644 stubs/cmos.c

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 22e954e0dc2d..ebfc1d5ac400 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -32,6 +32,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "hw/i386/pc.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
@@ -2789,6 +2791,85 @@ void isa_fdc_get_drive_max_chs(FloppyDriveType type,
     (*maxc)--;
 }
=20
+static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
+{
+    Aml *dev, *fdi;
+    uint8_t maxc, maxh, maxs;
+
+    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
+
+    dev =3D aml_device("FLP%c", 'A' + idx);
+
+    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
+
+    fdi =3D aml_package(16);
+    aml_append(fdi, aml_int(idx));  /* Drive Number */
+    aml_append(fdi,
+        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
+    /*
+     * the values below are the limits of the drive, and are thus independ=
ent
+     * of the inserted media
+     */
+    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
+    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
+    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
+    /*
+     * SeaBIOS returns the below values for int 0x13 func 0x08 regardless =
of
+     * the drive type, so shall we
+     */
+    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
+    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
+    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
+    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
+    aml_append(fdi, aml_int(0x12));  /* disk_eot */
+    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
+    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
+    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
+    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
+    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
+    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
+
+    aml_append(dev, aml_name_decl("_FDI", fdi));
+    return dev;
+}
+
+static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
+{
+    Aml *dev;
+    Aml *crs;
+    int i;
+
+#define ACPI_FDE_MAX_FD 4
+    uint32_t fde_buf[5] =3D {
+        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
+        cpu_to_le32(2)  /* tape presence (2 =3D=3D never present) */
+    };
+
+    crs =3D aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
+    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
+    aml_append(crs, aml_irq_no_flags(6));
+    aml_append(crs,
+        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
+
+    dev =3D aml_device("FDC0");
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    for (i =3D 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
+        FloppyDriveType type =3D isa_fdc_get_drive_type(isadev, i);
+
+        if (type < FLOPPY_DRIVE_TYPE_NONE) {
+            fde_buf[i] =3D cpu_to_le32(1);  /* drive present */
+            aml_append(dev, build_fdinfo_aml(i, type));
+        }
+    }
+    aml_append(dev, aml_name_decl("_FDE",
+               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
+
+    aml_append(scope, dev);
+}
+
 static const VMStateDescription vmstate_isa_fdc =3D{
     .name =3D "fdc",
     .version_id =3D 2,
@@ -2822,11 +2903,13 @@ static Property isa_fdc_properties[] =3D {
 static void isabus_fdc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
=20
     dc->realize =3D isabus_fdc_realize;
     dc->fw_name =3D "fdc";
     dc->reset =3D fdctrl_external_reset_isa;
     dc->vmsd =3D &vmstate_isa_fdc;
+    isa->build_aml =3D fdc_isa_build_aml;
     device_class_set_props(dc, isa_fdc_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0539620ddff5..be29422ede14 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1052,85 +1052,6 @@ static void build_hpet_aml(Aml *table)
     aml_append(table, scope);
 }
=20
-static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
-{
-    Aml *dev, *fdi;
-    uint8_t maxc, maxh, maxs;
-
-    isa_fdc_get_drive_max_chs(type, &maxc, &maxh, &maxs);
-
-    dev =3D aml_device("FLP%c", 'A' + idx);
-
-    aml_append(dev, aml_name_decl("_ADR", aml_int(idx)));
-
-    fdi =3D aml_package(16);
-    aml_append(fdi, aml_int(idx));  /* Drive Number */
-    aml_append(fdi,
-        aml_int(cmos_get_fd_drive_type(type)));  /* Device Type */
-    /*
-     * the values below are the limits of the drive, and are thus independ=
ent
-     * of the inserted media
-     */
-    aml_append(fdi, aml_int(maxc));  /* Maximum Cylinder Number */
-    aml_append(fdi, aml_int(maxs));  /* Maximum Sector Number */
-    aml_append(fdi, aml_int(maxh));  /* Maximum Head Number */
-    /*
-     * SeaBIOS returns the below values for int 0x13 func 0x08 regardless =
of
-     * the drive type, so shall we
-     */
-    aml_append(fdi, aml_int(0xAF));  /* disk_specify_1 */
-    aml_append(fdi, aml_int(0x02));  /* disk_specify_2 */
-    aml_append(fdi, aml_int(0x25));  /* disk_motor_wait */
-    aml_append(fdi, aml_int(0x02));  /* disk_sector_siz */
-    aml_append(fdi, aml_int(0x12));  /* disk_eot */
-    aml_append(fdi, aml_int(0x1B));  /* disk_rw_gap */
-    aml_append(fdi, aml_int(0xFF));  /* disk_dtl */
-    aml_append(fdi, aml_int(0x6C));  /* disk_formt_gap */
-    aml_append(fdi, aml_int(0xF6));  /* disk_fill */
-    aml_append(fdi, aml_int(0x0F));  /* disk_head_sttl */
-    aml_append(fdi, aml_int(0x08));  /* disk_motor_strt */
-
-    aml_append(dev, aml_name_decl("_FDI", fdi));
-    return dev;
-}
-
-static Aml *build_fdc_device_aml(ISADevice *fdc)
-{
-    int i;
-    Aml *dev;
-    Aml *crs;
-
-#define ACPI_FDE_MAX_FD 4
-    uint32_t fde_buf[5] =3D {
-        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
-        cpu_to_le32(2)  /* tape presence (2 =3D=3D never present) */
-    };
-
-    dev =3D aml_device("FDC0");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
-
-    crs =3D aml_resource_template();
-    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
-    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
-    aml_append(crs, aml_irq_no_flags(6));
-    aml_append(crs,
-        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    for (i =3D 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
-        FloppyDriveType type =3D isa_fdc_get_drive_type(fdc, i);
-
-        if (type < FLOPPY_DRIVE_TYPE_NONE) {
-            fde_buf[i] =3D cpu_to_le32(1);  /* drive present */
-            aml_append(dev, build_fdinfo_aml(i, type));
-        }
-    }
-    aml_append(dev, aml_name_decl("_FDE",
-               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));
-
-    return dev;
-}
-
 static Aml *build_kbd_device_aml(void)
 {
     Aml *dev;
@@ -1169,7 +1090,6 @@ static Aml *build_mouse_device_aml(void)
=20
 static void build_isa_devices_aml(Aml *table)
 {
-    ISADevice *fdc =3D pc_find_fdc0();
     bool ambiguous;
=20
     Aml *scope =3D aml_scope("_SB.PCI0.ISA");
@@ -1177,9 +1097,6 @@ static void build_isa_devices_aml(Aml *table)
=20
     aml_append(scope, build_kbd_device_aml());
     aml_append(scope, build_mouse_device_aml());
-    if (fdc) {
-        aml_append(scope, build_fdc_device_aml(fdc));
-    }
=20
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data=
");
diff --git a/stubs/cmos.c b/stubs/cmos.c
new file mode 100644
index 000000000000..416cbe4055ff
--- /dev/null
+++ b/stubs/cmos.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/i386/pc.h"
+
+int cmos_get_fd_drive_type(FloppyDriveType fd0)
+{
+    return 0;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 45be5dc0ed78..3cbe472d1c6c 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -3,6 +3,7 @@ stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
 stub-obj-y +=3D clock-warp.o
+stub-obj-y +=3D cmos.o
 stub-obj-y +=3D cpu-get-clock.o
 stub-obj-y +=3D cpu-get-icount.o
 stub-obj-y +=3D dump.o
--=20
2.18.2


