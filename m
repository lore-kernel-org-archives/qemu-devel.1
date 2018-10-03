Received: from eggs.gnu.org ([2001:4830:134:3::10]:52700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1g7j1q-0004E2-Mn
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1g7j1l-00056M-B3
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:25:34 -0400
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15]:60282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1g7j1k-00054W-3k
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:25:28 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed,  3 Oct 2018 17:25:21 +0200
Message-Id: <20181003152521.23144-1-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH QEMU POC] Add a GPIO backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bartekgola@gmail.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This is a Proof-of-Concept for a GPIO backend, which allows to connect
virtual GPIOs on the guest to physical GPIOs on the host.  This allows
the guest to control any external device connected to the physical
GPIOs.

Features and limitations:
  - The backend uses libgpiod on Linux,
  - For now only GPIO outputs are supported,
  - The frontend is currently hardcoded to be the PL061 GPIO controller
    on the arm virtual machine.  As the generic qdev_connect_gpio_out()
    API call is used, any virtual GPIO controller could do, though.

Future work:
  - Adding a user-instantiable GPIO frontend (or is any of the existing
    virtualized GPIO controllers already user-instantiable?),
  - Proper frontend/backend interface using IDs,
  - Adding a QEMU internal API for controlling multiple GPIOs at once,
  - Defining an API for GPIO paravirtualization,
  - ...

Example:
  To connect the first three GPIOs of the virtual PL061 GPIO controller
  to the GPIOs controlling the three LEDs on the Renesas Salvator-X(S)
  board, add the following to your qemu command invocation:

    -gpiodev e6055400.gpio,vgpios=0:1:2,gpios=11:12:13

  After that, the guest can cycle through the three LEDs using:

    for i in $(seq 504 506); do echo $i > /sys/class/gpio/export; done
    while /bin/true; do
        for i in $(seq 504 506); do
            echo high > /sys/class/gpio/gpio$i/direction
            sleep 1
            echo low > /sys/class/gpio/gpio$i/direction
        done
    done

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Thanks for your comments!
---
 backends/Makefile.objs   |   2 +
 backends/gpiodev.c       | 183 +++++++++++++++++++++++++++++++++++++++
 configure                |  29 +++++++
 hw/arm/virt.c            |   6 ++
 include/sysemu/gpiodev.h |  11 +++
 qemu-options.hx          |  20 +++++
 vl.c                     |  27 ++++++
 7 files changed, 278 insertions(+)
 create mode 100644 backends/gpiodev.c
 create mode 100644 include/sysemu/gpiodev.h

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 717fcbdae4715db1..2b5f68fedd40bea0 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -16,3 +16,5 @@ common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += \
 endif
 
 common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
+
+common-obj-$(CONFIG_GPIO) += gpiodev.o
diff --git a/backends/gpiodev.c b/backends/gpiodev.c
new file mode 100644
index 0000000000000000..8d90e150f5472463
--- /dev/null
+++ b/backends/gpiodev.c
@@ -0,0 +1,183 @@
+/*
+ * QEMU GPIO Backend
+ *
+ * Copyright (C) 2018 Glider bvba
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
+
+#include "sysemu/gpiodev.h"
+
+#include "hw/irq.h"
+#include "hw/qdev-core.h"
+
+DeviceState *the_pl061_dev;
+
+static void gpio_irq_handler(void *opaque, int n, int level)
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
+static int gpio_connect_line(unsigned int vgpio, struct gpiod_chip *chip,
+                             unsigned int gpio)
+{
+    const char *name = gpiod_chip_name(chip);
+    const char *label = gpiod_chip_label(chip);
+    struct gpiod_line *line;
+    qemu_irq irq;
+    int status;
+
+    if (!the_pl061_dev) {
+        error_report("PL061 GPIO controller not available");
+        return -1;
+    }
+
+    line = gpiod_chip_get_line(chip, gpio);
+    if (!line) {
+        error_report("%s/%s: Cannot obtain GPIO line %u: %s", name, label,
+                     gpio, strerror(errno));
+        return -1;
+    }
+
+    status = gpiod_line_request_output(line, "qemu", 0);
+    if (status < 0) {
+        error_report("%s/%s: Cannot request GPIO line %u for output: %s", name,
+                     label, gpio, strerror(errno));
+        return -1;
+    }
+
+    irq = qemu_allocate_irq(gpio_irq_handler, line, 0);
+    qdev_connect_gpio_out(the_pl061_dev, vgpio, irq);
+
+    info_report("%s/%s: Connected PL061 GPIO %u to GPIO line %u", name, label,
+                vgpio, gpio);
+    return 0;
+}
+
+static int gpio_count_gpios(const char *opt)
+{
+    unsigned int len = 0;
+    unsigned int n = 0;
+
+    do {
+        switch (*opt) {
+        case '0' ... '9':
+            len++;
+            break;
+
+        case ':':
+        case '\0':
+            if (!len) {
+                return -1;
+            }
+
+            n++;
+            len = 0;
+            break;
+
+        default:
+            return -1;
+        }
+    } while (*opt++);
+
+    return n;
+}
+
+int qemu_gpiodev_add(QemuOpts *opts)
+{
+    const char *name = qemu_opt_get(opts, "name");
+    const char *vgpios = qemu_opt_get(opts, "vgpios");
+    const char *gpios = qemu_opt_get(opts, "gpios");
+    unsigned int vgpio, gpio;
+    struct gpiod_chip *chip;
+    int n1, n2, i, status;
+
+    if (!name || !vgpios || !gpios) {
+        error_report("Missing parameters");
+        return -1;
+    }
+
+    n1 = gpio_count_gpios(vgpios);
+    if (n1 < 0) {
+        error_report("Invalid vgpios parameter");
+        return n1;
+    }
+
+    n2 = gpio_count_gpios(gpios);
+    if (n2 < 0) {
+        error_report("Invalid gpios parameter");
+        return n2;
+    }
+
+    if (n1 != n2) {
+        error_report("Number of vgpios and gpios do not match");
+        return -1;
+    }
+
+    chip = gpiod_chip_open_lookup(name);
+    if (!chip) {
+        error_report("Cannot open GPIO chip %s: %s", name, strerror(errno));
+        return -1;
+    }
+
+    for (i = 0; i < n1; i++, vgpios++, gpios++) {
+        qemu_strtoui(vgpios, &vgpios, 10, &vgpio);
+        qemu_strtoui(gpios, &gpios, 10, &gpio);
+
+        status = gpio_connect_line(vgpio, chip, gpio);
+        if (status) {
+            return status;
+        }
+    }
+
+    return 0;
+}
+
+static QemuOptsList qemu_gpiodev_opts = {
+    .name = "gpiodev",
+    .implied_opt_name = "name",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_gpiodev_opts.head),
+    .desc = {
+        {
+            .name = "name",
+            .type = QEMU_OPT_STRING,
+            .help = "Sets the GPIO chip specifier",
+        }, {
+            .name = "vgpios",
+            .type = QEMU_OPT_STRING,
+            .help = "Sets the list of virtual GPIO offsets",
+        }, {
+            .name = "gpios",
+            .type = QEMU_OPT_STRING,
+            .help = "Sets the list of physical GPIO offsets",
+        },
+        { /* end of list */ }
+    },
+};
+
+static void gpiodev_register_config(void)
+{
+    qemu_add_opts(&qemu_gpiodev_opts);
+}
+
+opts_init(gpiodev_register_config);
diff --git a/configure b/configure
index f3d4b799a5b08b1d..eec12eb766e28959 100755
--- a/configure
+++ b/configure
@@ -476,6 +476,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
+gpio=""
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1444,6 +1445,10 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
+  --disable-gpio) gpio="no"
+  ;;
+  --enable-gpio) gpio="yes"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1721,6 +1726,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
   libpmem         libpmem support
+  gpio            gpio support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -5632,6 +5638,24 @@ if test "$libpmem" != "no"; then
 	fi
 fi
 
+##########################################
+# check for libgpiod
+
+if test "$gpio" != "no"; then
+	if $pkg_config --exists "libgpiod"; then
+		gpio="yes"
+		libgpiod_libs=$($pkg_config --libs libgpiod)
+		libgpiod_cflags=$($pkg_config --cflags libgpiod)
+		libs_softmmu="$libs_softmmu $libgpiod_libs"
+		QEMU_CFLAGS="$QEMU_CFLAGS $libgpiod_cflags"
+	else
+		if test "$gpio" = "yes" ; then
+			feature_not_found "gpio" "Install libgpiod"
+		fi
+		gpio="no"
+	fi
+fi
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -6102,6 +6126,7 @@ echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
+echo "gpio support      $gpio"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6863,6 +6888,10 @@ if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
 fi
 
+if test "$gpio" = "yes" ; then
+  echo "CONFIG_GPIO=y" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b57f87abcbfd54b..78585e11c8d7dfa8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -40,6 +40,7 @@
 #include "hw/devices.h"
 #include "net/net.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/gpiodev.h"
 #include "sysemu/numa.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
@@ -761,6 +762,11 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
     const char compat[] = "arm,pl061\0arm,primecell";
 
     pl061_dev = sysbus_create_simple("pl061", base, pic[irq]);
+#ifdef CONFIG_GPIO
+    if (!the_pl061_dev) {
+        the_pl061_dev = pl061_dev;
+    }
+#endif
 
     uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
     nodename = g_strdup_printf("/pl061@%" PRIx64, base);
diff --git a/include/sysemu/gpiodev.h b/include/sysemu/gpiodev.h
new file mode 100644
index 0000000000000000..a5168bd90f53efa0
--- /dev/null
+++ b/include/sysemu/gpiodev.h
@@ -0,0 +1,11 @@
+/*
+ * QEMU GPIO Backend
+ *
+ * Copyright (C) 2018 Glider bvba
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+extern DeviceState *the_pl061_dev;
+
+int qemu_gpiodev_add(QemuOpts *opts);
diff --git a/qemu-options.hx b/qemu-options.hx
index f139459e802a3185..6bbcc062b09c9053 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2903,6 +2903,26 @@ DEFHEADING()
 
 #endif
 
+#ifdef CONFIG_GPIO
+DEFHEADING(GPIO device options:)
+
+DEF("gpiodev", HAS_ARG, QEMU_OPTION_gpiodev,
+    "-gpiodev gpiochip,vgpios=x:y:...:z,gpios=x:y:...:z\n", QEMU_ARCH_ALL)
+STEXI
+@item -gpiodev @var{gpiochip},vgpios=@var{vgpios},gpios=@var{gpios}
+@findef -gpiodev
+Define a new GPIO device. Valid options are:
+@table @option
+@item @var{gpiochip}
+This option specifies the GPIO chip to map virtual gpios to.
+@item vgpios=@var{vgpios}
+Specifies an array of virtual GPIOs to be mapped to physical GPIOs.
+@item gpios=@var{gpios}
+Specifies an array of physical GPIOs to be used as mapping targets.
+@end table
+ETEXI
+#endif
+
 DEFHEADING(Linux/Multiboot boot specific:)
 STEXI
 
diff --git a/vl.c b/vl.c
index 0388852deb9e5be3..110b88d1d821cb91 100644
--- a/vl.c
+++ b/vl.c
@@ -102,6 +102,9 @@ int main(int argc, char **argv)
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
 #endif
+#ifdef CONFIG_GPIO
+#include "sysemu/gpiodev.h"
+#endif
 #include "sysemu/qtest.h"
 
 #include "disas/disas.h"
@@ -2259,6 +2262,14 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 }
 #endif
 
+#ifdef CONFIG_GPIO
+static int gpiodev_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+
+    return qemu_gpiodev_add(opts);
+}
+#endif
+
 static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Chardev *chr;
@@ -3333,6 +3344,15 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+#ifdef CONFIG_GPIO
+            case QEMU_OPTION_gpiodev:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("gpiodev"),
+                                               optarg, true);
+                if (!opts) {
+                    exit(1);
+                }
+                break;
+#endif
             case QEMU_OPTION_virtfs: {
                 QemuOpts *fsdev;
                 QemuOpts *device;
@@ -4470,6 +4490,13 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+#ifdef CONFIG_GPIO
+    if (qemu_opts_foreach(qemu_find_opts("gpiodev"),
+                          gpiodev_init_func, NULL, NULL)) {
+        exit(1);
+    }
+#endif
+
     cpu_synchronize_all_post_init();
 
     rom_reset_order_override();
-- 
2.17.1
