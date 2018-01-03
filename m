Received: from eggs.gnu.org ([2001:4830:134:3::10]:59093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXDI-00069u-Bw
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXDF-0008UC-8I
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:47:24 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWXDF-0008Tb-0H
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:47:21 -0500
Received: by mail-pl0-x242.google.com with SMTP id n13so133442plp.11
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:47:20 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  3 Jan 2018 13:44:25 +1300
Message-Id: <1514940265-18093-22-git-send-email-mjc@sifive.com>
In-Reply-To: <1514940265-18093-1-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

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
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 Makefile.objs                          |  1 +
 arch_init.c                            |  2 ++
 configure                              | 11 +++++++++++
 cpus.c                                 |  6 ++++++
 default-configs/riscv32-linux-user.mak |  1 +
 default-configs/riscv32-softmmu.mak    |  4 ++++
 default-configs/riscv64-linux-user.mak |  1 +
 default-configs/riscv64-softmmu.mak    |  4 ++++
 hw/riscv/Makefile.objs                 | 12 ++++++++++++
 include/sysemu/arch_init.h             |  1 +
 qapi-schema.json                       | 14 +++++++++++++-
 scripts/qemu-binfmt-conf.sh            | 13 ++++++++++++-
 target/riscv/Makefile.objs             |  2 ++
 target/riscv/trace-events              |  1 +
 14 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/riscv32-linux-user.mak
 create mode 100644 default-configs/riscv32-softmmu.mak
 create mode 100644 default-configs/riscv64-linux-user.mak
 create mode 100644 default-configs/riscv64-softmmu.mak
 create mode 100644 hw/riscv/Makefile.objs
 create mode 100644 target/riscv/Makefile.objs
 create mode 100644 target/riscv/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 285c6f3..ae8658e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -164,6 +164,7 @@ trace-events-subdirs += target/mips
 trace-events-subdirs += target/sparc
 trace-events-subdirs += target/s390x
 trace-events-subdirs += target/ppc
+trace-events-subdirs += target/riscv
 trace-events-subdirs += qom
 trace-events-subdirs += linux-user
 trace-events-subdirs += qapi
diff --git a/arch_init.c b/arch_init.c
index a0b8ed6..dcf356b 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -69,6 +69,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_OPENRISC
 #elif defined(TARGET_PPC)
 #define QEMU_ARCH QEMU_ARCH_PPC
+#elif defined(TARGET_RISCV)
+#define QEMU_ARCH QEMU_ARCH_RISCV
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
diff --git a/configure b/configure
index 100309c..832e025 100755
--- a/configure
+++ b/configure
@@ -6530,6 +6530,14 @@ case "$target_name" in
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
+  riscv32)
+    TARGET_BASE_ARCH=riscv
+    TARGET_ABI_DIR=riscv
+  ;;
+  riscv64)
+    TARGET_BASE_ARCH=riscv
+    TARGET_ABI_DIR=riscv
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
@@ -6692,6 +6700,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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
index 83700c1..702da8b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1909,6 +1909,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #elif defined(TARGET_SPARC)
         SPARCCPU *sparc_cpu = SPARC_CPU(cpu);
         CPUSPARCState *env = &sparc_cpu->env;
+#elif defined(TARGET_RISCV)
+        RISCVCPU *riscv_cpu = RISCV_CPU(cpu);
+        CPURISCVState *env = &riscv_cpu->env;
 #elif defined(TARGET_MIPS)
         MIPSCPU *mips_cpu = MIPS_CPU(cpu);
         CPUMIPSState *env = &mips_cpu->env;
@@ -1942,6 +1945,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
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
index 0000000..a0c31ae
--- /dev/null
+++ b/hw/riscv/Makefile.objs
@@ -0,0 +1,12 @@
+obj-y += riscv_elf.o
+obj-y += riscv_htif.o
+obj-y += riscv_hart.o
+obj-y += sifive_e300.o
+obj-y += sifive_clint.o
+obj-y += sifive_prci.o
+obj-y += sifive_plic.o
+obj-y += sifive_u500.o
+obj-y += sifive_uart.o
+obj-y += spike_v1_09.o
+obj-y += spike_v1_10.o
+obj-y += virt.o
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 8751c46..63c6152 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_MOXIE = (1 << 15),
     QEMU_ARCH_TRICORE = (1 << 16),
     QEMU_ARCH_NIOS2 = (1 << 17),
+    QEMU_ARCH_RISCV = (1 << 18),
 };
 
 extern const uint32_t arch_type;
diff --git a/qapi-schema.json b/qapi-schema.json
index 5c06745..a69c9fe 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -413,7 +413,7 @@
 # Since: 2.6
 ##
 { 'enum': 'CpuInfoArch',
-  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
+  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'riscv', 'other' ] }
 
 ##
 # @CpuInfo:
@@ -452,6 +452,7 @@
             'ppc': 'CpuInfoPPC',
             'mips': 'CpuInfoMIPS',
             'tricore': 'CpuInfoTricore',
+            'riscv': 'CpuInfoRISCV',
             'other': 'CpuInfoOther' } }
 
 ##
@@ -512,6 +513,17 @@
 { 'struct': 'CpuInfoTricore', 'data': { 'PC': 'int' } }
 
 ##
+# @CpuInfoRISCV:
+#
+# Additional information about a virtual RISCV CPU
+#
+# @pc: the instruction pointer
+#
+# Since 2.8
+##
+{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
+
+##
 # @CpuInfoOther:
 #
 # No additional information is available about the virtual CPU
diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 8afc3eb..c5ac660 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -4,7 +4,7 @@
 
 qemu_target_list="i386 i486 alpha arm sparc32plus ppc ppc64 ppc64le m68k \
 mips mipsel mipsn32 mipsn32el mips64 mips64el \
-sh4 sh4eb s390x aarch64 hppa"
+sh4 sh4eb s390x aarch64 hppa riscv32 riscv64"
 
 i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
 i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
@@ -96,6 +96,14 @@ hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00
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
@@ -117,6 +125,9 @@ qemu_get_family() {
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
index 0000000..0c08263
--- /dev/null
+++ b/target/riscv/Makefile.objs
@@ -0,0 +1,2 @@
+obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o \
+	user_syscall.o user_atomic.o gdbstub.o pmp.o
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
new file mode 100644
index 0000000..9284b1f
--- /dev/null
+++ b/target/riscv/trace-events
@@ -0,0 +1 @@
+# See docs/devel/tracing.txt for syntax documentation.
-- 
2.7.0
