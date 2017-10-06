Received: from eggs.gnu.org ([2001:4830:134:3::10]:42665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRH-0001Aq-R7
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRF-00072X-Iq
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:52 -0300
Message-Id: <20171006235023.11952-58-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 57/88] ppc: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: replaced g_new0() -> g_new() in mac_newworld.c, added virtex_ml507]
---
 hw/intc/heathrow_pic.c | 2 +-
 hw/ppc/mac_newworld.c  | 5 ++---
 hw/ppc/mac_oldworld.c  | 2 +-
 hw/ppc/virtex_ml507.c  | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 171f5ed814..90c1e6a4b1 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -201,7 +201,7 @@ qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
 {
     HeathrowPICS *s;
 
-    s = g_malloc0(sizeof(HeathrowPICS));
+    s = g_new0(HeathrowPICS, 1);
     /* only 1 CPU */
     s->irqs = irqs[0];
     memory_region_init_io(&s->mem, NULL, &heathrow_pic_ops, s,
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 6d0ace20ca..59cded95b8 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -295,7 +295,7 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_init_io(unin2_memory, NULL, &unin_ops, token, "unin", 0x1000);
     memory_region_add_subregion(get_system_memory(), 0xf3000000, unin2_memory);
 
-    openpic_irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
+    openpic_irqs = g_new0(qemu_irq *, smp_cpus);
     openpic_irqs[0] =
         g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
     for (i = 0; i < smp_cpus; i++) {
@@ -339,8 +339,6 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
 
-    pic = g_new0(qemu_irq, 64);
-
     dev = qdev_create(NULL, TYPE_OPENPIC);
     qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_KEYLARGO);
     qdev_init_nofail(dev);
@@ -353,6 +351,7 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
 
+    pic = g_new(qemu_irq, 64);
     for (i = 0; i < 64; i++) {
         pic[i] = qdev_get_gpio_in(dev, i);
     }
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index bc7c8b7bd7..50ad9c56cb 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -232,7 +232,7 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0xfe000000, isa);
 
     /* XXX: we register only 1 output pin for heathrow PIC */
-    heathrow_irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
+    heathrow_irqs = g_new0(qemu_irq *, smp_cpus);
     heathrow_irqs[0] =
         g_malloc0(smp_cpus * sizeof(qemu_irq) * 1);
     /* Connect the heathrow PIC outputs to the 6xx bus */
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index ed9b406fd3..ed6e054611 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -104,7 +104,7 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
     ppc_dcr_init(env, NULL, NULL);
 
     /* interrupt controller */
-    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_CINT];
     ppcuic_init(env, irqs, 0x0C0, 0, 1);
-- 
2.14.2
