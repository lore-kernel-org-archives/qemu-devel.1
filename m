Received: from eggs.gnu.org ([2001:4830:134:3::10]:52877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZC-0007jc-Ff
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZA-0000M5-OH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06ZA-0000LX-FP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:56 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:51:06 +0200
Message-Id: <1507211474-188400-33-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 32/40] sparc: sun4u/sun4v/niagara: use
 generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: mark.cave-ayland@ilande.co.uk
CC: atar4qemu@gmail.com
---
 include/hw/sparc/sparc64.h | 3 +--
 hw/sparc64/niagara.c       | 4 ++--
 hw/sparc64/sparc64.c       | 8 ++------
 hw/sparc64/sun4u.c         | 8 +++-----
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
index 7748939..ca3bb4b 100644
--- a/include/hw/sparc/sparc64.h
+++ b/include/hw/sparc/sparc64.h
@@ -1,5 +1,4 @@
=20
-SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
-                              const char *dflt_cpu_model, uint64_t prom_=
addr);
+SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr);
=20
 void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level);
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 9a8d610..7a72332 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -106,8 +106,7 @@ static void niagara_init(MachineState *machine)
     MemoryRegion *sysmem =3D get_system_memory();
=20
     /* init CPUs */
-    sparc64_cpu_devinit(machine->cpu_model, "Sun UltraSparc T1",
-                        NIAGARA_PROM_BASE);
+    sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
     /* set up devices */
     memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.ram=
",
                                          NIAGARA_HV_RAM_SIZE);
@@ -174,6 +173,7 @@ static void niagara_class_init(ObjectClass *oc, void =
*data)
     mc->init =3D niagara_init;
     mc->max_cpus =3D 1; /* XXX for now */
     mc->default_boot_order =3D "c";
+    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
 }
=20
 static const TypeInfo niagara_type =3D {
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 097d529..9453e2c 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -339,8 +339,7 @@ void cpu_tick_set_limit(CPUTimer *timer, uint64_t lim=
it)
     }
 }
=20
-SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
-                              const char *default_cpu_model, uint64_t pr=
om_addr)
+SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
 {
     SPARCCPU *cpu;
     CPUSPARCState *env;
@@ -350,10 +349,7 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
     uint32_t  stick_frequency =3D 100 * 1000000;
     uint32_t hstick_frequency =3D 100 * 1000000;
=20
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D default_cpu_model;
-    }
-    cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
+    cpu =3D SPARC_CPU(cpu_create(cpu_type));
     env =3D &cpu->env;
=20
     env->tick =3D cpu_timer_create("tick", cpu, tick_irq,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c3280aa..d53fad8 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -73,7 +73,6 @@
 #define IVEC_MAX             0x40
=20
 struct hwdef {
-    const char * const default_cpu_model;
     uint16_t machine_id;
     uint64_t prom_addr;
     uint64_t console_serial_base;
@@ -439,8 +438,7 @@ static void sun4uv_init(MemoryRegion *address_space_m=
em,
     int onboard_nic_idx;
=20
     /* init CPUs */
-    cpu =3D sparc64_cpu_devinit(machine->cpu_model, hwdef->default_cpu_m=
odel,
-                              hwdef->prom_addr);
+    cpu =3D sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
=20
     /* set up devices */
     ram_init(0, machine->ram_size);
@@ -569,14 +567,12 @@ enum {
 static const struct hwdef hwdefs[] =3D {
     /* Sun4u generic PC-like machine */
     {
-        .default_cpu_model =3D "TI UltraSparc IIi",
         .machine_id =3D sun4u_id,
         .prom_addr =3D 0x1fff0000000ULL,
         .console_serial_base =3D 0,
     },
     /* Sun4v generic PC-like machine */
     {
-        .default_cpu_model =3D "Sun UltraSparc T1",
         .machine_id =3D sun4v_id,
         .prom_addr =3D 0x1fff0000000ULL,
         .console_serial_base =3D 0,
@@ -605,6 +601,7 @@ static void sun4u_class_init(ObjectClass *oc, void *d=
ata)
     mc->max_cpus =3D 1; /* XXX for now */
     mc->is_default =3D 1;
     mc->default_boot_order =3D "c";
+    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
 }
=20
 static const TypeInfo sun4u_type =3D {
@@ -622,6 +619,7 @@ static void sun4v_class_init(ObjectClass *oc, void *d=
ata)
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D 1; /* XXX for now */
     mc->default_boot_order =3D "c";
+    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
 }
=20
 static const TypeInfo sun4v_type =3D {
--=20
2.7.4
