Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E2CC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A6420725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYKf5vZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A6420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kNz-0005Co-7h
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIe-00012r-G2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIc-0001jH-Il
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIc-0001id-EN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYdstxzcQ0JeYJbq6+rim6fJ1h/j5r1EpcjftqpL+CI=;
 b=HYKf5vZN4aorRuLwgg9vCLOqQaan7m7fp63Ji2yu53DfupGwlbDTAI87h3qkuJoTAq9H3A
 ru207ohpHLFv3OzVPqb1h222jf9SLzvkvFBWKmJvUoQ8qjSoHYCugrUE9vjPOvPM41uQn7
 oLKwTVaSz62s1ix8AeGCsoR9GW2kyLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-IX5MjUGAOHqDJMx-IFXU5w-1; Mon, 17 Feb 2020 12:35:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ED57800D50
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:35:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B7878CCE0;
 Mon, 17 Feb 2020 17:35:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/79] arm/aspeed: actually check RAM size
Date: Mon, 17 Feb 2020 12:33:42 -0500
Message-Id: <20200217173452.15243-10-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IX5MjUGAOHqDJMx-IFXU5w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's supposed that SOC will check if "-m" provided
RAM size is valid by setting "ram-size" property and
then board would read back valid (possibly corrected
value) to map RAM MemoryReging with valid size.
It isn't doing so, since check is called only
indirectly from
  aspeed_sdmc_reset()->asc->compute_conf()
or much later when guest writes to configuration
register.

So depending on "-m" value QEMU end-ups with a warning
and an invalid MemoryRegion size allocated and mapped.
(examples:
 -M ast2500-evb -m 1M
    0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
      0000000080000000-00000000800fffff (prio 0, ram): ram
      0000000080100000-00000000bfffffff (prio 0, i/o): max_ram
 -M ast2500-evb -m 3G
    0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
      0000000080000000-000000013fffffff (prio 0, ram): ram
      [DETECTED OVERFLOW!] 0000000140000000-00000000bfffffff (prio 0, i/o):=
 max_ram
)
On top of that sdmc falls back and reports to guest
"default" size, it thinks machine should have.

This patch makes ram-size check actually work and
changes behavior from a warning later on during
machine reset to error_fatal at the moment SOC.ram-size
is set so user will have to fix RAM size on CLI
to start machine.

It also gets out of the way mutable ram-size logic,
so we could consolidate RAM allocation logic around
pre-allocated hostmem backend (supplied by user or
auto created by generic machine code depending on
supplied -m/mem-path/mem-prealloc options.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
v3:
  * replace
     [PATCH v2 07/86] arm:aspeed: convert valid RAM sizes to data
     [PATCH v2 08/86] arm:aspeed: actually check RAM size
    with a simplified variant that adds ram_size check to sdmc.ram-size
    property
  * use g_assert_not_reached() in default branch
    (C=C3=A9dric Le Goater <clg@kaod.org>)
---
 include/hw/misc/aspeed_sdmc.h |  1 +
 hw/arm/aspeed.c               | 13 +++---
 hw/misc/aspeed_sdmc.c         | 83 +++++++++++++++++++++++++++--------
 3 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 5dbde59fe7..cea1e67fe3 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -40,6 +40,7 @@ typedef struct AspeedSDMCClass {
     SysBusDeviceClass parent_class;
=20
     uint64_t max_ram_size;
+    const uint64_t *valid_ram_sizes;
     uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
     void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
 } AspeedSDMCClass;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a17843f0d3..805bebd0d0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -204,8 +204,12 @@ static void aspeed_machine_init(MachineState *machine)
=20
     sc =3D ASPEED_SOC_GET_CLASS(&bmc->soc);
=20
+    /*
+     * This will error out if isize is not supported by memory controller.
+     */
     object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
-                             &error_abort);
+                             &error_fatal);
+
     object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap1, "hw-strap1"=
,
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap2, "hw-strap2"=
,
@@ -228,13 +232,6 @@ static void aspeed_machine_init(MachineState *machine)
     object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
                              &error_abort);
=20
-    /*
-     * Allocate RAM after the memory controller has checked the size
-     * was valid. If not, a default value is used.
-     */
-    ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-size",
-                                        &error_abort);
-
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size)=
;
     memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 9c184790cd..7b466bf19a 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -17,6 +17,9 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qapi/visitor.h"
=20
 /* Protection Key Register */
 #define R_PROT            (0x00 / 4)
@@ -160,14 +163,9 @@ static int ast2400_rambits(AspeedSDMCState *s)
     case 512:
         return ASPEED_SDMC_DRAM_512MB;
     default:
+        g_assert_not_reached();
         break;
     }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 256M",
-                s->ram_size);
-    s->ram_size =3D 256 << 20;
-    return ASPEED_SDMC_DRAM_256MB;
 }
=20
 static int ast2500_rambits(AspeedSDMCState *s)
@@ -182,14 +180,9 @@ static int ast2500_rambits(AspeedSDMCState *s)
     case 1024:
         return ASPEED_SDMC_AST2500_1024MB;
     default:
+        g_assert_not_reached();
         break;
     }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
-                s->ram_size);
-    s->ram_size =3D 512 << 20;
-    return ASPEED_SDMC_AST2500_512MB;
 }
=20
 static int ast2600_rambits(AspeedSDMCState *s)
@@ -204,14 +197,9 @@ static int ast2600_rambits(AspeedSDMCState *s)
     case 2048:
         return ASPEED_SDMC_AST2600_2048MB;
     default:
+        g_assert_not_reached();
         break;
     }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
-                s->ram_size);
-    s->ram_size =3D 1024 << 20;
-    return ASPEED_SDMC_AST2600_1024MB;
 }
=20
 static void aspeed_sdmc_reset(DeviceState *dev)
@@ -225,6 +213,51 @@ static void aspeed_sdmc_reset(DeviceState *dev)
     s->regs[R_CONF] =3D asc->compute_conf(s, 0);
 }
=20
+static void aspeed_sdmc_get_ram_size(Object *obj, Visitor *v, const char *=
name,
+                                     void *opaque, Error **errp)
+{
+    AspeedSDMCState *s =3D ASPEED_SDMC(obj);
+    int64_t value =3D s->ram_size;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const char *=
name,
+                                     void *opaque, Error **errp)
+{
+    int i;
+    char *sz;
+    int64_t value;
+    Error *local_err =3D NULL;
+    AspeedSDMCState *s =3D ASPEED_SDMC(obj);
+    AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
+
+    visit_type_int(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    for (i =3D 0; asc->valid_ram_sizes[i]; i++) {
+        if (value =3D=3D asc->valid_ram_sizes[i]) {
+            s->ram_size =3D value;
+            return;
+        }
+    }
+
+    sz =3D size_to_str(value);
+    error_setg(&local_err, "Invalid RAM size %s", sz);
+    g_free(sz);
+    error_propagate(errp, local_err);
+}
+
+static void aspeed_sdmc_initfn(Object *obj)
+{
+    object_property_add(obj, "ram-size", "int",
+                        aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_size=
,
+                        NULL, NULL, NULL);
+}
+
 static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
@@ -249,7 +282,6 @@ static const VMStateDescription vmstate_aspeed_sdmc =3D=
 {
 };
=20
 static Property aspeed_sdmc_properties[] =3D {
-    DEFINE_PROP_UINT64("ram-size", AspeedSDMCState, ram_size, 0),
     DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -268,6 +300,7 @@ static const TypeInfo aspeed_sdmc_info =3D {
     .name =3D TYPE_ASPEED_SDMC,
     .parent =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(AspeedSDMCState),
+    .instance_init =3D aspeed_sdmc_initfn,
     .class_init =3D aspeed_sdmc_class_init,
     .class_size =3D sizeof(AspeedSDMCClass),
     .abstract   =3D true,
@@ -298,6 +331,9 @@ static void aspeed_2400_sdmc_write(AspeedSDMCState *s, =
uint32_t reg,
     s->regs[reg] =3D data;
 }
=20
+static const uint64_t
+aspeed_2400_ram_sizes[] =3D { 64 * MiB, 128 * MiB, 256 * MiB, 512 * MiB, 0=
};
+
 static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -307,6 +343,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *kl=
ass, void *data)
     asc->max_ram_size =3D 512 << 20;
     asc->compute_conf =3D aspeed_2400_sdmc_compute_conf;
     asc->write =3D aspeed_2400_sdmc_write;
+    asc->valid_ram_sizes =3D aspeed_2400_ram_sizes;
 }
=20
 static const TypeInfo aspeed_2400_sdmc_info =3D {
@@ -351,6 +388,9 @@ static void aspeed_2500_sdmc_write(AspeedSDMCState *s, =
uint32_t reg,
     s->regs[reg] =3D data;
 }
=20
+static const uint64_t
+aspeed_2500_ram_sizes[] =3D { 128 * MiB, 256 * MiB, 512 * MiB, 1024 * MiB,=
 0};
+
 static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -360,6 +400,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *kl=
ass, void *data)
     asc->max_ram_size =3D 1024 << 20;
     asc->compute_conf =3D aspeed_2500_sdmc_compute_conf;
     asc->write =3D aspeed_2500_sdmc_write;
+    asc->valid_ram_sizes =3D aspeed_2500_ram_sizes;
 }
=20
 static const TypeInfo aspeed_2500_sdmc_info =3D {
@@ -404,6 +445,9 @@ static void aspeed_2600_sdmc_write(AspeedSDMCState *s, =
uint32_t reg,
     s->regs[reg] =3D data;
 }
=20
+static const uint64_t
+aspeed_2600_ram_sizes[] =3D { 256 * MiB, 512 * MiB, 1024 * MiB, 2048 * MiB=
, 0};
+
 static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -413,6 +457,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *kl=
ass, void *data)
     asc->max_ram_size =3D 2048 << 20;
     asc->compute_conf =3D aspeed_2600_sdmc_compute_conf;
     asc->write =3D aspeed_2600_sdmc_write;
+    asc->valid_ram_sizes =3D aspeed_2600_ram_sizes;
 }
=20
 static const TypeInfo aspeed_2600_sdmc_info =3D {
--=20
2.18.1


