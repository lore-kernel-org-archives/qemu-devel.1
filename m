Received: from eggs.gnu.org ([2001:4830:134:3::10]:38842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSx-0008DT-IX
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSu-0001Gg-CX
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSt-0001Ew-Rq
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:40 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 19 Jul 2018 09:07:17 -0700
Message-Id: <20180719160721.18430-2-alistair.francis@wdc.com>
In-Reply-To: <20180719160721.18430-1-alistair.francis@wdc.com>
References: <20180719160721.18430-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 for 3.0 1/5] sifive_e: Fix crash when
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
 hw/riscv/sifive_e.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 8a8dbe1c00..4577d72037 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -105,9 +105,9 @@ static void riscv_sifive_e_init(MachineState *machine)
     int i;
 
     /* Initialize SoC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_E_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            sizeof(s->soc), TYPE_RISCV_E_SOC,
+                            &error_abort, NULL);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
 
@@ -139,9 +139,9 @@ static void riscv_sifive_e_soc_init(Object *obj)
 {
     SiFiveESoCState *s = RISCV_E_SOC(obj);
 
-    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
-                              &error_abort);
+    object_initialize_child(obj, "cpus", &s->cpus,
+                            sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
+                            &error_abort, NULL);
     object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
-- 
2.17.1
