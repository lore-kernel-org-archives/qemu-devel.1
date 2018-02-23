Received: from eggs.gnu.org ([2001:4830:134:3::10]:32786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ep11a-0001Yd-Me
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ep10p-0007IP-IA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:15:42 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:46125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ep10o-0007Ft-W1
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:14:55 -0500
Received: by mail-pf0-x244.google.com with SMTP id z24so2771627pfh.13
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 16:14:54 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 23 Feb 2018 13:12:09 +1300
Message-Id: <1519344729-73482-24-git-send-email-mjc@sifive.com>
In-Reply-To: <1519344729-73482-1-git-send-email-mjc@sifive.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 23/23] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

This adds RISC-V into the build system enabling the following targets:

- riscv32-softmmu
- riscv64-softmmu
- riscv32-linux-user
- riscv64-linux-user

This adds defaults configs for RISC-V, enables the build for the RISC-V
CPU core, hardware, and Linux User Emulation. The 'qemu-binfmt-conf.sh'
script is updated to add the RISC-V ELF magic.

Expected checkpatch errors for consistency reasons:

ERROR: line over 90 characters
FILE: scripts/qemu-binfmt-conf.sh

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 Makefile.objs                          |  1 +
 arch_init.c                            |  2 ++
 configure                              | 13 +++++++++++++
 cpus.c                                 |  6 ++++++
 default-configs/riscv32-linux-user.mak |  1 +
 default-configs/riscv32-softmmu.mak    |  4 ++++
 default-configs/riscv64-linux-user.mak |  1 +
 default-configs/riscv64-softmmu.mak    |  4 ++++
 hw/riscv/Makefile.objs                 | 12 ++++++++++++
 include/sysemu/arch_init.h             |  1 +
 qapi-schema.json                       | 16 +++++++++++++++-
 scripts/qemu-binfmt-conf.sh            | 13 ++++++++++++-
 target/riscv/Makefile.objs             |  1 +
 target/riscv/trace-events              |  1 +
 14 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/riscv32-linux-user.mak
 create mode 100644 default-configs/riscv32-softmmu.mak
 create mode 100644 default-configs/riscv64-linux-user.mak
 create mode 100644 default-configs/riscv64-softmmu.mak
 create mode 100644 hw/riscv/Makefile.objs
 create mode 100644 target/riscv/Makefile.objs
 create mode 100644 target/riscv/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 5dc1348..180c8ac 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -171,6 +171,7 @@ trace-events-subdirs += target/mips
 trace-events-subdirs += target/sparc
 trace-events-subdirs += target/s390x
 trace-events-subdirs += target/ppc
+trace-events-subdirs += target/riscv
 trace-events-subdirs += qom
 trace-events-subdirs += linux-user
 trace-events-subdirs += qapi
diff --git a/arch_init.c b/arch_init.c
index 4c36f2b..e157619 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -71,6 +71,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_OPENRISC
 #elif defined(TARGET_PPC)
 #define QEMU_ARCH QEMU_ARCH_PPC
+#elif defined(TARGET_RISCV)
+#define QEMU_ARCH QEMU_ARCH_RISCV
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
diff --git a/configure b/configure
index ed45a3c..a57fcac 100755
--- a/configure
+++ b/configure
@@ -6785,6 +6785,16 @@ case "$target_name" in
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
+  riscv32)
+    TARGET_BASE_ARCH=riscv
+    TARGET_ABI_DIR=riscv
+    mttcg=yes
+  ;;
+  riscv64)
+    TARGET_BASE_ARCH=riscv
+    TARGET_ABI_DIR=riscv
+    mttcg=yes
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
@@ -6954,6 +6964,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   ppc*)
     disas_config "PPC"
   ;;
+  riscv)
+    disas_config "RISCV"
+  ;;
   s390*)
     disas_config "S390"
   ;;
diff --git a/cpus.c b/cpus.c
index f298b65..91424ba 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2094,6 +2094,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #elif defined(TARGET_SPARC)
         SPARCCPU *sparc_cpu = SPARC_CPU(cpu);
         CPUSPARCState *env = &sparc_cpu->env;
+#elif defined(TARGET_RISCV)
+        RISCVCPU *riscv_cpu = RISCV_CPU(cpu);
+        CPURISCVState *env = &riscv_cpu->env;
 #elif defined(TARGET_MIPS)
         MIPSCPU *mips_cpu = MIPS_CPU(cpu);
         CPUMIPSState *env = &mips_cpu->env;
@@ -2127,6 +2130,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #elif defined(TARGET_TRICORE)
         info->value->arch = CPU_INFO_ARCH_TRICORE;
         info->value->u.tricore.PC = env->PC;
+#elif defined(TARGET_RISCV)
+        info->value->arch = CPU_INFO_ARCH_RISCV;
+        info->value->u.riscv.pc = env->pc;
 #else
         info->value->arch = CPU_INFO_ARCH_OTHER;
 #endif
diff --git a/default-configs/riscv32-linux-user.mak b/default-configs/riscv32-linux-user.mak
new file mode 100644
index 0000000..865b362
--- /dev/null
+++ b/default-configs/riscv32-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for riscv-linux-user
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
new file mode 100644
index 0000000..f9e7421
--- /dev/null
+++ b/default-configs/riscv32-softmmu.mak
@@ -0,0 +1,4 @@
+# Default configuration for riscv-softmmu
+
+CONFIG_SERIAL=y
+CONFIG_VIRTIO=y
diff --git a/default-configs/riscv64-linux-user.mak b/default-configs/riscv64-linux-user.mak
new file mode 100644
index 0000000..865b362
--- /dev/null
+++ b/default-configs/riscv64-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for riscv-linux-user
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
new file mode 100644
index 0000000..f9e7421
--- /dev/null
+++ b/default-configs/riscv64-softmmu.mak
@@ -0,0 +1,4 @@
+# Default configuration for riscv-softmmu
+
+CONFIG_SERIAL=y
+CONFIG_VIRTIO=y
diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
new file mode 100644
index 0000000..23f684b
--- /dev/null
+++ b/hw/riscv/Makefile.objs
@@ -0,0 +1,12 @@
+obj-y += riscv_htif.o
+obj-y += riscv_hart.o
+obj-y += sifive_e300.o
+obj-y += sifive_clint.o
+obj-y += sifive_prci.o
+obj-y += sifive_plic.o
+obj-y += sifive_test.o
+obj-y += sifive_u500.o
+obj-y += sifive_uart.o
+obj-y += spike_v1_09.o
+obj-y += spike_v1_10.o
+obj-y += virt.o
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index d40d882..ef52ae0 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_TRICORE = (1 << 16),
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
+    QEMU_ARCH_RISCV = (1 << 19),
 };
 
 extern const uint32_t arch_type;
diff --git a/qapi-schema.json b/qapi-schema.json
index 0262b9f..d288662 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -410,10 +410,12 @@
 # An enumeration of cpu types that enable additional information during
 # @query-cpus.
 #
+# @riscv: since 2.12
+#
 # Since: 2.6
 ##
 { 'enum': 'CpuInfoArch',
-  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
+  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'riscv', 'other' ] }
 
 ##
 # @CpuInfo:
@@ -452,6 +454,7 @@
             'ppc': 'CpuInfoPPC',
             'mips': 'CpuInfoMIPS',
             'tricore': 'CpuInfoTricore',
+            'riscv': 'CpuInfoRISCV',
             'other': 'CpuInfoOther' } }
 
 ##
@@ -512,6 +515,17 @@
 { 'struct': 'CpuInfoTricore', 'data': { 'PC': 'int' } }
 
 ##
+# @CpuInfoRISCV:
+#
+# Additional information about a virtual RISCV CPU
+#
+# @pc: the instruction pointer
+#
+# Since 2.12
+##
+{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
+
+##
 # @CpuInfoOther:
 #
 # No additional information is available about the virtual CPU
diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index ea5a748..bdb21bd 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -4,7 +4,7 @@
 
 qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
 mips mipsel mipsn32 mipsn32el mips64 mips64el \
-sh4 sh4eb s390x aarch64 aarch64_be hppa"
+sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64"
 
 i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
 i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
@@ -100,6 +100,14 @@ hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00
 hppa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 hppa_family=hppa
 
+riscv32_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'
+riscv32_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
+riscv32_family=riscv
+
+riscv64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'
+riscv64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
+riscv64_family=riscv
+
 qemu_get_family() {
     cpu=${HOST_ARCH:-$(uname -m)}
     case "$cpu" in
@@ -124,6 +132,9 @@ qemu_get_family() {
     sparc*)
         echo "sparc"
         ;;
+    riscv*)
+        echo "riscv"
+        ;;
     *)
         echo "$cpu"
         ;;
diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
new file mode 100644
index 0000000..abd0a7c
--- /dev/null
+++ b/target/riscv/Makefile.objs
@@ -0,0 +1 @@
+obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
new file mode 100644
index 0000000..9284b1f
--- /dev/null
+++ b/target/riscv/trace-events
@@ -0,0 +1 @@
+# See docs/devel/tracing.txt for syntax documentation.
-- 
2.7.0
