Received: from eggs.gnu.org ([2001:4830:134:3::10]:37077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHUt-0008DN-0j
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHUo-0004J8-5G
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:01:19 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45605 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1dAHUn-0004IV-Pw
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:01:14 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Mon, 15 May 2017 16:59:42 +0200
Message-Id: <1494860396-24930-3-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/16] linux-user: add tkill(),
 tgkill() and rt_sigqueueinfo() strace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: laurent@vivier.eu, Miodrag.Dinic@rt-rk.com, Aleksandar.Markovic@rt-rk.com, Petar.Jovanovic@rt-rk.com, yongbok.kim@imgtec.com, Milos.Stojanovic@rt-rk.com

Improve strace support for syscall tkill(), tgkill() and rt_sigqueueinfo(=
)
by implementing print functions that match arguments types of the system
calls and add them to the corresponding starce.list entry.

tkill:
Prior to this commit, typical strace output used to look like this:
4886 tkill(4886,50,0,4832615904,0,-9151031864016699136) =3D 0
After this commit, it looks like this:
4886 tkill(4886,50) =3D 0

tgkill:
Prior to this commit, typical strace output used to look like this:
4890 tgkill(4890,4890,50,8,4832630528,4832615904) =3D 0
After this commit, it looks like this:
4890 tgkill(4890,4890,50) =3D 0

rt_sigqueueinfo:
Prior to this commit, typical strace output used to look like this:
8307 rt_sigqueueinfo(8307,50,1996483164,0,0,50) =3D 0
After this commit, it looks like this:
8307 rt_sigqueueinfo(8307,50,0x00000040007ff6b0) =3D 0

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/strace.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  6 +++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 8fb1b6e..f6f76a5 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1901,6 +1901,20 @@ print_rt_sigprocmask(const struct syscallname *nam=
e,
 }
 #endif
=20
+#ifdef TARGET_NR_rt_sigqueueinfo
+static void
+print_rt_sigqueueinfo(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_signal(arg1, 0);
+    print_pointer(arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_syslog
 static void
 print_syslog_action(abi_ulong arg, int last)
@@ -2415,6 +2429,33 @@ print_kill(const struct syscallname *name,
 }
 #endif
=20
+#ifdef TARGET_NR_tkill
+static void
+print_tkill(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_signal(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_tgkill
+static void
+print_tgkill(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_raw_param("%d", arg1, 0);
+    print_signal(arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 /*
  * An array of all of the syscalls we know about
  */
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 6e33788..373d436 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1155,7 +1155,7 @@
 { TARGET_NR_rt_sigprocmask, "rt_sigprocmask" , NULL, print_rt_sigprocmas=
k, NULL },
 #endif
 #ifdef TARGET_NR_rt_sigqueueinfo
-{ TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, NULL, NULL },
+{ TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, print_rt_sigqueue=
info, NULL },
 #endif
 #ifdef TARGET_NR_rt_sigreturn
 { TARGET_NR_rt_sigreturn, "rt_sigreturn" , NULL, NULL, NULL },
@@ -1498,7 +1498,7 @@
 { TARGET_NR_tee, "tee" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_tgkill
-{ TARGET_NR_tgkill, "tgkill" , NULL, NULL, NULL },
+{ TARGET_NR_tgkill, "tgkill" , NULL, print_tgkill, NULL },
 #endif
 #ifdef TARGET_NR_time
 { TARGET_NR_time, "time" , NULL, NULL, NULL },
@@ -1534,7 +1534,7 @@
 { TARGET_NR_times, "times" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_tkill
-{ TARGET_NR_tkill, "tkill" , NULL, NULL, NULL },
+{ TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
 #ifdef TARGET_NR_truncate
 { TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
--=20
1.9.1
