Received: from eggs.gnu.org ([2001:4830:134:3::10]:46659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD1-0007p7-Fe
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD0-0004va-7G
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:15 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUD0-0004vU-2d
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:14 -0500
Received: by mail-qt0-x242.google.com with SMTP id a29so14087407qtb.1
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:14 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:38 -0800
Message-Id: <20170123021748.13170-17-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 16/26] linux-user: Add HPPA startup and main loop
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

Including support for the atomic memory op syscalls.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/elfload.c |  24 +++++++
 linux-user/main.c    | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5cea39d..51794bb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1215,6 +1215,30 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #endif /* TARGET_TILEGX */
 
+#ifdef TARGET_HPPA
+
+#define ELF_START_MMAP  0x80000000
+#define ELF_CLASS       ELFCLASS32
+#define ELF_ARCH        EM_PARISC
+#define ELF_PLATFORM    "PARISC"
+#define STACK_GROWS_DOWN 0
+#define STACK_ALIGNMENT  64
+
+static inline void init_thread(struct target_pt_regs *regs,
+                               struct image_info *infop)
+{
+    regs->iaoq[0] = infop->entry;
+    regs->iaoq[1] = infop->entry + 4;
+    regs->gr[23] = 0;
+    regs->gr[24] = infop->arg_start;
+    regs->gr[25] = (infop->arg_end - infop->arg_start) / sizeof(abi_ulong);
+    /* The top-of-stack contains a linkage buffer.  */
+    regs->gr[30] = infop->start_stack + 64;
+    regs->gr[31] = infop->entry;
+}
+
+#endif /* TARGET_HPPA */
+
 #ifndef ELF_PLATFORM
 #define ELF_PLATFORM (NULL)
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index aae29bd..db4eb68 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3512,6 +3512,169 @@ void cpu_loop(CPUTLGState *env)
 
 #endif
 
+#ifdef TARGET_HPPA
+
+static abi_ulong hppa_lws(CPUHPPAState *env)
+{
+    uint32_t which = env->gr[20];
+    abi_ulong addr = env->gr[26];
+    abi_ulong old = env->gr[25];
+    abi_ulong new = env->gr[24];
+    abi_ulong size, ret;
+
+    switch (which) {
+    default:
+        return -TARGET_ENOSYS;
+
+    case 0: /* elf32 atomic 32bit cmpxchg */
+        if ((addr & 3) || !access_ok(VERIFY_WRITE, addr, 4)) {
+            return -TARGET_EFAULT;
+        }
+        old = tswap32(old);
+        new = tswap32(new);
+        ret = atomic_cmpxchg((uint32_t *)g2h(addr), old, new);
+        ret = tswap32(ret);
+        break;
+
+    case 2: /* elf32 atomic "new" cmpxchg */
+        size = env->gr[23];
+        if (size >= 4) {
+            return -TARGET_ENOSYS;
+        }
+        if (((addr | old | new) & ((1 << size) - 1))
+            || !access_ok(VERIFY_WRITE, addr, 1 << size)
+            || !access_ok(VERIFY_READ, old, 1 << size)
+            || !access_ok(VERIFY_READ, new, 1 << size)) {
+            return -TARGET_EFAULT;
+        }
+        /* Note that below we use host-endian loads so that the cmpxchg
+           can be host-endian as well.  */
+        switch (size) {
+        case 0:
+            old = *(uint8_t *)g2h(old);
+            new = *(uint8_t *)g2h(new);
+            ret = atomic_cmpxchg((uint8_t *)g2h(addr), old, new);
+            ret = ret != old;
+            break;
+        case 1:
+            old = *(uint16_t *)g2h(old);
+            new = *(uint16_t *)g2h(new);
+            ret = atomic_cmpxchg((uint16_t *)g2h(addr), old, new);
+            ret = ret != old;
+            break;
+        case 2:
+            old = *(uint32_t *)g2h(old);
+            new = *(uint32_t *)g2h(new);
+            ret = atomic_cmpxchg((uint32_t *)g2h(addr), old, new);
+            ret = ret != old;
+            break;
+        case 3:
+            {
+                uint64_t o64, n64, r64;
+                o64 = *(uint64_t *)g2h(old);
+                n64 = *(uint64_t *)g2h(new);
+#ifdef CONFIG_ATOMIC64
+                r64 = atomic_cmpxchg__nocheck((uint64_t *)g2h(addr), o64, n64);
+                ret = r64 != o64;
+#else
+                start_exclusive();
+                r64 = *(uint64_t *)g2h(addr);
+                ret = 1;
+                if (r64 == o64) {
+                    *(uint64_t *)g2h(addr) = n64;
+                    ret = 0;
+                }
+                end_exclusive();
+#endif
+            }
+            break;
+        }
+        break;
+    }
+
+    env->gr[28] = ret;
+    return 0;
+}
+
+void cpu_loop(CPUHPPAState *env)
+{
+    CPUState *cs = CPU(hppa_env_get_cpu(env));
+    target_siginfo_t info;
+    abi_ulong ret;
+    int trapnr;
+
+    while (1) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch (trapnr) {
+        case EXCP_SYSCALL:
+            ret = do_syscall(env, env->gr[20],
+                             env->gr[26], env->gr[25],
+                             env->gr[24], env->gr[23],
+                             env->gr[22], env->gr[21], 0, 0);
+            switch (ret) {
+            default:
+                env->gr[28] = ret;
+                /* We arrived here by faking the gateway page.  Return.  */
+                env->iaoq_f = env->gr[31];
+                env->iaoq_b = env->gr[31] + 4;
+                break;
+            case -TARGET_ERESTARTSYS:
+            case -TARGET_QEMU_ESIGRETURN:
+                break;
+            }
+            break;
+        case EXCP_SYSCALL_LWS:
+            env->gr[21] = hppa_lws(env);
+            /* We arrived here by faking the gateway page.  Return.  */
+            env->iaoq_f = env->gr[31];
+            env->iaoq_b = env->gr[31] + 4;
+            break;
+        case EXCP_SIGSEGV:
+            info.si_signo = TARGET_SIGSEGV;
+            info.si_errno = 0;
+            info.si_code = TARGET_SEGV_ACCERR;
+            info._sifields._sigfault._addr = env->ior;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_SIGILL:
+            info.si_signo = TARGET_SIGILL;
+            info.si_errno = 0;
+            info.si_code = TARGET_ILL_ILLOPN;
+            info._sifields._sigfault._addr = env->iaoq_f;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_SIGFPE:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = 0;
+            info._sifields._sigfault._addr = env->iaoq_f;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_DEBUG:
+            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
+            if (trapnr) {
+                info.si_signo = trapnr;
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                queue_signal(env, trapnr, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        process_pending_signals(env);
+    }
+}
+
+#endif /* TARGET_HPPA */
+
 THREAD CPUState *thread_cpu;
 
 bool qemu_cpu_is_self(CPUState *cpu)
@@ -4539,6 +4702,15 @@ int main(int argc, char **argv, char **envp)
         }
         env->pc = regs->pc;
     }
+#elif defined(TARGET_HPPA)
+    {
+        int i;
+        for (i = 1; i < 32; i++) {
+            env->gr[i] = regs->gr[i];
+        }
+        env->iaoq_f = regs->iaoq[0];
+        env->iaoq_b = regs->iaoq[1];
+    }
 #else
 #error unsupported target CPU
 #endif
-- 
2.9.3
