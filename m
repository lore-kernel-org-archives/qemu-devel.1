Received: from eggs.gnu.org ([2001:4830:134:3::10]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckmtk-0001bb-MW
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckmtj-000092-KB
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ckmtj-00008b-E9
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:35 -0500
From: P J P <ppandit@redhat.com>
Date: Mon,  6 Mar 2017 12:47:21 +0530
Message-Id: <20170306071721.26708-3-ppandit@redhat.com>
In-Reply-To: <20170306071721.26708-1-ppandit@redhat.com>
References: <20170306071721.26708-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] linux-user: allocate heap memory for
 execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Arguments passed to execve(2) call from user program could
be large, allocating stack memory for them via alloca(3) call
would lead to bad behaviour. Use 'g_malloc0' to allocate memory
for such arguments.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 linux-user/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Update per: replace alloca() with g_malloc0()
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00750.html

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 86a4a9c..404fb0b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7800,8 +7800,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 ret = -TARGET_E2BIG;
                 break;
             }
-            argp = alloca((argc + 1) * sizeof(void *));
-            envp = alloca((envc + 1) * sizeof(void *));
+            argp = g_malloc0((argc + 1) * sizeof(void *));
+            envp = g_malloc0((envc + 1) * sizeof(void *));
 
             for (gp = guest_argp, q = argp; gp;
                   gp += sizeof(abi_ulong), q++) {
@@ -7862,6 +7862,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
2.9.3
