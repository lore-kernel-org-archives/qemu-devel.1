Received: from eggs.gnu.org ([209.51.188.92]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCn9-0003VS-BG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCn7-0008MQ-Ni
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:31 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:56533)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCn7-0008Kg-AR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:29 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu,  2 May 2019 23:34:07 +0900
Message-Id: <20190502143409.59600-11-ysato@users.sourceforge.jp>
In-Reply-To: <20190502143409.59600-1-ysato@users.sourceforge.jp>
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v8 10/12] Add rx-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, peter.maydell@linaro.org, richard.henderson@linaro.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 configure                      | 8 ++++++++
 default-configs/rx-softmmu.mak | 7 +++++++
 include/sysemu/arch_init.h     | 1 +
 arch_init.c                    | 2 ++
 hw/Kconfig                     | 1 +
 5 files changed, 19 insertions(+)
 create mode 100644 default-configs/rx-softmmu.mak

diff --git a/configure b/configure
index 60719ddcc5..71bd70bf8f 100755
--- a/configure
+++ b/configure
@@ -7545,6 +7545,11 @@ case "$target_name" in
     gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
     target_compiler=$cross_cc_riscv64
   ;;
+  rx)
+    TARGET_ARCH=rx
+    bflt="yes"
+    target_compiler=$cross_cc_rx
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
@@ -7765,6 +7770,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   riscv*)
     disas_config "RISCV"
   ;;
+  rx)
+    disas_config "RX"
+  ;;
   s390*)
     disas_config "S390"
   ;;
diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
new file mode 100644
index 0000000000..3f62f04e9b
--- /dev/null
+++ b/default-configs/rx-softmmu.mak
@@ -0,0 +1,7 @@
+# Default configuration for rx-softmmu
+
+CONFIG_SERIAL=y
+CONFIG_RX=y
+CONFIG_RENESAS_SCI=y
+CONFIG_RENESAS_TMR=y
+CONFIG_RENESAS_CMT=y
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 10cbafe970..3f4f844f7b 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -25,6 +25,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_RX = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/arch_init.c b/arch_init.c
index f4f3f610c8..cc25ddd7ca 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -74,6 +74,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_PPC
 #elif defined(TARGET_RISCV)
 #define QEMU_ARCH QEMU_ARCH_RISCV
+#elif defined(TARGET_RX)
+#define QEMU_ARCH QEMU_ARCH_RX
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
diff --git a/hw/Kconfig b/hw/Kconfig
index 88b9f15007..63a071092e 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -53,6 +53,7 @@ source nios2/Kconfig
 source openrisc/Kconfig
 source ppc/Kconfig
 source riscv/Kconfig
+source rx/Kconfig
 source s390x/Kconfig
 source sh4/Kconfig
 source sparc/Kconfig
-- 
2.11.0
