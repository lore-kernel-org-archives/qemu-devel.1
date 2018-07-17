Received: from eggs.gnu.org ([2001:4830:134:3::10]:49463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWaV-0000EX-W6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWaQ-0005l3-37
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:28:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7295ac877=Alistair.Francis@wdc.com>)
	id 1ffWaP-0005kc-Lf
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:28:42 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue, 17 Jul 2018 13:28:28 -0700
Message-Id: <6c60f18b1b26088dbbb54538caeaa0121e94a52d.1531859179.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1531859179.git.alistair.francis@wdc.com>
References: <cover.1531859179.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 4/5] riscv_hart: Fix crash when
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
Cc: alistair.francis@wdc.com, thuth@redhat.com, mjc@sifive.com

Use the new object_initialize_child() and sysbus_init_child_obj() to
fix the issue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv_hart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 75ba7ed579..e34a26a0ef 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -45,11 +45,10 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
     for (n = 0; n < s->num_harts; n++) {
-
-        object_initialize(&s->harts[n], sizeof(RISCVCPU), s->cpu_type);
+        object_initialize_child(OBJECT(s), "harts[*]", &s->harts[n],
+                                sizeof(RISCVCPU), s->cpu_type,
+                                &error_abort, NULL);
         s->harts[n].env.mhartid = n;
-        object_property_add_child(OBJECT(s), "harts[*]", OBJECT(&s->harts[n]),
-                                  &error_abort);
         qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
         object_property_set_bool(OBJECT(&s->harts[n]), true,
                                  "realized", &err);
-- 
2.17.1
