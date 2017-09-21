Received: from eggs.gnu.org ([2001:4830:134:3::10]:33501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gf-0007hY-Hj
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gZ-0006qc-Vr
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:41 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:29517)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gZ-0006pY-PI
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:35 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 21 Sep 2017 14:38:07 +0100
Message-ID: <1506001091-8296-4-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
References: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] mips: split cpu_mips_realize_env() out of
 cpu_mips_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

so it can be used in mips_cpu_realizefn() in the next commit

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/internal.h  |  1 +
 target/mips/translate.c | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 91c2df4..cf4c9db 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -132,6 +132,7 @@ void mips_tcg_init(void);
=20
 /* TODO QOM'ify CPU reset and remove */
 void cpu_state_reset(CPUMIPSState *s);
+void cpu_mips_realize_env(CPUMIPSState *env);
=20
 /* cp0_timer.c */
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index f0febaf..5fc7979 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20512,6 +20512,17 @@ void mips_tcg_init(void)
=20
 #include "translate_init.c"
=20
+void cpu_mips_realize_env(CPUMIPSState *env)
+{
+    env->exception_base =3D (int32_t)0xBFC00000;
+
+#ifndef CONFIG_USER_ONLY
+    mmu_init(env, env->cpu_model);
+#endif
+    fpu_init(env, env->cpu_model);
+    mvp_init(env, env->cpu_model);
+}
+
 MIPSCPU *cpu_mips_init(const char *cpu_model)
 {
     MIPSCPU *cpu;
@@ -20524,13 +20535,7 @@ MIPSCPU *cpu_mips_init(const char *cpu_model)
     cpu =3D MIPS_CPU(object_new(TYPE_MIPS_CPU));
     env =3D &cpu->env;
     env->cpu_model =3D def;
-    env->exception_base =3D (int32_t)0xBFC00000;
-
-#ifndef CONFIG_USER_ONLY
-    mmu_init(env, def);
-#endif
-    fpu_init(env, def);
-    mvp_init(env, def);
+    cpu_mips_realize_env(env);
=20
     object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
=20
--=20
2.7.4
