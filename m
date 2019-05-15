Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E521EC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B735F20818
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B735F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42429 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0yf-00042r-Rx
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:58:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rc-00067o-P1
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rb-0001Mf-EY
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0rb-0001LY-4T
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74BEC30018E9
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:50:58 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 778201820D;
	Wed, 15 May 2019 20:50:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:22 +0200
Message-Id: <1557953433-19663-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 15 May 2019 20:50:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/21] hw/i386/acpi: Add
 object_resolve_type_unambiguous to improve modularity
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

When building with CONFIG_Q35=3Dn, we get:

    LINK    x86_64-softmmu/qemu-system-x86_64
  /usr/bin/ld: hw/i386/acpi-build.o: in function `acpi_get_misc_info':
  /source/qemu/hw/i386/acpi-build.c:243: undefined reference to `ich9_lpc=
_find'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:204: qemu-system-x86_64] Error 1

This is due to a dependency in acpi-build.c on the ICH9_LPC
(via ich9_lpc_find) and PIIX4_PM (via piix4_pm_find) devices.

To allow better modularity (compile acpi-build.c with only
Q35/ICH9 or ISAPC/PIIX4), refactor the similar helper as
object_resolve_type_unambiguous(). This way we relax the
linker dependencies and can build the x86 targets with a
selection of machines (instead of all of them).

Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
Message-Id: <20190427144025.22880-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/piix4.c         | 11 -----------
 hw/i386/acpi-build.c    | 20 ++++++++++++++++----
 hw/isa/lpc_ich9.c       | 11 -----------
 include/hw/acpi/piix4.h |  2 --
 include/hw/i386/ich9.h  |  2 --
 5 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 160e730..c903e65 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -552,17 +552,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error *=
*errp)
     piix4_pm_add_propeties(s);
 }
=20
-Object *piix4_pm_find(void)
-{
-    bool ambig;
-    Object *o =3D object_resolve_path_type("", TYPE_PIIX4_PM, &ambig);
-
-    if (ambig || !o) {
-        return NULL;
-    }
-    return o;
-}
-
 I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
                       qemu_irq sci_irq, qemu_irq smi_irq,
                       int smm_enabled, DeviceState **piix4_pm)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 416da31..123ff2b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -35,6 +35,7 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu.h"
+#include "hw/acpi/piix4.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/loader.h"
@@ -164,10 +165,21 @@ static void init_common_fadt_data(Object *o, AcpiFa=
dtData *data)
     *data =3D fadt;
 }
=20
+static Object *object_resolve_type_unambiguous(const char *typename)
+{
+    bool ambig;
+    Object *o =3D object_resolve_path_type("", typename, &ambig);
+
+    if (ambig || !o) {
+        return NULL;
+    }
+    return o;
+}
+
 static void acpi_get_pm_info(AcpiPmInfo *pm)
 {
-    Object *piix =3D piix4_pm_find();
-    Object *lpc =3D ich9_lpc_find();
+    Object *piix =3D object_resolve_type_unambiguous(TYPE_PIIX4_PM);
+    Object *lpc =3D object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE=
);
     Object *obj =3D piix ? piix : lpc;
     QObject *o;
     pm->cpu_hp_io_base =3D 0;
@@ -228,8 +240,8 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
=20
 static void acpi_get_misc_info(AcpiMiscInfo *info)
 {
-    Object *piix =3D piix4_pm_find();
-    Object *lpc =3D ich9_lpc_find();
+    Object *piix =3D object_resolve_type_unambiguous(TYPE_PIIX4_PM);
+    Object *lpc =3D object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE=
);
     assert(!!piix !=3D !!lpc);
=20
     if (piix) {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ac44aa5..031ee9c 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -624,17 +624,6 @@ static const MemoryRegionOps ich9_rst_cnt_ops =3D {
     .endianness =3D DEVICE_LITTLE_ENDIAN
 };
=20
-Object *ich9_lpc_find(void)
-{
-    bool ambig;
-    Object *o =3D object_resolve_path_type("", TYPE_ICH9_LPC_DEVICE, &am=
big);
-
-    if (ambig) {
-        return NULL;
-    }
-    return o;
-}
-
 static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *na=
me,
                                  void *opaque, Error **errp)
 {
diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
index 57d7e1c..028bb53 100644
--- a/include/hw/acpi/piix4.h
+++ b/include/hw/acpi/piix4.h
@@ -3,6 +3,4 @@
=20
 #define TYPE_PIIX4_PM "PIIX4_PM"
=20
-Object *piix4_pm_find(void);
-
 #endif
diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 673d13d..046bcf3 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -81,8 +81,6 @@ typedef struct ICH9LPCState {
     qemu_irq gsi[GSI_NUM_PINS];
 } ICH9LPCState;
=20
-Object *ich9_lpc_find(void);
-
 #define Q35_MASK(bit, ms_bit, ls_bit) \
 ((uint##bit##_t)(((1ULL << ((ms_bit) + 1)) - 1) & ~((1ULL << ls_bit) - 1=
)))
=20
--=20
1.8.3.1



