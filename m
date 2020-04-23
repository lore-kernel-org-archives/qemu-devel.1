Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B19C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C519520781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C519520781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXlX-0002sF-Rb
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXje-0000lt-CL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjb-0001Dl-Ep
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:30 -0400
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14]:36688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jRXja-0001BX-2J
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:26 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:89cc:efc7:85ce:4669])
 by xavier.telenet-ops.be with bizsmtp
 id W91L2200R1RvcFS0191LFF; Thu, 23 Apr 2020 11:01:21 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0006kH-Bt; Thu, 23 Apr 2020 11:01:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0002vd-Aq; Thu, 23 Apr 2020 11:01:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartekgola@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH QEMU v2 4/5] ARM: PL061: Add gpiodev support
Date: Thu, 23 Apr 2020 11:01:17 +0200
Message-Id: <20200423090118.11199-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423090118.11199-1-geert+renesas@glider.be>
References: <20200423090118.11199-1-geert+renesas@glider.be>
Received-SPF: none client-ip=2a02:1800:120:4::f00:14;
 envelope-from=geert@linux-m68k.org; helo=xavier.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:1800:120:4::f00:14
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
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the PL061 GPIO controller user-creatable, and allow the user to tie
a newly created instance to a gpiochip on the host.

To create a new GPIO controller, the QEMU command line must be augmented
with:

    -device pl061,host=<gpiochip>

with <gpiochip> the name or label of the gpiochip on the host.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 hw/gpio/pl061.c | 35 +++++++++++++++++++++++++++++++++++
 qemu-options.hx |  9 +++++++++
 2 files changed, 44 insertions(+)

diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 74ba733a8a5e8ca5..98204f9a586ae8c8 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -12,11 +12,14 @@
 #include "hw/arm/fdt.h"
 #include "hw/gpio/pl061.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/gpiodev.h"
 
 //#define DEBUG_PL061 1
 
@@ -41,6 +44,9 @@ static const uint8_t pl061_id_luminary[12] =
 typedef struct PL061State {
     SysBusDevice parent_obj;
 
+#ifdef CONFIG_GPIODEV
+    char *host;
+#endif
     MemoryRegion iomem;
     uint32_t locked;
     uint32_t data;
@@ -370,10 +376,39 @@ static void pl061_init(Object *obj)
     qdev_init_gpio_out(dev, s->out, 8);
 }
 
+#ifdef CONFIG_GPIODEV
+static Property pl061_properties[] = {
+    DEFINE_PROP_STRING("host", PL061State, host),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pl061_realize(DeviceState *dev, Error **errp)
+{
+    PL061State *s = PL061(dev);
+
+    if (!dev->opts) {
+        /* Not created by user */
+        return;
+    }
+
+    if (!s->host) {
+        error_setg(errp, "'host' property is required");
+        return;
+    }
+
+    qemu_gpiodev_add(dev, s->host, 8, errp);
+}
+#endif /* CONFIG_GPIODEV */
+
 static void pl061_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+#ifdef CONFIG_GPIODEV
+    device_class_set_props(dc, pl061_properties);
+    dc->realize = pl061_realize;
+    dc->user_creatable = true;
+#endif
     dc->vmsd = &vmstate_pl061;
     dc->reset = &pl061_reset;
 }
diff --git a/qemu-options.hx b/qemu-options.hx
index 292d4e7c0cef6097..182de7fb63923b38 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -875,6 +875,15 @@ SRST
 ``-device isa-ipmi-bt,bmc=id[,ioport=val][,irq=val]``
     Like the KCS interface, but defines a BT interface. The default port
     is 0xe4 and the default interrupt is 5.
+
+#ifdef CONFIG_GPIODEV
+``-device pl061,host=gpiochip``
+    Add a PL061 GPIO controller, and map its virtual GPIO lines to a GPIO
+    controller on the host.
+
+    ``host=gpiochip``
+        The name or label of the GPIO controller on the host.
+#endif
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
2.17.1


