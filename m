Received: from eggs.gnu.org ([2001:4830:134:3::10]:52646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuvf-0001ly-Pt
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuvb-0002Eq-0Z
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuva-0002E6-J7
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:10 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 18 Jul 2018 15:27:53 -0700
Message-Id: <20180718222755.9014-4-alistair.francis@wdc.com>
In-Reply-To: <20180718222755.9014-1-alistair.francis@wdc.com>
References: <20180718222755.9014-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/5] virt: Fix crash when introspecting the
 device
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
