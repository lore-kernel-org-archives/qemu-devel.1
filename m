Received: from eggs.gnu.org ([2001:4830:134:3::10]:49623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz1-0000Pr-Uh
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYyz-0000T5-On
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:27 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:47702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYyz-0000RT-GZ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:25 -0400
Received: by mail-pf0-x22e.google.com with SMTP id u12so118857pfl.4
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:25 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-103-167.tukw.qwest.net.
	[97.126.103.167]) by smtp.gmail.com with ESMTPSA id
	l85sm32473848pfb.176.2017.09.14.11.35.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Sep 2017 11:35:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:10 -0700
Message-Id: <20170914183516.19537-5-richard.henderson@linaro.org>
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/10] disas: Support the Capstone disassembler
 library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If configured, prefer this over our rather dated copy of the
GPLv2-only binutils.  This will be especially apparent with
the proposed vector extensions to TCG, as disas/i386.c does
not handle AVX.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/bfd.h      |  4 ++
 include/disas/capstone.h | 38 +++++++++++++++++++
 disas.c                  | 99 ++++++++++++++++++++++++++++++++++++++++++------
 configure                | 17 +++++++++
 4 files changed, 146 insertions(+), 12 deletions(-)
 create mode 100644 include/disas/capstone.h

diff --git a/include/disas/bfd.h b/include/disas/bfd.h
index b01e002b4c..0f4ecdeb88 100644
--- a/include/disas/bfd.h
+++ b/include/disas/bfd.h
@@ -377,6 +377,10 @@ typedef struct disassemble_info {
   /* Command line options specific to the target disassembler.  */
   char * disassembler_options;
 
+  /* Options for Capstone disassembly.  */
+  int cap_arch;
+  int cap_mode;
+
 } disassemble_info;
 
 

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
new file mode 100644
index 0000000000..84e214956d
--- /dev/null
+++ b/include/disas/capstone.h
@@ -0,0 +1,38 @@
+#ifndef QEMU_CAPSTONE_H
+#define QEMU_CAPSTONE_H 1
+
+#ifdef CONFIG_CAPSTONE
+
+#include <capstone.h>
+
+#else
+
+/* Just enough to allow backends to init without ifdefs.  */
+
+#define CS_ARCH_ARM     -1
+#define CS_ARCH_ARM64   -1
+#define CS_ARCH_MIPS    -1
+#define CS_ARCH_X86     -1
+#define CS_ARCH_PPC     -1
+#define CS_ARCH_SPARC   -1
+#define CS_ARCH_SYSZ    -1
+
+#define CS_MODE_LITTLE_ENDIAN    0
+#define CS_MODE_BIG_ENDIAN       0
+#define CS_MODE_ARM              0
+#define CS_MODE_16               0
+#define CS_MODE_32               0
+#define CS_MODE_64               0
+#define CS_MODE_THUMB            0
+#define CS_MODE_MCLASS           0
+#define CS_MODE_V8               0
+#define CS_MODE_MICRO            0
+#define CS_MODE_MIPS3            0
+#define CS_MODE_MIPS32R6         0
+#define CS_MODE_MIPSGP64         0
+#define CS_MODE_V9               0
+#define CS_MODE_MIPS32           0
+#define CS_MODE_MIPS64           0
+
+#endif /* CONFIG_CAPSTONE */
+#endif /* QEMU_CAPSTONE_H */
diff --git a/disas.c b/disas.c
index ad675dc361..76ea76b026 100644
--- a/disas.c
+++ b/disas.c
@@ -6,6 +6,7 @@
 
 #include "cpu.h"
 #include "disas/disas.h"
+#include "disas/capstone.h"
 
 typedef struct CPUDebug {
     struct disassemble_info info;
@@ -171,6 +172,57 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
     return print_insn_objdump(pc, info, "OBJD-T");
 }
 
+static bool cap_disas(disassemble_info *info, uint64_t pc, size_t size)
+{
+    bool ret = false;
+#ifdef CONFIG_CAPSTONE
+    csh handle;
+    cs_insn *insn;
+    uint8_t *buf;
+    const uint8_t *cbuf;
+    uint64_t pc_start;
+    cs_mode cap_mode = info->cap_mode;
+
+    cap_mode += (info->endian == BFD_ENDIAN_BIG ? CS_MODE_BIG_ENDIAN
+                 : CS_MODE_LITTLE_ENDIAN);
+
+    if (cs_open(info->cap_arch, cap_mode, &handle) != CS_ERR_OK) {
+        goto err0;
+    }
+
+    /* ??? There probably ought to be a better place to put this.  */
+    if (info->cap_arch == CS_ARCH_X86) {
+        /* We don't care about errors (if for some reason the library
+           is compiled without AT&T syntax); the user will just have
+           to deal with the Intel syntax.  */
+        cs_option(handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+    }
+
+    insn = cs_malloc(handle);
+    if (insn == NULL) {
+        goto err1;
+    }
+
+    cbuf = buf = g_malloc(size);
+    info->read_memory_func(pc, buf, size, info);
+
+    pc_start = pc;
+    while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
+        (*info->fprintf_func)(info->stream,
+                              "0x%08" PRIx64 ":  %-12s %s\n",
+                              pc_start, insn->mnemonic, insn->op_str);
+        pc_start = pc;
+    }
+    ret = true;
+
+    g_free(buf);
+ err1:
+    cs_close(&handle);
+ err0:
+#endif /* CONFIG_CAPSTONE */
+    return ret;
+}
+
 /* Disassemble this for me please... (debugging).  */
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
                   target_ulong size)
@@ -188,6 +240,8 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     s.info.buffer_vma = code;
     s.info.buffer_length = size;
     s.info.print_address_func = generic_print_address;
+    s.info.cap_arch = -1;
+    s.info.cap_mode = 0;
 
 #ifdef TARGET_WORDS_BIGENDIAN
     s.info.endian = BFD_ENDIAN_BIG;
@@ -199,6 +253,10 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
         cc->disas_set_info(cpu, &s.info);
     }
 
+    if (s.info.cap_arch >= 0 && cap_disas(&s.info, code, size)) {
+        return;
+    }
+
     if (s.info.print_insn == NULL) {
         s.info.print_insn = print_insn_od_target;
     }
@@ -206,18 +264,6 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     for (pc = code; size > 0; pc += count, size -= count) {
 	fprintf(out, "0x" TARGET_FMT_lx ":  ", pc);
 	count = s.info.print_insn(pc, &s.info);
-#if 0
-        {
-            int i;
-            uint8_t b;
-            fprintf(out, " {");
-            for(i = 0; i < count; i++) {
-                target_read_memory(pc + i, &b, 1, &s.info);
-                fprintf(out, " %02x", b);
-            }
-            fprintf(out, " }");
-        }
-#endif
 	fprintf(out, "\n");
 	if (count < 0)
 	    break;
@@ -245,6 +291,8 @@ void disas(FILE *out, void *code, unsigned long size)
     s.info.buffer = code;
     s.info.buffer_vma = (uintptr_t)code;
     s.info.buffer_length = size;
+    s.info.cap_arch = -1;
+    s.info.cap_mode = 0;
 
 #ifdef HOST_WORDS_BIGENDIAN
     s.info.endian = BFD_ENDIAN_BIG;
@@ -256,21 +304,34 @@ void disas(FILE *out, void *code, unsigned long size)
 #elif defined(__i386__)
     s.info.mach = bfd_mach_i386_i386;
     print_insn = print_insn_i386;
+    s.info.cap_arch = CS_ARCH_X86;
+    s.info.cap_mode = CS_MODE_32;
 #elif defined(__x86_64__)
     s.info.mach = bfd_mach_x86_64;
     print_insn = print_insn_i386;
+    s.info.cap_arch = CS_ARCH_X86;
+    s.info.cap_mode = CS_MODE_64;
 #elif defined(_ARCH_PPC)
     s.info.disassembler_options = (char *)"any";
     print_insn = print_insn_ppc;
+    s.info.cap_arch = CS_ARCH_PPC;
+# ifdef _ARCH_PPC64
+    s.info.cap_mode = CS_MODE_64;
+# endif
 #elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
     print_insn = print_insn_arm_a64;
+    s.info.cap_arch = CS_ARCH_ARM64;
 #elif defined(__alpha__)
     print_insn = print_insn_alpha;
 #elif defined(__sparc__)
     print_insn = print_insn_sparc;
     s.info.mach = bfd_mach_sparc_v9b;
+    s.info.cap_arch = CS_ARCH_SPARC;
+    s.info.cap_mode = CS_MODE_V9;
 #elif defined(__arm__)
     print_insn = print_insn_arm;
+    s.info.cap_arch = CS_ARCH_ARM;
+    /* TCG only generates code for arm mode.  */
 #elif defined(__MIPSEB__)
     print_insn = print_insn_big_mips;
 #elif defined(__MIPSEL__)
@@ -279,9 +340,15 @@ void disas(FILE *out, void *code, unsigned long size)
     print_insn = print_insn_m68k;
 #elif defined(__s390__)
     print_insn = print_insn_s390;
+    s.info.cap_arch = CS_ARCH_SYSZ;
 #elif defined(__hppa__)
     print_insn = print_insn_hppa;
 #endif
+
+    if (s.info.cap_arch >= 0 && cap_disas(&s.info, (uintptr_t)code, size)) {
+        return;
+    }
+
     if (print_insn == NULL) {
         print_insn = print_insn_od_host;
     }
@@ -357,6 +424,14 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
         cc->disas_set_info(cpu, &s.info);
     }
 
+    /* ??? Capstone requires that we copy the data into a host-addressable
+       buffer first and has no call-back to read more.  Therefore we need
+       an estimate of buffer size.  This will work for most RISC, but we'll
+       need to figure out something else for variable-length ISAs.  */
+    if (s.info.cap_arch >= 0 && cap_disas(&s.info, pc, 4 * nb_insn)) {
+        return;
+    }
+
     if (!s.info.print_insn) {
         monitor_printf(mon, "0x" TARGET_FMT_lx
                        ": Asm output not supported on this arch\n", pc);
diff --git a/configure b/configure
index fd7e3a5e81..a55a8eda8a 100755
--- a/configure
+++ b/configure
@@ -366,6 +366,7 @@ opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt="no"
 zlib="yes"
+capstone=""
 lzo=""
 snappy=""
 bzip2=""
@@ -4381,6 +4382,18 @@ EOF
 fi
 
 ##########################################
+# capstone
+
+if test "$capstone" != no; then
+  capstone=no
+  if $pkg_config capstone; then
+    capstone=yes
+    QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
+    LDFLAGS="$LDFLAGS $($pkg_config --libs capstone)"
+  fi
+fi
+
+##########################################
 # check if we have fdatasync
 
 fdatasync=no
@@ -5402,6 +5415,7 @@ echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
+echo "capstone          $capstone"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6050,6 +6064,9 @@ fi
 if test "$ivshmem" = "yes" ; then
   echo "CONFIG_IVSHMEM=y" >> $config_host_mak
 fi
+if test "$capstone" = "yes" ; then
+  echo "CONFIG_CAPSTONE=y" >> $config_host_mak
+fi
 
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
-- 
2.13.5
