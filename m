Received: from eggs.gnu.org ([208.118.235.92]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezqh4-0000I1-TZ
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezqg0-0008SV-Tn
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:27:18 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:33003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezqg0-0008Qt-GF
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:26:12 -0400
Received: by mail-pg0-x22b.google.com with SMTP id i194so1649551pgd.0
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 14:26:12 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 14:24:38 -0700
Message-Id: <1521926678-76539-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1] RISC-V: RISC-V TCG backend work in progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>

This patch adds an experimental RISC-V TCG backend.

We have been dogfooding the RISC-V QEMU front-end with Fedora
to develop a RISC-V TCG backend. The RISC-V TCG backend can
be built inside of the QEMU RISC-V 'virt' machine using
the Fedora stage 4 disk image:

- https://fedoraproject.org/wiki/Architectures/RISC-V

Below are brief instructions on building riscv64-linux-user
and x86_64-linux-user QEMU inside a Fedora RISC-V environment
using either QEMU RISC-V or SiFive's HiFive Unleashed board:

```
sudo dnf install git python flex bison \
    zlib-devel glib2-devel pixman-devel
git clone --recursive https://github.com/michaeljclark/riscv-qemu.git
cd riscv-qemu
git checkout wip-riscv-tcg-backend
./configure \
    --prefix=/opt/riscv/qemu \
    --disable-capstone \
    --target-list=riscv64-linux-user,x86_64-linux-user
make -j$(nproc)
```

Testing

There is a user-mode version of riscv-tests that can
be used for testing RISC-V QEMU linux-user.

- https://github.com/arsv/riscv-qemu-tests

These tests can also be used to test the RISC-V TCG
back-end via the RISC-V front-end. e.g.

```
for ext in i m a f d; do
    for i in $(find rv64${ext} -type f -a -executable); do
        echo $i
        ../riscv-qemu/riscv64-linux-user/qemu-riscv64 $i
    done
done
```

At present the Base ISA tests pass except for mulhu and mulhsu
when compiled using the riscv newlib toolchain. When running
with --singlestep, all tests pass. Note: TCG performs constant
folding so in some cases the tests can be eliminated in the
TCG optimizer because constants are constructed as immediate
operands instead of being loaded from the data section.

```
    $ sh run-tests.sh
    rv64i/sub
    rv64i/srai
    rv64i/slti
    rv64i/sltu
    rv64i/lwu
    rv64i/ori
    rv64i/addw
    rv64i/lw
    rv64i/subw
    rv64i/xori
    rv64i/jal
    rv64i/sb
    rv64i/blt
    rv64i/slt
    rv64i/bgeu
    rv64i/bne
    rv64i/add
    rv64i/and
    rv64i/lui
    rv64i/sll
    rv64i/slliw
    rv64i/aiupc
    rv64i/bge
    rv64i/sltiu
    rv64i/jalr
    rv64i/srli
    rv64i/beq
    rv64i/lb
    rv64i/sw
    rv64i/sra
    rv64i/lhu
    rv64i/andi
    rv64i/addi
    rv64i/sraiw
    rv64i/srliw
    rv64i/srlw
    rv64i/xor
    rv64i/sllw
    rv64i/slli
    rv64i/or
    rv64i/lbu
    rv64i/bltu
    rv64i/srl
    rv64i/ld
    rv64i/sd
    rv64i/sraw
    rv64m/mulhu
    FAIL
    rv64m/divuw
    rv64m/mulhsu
    FAIL
    rv64m/mulh
    rv64m/divw
    rv64m/divu
    rv64m/remw
    rv64m/remu
    rv64m/rem
    rv64m/remuw
    rv64m/mul
    rv64m/div
    rv64m/mulw
    rv64a/amoswap_w
    rv64a/amoor_w
    rv64a/amoadd_d
    rv64a/amoand_w
    rv64a/amomax_w
    rv64a/amoor_d
    rv64a/amominu_d
    rv64a/lrsc_d
    rv64a/amomin_w
    rv64a/zero
    rv64a/amomaxu_d
    rv64a/amoxor_w
    rv64a/amoxor_d
    rv64a/amomaxu_w
    rv64a/amoadd_w
    rv64a/amominu_w
    rv64a/amoand_d
    rv64a/amomin_d
    rv64a/amoswap_d
    rv64a/amomax_d
    rv64a/lrsc_w
    rv64f/movex
    rv64f/ldst
    rv64f/fsgnj
    rv64f/fadd
    rv64f/fcvt
    rv64f/move
    rv64f/recoding
    rv64f/fdiv
    rv64f/fcvt_w
    rv64f/fmin
    rv64f/fclass
    rv64f/fcmp
    rv64f/fmadd
    rv64d/ldst
    rv64d/fsgnj
    rv64d/fadd
    rv64d/fcvt
    rv64d/move
    rv64d/recoding
    rv64d/fdiv
    rv64d/fcvt_w
    rv64d/fmin
    rv64d/fclass
    rv64d/fmadd
```

Many of the rv8-bench tests compiled for riscv64 and x86_64
will run (using musl-libc via the musl-riscv-toolchain):

- https://github.com/rv8-io/musl-riscv-toolchain/
- https://github.com/rv8-io/rv8-bench/
- https://rv8.io/bench

Running with `-d in_asm,op,op_opt,out_asm` is very helpful
for debugging. Note: due to a limitation in QEMU, the backend
disassembler is not compiled, unless the backend matches
the front-end, so `scripts/disas-objdump.pl` is required
to decode the emmitted RISC-V assembly when using the x86_64
front-end. When using the RISC-V front-end, the back-end
disassembly can be seen without any special decoding, so
the RISC-V front-end is a little easier for debugging.

Caveats:

- 64-bit on 32-bit hosts is not yet supported
  (tcg_out_brcond2 and tcg_out_setcond2 are not implemented)
- softmmu is not yet supported
  (tcg_out_tlb_load, tcg_out_qemu_ld_slow_path and
  tcg_out_qemu_st_slow_path are not implemented)
- big endian is not yet supported
  (tcg_out_qemu_ld_direct and tcg_out_qemu_st_direct
  do not support MO_BSWAP)
- subtle bugs still exist. i.e. glibc dynamic executables
  do not run but many static musl libc exectables do run.
---
 accel/tcg/user-exec.c             |   12 +
 configure                         |   10 +-
 disas.c                           |   10 +-
 include/elf.h                     |   55 ++
 include/exec/poison.h             |    1 +
 linux-user/host/riscv32/hostdep.h |   15 +
 linux-user/host/riscv64/hostdep.h |   15 +
 tcg/riscv/tcg-target.h            |  170 +++++
 tcg/riscv/tcg-target.inc.c        | 1466 +++++++++++++++++++++++++++++++++++++
 9 files changed, 1751 insertions(+), 3 deletions(-)
 create mode 100644 linux-user/host/riscv32/hostdep.h
 create mode 100644 linux-user/host/riscv64/hostdep.h
 create mode 100644 tcg/riscv/tcg-target.h
 create mode 100644 tcg/riscv/tcg-target.inc.c

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7789958..86a3686 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -570,6 +570,18 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
+#elif defined(__riscv)
+
+int cpu_signal_handler(int host_signum, void *pinfo,
+                       void *puc)
+{
+    siginfo_t *info = pinfo;
+    ucontext_t *uc = puc;
+    greg_t pc = uc->uc_mcontext.__gregs[REG_PC];
+    int is_write = 0;
+    return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
+}
+
 #else
 
 #error host CPU specific signal handler needed
diff --git a/configure b/configure
index f156805..7f1565c 100755
--- a/configure
+++ b/configure
@@ -655,6 +655,12 @@ elif check_define __s390__ ; then
   else
     cpu="s390"
   fi
+elif check_define __riscv ; then
+  if check_define _LP64 ; then
+    cpu="riscv64"
+  elif check_define _ILP32 ; then
+    cpu="riscv32"
+  fi
 elif check_define __arm__ ; then
   cpu="arm"
 elif check_define __aarch64__ ; then
@@ -667,7 +673,7 @@ ARCH=
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ppc|ppc64|s390|s390x|sparc64|x32)
+  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
     cpu="$cpu"
     supported_cpu="yes"
   ;;
@@ -6609,6 +6615,8 @@ elif test "$ARCH" = "x86_64" -o "$ARCH" = "x32" ; then
   QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" = "ppc64" ; then
   QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
+elif test "$ARCH" = "riscv32" -o "$ARCH" = "riscv64" ; then
+  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/riscv $QEMU_INCLUDES"
 else
   QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
diff --git a/disas.c b/disas.c
index 5325b7e..82a408f 100644
--- a/disas.c
+++ b/disas.c
@@ -522,8 +522,14 @@ void disas(FILE *out, void *code, unsigned long size)
 # ifdef _ARCH_PPC64
     s.info.cap_mode = CS_MODE_64;
 # endif
-#elif defined(__riscv__)
-    print_insn = print_insn_riscv;
+#elif defined(__riscv) && defined(CONFIG_RISCV_DIS)
+#if defined(_ILP32)
+    print_insn = print_insn_riscv32;
+#elif defined(_LP64)
+    print_insn = print_insn_riscv64;
+#else
+#error unsupported RISC-V ABI
+#endif
 #elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
     print_insn = print_insn_arm_a64;
     s.info.cap_arch = CS_ARCH_ARM64;
diff --git a/include/elf.h b/include/elf.h
index c0dc9bb..06b1cd2 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1285,6 +1285,61 @@ typedef struct {
 #define R_IA64_DTPREL64LSB	0xb7	/* @dtprel(sym + add), data8 LSB */
 #define R_IA64_LTOFF_DTPREL22	0xba	/* @ltoff(@dtprel(s+a)), imm22 */
 
+/* RISC-V relocations.  */
+#define R_RISCV_NONE          0
+#define R_RISCV_32            1
+#define R_RISCV_64            2
+#define R_RISCV_RELATIVE      3
+#define R_RISCV_COPY          4
+#define R_RISCV_JUMP_SLOT     5
+#define R_RISCV_TLS_DTPMOD32  6
+#define R_RISCV_TLS_DTPMOD64  7
+#define R_RISCV_TLS_DTPREL32  8
+#define R_RISCV_TLS_DTPREL64  9
+#define R_RISCV_TLS_TPREL32   10
+#define R_RISCV_TLS_TPREL64   11
+#define R_RISCV_BRANCH        16
+#define R_RISCV_JAL           17
+#define R_RISCV_CALL          18
+#define R_RISCV_CALL_PLT      19
+#define R_RISCV_GOT_HI20      20
+#define R_RISCV_TLS_GOT_HI20  21
+#define R_RISCV_TLS_GD_HI20   22
+#define R_RISCV_PCREL_HI20    23
+#define R_RISCV_PCREL_LO12_I  24
+#define R_RISCV_PCREL_LO12_S  25
+#define R_RISCV_HI20          26
+#define R_RISCV_LO12_I        27
+#define R_RISCV_LO12_S        28
+#define R_RISCV_TPREL_HI20    29
+#define R_RISCV_TPREL_LO12_I  30
+#define R_RISCV_TPREL_LO12_S  31
+#define R_RISCV_TPREL_ADD     32
+#define R_RISCV_ADD8          33
+#define R_RISCV_ADD16         34
+#define R_RISCV_ADD32         35
+#define R_RISCV_ADD64         36
+#define R_RISCV_SUB8          37
+#define R_RISCV_SUB16         38
+#define R_RISCV_SUB32         39
+#define R_RISCV_SUB64         40
+#define R_RISCV_GNU_VTINHERIT 41
+#define R_RISCV_GNU_VTENTRY   42
+#define R_RISCV_ALIGN         43
+#define R_RISCV_RVC_BRANCH    44
+#define R_RISCV_RVC_JUMP      45
+#define R_RISCV_RVC_LUI       46
+#define R_RISCV_GPREL_I       47
+#define R_RISCV_GPREL_S       48
+#define R_RISCV_TPREL_I       49
+#define R_RISCV_TPREL_S       50
+#define R_RISCV_RELAX         51
+#define R_RISCV_SUB6          52
+#define R_RISCV_SET6          53
+#define R_RISCV_SET8          54
+#define R_RISCV_SET16         55
+#define R_RISCV_SET32         56
+
 typedef struct elf32_rel {
   Elf32_Addr	r_offset;
   Elf32_Word	r_info;
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 41cd2eb..79aec29 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -79,6 +79,7 @@
 #pragma GCC poison CONFIG_MOXIE_DIS
 #pragma GCC poison CONFIG_NIOS2_DIS
 #pragma GCC poison CONFIG_PPC_DIS
+#pragma GCC poison CONFIG_RISCV_DIS
 #pragma GCC poison CONFIG_S390_DIS
 #pragma GCC poison CONFIG_SH4_DIS
 #pragma GCC poison CONFIG_SPARC_DIS
diff --git a/linux-user/host/riscv32/hostdep.h b/linux-user/host/riscv32/hostdep.h
new file mode 100644
index 0000000..d63dc57
--- /dev/null
+++ b/linux-user/host/riscv32/hostdep.h
@@ -0,0 +1,15 @@
+/*
+ * hostdep.h : things which are dependent on the host architecture
+ *
+ *  * Written by Peter Maydell <peter.maydell@linaro.org>
+ *
+ * Copyright (C) 2016 Linaro Limited
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef RISCV32_HOSTDEP_H
+#define RISCV32_HOSTDEP_H
+
+#endif
diff --git a/linux-user/host/riscv64/hostdep.h b/linux-user/host/riscv64/hostdep.h
new file mode 100644
index 0000000..4288410
--- /dev/null
+++ b/linux-user/host/riscv64/hostdep.h
@@ -0,0 +1,15 @@
+/*
+ * hostdep.h : things which are dependent on the host architecture
+ *
+ *  * Written by Peter Maydell <peter.maydell@linaro.org>
+ *
+ * Copyright (C) 2016 Linaro Limited
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef RISCV64_HOSTDEP_H
+#define RISCV64_HOSTDEP_H
+
+#endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
new file mode 100644
index 0000000..a0afdad
--- /dev/null
+++ b/tcg/riscv/tcg-target.h
@@ -0,0 +1,170 @@
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2018 SiFive, Inc
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef RISCV_TCG_TARGET_H
+#define RISCV_TCG_TARGET_H
+
+#if __riscv_xlen == 32
+# define TCG_TARGET_REG_BITS 32
+#elif __riscv_xlen == 64
+# define TCG_TARGET_REG_BITS 64
+#endif
+
+#define TCG_TARGET_INSN_UNIT_SIZE 4
+#define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
+#define TCG_TARGET_NB_REGS 32
+
+typedef enum {
+    TCG_REG_ZERO,
+    TCG_REG_RA,
+    TCG_REG_SP,
+    TCG_REG_GP,
+    TCG_REG_TP,
+    TCG_REG_T0,
+    TCG_REG_T1,
+    TCG_REG_T2,
+    TCG_REG_S0,
+    TCG_REG_S1,
+    TCG_REG_A0,
+    TCG_REG_A1,
+    TCG_REG_A2,
+    TCG_REG_A3,
+    TCG_REG_A4,
+    TCG_REG_A5,
+    TCG_REG_A6,
+    TCG_REG_A7,
+    TCG_REG_S2,
+    TCG_REG_S3,
+    TCG_REG_S4,
+    TCG_REG_S5,
+    TCG_REG_S6,
+    TCG_REG_S7,
+    TCG_REG_S8,
+    TCG_REG_S9,
+    TCG_REG_S10,
+    TCG_REG_S11,
+    TCG_REG_T3,
+    TCG_REG_T4,
+    TCG_REG_T5,
+    TCG_REG_T6,
+
+    /* aliases */
+    TCG_AREG0          = TCG_REG_S0,
+    TCG_GUEST_BASE_REG = TCG_REG_S1,
+    TCG_REG_TMP0       = TCG_REG_T6,
+    TCG_REG_TMP1       = TCG_REG_T5,
+} TCGReg;
+
+/* used for function call generation */
+#define TCG_REG_CALL_STACK              TCG_REG_SP
+#define TCG_TARGET_STACK_ALIGN          16
+#define TCG_TARGET_CALL_ALIGN_ARGS      1
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+
+/* optional instructions */
+#define TCG_TARGET_HAS_goto_ptr         1
+#define TCG_TARGET_HAS_movcond_i32      0
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_div2_i32         0
+#define TCG_TARGET_HAS_rot_i32          0
+#define TCG_TARGET_HAS_deposit_i32      0
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        (TCG_TARGET_REG_BITS == 32)
+#define TCG_TARGET_HAS_mulsh_i32        (TCG_TARGET_REG_BITS == 32)
+#define TCG_TARGET_HAS_ext8s_i32        0
+#define TCG_TARGET_HAS_ext16s_i32       0
+#define TCG_TARGET_HAS_ext8u_i32        0
+#define TCG_TARGET_HAS_ext16u_i32       0
+#define TCG_TARGET_HAS_bswap16_i32      0
+#define TCG_TARGET_HAS_bswap32_i32      0
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_neg_i32          1
+#define TCG_TARGET_HAS_andc_i32         0
+#define TCG_TARGET_HAS_orc_i32          0
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          0
+#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_direct_jump      1
+
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_movcond_i64      0
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_div2_i64         0
+#define TCG_TARGET_HAS_rot_i64          0
+#define TCG_TARGET_HAS_deposit_i64      0
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extrl_i64_i32    0
+#define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_ext8s_i64        0
+#define TCG_TARGET_HAS_ext16s_i64       0
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        0
+#define TCG_TARGET_HAS_ext16u_i64       0
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_bswap16_i64      0
+#define TCG_TARGET_HAS_bswap32_i64      0
+#define TCG_TARGET_HAS_bswap64_i64      0
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_neg_i64          1
+#define TCG_TARGET_HAS_andc_i64         0
+#define TCG_TARGET_HAS_orc_i64          0
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          0
+#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+#endif
+
+static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+{
+    __builtin___clear_cache((char *)start, (char *)stop);
+}
+
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+
+#define TCG_TARGET_DEFAULT_MO (0)
+
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+
+#endif
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
new file mode 100644
index 0000000..bfcd6bb
--- /dev/null
+++ b/tcg/riscv/tcg-target.inc.c
@@ -0,0 +1,1466 @@
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2018 SiFive, Inc
+ * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
+ * Copyright (c) 2009 Aurelien Jarno <aurelien@aurel32.net>
+ * Copyright (c) 2008 Fabrice Bellard
+ *
+ * Based on i386/tcg-target.c and mips/tcg-target.c
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifdef CONFIG_DEBUG_TCG
+static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
+    "zero",
+    "ra",
+    "sp",
+    "gp",
+    "tp",
+    "t0",
+    "t1",
+    "t2",
+    "s0",
+    "s1",
+    "a0",
+    "a1",
+    "a2",
+    "a3",
+    "a4",
+    "a5",
+    "a6",
+    "a7",
+    "s2",
+    "s3",
+    "s4",
+    "s5",
+    "s6",
+    "s7",
+    "s8",
+    "s9",
+    "s10",
+    "s11",
+    "t3",
+    "t4",
+    "t5",
+    "t6"
+};
+#endif
+
+static const int tcg_target_reg_alloc_order[] = {
+    /* Call saved registers */
+    TCG_REG_S0,
+    TCG_REG_S1,
+    TCG_REG_S2,
+    TCG_REG_S3,
+    TCG_REG_S4,
+    TCG_REG_S5,
+    TCG_REG_S6,
+    TCG_REG_S7,
+    TCG_REG_S8,
+    TCG_REG_S9,
+    TCG_REG_S10,
+    TCG_REG_S11,
+
+    /* Call clobbered registers */
+    TCG_REG_T6,
+    TCG_REG_T5,
+    TCG_REG_T4,
+    TCG_REG_T3,
+    TCG_REG_T2,
+    TCG_REG_T1,
+    TCG_REG_T0,
+
+    /* Argument registers */
+    TCG_REG_A7,
+    TCG_REG_A6,
+    TCG_REG_A5,
+    TCG_REG_A4,
+    TCG_REG_A3,
+    TCG_REG_A2,
+    TCG_REG_A1,
+    TCG_REG_A0,
+};
+
+static const int tcg_target_call_iarg_regs[] = {
+    TCG_REG_A0,
+    TCG_REG_A1,
+    TCG_REG_A2,
+    TCG_REG_A3,
+    TCG_REG_A4,
+    TCG_REG_A5,
+    TCG_REG_A6,
+    TCG_REG_A7,
+};
+
+static const int tcg_target_call_oarg_regs[] = {
+    TCG_REG_A0,
+    TCG_REG_A1,
+};
+
+#define TCG_CT_CONST_ZERO  0x100
+#define TCG_CT_CONST_S12   0x200
+#define TCG_CT_CONST_N12   0x400
+
+/* parse target specific constraints */
+static const char *target_parse_constraint(TCGArgConstraint *ct,
+                                           const char *ct_str, TCGType type)
+{
+    switch(*ct_str++) {
+    case 'r':
+        ct->ct |= TCG_CT_REG;
+        ct->u.regs = 0xffffffff;
+        break;
+    case 'L':
+        /* qemu_ld/qemu_st constraint */
+        ct->ct |= TCG_CT_REG;
+        ct->u.regs = 0xffffffff;
+        /* we may reserve additional registers for use by softmmu
+           however presently qemu_ld/qemu_st only use TCG_REG_TMP0 */
+        break;
+    case 'I':
+        ct->ct |= TCG_CT_CONST_S12;
+        break;
+    case 'N':
+        ct->ct |= TCG_CT_CONST_N12;
+        break;
+    case 'Z':
+        /* we can use a zero immediate as a zero register argument. */
+        ct->ct |= TCG_CT_CONST_ZERO;
+        break;
+    default:
+        return NULL;
+    }
+    return ct_str;
+}
+
+/* test if a constant matches the constraint */
+static int tcg_target_const_match(tcg_target_long val, TCGType type,
+                                  const TCGArgConstraint *arg_ct)
+{
+    int ct = arg_ct->ct;
+    if (ct & TCG_CT_CONST) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_S12) && val >= -2047 && val <= 2048) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_N12) && val >= -2047 && val <= 2047) {
+        return 1;
+    }
+    return 0;
+}
+
+/*
+ * RISC-V Base ISA opcodes (IM)
+ */
+
+typedef enum {
+    OPC_ADD = 0x33,
+    OPC_ADDI = 0x13,
+    OPC_ADDIW = 0x1b,
+    OPC_ADDW = 0x3b,
+    OPC_AND = 0x7033,
+    OPC_ANDI = 0x7013,
+    OPC_AUIPC = 0x17,
+    OPC_BEQ = 0x63,
+    OPC_BGE = 0x5063,
+    OPC_BGEU = 0x7063,
+    OPC_BLT = 0x4063,
+    OPC_BLTU = 0x6063,
+    OPC_BNE = 0x1063,
+    OPC_DIV = 0x2004033,
+    OPC_DIVU = 0x2005033,
+    OPC_DIVUW = 0x200503b,
+    OPC_DIVW = 0x200403b,
+    OPC_JAL = 0x6f,
+    OPC_JALR = 0x67,
+    OPC_LB = 0x3,
+    OPC_LBU = 0x4003,
+    OPC_LD = 0x3003,
+    OPC_LH = 0x1003,
+    OPC_LHU = 0x5003,
+    OPC_LUI = 0x37,
+    OPC_LW = 0x2003,
+    OPC_LWU = 0x6003,
+    OPC_MUL = 0x2000033,
+    OPC_MULH = 0x2001033,
+    OPC_MULHSU = 0x2002033,
+    OPC_MULHU = 0x2003033,
+    OPC_MULW = 0x200003b,
+    OPC_OR = 0x6033,
+    OPC_ORI = 0x6013,
+    OPC_REM = 0x2006033,
+    OPC_REMU = 0x2007033,
+    OPC_REMUW = 0x200703b,
+    OPC_REMW = 0x200603b,
+    OPC_SB = 0x23,
+    OPC_SD = 0x3023,
+    OPC_SH = 0x1023,
+    OPC_SLL = 0x1033,
+    OPC_SLLI = 0x1013,
+    OPC_SLLIW = 0x101b,
+    OPC_SLLW = 0x103b,
+    OPC_SLT = 0x2033,
+    OPC_SLTI = 0x2013,
+    OPC_SLTIU = 0x3013,
+    OPC_SLTU = 0x3033,
+    OPC_SRA = 0x40005033,
+    OPC_SRAI = 0x40005013,
+    OPC_SRAIW = 0x4000501b,
+    OPC_SRAW = 0x4000503b,
+    OPC_SRL = 0x5033,
+    OPC_SRLI = 0x5013,
+    OPC_SRLIW = 0x501b,
+    OPC_SRLW = 0x503b,
+    OPC_SUB = 0x40000033,
+    OPC_SUBW = 0x4000003b,
+    OPC_SW = 0x2023,
+    OPC_XOR = 0x4033,
+    OPC_XORI = 0x4013,
+    OPC_FENCE_RW_RW = 0x0330000f,
+    OPC_FENCE_R_R = 0x0220000f,
+    OPC_FENCE_W_R = 0x0120000f,
+    OPC_FENCE_R_W = 0x0210000f,
+    OPC_FENCE_W_W = 0x0110000f,
+    OPC_FENCE_RW_R = 0x0320000f,
+    OPC_FENCE_W_RW = 0x0130000f,
+} RISCVInsn;
+
+/*
+ * RISC-V immediate and instruction encoders (excludes 16-bit RVC)
+ */
+
+/* Type-R */
+
+static int32_t encode_r(RISCVInsn opc, TCGReg rd, TCGReg rs1, TCGReg rs2)
+{
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20;
+}
+
+/* Type-I */
+
+static int32_t encode_imm12(uint32_t imm)
+{
+    return (imm & 0xfff) << 20;
+}
+
+static int32_t encode_i(RISCVInsn opc, TCGReg rd, TCGReg rs1, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | encode_imm12(imm);
+}
+
+/* Type-S */
+
+static int32_t encode_simm12(uint32_t imm)
+{
+    return ((imm << 20) >> 25) << 25 | ((imm << 27) >> 27) << 7;
+}
+
+static int32_t encode_s(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+{
+    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_simm12(imm);
+}
+
+/* Type-SB */
+
+static int32_t encode_sbimm12(uint32_t imm)
+{
+    return ((imm << 19) >> 31) << 31 | ((imm << 21) >> 26) << 25 |
+           ((imm << 27) >> 28) << 8 | ((imm << 20) >> 31) << 7;
+}
+
+static int32_t encode_sb(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+{
+    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_sbimm12(imm);
+}
+
+/* Type-U */
+
+static int32_t encode_uimm20(uint32_t imm)
+{
+    return (imm >> 12) << 12;
+}
+
+static int32_t encode_u(RISCVInsn opc, TCGReg rd, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | encode_uimm20(imm);
+}
+
+/* Type-UJ */
+
+static int32_t encode_ujimm12(uint32_t imm)
+{
+    return ((imm << 11) >> 31) << 31 | ((imm << 21) >> 22) << 21 |
+           ((imm << 20) >> 31) << 20 | ((imm << 12) >> 24) << 12;
+}
+
+static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
+{
+    return opc | (rd & 0x1f) << 7 | encode_ujimm12(imm);
+}
+
+/*
+ * RISC-V instruction emitters
+ */
+
+static void tcg_out_opc_reg(TCGContext *s, RISCVInsn opc,
+                            TCGReg rd, TCGReg rs1, TCGReg rs2)
+{
+    tcg_out32(s, encode_r(opc, rd, rs1, rs2));
+}
+
+static void tcg_out_opc_imm(TCGContext *s, RISCVInsn opc,
+                            TCGReg rd, TCGReg rs1, TCGArg imm)
+{
+    tcg_out32(s, encode_i(opc, rd, rs1, imm));
+}
+
+static void tcg_out_opc_store(TCGContext *s, RISCVInsn opc,
+                              TCGReg rs1, TCGReg rs2, uint32_t imm)
+{
+    tcg_out32(s, encode_s(opc, rs1, rs2, imm));
+}
+
+static void tcg_out_opc_branch(TCGContext *s, RISCVInsn opc,
+                               TCGReg rs1, TCGReg rs2, uint32_t imm)
+{
+    tcg_out32(s, encode_sb(opc, rs1, rs2, imm));
+}
+
+static void tcg_out_opc_upper(TCGContext *s, RISCVInsn opc,
+                              TCGReg rd, uint32_t imm)
+{
+    tcg_out32(s, encode_u(opc, rd, imm));
+}
+
+static void tcg_out_opc_jump(TCGContext *s, RISCVInsn opc,
+                             TCGReg rd, uint32_t imm)
+{
+    tcg_out32(s, encode_uj(opc, rd, imm));
+}
+
+/*
+ * Relocations
+ */
+
+static void reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+    tcg_debug_assert(offset == sextract64(offset, 1, 12));
+
+    code_ptr[0] |= encode_sbimm12(offset);
+}
+
+static void reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+    tcg_debug_assert(offset == sextract64(offset, 1, 20));
+
+    code_ptr[0] |= encode_ujimm12(offset);
+}
+
+static void reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
+    tcg_debug_assert(offset == (int32_t)offset);
+
+    int32_t hi20 = ((offset + 0x800) >> 12) << 12;
+    int32_t lo12 = offset - hi20;
+
+    code_ptr[0] |= encode_uimm20(hi20);
+    code_ptr[1] |= encode_imm12(lo12);
+}
+
+static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    tcg_debug_assert(addend == 0);
+    switch (type) {
+    case R_RISCV_BRANCH:
+        reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
+        break;
+    case R_RISCV_JAL:
+        reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
+        break;
+    case R_RISCV_CALL:
+        reloc_call(code_ptr, (tcg_insn_unit *)value);
+        break;
+    default:
+        tcg_abort();
+    }
+}
+
+/*
+ * TCG intrinsics
+ */
+
+static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    if (ret == arg) {
+        return;
+    }
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
+                         tcg_target_long val)
+{
+    tcg_target_long lo = sextract64(val, 0, 12);
+    tcg_target_long hi = val - lo;
+
+    RISCVInsn add32_op = TCG_TARGET_REG_BITS == 64 ? OPC_ADDIW : OPC_ADDI;
+
+    if (val == lo) {
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, val);
+    } else if (val && !(val & (val - 1))) {
+        /* power of 2 */
+        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, 1);
+        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, ctz64(val));
+    } else if (TCG_TARGET_REG_BITS == 64 &&
+               !(val >> 31 == 0 || val >> 31 == -1)) {
+        int shift = 12 + ctz64(hi >> 12);
+        hi >>= shift;
+        tcg_out_movi(s, type, rd, hi);
+        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, shift);
+        if (lo != 0) {
+            tcg_out_opc_imm(s, OPC_ADDI, rd, rd, lo);
+        }
+    } else {
+        if (hi != 0) {
+            tcg_out_opc_upper(s, OPC_LUI, rd, hi);
+        }
+        if (lo != 0) {
+            tcg_out_opc_imm(s, add32_op, rd, hi == 0 ? TCG_REG_ZERO : rd, lo);
+        }
+    }
+}
+
+static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
+    tcg_out_opc_imm(s, OPC_SRLI, ret, ret, 32);
+}
+
+static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
+                         TCGReg addr, intptr_t offset)
+{
+    int32_t imm12 = sextract32(offset, 0, 12);
+    if (offset != imm12) {
+        if (addr == TCG_REG_ZERO) {
+            addr = TCG_REG_TMP0;
+        }
+        tcg_out_movi(s, TCG_TYPE_PTR, addr, offset - imm12);
+    }
+    switch (opc) {
+        case OPC_SB:
+        case OPC_SH:
+        case OPC_SW:
+        case OPC_SD:
+            tcg_out_opc_store(s, opc, addr, data, imm12);
+            break;
+        case OPC_LB:
+        case OPC_LBU:
+        case OPC_LH:
+        case OPC_LHU:
+        case OPC_LW:
+        case OPC_LWU:
+        case OPC_LD:
+            tcg_out_opc_imm(s, opc, data, addr, imm12);
+            break;
+        default:
+            g_assert_not_reached();
+    }
+}
+
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
+{
+    bool is32bit = (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32);
+    tcg_out_ldst(s, is32bit ? OPC_LW : OPC_LD, arg, arg1, arg2);
+}
+
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
+{
+    bool is32bit = (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32);
+    tcg_out_ldst(s, is32bit ? OPC_SW : OPC_SD, arg, arg1, arg2);
+}
+
+static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
+                        TCGReg base, intptr_t ofs)
+{
+    if (val == 0) {
+        tcg_out_st(s, type, TCG_REG_ZERO, base, ofs);
+        return true;
+    }
+    return false;
+}
+
+static const struct {
+    RISCVInsn op;
+    bool swap;
+} tcg_brcond_to_riscv[] = {
+    [TCG_COND_EQ] =  { OPC_BEQ,  false },
+    [TCG_COND_NE] =  { OPC_BNE,  false },
+    [TCG_COND_LT] =  { OPC_BLT,  false },
+    [TCG_COND_GE] =  { OPC_BGE,  false },
+    [TCG_COND_LE] =  { OPC_BGE,  true  },
+    [TCG_COND_GT] =  { OPC_BLT,  true  },
+    [TCG_COND_LTU] = { OPC_BLTU, false },
+    [TCG_COND_GEU] = { OPC_BGEU, false },
+    [TCG_COND_LEU] = { OPC_BGEU, true  },
+    [TCG_COND_GTU] = { OPC_BLTU, true  }
+};
+
+static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
+                           TCGReg arg2, TCGLabel *l)
+{
+    RISCVInsn op = tcg_brcond_to_riscv[cond].op;
+    bool swap = tcg_brcond_to_riscv[cond].swap;
+
+    tcg_out_opc_branch(s, op, swap ? arg2 : arg1, swap ? arg1 : arg2, 0);
+
+    if (l->has_value) {
+        reloc_sbimm12(s->code_ptr - 1, l->u.value_ptr);
+    } else {
+        tcg_out_reloc(s, s->code_ptr - 1, R_RISCV_BRANCH, l, 0);
+    }
+}
+
+static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
+                            TCGReg arg1, TCGReg arg2)
+{
+    switch (cond) {
+    case TCG_COND_EQ:
+        tcg_out_opc_reg(s, OPC_SUB, ret, arg1, arg2);
+        tcg_out_opc_imm(s, OPC_SLTIU, ret, ret, 1);
+        break;
+    case TCG_COND_NE:
+        tcg_out_opc_reg(s, OPC_SUB, ret, arg1, arg2);
+        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, ret);
+        break;
+    case TCG_COND_LT:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
+        break;
+    case TCG_COND_GE:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
+        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
+        break;
+    case TCG_COND_LE:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
+        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
+        break;
+    case TCG_COND_GT:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
+        break;
+    case TCG_COND_LTU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
+        break;
+    case TCG_COND_GEU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
+        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
+        break;
+    case TCG_COND_LEU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
+        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
+        break;
+    case TCG_COND_GTU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
+        break;
+    default:
+         g_assert_not_reached();
+         break;
+     }
+}
+
+static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                            TCGReg bl, TCGReg bh, TCGLabel *l)
+{
+    /* todo */
+    g_assert_not_reached();
+}
+
+static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
+                             TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+{
+    /* todo */
+    g_assert_not_reached();
+}
+
+static void tcg_out_jump_internal(TCGContext *s, tcg_insn_unit *arg, bool tail)
+{
+    TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
+    ptrdiff_t offset = tcg_pcrel_diff(s, arg);
+    if (offset == sextract64(offset, 1, 12)) {
+        /* short jump: -4094 to 4096 */
+        tcg_out_opc_jump(s, OPC_JAL, link, offset);
+    } else if (offset == sextract64(offset, 1, 31)) {
+        /* long jump: -2147483646 to 2147483648 */
+        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
+        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
+        reloc_call(s->code_ptr - 2, arg);
+    } else {
+        /* far jump: 64-bit */
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, (tcg_target_long)arg);
+        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
+    }
+}
+
+static void tcg_out_tail(TCGContext *s, tcg_insn_unit *arg)
+{
+    tcg_out_jump_internal(s, arg, true);
+}
+
+static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+{
+    tcg_out_jump_internal(s, arg, false);
+}
+
+static void tcg_out_mb(TCGContext *s, TCGArg a0)
+{
+    static const RISCVInsn fence[] = {
+        [0 ... TCG_MO_ALL] = OPC_FENCE_RW_RW,
+        [TCG_MO_LD_LD]     = OPC_FENCE_R_R,
+        [TCG_MO_ST_LD]     = OPC_FENCE_W_R,
+        [TCG_MO_LD_ST]     = OPC_FENCE_R_W,
+        [TCG_MO_ST_ST]     = OPC_FENCE_W_W,
+        [TCG_BAR_LDAQ]     = OPC_FENCE_RW_R,
+        [TCG_BAR_STRL]     = OPC_FENCE_W_RW,
+        [TCG_BAR_SC]       = OPC_FENCE_RW_RW,
+    };
+    tcg_out32(s, fence[a0 & TCG_MO_ALL]);
+}
+
+/*
+ * Load/store and TLB
+ */
+
+#if defined(CONFIG_SOFTMMU)
+#include "tcg-ldst.inc.c"
+
+/* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
+ *                                     TCGMemOpIdx oi, uintptr_t ra)
+ */
+static void * const qemu_ld_helpers[16] = {
+    [MO_UB]   = helper_ret_ldub_mmu,
+    [MO_SB]   = helper_ret_ldsb_mmu,
+    [MO_LEUW] = helper_le_lduw_mmu,
+    [MO_LESW] = helper_le_ldsw_mmu,
+    [MO_LEUL] = helper_le_ldul_mmu,
+    [MO_LESL] = helper_le_ldsl_mmu,
+    [MO_LEQ]  = helper_le_ldq_mmu,
+    [MO_BEUW] = helper_be_lduw_mmu,
+    [MO_BESW] = helper_be_ldsw_mmu,
+    [MO_BEUL] = helper_be_ldul_mmu,
+    [MO_BESL] = helper_be_ldsl_mmu,
+    [MO_BEQ]  = helper_be_ldq_mmu,
+};
+
+/* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
+ *                                     uintxx_t val, TCGMemOpIdx oi,
+ *                                     uintptr_t ra)
+ */
+static void * const qemu_st_helpers[16] = {
+    [MO_UB]   = helper_ret_stb_mmu,
+    [MO_LEUW] = helper_le_stw_mmu,
+    [MO_LEUL] = helper_le_stl_mmu,
+    [MO_LEQ]  = helper_le_stq_mmu,
+    [MO_BEUW] = helper_be_stw_mmu,
+    [MO_BEUL] = helper_be_stl_mmu,
+    [MO_BEQ]  = helper_be_stq_mmu,
+};
+
+static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
+                             TCGReg addrh, TCGMemOpIdx oi,
+                             tcg_insn_unit *label_ptr[2], bool is_load)
+{
+    /* todo */
+    g_assert_not_reached();
+}
+
+static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
+                                TCGType ext,
+                                TCGReg datalo, TCGReg datahi,
+                                TCGReg addrlo, TCGReg addrhi,
+                                void *raddr, tcg_insn_unit *label_ptr[2])
+{
+    TCGLabelQemuLdst *label = new_ldst_label(s);
+
+    label->is_ld = is_ld;
+    label->oi = oi;
+    label->type = ext;
+    label->datalo_reg = datalo;
+    label->datahi_reg = datahi;
+    label->addrlo_reg = addrlo;
+    label->addrhi_reg = addrhi;
+    label->raddr = raddr;
+    label->label_ptr[0] = label_ptr[0];
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        label->label_ptr[1] = label_ptr[1];
+    }
+}
+
+static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+{
+    /* todo */
+    g_assert_not_reached();
+}
+
+static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
+{
+    /* todo */
+    g_assert_not_reached();
+}
+#endif /* CONFIG_SOFTMMU */
+
+static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
+                                   TCGReg base, TCGMemOp opc, bool is_64)
+{
+    switch (opc & (MO_SSIZE | MO_BSWAP)) {
+    case MO_UB:
+        tcg_out_opc_imm(s, OPC_LBU, lo, base, 0);
+        break;
+    case MO_SB:
+        tcg_out_opc_imm(s, OPC_LB, lo, base, 0);
+        break;
+    case MO_UW:
+        tcg_out_opc_imm(s, OPC_LHU, lo, base, 0);
+        break;
+    case MO_SW:
+        tcg_out_opc_imm(s, OPC_LH, lo, base, 0);
+        break;
+    case MO_UL:
+        if (TCG_TARGET_REG_BITS == 64 && is_64) {
+            tcg_out_opc_imm(s, OPC_LWU, lo, base, 0);
+            break;
+        }
+        /* FALLTHRU */
+    case MO_SL:
+        tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+        break;
+    case MO_Q:
+        /* Prefer to load from offset 0 first, but allow for overlap.  */
+        if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
+        } else {
+            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
+{
+    TCGReg addr_regl, addr_regh __attribute__((unused));
+    TCGReg data_regl, data_regh;
+    TCGMemOpIdx oi;
+    TCGMemOp opc;
+#if defined(CONFIG_SOFTMMU)
+    tcg_insn_unit *label_ptr[2] __attribute__((unused));
+#endif
+    TCGReg base = TCG_REG_TMP0;
+
+    data_regl = *args++;
+    data_regh = (TCG_TARGET_REG_BITS == 32 && is_64 ? *args++ : 0);
+    addr_regl = *args++;
+    addr_regh = (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
+    oi = *args++;
+    opc = get_memop(oi);
+
+#if defined(CONFIG_SOFTMMU)
+    g_assert_not_reached();
+#else
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addr_regl);
+        addr_regl = base;
+    }
+    tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);
+    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
+#endif
+}
+
+static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
+                                   TCGReg base, TCGMemOp opc)
+{
+    switch (opc & (MO_SIZE | MO_BSWAP)) {
+    case MO_8:
+        tcg_out_opc_store(s, OPC_SB, base, lo, 0);
+        break;
+    case MO_16:
+        tcg_out_opc_store(s, OPC_SH, base, lo, 0);
+        break;
+    case MO_32:
+        tcg_out_opc_store(s, OPC_SW, base, lo, 0);
+        break;
+    case MO_64:
+        if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_opc_store(s, OPC_SD, base, lo, 0);
+        } else {
+            tcg_out_opc_store(s, OPC_SW, base, lo, 0);
+            tcg_out_opc_store(s, OPC_SW, base, hi, 4);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
+{
+    TCGReg addr_regl, addr_regh __attribute__((unused));
+    TCGReg data_regl, data_regh;
+    TCGMemOpIdx oi;
+    TCGMemOp opc;
+#if defined(CONFIG_SOFTMMU)
+    tcg_insn_unit *label_ptr[2] __attribute__((unused));
+#endif
+    TCGReg base = TCG_REG_TMP0;
+
+    data_regl = *args++;
+    data_regh = (TCG_TARGET_REG_BITS == 32 && is_64 ? *args++ : 0);
+    addr_regl = *args++;
+    addr_regh = (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
+    oi = *args++;
+    opc = get_memop(oi);
+
+#if defined(CONFIG_SOFTMMU)
+    g_assert_not_reached();
+#else
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addr_regl);
+        addr_regl = base;
+    }
+    tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);
+    tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
+#endif
+}
+
+static tcg_insn_unit *tb_ret_addr;
+
+static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+                       const TCGArg *args, const int *const_args)
+{
+    TCGArg a0 = args[0];
+    TCGArg a1 = args[1];
+    TCGArg a2 = args[2];
+    int c2 = const_args[2];
+    const bool is32bit = TCG_TARGET_REG_BITS == 32;
+
+    switch (opc) {
+    case INDEX_op_exit_tb:
+        /* Reuse the zeroing that exists for goto_ptr.  */
+        if (a0 == 0) {
+            tcg_out_tail(s, s->code_gen_epilogue);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_A0, a0);
+            tcg_out_tail(s, tb_ret_addr);
+        }
+        break;
+
+    case INDEX_op_goto_tb:
+        if (s->tb_jmp_insn_offset) {
+            /* direct jump method */
+            s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
+            /* should align on 64-bit boundary for atomic patching */
+            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
+            tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
+        } else {
+            /* indirect jump method */
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_REG_ZERO,
+                       (uintptr_t)(s->tb_jmp_target_addr + a0));
+            tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
+        }
+        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
+        break;
+
+    case INDEX_op_goto_ptr:
+        tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, a0, 0);
+        break;
+
+    case INDEX_op_br:
+        tcg_out_reloc(s, s->code_ptr, R_RISCV_CALL, arg_label(a0), 0);
+        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
+        tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
+        break;
+
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8u_i64:
+        tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
+        break;
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld8s_i64:
+        tcg_out_ldst(s, OPC_LB, a0, a1, a2);
+        break;
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16u_i64:
+        tcg_out_ldst(s, OPC_LHU, a0, a1, a2);
+        break;
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld16s_i64:
+        tcg_out_ldst(s, OPC_LH, a0, a1, a2);
+        break;
+    case INDEX_op_ld32u_i64:
+        tcg_out_ldst(s, OPC_LWU, a0, a1, a2);
+        break;
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld32s_i64:
+        tcg_out_ldst(s, OPC_LW, a0, a1, a2);
+        break;
+    case INDEX_op_ld_i64:
+        tcg_out_ldst(s, OPC_LD, a0, a1, a2);
+        break;
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st8_i64:
+        tcg_out_ldst(s, OPC_SB, a0, a1, a2);
+        break;
+    case INDEX_op_st16_i32:
+    case INDEX_op_st16_i64:
+        tcg_out_ldst(s, OPC_SH, a0, a1, a2);
+        break;
+    case INDEX_op_st_i32:
+    case INDEX_op_st32_i64:
+        tcg_out_ldst(s, OPC_SW, a0, a1, a2);
+        break;
+    case INDEX_op_st_i64:
+        tcg_out_ldst(s, OPC_SD, a0, a1, a2);
+        break;
+
+    case INDEX_op_add_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_ADDI : OPC_ADDIW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_ADD : OPC_ADDW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_add_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_ADD, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_sub_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_ADDI : OPC_ADDIW, a0, a1, -a2);
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_SUB : OPC_SUBW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_sub_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, -a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SUB, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_AND, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_XOR, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
+        tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
+        break;
+
+    case INDEX_op_neg_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_SUB : OPC_SUBW, a0, TCG_REG_ZERO, a1);
+        break;
+    case INDEX_op_neg_i64:
+        tcg_out_opc_imm(s, OPC_SUB, a0, TCG_REG_ZERO, a1);
+        break;
+
+    case INDEX_op_mul_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_MUL : OPC_MULW, a0, a1, a2);
+        break;
+    case INDEX_op_mul_i64:
+        tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
+        break;
+
+    case INDEX_op_div_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_DIV : OPC_DIVW, a0, a1, a2);
+        break;
+    case INDEX_op_div_i64:
+        tcg_out_opc_reg(s, OPC_DIV, a0, a1, a2);
+        break;
+
+    case INDEX_op_divu_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_DIVU : OPC_DIVUW, a0, a1, a2);
+        break;
+    case INDEX_op_divu_i64:
+        tcg_out_opc_reg(s, OPC_DIVU, a0, a1, a2);
+        break;
+
+    case INDEX_op_rem_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_REM : OPC_REMW, a0, a1, a2);
+        break;
+    case INDEX_op_rem_i64:
+        tcg_out_opc_reg(s, OPC_REM, a0, a1, a2);
+        break;
+
+    case INDEX_op_remu_i32:
+        tcg_out_opc_reg(s, is32bit ? OPC_REMU : OPC_REMUW, a0, a1, a2);
+        break;
+    case INDEX_op_remu_i64:
+        tcg_out_opc_reg(s, OPC_REMU, a0, a1, a2);
+        break;
+
+    case INDEX_op_shl_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_SLLI : OPC_SLLIW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_SLL : OPC_SLLW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_shl_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SLLI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SLL, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_shr_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_SRLI : OPC_SRLIW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_SRL : OPC_SRLW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_shr_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SRLI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SRL, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_sar_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, is32bit ? OPC_SRAI : OPC_SRAIW, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, is32bit ? OPC_SRA : OPC_SRAW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_sar_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SRAI, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SRA, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
+        break;
+    case INDEX_op_brcond2_i32:
+        tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]));
+        break;
+
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+        tcg_out_setcond(s, args[3], a0, a1, a2);
+        break;
+    case INDEX_op_setcond2_i32:
+        tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
+        break;
+
+    case INDEX_op_qemu_ld_i32:
+        tcg_out_qemu_ld(s, args, false);
+        break;
+    case INDEX_op_qemu_ld_i64:
+        tcg_out_qemu_ld(s, args, true);
+        break;
+    case INDEX_op_qemu_st_i32:
+        tcg_out_qemu_st(s, args, false);
+        break;
+    case INDEX_op_qemu_st_i64:
+        tcg_out_qemu_st(s, args, true);
+        break;
+
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext_i32_i64:
+        tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, 0);
+        break;
+
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_extu_i32_i64:
+        tcg_out_ext32u(s, a0, a1);
+        break;
+
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_mulsh_i64:
+        tcg_out_opc_imm(s, OPC_MULH, a0, a1, a2);
+        break;
+
+    case INDEX_op_muluh_i32:
+    case INDEX_op_muluh_i64:
+        tcg_out_opc_imm(s, OPC_MULHU, a0, a1, a2);
+        break;
+
+    case INDEX_op_mb:
+        tcg_out_mb(s, a0);
+        break;
+
+    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_mov_i64:
+    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
+    case INDEX_op_movi_i64:
+    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
+{
+    static const TCGTargetOpDef r
+        = { .args_ct_str = { "r" } };
+    static const TCGTargetOpDef r_r
+        = { .args_ct_str = { "r", "r" } };
+    static const TCGTargetOpDef rZ_r
+        = { .args_ct_str = { "rZ", "r" } };
+    static const TCGTargetOpDef rZ_rZ
+        = { .args_ct_str = { "rZ", "rZ" } };
+    static const TCGTargetOpDef r_r_ri
+        = { .args_ct_str = { "r", "r", "ri" } };
+    static const TCGTargetOpDef r_r_rI
+        = { .args_ct_str = { "r", "r", "rI" } };
+    static const TCGTargetOpDef r_rZ_rN
+        = { .args_ct_str = { "r", "rZ", "rN" } };
+    static const TCGTargetOpDef r_rZ_rZ
+        = { .args_ct_str = { "r", "rZ", "rZ" } };
+    static const TCGTargetOpDef r_L
+        = { .args_ct_str = { "r", "L" } };
+    static const TCGTargetOpDef r_r_L
+        = { .args_ct_str = { "r", "r", "L" } };
+    static const TCGTargetOpDef r_L_L
+        = { .args_ct_str = { "r", "L", "L" } };
+    static const TCGTargetOpDef r_r_L_L
+        = { .args_ct_str = { "r", "r", "L", "L" } };
+    static const TCGTargetOpDef LZ_L
+        = { .args_ct_str = { "LZ", "L" } };
+    static const TCGTargetOpDef LZ_L_L
+        = { .args_ct_str = { "LZ", "L", "L" } };
+    static const TCGTargetOpDef LZ_LZ_L
+        = { .args_ct_str = { "LZ", "LZ", "L" } };
+    static const TCGTargetOpDef LZ_LZ_L_L
+        = { .args_ct_str = { "LZ", "LZ", "L", "L" } };
+    static const TCGTargetOpDef brcond2
+        = { .args_ct_str = { "rZ", "rZ", "rZ", "rZ" } };
+    static const TCGTargetOpDef setcond2
+        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "rZ" } };
+
+    switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
+
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_not_i32:
+    case INDEX_op_neg_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_not_i64:
+    case INDEX_op_neg_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_extu_i32_i64:
+        return &r_r;
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return &rZ_r;
+
+    case INDEX_op_add_i32:
+    case INDEX_op_and_i32:
+    case INDEX_op_or_i32:
+    case INDEX_op_xor_i32:
+    case INDEX_op_add_i64:
+    case INDEX_op_and_i64:
+    case INDEX_op_or_i64:
+    case INDEX_op_xor_i64:
+        return &r_r_rI;
+
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+        return &r_rZ_rN;
+
+    case INDEX_op_mul_i32:
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_muluh_i32:
+    case INDEX_op_div_i32:
+    case INDEX_op_divu_i32:
+    case INDEX_op_rem_i32:
+    case INDEX_op_remu_i32:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_mul_i64:
+    case INDEX_op_mulsh_i64:
+    case INDEX_op_muluh_i64:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i64:
+    case INDEX_op_rem_i64:
+    case INDEX_op_remu_i64:
+    case INDEX_op_setcond_i64:
+        return &r_rZ_rZ;
+
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+        return &r_r_ri;
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return &rZ_rZ;
+
+    case INDEX_op_brcond2_i32:
+        return &brcond2;
+
+    case INDEX_op_setcond2_i32:
+        return &setcond2;
+
+    case INDEX_op_qemu_ld_i32:
+        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
+    case INDEX_op_qemu_st_i32:
+        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &LZ_L : &LZ_L_L;
+    case INDEX_op_qemu_ld_i64:
+        return TCG_TARGET_REG_BITS == 64 ? &r_L
+               : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_r_L
+               : &r_r_L_L;
+    case INDEX_op_qemu_st_i64:
+        return TCG_TARGET_REG_BITS == 64 ? &LZ_L
+               : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &LZ_LZ_L
+               : &LZ_LZ_L_L;
+
+    default:
+        return NULL;
+    }
+}
+
+static const int tcg_target_callee_save_regs[] = {
+    TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
+    TCG_REG_S1,
+    TCG_REG_S2,
+    TCG_REG_S3,
+    TCG_REG_S4,
+    TCG_REG_S5,
+    TCG_REG_S6,
+    TCG_REG_S7,
+    TCG_REG_S8,
+    TCG_REG_S9,
+    TCG_REG_S10,
+    TCG_REG_S11,
+    TCG_REG_RA,       /* should be last for ABI compliance */
+};
+
+/* Stack frame parameters.  */
+#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
+#define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
+#define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
+                     + TCG_TARGET_STACK_ALIGN - 1) \
+                    & -TCG_TARGET_STACK_ALIGN)
+#define SAVE_OFS   (TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE)
+
+/* We're expecting to be able to use an immediate for frame allocation.  */
+QEMU_BUILD_BUG_ON(FRAME_SIZE > 0x7ff);
+
+/* Generate global QEMU prologue and epilogue code */
+static void tcg_target_qemu_prologue(TCGContext *s)
+{
+    int i;
+
+    tcg_set_frame(s, TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE, TEMP_SIZE);
+
+    /* TB prologue */
+    tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_SP, TCG_REG_SP, -FRAME_SIZE);
+    for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
+        tcg_out_st(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
+                   TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
+    }
+
+#ifndef CONFIG_SOFTMMU
+    if (guest_base) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+    }
+#endif
+
+    /* Call generated code */
+    tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
+    tcg_out_opc_imm(s, OPC_JALR, 0, tcg_target_call_iarg_regs[1], 0);
+
+    /* Return path for goto_ptr. Set return value to 0 */
+    s->code_gen_epilogue = s->code_ptr;
+    tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_A0, TCG_REG_ZERO);
+
+    /* TB epilogue */
+    tb_ret_addr = s->code_ptr;
+    for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
+        tcg_out_ld(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
+                   TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
+    }
+
+    tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_SP, TCG_REG_SP, FRAME_SIZE);
+    tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_RA, 0);
+}
+
+static void tcg_target_init(TCGContext *s)
+{
+    tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+    }
+
+    tcg_target_call_clobber_regs = 0;
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A7);
+
+    s->reserved_regs = 0;
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_ZERO);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);
+}
+
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
+                              uintptr_t addr)
+{
+    /* Note: jump target patching should be atomic */
+    reloc_call((tcg_insn_unit*)jmp_addr, (tcg_insn_unit*)addr);
+    flush_icache_range(jmp_addr, jmp_addr + 8);
+}
+
+typedef struct {
+    DebugFrameHeader h;
+    uint8_t fde_def_cfa[4];
+    uint8_t fde_reg_ofs[ARRAY_SIZE(tcg_target_callee_save_regs) * 2];
+} DebugFrame;
+
+#define ELF_HOST_MACHINE EM_RISCV
+
+static const DebugFrame debug_frame = {
+    .h.cie.len = sizeof(DebugFrameCIE) - 4, /* length after .len member */
+    .h.cie.id = -1,
+    .h.cie.version = 1,
+    .h.cie.code_align = 1,
+    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.return_column = TCG_REG_RA,
+
+    /* Total FDE size does not include the "len" member.  */
+    .h.fde.len = sizeof(DebugFrame) - offsetof(DebugFrame, h.fde.cie_offset),
+
+    .fde_def_cfa = {
+        12, TCG_REG_SP,                 /* DW_CFA_def_cfa sp, ... */
+        (FRAME_SIZE & 0x7f) | 0x80,     /* ... uleb128 FRAME_SIZE */
+        (FRAME_SIZE >> 7)
+    },
+    .fde_reg_ofs = {
+        0x80 + 9,  12,                  /* DW_CFA_offset, s1,  -96 */
+        0x80 + 18, 11,                  /* DW_CFA_offset, s2,  -88 */
+        0x80 + 19, 10,                  /* DW_CFA_offset, s3,  -80 */
+        0x80 + 20, 9,                   /* DW_CFA_offset, s4,  -72 */
+        0x80 + 21, 8,                   /* DW_CFA_offset, s5,  -64 */
+        0x80 + 22, 7,                   /* DW_CFA_offset, s6,  -56 */
+        0x80 + 23, 6,                   /* DW_CFA_offset, s7,  -48 */
+        0x80 + 24, 5,                   /* DW_CFA_offset, s8,  -40 */
+        0x80 + 25, 4,                   /* DW_CFA_offset, s9,  -32 */
+        0x80 + 26, 3,                   /* DW_CFA_offset, s10, -24 */
+        0x80 + 27, 2,                   /* DW_CFA_offset, s11, -16 */
+        0x80 + 1 , 1,                   /* DW_CFA_offset, ra,  -8 */
+    }
+};
+
+void tcg_register_jit(void *buf, size_t buf_size)
+{
+    tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
+}
-- 
2.7.0
