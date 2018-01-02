Received: from eggs.gnu.org ([2001:4830:134:3::10]:35947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6H-0001Va-Ui
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6F-00052o-GE
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:41 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:64145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWB6F-00051e-60
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:39 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  2 Jan 2018 02:10:20 +0100
Message-Id: <20180102011032.30056-6-laurent@vivier.eu>
In-Reply-To: <20180102011032.30056-1-laurent@vivier.eu>
References: <20180102011032.30056-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 05/17] target/m68k: add CPU_LOG_INT trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

Display the interrupts/exceptions information
in QEMU logs (-d int)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h       |   8 ++++
 target/m68k/op_helper.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 5d03764eab..acc2629216 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -45,6 +45,8 @@
 #define EXCP_ADDRESS        3   /* Address error.  */
 #define EXCP_ILLEGAL        4   /* Illegal instruction.  */
 #define EXCP_DIV0           5   /* Divide by zero */
+#define EXCP_CHK            6   /* CHK, CHK2 Instructions */
+#define EXCP_TRAPCC         7   /* FTRAPcc, TRAPcc, TRAPV Instructions */
 #define EXCP_PRIVILEGE      8   /* Privilege violation.  */
 #define EXCP_TRACE          9
 #define EXCP_LINEA          10  /* Unimplemented line-A (MAC) opcode.  */
@@ -53,6 +55,9 @@
 #define EXCP_DEBEGBP        13  /* Breakpoint debug interrupt.  */
 #define EXCP_FORMAT         14  /* RTE format error.  */
 #define EXCP_UNINITIALIZED  15
+#define EXCP_SPURIOUS       24  /* Spurious interrupt */
+#define EXCP_INT_LEVEL_1    25  /* Level 1 Interrupt autovector */
+#define EXCP_INT_LEVEL_7    31  /* Level 7 Interrupt autovector */
 #define EXCP_TRAP0          32   /* User trap #0.  */
 #define EXCP_TRAP15         47   /* User trap #15.  */
 #define EXCP_FP_BSUN        48 /* Branch Set on Unordered */
@@ -63,6 +68,9 @@
 #define EXCP_FP_OVFL        53 /* Overflow */
 #define EXCP_FP_SNAN        54 /* Signaling Not-A-Number */
 #define EXCP_FP_UNIMP       55 /* Unimplemented Data type */
+#define EXCP_MMU_CONF       56  /* MMU Configuration Error */
+#define EXCP_MMU_ILLEGAL    57  /* MMU Illegal Operation Error */
+#define EXCP_MMU_ACCESS     58  /* MMU Access Level Violation Error */
 #define EXCP_UNSUPPORTED    61
 
 #define EXCP_RTE            0x100
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 63089511cb..f899b4b086 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -68,6 +68,111 @@ static void do_rte(CPUM68KState *env)
     helper_set_sr(env, fmt);
 }
 
+static const char *m68k_exception_name(int index)
+{
+    switch (index) {
+    case EXCP_ACCESS:
+        return "Access Fault";
+    case EXCP_ADDRESS:
+        return "Address Error";
+    case EXCP_ILLEGAL:
+        return "Illegal Instruction";
+    case EXCP_DIV0:
+        return "Divide by Zero";
+    case EXCP_CHK:
+        return "CHK/CHK2";
+    case EXCP_TRAPCC:
+        return "FTRAPcc, TRAPcc, TRAPV";
+    case EXCP_PRIVILEGE:
+        return "Privilege Violation";
+    case EXCP_TRACE:
+        return "Trace";
+    case EXCP_LINEA:
+        return "A-Line";
+    case EXCP_LINEF:
+        return "F-Line";
+    case EXCP_DEBEGBP: /* 68020/030 only */
+        return "Copro Protocol Violation";
+    case EXCP_FORMAT:
+        return "Format Error";
+    case EXCP_UNINITIALIZED:
+        return "Unitialized Interruot";
+    case EXCP_SPURIOUS:
+        return "Spurious Interrupt";
+    case EXCP_INT_LEVEL_1:
+        return "Level 1 Interrupt";
+    case EXCP_INT_LEVEL_1 + 1:
+        return "Level 2 Interrupt";
+    case EXCP_INT_LEVEL_1 + 2:
+        return "Level 3 Interrupt";
+    case EXCP_INT_LEVEL_1 + 3:
+        return "Level 4 Interrupt";
+    case EXCP_INT_LEVEL_1 + 4:
+        return "Level 5 Interrupt";
+    case EXCP_INT_LEVEL_1 + 5:
+        return "Level 6 Interrupt";
+    case EXCP_INT_LEVEL_1 + 6:
+        return "Level 7 Interrupt";
+    case EXCP_TRAP0:
+        return "TRAP #0";
+    case EXCP_TRAP0 + 1:
+        return "TRAP #1";
+    case EXCP_TRAP0 + 2:
+        return "TRAP #2";
+    case EXCP_TRAP0 + 3:
+        return "TRAP #3";
+    case EXCP_TRAP0 + 4:
+        return "TRAP #4";
+    case EXCP_TRAP0 + 5:
+        return "TRAP #5";
+    case EXCP_TRAP0 + 6:
+        return "TRAP #6";
+    case EXCP_TRAP0 + 7:
+        return "TRAP #7";
+    case EXCP_TRAP0 + 8:
+        return "TRAP #8";
+    case EXCP_TRAP0 + 9:
+        return "TRAP #9";
+    case EXCP_TRAP0 + 10:
+        return "TRAP #10";
+    case EXCP_TRAP0 + 11:
+        return "TRAP #11";
+    case EXCP_TRAP0 + 12:
+        return "TRAP #12";
+    case EXCP_TRAP0 + 13:
+        return "TRAP #13";
+    case EXCP_TRAP0 + 14:
+        return "TRAP #14";
+    case EXCP_TRAP0 + 15:
+        return "TRAP #15";
+    case EXCP_FP_BSUN:
+        return "FP Branch/Set on unordered condition";
+    case EXCP_FP_INEX:
+        return "FP Inexact Result";
+    case EXCP_FP_DZ:
+        return "FP Divide by Zero";
+    case EXCP_FP_UNFL:
+        return "FP Underflow";
+    case EXCP_FP_OPERR:
+        return "FP Operand Error";
+    case EXCP_FP_OVFL:
+        return "FP Overflow";
+    case EXCP_FP_SNAN:
+        return "FP Signaling NAN";
+    case EXCP_FP_UNIMP:
+        return "FP Unimplemented Data Type";
+    case EXCP_MMU_CONF: /* 68030/68851 only */
+        return "MMU Configuration Error";
+    case EXCP_MMU_ILLEGAL: /* 68851 only */
+        return "MMU Illegal Operation";
+    case EXCP_MMU_ACCESS: /* 68851 only */
+        return "MMU Access Level Violation";
+    case 64 ... 255:
+        return "User Defined Vector";
+    }
+    return "Unassigned";
+}
+
 static void do_interrupt_all(CPUM68KState *env, int is_hw)
 {
     CPUState *cs = CPU(m68k_env_get_cpu(env));
@@ -109,6 +214,13 @@ static void do_interrupt_all(CPUM68KState *env, int is_hw)
 
     vector = cs->exception_index << 2;
 
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        static int count;
+        qemu_log("INT %6d: %s(%#x) pc=%08x sp=%08x sr=%04x\n",
+                 ++count, m68k_exception_name(cs->exception_index),
+                 vector, env->pc, env->aregs[7], env->sr);
+    }
+
     fmt |= 0x40000000;
     fmt |= vector << 16;
     fmt |= env->sr;
-- 
2.14.3
