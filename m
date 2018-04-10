Received: from eggs.gnu.org ([2001:4830:134:3::10]:57004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDV-0007w9-2W
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDT-0000lI-UL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDT-0000er-Mh
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDH-0007Zr-TM
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:14 +0100
Message-Id: <20180410121724.8549-3-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/12] hw/arm/integratorcp: Don't do things that
 could be fatal in the instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

An instance_init function must not fail - and might be called multiple times,
e.g. during device introspection with the 'device-list-properties' QMP
command. Since the integratorcm device ignores this rule, QEMU currently
aborts in this case (though it really should not):

echo "{'execute':'qmp_capabilities'}"\
     "{'execute':'device-list-properties',"\
     "'arguments':{'typename':'integrator_core'}}" \
     | arm-softmmu/qemu-system-arm -M integratorcp,accel=qtest -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
RAMBlock "integrator.flash" already registered, abort!
Aborted (core dumped)

Move the problematic code to the realize() function instead to fix this
problem.

Reviewed-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1522906473-11252-1-git-send-email-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index e8303b83be..58b40efc19 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -266,7 +266,6 @@ static const MemoryRegionOps integratorcm_ops = {
 static void integratorcm_init(Object *obj)
 {
     IntegratorCMState *s = INTEGRATOR_CM(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
     s->cm_osc = 0x01000048;
     /* ??? What should the high bits of this value be?  */
@@ -276,20 +275,28 @@ static void integratorcm_init(Object *obj)
     s->cm_init = 0x00000112;
     s->cm_refcnt_offset = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), 24,
                                    1000);
-    memory_region_init_ram(&s->flash, obj, "integrator.flash", 0x100000,
-                           &error_fatal);
 
-    memory_region_init_io(&s->iomem, obj, &integratorcm_ops, s,
-                          "integratorcm", 0x00800000);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    integratorcm_do_remap(s);
     /* ??? Save/restore.  */
 }
 
 static void integratorcm_realize(DeviceState *d, Error **errp)
 {
     IntegratorCMState *s = INTEGRATOR_CM(d);
+    SysBusDevice *dev = SYS_BUS_DEVICE(d);
+    Error *local_err = NULL;
+
+    memory_region_init_ram(&s->flash, OBJECT(d), "integrator.flash", 0x100000,
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
 
     if (s->memsz >= 256) {
         integrator_spd[31] = 64;
-- 
2.16.2
