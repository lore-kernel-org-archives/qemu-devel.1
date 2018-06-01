Received: from eggs.gnu.org ([2001:4830:134:3::10]:57320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWd-0005PZ-5a
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWc-0000HT-3u
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:03 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:43316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWb-0000Gg-TQ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:02 -0400
Received: by mail-pf0-x22b.google.com with SMTP id j20-v6so12076532pff.10
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:22 -0700
Message-Id: <20180601073050.8054-6-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/33] linux-user: Propagate goto
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8ea2099001..f7b7051c1c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12081,7 +12081,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
           return 0;
       }
 #else
-      goto unimplemented_nowarn;
+      return -TARGET_ENOSYS;
 #endif
 #endif
 #ifdef TARGET_NR_get_thread_area
@@ -12094,12 +12094,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12184,7 +12184,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          * holding a mutex that is shared with another process via
          * shared memory).
          */
-        goto unimplemented_nowarn;
+        return -TARGET_ENOSYS;
 #endif
 
 #if defined(TARGET_NR_utimensat)
@@ -12886,9 +12886,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     default:
     unimplemented:
         gemu_log("qemu: Unsupported syscall: %d\n", num);
-#if defined(TARGET_NR_setxattr) || defined(TARGET_NR_get_thread_area) || defined(TARGET_NR_getdomainname) || defined(TARGET_NR_set_robust_list)
-    unimplemented_nowarn:
-#endif
         return -TARGET_ENOSYS;
     }
 fail:
-- 
2.17.0
