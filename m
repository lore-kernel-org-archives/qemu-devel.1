Received: from eggs.gnu.org ([2001:4830:134:3::10]:36851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mr-0007gq-RQ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mp-0003g4-AC
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:53 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:34512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mp-0003fp-3Y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:51 -0400
Received: by mail-lf0-x229.google.com with SMTP id 99so8623444lfu.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:51 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:25 +0300
Message-Id: <243e0fe5506d6b830e01d8da727ff7f20fa38502.1496234767.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/15] linux-user: add rt_tgsigqueueinfo() strace
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

This commit improves strace support for syscall rt_tgsigqueueinfo().

Prior to this commit, typical strace output used to look like this:
7775 rt_tgsigqueueinfo(7775,7775,50,1996483164,0,0) = 0

After this commit, it looks like this:
7775 rt_tgsigqueueinfo(7775,7775,50,0x76ffea5c) = 0

Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index f6f76a5bd4..779cda1a5e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1915,6 +1915,21 @@ print_rt_sigqueueinfo(const struct syscallname *name,
 }
 #endif
 
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
index 373d43689a..a91e33f7e5 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1167,7 +1167,7 @@
 { TARGET_NR_rt_sigtimedwait, "rt_sigtimedwait" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_rt_tgsigqueueinfo
-{ TARGET_NR_rt_tgsigqueueinfo, "rt_tgsigqueueinfo" , NULL, NULL, NULL },
+{ TARGET_NR_rt_tgsigqueueinfo, "rt_tgsigqueueinfo" , NULL, print_rt_tgsigqueueinfo, NULL },
 #endif
 #ifdef TARGET_NR_sched_getaffinity
 { TARGET_NR_sched_getaffinity, "sched_getaffinity" , NULL, NULL, NULL },
-- 
2.11.0
