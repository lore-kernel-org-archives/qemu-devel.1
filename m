Received: from eggs.gnu.org ([2001:4830:134:3::10]:44288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3xXt-0002jk-QN
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 01:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3xXs-0005mQ-Uk
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 01:34:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  5 Apr 2018 07:34:33 +0200
Message-Id: <1522906473-11252-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] hw/arm/integratorcp: Don't do things that
 could be fatal in the instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

An instance_init function must not fail - and might be called multiple ti=
mes,
e.g. during device introspection with the 'device-list-properties' QMP
command. Since the integratorcm device ignores this rule, QEMU currently
aborts in this case (though it really should not):

echo "{'execute':'qmp_capabilities'}"\
     "{'execute':'device-list-properties',"\
     "'arguments':{'typename':'integrator_core'}}" \
     | arm-softmmu/qemu-system-arm -M integratorcp,accel=3Dqtest -qmp std=
io
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
RAMBlock "integrator.flash" already registered, abort!
Aborted (core dumped)

Move the problematic code to the realize() function instead to fix this
problem.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use "OBJECT(d)" instead of "(Object *)d"

 hw/arm/integratorcp.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index e8303b8..58b40ef 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -266,7 +266,6 @@ static const MemoryRegionOps integratorcm_ops =3D {
 static void integratorcm_init(Object *obj)
 {
     IntegratorCMState *s =3D INTEGRATOR_CM(obj);
-    SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
=20
     s->cm_osc =3D 0x01000048;
     /* ??? What should the high bits of this value be?  */
@@ -276,20 +275,28 @@ static void integratorcm_init(Object *obj)
     s->cm_init =3D 0x00000112;
     s->cm_refcnt_offset =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUA=
L), 24,
                                    1000);
-    memory_region_init_ram(&s->flash, obj, "integrator.flash", 0x100000,
-                           &error_fatal);
=20
-    memory_region_init_io(&s->iomem, obj, &integratorcm_ops, s,
-                          "integratorcm", 0x00800000);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    integratorcm_do_remap(s);
     /* ??? Save/restore.  */
 }
=20
 static void integratorcm_realize(DeviceState *d, Error **errp)
 {
     IntegratorCMState *s =3D INTEGRATOR_CM(d);
+    SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
+    Error *local_err =3D NULL;
+
+    memory_region_init_ram(&s->flash, OBJECT(d), "integrator.flash", 0x1=
00000,
+                           &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(d), &integratorcm_ops, s,
+                          "integratorcm", 0x00800000);
+    sysbus_init_mmio(dev, &s->iomem);
+
+    integratorcm_do_remap(s);
=20
     if (s->memsz >=3D 256) {
         integrator_spd[31] =3D 64;
--=20
1.8.3.1
