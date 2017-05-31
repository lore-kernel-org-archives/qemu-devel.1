Received: from eggs.gnu.org ([2001:4830:134:3::10]:36802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mk-0007Zy-S0
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mj-0003ex-PS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:46 -0400
Received: from mail-lf0-x230.google.com ([2a00:1450:4010:c07::230]:34477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mj-0003ee-IZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:45 -0400
Received: by mail-lf0-x230.google.com with SMTP id 99so8621455lfu.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:45 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:21 +0300
Message-Id: <a8617d8c2fa888a37ecb7db6635fb44964505277.1496234767.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/15] linux-user: fix ssetmask() system call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>

From: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

Fix the ssetmask() system call by removing the invocation of sigorset().

The ssetmask() system call should replace the old signal mask
with the new and return the old mask. It shouldn't combine
the old and the new mask with sigorset(). Fetching the old
mask for sigorset() is also no longer needed.

The problem was detected after running LTP test group syscalls
for the MIPS EL 32 R2 architecture where the test ssetmask01 failed
with exit code 1. The test passes now that the ssetmask() system call
is fixed.

Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 909dde6de6..93bc6f679e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8621,17 +8621,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_ssetmask /* not on alpha */
     case TARGET_NR_ssetmask:
         {
-            sigset_t set, oset, cur_set;
+            sigset_t set, oset;
             abi_ulong target_set = arg1;
-            /* We only have one word of the new mask so we must read
-             * the rest of it with do_sigprocmask() and OR in this word.
-             * We are guaranteed that a do_sigprocmask() that only queries
-             * the signal mask will not fail.
-             */
-            ret = do_sigprocmask(0, NULL, &cur_set);
-            assert(!ret);
             target_to_host_old_sigset(&set, &target_set);
-            sigorset(&set, &set, &cur_set);
             ret = do_sigprocmask(SIG_SETMASK, &set, &oset);
             if (!ret) {
                 host_to_target_old_sigset(&target_set, &oset);
-- 
2.11.0
