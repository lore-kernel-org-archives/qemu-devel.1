Received: from eggs.gnu.org ([2001:4830:134:3::10]:34708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnBqv-0003RL-Uh
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnBqu-0002Fw-S1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:52:53 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnBqu-0002Fq-NT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:52:52 -0400
Received: by mail-qk0-x242.google.com with SMTP id o63so6479271qkb.5
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 15:52:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 30 Aug 2017 19:52:22 -0300
Message-Id: <20170830225225.27925-5-f4bug@amsat.org>
In-Reply-To: <20170830225225.27925-1-f4bug@amsat.org>
References: <20170830225225.27925-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/7] mips: call cpu_mips_realize_env() from
 mips_cpu_realizefn()
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
---
 target/mips/cpu.c       | 3 +++
 target/mips/translate.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 68bf423e9d..e3ef835599 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -123,6 +123,7 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info) {
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
+    MIPSCPU *cpu = MIPS_CPU(dev);
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
@@ -132,6 +133,8 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    cpu_mips_realize_env(&cpu->env);
+
     cpu_reset(cs);
     qemu_init_vcpu(cs);
 
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5fc7979ac5..94c38e8755 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20535,7 +20535,6 @@ MIPSCPU *cpu_mips_init(const char *cpu_model)
     cpu = MIPS_CPU(object_new(TYPE_MIPS_CPU));
     env = &cpu->env;
     env->cpu_model = def;
-    cpu_mips_realize_env(env);
 
     object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
 
-- 
2.14.1
