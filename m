Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E131C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B828217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9wrYPqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B828217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYDX-00066B-5A
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1itXya-0004t4-Bc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1itXyW-00009B-Sx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:24:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53242
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1itXyW-00008q-Pb
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579530260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQQrypcH82vvxguj9m1CeBZ/Pu2S/bf4/KIB8a4Hv5s=;
 b=L9wrYPqBxDaO/mJqQHZAL3BYu3RoKtfzeR36njNHvoA85uAZmgPqZ95JIWNhT51rV2liZM
 1zmbahBD0TRNStioIUi7A0t2A5EwguLtS3dzqBkXOUaLb2A8GMwFZak8OXpeOtW0uNO8Z6
 He5EnD7CCH29RPLUO0IyXL/G5oLDdYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-emjuMxipPBauaJvGJ_kkWQ-1; Mon, 20 Jan 2020 09:24:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49137DB61;
 Mon, 20 Jan 2020 14:24:15 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB8A560C81;
 Mon, 20 Jan 2020 14:24:13 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/84] hw/arm/aspeed: actually check RAM size
Date: Mon, 20 Jan 2020 15:21:52 +0100
Message-Id: <1579530112-80542-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <83481ccb-38e4-d0a2-18b5-66fcd7248521@kaod.org>
References: <83481ccb-38e4-d0a2-18b5-66fcd7248521@kaod.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: emjuMxipPBauaJvGJ_kkWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 clg@kaod.org, joel@jms.id.au
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
---
v3:
  * replace
     [PATCH v2 07/86] arm:aspeed: convert valid RAM sizes to data
     [PATCH v2 08/86] arm:aspeed: actually check RAM size
    with a simplified variant that adds ram_size check to sdmc.ram-size
    property

CC: clg@kaod.org
CC: peter.maydell@linaro.org
CC: andrew@aj.id.au
CC: joel@jms.id.au
CC: qemu-arm@nongnu.org

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/misc/aspeed_sdmc.h |  1 +
 hw/arm/aspeed.c               | 13 +++-----
 hw/misc/aspeed_sdmc.c         | 77 +++++++++++++++++++++++++++++++++++----=
----
 3 files changed, 70 insertions(+), 21 deletions(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 5dbde59..cea1e67 100644
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
index cc06af4..c8573e5 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -191,8 +191,12 @@ static void aspeed_machine_init(MachineState *machine)
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
@@ -215,13 +219,6 @@ static void aspeed_machine_init(MachineState *machine)
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
index 2df3244..b36b362 100644
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
@@ -163,10 +166,7 @@ static int ast2400_rambits(AspeedSDMCState *s)
         break;
     }
=20
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 256M",
-                s->ram_size);
-    s->ram_size =3D 256 << 20;
+    assert(0);
     return ASPEED_SDMC_DRAM_256MB;
 }
=20
@@ -185,10 +185,7 @@ static int ast2500_rambits(AspeedSDMCState *s)
         break;
     }
=20
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
-                s->ram_size);
-    s->ram_size =3D 512 << 20;
+    assert(0);
     return ASPEED_SDMC_AST2500_512MB;
 }
=20
@@ -207,10 +204,7 @@ static int ast2600_rambits(AspeedSDMCState *s)
         break;
     }
=20
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
-                s->ram_size);
-    s->ram_size =3D 1024 << 20;
+    assert(0);
     return ASPEED_SDMC_AST2600_1024MB;
 }
=20
@@ -225,6 +219,51 @@ static void aspeed_sdmc_reset(DeviceState *dev)
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
@@ -249,7 +288,6 @@ static const VMStateDescription vmstate_aspeed_sdmc =3D=
 {
 };
=20
 static Property aspeed_sdmc_properties[] =3D {
-    DEFINE_PROP_UINT64("ram-size", AspeedSDMCState, ram_size, 0),
     DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -268,6 +306,7 @@ static const TypeInfo aspeed_sdmc_info =3D {
     .name =3D TYPE_ASPEED_SDMC,
     .parent =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(AspeedSDMCState),
+    .instance_init =3D aspeed_sdmc_initfn,
     .class_init =3D aspeed_sdmc_class_init,
     .class_size =3D sizeof(AspeedSDMCClass),
     .abstract   =3D true,
@@ -298,6 +337,9 @@ static void aspeed_2400_sdmc_write(AspeedSDMCState *s, =
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
@@ -307,6 +349,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *kl=
ass, void *data)
     asc->max_ram_size =3D 512 << 20;
     asc->compute_conf =3D aspeed_2400_sdmc_compute_conf;
     asc->write =3D aspeed_2400_sdmc_write;
+    asc->valid_ram_sizes =3D aspeed_2400_ram_sizes;
 }
=20
 static const TypeInfo aspeed_2400_sdmc_info =3D {
@@ -351,6 +394,9 @@ static void aspeed_2500_sdmc_write(AspeedSDMCState *s, =
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
@@ -360,6 +406,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *kl=
ass, void *data)
     asc->max_ram_size =3D 1024 << 20;
     asc->compute_conf =3D aspeed_2500_sdmc_compute_conf;
     asc->write =3D aspeed_2500_sdmc_write;
+    asc->valid_ram_sizes =3D aspeed_2500_ram_sizes;
 }
=20
 static const TypeInfo aspeed_2500_sdmc_info =3D {
@@ -404,6 +451,9 @@ static void aspeed_2600_sdmc_write(AspeedSDMCState *s, =
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
@@ -413,6 +463,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *kl=
ass, void *data)
     asc->max_ram_size =3D 2048 << 20;
     asc->compute_conf =3D aspeed_2600_sdmc_compute_conf;
     asc->write =3D aspeed_2600_sdmc_write;
+    asc->valid_ram_sizes =3D aspeed_2600_ram_sizes;
 }
=20
 static const TypeInfo aspeed_2600_sdmc_info =3D {
--=20
2.7.4


