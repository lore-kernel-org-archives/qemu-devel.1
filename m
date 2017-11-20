Received: from eggs.gnu.org ([2001:4830:134:3::10]:58297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW6-0004xQ-S6
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW5-00087A-Mf
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:10 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtW5-00086U-El
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:09 -0500
Received: by mail-lf0-x242.google.com with SMTP id k66so11727525lfg.3
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:22:09 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:43 +0200
Message-Id: <f516511ea84d8bb3395d6ea95a7c7b80dc2a05e9.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 15/15] linux-user: Fix calculation of auxv length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/elfload.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3b857fbc9c..20f3d8c2c3 100644
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
2.14.2
