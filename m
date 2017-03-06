Received: from eggs.gnu.org ([2001:4830:134:3::10]:49676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckmth-0001Zq-QQ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckmtg-00006w-OS
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ckmtg-00006S-Hw
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:32 -0500
From: P J P <ppandit@redhat.com>
Date: Mon,  6 Mar 2017 12:47:20 +0530
Message-Id: <20170306071721.26708-2-ppandit@redhat.com>
In-Reply-To: <20170306071721.26708-1-ppandit@redhat.com>
References: <20170306071721.26708-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] linux-user: limit number of arguments
 to execve
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

Limit the number of arguments passed to execve(2) call from
a user program, as large number of them could lead to a bad
guest address error.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

Update per: use gemu_log() to report error
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00750.html

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9be8e95..86a4a9c 100644
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
@@ -7794,6 +7795,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 envc++;
             }
 
+            if (argc > ARG_MAX || envc > ARG_MAX) {
+                gemu_log("argc(%d), envc(%d) exceed %d\n", argc, envc, ARG_MAX);
+                ret = -TARGET_E2BIG;
+                break;
+            }
             argp = alloca((argc + 1) * sizeof(void *));
             envp = alloca((envc + 1) * sizeof(void *));
 
-- 
2.9.3
