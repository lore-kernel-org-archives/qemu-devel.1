Received: from eggs.gnu.org ([2001:4830:134:3::10]:43745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36x-0001db-4i
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36s-0002Rk-G6
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:19 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:31 +0200
Message-Id: <1531745974-17187-15-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/17] hw/arm/allwinner-a10: Fix
 introspection problem with 'allwinner-a10'
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

Valgrind complains:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'allwinner-a10'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
[...]
==32519== Invalid read of size 8
==32519==    at 0x61869A: qdev_print (qdev-monitor.c:686)
==32519==    by 0x61869A: qbus_print (qdev-monitor.c:719)
==32519==    by 0x452B38: handle_hmp_command (monitor.c:3446)
[...]

Use object_initialize_child() and sysbus_init_child_obj() to fix the issue.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/allwinner-a10.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index c5fbc65..9fe875c 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -27,20 +27,19 @@ static void aw_a10_init(Object *obj)
 {
     AwA10State *s = AW_A10(obj);
 
-    object_initialize(&s->cpu, sizeof(s->cpu), "cortex-a8-" TYPE_ARM_CPU);
-    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
+    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
+                            "cortex-a8-" TYPE_ARM_CPU, &error_abort, NULL);
 
-    object_initialize(&s->intc, sizeof(s->intc), TYPE_AW_A10_PIC);
-    qdev_set_parent_bus(DEVICE(&s->intc), sysbus_get_default());
+    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
+                          TYPE_AW_A10_PIC);
 
-    object_initialize(&s->timer, sizeof(s->timer), TYPE_AW_A10_PIT);
-    qdev_set_parent_bus(DEVICE(&s->timer), sysbus_get_default());
+    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
+                          TYPE_AW_A10_PIT);
 
-    object_initialize(&s->emac, sizeof(s->emac), TYPE_AW_EMAC);
-    qdev_set_parent_bus(DEVICE(&s->emac), sysbus_get_default());
+    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac), TYPE_AW_EMAC);
 
-    object_initialize(&s->sata, sizeof(s->sata), TYPE_ALLWINNER_AHCI);
-    qdev_set_parent_bus(DEVICE(&s->sata), sysbus_get_default());
+    sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
+                          TYPE_ALLWINNER_AHCI);
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
-- 
1.8.3.1
