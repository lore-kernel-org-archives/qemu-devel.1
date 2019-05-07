Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA318C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689AE205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689AE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49877 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO39o-0006Z7-Hr
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 12:41:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO35k-00030P-Tg
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO35j-00047W-KP
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hO35g-00043G-Hm; Tue, 07 May 2019 12:37:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A3C688305;
	Tue,  7 May 2019 16:37:15 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E06493DA5;
	Tue,  7 May 2019 16:37:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  7 May 2019 18:34:10 +0200
Message-Id: <20190507163416.24647-11-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-1-philmd@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 16:37:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/16] hw/mips: Use object_initialize_child
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Joel Stanley <joel@jms.id.au>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/mips/boston.c     |  4 ++--
 hw/mips/cps.c        | 20 ++++++++------------
 hw/mips/mips_malta.c |  4 ++--
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index cb3ea85fdc1..1ffccc8da92 100644
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
index fc97f59af4c..649b35a76c5 100644
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
index 04f2117d71e..aff8464f2ac 100644
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
2.20.1


