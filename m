Received: from eggs.gnu.org ([2001:4830:134:3::10]:36873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mu-0007jO-BQ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Ms-0003gk-UQ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:56 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:33237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Ms-0003gO-IE
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:54 -0400
Received: by mail-lf0-x22a.google.com with SMTP id m18so8650218lfj.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:54 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:27 +0300
Message-Id: <ba9fcea1cb6d80536f780760d870416fe5b85863.1496234767.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/15] linux-user: add strace support for uinfo
 structure of rt_sigqueueinfo() and rt_tgsigqueueinfo()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>

From: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

This commit adds support for printing the content of the target_siginfo_t
structure in a similar way to how it is printed by the host strace. The
pointer to this structure is sent as the last argument of the
rt_sigqueueinfo() and rt_tgsigqueueinfo() system calls.
For this purpose, print_siginfo() is used and the get_target_siginfo()
function is implemented in order to get the information obtained from
the pointer into the form that print_siginfo() expects.

The get_target_siginfo() function is based on
host_to_target_siginfo_noswap() in linux-user mode, but here both
arguments are pointers to target_siginfo_t, so instead of converting
the information to siginfo_t it just extracts and copies it to a
target_siginfo_t structure.

Prior to this commit, typical strace output used to look like this:
8307 rt_sigqueueinfo(8307,50,0x00000040007ff6b0) = 0

After this commit, it looks like this:
8307 rt_sigqueueinfo(8307,50,{si_signo=50, si_code=SI_QUEUE, si_pid=8307,
si_uid=1000, si_sigval=17716762128}) = 0

Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/strace.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5fbe067fd5..d821d165ff 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -188,6 +188,93 @@ static void print_si_code(int arg)
     gemu_log("%s", codename);
 }
 
+static void get_target_siginfo(target_siginfo_t *tinfo,
+                                const target_siginfo_t *info)
+{
+    abi_ulong sival_ptr;
+
+    int sig;
+    int si_errno;
+    int si_code;
+    int si_type;
+
+    __get_user(sig, &info->si_signo);
+    __get_user(si_errno, &tinfo->si_errno);
+    __get_user(si_code, &info->si_code);
+
+    tinfo->si_signo = sig;
+    tinfo->si_errno = si_errno;
+    tinfo->si_code = si_code;
+
+    /* Ensure we don't leak random junk to the guest later */
+    memset(tinfo->_sifields._pad, 0, sizeof(tinfo->_sifields._pad));
+
+    /* This is awkward, because we have to use a combination of
+     * the si_code and si_signo to figure out which of the union's
+     * members are valid. (Within the host kernel it is always possible
+     * to tell, but the kernel carefully avoids giving userspace the
+     * high 16 bits of si_code, so we don't have the information to
+     * do this the easy way...) We therefore make our best guess,
+     * bearing in mind that a guest can spoof most of the si_codes
+     * via rt_sigqueueinfo() if it likes.
+     *
+     * Once we have made our guess, we record it in the top 16 bits of
+     * the si_code, so that print_siginfo() later can use it.
+     * print_siginfo() will strip these top bits out before printing
+     * the si_code.
+     */
+
+    switch (si_code) {
+    case SI_USER:
+    case SI_TKILL:
+    case SI_KERNEL:
+        /* Sent via kill(), tkill() or tgkill(), or direct from the kernel.
+         * These are the only unspoofable si_code values.
+         */
+        __get_user(tinfo->_sifields._kill._pid, &info->_sifields._kill._pid);
+        __get_user(tinfo->_sifields._kill._uid, &info->_sifields._kill._uid);
+        si_type = QEMU_SI_KILL;
+        break;
+    default:
+        /* Everything else is spoofable. Make best guess based on signal */
+        switch (sig) {
+        case TARGET_SIGCHLD:
+            __get_user(tinfo->_sifields._sigchld._pid,
+                       &info->_sifields._sigchld._pid);
+            __get_user(tinfo->_sifields._sigchld._uid,
+                       &info->_sifields._sigchld._uid);
+            __get_user(tinfo->_sifields._sigchld._status,
+                       &info->_sifields._sigchld._status);
+            __get_user(tinfo->_sifields._sigchld._utime,
+                       &info->_sifields._sigchld._utime);
+            __get_user(tinfo->_sifields._sigchld._stime,
+                       &info->_sifields._sigchld._stime);
+            si_type = QEMU_SI_CHLD;
+            break;
+        case TARGET_SIGIO:
+            __get_user(tinfo->_sifields._sigpoll._band,
+                       &info->_sifields._sigpoll._band);
+            __get_user(tinfo->_sifields._sigpoll._fd,
+                       &info->_sifields._sigpoll._fd);
+            si_type = QEMU_SI_POLL;
+            break;
+        default:
+            /* Assume a sigqueue()/mq_notify()/rt_sigqueueinfo() source. */
+            __get_user(tinfo->_sifields._rt._pid, &info->_sifields._rt._pid);
+            __get_user(tinfo->_sifields._rt._uid, &info->_sifields._rt._uid);
+            /* XXX: potential problem if 64 bit */
+            __get_user(sival_ptr, &info->_sifields._rt._sigval.sival_ptr);
+            tinfo->_sifields._rt._sigval.sival_ptr = sival_ptr;
+
+            si_type = QEMU_SI_RT;
+            break;
+        }
+        break;
+    }
+
+    tinfo->si_code = deposit32(si_code, 16, 16, si_type);
+}
+
 static void print_siginfo(const target_siginfo_t *tinfo)
 {
     /* Print a target_siginfo_t in the format desired for printing
@@ -1907,10 +1994,21 @@ print_rt_sigqueueinfo(const struct syscallname *name,
     abi_long arg0, abi_long arg1, abi_long arg2,
     abi_long arg3, abi_long arg4, abi_long arg5)
 {
+    void *p;
+    target_siginfo_t uinfo;
+
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
     print_signal(arg1, 0);
-    print_pointer(arg2, 1);
+    p = lock_user(VERIFY_READ, arg2, sizeof(target_siginfo_t), 1);
+    if (p) {
+        get_target_siginfo(&uinfo, p);
+        print_siginfo(&uinfo);
+
+        unlock_user(p, arg2, 0);
+    } else {
+        print_pointer(arg2, 1);
+    }
     print_syscall_epilogue(name);
 }
 #endif
@@ -1921,11 +2019,22 @@ print_rt_tgsigqueueinfo(const struct syscallname *name,
     abi_long arg0, abi_long arg1, abi_long arg2,
     abi_long arg3, abi_long arg4, abi_long arg5)
 {
+    void *p;
+    target_siginfo_t uinfo;
+
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
     print_raw_param("%d", arg1, 0);
     print_signal(arg2, 0);
-    print_pointer(arg3, 1);
+    p = lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
+    if (p) {
+        get_target_siginfo(&uinfo, p);
+        print_siginfo(&uinfo);
+
+        unlock_user(p, arg3, 0);
+    } else {
+        print_pointer(arg3, 1);
+    }
     print_syscall_epilogue(name);
 }
 #endif
-- 
2.11.0
