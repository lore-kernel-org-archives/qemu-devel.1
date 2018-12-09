Received: from eggs.gnu.org ([2001:4830:134:3::10]:33413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uF-0001SX-9y
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uD-0005sr-7b
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uC-00051I-Rx
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:21 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:29 -0500
Message-Id: <20181209193749.12277-19-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 18/38] *-user: plugin syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 bsd-user/syscall.c   | 9 +++++++++
 linux-user/syscall.c | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index b7818af450..4993f81b2b 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -323,6 +323,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
     gemu_log("freebsd syscall %d\n", num);
 #endif
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
+    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+                             arg8);
     if(do_strace)
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
 
@@ -404,6 +406,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
     if (do_strace)
         print_freebsd_syscall_ret(num, ret);
     trace_guest_user_syscall_ret(cpu, num, ret);
+    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
     return ret;
  efault:
     ret = -TARGET_EFAULT;
@@ -422,6 +425,8 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
     gemu_log("netbsd syscall %d\n", num);
 #endif
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
+    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0,
+                             0);
     if(do_strace)
         print_netbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
 
@@ -480,6 +485,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
     if (do_strace)
         print_netbsd_syscall_ret(num, ret);
     trace_guest_user_syscall_ret(cpu, num, ret);
+    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
     return ret;
  efault:
     ret = -TARGET_EFAULT;
@@ -498,6 +504,8 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
     gemu_log("openbsd syscall %d\n", num);
 #endif
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
+    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0,
+                             0);
     if(do_strace)
         print_openbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
 
@@ -556,6 +564,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
     if (do_strace)
         print_openbsd_syscall_ret(num, ret);
     trace_guest_user_syscall_ret(cpu, num, ret);
+    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
     return ret;
  efault:
     ret = -TARGET_EFAULT;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 15b03e17b9..9f6457768c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11422,6 +11422,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
+    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+                             arg8);
 
     if (unlikely(do_strace)) {
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -11434,5 +11436,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     }
 
     trace_guest_user_syscall_ret(cpu, num, ret);
+    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
     return ret;
 }
-- 
2.17.1
