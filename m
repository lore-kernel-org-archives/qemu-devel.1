Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKh-0006hv-Ey
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKf-0000Ny-GQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKc-0008Vr-4x
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:30 -0400
Message-Id: <20181025172057.20414-22-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 21/48] *-user: plugin syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

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
index ae3c0dfef7..a6d17a9f37 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11232,6 +11232,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
+    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+                             arg8);
 
     if (unlikely(do_strace)) {
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -11244,5 +11246,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     }
 
     trace_guest_user_syscall_ret(cpu, num, ret);
+    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
     return ret;
 }
-- 
2.17.1
