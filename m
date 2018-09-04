Received: from eggs.gnu.org ([2001:4830:134:3::10]:42746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxIRO-0008Ac-NX
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxIRN-0001MB-UH
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:00:50 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:38652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxIRN-0001Kc-Gx
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:00:49 -0400
Received: by mail-lf1-x143.google.com with SMTP id i7-v6so4158681lfh.5
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 14:00:49 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 14:00:36 -0700
Message-Id: <20180904210036.7317-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] linux-user: do setrlimit selectively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

When running 32-bit guest on 64-bit host setrlimit guest calls that
affect memory resources (RLIMIT_{AS,DATA,STACK}) don't always make sense
as is. They may result in QEMU lockup because mprotect call in
page_unprotect would fail with ENOMEM error code, causing infinite loop
of SIGSEGV. E.g. it happens when running libstdc++ testsuite for xtensa
target on x86_64 host.

Don't call host setrlimit for memory-related resources when running
32-bit guest on 64-bit host.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 850b72a0c760..693a6c8aa7bb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9272,7 +9272,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
             rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
             unlock_user_struct(target_rlim, arg2, 0);
-            return get_errno(setrlimit(resource, &rlim));
+            if (HOST_LONG_BITS <= TARGET_LONG_BITS ||
+                (resource != RLIMIT_DATA &&
+                 resource != RLIMIT_AS &&
+                 resource != RLIMIT_STACK)) {
+                return get_errno(setrlimit(resource, &rlim));
+            } else {
+                return 0;
+            }
         }
 #endif
 #ifdef TARGET_NR_getrlimit
-- 
2.11.0
