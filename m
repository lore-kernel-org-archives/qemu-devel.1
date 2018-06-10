Received: from eggs.gnu.org ([2001:4830:134:3::10]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fS2Qp-00051C-5K
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 11:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fS2Qm-0002nv-1P
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 11:39:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43774 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fS2Ql-0002nU-Rt
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 11:38:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sun, 10 Jun 2018 16:35:56 +0100
Message-Id: <20180610153556.17107-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC] target/arm: add ARMv6-M UNDEFINED 32-bit
 instruction test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jusual@mail.ru
Cc: qemu.ml@steffen-goertz.de, joel@jms.id.au, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, Stefan Hajnoczi <stefanha@redhat.com>

Test that 32-bit instructions declared UNDEFINED in the ARMv6-M
Reference Manual really do raise an exception.

The Intel HEX (.hex) file is included to save people the trouble of
installing a cross-compiler toolchain.

To run the test (make sure qemu-system-arm is in your $PATH):

  $ cd tests/tcg/arm
  $ make run-test-armv6m-undef

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Based-on: http://github.com/stefanha/qemu/commits/microbit
---
Hi Julia,
Several instructions are currently not raising an exception.  I have
commented them out with "FAIL".  Maybe your 32-bit instruction work will
fix them.  Otherwise they require additional investigation.

Hi Peter and Alex,
Is this along the lines you were thinking of when we discussed this type
of test on IRC?

 tests/tcg/arm/Makefile              |  21 +++++
 tests/tcg/arm/test-armv6m-undef.S   | 119 ++++++++++++++++++++++++++++
 tests/tcg/arm/test-armv6m-undef.hex |  17 ++++
 tests/tcg/arm/test-armv6m-undef.ld  |  21 +++++
 4 files changed, 178 insertions(+)
 create mode 100644 tests/tcg/arm/Makefile
 create mode 100644 tests/tcg/arm/test-armv6m-undef.S
 create mode 100644 tests/tcg/arm/test-armv6m-undef.hex
 create mode 100644 tests/tcg/arm/test-armv6m-undef.ld

diff --git a/tests/tcg/arm/Makefile b/tests/tcg/arm/Makefile
new file mode 100644
index 0000000000..c43049ca10
--- /dev/null
+++ b/tests/tcg/arm/Makefile
@@ -0,0 +1,21 @@
+CC = arm-linux-gnu-gcc
+OBJCOPY = arm-linux-gnu-objcopy
+
+SOURCES = $(wildcard *.S)
+BINARIES = $(patsubst %.S,%.hex,$(SOURCES))
+
+.PHONY: clean
+
+all: $(BINARIES)
+
+clean:
+	rm -f $(BINARIES) *.o
+
+%.o: %.S %.ld
+	$(CC) -nostdlib -Wl,--build-id=none -x assembler-with-cpp -T $(patsubst %.S,%.ld,$<) -x assembler-with-cpp -o $@ $<
+
+%.hex: %.o
+	$(OBJCOPY) -O ihex $< $@
+
+run-test-armv6m-undef: test-armv6m-undef.hex
+	qemu-system-arm -semihosting -M microbit -kernel $<
diff --git a/tests/tcg/arm/test-armv6m-undef.S b/tests/tcg/arm/test-armv6m-undef.S
new file mode 100644
index 0000000000..d16ce0326a
--- /dev/null
+++ b/tests/tcg/arm/test-armv6m-undef.S
@@ -0,0 +1,119 @@
+/*
+ * Test ARMv6-M UNDEFINED 32-bit instructions
+ *
+ * Copyright 2018 Red Hat Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2
+ * or later. See the COPYING file in the top-level directory.
+ */
+
+/*
+ * Test that UNDEFINED 32-bit instructions fault as expected.  This is an
+ * interesting test because ARMv6-M shares code with its more fully-featured
+ * siblings and it's necessary to verify that its limited instruction set is
+ * emulated correctly.
+ *
+ * The emulator must be invoked with -semihosting so that the test case can
+ * terminate with exit code 0 on success or 1 on failure.
+ *
+ * Failures can be debugged with -d in_asm,int,exec,cpu and the
+ * gdbstub (-S -s).
+ */
+
+.syntax unified
+.cpu cortex-m0
+.thumb
+
+/*
+ * Memory map
+ */
+#define SRAM_BASE 0x20000000
+#define SRAM_SIZE (16 * 1024)
+
+/*
+ * Semihosting interface on ARM T32
+ * See "Semihosting for AArch32 and AArch64 Version 2.0 Documentation" by ARM
+ */
+#define semihosting_call bkpt 0xab
+#define SYS_EXIT 0x18
+
+vector_table:
+    .word SRAM_BASE + SRAM_SIZE /* 0. SP_main */
+    .word exc_reset_thumb       /* 1. Reset */
+    .word 0                     /* 2. NMI */
+    .word exc_hard_fault_thumb  /* 3. HardFault */
+    .rept 7
+    .word 0                     /* 4-10. Reserved */
+    .endr
+    .word 0                     /* 11. SVCall */
+    .word 0                     /* 12. Reserved */
+    .word 0                     /* 13. Reserved */
+    .word 0                     /* 14. PendSV */
+    .word 0                     /* 15. SysTick */
+    .rept 32
+    .word 0                     /* 16-47. External Interrupts */
+    .endr
+
+exc_reset:
+.equ exc_reset_thumb, exc_reset + 1
+.global exc_reset_thumb
+    /* The following 32-bit UNDEFINED instructions are tested by executing
+     * them.  The HardFault exception handler should execute and return to
+     * the next test case.  If no exception is raised the test fails.
+     */
+
+    /* Table A5-9 32-bit Thumb encoding */
+/* FAIL disas_thumb_insn() case 14 is missing UNDEF for BL/BLX!
+    .short 0b1110100000000000
+    .short 0b0000000000000000
+    b not_reached */
+/* FAIL    .short 0b1110100000000000
+    .short 0b1000000000000000
+    b not_reached */
+/* FAIL .short 0b1111100000000000
+    .short 0b0000000000000000
+    b not_reached */
+/* FAIL    .short 0b1111100000000000
+    .short 0b1000000000000000
+    b not_reached */
+    .short 0b1111000000000000
+    .short 0b0000000000000000
+    b not_reached
+
+    /* Table A5-10 Branch and miscellaneous control instructions */
+    .short 0b1111011111110000
+    .short 0b1010000000000000
+    b not_reached
+
+    /* Success! */
+    movs r0, 1
+    b exit
+
+not_reached: /* Failure :( */
+    movs r0, 0
+    b exit
+
+/* When a HardFault occurs, return to pc+6 (test cases are 3 halfwords long) */
+exc_hard_fault:
+.equ exc_hard_fault_thumb, exc_hard_fault + 1
+.global exc_hard_fault_thumb
+    ldr r0, [sp, 0x18]
+    adds r0, 6
+    str r0, [sp, 0x18]
+    bx lr
+
+/*
+ * exit: Terminate emulator
+ * @r0: 0 - failure, 1 - success
+ */
+exit:
+    movs r1, 0
+    cmp r0, 1
+    bne 1f
+    ldr r1, ADP_Stopped_ApplicationExit
+1:
+    movs r0, SYS_EXIT
+    semihosting_call
+.align 2
+ADP_Stopped_ApplicationExit:
+    .word 0x20026
diff --git a/tests/tcg/arm/test-armv6m-undef.hex b/tests/tcg/arm/test-armv6m-undef.hex
new file mode 100644
index 0000000000..7abd63a386
--- /dev/null
+++ b/tests/tcg/arm/test-armv6m-undef.hex
@@ -0,0 +1,17 @@
+:1000000000400020C100000000000000D5000000FA
+:1000100000000000000000000000000000000000E0
+:1000200000000000000000000000000000000000D0
+:1000300000000000000000000000000000000000C0
+:1000400000000000000000000000000000000000B0
+:1000500000000000000000000000000000000000A0
+:100060000000000000000000000000000000000090
+:100070000000000000000000000000000000000080
+:100080000000000000000000000000000000000070
+:100090000000000000000000000000000000000060
+:1000A0000000000000000000000000000000000050
+:1000B0000000000000000000000000000000000040
+:1000C00000F0000004E0F0F700A001E0012005E0EE
+:1000D000002003E0069806300690704700210128B2
+:0C00E00000D101491820ABBE2600020030
+:04000003000000C138
+:00000001FF
diff --git a/tests/tcg/arm/test-armv6m-undef.ld b/tests/tcg/arm/test-armv6m-undef.ld
new file mode 100644
index 0000000000..43dbbf17d5
--- /dev/null
+++ b/tests/tcg/arm/test-armv6m-undef.ld
@@ -0,0 +1,21 @@
+ENTRY(exc_reset_thumb)
+
+SECTIONS
+{
+    . = 0x0;
+    .text : {
+        *(.text)
+    }
+    .data : {
+        *(.data)
+    }
+    .rodata : {
+        *(.rodata)
+    }
+    .bss : {
+        *(.bss)
+    }
+    /DISCARD/ : {
+        *(.ARM.attributes)
+    }
+}
-- 
2.17.1
