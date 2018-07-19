Received: from eggs.gnu.org ([2001:4830:134:3::10]:38877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSz-0008Dm-KV
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSv-0001HC-J6
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=73156a1e4=Alistair.Francis@wdc.com>)
	id 1fgBSv-0001Ew-92
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:07:41 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 19 Jul 2018 09:07:20 -0700
Message-Id: <20180719160721.18430-5-alistair.francis@wdc.com>
In-Reply-To: <20180719160721.18430-1-alistair.francis@wdc.com>
References: <20180719160721.18430-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 for 3.0 4/5] riscv_hart: Fix crash when
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
