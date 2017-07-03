Received: from eggs.gnu.org ([2001:4830:134:3::10]:51654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KJ-0000ls-BA
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KI-00081W-8T
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:55 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4KI-000809-2A
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:54 -0400
Received: by mail-wm0-x242.google.com with SMTP id p204so21568144wmg.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:35:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:39 +0200
Message-Id: <1499099693-22903-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/22] tcg: make tcg_allowed global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

From: Yang Zhong <yang.zhong@intel.com>

Change the tcg_enabled() and make sure user build still enable tcg
even x86 softmmu disable tcg.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec-common.c | 2 ++
 accel/tcg/tcg-all.c         | 1 -
 accel/tcg/translate-all.c   | 6 +-----
 include/qemu-common.h       | 7 ++++++-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index e81da27..5b4ae54 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -23,6 +23,8 @@
 #include "exec/exec-all.h"
 #include "exec/memory-internal.h"
 
+bool tcg_allowed;
+
 /* exit the current TB, but without causing any exception to be raised */
 void cpu_loop_exit_noexc(CPUState *cpu)
 {
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c1ccad3..56dbb56 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -33,7 +33,6 @@
 #include "qemu/main-loop.h"
 
 unsigned long tcg_tb_size;
-static bool tcg_allowed = true;
 
 #ifndef CONFIG_USER_ONLY
 /* mask must never be zero, except for A20 change call */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8428fce..4c1d8c9 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -784,6 +784,7 @@ static void tb_htable_init(void)
    size. */
 void tcg_exec_init(unsigned long tb_size)
 {
+    tcg_allowed = true;
     cpu_gen_init();
     page_init();
     tb_htable_init();
@@ -795,11 +796,6 @@ void tcg_exec_init(unsigned long tb_size)
 #endif
 }
 
-bool tcg_enabled(void)
-{
-    return tcg_ctx.code_gen_buffer != NULL;
-}
-
 /*
  * Allocate a new translation block. Flush the translation buffer if
  * too many translation blocks or too much generated code.
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 387ef52..b5adbfa 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -76,8 +76,13 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
     sendto(sockfd, buf, len, flags, destaddr, addrlen)
 #endif
 
+extern bool tcg_allowed;
 void tcg_exec_init(unsigned long tb_size);
-bool tcg_enabled(void);
+#ifdef CONFIG_TCG
+#define tcg_enabled() (tcg_allowed)
+#else
+#define tcg_enabled() 0
+#endif
 
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
-- 
1.8.3.1
