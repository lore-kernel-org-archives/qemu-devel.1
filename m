Received: from eggs.gnu.org ([2001:4830:134:3::10]:41742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgL-0007Bb-Fe
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgK-0007oO-8H
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:41 -0500
Received: from mail-wj0-f176.google.com ([209.85.210.176]:36486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFJgJ-0007o3-Vi
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:40 -0500
Received: by mail-wj0-f176.google.com with SMTP id tk12so12536160wjb.3
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 03:49:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Dec 2016 11:48:22 +0000
Message-Id: <20161209114830.9158-3-alex.bennee@linaro.org>
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 02/10] aarch64: add hand-coded risu
 skeleton for directed testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Sometimes you want absolute control over your test set-up to feed
explicit values into the test. This started as an experiment but might
be useful for further developing tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile                      |   7 ++
 aarch64_simd_handcoded.risu.S | 208 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 aarch64_simd_handcoded.risu.S

diff --git a/Makefile b/Makefile
index bfa8cac..4202c35 100644
--- a/Makefile
+++ b/Makefile
@@ -36,6 +36,13 @@ $(PROG): $(OBJS)
 %.risu.asm: %.risu.bin
 	${OBJDUMP} -b binary -m $(ARCH) -D $^ > $@
 
+# hand-coded tests
+%.risu.bin: %.risu.elf
+	$(OBJCOPY) -O binary $< $@
+
+%.risu.elf: %.risu.S
+	${AS} -o $@ $^
+
 %.o: %.c $(HDRS)
 	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
 
diff --git a/aarch64_simd_handcoded.risu.S b/aarch64_simd_handcoded.risu.S
new file mode 100644
index 0000000..61bd11a
--- /dev/null
+++ b/aarch64_simd_handcoded.risu.S
@@ -0,0 +1,208 @@
+/*
+    Hand coded RISU tests for aarch64
+
+    Sometimes you want slightly more than random instructions and you
+    want a specifically crafted test but within RISU's framework.
+
+    This file offers such a thing.
+        # So the last nibble indicates the desired operation:
+my $OP_COMPARE = 0;        # compare registers
+my $OP_TESTEND = 1;        # end of test, stop
+my $OP_SETMEMBLOCK = 2;    # r0 is address of memory block (8192 bytes)
+my $OP_GETMEMBLOCK = 3;    # add the address of memory block to r0
+my $OP_COMPAREMEM = 4;     # compare memory block
+
+        */
+
+.macro  risuop_comp
+        .word   0x00005af0
+.endm
+.macro  risuop_testend
+        .word   0x00005af1
+.endm
+
+        .org    0x0
+        
+//.globl	.data
+ 	mov	x0, #0x0                   	// #0
+ 	msr	fpsr, x0
+ 	mov	x0, #0x0                   	// #0
+ 	msr	fpcr, x0
+ 	mrs	x0, nzcv
+ 	eor	w0, w0, #0xf0000000
+ 	msr	nzcv, x0
+ 	adr	x0, _q0
+ 	eor	x0, x0, #0xf
+ 	b	reg_setup
+
+        /*
+
+        This is the of block of data used for ld/st and setting up vector regs
+        Each .word is 32bits of data
+
+        */
+        .align  16
+        
+_q0:    .word   0x70000000, 0xffffffff, 0x80000000, 0xffffffff
+_q1:    .word   0x90000000, 0x00000000, 0xa0000000, 0x00000000
+_q2:    .word   0xffff0000, 0x00000000, 0xeeee0000, 0x00000000
+_q3:    .word   0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
+_q4:    .word   0x80000000, 0x00000000, 0xf0000000, 0x00000000
+_q5:    .word   0xffff0000, 0x00000000, 0xeeee0000, 0x00000000
+_q6:    .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q7:    .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+
+_q8:    .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q9:    .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q10:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q11:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q12:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q13:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q14:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q15:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+
+_q16:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q17:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q18:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q19:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q20:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q21:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q22:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q23:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+
+_q24:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q25:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q26:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q27:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q28:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q29:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q30:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+_q31:   .word   0x00000000, 0x00000000, 0x00000000, 0x00000000
+        
+        .align  16
+
+        /* Setup the register state */
+reg_setup:
+ 	ldp	q0, q1, [x0],#32
+ 	ldp	q2, q3, [x0],#16
+ 	ldp	q4, q5, [x0],#16
+ 	ldp	q6, q7, [x0],#16
+ 	ldp	q8, q9, [x0],#16
+ 	ldp	q10, q11, [x0],#16
+ 	ldp	q12, q13, [x0],#16
+ 	ldp	q14, q15, [x0],#16
+ 	ldp	q16, q17, [x0],#16
+ 	ldp	q18, q19, [x0],#16
+ 	ldp	q20, q21, [x0],#16
+ 	ldp	q22, q23, [x0],#16
+ 	ldp	q24, q25, [x0],#16
+ 	ldp	q26, q27, [x0],#16
+ 	ldp	q28, q29, [x0],#16
+ 	ldp	q30, q31, [x0],#16
+
+        /* Set-up integer registers */
+        mov     x0, #0
+        mov     x1, #0
+        mov     x2, #0
+        mov     x3, #0
+        mov     x4, #0
+        mov     x5, #0
+        mov     x6, #0
+        mov     x7, #0
+        mov     x8, #0
+        mov     x9, #0
+        mov     x10, #0
+        mov     x11, #0
+        mov     x12, #0
+        mov     x13, #0
+        mov     x14, #0
+        mov     x15, #0
+        mov     x16, #0
+        mov     x17, #0
+        mov     x18, #0
+        mov     x19, #0
+        mov     x20, #0
+        mov     x21, #0
+        mov     x22, #0
+        mov     x23, #0
+        mov     x24, #0
+        mov     x25, #0
+        mov     x26, #0
+        mov     x26, #0
+        mov     x27, #0
+        mov     x28, #0
+        mov     x29, #0
+        mov     x30, #0
+
+        risuop_comp
+
+        /* Testing ursra */
+        
+ 	ursra	v16.2d, v0.2d, #64
+        risuop_comp
+ 	ursra	v17.2d, v1.2d, #64
+        risuop_comp
+ 	ursra	v18.2d, v2.2d, #64
+        risuop_comp
+ 	ursra	v19.2d, v3.2d, #64
+        risuop_comp
+ 	ursra	v20.2d, v4.2d, #64
+        risuop_comp
+ 	ursra	v21.2d, v5.2d, #64
+        risuop_comp
+ 	ursra	v22.2d, v6.2d, #64
+        risuop_comp
+ 	ursra	v23.2d, v7.2d, #64
+        risuop_comp
+ 	ursra	v24.2d, v8.2d, #64
+        risuop_comp
+ 	ursra	v25.2d, v9.2d, #64
+        risuop_comp
+ 	ursra	v26.2d, v10.2d, #64
+        risuop_comp
+ 	ursra	v27.2d, v11.2d, #64
+        risuop_comp
+ 	ursra	v28.2d, v12.2d, #64
+        risuop_comp
+ 	ursra	v29.2d, v13.2d, #64
+        risuop_comp
+ 	ursra	v30.2d, v14.2d, #64
+        risuop_comp
+ 	ursra	v31.2d, v15.2d, #64
+        risuop_comp
+
+        /* second pass */
+        ursra	v16.2d, v0.2d, #64
+        risuop_comp
+ 	ursra	v17.2d, v1.2d, #64
+        risuop_comp
+ 	ursra	v18.2d, v2.2d, #64
+        risuop_comp
+ 	ursra	v19.2d, v3.2d, #64
+        risuop_comp
+ 	ursra	v20.2d, v4.2d, #64
+        risuop_comp
+ 	ursra	v21.2d, v5.2d, #64
+        risuop_comp
+ 	ursra	v22.2d, v6.2d, #64
+        risuop_comp
+ 	ursra	v23.2d, v7.2d, #64
+        risuop_comp
+ 	ursra	v24.2d, v8.2d, #64
+        risuop_comp
+ 	ursra	v25.2d, v9.2d, #64
+        risuop_comp
+ 	ursra	v26.2d, v10.2d, #64
+        risuop_comp
+ 	ursra	v27.2d, v11.2d, #64
+        risuop_comp
+ 	ursra	v28.2d, v12.2d, #64
+        risuop_comp
+ 	ursra	v29.2d, v13.2d, #64
+        risuop_comp
+ 	ursra	v30.2d, v14.2d, #64
+        risuop_comp
+ 	ursra	v31.2d, v15.2d, #64
+        risuop_comp
+
+        risuop_testend       /* test end */
-- 
2.11.0
