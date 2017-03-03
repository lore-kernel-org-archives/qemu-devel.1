Received: from eggs.gnu.org ([2001:4830:134:3::10]:54898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cjlKk-0006y3-Mh
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cjlKg-0001BN-Oi
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:25:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cjlKg-0001AG-Ij
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:25:10 -0500
From: P J P <ppandit@redhat.com>
Date: Fri,  3 Mar 2017 16:55:03 +0530
Message-Id: <20170303112503.32277-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] linux-user: limit number of arguments to execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Limit the number of arguments passed to execve(2) call from
a user program, as large number of them could lead to a bad
guest address error.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 linux-user/syscall.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9be8e95..c545c12 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7766,6 +7766,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
     case TARGET_NR_execve:
         {
+#define ARG_MAX 65535
             char **argp, **envp;
             int argc, envc;
             abi_ulong gp;
@@ -7794,6 +7795,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 envc++;
             }
 
+            if (argc > ARG_MAX || envc > ARG_MAX) {
+                fprintf(stderr,
+                        "argc(%d), envc(%d) exceed %d\n", argc, envc, ARG_MAX);
+                ret = -TARGET_EFAULT;
+                break;
+            }
             argp = alloca((argc + 1) * sizeof(void *));
             envp = alloca((envc + 1) * sizeof(void *));
 
-- 
2.9.3
