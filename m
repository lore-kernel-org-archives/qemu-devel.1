Received: from eggs.gnu.org ([2001:4830:134:3::10]:52654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuvg-0001m1-76
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuvc-0002Fj-7j
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=730c0c5bd=Alistair.Francis@wdc.com>)
	id 1ffuvb-0002Du-Rl
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 18:28:12 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 18 Jul 2018 15:27:54 -0700
Message-Id: <20180718222755.9014-5-alistair.francis@wdc.com>
In-Reply-To: <20180718222755.9014-1-alistair.francis@wdc.com>
References: <20180718222755.9014-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/5] riscv_hart: Fix crash when introspecting
 the device
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
