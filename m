Received: from eggs.gnu.org ([2001:4830:134:3::10]:49976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LJ-00042U-Ak
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LF-0006PZ-B7
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44634 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LF-0006EA-3n
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:37 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:11 +0200
Message-Id: <1494586944-7253-4-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/16] linux-user: fix ssetmask() system call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: Milos.Stojanovic@rt-rk.com

Fix the ssetmask() system call by removing the invocation of sigorset().

The ssetmask() system call should replace the old signal mask
with the new and return the old mask. It shouldn't combine
the old and the new mask with sigorset(). Fetching the old
mask for sigorset() is also no longer needed.

The problem was detected after running LTP test group syscalls
for the MIPS EL 32 R2 architecture where the test ssetmask01 failed
with exit code 1. The test passes now that the ssetmask() system call
is fixed.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/syscall.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cec8428..abba3d8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8592,17 +8592,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_lo=
ng arg1,
 #ifdef TARGET_NR_ssetmask /* not on alpha */
     case TARGET_NR_ssetmask:
         {
-            sigset_t set, oset, cur_set;
+            sigset_t set, oset;
             abi_ulong target_set =3D arg1;
-            /* We only have one word of the new mask so we must read
-             * the rest of it with do_sigprocmask() and OR in this word.
-             * We are guaranteed that a do_sigprocmask() that only queri=
es
-             * the signal mask will not fail.
-             */
-            ret =3D do_sigprocmask(0, NULL, &cur_set);
-            assert(!ret);
             target_to_host_old_sigset(&set, &target_set);
-            sigorset(&set, &set, &cur_set);
             ret =3D do_sigprocmask(SIG_SETMASK, &set, &oset);
             if (!ret) {
                 host_to_target_old_sigset(&target_set, &oset);
--=20
1.9.1
