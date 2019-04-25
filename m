Received: from eggs.gnu.org ([209.51.188.92]:39632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYU-0005l6-2V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYP-0007Es-5R
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJkYM-0005pa-Pl
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 17:00:48 -0300
Message-Id: <20190425200051.19906-2-ehabkost@redhat.com>
In-Reply-To: <20190425200051.19906-1-ehabkost@redhat.com>
References: <20190425200051.19906-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] machine: Move gpio code to hw/core/gpio.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Like Xu <like.xu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>

Only softmmu code uses gpio, so move gpio code from qdev.c to
gpio.c and compile it only on softmmu mode.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/gpio.c        | 206 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c        | 184 -------------------------------------
 hw/core/Makefile.objs |   1 +
 3 files changed, 207 insertions(+), 184 deletions(-)
 create mode 100644 hw/core/gpio.c

diff --git a/hw/core/gpio.c b/hw/core/gpio.c
new file mode 100644
index 0000000000..2724b4d7e7
--- /dev/null
+++ b/hw/core/gpio.c
@@ -0,0 +1,206 @@
+/*
+ * qdev GPIO helpers
+ *
+ *  Copyright (c) 2009 CodeSourcery
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+#include "qapi/error.h"
+
+static NamedGPIOList *qdev_get_named_gpio_list(DeviceState *dev,
+                                               const char *name)
+{
+    NamedGPIOList *ngl;
+
+    QLIST_FOREACH(ngl, &dev->gpios, node) {
+        /* NULL is a valid and matchable name, otherwise do a normal
+         * strcmp match.
+         */
+        if ((!ngl->name && !name) ||
+                (name && ngl->name && strcmp(name, ngl->name) == 0)) {
+            return ngl;
+        }
+    }
+
+    ngl = g_malloc0(sizeof(*ngl));
+    ngl->name = g_strdup(name);
+    QLIST_INSERT_HEAD(&dev->gpios, ngl, node);
+    return ngl;
+}
+
+void qdev_init_gpio_in_named_with_opaque(DeviceState *dev,
+                                         qemu_irq_handler handler,
+                                         void *opaque,
+                                         const char *name, int n)
+{
+    int i;
+    NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
+
+    assert(gpio_list->num_out == 0 || !name);
+    gpio_list->in = qemu_extend_irqs(gpio_list->in, gpio_list->num_in, handler,
+                                     opaque, n);
+
+    if (!name) {
+        name = "unnamed-gpio-in";
+    }
+    for (i = gpio_list->num_in; i < gpio_list->num_in + n; i++) {
+        gchar *propname = g_strdup_printf("%s[%u]", name, i);
+
+        object_property_add_child(OBJECT(dev), propname,
+                                  OBJECT(gpio_list->in[i]), &error_abort);
+        g_free(propname);
+    }
+
+    gpio_list->num_in += n;
+}
+
+void qdev_init_gpio_in(DeviceState *dev, qemu_irq_handler handler, int n)
+{
+    qdev_init_gpio_in_named(dev, handler, NULL, n);
+}
+
+void qdev_init_gpio_out_named(DeviceState *dev, qemu_irq *pins,
+                              const char *name, int n)
+{
+    int i;
+    NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
+
+    assert(gpio_list->num_in == 0 || !name);
+
+    if (!name) {
+        name = "unnamed-gpio-out";
+    }
+    memset(pins, 0, sizeof(*pins) * n);
+    for (i = 0; i < n; ++i) {
+        gchar *propname = g_strdup_printf("%s[%u]", name,
+                                          gpio_list->num_out + i);
+
+        object_property_add_link(OBJECT(dev), propname, TYPE_IRQ,
+                                 (Object **)&pins[i],
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_STRONG,
+                                 &error_abort);
+        g_free(propname);
+    }
+    gpio_list->num_out += n;
+}
+
+void qdev_init_gpio_out(DeviceState *dev, qemu_irq *pins, int n)
+{
+    qdev_init_gpio_out_named(dev, pins, NULL, n);
+}
+
+qemu_irq qdev_get_gpio_in_named(DeviceState *dev, const char *name, int n)
+{
+    NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
+
+    assert(n >= 0 && n < gpio_list->num_in);
+    return gpio_list->in[n];
+}
+
+qemu_irq qdev_get_gpio_in(DeviceState *dev, int n)
+{
+    return qdev_get_gpio_in_named(dev, NULL, n);
+}
+
+void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
+                                 qemu_irq pin)
+{
+    char *propname = g_strdup_printf("%s[%d]",
+                                     name ? name : "unnamed-gpio-out", n);
+    if (pin) {
+        /* We need a name for object_property_set_link to work.  If the
+         * object has a parent, object_property_add_child will come back
+         * with an error without doing anything.  If it has none, it will
+         * never fail.  So we can just call it with a NULL Error pointer.
+         */
+        object_property_add_child(container_get(qdev_get_machine(),
+                                                "/unattached"),
+                                  "non-qdev-gpio[*]", OBJECT(pin), NULL);
+    }
+    object_property_set_link(OBJECT(dev), OBJECT(pin), propname, &error_abort);
+    g_free(propname);
+}
+
+qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
+{
+    char *propname = g_strdup_printf("%s[%d]",
+                                     name ? name : "unnamed-gpio-out", n);
+
+    qemu_irq ret = (qemu_irq)object_property_get_link(OBJECT(dev), propname,
+                                                      NULL);
+
+    return ret;
+}
+
+/* disconnect a GPIO output, returning the disconnected input (if any) */
+
+static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
+                                               const char *name, int n)
+{
+    char *propname = g_strdup_printf("%s[%d]",
+                                     name ? name : "unnamed-gpio-out", n);
+
+    qemu_irq ret = (qemu_irq)object_property_get_link(OBJECT(dev), propname,
+                                                      NULL);
+    if (ret) {
+        object_property_set_link(OBJECT(dev), NULL, propname, NULL);
+    }
+    g_free(propname);
+    return ret;
+}
+
+qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
+                                 const char *name, int n)
+{
+    qemu_irq disconnected = qdev_disconnect_gpio_out_named(dev, name, n);
+    qdev_connect_gpio_out_named(dev, name, n, icpt);
+    return disconnected;
+}
+
+void qdev_connect_gpio_out(DeviceState * dev, int n, qemu_irq pin)
+{
+    qdev_connect_gpio_out_named(dev, NULL, n, pin);
+}
+
+void qdev_pass_gpios(DeviceState *dev, DeviceState *container,
+                     const char *name)
+{
+    int i;
+    NamedGPIOList *ngl = qdev_get_named_gpio_list(dev, name);
+
+    for (i = 0; i < ngl->num_in; i++) {
+        const char *nm = ngl->name ? ngl->name : "unnamed-gpio-in";
+        char *propname = g_strdup_printf("%s[%d]", nm, i);
+
+        object_property_add_alias(OBJECT(container), propname,
+                                  OBJECT(dev), propname,
+                                  &error_abort);
+        g_free(propname);
+    }
+    for (i = 0; i < ngl->num_out; i++) {
+        const char *nm = ngl->name ? ngl->name : "unnamed-gpio-out";
+        char *propname = g_strdup_printf("%s[%d]", nm, i);
+
+        object_property_add_alias(OBJECT(container), propname,
+                                  OBJECT(dev), propname,
+                                  &error_abort);
+        g_free(propname);
+    }
+    QLIST_REMOVE(ngl, node);
+    QLIST_INSERT_HEAD(&container->gpios, ngl, node);
+}
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f9b6efe509..f73e7ded1a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -346,190 +346,6 @@ BusState *qdev_get_parent_bus(DeviceState *dev)
     return dev->parent_bus;
 }
 
-static NamedGPIOList *qdev_get_named_gpio_list(DeviceState *dev,
-                                               const char *name)
-{
-    NamedGPIOList *ngl;
-
-    QLIST_FOREACH(ngl, &dev->gpios, node) {
-        /* NULL is a valid and matchable name, otherwise do a normal
-         * strcmp match.
-         */
-        if ((!ngl->name && !name) ||
-                (name && ngl->name && strcmp(name, ngl->name) == 0)) {
-            return ngl;
-        }
-    }
-
-    ngl = g_malloc0(sizeof(*ngl));
-    ngl->name = g_strdup(name);
-    QLIST_INSERT_HEAD(&dev->gpios, ngl, node);
-    return ngl;
-}
-
-void qdev_init_gpio_in_named_with_opaque(DeviceState *dev,
-                                         qemu_irq_handler handler,
-                                         void *opaque,
-                                         const char *name, int n)
-{
-    int i;
-    NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
-
-    assert(gpio_list->num_out == 0 || !name);
-    gpio_list->in = qemu_extend_irqs(gpio_list->in, gpio_list->num_in, handler,
-                                     opaque, n);
-
-    if (!name) {
-        name = "unnamed-gpio-in";
-    }
-    for (i = gpio_list->num_in; i < gpio_list->num_in + n; i++) {
-        gchar *propname = g_strdup_printf("%s[%u]", name, i);
-
-        object_property_add_child(OBJECT(dev), propname,
-                                  OBJECT(gpio_list->in[i]), &error_abort);
-        g_free(propname);
-    }
-
-    gpio_list->num_in += n;
-}
-
-void qdev_init_gpio_in(DeviceState *dev, qemu_irq_handler handler, int n)
-{
-    qdev_init_gpio_in_named(dev, handler, NULL, n);
-}
-
-void qdev_init_gpio_out_named(DeviceState *dev, qemu_irq *pins,
-                              const char *name, int n)
-{
-    int i;
-    NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
-
-    assert(gpio_list->num_in == 0 || !name);
-
-    if (!name) {
-        name = "unnamed-gpio-out";
-    }
-    memset(pins, 0, sizeof(*pins) * n);
-    for (i = 0; i < n; ++i) {
-        gchar *propname = g_strdup_printf("%s[%u]", name,
-                                          gpio_list->num_out + i);
-
-        object_property_add_link(OBJECT(dev), propname, TYPE_IRQ,
-                                 (Object **)&pins[i],
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG,
-                                 &error_abort);
-        g_free(propname);
-    }
-    gpio_list->num_out += n;
-}
-
-void qdev_init_gpio_out(DeviceState *dev, qemu_irq *pins, int n)
-{
-    qdev_init_gpio_out_named(dev, pins, NULL, n);
-}
-
-qemu_irq qdev_get_gpio_in_named(DeviceState *dev, const char *name, int n)
-{
-    NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
-
-    assert(n >= 0 && n < gpio_list->num_in);
-    return gpio_list->in[n];
-}
-
-qemu_irq qdev_get_gpio_in(DeviceState *dev, int n)
-{
-    return qdev_get_gpio_in_named(dev, NULL, n);
-}
-
-void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
-                                 qemu_irq pin)
-{
-    char *propname = g_strdup_printf("%s[%d]",
-                                     name ? name : "unnamed-gpio-out", n);
-    if (pin) {
-        /* We need a name for object_property_set_link to work.  If the
-         * object has a parent, object_property_add_child will come back
-         * with an error without doing anything.  If it has none, it will
-         * never fail.  So we can just call it with a NULL Error pointer.
-         */
-        object_property_add_child(container_get(qdev_get_machine(),
-                                                "/unattached"),
-                                  "non-qdev-gpio[*]", OBJECT(pin), NULL);
-    }
-    object_property_set_link(OBJECT(dev), OBJECT(pin), propname, &error_abort);
-    g_free(propname);
-}
-
-qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
-{
-    char *propname = g_strdup_printf("%s[%d]",
-                                     name ? name : "unnamed-gpio-out", n);
-
-    qemu_irq ret = (qemu_irq)object_property_get_link(OBJECT(dev), propname,
-                                                      NULL);
-
-    return ret;
-}
-
-/* disconnect a GPIO output, returning the disconnected input (if any) */
-
-static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
-                                               const char *name, int n)
-{
-    char *propname = g_strdup_printf("%s[%d]",
-                                     name ? name : "unnamed-gpio-out", n);
-
-    qemu_irq ret = (qemu_irq)object_property_get_link(OBJECT(dev), propname,
-                                                      NULL);
-    if (ret) {
-        object_property_set_link(OBJECT(dev), NULL, propname, NULL);
-    }
-    g_free(propname);
-    return ret;
-}
-
-qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
-                                 const char *name, int n)
-{
-    qemu_irq disconnected = qdev_disconnect_gpio_out_named(dev, name, n);
-    qdev_connect_gpio_out_named(dev, name, n, icpt);
-    return disconnected;
-}
-
-void qdev_connect_gpio_out(DeviceState * dev, int n, qemu_irq pin)
-{
-    qdev_connect_gpio_out_named(dev, NULL, n, pin);
-}
-
-void qdev_pass_gpios(DeviceState *dev, DeviceState *container,
-                     const char *name)
-{
-    int i;
-    NamedGPIOList *ngl = qdev_get_named_gpio_list(dev, name);
-
-    for (i = 0; i < ngl->num_in; i++) {
-        const char *nm = ngl->name ? ngl->name : "unnamed-gpio-in";
-        char *propname = g_strdup_printf("%s[%d]", nm, i);
-
-        object_property_add_alias(OBJECT(container), propname,
-                                  OBJECT(dev), propname,
-                                  &error_abort);
-        g_free(propname);
-    }
-    for (i = 0; i < ngl->num_out; i++) {
-        const char *nm = ngl->name ? ngl->name : "unnamed-gpio-out";
-        char *propname = g_strdup_printf("%s[%d]", nm, i);
-
-        object_property_add_alias(OBJECT(container), propname,
-                                  OBJECT(dev), propname,
-                                  &error_abort);
-        g_free(propname);
-    }
-    QLIST_REMOVE(ngl, node);
-    QLIST_INSERT_HEAD(&container->gpios, ngl, node);
-}
-
 BusState *qdev_get_child_bus(DeviceState *dev, const char *name)
 {
     BusState *bus;
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a799c83815..6789154807 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -13,6 +13,7 @@ common-obj-$(CONFIG_XILINX_AXI) += stream.o
 common-obj-$(CONFIG_PTIMER) += ptimer.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
+common-obj-$(CONFIG_SOFTMMU) += gpio.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_FITLOADER) += loader-fit.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
-- 
2.18.0.rc1.1.g3f1ff2140
