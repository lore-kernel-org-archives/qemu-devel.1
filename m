Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36Z-0001G9-SW
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36Y-00028G-Tl
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:55 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:23 +0200
Message-Id: <1531745974-17187-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/17] hw/arm/msf2-soc: Fix introspection
 problem with the "msf2-soc" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Valgrind currently reports a problem when running QEMU like this:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'msf2-soc'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
[...]
==23097== Invalid read of size 8
==23097==    at 0x6192AA: qdev_print (qdev-monitor.c:686)
==23097==    by 0x6192AA: qbus_print (qdev-monitor.c:719)
[...]

Use the new sysbus_init_child_obj() function to make sure that the child
objects are cleaned up correctly when the parent gets destroyed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/msf2-soc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index edb3ba8..dbefade 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -68,19 +68,18 @@ static void m2sxxx_soc_initfn(Object *obj)
     MSF2State *s = MSF2_SOC(obj);
     int i;
 
-    object_initialize(&s->armv7m, sizeof(s->armv7m), TYPE_ARMV7M);
-    qdev_set_parent_bus(DEVICE(&s->armv7m), sysbus_get_default());
+    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
+                          TYPE_ARMV7M);
 
-    object_initialize(&s->sysreg, sizeof(s->sysreg), TYPE_MSF2_SYSREG);
-    qdev_set_parent_bus(DEVICE(&s->sysreg), sysbus_get_default());
+    sysbus_init_child_obj(obj, "sysreg", &s->sysreg, sizeof(s->sysreg),
+                          TYPE_MSF2_SYSREG);
 
-    object_initialize(&s->timer, sizeof(s->timer), TYPE_MSS_TIMER);
-    qdev_set_parent_bus(DEVICE(&s->timer), sysbus_get_default());
+    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
+                          TYPE_MSS_TIMER);
 
     for (i = 0; i < MSF2_NUM_SPIS; i++) {
-        object_initialize(&s->spi[i], sizeof(s->spi[i]),
+        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
                           TYPE_MSS_SPI);
-        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
     }
 }
 
-- 
1.8.3.1
