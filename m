Received: from eggs.gnu.org ([2001:4830:134:3::10]:36730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Me-0007U5-Cz
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Md-0003dC-CP
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:40 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:34434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Md-0003cx-4W
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:39 -0400
Received: by mail-lf0-x233.google.com with SMTP id 99so8619103lfu.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:39 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:17 +0300
Message-Id: <b936cb50aacf3cccf5d2363095c6547eb709583a.1496234766.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 05/15] linux-user: allocate heap memory for
 execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Arguments passed to execve(2) call from user program could
be large, allocating stack memory for them via alloca(3) call
would lead to bad behaviour. Use 'g_new0' to allocate memory
for such arguments.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 32aba195c5..c8f6efc89c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7985,8 +7985,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 envc++;
             }
 
-            argp = alloca((argc + 1) * sizeof(void *));
-            envp = alloca((envc + 1) * sizeof(void *));
+            argp = g_new0(char *, argc + 1);
+            envp = g_new0(char *, envc + 1);
 
             for (gp = guest_argp, q = argp; gp;
                   gp += sizeof(abi_ulong), q++) {
@@ -8047,6 +8047,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     break;
                 unlock_user(*q, addr, 0);
             }
+
+            g_free(argp);
+            g_free(envp);
         }
         break;
     case TARGET_NR_chdir:
-- 
2.11.0
