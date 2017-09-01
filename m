Received: from eggs.gnu.org ([2001:4830:134:3::10]:40859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnU6-00080c-JF
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnU1-0002ya-Tn
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnU1-0002yC-LI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:45 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:02:59 -0300
Message-Id: <20170901150317.10380-12-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/29] sparc: replace cpu_sparc_init() with
 cpu_generic_init()
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

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1503592308-93913-8-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/sparc/cpu.h   | 3 +--
 hw/sparc/leon3.c     | 2 +-
 hw/sparc/sun4m.c     | 2 +-
 hw/sparc64/sparc64.c | 2 +-
 target/sparc/cpu.c   | 5 -----
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 0e41916a52..b45cfb4708 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -579,7 +579,6 @@ void cpu_raise_exception_ra(CPUSPARCState *, int, uin=
tptr_t) QEMU_NORETURN;
=20
 #ifndef NO_CPU_IO_DEFS
 /* cpu_init.c */
-SPARCCPU *cpu_sparc_init(const char *cpu_model);
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* mmu_helper.c */
@@ -656,7 +655,7 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, =
target_ulong addr,
 int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
=20
 #ifndef NO_CPU_IO_DEFS
-#define cpu_init(cpu_model) CPU(cpu_sparc_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_SPARC_CPU, cpu_model)
 #endif
=20
 #define cpu_signal_handler cpu_sparc_signal_handler
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d5ff188d9e..56512ecd00 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -126,7 +126,7 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
         cpu_model =3D "LEON3";
     }
=20
-    cpu =3D cpu_sparc_init(cpu_model);
+    cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
         exit(1);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 89dd8a96c3..cf47dca83a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -797,7 +797,7 @@ static void cpu_devinit(const char *cpu_model, unsign=
ed int id,
     SPARCCPU *cpu;
     CPUSPARCState *env;
=20
-    cpu =3D cpu_sparc_init(cpu_model);
+    cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
         exit(1);
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 4e4fdab065..ecf38a45da 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -353,7 +353,7 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
     if (cpu_model =3D=3D NULL) {
         cpu_model =3D default_cpu_model;
     }
-    cpu =3D cpu_sparc_init(cpu_model);
+    cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find Sparc CPU definition\n");
         exit(1);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 29296b2411..0806d699e6 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -194,11 +194,6 @@ static void sparc_cpu_parse_features(const char *typ=
ename, char *features,
     g_list_free_full(minus_features, g_free);
 }
=20
-SPARCCPU *cpu_sparc_init(const char *cpu_model)
-{
-    return SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
-}
-
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
 {
 #if !defined(TARGET_SPARC64)
--=20
2.13.5
