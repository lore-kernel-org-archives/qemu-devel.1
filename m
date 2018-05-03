Received: from eggs.gnu.org ([2001:4830:134:3::10]:54821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwo-0004jG-OF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwk-00056a-Oe
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:30 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fELwk-00054P-CN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:26 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  3 May 2018 23:39:00 +0200
Message-Id: <20180503213903.30335-4-laurent@vivier.eu>
In-Reply-To: <20180503213903.30335-1-laurent@vivier.eu>
References: <20180503213903.30335-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/6] linux-user: ARM-FDPIC: Add support of FDPIC
 for ARM.
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

Add FDPIC info into image_info structure since interpreter info is on
stack and needs to be saved to be accessed later on.

Co-Authored-By:  Mickaël Guêné <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180430080404.7323-4-christophe.lyon@st.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 29 +++++++++++++++++++++++++++++
 linux-user/qemu.h    |  9 +++++++++
 2 files changed, 38 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 76d7718b3d..36d52194bc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -78,6 +78,11 @@ enum {
  */
 #define personality(pers)       (pers & PER_MASK)
 
+int info_is_fdpic(struct image_info *info)
+{
+    return info->personality == PER_LINUX_FDPIC;
+}
+
 /* this flag is uneffective under linux too, should be deleted */
 #ifndef MAP_DENYWRITE
 #define MAP_DENYWRITE 0
@@ -287,6 +292,25 @@ static inline void init_thread(struct target_pt_regs *regs,
     /* For uClinux PIC binaries.  */
     /* XXX: Linux does this only on ARM with no MMU (do we care ?) */
     regs->uregs[10] = infop->start_data;
+
+    /* Support ARM FDPIC.  */
+    if (info_is_fdpic(infop)) {
+        /* As described in the ABI document, r7 points to the loadmap info
+         * prepared by the kernel. If an interpreter is needed, r8 points
+         * to the interpreter loadmap and r9 points to the interpreter
+         * PT_DYNAMIC info. If no interpreter is needed, r8 is zero, and
+         * r9 points to the main program PT_DYNAMIC info.
+         */
+        regs->uregs[7] = infop->loadmap_addr;
+        if (infop->interpreter_loadmap_addr) {
+            /* Executable is dynamically loaded.  */
+            regs->uregs[8] = infop->interpreter_loadmap_addr;
+            regs->uregs[9] = infop->interpreter_pt_dynamic_addr;
+        } else {
+            regs->uregs[8] = 0;
+            regs->uregs[9] = infop->pt_dynamic_addr;
+        }
+    }
 }
 
 #define ELF_NREG    18
@@ -1745,6 +1769,11 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
         if (interp_info) {
             interp_info->other_info = info;
             sp = loader_build_fdpic_loadmap(interp_info, sp);
+            info->interpreter_loadmap_addr = interp_info->loadmap_addr;
+            info->interpreter_pt_dynamic_addr = interp_info->pt_dynamic_addr;
+        } else {
+            info->interpreter_loadmap_addr = 0;
+            info->interpreter_pt_dynamic_addr = 0;
         }
     }
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index da3b51724c..c55c8e294b 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -57,6 +57,8 @@ struct image_info {
         uint16_t        nsegs;
         void           *loadsegs;
         abi_ulong       pt_dynamic_addr;
+        abi_ulong       interpreter_loadmap_addr;
+        abi_ulong       interpreter_pt_dynamic_addr;
         struct image_info *other_info;
 };
 
@@ -183,6 +185,13 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
              struct target_pt_regs * regs, struct image_info *infop,
              struct linux_binprm *);
 
+/* Returns true if the image uses the FDPIC ABI. If this is the case,
+ * we have to provide some information (loadmap, pt_dynamic_info) such
+ * that the program can be relocated adequately. This is also useful
+ * when handling signals.
+ */
+int info_is_fdpic(struct image_info *info);
+
 uint32_t get_elf_eflags(int fd);
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct linux_binprm *bprm, struct image_info *info);
-- 
2.14.3
