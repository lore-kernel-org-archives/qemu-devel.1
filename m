Received: from eggs.gnu.org ([2001:4830:134:3::10]:34706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnBqv-0003RK-Td
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnBqr-0002FC-2g
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:52:53 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnBqq-0002F4-Us
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:52:49 -0400
Received: by mail-qk0-x242.google.com with SMTP id k126so3144037qkb.0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 15:52:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 30 Aug 2017 19:52:21 -0300
Message-Id: <20170830225225.27925-4-f4bug@amsat.org>
In-Reply-To: <20170830225225.27925-1-f4bug@amsat.org>
References: <20170830225225.27925-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/7] mips: split cpu_mips_realize_env() out
 of cpu_mips_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

so it can be used in mips_cpu_realizefn() in the next commit

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
---
 target/mips/internal.h  |  1 +
 target/mips/translate.c | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 91c2df4537..cf4c9db427 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -132,6 +132,7 @@ void mips_tcg_init(void);
 
 /* TODO QOM'ify CPU reset and remove */
 void cpu_state_reset(CPUMIPSState *s);
+void cpu_mips_realize_env(CPUMIPSState *env);
 
 /* cp0_timer.c */
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index f0febaf1b2..5fc7979ac5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20512,6 +20512,17 @@ void mips_tcg_init(void)
 
 #include "translate_init.c"
 
+void cpu_mips_realize_env(CPUMIPSState *env)
+{
+    env->exception_base = (int32_t)0xBFC00000;
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
     cpu = MIPS_CPU(object_new(TYPE_MIPS_CPU));
     env = &cpu->env;
     env->cpu_model = def;
-    env->exception_base = (int32_t)0xBFC00000;
-
-#ifndef CONFIG_USER_ONLY
-    mmu_init(env, def);
-#endif
-    fpu_init(env, def);
-    mvp_init(env, def);
+    cpu_mips_realize_env(env);
 
     object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
 
-- 
2.14.1
