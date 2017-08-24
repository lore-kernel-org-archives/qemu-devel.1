Received: from eggs.gnu.org ([2001:4830:134:3::10]:54948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv30-0000Zc-W0
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv2z-0007SQ-Sn
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv2z-0007Ru-KE
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:57 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:28 +0200
Message-Id: <1503592308-93913-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 v3 05/25] sparc: move adhoc
 CPUSPARCState initialization to realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

SPARCCPU::env was initialized from previously set properties
(with help of sparc_cpu_parse_features) in cpu_sparc_register().
However there is not reason to keep it there as this task is
typically done at realize time. So move post properties
initialization into sparc_cpu_realizefn, which brings
cpu_sparc_init() closer to cpu_generic_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 82ab5ad..9dfc150 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -109,7 +109,6 @@ static void sparc_cpu_parse_features(CPUState *cs, ch=
ar *features,
=20
 static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
 {
-    CPUSPARCState *env =3D &cpu->env;
     char *s =3D g_strdup(cpu_model);
     char *featurestr =3D strtok(s, ",");
     Error *err =3D NULL;
@@ -122,19 +121,6 @@ static int cpu_sparc_register(SPARCCPU *cpu, const c=
har *cpu_model)
         return -1;
     }
=20
-    env->version =3D env->def.iu_version;
-    env->fsr =3D env->def.fpu_version;
-    env->nwindows =3D env->def.nwindows;
-#if !defined(TARGET_SPARC64)
-    env->mmuregs[0] |=3D env->def.mmu_version;
-    cpu_sparc_set_id(env, 0);
-    env->mxccregs[7] |=3D env->def.mxcc_version;
-#else
-    env->mmu_version =3D env->def.mmu_version;
-    env->maxtl =3D env->def.maxtl;
-    env->version |=3D env->def.maxtl << 8;
-    env->version |=3D env->def.nwindows - 1;
-#endif
     return 0;
 }
=20
@@ -816,15 +802,29 @@ static void sparc_cpu_realizefn(DeviceState *dev, E=
rror **errp)
     CPUState *cs =3D CPU(dev);
     SPARCCPUClass *scc =3D SPARC_CPU_GET_CLASS(dev);
     Error *local_err =3D NULL;
-#if defined(CONFIG_USER_ONLY)
     SPARCCPU *cpu =3D SPARC_CPU(dev);
     CPUSPARCState *env =3D &cpu->env;
=20
+#if defined(CONFIG_USER_ONLY)
     if ((env->def.features & CPU_FEATURE_FLOAT)) {
         env->def.features |=3D CPU_FEATURE_FLOAT128;
     }
 #endif
=20
+    env->version =3D env->def.iu_version;
+    env->fsr =3D env->def.fpu_version;
+    env->nwindows =3D env->def.nwindows;
+#if !defined(TARGET_SPARC64)
+    env->mmuregs[0] |=3D env->def.mmu_version;
+    cpu_sparc_set_id(env, 0);
+    env->mxccregs[7] |=3D env->def.mxcc_version;
+#else
+    env->mmu_version =3D env->def.mmu_version;
+    env->maxtl =3D env->def.maxtl;
+    env->version |=3D env->def.maxtl << 8;
+    env->version |=3D env->def.nwindows - 1;
+#endif
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err !=3D NULL) {
         error_propagate(errp, local_err);
--=20
2.7.4
