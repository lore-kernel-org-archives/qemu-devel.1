Received: from eggs.gnu.org ([2001:4830:134:3::10]:39397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1eRGQB-0007h8-Rx
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1eRGQ8-0005NS-NU
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:50:55 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:38562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wzssyqa@gmail.com>) id 1eRGQ8-0005Mc-1W
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:50:52 -0500
Received: by mail-pg0-x230.google.com with SMTP id f12so10433289pgo.5
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 03:50:51 -0800 (PST)
Sender: YunQiang Su <wzssyqa@gmail.com>
From: YunQiang Su <syq@debian.org>
Date: Tue, 19 Dec 2017 19:50:41 +0800
Message-Id: <20171219115041.6611-1-syq@debian.org>
Subject: [Qemu-devel] [PATCH] linux-user: MIPS set cpu to r6 CPU if binary
 is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>

MIPS r6 is not just simple super set for pre-R6,
it also drops some instruction and even changes encoding for some.
But r6 binary has the same header for binfmt_misc.

So here we need to detect the version of binaries and set
cpu_model for it.
---
 include/elf.h        |  4 ++++
 linux-user/elfload.c | 36 ++++++++++++++++++++++++++++++++++++
 linux-user/main.c    | 15 +++++++++++++++
 linux-user/qemu.h    |  1 +
 4 files changed, 56 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index e8a515ce3d..f2104809b1 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -40,6 +40,10 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ARCH_5		0x40000000	/* -mips5 code.  */
 #define EF_MIPS_ARCH_32		0x50000000	/* MIPS32 code.  */
 #define EF_MIPS_ARCH_64		0x60000000	/* MIPS64 code.  */
+#define EF_MIPS_ARCH_32R2       0x70000000      /* MIPS32r2 code.  */
+#define EF_MIPS_ARCH_64R2       0x80000000      /* MIPS64r2 code.  */
+#define EF_MIPS_ARCH_32R6       0x90000000      /* MIPS32r6 code.  */
+#define EF_MIPS_ARCH_64R6       0xa0000000      /* MIPS64r6 code.  */
 
 /* The ABI of a file. */
 #define EF_MIPS_ABI_O32		0x00001000	/* O32 ABI.  */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20f3d8c2c3..f9b8e028ca 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2224,6 +2224,42 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     exit(-1);
 }
 
+uint32_t get_elf_eflags(const char *filename)
+{
+    int fd, retval;
+    char bprm_buf[BPRM_BUF_SIZE];
+
+    fd = open(path(filename), O_RDONLY);
+    if (fd < 0) {
+        return 0;
+    }
+    retval = read(fd, bprm_buf, BPRM_BUF_SIZE);
+    close(fd);
+    if (retval < 0) {
+        return 0;
+    }
+    if (retval < BPRM_BUF_SIZE) {
+        memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
+    }
+
+    if (bprm_buf[0] != 0x7f
+             || bprm_buf[1] != 'E'
+             || bprm_buf[2] != 'L'
+             || bprm_buf[3] != 'F') {
+        return 0;
+    }
+
+    struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
+    if (!elf_check_ident(ehdr)) {
+        return 0;
+    }
+    bswap_ehdr(ehdr);
+    if (!elf_check_ehdr(ehdr)) {
+        return 0;
+    }
+    return ehdr->e_flags;
+}
+
 static int symfind(const void *s0, const void *s1)
 {
     target_ulong addr = *(target_ulong *)s0;
diff --git a/linux-user/main.c b/linux-user/main.c
index 7c0bffeff6..b4626e5aa0 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4287,6 +4287,21 @@ int main(int argc, char **argv, char **envp)
     }
     trace_init_file(trace_file);
 
+#if defined(TARGET_MIPS)
+    if (cpu_model == NULL) {
+        uint32_t eflags = get_elf_eflags(filename);
+#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64)
+        if ((eflags & EF_MIPS_ARCH_64R6) != 0) {
+            cpu_model = "I6400";
+        }
+#else
+        if ((eflags & EF_MIPS_ARCH_32R6) != 0) {
+            cpu_model = "mips32r6-generic";
+        }
+#endif
+    }
+#endif
+
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4edd7d0c08..cf09110bf9 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -190,6 +190,7 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
 
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct linux_binprm *bprm, struct image_info *info);
+uint32_t get_elf_eflags(const char *filename);
 
 abi_long memcpy_to_target(abi_ulong dest, const void *src,
                           unsigned long len);
-- 
2.15.1
