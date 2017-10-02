Received: from eggs.gnu.org ([2001:4830:134:3::10]:47264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiq-0002W4-1f
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywin-0006JY-A8
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywin-0006J8-4h
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:05 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:15 +0200
Message-Id: <1506935300-132598-34-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 33/38] mips: use object_new() instead of
 gnew()+object_initialize()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, paul.burton@imgtec.com, aurelien@aurel32.net, yongbok.kim@imgtec.com
List-ID: <qemu-devel.nongnu.org>

object_initialize() is intended for inplace initialization of
objects, but here it's first allocated with g_new0() and then
initialized with object_initialize(). QEMU already has API
to do this (object_new), so do object creation with suitable
for usecase API.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
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
 
     s = BOSTON(dev);
     s->mach = machine;
-    s->cps = g_new0(MIPSCPSState, 1);
 
     if (!cpu_supports_cps_smp(cpu_model)) {
         error_report("Boston requires CPUs which support CPS");
@@ -469,7 +468,7 @@ static void boston_mach_init(MachineState *machine)
 
     is_64b = cpu_supports_isa(cpu_model, ISA_MIPS64);
 
-    object_initialize(s->cps, sizeof(MIPSCPSState), TYPE_MIPS_CPS);
+    s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
     qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
 
     object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2adb9bc..b6a58c7 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -949,9 +949,8 @@ static void create_cps(MaltaState *s, const char *cpu_model,
                        qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     Error *err = NULL;
-    s->cps = g_new0(MIPSCPSState, 1);
 
-    object_initialize(s->cps, sizeof(MIPSCPSState), TYPE_MIPS_CPS);
+    s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
     qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
 
     object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err);
-- 
2.7.4
