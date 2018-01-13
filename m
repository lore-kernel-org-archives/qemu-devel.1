Received: from eggs.gnu.org ([2001:4830:134:3::10]:47225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eaN7R-0000UJ-9L
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eaN7O-0007KU-6C
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:13 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eaN7N-0007Io-RE
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:10 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 13 Jan 2018 15:48:45 +0100
Message-Id: <20180113144847.8403-2-laurent@vivier.eu>
In-Reply-To: <20180113144847.8403-1-laurent@vivier.eu>
References: <20180113144847.8403-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/3] linux-user: introduce functions to detect
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
Cc: YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aaron Sierra <asierra@xes-inc.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>

From: YunQiang Su <syq@debian.org>

Move CPU type name selection to a function,
and add a function to return ELF e_flags.

[lv: splitted the patch and some cleanup in get_elf_eflags()]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    YunQiang Su, please add your Signed-off-by that was
    missing in your original patch.

 linux-user/elfload.c |  37 +++++++++++++++++++
 linux-user/main.c    | 101 +++++++++++++++++++++++++++------------------------
 linux-user/qemu.h    |   1 +
 3 files changed, 91 insertions(+), 48 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20f3d8c2c3..03244f5e97 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2376,6 +2376,43 @@ give_up:
     g_free(syms);
 }
 
+int get_elf_eflags(int fd, uint32_t *eflags)
+{
+    struct elfhdr ehdr;
+    off_t offset;
+    int ret;
+
+    /* Read ELF header */
+    offset = lseek(fd, 0, SEEK_SET);
+    if (offset == (off_t) -1) {
+        return -1;
+    }
+    ret = read(fd, &ehdr, sizeof(ehdr));
+    if (ret < sizeof(ehdr)) {
+        return -1;
+    }
+    offset = lseek(fd, offset, SEEK_SET);
+    if (offset == (off_t) -1) {
+        return -1;
+    }
+
+    /* Check ELF signature */
+    if (!elf_check_ident(&ehdr)) {
+        return -1;
+    }
+
+    /* check header */
+    bswap_ehdr(&ehdr);
+    if (!elf_check_ehdr(&ehdr)) {
+        return -1;
+    }
+
+    /* return architecture id */
+    *eflags = ehdr.e_flags;
+
+    return 0;
+}
+
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 {
     struct image_info interp_info;
diff --git a/linux-user/main.c b/linux-user/main.c
index 450eb3ce65..9ce90ae634 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4254,6 +4254,49 @@ static int parse_args(int argc, char **argv)
     return optind;
 }
 
+static const char *get_cpu_model(int fd)
+{
+#if defined(TARGET_I386)
+#ifdef TARGET_X86_64
+    return "qemu64";
+#else
+    return "qemu32";
+#endif
+#elif defined(TARGET_ARM)
+    return "any";
+#elif defined(TARGET_UNICORE32)
+    return "any";
+#elif defined(TARGET_M68K)
+    return "any";
+#elif defined(TARGET_SPARC)
+#ifdef TARGET_SPARC64
+    return "TI UltraSparc II";
+#else
+    return "Fujitsu MB86904";
+#endif
+#elif defined(TARGET_MIPS)
+#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64)
+    return "5KEf";
+#else
+    return "24Kf";
+#endif
+#elif defined TARGET_OPENRISC
+    return "or1200";
+#elif defined(TARGET_PPC)
+# ifdef TARGET_PPC64
+    return "POWER8";
+# else
+    return "750";
+# endif
+#elif defined TARGET_SH4
+    return "sh7785";
+#elif defined TARGET_S390X
+    return "qemu";
+#else
+    return "any";
+#endif
+}
+
 int main(int argc, char **argv, char **envp)
 {
     struct target_pt_regs regs1, *regs = &regs1;
@@ -4318,46 +4361,17 @@ int main(int argc, char **argv, char **envp)
 
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
-#if defined(TARGET_I386)
-#ifdef TARGET_X86_64
-        cpu_model = "qemu64";
-#else
-        cpu_model = "qemu32";
-#endif
-#elif defined(TARGET_ARM)
-        cpu_model = "any";
-#elif defined(TARGET_UNICORE32)
-        cpu_model = "any";
-#elif defined(TARGET_M68K)
-        cpu_model = "any";
-#elif defined(TARGET_SPARC)
-#ifdef TARGET_SPARC64
-        cpu_model = "TI UltraSparc II";
-#else
-        cpu_model = "Fujitsu MB86904";
-#endif
-#elif defined(TARGET_MIPS)
-#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64)
-        cpu_model = "5KEf";
-#else
-        cpu_model = "24Kf";
-#endif
-#elif defined TARGET_OPENRISC
-        cpu_model = "or1200";
-#elif defined(TARGET_PPC)
-# ifdef TARGET_PPC64
-        cpu_model = "POWER8";
-# else
-        cpu_model = "750";
-# endif
-#elif defined TARGET_SH4
-        cpu_model = "sh7785";
-#elif defined TARGET_S390X
-        cpu_model = "qemu";
-#else
-        cpu_model = "any";
-#endif
+        cpu_model = get_cpu_model(execfd);
     }
     tcg_exec_init(0);
     /* NOTE: we need to init the CPU at this stage to get
@@ -4450,15 +4464,6 @@ int main(int argc, char **argv, char **envp)
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
index 4edd7d0c08..c2a701163c 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -188,6 +188,7 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
              struct target_pt_regs * regs, struct image_info *infop,
              struct linux_binprm *);
 
+int get_elf_eflags(int fd, uint32_t *eflags);
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct linux_binprm *bprm, struct image_info *info);
 
-- 
2.14.3
