Received: from eggs.gnu.org ([2001:4830:134:3::10]:38531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNn-0005Aj-Ev
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNm-0000pe-MG
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:23 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:36718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOWNm-0000p5-Gv
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:22 -0400
Received: by mail-pf0-x231.google.com with SMTP id w129-v6so11499025pfd.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 15:49:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 May 2018 15:49:10 -0700
Message-Id: <20180531224911.23725-6-richard.henderson@linaro.org>
In-Reply-To: <20180531224911.23725-1-richard.henderson@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/6] linux-user: Check is_hostfd in mmap
 syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b98125829b..d7513d5dac 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9605,11 +9605,17 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             v5 = tswapal(v[4]);
             v6 = tswapal(v[5]);
             unlock_user(v, arg1, 0);
+            if (is_hostfd(v5)) {
+                goto ebadf;
+            }
             ret = get_errno(target_mmap(v1, v2, v3,
                                         target_to_host_bitmask(v4, mmap_flags_tbl),
                                         v5, v6));
         }
 #else
+        if (is_hostfd(arg5)) {
+            goto ebadf;
+        }
         ret = get_errno(target_mmap(arg1, arg2, arg3,
                                     target_to_host_bitmask(arg4, mmap_flags_tbl),
                                     arg5,
@@ -9622,6 +9628,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifndef MMAP_SHIFT
 #define MMAP_SHIFT 12
 #endif
+        if (is_hostfd(arg5)) {
+            goto ebadf;
+        }
         ret = get_errno(target_mmap(arg1, arg2, arg3,
                                     target_to_host_bitmask(arg4, mmap_flags_tbl),
                                     arg5,
-- 
2.17.0
