Received: from eggs.gnu.org ([2001:4830:134:3::10]:37759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHXZ-0001x9-F0
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHXV-0005rU-Ik
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:04:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46231 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1dAHXV-0005qz-Bl
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:04:01 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Mon, 15 May 2017 16:59:47 +0200
Message-Id: <1494860396-24930-8-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/16] linux-user: add rt_tgsigqueueinfo()
 strace
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

This commit improves strace support for syscall rt_tgsigqueueinfo().

Prior to this commit, typical strace output used to look like this:
7775 rt_tgsigqueueinfo(7775,7775,50,1996483164,0,0) =3D 0

After this commit, it looks like this:
7775 rt_tgsigqueueinfo(7775,7775,50,0x76ffea5c) =3D 0

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index f6f76a5..779cda1 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1915,6 +1915,21 @@ print_rt_sigqueueinfo(const struct syscallname *na=
me,
 }
 #endif
=20
+#ifdef TARGET_NR_rt_tgsigqueueinfo
+static void
+print_rt_tgsigqueueinfo(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_raw_param("%d", arg1, 0);
+    print_signal(arg2, 0);
+    print_pointer(arg3, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_syslog
 static void
 print_syslog_action(abi_ulong arg, int last)
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 373d436..a91e33f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1167,7 +1167,7 @@
 { TARGET_NR_rt_sigtimedwait, "rt_sigtimedwait" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_rt_tgsigqueueinfo
-{ TARGET_NR_rt_tgsigqueueinfo, "rt_tgsigqueueinfo" , NULL, NULL, NULL },
+{ TARGET_NR_rt_tgsigqueueinfo, "rt_tgsigqueueinfo" , NULL, print_rt_tgsi=
gqueueinfo, NULL },
 #endif
 #ifdef TARGET_NR_sched_getaffinity
 { TARGET_NR_sched_getaffinity, "sched_getaffinity" , NULL, NULL, NULL },
--=20
1.9.1
