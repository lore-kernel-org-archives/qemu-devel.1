Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052CC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C88021848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C88021848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFND-00080i-9v
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:56:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFCS-0007JZ-1R
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFCQ-0006d3-Cp
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUFCQ-0006T4-4Y
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA1933082140;
	Fri, 24 May 2019 18:45:39 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 04E116871F;
	Fri, 24 May 2019 18:45:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 24 May 2019 15:44:41 -0300
Message-Id: <20190524184447.16678-12-ehabkost@redhat.com>
In-Reply-To: <20190524184447.16678-1-ehabkost@redhat.com>
References: <20190524184447.16678-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 24 May 2019 18:45:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/17] hw/mips: Use object_initialize_child for
 correct reference counting
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

We let the Malta/Boston machines adopt the CPS child, and similarly
the CPS adopts the ITU/CPC/GIC/GCR children.

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
Message-Id: <20190507163416.24647-11-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mips/boston.c     |  4 ++--
 hw/mips/cps.c        | 20 ++++++++------------
 hw/mips/mips_malta.c |  4 ++--
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index cb3ea85fdc..1ffccc8da9 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -455,8 +455,8 @@ static void boston_mach_init(MachineState *machine)
=20
     is_64b =3D cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
=20
-    object_initialize(&s->cps, sizeof(s->cps), TYPE_MIPS_CPS);
-    qdev_set_parent_bus(DEVICE(&s->cps), sysbus_get_default());
+    sysbus_init_child_obj(OBJECT(machine), "cps", OBJECT(&s->cps),
+                          sizeof(s->cps), TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-typ=
e",
                             &err);
     object_property_set_int(OBJECT(&s->cps), smp_cpus, "num-vp", &err);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index fc97f59af4..649b35a76c 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -94,9 +94,8 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
=20
     /* Inter-Thread Communication Unit */
     if (itu_present) {
-        object_initialize(&s->itu, sizeof(s->itu), TYPE_MIPS_ITU);
-        qdev_set_parent_bus(DEVICE(&s->itu), sysbus_get_default());
-
+        sysbus_init_child_obj(OBJECT(dev), "itu", &s->itu, sizeof(s->itu=
),
+                              TYPE_MIPS_ITU);
         object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", &err);
         object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", &=
err);
         object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-pr=
esent",
@@ -115,9 +114,8 @@ static void mips_cps_realize(DeviceState *dev, Error =
**errp)
     }
=20
     /* Cluster Power Controller */
-    object_initialize(&s->cpc, sizeof(s->cpc), TYPE_MIPS_CPC);
-    qdev_set_parent_bus(DEVICE(&s->cpc), sysbus_get_default());
-
+    sysbus_init_child_obj(OBJECT(dev), "cpc", &s->cpc, sizeof(s->cpc),
+                          TYPE_MIPS_CPC);
     object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp", &err);
     object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running", &err=
);
     object_property_set_bool(OBJECT(&s->cpc), true, "realized", &err);
@@ -130,9 +128,8 @@ static void mips_cps_realize(DeviceState *dev, Error =
**errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cp=
c), 0));
=20
     /* Global Interrupt Controller */
-    object_initialize(&s->gic, sizeof(s->gic), TYPE_MIPS_GIC);
-    qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
-
+    sysbus_init_child_obj(OBJECT(dev), "gic", &s->gic, sizeof(s->gic),
+                          TYPE_MIPS_GIC);
     object_property_set_int(OBJECT(&s->gic), s->num_vp, "num-vp", &err);
     object_property_set_int(OBJECT(&s->gic), 128, "num-irq", &err);
     object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
@@ -147,9 +144,8 @@ static void mips_cps_realize(DeviceState *dev, Error =
**errp)
     /* Global Configuration Registers */
     gcr_base =3D env->CP0_CMGCRBase << 4;
=20
-    object_initialize(&s->gcr, sizeof(s->gcr), TYPE_MIPS_GCR);
-    qdev_set_parent_bus(DEVICE(&s->gcr), sysbus_get_default());
-
+    sysbus_init_child_obj(OBJECT(dev), "gcr", &s->gcr, sizeof(s->gcr),
+                          TYPE_MIPS_GCR);
     object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp", &err);
     object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev", &err);
     object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base", &err)=
;
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 04f2117d71..aff8464f2a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1151,8 +1151,8 @@ static void create_cps(MaltaState *s, const char *c=
pu_type,
 {
     Error *err =3D NULL;
=20
-    object_initialize(&s->cps, sizeof(s->cps), TYPE_MIPS_CPS);
-    qdev_set_parent_bus(DEVICE(&s->cps), sysbus_get_default());
+    sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->c=
ps),
+                          TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), cpu_type, "cpu-type", &err)=
;
     object_property_set_int(OBJECT(&s->cps), smp_cpus, "num-vp", &err);
     object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
--=20
2.18.0.rc1.1.g3f1ff2140


