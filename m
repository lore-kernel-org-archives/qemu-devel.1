Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0791C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A708D21848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A708D21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58889 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFKr-0005qL-Ut
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:54:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFCI-0007Be-AA
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFCC-0006RZ-LL
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUFC8-0006OR-Qz
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3E5881F19;
	Fri, 24 May 2019 18:45:30 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D81319C6A;
	Fri, 24 May 2019 18:45:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 24 May 2019 15:44:39 -0300
Message-Id: <20190524184447.16678-10-ehabkost@redhat.com>
In-Reply-To: <20190524184447.16678-1-ehabkost@redhat.com>
References: <20190524184447.16678-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 24 May 2019 18:45:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/17] hw/arm: Use object_initialize_child for
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

This patch was generated using the following Coccinelle script
(with a bit of manual fix-up for overly long lines):

 @use_object_initialize_child@
 expression parent_obj;
 expression child_ptr;
 expression child_name;
 expression child_type;
 expression child_size;
 expression errp;
 @@
 (
 -   object_initialize(child_ptr, child_size, child_type);
 +   object_initialize_child(parent_obj, child_name,  child_ptr, child_si=
ze,
 +                           child_type, &error_abort, NULL);
     ... when !=3D parent_obj
 -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr),=
 NULL);
     ...
 ?-  object_unref(OBJECT(child_ptr));
 |
 -   object_initialize(child_ptr, child_size, child_type);
 +   object_initialize_child(parent_obj, child_name,  child_ptr, child_si=
ze,
 +                            child_type, errp, NULL);
     ... when !=3D parent_obj
 -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr),=
 errp);
     ...
 ?-  object_unref(OBJECT(child_ptr));
 )

 @use_sysbus_init_child_obj@
 expression parent_obj;
 expression dev;
 expression child_ptr;
 expression child_name;
 expression child_type;
 expression child_size;
 expression errp;
 @@
 (
 -   object_initialize_child(parent_obj, child_name, child_ptr, child_siz=
e,
 -                           child_type, errp, NULL);
 +   sysbus_init_child_obj(parent_obj, child_name, child_ptr, child_size,
 +                         child_type);
     ...
 -   qdev_set_parent_bus(DEVICE(child_ptr), sysbus_get_default());
 |
 -   object_initialize_child(parent_obj, child_name, child_ptr, child_siz=
e,
 -                           child_type, errp, NULL);
 +   sysbus_init_child_obj(parent_obj, child_name, child_ptr, child_size,
 +                         child_type);
 -   dev =3D DEVICE(child_ptr);
 -   qdev_set_parent_bus(dev, sysbus_get_default());
 )

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
Message-Id: <20190507163416.24647-9-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/digic.c       | 17 ++++++-----------
 hw/arm/imx25_pdk.c   |  5 ++---
 hw/arm/kzm.c         |  5 ++---
 hw/arm/raspi.c       |  7 +++----
 hw/arm/sabrelite.c   |  5 ++---
 hw/arm/xlnx-zcu102.c |  5 ++---
 hw/arm/xlnx-zynqmp.c |  8 ++++----
 7 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 726abb9b48..6ef26c6bac 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -32,27 +32,22 @@
 static void digic_init(Object *obj)
 {
     DigicState *s =3D DIGIC(obj);
-    DeviceState *dev;
     int i;
=20
-    object_initialize(&s->cpu, sizeof(s->cpu), "arm946-" TYPE_ARM_CPU);
-    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
+    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
+                            "arm946-" TYPE_ARM_CPU, &error_abort, NULL);
=20
     for (i =3D 0; i < DIGIC4_NB_TIMERS; i++) {
 #define DIGIC_TIMER_NAME_MLEN    11
         char name[DIGIC_TIMER_NAME_MLEN];
=20
-        object_initialize(&s->timer[i], sizeof(s->timer[i]), TYPE_DIGIC_=
TIMER);
-        dev =3D DEVICE(&s->timer[i]);
-        qdev_set_parent_bus(dev, sysbus_get_default());
         snprintf(name, DIGIC_TIMER_NAME_MLEN, "timer[%d]", i);
-        object_property_add_child(obj, name, OBJECT(&s->timer[i]), NULL)=
;
+        sysbus_init_child_obj(obj, name, &s->timer[i], sizeof(s->timer[i=
]),
+                              TYPE_DIGIC_TIMER);
     }
=20
-    object_initialize(&s->uart, sizeof(s->uart), TYPE_DIGIC_UART);
-    dev =3D DEVICE(&s->uart);
-    qdev_set_parent_bus(dev, sysbus_get_default());
-    object_property_add_child(obj, "uart", OBJECT(&s->uart), NULL);
+    sysbus_init_child_obj(obj, "uart", &s->uart, sizeof(s->uart),
+                          TYPE_DIGIC_UART);
 }
=20
 static void digic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 9f3ee14739..eef1b184b0 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -72,9 +72,8 @@ static void imx25_pdk_init(MachineState *machine)
     unsigned int alias_offset;
     int i;
=20
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX25);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
+                            TYPE_FSL_IMX25, &error_abort, NULL);
=20
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_f=
atal);
=20
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 139934c4ec..44cba8782b 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -71,9 +71,8 @@ static void kzm_init(MachineState *machine)
     unsigned int alias_offset;
     unsigned int i;
=20
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX31);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
+                            TYPE_FSL_IMX31, &error_abort, NULL);
=20
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_f=
atal);
=20
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 2b5fe10e2f..8c249fcabb 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -182,10 +182,9 @@ static void raspi_init(MachineState *machine, int ve=
rsion)
         exit(1);
     }
=20
-    object_initialize(&s->soc, sizeof(s->soc),
-                      version =3D=3D 3 ? TYPE_BCM2837 : TYPE_BCM2836);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
+                            version =3D=3D 3 ? TYPE_BCM2837 : TYPE_BCM28=
36,
+                            &error_abort, NULL);
=20
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram"=
,
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index ee140e5d9e..f1b00de229 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -55,9 +55,8 @@ static void sabrelite_init(MachineState *machine)
         exit(1);
     }
=20
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX6);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
+                            TYPE_FSL_IMX6, &error_abort, NULL);
=20
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &err);
     if (err !=3D NULL) {
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index b6bc6a93b8..c802f26fbd 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -91,9 +91,8 @@ static void xlnx_zcu102_init(MachineState *machine)
     memory_region_allocate_system_memory(&s->ddr_ram, NULL, "ddr-ram",
                                          ram_size);
=20
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_XLNX_ZYNQMP);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
+                            TYPE_XLNX_ZYNQMP, &error_abort, NULL);
=20
     object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
                          "ddr-ram", &error_abort);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 4f8bc41d9d..6e99190302 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -191,10 +191,10 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState =
*s, const char *boot_cpu,
     for (i =3D 0; i < num_rpus; i++) {
         char *name;
=20
-        object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
-                          "cortex-r5f-" TYPE_ARM_CPU);
-        object_property_add_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
-                                  OBJECT(&s->rpu_cpu[i]), &error_abort);
+        object_initialize_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
+                                &s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
+                                "cortex-r5f-" TYPE_ARM_CPU, &error_abort=
,
+                                NULL);
=20
         name =3D object_get_canonical_path_component(OBJECT(&s->rpu_cpu[=
i]));
         if (strcmp(name, boot_cpu)) {
--=20
2.18.0.rc1.1.g3f1ff2140


