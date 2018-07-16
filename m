Received: from eggs.gnu.org ([2001:4830:134:3::10]:43724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36t-0001ah-2v
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36p-0002Og-BR
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:15 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:29 +0200
Message-Id: <1531745974-17187-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/17] hw/cpu/arm11mpcore: Fix introspection
 problem with 'arm11mpcore_priv'
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

Valgrind reports an error here:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'arm11mpcore_priv'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
[...]
==3145== Invalid read of size 8
==3145==    at 0x61873A: qdev_print (qdev-monitor.c:686)
==3145==    by 0x61873A: qbus_print (qdev-monitor.c:719)
[...]

Use sysbus_init_child_obj() to fix it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/cpu/arm11mpcore.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index eb24465..8aead37 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -121,19 +121,17 @@ static void mpcore_priv_initfn(Object *obj)
                        "mpcore-priv-container", 0x2000);
     sysbus_init_mmio(sbd, &s->container);
 
-    object_initialize(&s->scu, sizeof(s->scu), TYPE_ARM11_SCU);
-    qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
+    sysbus_init_child_obj(obj, "scu", &s->scu, sizeof(s->scu), TYPE_ARM11_SCU);
 
-    object_initialize(&s->gic, sizeof(s->gic), TYPE_ARM_GIC);
-    qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
+    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic), TYPE_ARM_GIC);
     /* Request the legacy 11MPCore GIC behaviour: */
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 0);
 
-    object_initialize(&s->mptimer, sizeof(s->mptimer), TYPE_ARM_MPTIMER);
-    qdev_set_parent_bus(DEVICE(&s->mptimer), sysbus_get_default());
+    sysbus_init_child_obj(obj, "mptimer", &s->mptimer, sizeof(s->mptimer),
+                          TYPE_ARM_MPTIMER);
 
-    object_initialize(&s->wdtimer, sizeof(s->wdtimer), TYPE_ARM_MPTIMER);
-    qdev_set_parent_bus(DEVICE(&s->wdtimer), sysbus_get_default());
+    sysbus_init_child_obj(obj, "wdtimer", &s->wdtimer, sizeof(s->wdtimer),
+                          TYPE_ARM_MPTIMER);
 }
 
 static Property mpcore_priv_properties[] = {
-- 
1.8.3.1
