Received: from eggs.gnu.org ([2001:4830:134:3::10]:37799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0R-0004GF-QE
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0P-00080s-VZ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:49:59 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0P-00080K-RK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:49:57 -0400
Received: by mail-qk0-x243.google.com with SMTP id r66so2330044qke.4
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 12:49:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 20 Sep 2017 16:49:32 -0300
Message-Id: <20170920194934.23071-5-f4bug@amsat.org>
In-Reply-To: <20170920194934.23071-1-f4bug@amsat.org>
References: <20170920194934.23071-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 4/6] mips: call cpu_mips_realize_env() from
 mips_cpu_realizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>

This changes the order between cpu_mips_realize_env() and
cpu_exec_initfn(), but cpu_exec_initfn() don't have anything that
depends on cpu_mips_realize_env() being called first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
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
