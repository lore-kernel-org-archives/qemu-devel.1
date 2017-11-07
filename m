Received: from eggs.gnu.org ([2001:4830:134:3::10]:51142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC8YK-0005V2-NM
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC8YJ-0004mu-Gv
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:24:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC8YJ-0004mF-9R
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:24:47 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 18:25:18 +0000
Message-Id: <1510079118-3923-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.11] linux-user: Fix calculation of auxv
 length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

In commit 7c4ee5bcc82e643 we changed the order in which we construct
the AUXV, but forgot to adjust the calculation of the length. The
result is that we set info->auxv_len to a bogus and negative value,
and then later on the code in open_self_auxv() gets confused and
ends up presenting the guest with an empty file.

Since we now have to calculate the auxv length up-front as part
of figuring out how much we're going to put on the stack, set
info->auxv_len then; this allows us to assert that we put the
same number of entries into auxv as we pre-calculated, rather
than merely having a comment saying we need to do that.

Fixes: https://bugs.launchpad.net/qemu/+bug/1728116

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3b857fb..20f3d8c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1732,6 +1732,8 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #ifdef ELF_HWCAP2
     size += 2;
 #endif
+    info->auxv_len = size * n;
+
     size += envc + argc + 2;
     size += 1;  /* argc itself */
     size *= n;
@@ -1760,7 +1762,6 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
         put_user_ual(val, u_auxv); u_auxv += n; \
     } while(0)
 
-    /* There must be exactly DLINFO_ITEMS entries here.  */
 #ifdef ARCH_DLINFO
     /*
      * ARCH_DLINFO must come first so platform specific code can enforce
@@ -1768,6 +1769,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
      */
     ARCH_DLINFO;
 #endif
+    /* There must be exactly DLINFO_ITEMS entries here, or the assert
+     * on info->auxv_len will trigger.
+     */
     NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
     NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
@@ -1793,7 +1797,10 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT (AT_NULL, 0);
 #undef NEW_AUX_ENT
 
-    info->auxv_len = u_argv - info->saved_auxv;
+    /* Check that our initial calculation of the auxv length matches how much
+     * we actually put into it.
+     */
+    assert(info->auxv_len == u_auxv - info->saved_auxv);
 
     put_user_ual(argc, u_argc);
 
-- 
2.7.4
