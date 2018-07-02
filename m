Received: from eggs.gnu.org ([2001:4830:134:3::10]:33951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fZw5L-0000TY-Pe
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fZw5H-0000Nb-5O
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:29:31 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fZw5G-0000NM-Qh
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:29:27 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  2 Jul 2018 12:28:21 +0200
Message-Id: <20180702102821.22188-2-laurent@vivier.eu>
In-Reply-To: <20180702102821.22188-1-laurent@vivier.eu>
References: <20180702102821.22188-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/1] target/m68k: correctly disassemble move16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

"move16 %a0@+,%a1@" and "fmovel (cpid=3) %a0@-,%fpcr"
share the same opcode.

To fix that, backport the fix from binutils:

  2005-11-10  Andreas Schwab  <schwab@suse.de>

     * m68k-dis.c (print_insn_m68k): Only match FPU insns with
     coprocessor ID 1.

Reported-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20180625203559.21370-2-laurent@vivier.eu>
---
 disas/m68k.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/disas/m68k.c b/disas/m68k.c
index 61b689ef3e..a687df437c 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -2017,6 +2017,20 @@ print_insn_m68k (bfd_vma memaddr, disassemble_info *info)
 		}
 	    }
 
+          /* Don't match FPU insns with non-default coprocessor ID.  */
+          if (*d == '\0')
+            {
+              for (d = opc->args; *d; d += 2)
+                {
+                  if (d[0] == 'I')
+                    {
+                      val = fetch_arg (buffer, 'd', 3, info);
+                      if (val != 1)
+                        break;
+                    }
+                }
+            }
+
 	  if (*d == '\0')
 	    if ((val = match_insn_m68k (memaddr, info, opc, & priv)))
 	      return val;
-- 
2.14.4
