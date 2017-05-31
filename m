Received: from eggs.gnu.org ([2001:4830:134:3::10]:36782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mj-0007Yv-L8
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mi-0003ea-G0
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:45 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:35966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mi-0003eK-8l
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:44 -0400
Received: by mail-lf0-x22c.google.com with SMTP id h4so8617308lfj.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:44 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:20 +0300
Message-Id: <5162264e438cf5efcb101bc8030e5f76feb58635.1496234766.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/15] linux-user: add tkill(),
 tgkill() and rt_sigqueueinfo() strace
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

Improve strace support for syscall tkill(), tgkill() and rt_sigqueueinfo()
by implementing print functions that match arguments types of the system
calls and add them to the corresponding starce.list entry.

tkill:
Prior to this commit, typical strace output used to look like this:
4886 tkill(4886,50,0,4832615904,0,-9151031864016699136) = 0
After this commit, it looks like this:
4886 tkill(4886,50) = 0

tgkill:
Prior to this commit, typical strace output used to look like this:
4890 tgkill(4890,4890,50,8,4832630528,4832615904) = 0
After this commit, it looks like this:
4890 tgkill(4890,4890,50) = 0

rt_sigqueueinfo:
Prior to this commit, typical strace output used to look like this:
8307 rt_sigqueueinfo(8307,50,1996483164,0,0,50) = 0
After this commit, it looks like this:
8307 rt_sigqueueinfo(8307,50,0x00000040007ff6b0) = 0

Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/strace.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  6 +++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 8fb1b6e252..f6f76a5bd4 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1901,6 +1901,20 @@ print_rt_sigprocmask(const struct syscallname *name,
 }
 #endif
 
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
index 6e33788a17..373d43689a 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1155,7 +1155,7 @@
 { TARGET_NR_rt_sigprocmask, "rt_sigprocmask" , NULL, print_rt_sigprocmask, NULL },
 #endif
 #ifdef TARGET_NR_rt_sigqueueinfo
-{ TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, NULL, NULL },
+{ TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, print_rt_sigqueueinfo, NULL },
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
-- 
2.11.0
