Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2734C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB3F2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB3F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYO6-0006jS-Tz
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:15:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYM8-0005Hu-6N
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYM6-0001CF-Ed
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:08 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:45128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUYM6-00018j-6n
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:06 -0400
Received: from player698.ha.ovh.net (unknown [10.109.146.76])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id A456E10128E
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 17:13:03 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id 82AB6625A6FD;
	Sat, 25 May 2019 15:12:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 17:12:23 +0200
Message-Id: <20190525151241.5017-2-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525151241.5017-1-clg@kaod.org>
References: <20190525151241.5017-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6592988382810508049
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddukedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.159
Subject: [Qemu-devel] [PATCH 01/19] hw/arm/aspeed: Use
 object_initialize_child for correct ref. counting
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
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
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-Id: <20190507163416.24647-8-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/aspeed.c     |  6 +++---
 hw/arm/aspeed_soc.c | 50 ++++++++++++++++++---------------------------
 2 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 415cff7a015d..33070a6df843 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -160,9 +160,9 @@ static void aspeed_board_init(MachineState *machine,
     ram_addr_t max_ram_size;
=20
     bmc =3D g_new0(AspeedBoardState, 1);
-    object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&bmc->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
+                            (sizeof(bmc->soc)), cfg->soc_name, &error_ab=
ort,
+                            NULL);
=20
     sc =3D ASPEED_SOC_GET_CLASS(&bmc->soc);
=20
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a27233d4876b..faff42b84ad1 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -106,12 +106,11 @@ static void aspeed_soc_init(Object *obj)
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
     int i;
=20
-    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
-    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
+    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cpu),
+                            sc->info->cpu_type, &error_abort, NULL);
=20
-    object_initialize(&s->scu, sizeof(s->scu), TYPE_ASPEED_SCU);
-    object_property_add_child(obj, "scu", OBJECT(&s->scu), NULL);
-    qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
+    sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
+                          TYPE_ASPEED_SCU);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->info->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
@@ -121,36 +120,29 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key", &error_abort);
=20
-    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
-    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
-    qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
+    sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic),
+                          TYPE_ASPEED_VIC);
=20
-    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_T=
IMER);
-    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), N=
ULL);
+    sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
+                          sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
                                    OBJECT(&s->scu), &error_abort);
-    qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
=20
-    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
-    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
-    qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
+    sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
+                          TYPE_ASPEED_I2C);
=20
-    object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
-    object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
-    qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
+    sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
+                          sc->info->fmc_typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
=20
     for (i =3D 0; i < sc->info->spis_num; i++) {
-        object_initialize(&s->spi[i], sizeof(s->spi[i]),
-                          sc->info->spi_typename[i]);
-        object_property_add_child(obj, "spi[*]", OBJECT(&s->spi[i]), NUL=
L);
-        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
+                              sizeof(s->spi[i]), sc->info->spi_typename[=
i]);
     }
=20
-    object_initialize(&s->sdmc, sizeof(s->sdmc), TYPE_ASPEED_SDMC);
-    object_property_add_child(obj, "sdmc", OBJECT(&s->sdmc), NULL);
-    qdev_set_parent_bus(DEVICE(&s->sdmc), sysbus_get_default());
+    sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc)=
,
+                          TYPE_ASPEED_SDMC);
     qdev_prop_set_uint32(DEVICE(&s->sdmc), "silicon-rev",
                          sc->info->silicon_rev);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
@@ -159,16 +151,14 @@ static void aspeed_soc_init(Object *obj)
                               "max-ram-size", &error_abort);
=20
     for (i =3D 0; i < sc->info->wdts_num; i++) {
-        object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_WDT=
);
-        object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), NUL=
L);
-        qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
+                              sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
         qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
                                     sc->info->silicon_rev);
     }
=20
-    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC10=
0);
-    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100), N=
ULL);
-    qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());
+    sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
+                          sizeof(s->ftgmac100), TYPE_FTGMAC100);
 }
=20
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
--=20
2.20.1


