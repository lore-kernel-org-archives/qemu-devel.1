Received: from eggs.gnu.org ([2001:4830:134:3::10]:38841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSx-0008DS-IP
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSv-0001H4-Gm
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSu-0001Fb-O9
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:41 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 19 Jul 2018 09:07:18 -0700
Message-Id: <20180719160721.18430-3-alistair.francis@wdc.com>
In-Reply-To: <20180719160721.18430-1-alistair.francis@wdc.com>
References: <20180719160721.18430-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 for 3.0 2/5] sifive_u: Fix crash when
 introspecting the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>

Use the new object_initialize_child() and sysbus_init_child_obj() to
fix the issue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/sifive_u.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3a6ffeb437..59ae1ce24a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -244,9 +244,9 @@ static void riscv_sifive_u_init(MachineState *machine)
     int i;
 
     /* Initialize SoC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_U_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            sizeof(s->soc), TYPE_RISCV_U_SOC,
+                            &error_abort, NULL);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
 
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
2.17.1
