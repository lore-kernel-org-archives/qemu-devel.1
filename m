Received: from eggs.gnu.org ([2001:4830:134:3::10]:37410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <matz@suse.de>) id 1epHAZ-0003QN-Hi
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <matz@suse.de>) id 1epHAU-0000iZ-Ks
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:30:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:43295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <matz@suse.de>) id 1epHAU-0000h0-EA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:29:58 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7B849AC07
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 17:29:56 +0000 (UTC)
Date: Fri, 23 Feb 2018 17:29:56 +0000 (UTC)
From: Michael Matz <matz@suse.de>
Message-ID: <alpine.LSU.2.21.1802231729040.10187@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Qemu-devel] [PATCH] ppc: Fix size of ppc64 xer register (fwd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Torsten Duwe <duwe@suse.de>

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
---
 target/ppc/gdbstub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 7a33813..b6f6693 100644
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
1.8.1.4
