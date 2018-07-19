Received: from eggs.gnu.org ([2001:4830:134:3::10]:38840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSx-0008DR-ID
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSv-0001Gt-2n
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSu-0001Ew-OC
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:40 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 19 Jul 2018 09:07:19 -0700
Message-Id: <20180719160721.18430-4-alistair.francis@wdc.com>
In-Reply-To: <20180719160721.18430-1-alistair.francis@wdc.com>
References: <20180719160721.18430-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 for 3.0 3/5] virt: Fix crash when
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
 hw/riscv/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index aeada2498d..248bbdffd3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -274,9 +274,8 @@ static void riscv_virt_board_init(MachineState *machine)
     void *fdt;
 
     /* Initialize SOC */
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
-                              &error_abort);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
     object_property_set_str(OBJECT(&s->soc), VIRT_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-- 
2.17.1
