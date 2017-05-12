Received: from eggs.gnu.org ([2001:4830:134:3::10]:50027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LK-00043M-ET
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LI-0006Sj-CU
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44636 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LI-0006EF-5g
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:40 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:12 +0200
Message-Id: <1494586944-7253-5-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/16] linux-user: fix mismatch of
 lock/unlock_user() invocations in rt_sigqueinfo() syscall
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

Change the unlock_user() argument from arg1 to arg3 to match with
lock_user(), since arg3 contains the pointer to the siginfo_t structure.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index abba3d8..ff03e1a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8839,7 +8839,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
                 goto efault;
             }
             target_to_host_siginfo(&uinfo, p);
-            unlock_user(p, arg1, 0);
+            unlock_user(p, arg3, 0);
             ret =3D get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
         }
         break;
--=20
1.9.1
