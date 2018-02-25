Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eq0aS-0002Dy-DP
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eq0aO-0002lc-Gx
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:48 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:40195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eq0aO-0002jP-3H
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Feb 2018 18:59:26 +0100
Message-Id: <20180225175928.13101-3-laurent@vivier.eu>
In-Reply-To: <20180225175928.13101-1-laurent@vivier.eu>
References: <20180225175928.13101-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 2/4] linux-user: introduce functions to detect
 CPU type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, YunQiang Su <syq@debian.org>, Laurent Vivier <laurent@vivier.eu>

From: YunQiang Su <syq@debian.org>

Add a function to return ELF e_flags and use it
to select the CPU model.

Signed-off-by: YunQiang Su <syq@debian.org>
[lv: split the patch and some cleanup in get_elf_eflags()]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180220173307.25125-3-laurent@vivier.eu>
---
 linux-user/elfload.c | 35 +++++++++++++++++++++++++++++++++++
 linux-user/main.c    | 20 ++++++++++----------
 linux-user/qemu.h    |  1 +
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8bb9a2c3e8..0208022445 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2396,6 +2396,41 @@ give_up:
     g_free(syms);
 }
 
+uint32_t get_elf_eflags(int fd)
+{
+    struct elfhdr ehdr;
+    off_t offset;
+    int ret;
+
+    /* Read ELF header */
+    offset = lseek(fd, 0, SEEK_SET);
+    if (offset == (off_t) -1) {
+        return 0;
+    }
+    ret = read(fd, &ehdr, sizeof(ehdr));
+    if (ret < sizeof(ehdr)) {
+        return 0;
+    }
+    offset = lseek(fd, offset, SEEK_SET);
+    if (offset == (off_t) -1) {
+        return 0;
+    }
+
+    /* Check ELF signature */
+    if (!elf_check_ident(&ehdr)) {
+        return 0;
+    }
+
+    /* check header */
+    bswap_ehdr(&ehdr);
+    if (!elf_check_ehdr(&ehdr)) {
+        return 0;
+    }
+
+    /* return architecture id */
+    return ehdr.e_flags;
+}
+
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 {
     struct image_info interp_info;
diff --git a/linux-user/main.c b/linux-user/main.c
index 079b98235b..bbeb78fb89 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4344,8 +4344,17 @@ int main(int argc, char **argv, char **envp)
 
     init_qemu_uname_release();
 
+    execfd = qemu_getauxval(AT_EXECFD);
+    if (execfd == 0) {
+        execfd = open(filename, O_RDONLY);
+        if (execfd < 0) {
+            printf("Error while loading %s: %s\n", filename, strerror(errno));
+            _exit(EXIT_FAILURE);
+        }
+    }
+
     if (cpu_model == NULL) {
-        cpu_model = cpu_get_model(0);
+        cpu_model = cpu_get_model(get_elf_eflags(execfd));
     }
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
@@ -4438,15 +4447,6 @@ int main(int argc, char **argv, char **envp)
     cpu->opaque = ts;
     task_settid(ts);
 
-    execfd = qemu_getauxval(AT_EXECFD);
-    if (execfd == 0) {
-        execfd = open(filename, O_RDONLY);
-        if (execfd < 0) {
-            printf("Error while loading %s: %s\n", filename, strerror(errno));
-            _exit(EXIT_FAILURE);
-        }
-    }
-
     ret = loader_exec(execfd, filename, target_argv, target_environ, regs,
         info, &bprm);
     if (ret != 0) {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index bc4bf35036..f4b4ca72ad 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -186,6 +186,7 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
              struct target_pt_regs * regs, struct image_info *infop,
              struct linux_binprm *);
 
+uint32_t get_elf_eflags(int fd);
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct linux_binprm *bprm, struct image_info *info);
 
-- 
2.14.3
