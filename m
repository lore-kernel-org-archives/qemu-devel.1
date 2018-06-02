Received: from eggs.gnu.org ([2001:4830:134:3::10]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fOx2D-00024p-Ni
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fOx29-0006aX-Kj
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:16:53 -0400
Received: from steffen-goertz.de ([88.198.119.201]:44108)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fOx29-0006Xj-A5
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:16:49 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Fri,  1 Jun 2018 23:16:29 -0400
Message-Id: <20180602031629.3925-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC] qapi: command category to stimulate high-level
 machine devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Steffen Goertz <contrib@steffen-goertz.de>

From: Steffen Goertz <contrib@steffen-goertz.de>

Add a new category "stimulate" to host commands that
act upon high-level devices associated with machines/boards.

This is patch is part of an effort to add support for BBC:microbit
educational computer to QEMU.

The microbit board, as many other microcontroller boards,
contains typical trivial (digital) input and output options such as butto=
ns and LEDs,
but also more sophiscated possibilities such as analog inputs and
complex dedicated sensor ICs that are connected to the microbit machine
by means of inter-ic bus (i2c).
These devices interact with peripheral devices of the microcontroller
in use, for example with the GPIO peripheral of the used NRF51.

One aim of our efforts is to create a user interface that models the
look and feel of the physical microbit board and lets the user interact
with its inputs and provide feedback on its outsputs.

For this it is necessary to transmit user inputs such as the pressing of =
a
button to the machine.
In return, when the state of an output is changed on the machine, this
change needs to be reflected in the user interface.

At the moment, there are only a few QMP commands that provide user input =
to the
machine, eg. send-keys, input-button. These commands require very
high-level concepts, which are not really suitable for applications that
microcontrollers are typically used in in.

This RFC is meant to start a discussion on how to provide stimuli to
low-complex inputs and outputs typically found in embedded
microcontroller applications. To the best of my knowledge, there are
currently no examples of how to provide such stimuli to either SoC
device peripheral or machine level concepts like pushbuttons and LEDs.

To my understanding, the following concepts/apis are needed:
- QMP commands to send stimuli to machine level concepts like
pushbuttons
- Machine level devices that receive these stimuli and act as an adapter
to manipulate the associated SoC peripheral devices
- For outputs, machine level devices are needed that observe changes in
SoC peripherals and emit QMP events that clients can receive

This patch adds a new qmp command "buttons-set-state" to update the
push-down state of arbitrarily identified buttons (string identifier).

The handler of this command is mocked to set the machines SoC gpio/irq
lines associated with these buttons on the machine by means of object
property aliases. This is just a mock until a proper concept/api is
agreed upon.

As i recently joined the QEMU community as part of GSoC, i am still a
greenhorn to the codebase and i am really excited to discuss potential
concepts and APIs to realize the described features.

Based-on: <20180503090532.3113-1-joel@jms.id.au>
Signed-off-by: Steffen Goertz <contrib@steffen-goertz.de>
---
 Makefile              |  8 +++++++
 Makefile.objs         |  4 ++++
 Makefile.target       |  1 +
 hw/arm/microbit.c     |  5 ++++
 qapi/qapi-schema.json |  1 +
 qapi/stimulate.json   | 24 +++++++++++++++++++
 stimulate.c           | 56 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 99 insertions(+)
 create mode 100644 qapi/stimulate.json
 create mode 100644 stimulate.c

diff --git a/Makefile b/Makefile
index d71dd5bea4..d9319efa68 100644
--- a/Makefile
+++ b/Makefile
@@ -108,6 +108,7 @@ GENERATED_FILES +=3D qapi/qapi-types-tpm.h qapi/qapi-=
types-tpm.c
 GENERATED_FILES +=3D qapi/qapi-types-trace.h qapi/qapi-types-trace.c
 GENERATED_FILES +=3D qapi/qapi-types-transaction.h qapi/qapi-types-trans=
action.c
 GENERATED_FILES +=3D qapi/qapi-types-ui.h qapi/qapi-types-ui.c
+GENERATED_FILES +=3D qapi/qapi-types-stimulate.h qapi/qapi-types-stimula=
te.c
 GENERATED_FILES +=3D qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
 GENERATED_FILES +=3D qapi/qapi-visit.h qapi/qapi-visit.c
 GENERATED_FILES +=3D qapi/qapi-visit-block-core.h qapi/qapi-visit-block-=
core.c
@@ -126,6 +127,7 @@ GENERATED_FILES +=3D qapi/qapi-visit-tpm.h qapi/qapi-=
visit-tpm.c
 GENERATED_FILES +=3D qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
 GENERATED_FILES +=3D qapi/qapi-visit-transaction.h qapi/qapi-visit-trans=
action.c
 GENERATED_FILES +=3D qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
+GENERATED_FILES +=3D qapi/qapi-visit-stimulate.h qapi/qapi-visit-stimula=
te.c
 GENERATED_FILES +=3D qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_FILES +=3D qapi/qapi-commands-block-core.h qapi/qapi-commands-=
block-core.c
 GENERATED_FILES +=3D qapi/qapi-commands-block.h qapi/qapi-commands-block=
.c
@@ -143,6 +145,7 @@ GENERATED_FILES +=3D qapi/qapi-commands-tpm.h qapi/qa=
pi-commands-tpm.c
 GENERATED_FILES +=3D qapi/qapi-commands-trace.h qapi/qapi-commands-trace=
.c
 GENERATED_FILES +=3D qapi/qapi-commands-transaction.h qapi/qapi-commands=
-transaction.c
 GENERATED_FILES +=3D qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
+GENERATED_FILES +=3D qapi/qapi-commands-stimulate.h qapi/qapi-commands-s=
timulate.c
 GENERATED_FILES +=3D qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_FILES +=3D qapi/qapi-events-block-core.h qapi/qapi-events-bloc=
k-core.c
 GENERATED_FILES +=3D qapi/qapi-events-block.h qapi/qapi-events-block.c
@@ -160,6 +163,7 @@ GENERATED_FILES +=3D qapi/qapi-events-tpm.h qapi/qapi=
-events-tpm.c
 GENERATED_FILES +=3D qapi/qapi-events-trace.h qapi/qapi-events-trace.c
 GENERATED_FILES +=3D qapi/qapi-events-transaction.h qapi/qapi-events-tra=
nsaction.c
 GENERATED_FILES +=3D qapi/qapi-events-ui.h qapi/qapi-events-ui.c
+GENERATED_FILES +=3D qapi/qapi-events-stimulate.h qapi/qapi-events-stimu=
late.c
 GENERATED_FILES +=3D qapi/qapi-introspect.c qapi/qapi-introspect.h
 GENERATED_FILES +=3D qapi/qapi-doc.texi
=20
@@ -611,6 +615,7 @@ qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
+qapi/qapi-types-stimulate.c qapi/qapi-types-stimulate.h \
 qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
 qapi/qapi-visit.c qapi/qapi-visit.h \
 qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
@@ -629,6 +634,7 @@ qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
+qapi/qapi-visit-stimulate.c qapi/qapi-visit-stimulate.h \
 qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
 qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
@@ -646,6 +652,7 @@ qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
+qapi/qapi-commands-stimulate.c qapi/qapi-commands-stimulate.h \
 qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
 qapi/qapi-events-block.c qapi/qapi-events-block.h \
@@ -663,6 +670,7 @@ qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
+qapi/qapi-events-stimulate.c qapi/qapi-events-stimulate.h \
 qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
 qapi-gen-timestamp ;
diff --git a/Makefile.objs b/Makefile.objs
index c6c9b8fc21..c6806ed83c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -20,6 +20,7 @@ util-obj-y +=3D qapi/qapi-types-tpm.o
 util-obj-y +=3D qapi/qapi-types-trace.o
 util-obj-y +=3D qapi/qapi-types-transaction.o
 util-obj-y +=3D qapi/qapi-types-ui.o
+util-obj-y +=3D qapi/qapi-types-stimulate.o
 util-obj-y +=3D qapi/qapi-builtin-visit.o
 util-obj-y +=3D qapi/qapi-visit.o
 util-obj-y +=3D qapi/qapi-visit-block-core.o
@@ -38,6 +39,7 @@ util-obj-y +=3D qapi/qapi-visit-tpm.o
 util-obj-y +=3D qapi/qapi-visit-trace.o
 util-obj-y +=3D qapi/qapi-visit-transaction.o
 util-obj-y +=3D qapi/qapi-visit-ui.o
+util-obj-y +=3D qapi/qapi-visit-stimulate.o
 util-obj-y +=3D qapi/qapi-events.o
 util-obj-y +=3D qapi/qapi-events-block-core.o
 util-obj-y +=3D qapi/qapi-events-block.o
@@ -55,6 +57,7 @@ util-obj-y +=3D qapi/qapi-events-tpm.o
 util-obj-y +=3D qapi/qapi-events-trace.o
 util-obj-y +=3D qapi/qapi-events-transaction.o
 util-obj-y +=3D qapi/qapi-events-ui.o
+util-obj-y +=3D qapi/qapi-events-stimulate.o
 util-obj-y +=3D qapi/qapi-introspect.o
=20
 chardev-obj-y =3D chardev/
@@ -150,6 +153,7 @@ common-obj-y +=3D qapi/qapi-commands-tpm.o
 common-obj-y +=3D qapi/qapi-commands-trace.o
 common-obj-y +=3D qapi/qapi-commands-transaction.o
 common-obj-y +=3D qapi/qapi-commands-ui.o
+common-obj-y +=3D qapi/qapi-commands-stimulate.o
 common-obj-y +=3D qapi/qapi-introspect.o
 common-obj-y +=3D qmp.o hmp.o
 endif
diff --git a/Makefile.target b/Makefile.target
index d0ec77a307..6ecd09321a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -139,6 +139,7 @@ obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
 obj-y +=3D dump.o
 obj-y +=3D migration/ram.o
+obj-y +=3D stimulate.o
 LIBS :=3D $(libs_softmmu) $(LIBS)
=20
 # Hardware support
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index b61d0747fe..2fdb1d01a6 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -16,12 +16,17 @@
 static void microbit_init(MachineState *machine)
 {
     DeviceState *dev;
+    NRF51State * soc;
=20
     dev =3D qdev_create(NULL, TYPE_NRF51_SOC);
     if (machine->kernel_filename) {
         qdev_prop_set_string(dev, "kernel-filename", machine->kernel_fil=
ename);
     }
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal=
);
+
+    soc =3D NRF51_SOC(dev);
+    object_property_add_alias(OBJECT(machine), "button-a", OBJECT(soc->n=
vic), "unnamed-gpio-in[17]", &error_fatal);
+    object_property_add_alias(OBJECT(machine), "button-b", OBJECT(soc->n=
vic), "unnamed-gpio-in[26]", &error_fatal);
 }
=20
 static void microbit_machine_init(MachineClass *mc)
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 25bce78352..0f506ca6f1 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -93,3 +93,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'stimulate.json' }
diff --git a/qapi/stimulate.json b/qapi/stimulate.json
new file mode 100644
index 0000000000..5ff9c73ff8
--- /dev/null
+++ b/qapi/stimulate.json
@@ -0,0 +1,24 @@
+# -*- Mode: Python -*-
+
+##
+# @ButtonPress:
+#
+# @identifier:  Name of the button.
+# @pushed_down: State of the button.
+#
+##
+{ 'struct': 'ButtonPress',
+  'data': {
+    'identifier': 'str',
+    'pushed_down': 'bool'
+     } }
+   =20
+##
+# @buttons-set-state:
+#
+# @buttons: List of updated button states.
+#
+# Returns: nothing in case of success
+##
+{ 'command': 'buttons-set-state',
+  'data': { 'buttons': ['ButtonPress'] } }
diff --git a/stimulate.c b/stimulate.c
new file mode 100644
index 0000000000..0bca40cd22
--- /dev/null
+++ b/stimulate.c
@@ -0,0 +1,56 @@
+/*
+ * stimulate.c
+ *
+ * Copyright (C) 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+#include "hw/boards.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-stimulate.h"
+
+#ifndef DEBUG_STIMULATE
+#define DEBUG_STIMULATE 1
+#endif
+
+#define DPRINTF(fmt, ...) do {                                          =
 \
+    if (DEBUG_STIMULATE) {                                              =
 \
+        qemu_log("stimulate: " fmt , ## __VA_ARGS__);                   =
 \
+    }                                                                   =
 \
+} while (0);
+
+void qmp_buttons_set_state(ButtonPressList *buttons, Error **errp)
+{
+    for (; buttons; buttons =3D buttons->next) {
+        if (buttons->value) {
+            DPRINTF("Set button %s to %s", buttons->value->identifier,
+                    buttons->value->pushed_down ? "true" : "false");
+
+            gchar *name =3D g_strdup_printf("button-%s",
+                    buttons->value->identifier);
+            Object *child =3D object_resolve_path_component(
+                    OBJECT(current_machine), name);
+
+            if (!child) {
+                error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                        "GPIO '%s' doesn't exists", name);
+                g_free(name);
+                return;
+
+            } else {
+                g_free(name);
+                qemu_set_irq(OBJECT_CHECK(struct IRQState, (child), TYPE=
_IRQ),
+                        buttons->value->pushed_down);
+
+            }
+        }
+    }
+}
--=20
2.17.0
