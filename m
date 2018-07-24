Received: from eggs.gnu.org ([2001:4830:134:3::10]:50725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhzMU-0002Kp-Ob
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhzMT-0003kz-OQ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:36:30 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 16:36:16 +0100
Message-Id: <20180724153616.32352-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] hw/misc/tz-mpc: Zero the LUT on
 initialization, not just reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>

In the tz-mpc device we allocate a data block for the LUT,
which we then clear to zero in the device's reset method.
This is conceptually fine, but unfortunately results in a
valgrind complaint about use of uninitialized data on startup:

==30906== Conditional jump or move depends on uninitialised value(s)
==30906==    at 0x503609: tz_mpc_translate (tz-mpc.c:439)
==30906==    by 0x3F3D90: address_space_translate_iommu (exec.c:511)
==30906==    by 0x3F3FF8: flatview_do_translate (exec.c:584)
==30906==    by 0x3F4292: flatview_translate (exec.c:644)
==30906==    by 0x3F2120: address_space_translate (memory.h:1962)
==30906==    by 0x3FB753: address_space_ldl_internal (memory_ldst.inc.c:36)
==30906==    by 0x3FB8A6: address_space_ldl (memory_ldst.inc.c:80)
==30906==    by 0x619037: ldl_phys (memory_ldst_phys.inc.h:25)
==30906==    by 0x61985D: arm_cpu_reset (cpu.c:255)
==30906==    by 0x98791B: cpu_reset (cpu.c:249)
==30906==    by 0x57FFDB: armv7m_reset (armv7m.c:265)
==30906==    by 0x7B1775: qemu_devices_reset (reset.c:69)

This is because of a reset ordering problem -- the TZ MPC
resets after the CPU, but an M-profile CPU's reset function
includes memory loads to get the initial PC and SP, which
then go through an MPC that hasn't yet been reset.

The simplest fix for this is to zero the LUT when we
initialize the data, which will result in the MPC's
translate function giving the right answers for these
early memory accesses.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I think the long-term solution is probably for the M profile
reset not to load PC and SP in its reset function (which
has other issues, like not interacting nicely with ROM
images which write to aliased memory regions), but that's
complicated...

 hw/misc/tz-mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 8316079b4bf..e0c58ba37ec 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -547,7 +547,7 @@ static void tz_mpc_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->blocked_io_as, &s->blocked_io,
                        "tz-mpc-blocked-io");
 
-    s->blk_lut = g_new(uint32_t, s->blk_max);
+    s->blk_lut = g_new0(uint32_t, s->blk_max);
 }
 
 static int tz_mpc_post_load(void *opaque, int version_id)
-- 
2.17.1
