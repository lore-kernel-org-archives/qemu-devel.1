Received: from eggs.gnu.org ([2001:4830:134:3::10]:36182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMcAL-0007Sq-6L
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMbxD-0004AN-BF
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:54:25 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 13 Nov 2018 17:52:47 +0100
Message-Id: <20181113165247.4806-14-sameo@linux.intel.com>
In-Reply-To: <20181113165247.4806-1-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/13] target: arm: Do not build TCG objects
 when TCG is off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, qemu-arm@nongnu.org

We can now safely turn all TCG dependent build off when CONFIG_TCG is
off. This allows building ARM binaries with --disable-tcg.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
---
 target/arm/Makefile.objs | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 8e513748e3..3f59bf1685 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -1,9 +1,10 @@
 obj-y += arm-semi.o crypto_helper.o gdbstub.o helper.o cpu.o
-obj-y += translate.o op_helper.o neon_helper.o
-obj-y += iwmmxt_helper.o vec_helper.o m_helper.o
-obj-y += excp_helper.o vfp_helper.o
+obj-$(CONFIG_TCG) += translate.o op_helper.o neon_helper.o
+obj-$(CONFIG_TCG) += iwmmxt_helper.o vec_helper.o m_helper.o
+obj-$(CONFIG_TCG) += excp_helper.o vfp_helper.o
 
-obj-$(CONFIG_SOFTMMU) += machine.o psci.o arch_dump.o monitor.o arm-powerctl.o
+obj-$(CONFIG_SOFTMMU) += machine.o arch_dump.o monitor.o arm-powerctl.o
+obj-$(call land,$(CONFIG_TCG),$(CONFIG_SOFTMMU)) += psci.o
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
 obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
@@ -17,5 +18,6 @@ target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
 	  "GEN", $(TARGET_DIR)$@)
 
 target/arm/translate-sve.o: target/arm/decode-sve.inc.c
-obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
-obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
+obj-$(call land,$(CONFIG_TCG),$(TARGET_AARCH64)) += translate-sve.o sve_helper.o
+obj-$(call land,$(CONFIG_TCG),$(TARGET_AARCH64)) += translate-a64.o helper-a64.o
+obj-$(TARGET_AARCH64) += cpu64.o gdbstub64.o
-- 
2.19.1
