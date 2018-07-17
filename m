Received: from eggs.gnu.org ([2001:4830:134:3::10]:49421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWaH-0008VR-6g
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWaE-0005h3-1i
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:28:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWaD-0005gc-KD
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:28:29 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue, 17 Jul 2018 13:28:15 -0700
Message-Id: <8a6a1a1a1056023dc79179399c11e059fbdcde1a.1531859179.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1531859179.git.alistair.francis@wdc.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 3/5] virt: Fix crash when introspecting the
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
Cc: alistair.francis@wdc.com, thuth@redhat.com, mjc@sifive.com

Use the new object_initialize_child() and sysbus_init_child_obj() to
fix the issue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
