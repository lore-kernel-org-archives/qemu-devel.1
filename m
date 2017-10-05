Received: from eggs.gnu.org ([2001:4830:134:3::10]:52985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZI-0007rN-O8
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZE-0000RI-Th
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06ZE-0000Qv-Nl
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:00 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:51:09 +0200
Message-Id: <1507211474-188400-36-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 35/40] mips: use object_new() instead of
 gnew()+object_initialize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, paul.burton@imgtec.com, aurelien@aurel32.net, yongbok.kim@imgtec.com

object_initialize() is intended for inplace initialization of
objects, but here it's first allocated with g_new0() and then
initialized with object_initialize(). QEMU already has API
to do this (object_new), so do object creation with suitable
for usecase API.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: paul.burton@imgtec.com
CC: aurelien@aurel32.net
CC: yongbok.kim@imgtec.com
---
 hw/mips/boston.c     | 3 +--
 hw/mips/mips_malta.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 776ee28..e815be6 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -460,7 +460,6 @@ static void boston_mach_init(MachineState *machine)
=20
     s =3D BOSTON(dev);
     s->mach =3D machine;
-    s->cps =3D g_new0(MIPSCPSState, 1);
=20
     if (!cpu_supports_cps_smp(cpu_model)) {
         error_report("Boston requires CPUs which support CPS");
@@ -469,7 +468,7 @@ static void boston_mach_init(MachineState *machine)
=20
     is_64b =3D cpu_supports_isa(cpu_model, ISA_MIPS64);
=20
-    object_initialize(s->cps, sizeof(MIPSCPSState), TYPE_MIPS_CPS);
+    s->cps =3D MIPS_CPS(object_new(TYPE_MIPS_CPS));
     qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
=20
     object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err=
);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2adb9bc..b6a58c7 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -949,9 +949,8 @@ static void create_cps(MaltaState *s, const char *cpu=
_model,
                        qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     Error *err =3D NULL;
-    s->cps =3D g_new0(MIPSCPSState, 1);
=20
-    object_initialize(s->cps, sizeof(MIPSCPSState), TYPE_MIPS_CPS);
+    s->cps =3D MIPS_CPS(object_new(TYPE_MIPS_CPS));
     qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
=20
     object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err=
);
--=20
2.7.4
