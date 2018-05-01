Received: from eggs.gnu.org ([2001:4830:134:3::10]:43986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlH-0003Pi-GF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlD-0007xA-8e
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:07 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  1 May 2018 15:55:44 +0200
Message-Id: <20180501135547.12414-2-laurent@vivier.eu>
In-Reply-To: <20180501135547.12414-1-laurent@vivier.eu>
References: <20180501135547.12414-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/4] m68k: fix subx mem, mem instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch fixes decrement of the pointers for subx mem, mem instructions.
Without the patch pointers are decremented by OS_* constant value instead of
retrieving the corresponding data size and using it as a decrement.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180418064152.24606.71975.stgit@pasha-VirtualBox>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6beaf9ed66..e407ba2db3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3166,11 +3166,11 @@ DISAS_INSN(subx_mem)
     opsize = insn_opsize(insn);
 
     addr_src = AREG(insn, 0);
-    tcg_gen_subi_i32(addr_src, addr_src, opsize);
+    tcg_gen_subi_i32(addr_src, addr_src, opsize_bytes(opsize));
     src = gen_load(s, opsize, addr_src, 1, IS_USER(s));
 
     addr_dest = AREG(insn, 9);
-    tcg_gen_subi_i32(addr_dest, addr_dest, opsize);
+    tcg_gen_subi_i32(addr_dest, addr_dest, opsize_bytes(opsize));
     dest = gen_load(s, opsize, addr_dest, 1, IS_USER(s));
 
     gen_subx(s, src, dest, opsize);
-- 
2.14.3
