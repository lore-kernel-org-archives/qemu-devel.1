Received: from eggs.gnu.org ([2001:4830:134:3::10]:42763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRN-0001Hy-D9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRM-00078X-Jr
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:54 -0300
Message-Id: <20171006235023.11952-60-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 59/88] ppce500: use g_new() family of functions
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
[PMD: replaced g_new0() -> g_new() since no bzero() required]
---
 hw/ppc/e500.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index db0e49ab8f..b396fd1a22 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -737,8 +737,6 @@ static qemu_irq *ppce500_init_mpic(MachineState *machine, PPCE500Params *params,
     SysBusDevice *s;
     int i;
 
-    mpic = g_new0(qemu_irq, 256);
-
     if (kvm_enabled()) {
         Error *err = NULL;
 
@@ -756,6 +754,7 @@ static qemu_irq *ppce500_init_mpic(MachineState *machine, PPCE500Params *params,
         dev = ppce500_init_mpic_qemu(params, irqs);
     }
 
+    mpic = g_new(qemu_irq, 256);
     for (i = 0; i < 256; i++) {
         mpic[i] = qdev_get_gpio_in(dev, i);
     }
@@ -808,7 +807,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         machine->cpu_model = "e500v2_v30";
     }
 
-    irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
+    irqs = g_new0(qemu_irq *, smp_cpus);
     irqs[0] = g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
     for (i = 0; i < smp_cpus; i++) {
         PowerPCCPU *cpu;
@@ -844,7 +843,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         if (!i) {
             /* Primary CPU */
             struct boot_info *boot_info;
-            boot_info = g_malloc0(sizeof(struct boot_info));
+            boot_info = g_new0(struct boot_info, 1);
             qemu_register_reset(ppce500_cpu_reset, cpu);
             env->load_info = boot_info;
         } else {
-- 
2.14.2
