Received: from eggs.gnu.org ([2001:4830:134:3::10]:44231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxaao-0005uV-48
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxaW7-0002aD-Hp
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:18:56 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxaW7-0002Zl-91
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:18:55 -0400
Received: by mail-lj1-x242.google.com with SMTP id l15-v6so6744388lji.6
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 09:18:55 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed,  5 Sep 2018 09:18:41 -0700
Message-Id: <20180905161841.10904-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2] linux-user: do setrlimit selectively
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

setrlimit guest calls that affect memory resources
(RLIMIT_{AS,DATA,STACK}) may interfere with QEMU internal memory
management. They may result in QEMU lockup because mprotect call in
page_unprotect would fail with ENOMEM error code, causing infinite loop
of SIGSEGV. E.g. it happens when running libstdc++ testsuite for xtensa
target on x86_64 host.

Don't call host setrlimit for memory-related resources.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- don't limit change to 32-bit guest on 64-bit host case

 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bb42a225eb58..a9cace49dad8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9275,7 +9275,13 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
             rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
             unlock_user_struct(target_rlim, arg2, 0);
-            ret = get_errno(setrlimit(resource, &rlim));
+            if (resource != RLIMIT_AS &&
+                resource != RLIMIT_DATA &&
+                resource != RLIMIT_STACK) {
+                return get_errno(setrlimit(resource, &rlim));
+            } else {
+                return 0;
+            }
         }
         break;
 #endif
-- 
2.11.0
