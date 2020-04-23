Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8852C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6332075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6332075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXlk-00032K-IB
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjd-0000kL-CY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjb-0001DC-9r
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:28 -0400
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15]:34546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jRXja-0001Bi-2O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:26 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:89cc:efc7:85ce:4669])
 by andre.telenet-ops.be with bizsmtp
 id W91L2200g1RvcFS0191LLo; Thu, 23 Apr 2020 11:01:21 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0006kC-BF; Thu, 23 Apr 2020 11:01:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0002vY-AD; Thu, 23 Apr 2020 11:01:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartekgola@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH QEMU v2 3/5] Add a GPIO backend using libgpiod
Date: Thu, 23 Apr 2020 11:01:16 +0200
Message-Id: <20200423090118.11199-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423090118.11199-1-geert+renesas@glider.be>
References: <20200423090118.11199-1-geert+renesas@glider.be>
Received-SPF: none client-ip=2a02:1800:120:4::f00:15;
 envelope-from=geert@linux-m68k.org; helo=andre.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:1800:120:4::f00:15
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

Add a GPIO controller backend, to connect virtual GPIOs on the guest to
physical GPIOs on the host.  This allows the guest to control any
external device connected to the physical GPIOs.

Features and limitations:
  - The backend uses libgpiod on Linux,
  - For now only GPIO outputs are supported,
  - The number of GPIO lines mapped is limited to the number of GPIO
    lines available on the virtual GPIO controller.

Future work:
  - GPIO inputs,
  - GPIO line configuration,
  - Optimizations for controlling multiple GPIO lines at once,
  - ...

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop vgpios and gpios parameters, and map the full gpiochip instead,
  - Replace hardcoded PL061 instance by multiple dynamic instances,
    registered through qemu_gpiodev_add().
---
 MAINTAINERS              |  6 +++
 backends/Makefile.objs   |  2 +
 backends/gpiodev.c       | 94 ++++++++++++++++++++++++++++++++++++++++
 configure                | 28 ++++++++++++
 include/sysemu/gpiodev.h | 12 +++++
 5 files changed, 142 insertions(+)
 create mode 100644 backends/gpiodev.c
 create mode 100644 include/sysemu/gpiodev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e760f65270d29d5d..a70af47430083d14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -607,6 +607,12 @@ F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
 
+GPIO device backend
+M: Geert Uytterhoeven <geert+renesas@glider.be>
+S: Supported
+F: backends/gpiodev.c
+F: include/sysemu/gpiodev.h
+
 Goldfish RTC
 M: Anup Patel <anup.patel@wdc.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 28a847cd571d96ed..ee658e797454119a 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -21,3 +21,5 @@ common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
 common-obj-$(CONFIG_GIO) += dbus-vmstate.o
 dbus-vmstate.o-cflags = $(GIO_CFLAGS)
 dbus-vmstate.o-libs = $(GIO_LIBS)
+
+common-obj-$(CONFIG_GPIODEV) += gpiodev.o
diff --git a/backends/gpiodev.c b/backends/gpiodev.c
new file mode 100644
index 0000000000000000..df1bd0113c7b2985
--- /dev/null
+++ b/backends/gpiodev.c
@@ -0,0 +1,94 @@
+/*
+ * QEMU GPIO Backend
+ *
+ * Copyright (C) 2018-2020 Glider bv
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <errno.h>
+#include <gpiod.h>
+
+#include "qemu/osdep.h"
+#include "qemu/config-file.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qapi/error.h"
+
+#include "sysemu/gpiodev.h"
+
+#include "hw/irq.h"
+#include "hw/qdev-core.h"
+
+static void gpiodev_irq_handler(void *opaque, int n, int level)
+{
+    struct gpiod_line *line = opaque;
+    int status;
+
+    status = gpiod_line_set_value(line, level);
+    if (status < 0) {
+        struct gpiod_chip *chip = gpiod_line_get_chip(line);
+
+        error_report("%s/%s: Cannot set GPIO line %u: %s",
+                     gpiod_chip_name(chip), gpiod_chip_label(chip),
+                     gpiod_line_offset(line), strerror(errno));
+    }
+}
+
+static int gpiodev_map_line(DeviceState *dev, struct gpiod_chip *chip,
+                            unsigned int gpio, Error **errp)
+{
+    struct gpiod_line *line;
+    qemu_irq irq;
+    int status;
+
+    line = gpiod_chip_get_line(chip, gpio);
+    if (!line) {
+        error_setg(errp, "Cannot obtain GPIO line %u: %s", gpio,
+                   strerror(errno));
+        return -1;
+    }
+
+    status = gpiod_line_request_output(line, "qemu", 0);
+    if (status < 0) {
+        error_setg(errp, "Cannot request GPIO line %u for output: %s", gpio,
+                   strerror(errno));
+        return status;
+    }
+
+    irq = qemu_allocate_irq(gpiodev_irq_handler, line, 0);
+    qdev_connect_gpio_out(dev, gpio, irq);
+    return 0;
+}
+
+void qemu_gpiodev_add(DeviceState *dev, const char *name, unsigned int maxgpio,
+                      Error **errp)
+{
+    struct gpiod_chip *chip;
+    unsigned int i, n;
+    int status;
+
+    chip = gpiod_chip_open_lookup(name);
+    if (!chip) {
+        error_setg(errp, "Cannot open GPIO chip %s: %s", name,
+                   strerror(errno));
+        return;
+    }
+
+    n = gpiod_chip_num_lines(chip);
+    if (n > maxgpio) {
+        warn_report("Last %u GPIO line(s) will not be mapped", n - maxgpio);
+        n = maxgpio;
+    }
+
+    for (i = 0; i < n; i++) {
+        status = gpiodev_map_line(dev, chip, i, errp);
+        if (status < 0) {
+            return;
+        }
+    }
+
+    info_report("Mapped %u GPIO lines", n);
+}
diff --git a/configure b/configure
index 23b5e93752b6a259..8b133402ef727c8e 100755
--- a/configure
+++ b/configure
@@ -509,6 +509,7 @@ libpmem=""
 default_devices="yes"
 plugins="no"
 fuzzing="no"
+gpio=""
 
 supported_cpu="no"
 supported_os="no"
@@ -1601,6 +1602,10 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --disable-gpio) gpio="no"
+  ;;
+  --enable-gpio) gpio="yes"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1894,6 +1899,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   debug-mutex     mutex debugging support
   libpmem         libpmem support
   xkbcommon       xkbcommon support
+  gpio            gpio support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6250,6 +6256,23 @@ case "$slirp" in
     ;;
 esac
 
+##########################################
+# check for libgpiod
+
+if test "$gpio" != "no"; then
+    if $pkg_config --exists "libgpiod"; then
+        gpio="yes"
+        libgpiod_libs=$($pkg_config --libs libgpiod)
+        libgpiod_cflags=$($pkg_config --cflags libgpiod)
+        libs_softmmu="$libs_softmmu $libgpiod_libs"
+        QEMU_CFLAGS="$QEMU_CFLAGS $libgpiod_cflags"
+    else
+        if test "$gpio" = "yes" ; then
+            feature_not_found "gpio" "Install libgpiod"
+        fi
+        gpio="no"
+    fi
+fi
 
 ##########################################
 # End of CC checks
@@ -6733,6 +6756,7 @@ echo "default devices   $default_devices"
 echo "plugin support    $plugins"
 echo "fuzzing support   $fuzzing"
 echo "gdb               $gdb_bin"
+echo "gpio support      $gpio"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7614,6 +7638,10 @@ if test -n "$gdb_bin" ; then
     echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
 fi
 
+if test "$gpio" = "yes" ; then
+  echo "CONFIG_GPIODEV=y" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
diff --git a/include/sysemu/gpiodev.h b/include/sysemu/gpiodev.h
new file mode 100644
index 0000000000000000..bedd141001245207
--- /dev/null
+++ b/include/sysemu/gpiodev.h
@@ -0,0 +1,12 @@
+/*
+ * QEMU GPIO Backend
+ *
+ * Copyright (C) 2018-2020 Glider bv
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/typedefs.h"
+
+void qemu_gpiodev_add(DeviceState *dev, const char *name, unsigned int maxgpio,
+                      Error **errp);
-- 
2.17.1


