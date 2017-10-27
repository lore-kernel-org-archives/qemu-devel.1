Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Wr-0005pI-5N
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Wq-0000vp-89
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85Wq-0000ul-26
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:45 +0200
Message-Id: <20171027142107.15542-18-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 17/39] sh4: shix: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

default cpu model 'any' resolves to type TYPE_SH7750R_CPU
in superh_cpu_class_by_name(), so use it directly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-21-git-send-email-imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/sh4/shix.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 50ee36a5c5..4add2309eb 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -45,7 +45,6 @@
=20
 static void shix_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     int ret;
     SuperHCPU *cpu;
     struct SH7750State *s;
@@ -53,10 +52,7 @@ static void shix_init(MachineState *machine)
     MemoryRegion *rom =3D g_new(MemoryRegion, 1);
     MemoryRegion *sdram =3D g_new(MemoryRegion, 2);
    =20
-    if (!cpu_model)
-        cpu_model =3D "any";
-
-    cpu =3D SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
+    cpu =3D SUPERH_CPU(cpu_create(machine->cpu_type));
=20
     /* Allocate memory space */
     memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
@@ -89,6 +85,7 @@ static void shix_machine_init(MachineClass *mc)
     mc->desc =3D "shix card";
     mc->init =3D shix_init;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D TYPE_SH7750R_CPU;
 }
=20
 DEFINE_MACHINE("shix", shix_machine_init)
--=20
2.13.6
