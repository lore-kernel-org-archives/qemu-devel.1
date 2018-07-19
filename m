Received: from eggs.gnu.org ([2001:4830:134:3::10]:38868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSy-0008DZ-OT
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSv-0001HK-Ou
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSv-0001Gl-CT
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:41 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 19 Jul 2018 09:07:21 -0700
Message-Id: <20180719160721.18430-6-alistair.francis@wdc.com>
In-Reply-To: <20180719160721.18430-1-alistair.francis@wdc.com>
References: <20180719160721.18430-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 for 3.0 5/5] spike: Fix crash when
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
---
 hw/riscv/spike.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index f94e2b6707..c8c056c50b 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -171,9 +171,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     int i;
 
     /* Initialize SOC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
     object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
@@ -254,9 +253,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     int i;
 
     /* Initialize SOC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
     object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-- 
2.17.1
