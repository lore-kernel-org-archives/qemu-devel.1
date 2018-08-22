Received: from eggs.gnu.org ([2001:4830:134:3::10]:36340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjV-0005kB-CB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHjP-0001el-Hn
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:14:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsHjO-0001bI-Iu
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:14:43 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 22 Aug 2018 03:14:15 +0200
Message-Id: <20180822011417.11608-6-laurent@vivier.eu>
In-Reply-To: <20180822011417.11608-1-laurent@vivier.eu>
References: <20180822011417.11608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/7] linux-user: Propagate goto
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180818190118.12911-6-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 19e98cc0e5..6e63f15ca1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11976,7 +11976,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
           return 0;
       }
 #else
-      goto unimplemented_nowarn;
+      return -TARGET_ENOSYS;
 #endif
 #endif
 #ifdef TARGET_NR_get_thread_area
@@ -11989,12 +11989,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12079,7 +12079,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          * holding a mutex that is shared with another process via
          * shared memory).
          */
-        goto unimplemented_nowarn;
+        return -TARGET_ENOSYS;
 #endif
 
 #if defined(TARGET_NR_utimensat)
@@ -12739,9 +12739,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
