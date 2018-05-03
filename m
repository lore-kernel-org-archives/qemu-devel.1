Received: from eggs.gnu.org ([2001:4830:134:3::10]:54861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwq-0004jQ-97
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwm-00059B-48
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fELwl-00056q-Qf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:28 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  3 May 2018 23:38:59 +0200
Message-Id: <20180503213903.30335-3-laurent@vivier.eu>
In-Reply-To: <20180503213903.30335-1-laurent@vivier.eu>
References: <20180503213903.30335-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/6] linux-user: ARM-FDPIC: Identify ARM FDPIC
 binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Christophe Lyon <christophe.lyon@st.com>

From: Christophe Lyon <christophe.lyon@st.com>

Define an ARM-specific version of elf_is_fdpic:
FDPIC ELF objects are identified with e_ident[EI_OSABI] ==
ELFOSABI_ARM_FDPIC.

Co-Authored-By: Mickaël Guêné <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180430080404.7323-3-christophe.lyon@st.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/elf.h        | 1 +
 linux-user/elfload.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index c0dc9bb5fd..934dbbd6b3 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1483,6 +1483,7 @@ typedef struct elf64_shdr {
 #define ELFOSABI_TRU64          10      /* Compaq TRU64 UNIX.  */
 #define ELFOSABI_MODESTO        11      /* Novell Modesto.  */
 #define ELFOSABI_OPENBSD        12      /* OpenBSD.  */
+#define ELFOSABI_ARM_FDPIC      65      /* ARM FDPIC */
 #define ELFOSABI_ARM            97      /* ARM */
 #define ELFOSABI_STANDALONE     255     /* Standalone (embedded) application */
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bbe93b03b6..76d7718b3d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1681,11 +1681,18 @@ static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
     }
 }
 
+#ifdef TARGET_ARM
+static int elf_is_fdpic(struct elfhdr *exec)
+{
+    return exec->e_ident[EI_OSABI] == ELFOSABI_ARM_FDPIC;
+}
+#else
 /* Default implementation, always false.  */
 static int elf_is_fdpic(struct elfhdr *exec)
 {
     return 0;
 }
+#endif
 
 static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong sp)
 {
-- 
2.14.3
