Received: from eggs.gnu.org ([2001:4830:134:3::10]:41411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXo-00022I-OS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXm-0000Vu-OD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:56 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKXm-0000Te-Hv
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:54 -0400
Received: by mail-lf0-x242.google.com with SMTP id g21so17212172lfk.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:54:52 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:32 +0200
Message-Id: <1499162088-1562-2-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 01/17] disas/microblaze: Add missing 'const'
 attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: Stefan Weil <sw@weilnetz.de>

Making the opcode list 'const' saves memory.
Some function arguments and local variables needed 'const', too.

Add also 'static' to two local functions.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Stefan Weil <sw@weilnetz.de>
[EI: Removed old prototypes to fix the build]
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 disas/microblaze.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 7795a0b..598ecbc 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -272,7 +272,7 @@ enum microblaze_instr_type {
 
 #define MAX_OPCODES 280
 
-static struct op_code_struct {
+static const struct op_code_struct {
   const char *name;
   short inst_type; /* registers and immediate values involved */
   short inst_offset_type; /* immediate vals offset from PC? (= 1 for branches) */
@@ -596,10 +596,6 @@ static char * get_field_imm15 (long instr);
 #if 0
 static char * get_field_unsigned_imm (long instr);
 #endif
-char * get_field_special (long instr, struct op_code_struct * op);
-unsigned long read_insn_microblaze (bfd_vma memaddr, 
-		      struct disassemble_info *info,
-		      struct op_code_struct **opr);
 
 static char *
 get_field (long instr, long mask, unsigned short low)
@@ -664,8 +660,8 @@ get_field_unsigned_imm (long instr)
   }
 */
 
-char *
-get_field_special (long instr, struct op_code_struct * op)
+static char *
+get_field_special(long instr, const struct op_code_struct *op)
 {
    char tmpstr[25];
    char spr[6];
@@ -729,14 +725,14 @@ get_field_special (long instr, struct op_code_struct * op)
    return(strdup(tmpstr));
 }
 
-unsigned long
+static unsigned long
 read_insn_microblaze (bfd_vma memaddr, 
 		      struct disassemble_info *info,
-		      struct op_code_struct **opr)
+		      const struct op_code_struct **opr)
 {
   unsigned char       ibytes[4];
   int                 status;
-  struct op_code_struct * op;
+  const struct op_code_struct *op;
   unsigned long inst;
 
   status = info->read_memory_func (memaddr, ibytes, 4, info);
@@ -772,7 +768,7 @@ print_insn_microblaze (bfd_vma memaddr, struct disassemble_info * info)
   fprintf_function    fprintf_func = info->fprintf_func;
   void *              stream = info->stream;
   unsigned long       inst, prev_inst;
-  struct op_code_struct * op, *pop;
+  const struct op_code_struct *op, *pop;
   int                 immval = 0;
   bfd_boolean         immfound = FALSE;
   static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
-- 
2.7.4
