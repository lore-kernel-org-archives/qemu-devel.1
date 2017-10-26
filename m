Received: from eggs.gnu.org ([2001:4830:134:3::10]:44733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7io6-0005VS-Ni
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7io5-0001FJ-Ms
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7io5-0001EF-Gi
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:57 +0200
Message-Id: <20171026140404.21948-33-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/39] mips: use object_new() instead of
 gnew()+object_initialize()
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

object_initialize() is intended for inplace initialization of
objects, but here it's first allocated with g_new0() and then
initialized with object_initialize(). QEMU already has API
to do this (object_new), so do object creation with suitable
for usecase API.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-36-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mips/boston.c     | 3 +--
 hw/mips/mips_malta.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 776ee283e1..e815be6a6c 100644
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
index 2adb9bcf89..b6a58c7f21 100644
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
2.13.6
