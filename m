Received: from eggs.gnu.org ([2001:4830:134:3::10]:47746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f8gmz-0004yB-U9
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f8gmw-0001AK-Ry
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:41:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46190)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1f8gmw-00015k-IL
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:41:54 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 18 Apr 2018 09:41:53 +0300
Message-ID: <20180418064152.24606.71975.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] m68k: fix subx mem, mem instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, laurent@vivier.eu, pavel.dovgaluk@ispras.ru

This patch fixes decrement of the pointers for subx mem, mem instructions.
Without the patch pointers are decremented by OS_* constant value instead of
retrieving the corresponding data size and using it as a decrement.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 target/m68k/translate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6beaf9e..e407ba2 100644
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
