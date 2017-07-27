Received: from eggs.gnu.org ([2001:4830:134:3::10]:54931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlj-0005lg-96
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYli-0008BI-FH
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:19 -0300
Message-Id: <20170727024224.22900-15-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 14/20] syscall: check inotify() and
 eventfd() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

linux-user/syscall.c:555:25: warning: Out of bound memory access (accessed memory precedes memory block)
    target_fd_trans[fd] = trans;
    ~~~~~~~~~~~~~~~~~~~~^~~~~~~

Reported-by: Clang Static Analyzer
Suggested-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/syscall.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 81f52f7483..dfc1301e63 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11742,7 +11742,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
-        fd_trans_register(ret, &target_inotify_trans);
+        if (ret >= 0) {
+            fd_trans_register(ret, &target_inotify_trans);
+        }
         break;
 #endif
 #ifdef CONFIG_INOTIFY1
@@ -11750,7 +11752,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_inotify_init1:
         ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
                                           fcntl_flags_tbl)));
-        fd_trans_register(ret, &target_inotify_trans);
+        if (ret >= 0) {
+            fd_trans_register(ret, &target_inotify_trans);
+        }
         break;
 #endif
 #endif
@@ -11916,7 +11920,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_eventfd)
     case TARGET_NR_eventfd:
         ret = get_errno(eventfd(arg1, 0));
-        fd_trans_register(ret, &target_eventfd_trans);
+        if (ret >= 0) {
+            fd_trans_register(ret, &target_eventfd_trans);
+        }
         break;
 #endif
 #if defined(TARGET_NR_eventfd2)
@@ -11930,7 +11936,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             host_flags |= O_CLOEXEC;
         }
         ret = get_errno(eventfd(arg1, host_flags));
-        fd_trans_register(ret, &target_eventfd_trans);
+        if (ret >= 0) {
+            fd_trans_register(ret, &target_eventfd_trans);
+        }
         break;
     }
 #endif
-- 
2.13.3
