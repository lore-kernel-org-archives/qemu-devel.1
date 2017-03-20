Received: from eggs.gnu.org ([2001:4830:134:3::10]:49527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1cpvXf-0003VV-97
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1cpvXb-0004yD-Au
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:32:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:60097)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1cpvXa-0004xo-Np
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:31:59 -0400
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 20 Mar 2017 12:31:55 +0100
Message-ID: <mvmh92ouqtw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: remove all traces of qemu from
 /proc/self/cmdline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Instead of post-processing the real contents use the remembered target
argv.  That removes all traces of qemu, including command line options,
and handles QEMU_ARGV0.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 47 +++++++----------------------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cec8428589..ec1fd20386 100644
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
2.12.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
