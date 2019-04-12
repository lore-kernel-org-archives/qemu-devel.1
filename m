Received: from eggs.gnu.org ([209.51.188.92]:54398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRx-00014q-An
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzRu-0007Bq-Hp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:48 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:54:09 +0200
Message-Id: <20190412165416.7977-6-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/12] hw/devices: Move Blizzard
 declarations into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Add an entries the Blizzard device in MAINTAINERS.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                   |  2 ++
 hw/arm/nseries.c              |  1 +
 hw/display/blizzard.c         |  2 +-
 include/hw/devices.h          |  7 -------
 include/hw/display/blizzard.h | 22 ++++++++++++++++++++++
 5 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100644 include/hw/display/blizzard.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ccf8097f413..e1e30b071ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -663,10 +663,12 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/nseries.c
+F: hw/display/blizzard.c
 F: hw/input/lm832x.c
 F: hw/input/tsc2005.c
 F: hw/misc/cbus.c
 F: hw/timer/twl92230.c
+F: include/hw/display/blizzard.h
=20
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 2b710c3d49f..ef09b3bf79f 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -31,6 +31,7 @@
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/devices.h"
+#include "hw/display/blizzard.h"
 #include "hw/misc/tmp105.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index 291abe6fcae..471bd0ed997 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "ui/console.h"
-#include "hw/devices.h"
+#include "hw/display/blizzard.h"
 #include "ui/pixel_ops.h"
=20
 typedef void (*blizzard_fn_t)(uint8_t *, const uint8_t *, unsigned int);
diff --git a/include/hw/devices.h b/include/hw/devices.h
index 1e2141caad1..77d66113021 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -29,13 +29,6 @@ void tsc2005_set_transform(void *opaque, MouseTransfor=
mInfo *info);
 /* stellaris_input.c */
 void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
=20
-/* blizzard.c */
-void *s1d13745_init(qemu_irq gpio_int);
-void s1d13745_write(void *opaque, int dc, uint16_t value);
-void s1d13745_write_block(void *opaque, int dc,
-                void *buf, size_t len, int pitch);
-uint16_t s1d13745_read(void *opaque, int dc);
-
 /* cbus.c */
 typedef struct {
     qemu_irq clk;
diff --git a/include/hw/display/blizzard.h b/include/hw/display/blizzard.=
h
new file mode 100644
index 00000000000..ef72bbc1865
--- /dev/null
+++ b/include/hw/display/blizzard.h
@@ -0,0 +1,22 @@
+/*
+ * Epson S1D13744/S1D13745 (Blizzard/Hailstorm/Tornado) LCD/TV controlle=
r.
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Andrzej Zaborowski
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_DISPLAY_BLIZZARD_H
+#define HW_DISPLAY_BLIZZARD_H
+
+#include "hw/irq.h"
+
+void *s1d13745_init(qemu_irq gpio_int);
+void s1d13745_write(void *opaque, int dc, uint16_t value);
+void s1d13745_write_block(void *opaque, int dc,
+                          void *buf, size_t len, int pitch);
+uint16_t s1d13745_read(void *opaque, int dc);
+
+#endif
--=20
2.20.1
