Received: from eggs.gnu.org ([2001:4830:134:3::10]:41510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPe-0008AM-7y
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPb-0005i4-6h
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:23 -0300
Message-Id: <20171006235023.11952-29-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 28/88] disas: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: fixed const cast, squashed M68K + NiosII + SPARC, renamed subject "disas"]
---
 disas/m68k.c  | 3 +--
 disas/nios2.c | 3 +--
 disas/sparc.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index 61b689ef3e..31cf6ea5f9 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1886,8 +1886,7 @@ print_insn_m68k (bfd_vma memaddr, disassemble_info *info)
 
       /* Then create a sorted table of pointers
 	 that point into the unsorted table.  */
-      opc_pointer[0] = malloc (sizeof (struct m68k_opcode *)
-                               * m68k_numopcodes);
+      opc_pointer[0] = g_new(const struct m68k_opcode *, m68k_numopcodes);
       opcodes[0] = opc_pointer[0];
 
       for (i = 1; i < 16; i++)
diff --git a/disas/nios2.c b/disas/nios2.c
index b342936d21..9e6e1e6a1f 100644
--- a/disas/nios2.c
+++ b/disas/nios2.c
@@ -2625,8 +2625,7 @@ nios2_init_opcode_hash (nios2_disassembler_state *state)
 
 	if (bucket)
 	  {
-	    new_hash =
-	      (nios2_opcode_hash *) malloc (sizeof (nios2_opcode_hash));
+	    new_hash = g_new(nios2_opcode_hash, 1);
 	    if (new_hash == NULL)
 	      {
 		fprintf (stderr,
diff --git a/disas/sparc.c b/disas/sparc.c
index f120f4e86d..6d0adab8a7 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2684,8 +2684,7 @@ print_insn_sparc (bfd_vma memaddr, disassemble_info *info)
       current_arch_mask = compute_arch_mask (info->mach);
 
       if (!opcodes_initialized)
-        sorted_opcodes =
-          malloc (sparc_num_opcodes * sizeof (sparc_opcode *));
+        sorted_opcodes = g_new(const sparc_opcode *, sparc_num_opcodes);
       /* Reset the sorted table so we can resort it.  */
       for (i = 0; i < sparc_num_opcodes; ++i)
         sorted_opcodes[i] = &sparc_opcodes[i];
-- 
2.14.2
