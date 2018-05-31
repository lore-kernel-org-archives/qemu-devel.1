Received: from eggs.gnu.org ([2001:4830:134:3::10]:41602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUu-0000rR-3I
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUt-0006W6-3O
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUs-0006SF-Sx
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUl-0002qL-5W
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:38 +0100
Message-Id: <20180531142357.904-7-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/25] arm: fix qemu crash on startup with -bios
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

When QEMU is started with following CLI
 -machine virt,gic-version=3,accel=kvm -cpu host -bios AAVMF_CODE.fd
it crashes with abort at
 accel/kvm/kvm-all.c:2164:
 KVM_SET_DEVICE_ATTR failed: Group 6 attr 0x000000000000c665: Invalid argument

Which is caused by implicit dependency of kvm_arm_gicv3_reset() on
arm_gicv3_icc_reset() where the later is called by CPU reset
reset callback.

However commit:
 3b77f6c arm/boot: split load_dtb() from arm_load_kernel()
broke CPU reset callback registration in case

  arm_load_kernel()
      ...
      if (!info->kernel_filename || info->firmware_loaded)

branch is taken, i.e. it's sufficient to provide a firmware
or do not provide kernel on CLI to skip cpu reset callback
registration, where before offending commit the callback
has been registered unconditionally.

Fix it by registering the callback right at the beginning of
arm_load_kernel() unconditionally instead of doing it at the end.

NOTE:
 we probably should eliminate that dependency anyways as well as
 separate arch CPU reset parts from arm_load_kernel() into CPU
 itself, but that refactoring that I probably would have to do
 anyways later for CPU hotplug to work.

Reported-by: Auger Eric <eric.auger@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1527070950-208350-1-git-send-email-imammedo@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9496f331a8..1e481662ad 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -926,6 +926,15 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     static const ARMInsnFixup *primary_loader;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
+    /* CPU objects (unlike devices) are not automatically reset on system
+     * reset, so we must always register a handler to do so. If we're
+     * actually loading a kernel, the handler is also responsible for
+     * arranging that we start it correctly.
+     */
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
+        qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
+    }
+
     /* The board code is not supposed to set secure_board_setup unless
      * running its code in secure mode is actually possible, and KVM
      * doesn't support secure.
@@ -1143,15 +1152,6 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
         ARM_CPU(cs)->env.boot_info = info;
     }
 
-    /* CPU objects (unlike devices) are not automatically reset on system
-     * reset, so we must always register a handler to do so. If we're
-     * actually loading a kernel, the handler is also responsible for
-     * arranging that we start it correctly.
-     */
-    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
-        qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
-    }
-
     if (!info->skip_dtb_autoload && have_dtb(info)) {
         if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
             exit(1);
-- 
2.17.1
