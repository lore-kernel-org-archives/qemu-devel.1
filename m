Received: from eggs.gnu.org ([2001:4830:134:3::10]:33488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1ge-0007gT-DQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gY-0006pz-Hm
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:40 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:3495)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gY-0006pe-BY
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:34 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 21 Sep 2017 14:38:08 +0100
Message-ID: <1506001091-8296-5-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
References: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/7] mips: call cpu_mips_realize_env() from
 mips_cpu_realizefn()
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

This changes the order between cpu_mips_realize_env() and
cpu_exec_initfn(), but cpu_exec_initfn() don't have anything that
depends on cpu_mips_realize_env() being called first.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/cpu.c       | 3 +++
 target/mips/translate.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 68bf423..e3ef835 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -123,6 +123,7 @@ static void mips_cpu_disas_set_info(CPUState *s, disa=
ssemble_info *info) {
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs =3D CPU(dev);
+    MIPSCPU *cpu =3D MIPS_CPU(dev);
     MIPSCPUClass *mcc =3D MIPS_CPU_GET_CLASS(dev);
     Error *local_err =3D NULL;
=20
@@ -132,6 +133,8 @@ static void mips_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
         return;
     }
=20
+    cpu_mips_realize_env(&cpu->env);
+
     cpu_reset(cs);
     qemu_init_vcpu(cs);
=20
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5fc7979..94c38e8 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20535,7 +20535,6 @@ MIPSCPU *cpu_mips_init(const char *cpu_model)
     cpu =3D MIPS_CPU(object_new(TYPE_MIPS_CPU));
     env =3D &cpu->env;
     env->cpu_model =3D def;
-    cpu_mips_realize_env(env);
=20
     object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
=20
--=20
2.7.4
