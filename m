Received: from eggs.gnu.org ([2001:4830:134:3::10]:54645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7zf-0003MM-7S
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7ze-0004Tj-Ct
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:32:11 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:36 +0300
Message-Id: <b929f7e56f505d18bea32b08b57a8b84c6b28f30.1501496350.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/25] syscall: check inotify() and eventfd()
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

linux-user/syscall.c:555:25: warning: Out of bound memory access (accesse=
d memory precedes memory block)
    target_fd_trans[fd] =3D trans;
    ~~~~~~~~~~~~~~~~~~~~^~~~~~~

Reported-by: Clang Static Analyzer
Suggested-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 81f52f7483..dfc1301e63 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11742,7 +11742,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret =3D get_errno(sys_inotify_init());
-        fd_trans_register(ret, &target_inotify_trans);
+        if (ret >=3D 0) {
+            fd_trans_register(ret, &target_inotify_trans);
+        }
         break;
 #endif
 #ifdef CONFIG_INOTIFY1
@@ -11750,7 +11752,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
     case TARGET_NR_inotify_init1:
         ret =3D get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
                                           fcntl_flags_tbl)));
-        fd_trans_register(ret, &target_inotify_trans);
+        if (ret >=3D 0) {
+            fd_trans_register(ret, &target_inotify_trans);
+        }
         break;
 #endif
 #endif
@@ -11916,7 +11920,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
 #if defined(TARGET_NR_eventfd)
     case TARGET_NR_eventfd:
         ret =3D get_errno(eventfd(arg1, 0));
-        fd_trans_register(ret, &target_eventfd_trans);
+        if (ret >=3D 0) {
+            fd_trans_register(ret, &target_eventfd_trans);
+        }
         break;
 #endif
 #if defined(TARGET_NR_eventfd2)
@@ -11930,7 +11936,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
             host_flags |=3D O_CLOEXEC;
         }
         ret =3D get_errno(eventfd(arg1, host_flags));
-        fd_trans_register(ret, &target_eventfd_trans);
+        if (ret >=3D 0) {
+            fd_trans_register(ret, &target_eventfd_trans);
+        }
         break;
     }
 #endif
--=20
2.11.0
