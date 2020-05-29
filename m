Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C01C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DE6207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXySseTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DE6207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefNc-0008Op-DX
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKL-0002dX-4m
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKI-00070I-9t
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjBiZr01BOHeqF27fk7D/XvP7rYHi3WtnUH4hnCH27I=;
 b=TXySseTuhkz9wi1awNu4uU5x94qTz57qfkHjjzgYEn+jc/dWGXuS+exnYm6MJL6IBR3XkY
 2FTEJ87/+QfQu+D1svNU4m/zI9VjoLizjAH94ST5gcg8F66unkcyFvXgCkXlu+stEQMyT4
 BfJaL9n4399qHElBD2AvSZwiyY/tldI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-FI3x_zKOM2iJwozLrtB7JA-1; Fri, 29 May 2020 09:45:31 -0400
X-MC-Unique: FI3x_zKOM2iJwozLrtB7JA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D8E9835B40
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 227DD10013D4
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BE9C11358D2; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/58] isa: Convert uses of isa_create() with Coccinelle
Date: Fri, 29 May 2020 15:44:44 +0200
Message-Id: <20200529134523.8477-20-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace

    dev = isa_create(bus, type_name);
    ...
    qdev_init_nofail(dev);

by

    dev = isa_new(type_name);
    ...
    isa_realize_and_unref(dev, bus, &error_fatal);

Recent commit "qdev: New qdev_new(), qdev_realize(), etc." explains
why.

Coccinelle script:

    @@
    expression dev, bus, expr;
    expression list args;
    expression d;
    @@
    -    dev = isa_create(bus, args);
    +    dev = isa_new(args);
    (
         d = &dev->qdev;
    |
         d = DEVICE(dev);
    )
         ... when != dev = expr
    -    qdev_init_nofail(d);
    +    isa_realize_and_unref(dev, bus, &error_fatal);

    @@
    expression dev, bus, expr;
    expression list args;
    @@
    -    dev = isa_create(bus, args);
    +    dev = isa_new(args);
         ... when != dev = expr
    -    qdev_init_nofail(DEVICE(dev));
    +    isa_realize_and_unref(dev, bus, &error_fatal);

    @@
    expression dev, bus, expr;
    expression list args;
    @@
    -    dev = DEVICE(isa_create(bus, args));
    +    ISADevice *isa_dev; // TODO move
    +    isa_dev = isa_new(args);
    +    dev = DEVICE(isa_dev);
         ... when != dev = expr
    -    qdev_init_nofail(dev);
    +    isa_realize_and_unref(isa_dev, bus, &error_fatal);

Missing #include "qapi/error.h" added manually, whitespace changes
minimized manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/audio/pcspk.h |  5 +++--
 include/hw/timer/i8254.h |  9 +++++----
 hw/char/parallel-isa.c   |  5 +++--
 hw/char/serial-isa.c     |  4 ++--
 hw/dma/i8257.c           |  9 +++++----
 hw/ide/isa.c             |  5 +++--
 hw/intc/i8259_common.c   |  5 +++--
 hw/isa/isa-bus.c         |  4 ++--
 hw/isa/isa-superio.c     | 20 ++++++++++----------
 hw/ppc/prep.c            | 26 ++++++++++++++++----------
 hw/rtc/m48t59-isa.c      |  7 +++++--
 hw/rtc/mc146818rtc.c     |  4 ++--
 hw/sparc64/sun4u.c       |  6 ++++--
 13 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 632cce9f68..7e7f5f49dc 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -27,6 +27,7 @@
 
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "qapi/error.h"
 
 #define TYPE_PC_SPEAKER "isa-pcspk"
 
@@ -35,11 +36,11 @@ static inline ISADevice *pcspk_init(ISABus *bus, ISADevice *pit)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_create(bus, TYPE_PC_SPEAKER);
+    isadev = isa_new(TYPE_PC_SPEAKER);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "iobase", 0x61);
     object_property_set_link(OBJECT(dev), OBJECT(pit), "pit", NULL);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isadev, bus, &error_fatal);
 
     return isadev;
 }
diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 45cb42571f..e75b4a5a08 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -27,6 +27,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
+#include "qapi/error.h"
 
 #define PIT_FREQ 1193182
 
@@ -54,10 +55,10 @@ static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
     DeviceState *dev;
     ISADevice *d;
 
-    d = isa_create(bus, TYPE_I8254);
+    d = isa_new(TYPE_I8254);
     dev = DEVICE(d);
     qdev_prop_set_uint32(dev, "iobase", base);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(d, bus, &error_fatal);
     qdev_connect_gpio_out(dev, 0,
                           isa_irq >= 0 ? isa_get_irq(d, isa_irq) : alt_irq);
 
@@ -69,10 +70,10 @@ static inline ISADevice *kvm_pit_init(ISABus *bus, int base)
     DeviceState *dev;
     ISADevice *d;
 
-    d = isa_create(bus, TYPE_KVM_I8254);
+    d = isa_new(TYPE_KVM_I8254);
     dev = DEVICE(d);
     qdev_prop_set_uint32(dev, "iobase", base);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(d, bus, &error_fatal);
 
     return d;
 }
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index bcc577f61c..1ccbb96e70 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -14,17 +14,18 @@
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "hw/char/parallel.h"
+#include "qapi/error.h"
 
 static void parallel_init(ISABus *bus, int index, Chardev *chr)
 {
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_create(bus, "isa-parallel");
+    isadev = isa_new("isa-parallel");
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isadev, bus, &error_fatal);
 }
 
 void parallel_hds_isa_init(ISABus *bus, int n)
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index f9b6eed783..f13dd98c60 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -138,11 +138,11 @@ static void serial_isa_init(ISABus *bus, int index, Chardev *chr)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_create(bus, TYPE_ISA_SERIAL);
+    isadev = isa_new(TYPE_ISA_SERIAL);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "index", index);
     qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isadev, bus, &error_fatal);
 }
 
 void serial_hds_isa_init(ISABus *bus, int from, int to)
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 1b3435ab58..db808029b0 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
+#include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
@@ -638,21 +639,21 @@ void i8257_dma_init(ISABus *bus, bool high_page_enable)
     ISADevice *isa1, *isa2;
     DeviceState *d;
 
-    isa1 = isa_create(bus, TYPE_I8257);
+    isa1 = isa_new(TYPE_I8257);
     d = DEVICE(isa1);
     qdev_prop_set_int32(d, "base", 0x00);
     qdev_prop_set_int32(d, "page-base", 0x80);
     qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x480 : -1);
     qdev_prop_set_int32(d, "dshift", 0);
-    qdev_init_nofail(d);
+    isa_realize_and_unref(isa1, bus, &error_fatal);
 
-    isa2 = isa_create(bus, TYPE_I8257);
+    isa2 = isa_new(TYPE_I8257);
     d = DEVICE(isa2);
     qdev_prop_set_int32(d, "base", 0xc0);
     qdev_prop_set_int32(d, "page-base", 0x88);
     qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x488 : -1);
     qdev_prop_set_int32(d, "dshift", 1);
-    qdev_init_nofail(d);
+    isa_realize_and_unref(isa2, bus, &error_fatal);
 
     isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2));
 }
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 8395807b08..f28c8fba6c 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -27,6 +27,7 @@
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 
@@ -86,12 +87,12 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
     ISADevice *isadev;
     ISAIDEState *s;
 
-    isadev = isa_create(bus, TYPE_ISA_IDE);
+    isadev = isa_new(TYPE_ISA_IDE);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "iobase",  iobase);
     qdev_prop_set_uint32(dev, "iobase2", iobase2);
     qdev_prop_set_uint32(dev, "irq",     isairq);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isadev, bus, &error_fatal);
 
     s = ISA_IDE(dev);
     if (hd0) {
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 99f8f6abd5..d90b40fe4c 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -29,6 +29,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
+#include "qapi/error.h"
 
 static int irq_level[16];
 static uint64_t irq_count[16];
@@ -94,13 +95,13 @@ ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_create(bus, name);
+    isadev = isa_new(name);
     dev = DEVICE(isadev);
     qdev_prop_set_uint32(dev, "iobase", master ? 0x20 : 0xa0);
     qdev_prop_set_uint32(dev, "elcr_addr", master ? 0x4d0 : 0x4d1);
     qdev_prop_set_uint8(dev, "elcr_mask", master ? 0xf8 : 0xde);
     qdev_prop_set_bit(dev, "master", master);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isadev, bus, &error_fatal);
 
     return isadev;
 }
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index e6412d39b4..9a95ac3f96 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -190,8 +190,8 @@ ISADevice *isa_create_simple(ISABus *bus, const char *name)
 {
     ISADevice *dev;
 
-    dev = isa_create(bus, name);
-    qdev_init_nofail(DEVICE(dev));
+    dev = isa_new(name);
+    isa_realize_and_unref(dev, bus, &error_fatal);
     return dev;
 }
 
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 3dcdc234a4..d3d58f9f16 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -51,7 +51,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             } else {
                 name = g_strdup_printf("parallel%d", i);
             }
-            isa = isa_create(bus, "isa-parallel");
+            isa = isa_new("isa-parallel");
             d = DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->parallel.get_iobase) {
@@ -63,7 +63,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             }
             qdev_prop_set_chr(d, "chardev", chr);
             object_property_add_child(OBJECT(dev), name, OBJECT(isa));
-            qdev_init_nofail(d);
+            isa_realize_and_unref(isa, bus, &error_fatal);
             sio->parallel[i] = isa;
             trace_superio_create_parallel(i,
                                           k->parallel.get_iobase ?
@@ -90,7 +90,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             } else {
                 name = g_strdup_printf("serial%d", i);
             }
-            isa = isa_create(bus, TYPE_ISA_SERIAL);
+            isa = isa_new(TYPE_ISA_SERIAL);
             d = DEVICE(isa);
             qdev_prop_set_uint32(d, "index", i);
             if (k->serial.get_iobase) {
@@ -102,7 +102,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             }
             qdev_prop_set_chr(d, "chardev", chr);
             object_property_add_child(OBJECT(dev), name, OBJECT(isa));
-            qdev_init_nofail(d);
+            isa_realize_and_unref(isa, bus, &error_fatal);
             sio->serial[i] = isa;
             trace_superio_create_serial(i,
                                         k->serial.get_iobase ?
@@ -115,7 +115,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
 
     /* Floppy disc */
     if (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0)) {
-        isa = isa_create(bus, "isa-fdc");
+        isa = isa_new("isa-fdc");
         d = DEVICE(isa);
         if (k->floppy.get_iobase) {
             qdev_prop_set_uint32(d, "iobase", k->floppy.get_iobase(sio, 0));
@@ -136,7 +136,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
                                 &error_fatal);
         }
         object_property_add_child(OBJECT(sio), "isa-fdc", OBJECT(isa));
-        qdev_init_nofail(d);
+        isa_realize_and_unref(isa, bus, &error_fatal);
         sio->floppy = isa;
         trace_superio_create_floppy(0,
                                     k->floppy.get_iobase ?
@@ -146,14 +146,14 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     }
 
     /* Keyboard, mouse */
-    isa = isa_create(bus, TYPE_I8042);
+    isa = isa_new(TYPE_I8042);
     object_property_add_child(OBJECT(sio), TYPE_I8042, OBJECT(isa));
-    qdev_init_nofail(DEVICE(isa));
+    isa_realize_and_unref(isa, bus, &error_fatal);
     sio->kbc = isa;
 
     /* IDE */
     if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(sio, 0))) {
-        isa = isa_create(bus, "isa-ide");
+        isa = isa_new("isa-ide");
         d = DEVICE(isa);
         if (k->ide.get_iobase) {
             qdev_prop_set_uint32(d, "iobase", k->ide.get_iobase(sio, 0));
@@ -164,7 +164,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
         if (k->ide.get_irq) {
             qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
         }
-        qdev_init_nofail(d);
+        isa_realize_and_unref(isa, bus, &error_fatal);
         object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
         sio->ide = isa;
         trace_superio_create_ide(0,
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index c7af0e16c3..73a40b2cbe 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -244,6 +244,7 @@ static void ibm_40p_init(MachineState *machine)
     SysBusDevice *pcihost, *s;
     Nvram *m48t59 = NULL;
     PCIBus *pci_bus;
+    ISADevice *isa_dev;
     ISABus *isa_bus;
     void *fw_cfg;
     int i;
@@ -292,14 +293,16 @@ static void ibm_40p_init(MachineState *machine)
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
     /* Memory controller */
-    dev = DEVICE(isa_create(isa_bus, "rs6000-mc"));
+    isa_dev = isa_new("rs6000-mc");
+    dev = DEVICE(isa_dev);
     qdev_prop_set_uint32(dev, "ram-size", machine->ram_size);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
     /* RTC */
-    dev = DEVICE(isa_create(isa_bus, TYPE_MC146818_RTC));
+    isa_dev = isa_new(TYPE_MC146818_RTC);
+    dev = DEVICE(isa_dev);
     qdev_prop_set_int32(dev, "base_year", 1900);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
     /* initialize CMOS checksums */
     cmos_checksum = 0x6aa9;
@@ -310,19 +313,22 @@ static void ibm_40p_init(MachineState *machine)
     if (defaults_enabled()) {
         m48t59 = NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
 
-        dev = DEVICE(isa_create(isa_bus, "cs4231a"));
+        isa_dev = isa_new("cs4231a");
+        dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", 0x830);
         qdev_prop_set_uint32(dev, "irq", 10);
-        qdev_init_nofail(dev);
+        isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
-        dev = DEVICE(isa_create(isa_bus, "pc87312"));
+        isa_dev = isa_new("pc87312");
+        dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "config", 12);
-        qdev_init_nofail(dev);
+        isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
-        dev = DEVICE(isa_create(isa_bus, "prep-systemio"));
+        isa_dev = isa_new("prep-systemio");
+        dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
         qdev_prop_set_uint32(dev, "equipment", 0xc0);
-        qdev_init_nofail(dev);
+        isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
         dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
                                        "lsi53c810"));
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 131eb5b7d3..f641225301 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -28,6 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/rtc/m48t59.h"
 #include "m48t59-internal.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 
 #define TYPE_M48TXX_ISA "isa-m48txx"
@@ -70,10 +71,12 @@ Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
             continue;
         }
 
-        dev = DEVICE(isa_create(bus, m48txx_isa_info[i].bus_name));
+        ISADevice *isa_dev; // TODO move
+        isa_dev = isa_new(m48txx_isa_info[i].bus_name);
+        dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", io_base);
         qdev_prop_set_int32(dev, "base-year", base_year);
-        qdev_init_nofail(dev);
+        isa_realize_and_unref(isa_dev, bus, &error_fatal);
         return NVRAM(dev);
     }
 
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 9c30cbdcd7..1a31d71b5e 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -973,10 +973,10 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_create(bus, TYPE_MC146818_RTC);
+    isadev = isa_new(TYPE_MC146818_RTC);
     dev = DEVICE(isadev);
     qdev_prop_set_int32(dev, "base_year", base_year);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isadev, bus, &error_fatal);
     if (intercept_irq) {
         qdev_connect_gpio_out(dev, 0, intercept_irq);
     } else {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 0b898d6e3d..e791fb514a 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -338,7 +338,9 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     for (i = 0; i < MAX_FD; i++) {
         fd[i] = drive_get(IF_FLOPPY, 0, i);
     }
-    dev = DEVICE(isa_create(s->isa_bus, TYPE_ISA_FDC));
+    ISADevice *isa_dev; // TODO move
+    isa_dev = isa_new(TYPE_ISA_FDC);
+    dev = DEVICE(isa_dev);
     if (fd[0]) {
         qdev_prop_set_drive(dev, "driveA", blk_by_legacy_dinfo(fd[0]),
                             &error_abort);
@@ -348,7 +350,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
                             &error_abort);
     }
     qdev_prop_set_uint32(dev, "dma", -1);
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isa_dev, s->isa_bus, &error_fatal);
 
     /* Power */
     dev = qdev_new(TYPE_SUN4U_POWER);
-- 
2.21.3


