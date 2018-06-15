Received: from eggs.gnu.org ([2001:4830:134:3::10]:60653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfQ-0001Xz-Uu
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfP-0006Az-M1
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfP-00065w-DW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfN-0003eQ-Su
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:29 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:48 +0100
Message-Id: <20180615142521.19143-11-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/43] hw/arm/armv7m: Remove unused
 armv7m_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove the now-unused armv7m_init() function. This was a legacy from
before we properly QOMified ARMv7M, and it has some flaws:

 * it combines work that needs to be done by an SoC object (creating
   and initializing the TYPE_ARMV7M object) with work that needs to
   be done by the board model (setting the system up to load the ELF
   file specified with -kernel)
 * TYPE_ARMV7M creation failure is fatal, but an SoC object wants to
   arrange to propagate the failure outward
 * it uses allocate-and-create via qdev_create() whereas the current
   preferred style for SoC objects is to do creation in-place

Board and SoC models can instead do the two jobs this function
was doing themselves, in the right places and with whatever their
preferred style/error handling is.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180601144328.23817-3-peter.maydell@linaro.org
---
 include/hw/arm/arm.h |  8 ++------
 hw/arm/armv7m.c      | 21 ---------------------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 70fa2287e2c..ffed39252d8 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -23,9 +23,6 @@ typedef enum {
     ARM_ENDIANNESS_BE32,
 } arm_endianness;
 
-/* armv7m.c */
-DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
-                         const char *kernel_filename, const char *cpu_type);
 /**
  * armv7m_load_kernel:
  * @cpu: CPU
@@ -33,9 +30,8 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
  * @mem_size: mem_size: maximum image size to load
  *
  * Load the guest image for an ARMv7M system. This must be called by
- * any ARMv7M board, either directly or via armv7m_init(). (This is
- * necessary to ensure that the CPU resets correctly on system reset,
- * as well as for kernel loading.)
+ * any ARMv7M board. (This is necessary to ensure that the CPU resets
+ * correctly on system reset, as well as for kernel loading.)
  */
 void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
 
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index f123cc7d3d2..a4ab7d20696 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -261,27 +261,6 @@ static void armv7m_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-/* Init CPU and memory for a v7-M based board.
-   mem_size is in bytes.
-   Returns the ARMv7M device.  */
-
-DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
-                         const char *kernel_filename, const char *cpu_type)
-{
-    DeviceState *armv7m;
-
-    armv7m = qdev_create(NULL, TYPE_ARMV7M);
-    qdev_prop_set_uint32(armv7m, "num-irq", num_irq);
-    qdev_prop_set_string(armv7m, "cpu-type", cpu_type);
-    object_property_set_link(OBJECT(armv7m), OBJECT(get_system_memory()),
-                                     "memory", &error_abort);
-    /* This will exit with an error if the user passed us a bad cpu_type */
-    qdev_init_nofail(armv7m);
-
-    armv7m_load_kernel(ARM_CPU(first_cpu), kernel_filename, mem_size);
-    return armv7m;
-}
-
 void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
 {
     int image_size;
-- 
2.17.1
