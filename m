Received: from eggs.gnu.org ([2001:4830:134:3::10]:41139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11S-0001MV-BB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11O-0001BN-Et
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW11O-0001Ac-5O
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:42 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:51:54 +0200
Message-Id: <1500040339-119465-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/28] mips: replace cpu_mips_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

now cpu_mips_init() reimplements subset of cpu_generic_init()
tasks, so just drop it and use cpu_generic_init() directly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Yongbok Kim <yongbok.kim@imgtec.com>
CC: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
---
 target/mips/cpu.h       |  3 +--
 hw/mips/cps.c           |  2 +-
 hw/mips/mips_fulong2e.c |  2 +-
 hw/mips/mips_jazz.c     |  2 +-
 hw/mips/mips_malta.c    |  2 +-
 hw/mips/mips_mipssim.c  |  2 +-
 hw/mips/mips_r4k.c      |  2 +-
 target/mips/translate.c | 17 -----------------
 8 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7c2e0bf..efc8025 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -865,10 +865,9 @@ enum {
 #define CPU_INTERRUPT_WAKE CPU_INTERRUPT_TGT_INT_0
=20
 void mips_tcg_init(void);
-MIPSCPU *cpu_mips_init(const char *cpu_model);
 int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
=20
-#define cpu_init(cpu_model) CPU(cpu_mips_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_MIPS_CPU, cpu_model)
 bool cpu_supports_cps_smp(const char *cpu_model);
 bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 4ef337d..708899c 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -71,7 +71,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
     bool itu_present =3D false;
=20
     for (i =3D 0; i < s->num_vp; i++) {
-        cpu =3D cpu_mips_init(s->cpu_model);
+        cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, s->cpu_model));
         if (cpu =3D=3D NULL) {
             error_setg(errp, "%s: CPU initialization failed",  __func__)=
;
             return;
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index dbe2805..02a1712 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -277,7 +277,7 @@ static void mips_fulong2e_init(MachineState *machine)
     if (cpu_model =3D=3D NULL) {
         cpu_model =3D "Loongson-2E";
     }
-    cpu =3D cpu_mips_init(cpu_model);
+    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 1cef581..ee58c44 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -151,7 +151,7 @@ static void mips_jazz_init(MachineState *machine,
     if (cpu_model =3D=3D NULL) {
         cpu_model =3D "R4000";
     }
-    cpu =3D cpu_mips_init(cpu_model);
+    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 95cdabb..21dd2c3 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -928,7 +928,7 @@ static void create_cpu_without_cps(const char *cpu_mo=
del,
     int i;
=20
     for (i =3D 0; i < smp_cpus; i++) {
-        cpu =3D cpu_mips_init(cpu_model);
+        cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
         if (cpu =3D=3D NULL) {
             fprintf(stderr, "Unable to find CPU definition\n");
             exit(1);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 1b91195..80e2bab 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -162,7 +162,7 @@ mips_mipssim_init(MachineState *machine)
         cpu_model =3D "24Kf";
 #endif
     }
-    cpu =3D cpu_mips_init(cpu_model);
+    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index f4de9fc..81dba5e 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -191,7 +191,7 @@ void mips_r4k_init(MachineState *machine)
         cpu_model =3D "24Kf";
 #endif
     }
-    cpu =3D cpu_mips_init(cpu_model);
+    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ae7ca80..ad4242f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20191,23 +20191,6 @@ void mips_tcg_init(void)
=20
 #include "translate_init.c"
=20
-MIPSCPU *cpu_mips_init(const char *cpu_model)
-{
-    ObjectClass *oc;
-    MIPSCPU *cpu;
-
-    oc =3D cpu_class_by_name(TYPE_MIPS_CPU, cpu_model);
-    if (oc =3D=3D NULL) {
-        return NULL;
-    }
-
-    cpu =3D MIPS_CPU(object_new(object_class_get_name(oc)));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
-}
-
 bool cpu_supports_cps_smp(const char *cpu_model)
 {
     const mips_def_t *def =3D cpu_mips_find_by_name(cpu_model);
--=20
2.7.4
