Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F038C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B0521848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B0521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFKd-0005e6-6o
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:54:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFCa-0007Sr-05
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFCY-0006oB-P6
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUFCY-0006mI-Gg
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCDC3307D840;
	Fri, 24 May 2019 18:45:57 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 29C8B1001E65;
	Fri, 24 May 2019 18:45:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 24 May 2019 15:44:46 -0300
Message-Id: <20190524184447.16678-17-ehabkost@redhat.com>
In-Reply-To: <20190524184447.16678-1-ehabkost@redhat.com>
References: <20190524184447.16678-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 24 May 2019 18:45:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/17] hw/arm/mps2: Use object_initialize_child
 for correct reference counting
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

As explained in commit aff39be0ed97:

  Both functions, object_initialize() and object_property_add_child()
  increase the reference counter of the new object, so one of the
  references has to be dropped afterwards to get the reference
  counting right. Otherwise the child object will not be properly
  cleaned up when the parent gets destroyed.
  Thus let's use now object_initialize_child() instead to get the
  reference counting here right.

This patch was generated using the following Coccinelle script:

 @use_sysbus_init_child_obj_missing_parent@
 expression child_ptr;
 expression child_type;
 expression child_size;
 @@
 -   object_initialize(child_ptr, child_size, child_type);
     ...
 -   qdev_set_parent_bus(DEVICE(child_ptr), sysbus_get_default());
     ...
 ?-  object_unref(OBJECT(child_ptr));
 +   sysbus_init_child_obj(OBJECT(PARENT_OBJ), "CHILD_NAME", child_ptr,
 +                         child_size, child_type);

We let the MPS2 boards adopt the cpu core, the FPGA and the SCC children.

While the object_initialize() function doesn't take an
'Error *errp' argument, the object_initialize_child() does.
Since this code is used when a machine is created (and is not
yet running), we deliberately choose to use the &error_abort
argument instead of ignoring errors if an object creation failed.
This choice also matches when using sysbus_init_child_obj(),
since its code is:

  void sysbus_init_child_obj(Object *parent,
                             const char *childname, void *child,
                             size_t childsize, const char *childtype)
  {
      object_initialize_child(parent, childname, child, childsize,
                              childtype, &error_abort, NULL);

      qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
  }

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190507163416.24647-16-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/mps2-tz.c | 8 ++++----
 hw/arm/mps2.c    | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index c167a5fa59..d85dc2c4bd 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -214,9 +214,9 @@ static MemoryRegion *make_scc(MPS2TZMachineState *mms=
, void *opaque,
     DeviceState *sccdev;
     MPS2TZMachineClass *mmc =3D MPS2TZ_MACHINE_GET_CLASS(mms);
=20
-    object_initialize(scc, sizeof(mms->scc), TYPE_MPS2_SCC);
+    sysbus_init_child_obj(OBJECT(mms), "scc", scc,
+                          sizeof(mms->scc), TYPE_MPS2_SCC);
     sccdev =3D DEVICE(scc);
-    qdev_set_parent_bus(sccdev, sysbus_get_default());
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
     qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
@@ -229,8 +229,8 @@ static MemoryRegion *make_fpgaio(MPS2TZMachineState *=
mms, void *opaque,
 {
     MPS2FPGAIO *fpgaio =3D opaque;
=20
-    object_initialize(fpgaio, sizeof(mms->fpgaio), TYPE_MPS2_FPGAIO);
-    qdev_set_parent_bus(DEVICE(fpgaio), sysbus_get_default());
+    sysbus_init_child_obj(OBJECT(mms), "fpgaio", fpgaio,
+                          sizeof(mms->fpgaio), TYPE_MPS2_FPGAIO);
     object_property_set_bool(OBJECT(fpgaio), true, "realized", &error_fa=
tal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(fpgaio), 0);
 }
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index b74f1378c9..10efff36b2 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -174,9 +174,9 @@ static void mps2_common_init(MachineState *machine)
         g_assert_not_reached();
     }
=20
-    object_initialize(&mms->armv7m, sizeof(mms->armv7m), TYPE_ARMV7M);
+    sysbus_init_child_obj(OBJECT(mms), "armv7m", &mms->armv7m,
+                          sizeof(mms->armv7m), TYPE_ARMV7M);
     armv7m =3D DEVICE(&mms->armv7m);
-    qdev_set_parent_bus(armv7m, sysbus_get_default());
     switch (mmc->fpga_type) {
     case FPGA_AN385:
         qdev_prop_set_uint32(armv7m, "num-irq", 32);
@@ -308,9 +308,9 @@ static void mps2_common_init(MachineState *machine)
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
=20
-    object_initialize(&mms->scc, sizeof(mms->scc), TYPE_MPS2_SCC);
+    sysbus_init_child_obj(OBJECT(mms), "scc", &mms->scc,
+                          sizeof(mms->scc), TYPE_MPS2_SCC);
     sccdev =3D DEVICE(&mms->scc);
-    qdev_set_parent_bus(sccdev, sysbus_get_default());
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
     qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
--=20
2.18.0.rc1.1.g3f1ff2140


