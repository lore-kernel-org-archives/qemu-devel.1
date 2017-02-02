Received: from eggs.gnu.org ([2001:4830:134:3::10]:35356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU4-0005NW-DP
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU0-0005SJ-VX
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:36 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39804 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU0-0005Ow-H0
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:32 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:59 +0300
Message-Id: <1486046099-17726-22-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 21/21] tcg/README: update README to
 include information about vector opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/README | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/tcg/README b/tcg/README
index a9858c2..209dbc4 100644
--- a/tcg/README
+++ b/tcg/README
@@ -53,9 +53,18 @@ an "undefined result".
 
 TCG instructions operate on variables which are temporaries, local
 temporaries or globals. TCG instructions and variables are strongly
-typed. Two types are supported: 32 bit integers and 64 bit
-integers. Pointers are defined as an alias to 32 bit or 64 bit
-integers depending on the TCG target word size.
+typed. Several types are supported:
+
+* 32 bit integers,
+
+* 64 bit integers,
+
+* 64 bit vectors,
+
+* 128 bit vectors.
+
+Pointers are defined as an alias to 32 bit or 64 bit integers
+depending on the TCG target word size.
 
 Each instruction has a fixed number of output variable operands, input
 variable operands and always constant operands.
@@ -208,6 +217,22 @@ t0=t1%t2 (signed). Undefined behavior if division by zero or overflow.
 
 t0=t1%t2 (unsigned). Undefined behavior if division by zero.
 
+* add_i8x16 t0, t1, t2
+add_i16x8 t0, t1, t2
+add_i32x4 t0, t1, t2
+add_i64x2 t0, t1, t2
+
+t0=t1+t2 where t0, t1 and t2 are 128 bit vectors of 8, 16, 32 or 64 bit
+integers.
+
+* add_i8x8 t0, t1, t2
+add_i16x4 t0, t1, t2
+add_i32x2 t0, t1, t2
+add_i64x1 t0, t1, t2
+
+t0=t1+t2 where t0, t1 and t2 are 64 bit vectors of 8, 16, 32 or 64 bit
+integers.
+
 ********* Logical
 
 * and_i32/i64 t0, t1, t2
@@ -477,8 +502,8 @@ current TB was linked to this TB. Otherwise execute the next
 instructions. Only indices 0 and 1 are valid and tcg_gen_goto_tb may be issued
 at most once with each slot index per TB.
 
-* qemu_ld_i32/i64 t0, t1, flags, memidx
-* qemu_st_i32/i64 t0, t1, flags, memidx
+* qemu_ld_i32/i64/v128 t0, t1, flags, memidx
+* qemu_st_i32/i64/v128 t0, t1, flags, memidx
 
 Load data at the guest address t1 into t0, or store data in t0 at guest
 address t1.  The _i32/_i64 size applies to the size of the input/output
@@ -488,6 +513,9 @@ and the width of the memory operation is controlled by flags.
 Both t0 and t1 may be split into little-endian ordered pairs of registers
 if dealing with 64-bit quantities on a 32-bit host.
 
+The _v128 size can only be used to read exactly 128 bit. Host and target
+are required to be of the same endianness for it to work.
+
 The memidx selects the qemu tlb index to use (e.g. user or kernel access).
 The flags are the TCGMemOp bits, selecting the sign, width, and endianness
 of the memory access.
@@ -538,6 +566,15 @@ Floating point operations are not supported in this version. A
 previous incarnation of the code generator had full support of them,
 but it is better to concentrate on integer operations first.
 
+To support vector operations, the backend must define:
+- TCG_TARGET_HAS_REGV64 for the 64 bit vector type and/or
+- TCG_TARGET_HAS_REG128 for the 128 bit vector type.
+For supported types, load and store operations must be supported. An
+arbitrary set of other vector operations may be supported. Vector operations
+that were not explicitly declared as supported (by defining
+TCG_TARGET_HAS_<operation> to 1) will never appear in the intermediate
+representation. In this case, the emulation code will be emitted instead.
+
 4.2) Constraints
 
 GCC like constraints are used to define the constraints of every
-- 
2.1.4
