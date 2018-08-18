Received: from eggs.gnu.org ([2001:4830:134:3::10]:55194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Ta-0005FX-Vx
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Ta-00079l-9i
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:30 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:45553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Ta-000797-49
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:30 -0400
Received: by mail-pg1-x52f.google.com with SMTP id f1-v6so4943677pgq.12
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:07 -0700
Message-Id: <20180818190118.12911-6-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 05/16] linux-user: Propagate goto
 unimplemented_nowarn to return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 23c3cd5ddd..812fb27fa1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11870,7 +11870,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
           return 0;
       }
 #else
-      goto unimplemented_nowarn;
+      return -TARGET_ENOSYS;
 #endif
 #endif
 #ifdef TARGET_NR_get_thread_area
@@ -11883,12 +11883,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return ts->tp_value;
         }
 #else
-        goto unimplemented_nowarn;
+        return -TARGET_ENOSYS;
 #endif
 #endif
 #ifdef TARGET_NR_getdomainname
     case TARGET_NR_getdomainname:
-        goto unimplemented_nowarn;
+        return -TARGET_ENOSYS;
 #endif
 
 #ifdef TARGET_NR_clock_settime
@@ -11973,7 +11973,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          * holding a mutex that is shared with another process via
          * shared memory).
          */
-        goto unimplemented_nowarn;
+        return -TARGET_ENOSYS;
 #endif
 
 #if defined(TARGET_NR_utimensat)
@@ -12633,9 +12633,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     default:
     unimplemented:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
-#if defined(TARGET_NR_setxattr) || defined(TARGET_NR_get_thread_area) || defined(TARGET_NR_getdomainname) || defined(TARGET_NR_set_robust_list)
-    unimplemented_nowarn:
-#endif
         return -TARGET_ENOSYS;
     }
 fail:
-- 
2.17.1
