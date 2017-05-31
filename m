Received: from eggs.gnu.org ([2001:4830:134:3::10]:36752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mg-0007WO-MM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mf-0003dx-Ig
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:42 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mf-0003da-AO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:41 -0400
Received: by mail-lf0-x22d.google.com with SMTP id m18so8645280lfj.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:41 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:18 +0300
Message-Id: <58de8b9684cc7b4b1fb3cd47678a04d6924b28de.1496234766.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 06/15] linux-user: remove all traces of qemu
 from /proc/self/cmdline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, Andreas Schwab <schwab@suse.de>

From: Andreas Schwab <schwab@suse.de>

Instead of post-processing the real contents use the remembered target
argv.  That removes all traces of qemu, including command line options,
and handles QEMU_ARGV0.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 47 +++++++----------------------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c8f6efc89c..909dde6de6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7358,52 +7358,19 @@ int host_to_target_waitstatus(int status)
 
 static int open_self_cmdline(void *cpu_env, int fd)
 {
-    int fd_orig = -1;
-    bool word_skipped = false;
-
-    fd_orig = open("/proc/self/cmdline", O_RDONLY);
-    if (fd_orig < 0) {
-        return fd_orig;
-    }
+    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    struct linux_binprm *bprm = ((TaskState *)cpu->opaque)->bprm;
+    int i;
 
-    while (true) {
-        ssize_t nb_read;
-        char buf[128];
-        char *cp_buf = buf;
+    for (i = 0; i < bprm->argc; i++) {
+        size_t len = strlen(bprm->argv[i]) + 1;
 
-        nb_read = read(fd_orig, buf, sizeof(buf));
-        if (nb_read < 0) {
-            int e = errno;
-            fd_orig = close(fd_orig);
-            errno = e;
+        if (write(fd, bprm->argv[i], len) != len) {
             return -1;
-        } else if (nb_read == 0) {
-            break;
-        }
-
-        if (!word_skipped) {
-            /* Skip the first string, which is the path to qemu-*-static
-               instead of the actual command. */
-            cp_buf = memchr(buf, 0, nb_read);
-            if (cp_buf) {
-                /* Null byte found, skip one string */
-                cp_buf++;
-                nb_read -= cp_buf - buf;
-                word_skipped = true;
-            }
-        }
-
-        if (word_skipped) {
-            if (write(fd, cp_buf, nb_read) != nb_read) {
-                int e = errno;
-                close(fd_orig);
-                errno = e;
-                return -1;
-            }
         }
     }
 
-    return close(fd_orig);
+    return 0;
 }
 
 static int open_self_maps(void *cpu_env, int fd)
-- 
2.11.0
