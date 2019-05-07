Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F67C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525FA205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525FA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO36a-0003cl-FD
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 12:38:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO34a-0001fk-7z
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO34Y-0002Pv-IJ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hO34U-0002KJ-Ax; Tue, 07 May 2019 12:36:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 680EE8046F;
	Tue,  7 May 2019 16:36:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B9C7E3DA5;
	Tue,  7 May 2019 16:35:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  7 May 2019 18:34:06 +0200
Message-Id: <20190507163416.24647-7-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-1-philmd@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 16:36:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/16] hw/arm/bcm2835: Use
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
---
 hw/arm/bcm2835_peripherals.c | 53 ++++++++++++++----------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 2931a82a25a..0fb54c7964e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -41,44 +41,36 @@ static void bcm2835_peripherals_init(Object *obj)
                        MBOX_CHAN_COUNT << MBOX_AS_CHAN_SHIFT);
=20
     /* Interrupt Controller */
-    object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
-    object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
-    qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
+    sysbus_init_child_obj(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835=
_IC);
=20
     /* UART0 */
-    object_initialize(&s->uart0, sizeof(s->uart0), TYPE_PL011);
-    object_property_add_child(obj, "uart0", OBJECT(&s->uart0), NULL);
-    qdev_set_parent_bus(DEVICE(&s->uart0), sysbus_get_default());
+    sysbus_init_child_obj(obj, "uart0", &s->uart0, sizeof(s->uart0),
+                          TYPE_PL011);
=20
     /* AUX / UART1 */
-    object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
-    object_property_add_child(obj, "aux", OBJECT(&s->aux), NULL);
-    qdev_set_parent_bus(DEVICE(&s->aux), sysbus_get_default());
+    sysbus_init_child_obj(obj, "aux", &s->aux, sizeof(s->aux),
+                          TYPE_BCM2835_AUX);
=20
     /* Mailboxes */
-    object_initialize(&s->mboxes, sizeof(s->mboxes), TYPE_BCM2835_MBOX);
-    object_property_add_child(obj, "mbox", OBJECT(&s->mboxes), NULL);
-    qdev_set_parent_bus(DEVICE(&s->mboxes), sysbus_get_default());
+    sysbus_init_child_obj(obj, "mbox", &s->mboxes, sizeof(s->mboxes),
+                          TYPE_BCM2835_MBOX);
=20
     object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
                                    OBJECT(&s->mbox_mr), &error_abort);
=20
     /* Framebuffer */
-    object_initialize(&s->fb, sizeof(s->fb), TYPE_BCM2835_FB);
-    object_property_add_child(obj, "fb", OBJECT(&s->fb), NULL);
+    sysbus_init_child_obj(obj, "fb", &s->fb, sizeof(s->fb), TYPE_BCM2835=
_FB);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-=
size",
                               &error_abort);
-    qdev_set_parent_bus(DEVICE(&s->fb), sysbus_get_default());
=20
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort)=
;
=20
     /* Property channel */
-    object_initialize(&s->property, sizeof(s->property), TYPE_BCM2835_PR=
OPERTY);
-    object_property_add_child(obj, "property", OBJECT(&s->property), NUL=
L);
+    sysbus_init_child_obj(obj, "property", &s->property, sizeof(s->prope=
rty),
+                          TYPE_BCM2835_PROPERTY);
     object_property_add_alias(obj, "board-rev", OBJECT(&s->property),
                               "board-rev", &error_abort);
-    qdev_set_parent_bus(DEVICE(&s->property), sysbus_get_default());
=20
     object_property_add_const_link(OBJECT(&s->property), "fb",
                                    OBJECT(&s->fb), &error_abort);
@@ -86,32 +78,27 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->gpu_bus_mr), &error_abort)=
;
=20
     /* Random Number Generator */
-    object_initialize(&s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
-    object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
-    qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
+    sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
+                          TYPE_BCM2835_RNG);
=20
     /* Extended Mass Media Controller */
-    object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
-    object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
-    qdev_set_parent_bus(DEVICE(&s->sdhci), sysbus_get_default());
+    sysbus_init_child_obj(obj, "sdhci", &s->sdhci, sizeof(s->sdhci),
+                          TYPE_SYSBUS_SDHCI);
=20
     /* SDHOST */
-    object_initialize(&s->sdhost, sizeof(s->sdhost), TYPE_BCM2835_SDHOST=
);
-    object_property_add_child(obj, "sdhost", OBJECT(&s->sdhost), NULL);
-    qdev_set_parent_bus(DEVICE(&s->sdhost), sysbus_get_default());
+    sysbus_init_child_obj(obj, "sdhost", &s->sdhost, sizeof(s->sdhost),
+                          TYPE_BCM2835_SDHOST);
=20
     /* DMA Channels */
-    object_initialize(&s->dma, sizeof(s->dma), TYPE_BCM2835_DMA);
-    object_property_add_child(obj, "dma", OBJECT(&s->dma), NULL);
-    qdev_set_parent_bus(DEVICE(&s->dma), sysbus_get_default());
+    sysbus_init_child_obj(obj, "dma", &s->dma, sizeof(s->dma),
+                          TYPE_BCM2835_DMA);
=20
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort)=
;
=20
     /* GPIO */
-    object_initialize(&s->gpio, sizeof(s->gpio), TYPE_BCM2835_GPIO);
-    object_property_add_child(obj, "gpio", OBJECT(&s->gpio), NULL);
-    qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
+    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
+                          TYPE_BCM2835_GPIO);
=20
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
                                    OBJECT(&s->sdhci.sdbus), &error_abort=
);
--=20
2.20.1


