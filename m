Received: from eggs.gnu.org ([2001:4830:134:3::10]:41266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpfGt-0002DJ-J7
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpfGe-0007eb-9e
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:46:27 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fpfGd-0007db-Qf
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:46:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 14 Aug 2018 21:45:20 +0200
Message-Id: <20180814194520.22458-2-laurent@vivier.eu>
In-Reply-To: <20180814194520.22458-1-laurent@vivier.eu>
References: <20180814194520.22458-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: add pseudo /proc/hardware for
 m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Debian console-setup uses /proc/hardware to guess the keyboard layout.
If the file /proc/hardware cannot be opened, the installation fails.

This patch adds a pseudo /proc/hardware file to report the model of
the machine. Instead of reporting a known and fake model, it
reports "qemu-m68k", which is true, and avoids to set the configuration
for an Amiga/Apple/Atari and let the user to chose the good one.

Bug: https://github.com/vivier/qemu-m68k/issues/34
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5850aba5be..f9a6ada611 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7746,7 +7746,7 @@ static int is_proc_myself(const char *filename, const char *entry)
 }
 
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
-    defined(TARGET_SPARC)
+    defined(TARGET_SPARC) || defined(TARGET_M68K)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) == 0;
@@ -7800,6 +7800,14 @@ static int open_cpuinfo(void *cpu_env, int fd)
 }
 #endif
 
+#if defined(TARGET_M68K)
+static int open_hardware(void *cpu_env, int fd)
+{
+    dprintf(fd, "Model:\t\tqemu-m68k\n");
+    return 0;
+}
+#endif
+
 static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags, mode_t mode)
 {
     struct fake_open {
@@ -7818,6 +7826,9 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
 #endif
 #if defined(TARGET_SPARC)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
+#endif
+#if defined(TARGET_M68K)
+        { "/proc/hardware", open_hardware, is_proc },
 #endif
         { NULL, NULL, NULL }
     };
-- 
2.17.1
