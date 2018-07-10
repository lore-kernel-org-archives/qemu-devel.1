Received: from eggs.gnu.org ([2001:4830:134:3::10]:48355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcm4W-0006ZX-WC
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcm4S-0005ll-Iv
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:25 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fcm4S-0005k5-6y
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:24:20 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 10 Jul 2018 08:23:51 +0200
Message-Id: <20180710062352.9843-3-laurent@vivier.eu>
In-Reply-To: <20180710062352.9843-1-laurent@vivier.eu>
References: <20180710062352.9843-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/3] linux-user: Do not report "syscall not
 implemented" by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This can still be reported using the "-d unimp" command line option.

Code change produced with:

  git ls-files linux-user | \
  xargs sed -i -E 's/fprintf\(stderr,\s?(".*not implemented\\n")\);/qemu_log_mask(LOG_UNIMP, \1);/g'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180706155127.7483-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/cris/signal.c       | 4 ++--
 linux-user/microblaze/signal.c | 4 ++--
 linux-user/nios2/signal.c      | 2 +-
 linux-user/sparc/signal.c      | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/linux-user/cris/signal.c b/linux-user/cris/signal.c
index 0b405247cf..1e02194377 100644
--- a/linux-user/cris/signal.c
+++ b/linux-user/cris/signal.c
@@ -146,7 +146,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                      target_sigset_t *set, CPUCRISState *env)
 {
-    fprintf(stderr, "CRIS setup_rt_frame: not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "setup_rt_frame: not implemented\n");
 }
 
 long do_sigreturn(CPUCRISState *env)
@@ -183,6 +183,6 @@ badframe:
 long do_rt_sigreturn(CPUCRISState *env)
 {
     trace_user_do_rt_sigreturn(env, 0);
-    fprintf(stderr, "CRIS do_rt_sigreturn: not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "do_rt_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index 712ee522b2..80950c2181 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -200,7 +200,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPUMBState *env)
 {
-    fprintf(stderr, "Microblaze setup_rt_frame: not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "setup_rt_frame: not implemented\n");
 }
 
 long do_sigreturn(CPUMBState *env)
@@ -240,6 +240,6 @@ badframe:
 long do_rt_sigreturn(CPUMBState *env)
 {
     trace_user_do_rt_sigreturn(env, 0);
-    fprintf(stderr, "Microblaze do_rt_sigreturn: not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "do_rt_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
diff --git a/linux-user/nios2/signal.c b/linux-user/nios2/signal.c
index 4985dc2212..7d535065ed 100644
--- a/linux-user/nios2/signal.c
+++ b/linux-user/nios2/signal.c
@@ -203,7 +203,7 @@ give_sigsegv:
 long do_sigreturn(CPUNios2State *env)
 {
     trace_user_do_sigreturn(env, 0);
-    fprintf(stderr, "do_sigreturn: not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "do_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
 
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 55e9d6f9b2..b4c60aa446 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -278,7 +278,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPUSPARCState *env)
 {
-    fprintf(stderr, "setup_rt_frame: not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "setup_rt_frame: not implemented\n");
 }
 
 long do_sigreturn(CPUSPARCState *env)
@@ -357,7 +357,7 @@ segv_and_exit:
 long do_rt_sigreturn(CPUSPARCState *env)
 {
     trace_user_do_rt_sigreturn(env, 0);
-    fprintf(stderr, "do_rt_sigreturn: not implemented\n");
+    qemu_log_mask(LOG_UNIMP, "do_rt_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
 
-- 
2.17.1
