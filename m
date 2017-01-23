Received: from eggs.gnu.org ([2001:4830:134:3::10]:46483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCl-0007bD-61
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCj-0004ra-FW
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:17:59 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCj-0004rT-98
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:17:57 -0500
Received: by mail-qt0-x242.google.com with SMTP id n13so14085977qtc.0
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:17:57 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:24 -0800
Message-Id: <20170123021748.13170-3-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 02/26] linux-user: Support stack-grows-up in
 elfload.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

HPPA is a (the) stack-grows-up target, and supporting that requires
rearranging how we compute addresses while laying out the initial
program stack.  In addition, hppa32 requires 64-byte stack alignment
so parameterize that as well.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/elfload.c | 235 +++++++++++++++++++++++++++++++++++++--------------
 linux-user/main.c    |  13 +--
 linux-user/qemu.h    |   3 +
 3 files changed, 180 insertions(+), 71 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 547053c..5cea39d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1231,6 +1231,14 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_HWCAP 0
 #endif
 
+#ifndef STACK_GROWS_DOWN
+#define STACK_GROWS_DOWN 1
+#endif
+
+#ifndef STACK_ALIGNMENT
+#define STACK_ALIGNMENT 16
+#endif
+
 #ifdef TARGET_ABI32
 #undef ELF_CLASS
 #define ELF_CLASS ELFCLASS32
@@ -1374,45 +1382,78 @@ static abi_ulong copy_elf_strings(int argc, char **argv, char *scratch,
                                   abi_ulong p, abi_ulong stack_limit)
 {
     char *tmp;
-    int len, offset;
+    int len, i;
     abi_ulong top = p;
 
     if (!p) {
         return 0;       /* bullet-proofing */
     }
 
-    offset = ((p - 1) % TARGET_PAGE_SIZE) + 1;
+    if (STACK_GROWS_DOWN) {
+        int offset = ((p - 1) % TARGET_PAGE_SIZE) + 1;
+        for (i = argc - 1; i >= 0; --i) {
+            tmp = argv[i];
+            if (!tmp) {
+                fprintf(stderr, "VFS: argc is wrong");
+                exit(-1);
+            }
+            len = strlen(tmp) + 1;
+            tmp += len;
 
-    while (argc-- > 0) {
-        tmp = argv[argc];
-        if (!tmp) {
-            fprintf(stderr, "VFS: argc is wrong");
-            exit(-1);
+            if (len > (p - stack_limit)) {
+                return 0;
+            }
+            while (len) {
+                int bytes_to_copy = (len > offset) ? offset : len;
+                tmp -= bytes_to_copy;
+                p -= bytes_to_copy;
+                offset -= bytes_to_copy;
+                len -= bytes_to_copy;
+
+                memcpy_fromfs(scratch + offset, tmp, bytes_to_copy);
+
+                if (offset == 0) {
+                    memcpy_to_target(p, scratch, top - p);
+                    top = p;
+                    offset = TARGET_PAGE_SIZE;
+                }
+            }
         }
-        len = strlen(tmp) + 1;
-        tmp += len;
-
-        if (len > (p - stack_limit)) {
-            return 0;
+        if (p != top) {
+            memcpy_to_target(p, scratch + offset, top - p);
         }
-        while (len) {
-            int bytes_to_copy = (len > offset) ? offset : len;
-            tmp -= bytes_to_copy;
-            p -= bytes_to_copy;
-            offset -= bytes_to_copy;
-            len -= bytes_to_copy;
-
-            memcpy_fromfs(scratch + offset, tmp, bytes_to_copy);
-
-            if (offset == 0) {
-                memcpy_to_target(p, scratch, top - p);
-                top = p;
-                offset = TARGET_PAGE_SIZE;
+    } else {
+        int remaining = TARGET_PAGE_SIZE - (p % TARGET_PAGE_SIZE);
+        for (i = 0; i < argc; ++i) {
+            tmp = argv[i];
+            if (!tmp) {
+                fprintf(stderr, "VFS: argc is wrong");
+                exit(-1);
+            }
+            len = strlen(tmp) + 1;
+            if (len > (stack_limit - p)) {
+                return 0;
+            }
+            while (len) {
+                int bytes_to_copy = (len > remaining) ? remaining : len;
+
+                memcpy_fromfs(scratch + (p - top), tmp, bytes_to_copy);
+
+                tmp += bytes_to_copy;
+                remaining -= bytes_to_copy;
+                p += bytes_to_copy;
+                len -= bytes_to_copy;
+
+                if (remaining == 0) {
+                    memcpy_to_target(top, scratch, p - top);
+                    top = p;
+                    remaining = TARGET_PAGE_SIZE;
+                }
             }
         }
-    }
-    if (offset) {
-        memcpy_to_target(p, scratch + offset, top - p);
+        if (p != top) {
+            memcpy_to_target(top, scratch, p - top);
+        }
     }
 
     return p;
@@ -1447,11 +1488,15 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
     }
 
     /* We reserve one extra page at the top of the stack as guard.  */
-    target_mprotect(error, guard, PROT_NONE);
-
-    info->stack_limit = error + guard;
-
-    return info->stack_limit + size - sizeof(void *);
+    if (STACK_GROWS_DOWN) {
+        target_mprotect(error, guard, PROT_NONE);
+        info->stack_limit = error + guard;
+        return info->stack_limit + size - sizeof(void *);
+    } else {
+        target_mprotect(error + size, guard, PROT_NONE);
+        info->stack_limit = error + size;
+        return error;
+    }
 }
 
 /* Map and zero the bss.  We need to explicitly zero any fractional pages
@@ -1529,7 +1574,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
                                    struct image_info *interp_info)
 {
     abi_ulong sp;
-    abi_ulong sp_auxv;
+    abi_ulong u_argc, u_argv, u_envp, u_auxv;
     int size;
     int i;
     abi_ulong u_rand_bytes;
@@ -1558,10 +1603,25 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     k_platform = ELF_PLATFORM;
     if (k_platform) {
         size_t len = strlen(k_platform) + 1;
-        sp -= (len + n - 1) & ~(n - 1);
-        u_platform = sp;
-        /* FIXME - check return value of memcpy_to_target() for failure */
-        memcpy_to_target(sp, k_platform, len);
+        if (STACK_GROWS_DOWN) {
+            sp -= (len + n - 1) & ~(n - 1);
+            u_platform = sp;
+            /* FIXME - check return value of memcpy_to_target() for failure */
+            memcpy_to_target(sp, k_platform, len);
+        } else {
+            memcpy_to_target(sp, k_platform, len);
+            u_platform = sp;
+            sp += len + 1;
+        }
+    }
+
+    /* Provide 16 byte alignment for the PRNG, and basic alignment for
+     * the argv and envp pointers.
+     */
+    if (STACK_GROWS_DOWN) {
+        sp = QEMU_ALIGN_DOWN(sp, 16);
+    } else {
+        sp = QEMU_ALIGN_UP(sp, 16);
     }
 
     /*
@@ -1571,15 +1631,17 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     for (i = 0; i < 16; i++) {
         k_rand_bytes[i] = rand();
     }
-    sp -= 16;
-    u_rand_bytes = sp;
-    /* FIXME - check return value of memcpy_to_target() for failure */
-    memcpy_to_target(sp, k_rand_bytes, 16);
+    if (STACK_GROWS_DOWN) {
+        sp -= 16;
+        u_rand_bytes = sp;
+        /* FIXME - check return value of memcpy_to_target() for failure */
+        memcpy_to_target(sp, k_rand_bytes, 16);
+    } else {
+        memcpy_to_target(sp, k_rand_bytes, 16);
+        u_rand_bytes = sp;
+        sp += 16;
+    }
 
-    /*
-     * Force 16 byte _final_ alignment here for generality.
-     */
-    sp = sp &~ (abi_ulong)15;
     size = (DLINFO_ITEMS + 1) * 2;
     if (k_platform)
         size += 2;
@@ -1592,20 +1654,31 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     size += envc + argc + 2;
     size += 1;  /* argc itself */
     size *= n;
-    if (size & 15)
-        sp -= 16 - (size & 15);
+
+    /* Allocate space and finalize stack alignment for entry now.  */
+    if (STACK_GROWS_DOWN) {
+        u_argc = QEMU_ALIGN_DOWN(sp - size, STACK_ALIGNMENT);
+        sp = u_argc;
+    } else {
+        u_argc = sp;
+        sp = QEMU_ALIGN_UP(sp + size, STACK_ALIGNMENT);
+    }
+
+    u_argv = u_argc + n;
+    u_envp = u_argv + (argc + 1) * n;
+    u_auxv = u_envp + (envc + 1) * n;
+    info->saved_auxv = u_auxv;
+    info->arg_start = u_argv;
+    info->arg_end = u_argv + argc * n;
 
     /* This is correct because Linux defines
      * elf_addr_t as Elf32_Off / Elf64_Off
      */
 #define NEW_AUX_ENT(id, val) do {               \
-        sp -= n; put_user_ual(val, sp);         \
-        sp -= n; put_user_ual(id, sp);          \
+        put_user_ual(id, u_auxv);  u_auxv += n; \
+        put_user_ual(val, u_auxv); u_auxv += n; \
     } while(0)
 
-    sp_auxv = sp;
-    NEW_AUX_ENT (AT_NULL, 0);
-
     /* There must be exactly DLINFO_ITEMS entries here.  */
     NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
@@ -1626,8 +1699,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
 #endif
 
-    if (k_platform)
+    if (u_platform) {
         NEW_AUX_ENT(AT_PLATFORM, u_platform);
+    }
 #ifdef ARCH_DLINFO
     /*
      * ARCH_DLINFO must come last so platform specific code can enforce
@@ -1635,14 +1709,29 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
      */
     ARCH_DLINFO;
 #endif
+    NEW_AUX_ENT (AT_NULL, 0);
 #undef NEW_AUX_ENT
 
-    info->saved_auxv = sp;
-    info->auxv_len = sp_auxv - sp;
+    info->auxv_len = u_argv - info->saved_auxv;
+
+    put_user_ual(argc, u_argc);
+
+    p = info->arg_strings;
+    for (i = 0; i < argc; ++i) {
+        put_user_ual(p, u_argv);
+        u_argv += n;
+        p += target_strlen(p) + 1;
+    }
+    put_user_ual(0, u_argv);
+
+    p = info->env_strings;
+    for (i = 0; i < envc; ++i) {
+        put_user_ual(p, u_envp);
+        u_envp += n;
+        p += target_strlen(p) + 1;
+    }
+    put_user_ual(0, u_envp);
 
-    sp = loader_build_argptr(envc, argc, sp, p, 0);
-    /* Check the right amount of stack was allocated for auxvec, envp & argv. */
-    assert(sp_auxv - sp == size);
     return sp;
 }
 
@@ -2213,12 +2302,28 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     bprm->p = setup_arg_pages(bprm, info);
 
     scratch = g_new0(char, TARGET_PAGE_SIZE);
-    bprm->p = copy_elf_strings(1, &bprm->filename, scratch,
-                               bprm->p, info->stack_limit);
-    bprm->p = copy_elf_strings(bprm->envc, bprm->envp, scratch,
-                               bprm->p, info->stack_limit);
-    bprm->p = copy_elf_strings(bprm->argc, bprm->argv, scratch,
-                               bprm->p, info->stack_limit);
+    if (STACK_GROWS_DOWN) {
+        bprm->p = copy_elf_strings(1, &bprm->filename, scratch,
+                                   bprm->p, info->stack_limit);
+        info->file_string = bprm->p;
+        bprm->p = copy_elf_strings(bprm->envc, bprm->envp, scratch,
+                                   bprm->p, info->stack_limit);
+        info->env_strings = bprm->p;
+        bprm->p = copy_elf_strings(bprm->argc, bprm->argv, scratch,
+                                   bprm->p, info->stack_limit);
+        info->arg_strings = bprm->p;
+    } else {
+        info->arg_strings = bprm->p;
+        bprm->p = copy_elf_strings(bprm->argc, bprm->argv, scratch,
+                                   bprm->p, info->stack_limit);
+        info->env_strings = bprm->p;
+        bprm->p = copy_elf_strings(bprm->envc, bprm->envp, scratch,
+                                   bprm->p, info->stack_limit);
+        info->file_string = bprm->p;
+        bprm->p = copy_elf_strings(1, &bprm->filename, scratch,
+                                   bprm->p, info->stack_limit);
+    }
+
     g_free(scratch);
 
     if (!bprm->p) {
diff --git a/linux-user/main.c b/linux-user/main.c
index 94a636f..aae29bd 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4179,15 +4179,16 @@ int main(int argc, char **argv, char **envp)
 
         qemu_log("start_brk   0x" TARGET_ABI_FMT_lx "\n", info->start_brk);
         qemu_log("end_code    0x" TARGET_ABI_FMT_lx "\n", info->end_code);
-        qemu_log("start_code  0x" TARGET_ABI_FMT_lx "\n",
-                 info->start_code);
-        qemu_log("start_data  0x" TARGET_ABI_FMT_lx "\n",
-                 info->start_data);
+        qemu_log("start_code  0x" TARGET_ABI_FMT_lx "\n", info->start_code);
+        qemu_log("start_data  0x" TARGET_ABI_FMT_lx "\n", info->start_data);
         qemu_log("end_data    0x" TARGET_ABI_FMT_lx "\n", info->end_data);
-        qemu_log("start_stack 0x" TARGET_ABI_FMT_lx "\n",
-                 info->start_stack);
+        qemu_log("start_stack 0x" TARGET_ABI_FMT_lx "\n", info->start_stack);
         qemu_log("brk         0x" TARGET_ABI_FMT_lx "\n", info->brk);
         qemu_log("entry       0x" TARGET_ABI_FMT_lx "\n", info->entry);
+        qemu_log("argv_start  0x" TARGET_ABI_FMT_lx "\n", info->arg_start);
+        qemu_log("env_start   0x" TARGET_ABI_FMT_lx "\n",
+                 info->arg_end + (abi_ulong)sizeof(abi_ulong));
+        qemu_log("auxv_start  0x" TARGET_ABI_FMT_lx "\n", info->saved_auxv);
     }
 
     target_set_brk(info->brk);
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index da73a01..4edd7d0 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -48,6 +48,9 @@ struct image_info {
         abi_ulong       auxv_len;
         abi_ulong       arg_start;
         abi_ulong       arg_end;
+        abi_ulong       arg_strings;
+        abi_ulong       env_strings;
+        abi_ulong       file_string;
         uint32_t        elf_flags;
 	int		personality;
 #ifdef CONFIG_USE_FDPIC
-- 
2.9.3
