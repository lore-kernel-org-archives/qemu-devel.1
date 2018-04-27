Received: from eggs.gnu.org ([2001:4830:134:3::10]:59817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaX-000295-HG
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaW-0002IQ-FU
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:00 +1000
Message-Id: <20180427092126.24812-24-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/49] ppc: Fix size of ppc64 xer register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Matz <matz@suse.de>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Matz <matz@suse.de>

The normal gdb definition of the XER registers is only 32 bit,
and that's what the current version of power64-core.xml also
says (seems copied from gdb's).  But qemu's idea of the XER register
is target_ulong (in CPUPPCState, ppc_gdb_register_len and
ppc_cpu_gdb_read_register)

That mismatch leads to the following message when attaching
with gdb:

  Truncated register 32 in remote 'g' packet

(and following on that qemu stops responding).  The simple fix is
to say the truth in the .xml file.  But the better fix is to
actually make it 32bit on the wire, as old gdbs don't support
XML files for describing registers.  Also the XER state in qemu
doesn't seem to use the high 32 bits, so sending it off to gdb
doesn't seem worthwhile.

Signed-off-by: Michael Matz <matz@suse.de>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/gdbstub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 7a338136a8..b6f6693583 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -37,10 +37,10 @@ static int ppc_gdb_register_len_apple(int n)
     case 65+32: /* msr */
     case 67+32: /* lr */
     case 68+32: /* ctr */
-    case 69+32: /* xer */
     case 70+32: /* fpscr */
         return 8;
     case 66+32: /* cr */
+    case 69+32: /* xer */
         return 4;
     default:
         return 0;
@@ -61,6 +61,8 @@ static int ppc_gdb_register_len(int n)
         return 8;
     case 66:
         /* cr */
+    case 69:
+        /* xer */
         return 4;
     case 64:
         /* nip */
@@ -70,8 +72,6 @@ static int ppc_gdb_register_len(int n)
         /* lr */
     case 68:
         /* ctr */
-    case 69:
-        /* xer */
         return sizeof(target_ulong);
     case 70:
         /* fpscr */
@@ -152,7 +152,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
             gdb_get_regl(mem_buf, env->ctr);
             break;
         case 69:
-            gdb_get_regl(mem_buf, env->xer);
+            gdb_get_reg32(mem_buf, env->xer);
             break;
         case 70:
             gdb_get_reg32(mem_buf, env->fpscr);
@@ -208,7 +208,7 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
             gdb_get_reg64(mem_buf, env->ctr);
             break;
         case 69 + 32:
-            gdb_get_reg64(mem_buf, env->xer);
+            gdb_get_reg32(mem_buf, env->xer);
             break;
         case 70 + 32:
             gdb_get_reg64(mem_buf, env->fpscr);
@@ -259,7 +259,7 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             env->ctr = ldtul_p(mem_buf);
             break;
         case 69:
-            env->xer = ldtul_p(mem_buf);
+            env->xer = ldl_p(mem_buf);
             break;
         case 70:
             /* fpscr */
@@ -309,7 +309,7 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
             env->ctr = ldq_p(mem_buf);
             break;
         case 69 + 32:
-            env->xer = ldq_p(mem_buf);
+            env->xer = ldl_p(mem_buf);
             break;
         case 70 + 32:
             /* fpscr */
-- 
2.14.3
