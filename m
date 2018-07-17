Received: from eggs.gnu.org ([2001:4830:134:3::10]:47259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffRV3-0002I6-BO
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffRUx-0003t1-4l
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:02:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffRUw-0003sF-UN
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:02:43 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 17 Jul 2018 17:02:39 +0200
Message-Id: <1531839759-14090-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/riscv/sifive_u: Fix introspection problem
 in the "riscv.sifive.u.soc" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Valgrind complains:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'riscv.sifive.u.soc'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q riscv32-softmmu/qemu-system-riscv32 -M none,accel=qtest -qmp stdio
[...]
==28083== Invalid read of size 8
==28083==    at 0x2E036A: qdev_print (qdev-monitor.c:686)
==28083==    by 0x2E036A: qbus_print (qdev-monitor.c:719)
==28083==    by 0x268938: handle_hmp_command (monitor.c:3446)
[...]

Use the new object_initialize_child() and sysbus_init_child_obj() functions
to fix the problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/riscv/sifive_u.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3a6ffeb..459ec90 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -303,16 +303,15 @@ static void riscv_sifive_u_soc_init(Object *obj)
 {
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
 
-    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
-                              &error_abort);
+    object_initialize_child(obj, "cpus", &s->cpus, sizeof(s->cpus),
+                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
     object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
                             &error_abort);
 
-    object_initialize(&s->gem, sizeof(s->gem), TYPE_CADENCE_GEM);
-    qdev_set_parent_bus(DEVICE(&s->gem), sysbus_get_default());
+    sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
+                          TYPE_CADENCE_GEM);
 }
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
-- 
1.8.3.1
